/*
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef TRINITY_INSTANCE_DATA_H
#define TRINITY_INSTANCE_DATA_H

#include "ZoneScript.h"
#include "World.h"
#include "ObjectMgr.h"

#define OUT_SAVE_INST_DATA             TC_LOG_DEBUG("scripts", "Saving Instance Data for Instance %s (Map %d, Instance Id %d)", instance->GetMapName(), instance->GetId(), instance->GetInstanceId())
#define OUT_SAVE_INST_DATA_COMPLETE    TC_LOG_DEBUG("scripts", "Saving Instance Data for Instance %s (Map %d, Instance Id %d) completed.", instance->GetMapName(), instance->GetId(), instance->GetInstanceId())
#define OUT_LOAD_INST_DATA(a)          TC_LOG_DEBUG("scripts", "Loading Instance Data for Instance %s (Map %d, Instance Id %d). Input is '%s'", instance->GetMapName(), instance->GetId(), instance->GetInstanceId(), a)
#define OUT_LOAD_INST_DATA_COMPLETE    TC_LOG_DEBUG("scripts", "Instance Data Load for Instance %s (Map %d, Instance Id: %d) is complete.", instance->GetMapName(), instance->GetId(), instance->GetInstanceId())
#define OUT_LOAD_INST_DATA_FAIL        TC_LOG_ERROR("scripts", "Unable to load Instance Data for Instance %s (Map %d, Instance Id: %d).", instance->GetMapName(), instance->GetId(), instance->GetInstanceId())

class Map;
class Unit;
class Player;
class GameObject;
class Creature;

typedef std::set<GameObject*> DoorSet;
typedef std::set<Creature*> MinionSet;

enum EncounterFrameType
{
    ENCOUNTER_FRAME_SET_COMBAT_RES_LIMIT    = 0,
    ENCOUNTER_FRAME_RESET_COMBAT_RES_LIMIT  = 1,
    ENCOUNTER_FRAME_ENGAGE                  = 2,
    ENCOUNTER_FRAME_DISENGAGE               = 3,
    ENCOUNTER_FRAME_UPDATE_PRIORITY         = 4,
    ENCOUNTER_FRAME_ADD_TIMER               = 5,
    ENCOUNTER_FRAME_ENABLE_OBJECTIVE        = 6,
    ENCOUNTER_FRAME_UPDATE_OBJECTIVE        = 7,
    ENCOUNTER_FRAME_DISABLE_OBJECTIVE       = 8,
    ENCOUNTER_FRAME_UNK7                    = 9,    // Seems to have something to do with sorting the encounter units
    ENCOUNTER_FRAME_ADD_COMBAT_RES_LIMIT    = 10
};

enum EncounterState
{
    NOT_STARTED   = 0,
    IN_PROGRESS   = 1,
    FAIL          = 2,
    DONE          = 3,
    DONE_HM       = 4,
    SPECIAL       = 5,
    TO_BE_DECIDED = 6
};

enum DoorType
{
    DOOR_TYPE_ROOM          = 0,    // Door can open if encounter is not in progress
    DOOR_TYPE_PASSAGE       = 1,    // Door can open if encounter is done
    DOOR_TYPE_SPAWN_HOLE    = 2,    // Door can open if encounter is in progress, typically used for spawning places
    MAX_DOOR_TYPES
};

enum BoundaryType
{
    BOUNDARY_NONE = 0,
    BOUNDARY_N,
    BOUNDARY_S,
    BOUNDARY_E,
    BOUNDARY_W,
    BOUNDARY_NE,
    BOUNDARY_NW,
    BOUNDARY_SE,
    BOUNDARY_SW,
    BOUNDARY_MAX_X = BOUNDARY_N,
    BOUNDARY_MIN_X = BOUNDARY_S,
    BOUNDARY_MAX_Y = BOUNDARY_W,
    BOUNDARY_MIN_Y = BOUNDARY_E
};

typedef std::map<BoundaryType, float> BossBoundaryMap;

struct DoorData
{
    uint32 entry, bossId;
    DoorType type;
    uint32 boundary;
};

struct MinionData
{
    uint32 entry, bossId;
};

struct ObjectData
{
    uint32 entry;
    uint32 type;
};

struct TeleportationData
{
    uint32 teleportationId;
    uint32 bossId;
};

struct BossInfo
{
    BossInfo() : state(TO_BE_DECIDED) {}
    EncounterState state;
    DoorSet door[MAX_DOOR_TYPES];
    MinionSet minion;
    BossBoundaryMap boundary;
};

struct DoorInfo
{
    explicit DoorInfo(BossInfo* _bossInfo, DoorType _type, BoundaryType _boundary)
        : bossInfo(_bossInfo), type(_type), boundary(_boundary) {}
    BossInfo* bossInfo;
    DoorType type;
    BoundaryType boundary;
};

struct MinionInfo
{
    explicit MinionInfo(BossInfo* _bossInfo) : bossInfo(_bossInfo) {}
    BossInfo* bossInfo;
};

typedef std::multimap<uint32 /*entry*/, DoorInfo> DoorInfoMap;
typedef std::pair<DoorInfoMap::const_iterator, DoorInfoMap::const_iterator> DoorInfoMapBounds;

