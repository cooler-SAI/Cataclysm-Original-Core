DELETE from npc_vendor WHERE entry in (SELECT entry from creature_template WHERE npcflag & 128 = 0);