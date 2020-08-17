#include "CustomWaypointMovementGenerator.h"
#include "ObjectMgr.h"
#include "World.h"
#include "MapManager.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "CreatureGroups.h"
#include "Player.h"
#include "MoveSplineInit.h"
#include "MoveSpline.h"
#include "Transport.h"
#include "SmartAI.h"
#include "SmartScript.h"

void CustomWaypointMovementGenerator<Creature>::DoInitialize(Creature* creature)
{
    creature->LoadPath(m_pathId);
    creature->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
    if (auto smartAI = static_cast<SmartAI*>(creature->AI()))
    {
        smartAI->GetScript()->SetPathId(m_pathId);
    }
}

void CustomWaypointMovementGenerator<Creature>::DoFinalize(Creature* creature)
{
    creature->ClearUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
    creature->SetWalk(false);
}

void CustomWaypointMovementGenerator<Creature>::DoReset(Creature* creature)
{
    creature->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
    StartMove(creature);
}

void CustomWaypointMovementGenerator<Creature>::OnArrived(Creature* creature)
{
    if (!m_path || m_path->empty())
        return;

    if (m_isArrivalDone)
        return;

    creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
    m_isArrivalDone = true;

    // Inform script
    MovementInform(creature);
    creature->UpdateWaypointID(m_nodeId);
}

bool CustomWaypointMovementGenerator<Creature>::StartMove(Creature* creature)
{
    if (!m_path || m_path->empty())
        return false;

    // Dont allow dead creatures to move
    if (!creature->isAlive())
        return false;

    constexpr bool shouldUseInterpolation = true;
    doneMovement = false;

    if (shouldUseInterpolation)
    {
        if (m_isArrivalDone && doneMovement)
        {
            creature->GetMotionMaster()->Initialize();
            return false;
        }

        //stick every path generated by the pathfinder next to each other so catmullrom will find a smooth path.
        Movement::PointsArray pointPath;
        for (auto itr = m_path->begin(); itr != m_path->end(); ++itr)
        {
            auto srcPoint = *itr;
            pointPath.push_back(G3D::Vector3{ srcPoint.x, srcPoint.y, srcPoint.z });
        }

        creature->AddUnitState(UNIT_STATE_ROAMING_MOVE);

        Movement::MoveSplineInit init(creature);

        init.MovebyPath(pointPath);

        init.SetWalk(creature->IsWalking());

        if (m_isCyclic)
            init.SetCyclic();
        if (m_isCatmullRom)
            init.SetAnimation(Movement::ToFly);

        init.Launch();
        doneMovement = true;
        return true;
    }

    bool transportPath = creature->GetTransport() != nullptr;

    if (m_isArrivalDone)
    {
        if ((m_nodeId == m_path->size() - 1) && !m_repeating) // If that's our last waypoint
        {
            float x = m_path->at(m_nodeId).x;
            float y = m_path->at(m_nodeId).y;
            float z = m_path->at(m_nodeId).z;
            float o = creature->GetOrientation();

            if (!transportPath)
                creature->SetHomePosition(x, y, z, o);
            else
            {
                if (Transport* trans = creature->GetTransport())
                {
                    o -= trans->GetOrientation();
                    creature->SetTransportHomePosition(x, y, z, o);
                    trans->CalculatePassengerPosition(x, y, z, o);
                    creature->SetHomePosition(x, y, z, o);
                }
                else
                    transportPath = false;
                // else if (vehicle) - this should never happen, vehicle offsets are const
            }

            creature->GetMotionMaster()->Initialize();
            return false;
        }

        m_nodeId = (m_nodeId + 1) % m_path->size();
    }

    auto node = m_path->at(m_nodeId);


    m_isArrivalDone = false;

    creature->AddUnitState(UNIT_STATE_ROAMING_MOVE);

    Movement::Location formationDest(node.x, node.y, node.z, 0.0f);
    Movement::MoveSplineInit init(creature);

    //! If creature is on transport, we assume waypoints set in DB are already transport offsets
    if (transportPath)
    {
        init.DisableTransportPathTransformations();
        if (TransportBase* trans = creature->GetDirectTransport())
            trans->CalculatePassengerPosition(formationDest.x, formationDest.y, formationDest.z, formationDest.orientation);
    }

    //! Do not use formationDest here, MoveTo requires transport offsets due to DisableTransportPathTransformations() call
    //! but formationDest contains global coordinates
    init.MoveTo(node.x, node.y, node.z);


    init.SetWalk(creature->IsWalking());

    if (m_isCyclic)
        init.SetCyclic();
    if (m_isCatmullRom)
        init.SetSmooth();

    init.Launch();

    //Call for creature group update
    if (creature->GetFormation() && creature->GetFormation()->getLeader() == creature)
        creature->GetFormation()->LeaderMoveTo(node.x, node.y, node.z);

    return true;
}

bool CustomWaypointMovementGenerator<Creature>::DoUpdate(Creature* creature, uint32 diff)
{
    // Waypoint movement can be switched on/off
    // This is quite handy for escort quests and other stuff
    if (creature->HasUnitState(UNIT_STATE_NOT_MOVE))
    {
        creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        return true;
    }
    // prevent a crash at empty waypoint path.
    if (!m_path || m_path->empty())
        return false;

    if (!creature->GetTransGUID())
        creature->SetHomePosition(creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), creature->GetOrientation());
    if (creature->movespline->Finalized())
    {
        if(doneMovement)
        {
            OnArrived(creature);
        return false;
        }
        else
            return StartMove(creature);
    }
    return true;
}

void CustomWaypointMovementGenerator<Creature>::MovementInform(Creature* creature)
{
    if (creature->AI())
        creature->AI()->MovementInform(WAYPOINT_MOTION_TYPE, m_path->size());

    if (static_cast<SmartAI*>(creature->AI()))
    {
        auto* smartAI = static_cast<SmartAI*>(creature->AI());
        smartAI->GetScript()->ProcessEventsFor(SMART_EVENT_WAYPOINT_ENDED, NULL, m_path->size(), m_pathId);
    }
}

bool CustomWaypointMovementGenerator<Creature>::GetResetPos(Creature*, float& x, float& y, float& z)
{
    // prevent a crash at empty waypoint path.
    if (!m_path || m_path->empty())
        return false;

    return true;
}