typedef std::map<uint32 /*entry*/, MinionInfo> MinionInfoMap;
typedef std::map<uint32 /*type*/, uint64 /*guid*/> ObjectGuidMap;
typedef std::map<uint32 /*entry*/, uint32 /*type*/> ObjectInfoMap;


class InstanceScript : public ZoneScript
{
    public:
        explicit InstanceScript(Map* map) : instance(map), completedEncounters(0), _battleResurrectionsCounter(0), hardModeDifficulty(0), _disableFallDamage(false) { }

        virtual ~InstanceScript() {}

        Map* instance;

        // On creation, NOT load.
        virtual void Initialize() { }

        // On load
        virtual void Load(char const* data);

        // When save is needed, this function generates the data
        virtual std::string GetSaveData();

        void SaveToDB();

        virtual void Update(uint32 /*diff*/) {}

        // Used by the map's CanEnter function.
        // This is to prevent players from entering during boss encounters.
        virtual bool IsEncounterInProgress() const;

        // Called when a creature/gameobject is added to map or removed from map.
        // Insert/Remove objectguid to dynamic guid store
        virtual void OnCreatureCreate(Creature* creature) override;
        virtual void OnCreatureRemove(Creature* creature) override;

        virtual void OnGameObjectCreate(GameObject* go) override;
        virtual void OnGameObjectRemove(GameObject* go) override;

        uint64 GetObjectGuid(uint32 type) const;
        virtual uint64 GetData64(uint32 type) const override;

        virtual bool GetBool(uint32 p_Type) const override;

        inline Creature* GetCreature(uint32 type)
        {
            return ObjectAccessor::GetObjectInMap<Creature>(GetObjectGuid(type), instance, nullptr);
        }
        inline GameObject* GetGameObject(uint32 type)
        {
            return ObjectAccessor::GetObjectInMap<GameObject>(GetObjectGuid(type), instance, nullptr);
        }

        // Called when a player successfully enters the instance.
        virtual void OnPlayerEnter(Player* /*player*/) { }

        // Called when a player leaves the instance.
        virtual void OnPlayerLeave(Player* /*player*/) { }

        // Handle open / close objects
        // * use HandleGameObject(0, boolen, GO); in OnObjectCreate in instance scripts
        // * use HandleGameObject(GUID, boolen, NULL); in any other script
        void HandleGameObject(uint64 guid, bool open, GameObject* go = nullptr);

        // Change active state of doors or buttons
        void DoUseDoorOrButton(uint64 guid, uint32 withRestoreTime = 0, bool useAlternativeState = false);

        // Respawns a GO having negative spawntimesecs in gameobject-table
        void DoRespawnGameObject(uint64 guid, uint32 timeToDespawn = MINUTE);

