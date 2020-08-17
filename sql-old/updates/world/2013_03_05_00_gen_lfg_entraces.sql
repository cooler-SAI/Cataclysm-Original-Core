
/*
Von    : Mediv
Beschr : lfg_entraces needed Item Level + List for all Dungeons;
Ticket : 
*/

DROP TABLE IF EXISTS `lfg_entrances`;
CREATE TABLE IF NOT EXISTS `lfg_entrances` (
  `dungeonId` int(11) NOT NULL DEFAULT '0',
  `name` text NOT NULL,
  `position_x` float NOT NULL,
  `position_y` float NOT NULL,
  `position_z` float NOT NULL,
  `orientation` float NOT NULL,
  `neededILevel` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dungeonId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `lfg_entrances` (`dungeonId`, `name`, `position_x`, `position_y`, `position_z`, `orientation`, `neededILevel`) VALUES
(1, 'H�hlen des Wehklagens', 0, 0, 0, 0, 0),
(2, 'Scholomance', 0, 0, 0, 0, 0),
(4, 'Der Flammenschlund', 0, 0, 0, 0, 0),
(6, 'Todesminen', 0, 0, 0, 0, 0),
(8, 'Burg Schattenfang', 0, 0, 0, 0, 0),
(10, 'Tiefschwarze Grotte', 0, 0, 0, 0, 0),
(12, 'Verlies von Sturmwind', 0, 0, 0, 0, 0),
(14, 'Gnomeregan', 0, 0, 0, 0, 0),
(16, 'Kral der Klingenhauer', 0, 0, 0, 0, 0),
(18, 'Scharlachrotes Kloster - Friedhof', 1688.99, 1053.48, 18.6775, 0.00117, 0),
(20, 'H�gel der Klingenhauer', 0, 0, 0, 0, 0),
(22, 'Uldaman', 0, 0, 0, 0, 0),
(24, 'Zul''Farrak', 0, 0, 0, 0, 0),
(26, 'Maraudon - Faulsporenh�hle', 1019.69, -458.31, -43.43, 0.31, 0),
(28, 'Versunkener Tempel', 0, 0, 0, 0, 0),
(30, 'Schwarzfelstiefen - Gef�ngnisblock', 0, 0, 0, 0, 0),
(32, 'Untere Schwarzfelsspitze', 0, 0, 0, 0, 0),
(34, 'D�sterbruch - Wucherborkenviertel', 44.4499, -154.822, -2.71201, 0, 0),
(36, 'D�sterbruch - Hauptstadtg�rten', -62.9658, 159.867, -3.46206, 3.14788, 0),
(38, 'D�sterbruch - Gordokhallen', 255.249, -16.0561, -2.58737, 4.7, 0),
(40, 'Stratholme - Haupttor', 3395.09, -3380.25, 142.702, 0.1, 0),
(136, 'H�llenfeuerbollwerk', 0, 0, 0, 0, 0),
(137, 'Blutkessel', 0, 0, 0, 0, 0),
(138, 'Die Zerschmetterten Hallen', 0, 0, 0, 0, 0),
(140, 'Sklavenunterk�nfte', 0, 0, 0, 0, 0),
(146, 'Tiefensumpf', 0, 0, 0, 0, 0),
(147, 'Dampfkammer', 0, 0, 0, 0, 0),
(148, 'Managruft', 0, 0, 0, 0, 0),
(149, 'Auchenaikrypta', 0, 0, 0, 0, 0),
(150, 'Sethekkhallen', 0, 0, 0, 0, 0),
(151, 'Schattenlabyrinth', 0, 0, 0, 0, 0),
(163, 'Scharlachrotes Kloster - Waffenkammer', 1610.83, -323.433, 18.6738, 6.28022, 0),
(164, 'Scharlachrotes Kloster - Kathedrale', 855.683, 1321.5, 18.6709, 0.001747, 0),
(165, 'Scharlachrotes Kloster - Bibliothek', 255.346, -209.09, 18.6773, 6.26656, 0),
(170, 'Die Flucht aus Durnholde', 0, 0, 0, 0, 0),
(171, 'Die �ffnung des Dunklen Portals', 0, 0, 0, 0, 0),
(172, 'Die Mechanar', 0, 0, 0, 0, 0),
(173, 'Die Botanika', 0, 0, 0, 0, 0),
(174, 'Die Arkatraz', 0, 0, 0, 0, 0),
(178, 'Auchenaikrypta', 0, 0, 0, 0, 0),
(179, 'Managruft', 0, 0, 0, 0, 0),
(180, 'Sethekkhallen', 0, 0, 0, 0, 0),
(181, 'Schattenlabyrinth', 0, 0, 0, 0, 0),
(182, 'Die �ffnung des Dunklen Portals', 0, 0, 0, 0, 0),
(183, 'Die Flucht aus Durnholde', 0, 0, 0, 0, 0),
(184, 'Sklavenunterk�nfte', 0, 0, 0, 0, 0),
(185, 'Dampfkammer', 0, 0, 0, 0, 0),
(186, 'Tiefensumpf', 0, 0, 0, 0, 0),
(187, 'Blutkessel', 0, 0, 0, 0, 0),
(188, 'H�llenfeuerbollwerk', 0, 0, 0, 0, 0),
(189, 'Die Zerschmetterten Hallen', 0, 0, 0, 0, 0),
(190, 'Die Arkatraz', 0, 0, 0, 0, 0),
(191, 'Die Botanika', 0, 0, 0, 0, 0),
(192, 'Die Mechanar', 0, 0, 0, 0, 0),
(198, 'Terrasse der Magister', 0, 0, 0, 0, 0),
(201, 'Terrasse der Magister', 0, 0, 0, 0, 0),
(202, 'Burg Utgarde', 0, 0, 0, 0, 0),
(203, 'Turm Utgarde', 0, 0, 0, 0, 0),
(204, 'Azjol-Nerub', 0, 0, 0, 0, 0),
(205, 'Turm Utgarde', 0, 0, 0, 0, 0),
(206, 'Das Oculus', 0, 0, 0, 0, 0),
(207, 'Hallen der Blitze', 0, 0, 0, 0, 0),
(208, 'Hallen des Steins', 0, 0, 0, 0, 0),
(209, 'Das Ausmerzen von Stratholme', 0, 0, 0, 0, 0),
(210, 'Das Ausmerzen von Stratholme', 0, 0, 0, 0, 0),
(211, 'Das Oculus', 0, 0, 0, 0, 0),
(212, 'Hallen der Blitze', 0, 0, 0, 0, 0),
(213, 'Hallen des Steins', 0, 0, 0, 0, 0),
(214, 'Feste Drak''Tharon', 0, 0, 0, 0, 0),
(215, 'Feste Drak''Tharon', 0, 0, 0, 0, 0),
(216, 'Gundrak', 0, 0, 0, 0, 0),
(217, 'Gundrak', 0, 0, 0, 0, 0),
(218, 'Ahn''kahet: Das Alte K�nigreich', 0, 0, 0, 0, 0),
(219, 'Ahn''kahet: Das Alte K�nigreich', 0, 0, 0, 0, 0),
(220, 'Die Violette Festung', 0, 0, 0, 0, 0),
(221, 'Die Violette Festung', 0, 0, 0, 0, 0),
(225, 'Der Nexus', 0, 0, 0, 0, 0),
(226, 'Der Nexus', 0, 0, 0, 0, 0),
(241, 'Azjol-Nerub', 0, 0, 0, 0, 0),
(242, 'Burg Utgarde', 0, 0, 0, 0, 0),
(245, 'Pr�fung des Champions', 0, 0, 0, 0, 0),
(249, 'Pr�fung des Champions', 0, 0, 0, 0, 0),
(251, 'Die Seelenschmiede', 0, 0, 0, 0, 0),
(252, 'Die Seelenschmiede', 0, 0, 0, 0, 0),
(253, 'Grube von Saron', 0, 0, 0, 0, 0),
(254, 'Grube von Saron', 0, 0, 0, 0, 0),
(255, 'Hallen der Reflexion', 0, 0, 0, 0, 0),
(256, 'Hallen der Reflexion', 0, 0, 0, 0, 0),
(272, 'Maraudon - Die T�ckische Grotte', 752.91, -616.53, -33.11, 1.37, 0),
(273, 'Maraudon - F�lle des Irdenen Gesangs', 495.702, 17.3372, -96.3128, 3.11854, 0),
(274, 'Stratholme - Dienstboteneingang', 3593.15, -3646.56, 138.5, 5.33, 0),
(276, 'Schwarzfelstiefen - Oberes Viertel', 0, 0, 0, 0, 0),
(285, 'Der Kopflose Reiter', 1797.52, 1347.38, 18.8876, 3.142, 0),
(286, 'Frostf�rst Ahune', -100.396, -95.9996, -4.28423, 4.71239, 0),
(287, 'Coren D�sterbr�u', 897.495, -141.976, -49.7563, 2.1255, 0),
(288, 'Chemiemanufaktur Krone', -238.075, 2166.43, 88.853, 1.13446, 0),
(296, 'H�chster Botschafter Flammenschlag', 0, 0, 0, 0, 0),
(297, 'Kronprinzessin Theradras', 0, 0, 0, 0, 0),
(298, 'Kai''ju Gahz''rilla', 0, 0, 0, 0, 0),
(299, 'Prinz Sarsarun', -9312.19, 1912.81, 86.3158, 3.37837, 0),
(302, 'Thron der Gezeiten', 0, 0, 0, 0, 0),
(303, 'Schwarzfelsh�hlen', 0, 0, 0, 0, 0),
(304, 'Grim Batol', 0, 0, 0, 0, 0),
(305, 'Hallen des Ursprungs', 0, 0, 0, 0, 0),
(306, 'Kai''ju Gahz''rilla', 0, 0, 0, 0, 0),
(307, 'Der Steinerne Kern', 0, 0, 0, 0, 0),
(308, 'H�chster Botschafter Flammenschlag', 0, 0, 0, 0, 0),
(309, 'Kronprinzessin Theradras', 0, 0, 0, 0, 0),
(310, 'Prinz Sarsarun', -9312.19, 1912.81, 86.3158, 3.37837, 0),
(311, 'Der Vortexgipfel', 0, 0, 0, 0, 0),
(312, 'Die Verlorene Stadt der Tol''vir', 0, 0, 0, 0, 0),
(319, 'Der Vortexgipfel', 0, 0, 0, 0, 0),
(320, 'Der Steinerne Kern', 0, 0, 0, 0, 0),
(321, 'Hallen des Ursprungs', 0, 0, 0, 0, 0),
(322, 'Grim Batol', 0, 0, 0, 0, 0),
(323, 'Schwarzfelsh�hlen', 0, 0, 0, 0, 0),
(324, 'Thron der Gezeiten', 0, 0, 0, 0, 0),
(325, 'Die Verlorene Stadt der Tol''vir', 0, 0, 0, 0, 0),
(326, 'Todesminen', 0, 0, 0, 0, 0),
(327, 'Burg Schattenfang', 0, 0, 0, 0, 0),
(330, 'Obere Schwarzfelsspitze', 0, 0, 0, 0, 0),
(334, 'Zul''Gurub', 0, 0, 0, 0, 0),
(340, 'Zul''Aman', 0, 0, 0, 0, 0),
(416, 'Belagerung des Wyrmruhtempels', 0, 0, 0, 0, 0),
(417, 'Todesschwinges Sturz', 0, 0, 0, 0, 0),
(435, 'Endzeit', 0, 0, 0, 0, 0),
(437, 'Brunnen der Ewigkeit', 0, 0, 0, 0, 0),
(439, 'Stunde des Zwielichts', 0, 0, 0, 0, 0),
(46, 'Onyxias Hort', 0, 0, 0, 0, 0),
(48, 'Geschmolzener Kern', 0, 0, 0, 0, 0),
(50, 'Pechschwingenhort', 0, 0, 0, 0, 0),
(159, 'Naxxramas', 0, 0, 0, 0, 0),
(160, 'Ruinen von Ahn''Qiraj', 0, 0, 0, 0, 0),
(161, 'Tempel von Ahn''Qiraj', 0, 0, 0, 0, 0),
(175, 'Karazhan', 0, 0, 0, 0, 0),
(176, 'Magtheridons Kammer', 0, 0, 0, 0, 0),
(177, 'Gruuls Unterschlupf', 0, 0, 0, 0, 0),
(193, 'Festung der St�rme', 0, 0, 0, 0, 0),
(194, 'H�hle des Schlangenschreins', 0, 0, 0, 0, 0),
(195, 'Hyjal der Vergangenheit', 0, 0, 0, 0, 0),
(196, 'Der Schwarze Tempel', 0, 0, 0, 0, 0),
(199, 'Der Sonnenbrunnen', 0, 0, 0, 0, 0),
(223, 'Das Auge der Ewigkeit', 0, 0, 0, 0, 0),
(224, 'Das Obsidiansanktum', 0, 0, 0, 0, 0),
(227, 'Naxxramas', 0, 0, 0, 0, 0),
(237, 'Das Auge der Ewigkeit', 0, 0, 0, 0, 0),
(238, 'Das Obsidiansanktum', 0, 0, 0, 0, 0),
(239, 'Archavons Kammer', 0, 0, 0, 0, 0),
(240, 'Archavons Kammer', 0, 0, 0, 0, 0),
(243, 'Ulduar', 0, 0, 0, 0, 0),
(244, 'Ulduar', 0, 0, 0, 0, 0),
(246, 'Pr�fung des Kreuzfahrers', 0, 0, 0, 0, 0),
(247, 'Pr�fung des Obersten Kreuzfahrers', 0, 0, 0, 0, 0),
(248, 'Pr�fung des Kreuzfahrers', 0, 0, 0, 0, 0),
(250, 'Pr�fung des Obersten Kreuzfahrers', 0, 0, 0, 0, 0),
(257, 'Onyxias Hort', 0, 0, 0, 0, 0),
(279, 'Eiskronenzitadelle', 0, 0, 0, 0, 0),
(280, 'Eiskronenzitadelle', 0, 0, 0, 0, 0),
(293, 'Rubinsanktum', 0, 0, 0, 0, 0),
(294, 'Rubinsanktum', 0, 0, 0, 0, 0),
(313, 'Pechschwingenabstieg', 0, 0, 0, 0, 0),
(314, 'Pechschwingenabstieg', 0, 0, 0, 0, 0),
(315, 'Die Bastion des Zwielichts', 0, 0, 0, 0, 0),
(316, 'Die Bastion des Zwielichts', 0, 0, 0, 0, 0),
(317, 'Thron der Vier Winde', 0, 0, 0, 0, 0),
(318, 'Thron der Vier Winde', 0, 0, 0, 0, 0),
(328, 'Baradinfestung', 0, 0, 0, 0, 0),
(329, 'Baradinfestung', 0, 0, 0, 0, 0),
(358, 'Gewertetes Schlachtfeld (10vs10)', 0, 0, 0, 0, 0),
(361, 'Feuerlande', 0, 0, 0, 0, 0),
(362, 'Feuerlande', 0, 0, 0, 0, 0),
(447, 'Drachenseele', 0, 0, 0, 0, 0),
(448, 'Drachenseele', 0, 0, 0, 0, 0),
(58, 'Wald von Elwynn', 0, 0, 0, 0, 0),
(60, 'Westfall', 0, 0, 0, 0, 0),
(62, 'D�mmerwald', 0, 0, 0, 0, 0),
(64, 'Dun Morogh', 0, 0, 0, 0, 0),
(66, 'Loch Modan', 0, 0, 0, 0, 0),
(68, 'Sumpfland', 0, 0, 0, 0, 0),
(70, 'Schlingendorntal', 0, 0, 0, 0, 0),
(72, 'Verw�stete Lande', 0, 0, 0, 0, 0),
(74, 'S�mpfe des Elends', 0, 0, 0, 0, 0),
(76, 'Rotkammgebirge', 0, 0, 0, 0, 0),
(78, 'Brennende Steppe', 0, 0, 0, 0, 0),
(80, 'Sengende Schlucht', 0, 0, 0, 0, 0),
(82, '�dland', 0, 0, 0, 0, 0),
(84, 'Arathihochland', 0, 0, 0, 0, 0),
(86, 'Vorgebirge des H�gellands', 0, 0, 0, 0, 0),
(88, 'Hinterland', 0, 0, 0, 0, 0),
(90, 'Westliche Pestl�nder', 0, 0, 0, 0, 0),
(92, '�stliche Pestl�nder', 0, 0, 0, 0, 0),
(94, 'Tirisfal', 0, 0, 0, 0, 0),
(96, 'Silberwald', 0, 0, 0, 0, 0),
(98, 'Alteracgebirge', 0, 0, 0, 0, 0),
(100, 'Durotar', 0, 0, 0, 0, 0),
(102, 'Mulgore', 0, 0, 0, 0, 0),
(104, 'Brachland', 0, 0, 0, 0, 0),
(106, 'Steinkrallengebirge', 0, 0, 0, 0, 0),
(108, 'Tausend Nadeln', 0, 0, 0, 0, 0),
(110, 'Desolace', 0, 0, 0, 0, 0),
(112, 'Feralas', 0, 0, 0, 0, 0),
(114, 'D�stermarschen', 0, 0, 0, 0, 0),
(116, 'Tanaris', 0, 0, 0, 0, 0),
(118, 'Krater von Un''Goro', 0, 0, 0, 0, 0),
(120, 'Silithus', 0, 0, 0, 0, 0),
(122, 'Teldrassil', 0, 0, 0, 0, 0),
(124, 'Dunkelk�ste', 0, 0, 0, 0, 0),
(126, 'Eschental', 0, 0, 0, 0, 0),
(128, 'Teufelswald', 0, 0, 0, 0, 0),
(130, 'Azshara', 0, 0, 0, 0, 0),
(132, 'Winterquell', 0, 0, 0, 0, 0),
(152, 'H�llenfeuerhalbinsel', 0, 0, 0, 0, 0),
(153, 'Zangarmarschen', 0, 0, 0, 0, 0),
(154, 'W�lder von Terokkar', 0, 0, 0, 0, 0),
(155, 'Nagrand', 0, 0, 0, 0, 0),
(156, 'Schattenmondtal', 0, 0, 0, 0, 0),
(157, 'Schergrat', 0, 0, 0, 0, 0),
(158, 'Nethersturm', 0, 0, 0, 0, 0),
(166, 'Immersangwald', 0, 0, 0, 0, 0),
(167, 'Azurmythosinsel', 0, 0, 0, 0, 0),
(168, 'Geisterlande', 0, 0, 0, 0, 0),
(169, 'Blutmythosinsel', 0, 0, 0, 0, 0),
(200, 'Insel von Quel''Danas', 0, 0, 0, 0, 0),
(228, 'Boreanische Tundra', 0, 0, 0, 0, 0),
(229, 'Heulender Fjord', 0, 0, 0, 0, 0),
(230, 'Grizzlyh�gel', 0, 0, 0, 0, 0),
(231, 'Drachen�de', 0, 0, 0, 0, 0),
(232, 'Tausendwinter', 0, 0, 0, 0, 0),
(233, 'Zul''Drak', 0, 0, 0, 0, 0),
(234, 'Sholazarbecken', 0, 0, 0, 0, 0),
(235, 'Die Sturmgipfel', 0, 0, 0, 0, 0),
(236, 'Eiskrone', 0, 0, 0, 0, 0),
(258, 'Zuf�lliger Dungeon (Classic)', 0, 0, 0, 0, 0),
(259, 'Zuf�lliger Dungeon (Burning Crusade)', 0, 0, 0, 0, 0),
(260, 'Zuf�lliger heroischer Dungeon (Burning Crusade)', 0, 0, 0, 0, 0),
(261, 'Zuf�lliger Dungeon (Wrath of the Lich King)', 0, 0, 0, 0, 0),
(262, 'Zuf�lliger heroischer Dungeon (Wrath of the Lich King)', 0, 0, 0, 0, 0),
(300, 'Zuf�lliger Dungeon (Cataclysm)', 0, 0, 0, 0, 0),
(301, 'Zuf�lliger heroischer Dungeon (Cataclysm)', 0, 0, 0, 0, 0),
(434, 'Zuf�lliger heroischer Dungeon (Stunde des Zwielichts)', 0, 0, 0, 0, 0);