        // Sends world state update to all players in instance
        void DoUpdateWorldState(uint32 worldstateId, uint32 worldstateValue);

        // Send Notify to all players in instance
        void DoSendNotifyToInstance(char const* format, ...);

        // Reset Achievement Criteria
        void DoResetAchievementCriteria(AchievementCriteriaTypes type, uint64 miscValue1 = 0, uint64 miscValue2 = 0, bool evenIfCriteriaComplete = false);

        // Complete Achievement for all players in instance
        void DoCompleteAchievement(uint32 achievement);

        // Complete Achievement Criteria for all players in instance
        void DoCompleteCriteria(uint32 criteria);

        // Update Achievement Criteria for all players in instance
        void DoUpdateAchievementCriteria(AchievementCriteriaTypes type, uint32 miscValue1 = 0, uint32 miscValue2 = 0, Unit* unit = NULL);

        // Start/Stop Timed Achievement Criteria for all players in instance
        void DoStartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry);
        void DoStopTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry);

        // Remove Auras due to Spell on all players in instance
        void DoRemoveAurasDueToSpellOnPlayers(uint32 spell, uint64 casterGUID = 0, AuraRemoveMode removeMode = AURA_REMOVE_BY_DEFAULT);

        // Set power to players in instance (newmax is used only for ALT_POWER)
        void DoSetPowerOnPlayers(Powers power, int32 val, int32 newmax = 100);

        // Remove Aura stack on all players in instance
        void DoRemoveAuraStackOnPlayers(uint32 spell, uint64 casterGUID = 0, AuraRemoveMode removeMode = AURA_REMOVE_BY_DEFAULT);

        // Cast spell on all players in instance
        void DoCastSpellOnPlayers(uint32 spell);

        // Add aura on all players in instance
        void DoAddAuraOnPlayers(uint32 spell);

        void DoSetAlternatePowerOnPlayers(int32 value);

        void DoModifyPlayerCurrencies(uint32 id, int32 value);

        void DoModifyPlayerCurrenciesIfLevel(uint32 id, int32 value, int8 level);

        void DoAddTitleIfLevel(uint32 title, int8 level);

        void DoNearTeleportPlayers(const Position pos, bool casting = false);

        void DoStartMovie(uint32 movieId);

        void DoKilledMonsterKredit(uint32 questId, uint32 entry, uint64 guid = 0);

        // Return wether server allow two side groups or not
        bool ServerAllowsTwoSideGroups() { return sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GROUP) || sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_LFG); }

        virtual bool SetBossState(uint32 id, EncounterState state);
        EncounterState GetBossState(uint32 id) const { return id < bosses.size() ? (bosses[id].state == DONE_HM ? DONE : bosses[id].state) : TO_BE_DECIDED; }
        bool IsDone(uint32 id) const  { return id < bosses.size() ? ((bosses[id].state == DONE_HM || bosses[id].state == DONE) ? true : false) : false; }
        bool IsDoneInHeroic(uint32 id) const  { return id < bosses.size() ? (bosses[id].state == DONE_HM ? true : false) : false; }
        BossBoundaryMap const* GetBossBoundary(uint32 id) const { return id < bosses.size() ? &bosses[id].boundary : NULL; }
        void SetBindToHardModeDifficulty(uint8 difficulty) { hardModeDifficulty = difficulty; }
        uint8 GetHardModeDifficulty() const { return hardModeDifficulty > 0 ? hardModeDifficulty : 0; }

        // Achievement criteria additional requirements check
        // NOTE: not use this if same can be checked existed requirement types from AchievementCriteriaRequirementType
        virtual bool CheckAchievementCriteriaMeet(uint32 /*criteria_id*/, Player const* /*source*/, Unit const* /*target*/ = NULL, uint32 /*miscvalue1*/ = 0);

        // Checks boss requirements (one boss required to kill other)
        virtual bool CheckRequiredBosses(uint32 /*bossId*/, Player const* /*player*/ = nullptr) const { return true; }

        // Checks encounter state at kill/spellcast
        void UpdateEncounterState(EncounterCreditType type, uint32 creditEntry, Unit* source);

        // Used only during loading
        void SetCompletedEncountersMask(uint32 newMask) { completedEncounters = newMask; }

        // Returns completed encounters mask for packets
        uint32 GetCompletedEncounterMask() const { return completedEncounters; }

        void SendEncounterUnit(uint32 type, Unit* unit = NULL, uint8 param1 = 0, uint8 param2 = 0);

        virtual void FillInitialWorldStates(WorldPacket& /*data*/) {}

        // ReCheck PhaseTemplate related conditions
        void UpdatePhasing();

        void SendCinematicStartToPlayers(uint32 cinematicId);

        void CompleteGuildCriteriaForGuildGroup(uint32 criteriaId);

        void ResetBattleResurrections();
        bool IsBattleResurrectionAvailable() const;
        void UseBattleResurrection();

        bool IsFallDamageDisable() { return _disableFallDamage; }

        void DisableFallDamage(bool state) { _disableFallDamage = state; }

        void FinishLfgDungeon(Creature* boss);

        void UpdateTeleportations();

    protected:
        void SetHeaders(std::string const& dataHeaders);
        void SetBossNumber(uint32 number) { bosses.resize(number); }
        void LoadDoorData(DoorData const* data);
        void LoadMinionData(MinionData const* data);
        void LoadObjectData(ObjectData const* creatureData, ObjectData const* gameObjectData);
        void LoadTeleportationData(TeleportationData const* data);

        void AddObject(Creature* obj, bool add);
        void AddObject(GameObject* obj, bool add);
        void AddObject(WorldObject* obj, uint32 type, bool add);

        void AddDoor(GameObject* door, bool add);
        void AddMinion(Creature* minion, bool add);

        void UpdateDoorState(GameObject* door);
        void UpdateMinionState(Creature* minion, EncounterState state);

        std::string GetBossSaveData();

        void AddTeleporter(uint64 guid);

        // Instance Load and Save
        bool ReadSaveDataHeaders(std::istringstream& data);
        void ReadSaveDataBossStates(std::istringstream& data);
        virtual void ReadSaveDataMore(std::istringstream& /*data*/) { }
        void WriteSaveDataHeaders(std::ostringstream& data);
        void WriteSaveDataBossStates(std::ostringstream& data);
        virtual void WriteSaveDataMore(std::ostringstream& /*data*/) { }

    private:
        static void LoadObjectData(ObjectData const* creatureData, ObjectInfoMap& objectInfo);

        std::vector<char> headers;
        std::vector<BossInfo> bosses;
        DoorInfoMap doors;
        MinionInfoMap minions;
        ObjectInfoMap _creatureInfo;
        ObjectInfoMap _gameObjectInfo;
        ObjectGuidMap _objectGuids;
        uint32 completedEncounters; // completed encounter mask, bit indexes are DungeonEncounter.dbc boss numbers, used for packets
        uint8 _battleResurrectionsCounter;
        uint8 hardModeDifficulty;
        bool _disableFallDamage;

        std::vector<uint64 /*guids*/ > _teleporters;
        std::map<uint32 /*teleportationId*/, std::list<uint32 > /*BossIds*/ > _teleportationReq;
};

template<class AI, class T>
    AI* GetInstanceAI(T* obj, char const* scriptName)
{
    if (InstanceMap* instance = obj->GetMap()->ToInstanceMap())
        if (instance->GetInstanceScript())
            if (instance->GetScriptId() == sObjectMgr->GetScriptId(scriptName))
                return new AI(obj);

    return NULL;
}

template<class AI, class T>
    AI* GetInstanceAI(T* obj)
{
    if (InstanceMap* instance = obj->GetMap()->ToInstanceMap())
        if (instance->GetInstanceScript())
            return new AI(obj);

    return NULL;
}

#endif
