DELETE FROM `playercreateinfo_spell` WHERE `spell` = 810;
INSERT INTO `playercreateinfo_spell`(`race`,`class`,`Spell`,`Note`) VALUES
(1,1,810,'Glyphs'),
(1,6,810,'Glyphs'),
(1,9,810,'Glyphs'),
(1,8,810,'Glyphs'),
(1,5,810,'Glyphs'),
(1,4,810,'Glyphs'),
(1,3,810,'Glyphs'),
(1,2,810,'Glyphs'),
(2,6,810,'Glyphs'),
(2,9,810,'Glyphs'),
(2,8,810,'Glyphs'),
(2,7,810,'Glyphs'),
(2,4,810,'Glyphs'),
(2,3,810,'Glyphs'),
(2,1,810,'Glyphs'),
(3,6,810,'Glyphs'),
(3,9,810,'Glyphs'),
(3,8,810,'Glyphs'),
(3,7,810,'Glyphs'),
(3,5,810,'Glyphs'),
(3,4,810,'Glyphs'),
(3,3,810,'Glyphs'),
(3,2,810,'Glyphs'),
(3,1,810,'Glyphs'),
(4,6,810,'Glyphs'),
(4,11,810,'Glyphs'),
(4,8,810,'Glyphs'),
(4,5,810,'Glyphs'),
(4,4,810,'Glyphs'),
(4,3,810,'Glyphs'),
(4,1,810,'Glyphs'),
(5,6,810,'Glyphs'),
(5,9,810,'Glyphs'),
(5,8,810,'Glyphs'),
(5,5,810,'Glyphs'),
(5,4,810,'Glyphs'),
(5,3,810,'Glyphs'),
(5,1,810,'Glyphs'),
(6,6,810,'Glyphs'),
(6,7,810,'Glyphs'),
(6,2,810,'Glyphs'),
(6,11,810,'Glyphs'),
(6,5,810,'Glyphs'),
(6,1,810,'Glyphs'),
(6,3,810,'Glyphs'),
(7,1,810,'Glyphs'),
(7,5,810,'Glyphs'),
(7,6,810,'Glyphs'),
(7,4,810,'Glyphs'),
(7,9,810,'Glyphs'),
(7,8,810,'Glyphs'),
(8,6,810,'Glyphs'),
(8,4,810,'Glyphs'),
(8,5,810,'Glyphs'),
(8,3,810,'Glyphs'),
(8,11,810,'Glyphs'),
(8,9,810,'Glyphs'),
(8,8,810,'Glyphs'),
(8,7,810,'Glyphs'),
(8,1,810,'Glyphs'),
(9,6,810,'Glyphs'),
(9,3,810,'Glyphs'),
(9,5,810,'Glyphs'),
(9,4,810,'Glyphs'),
(9,1,810,'Glyphs'),
(9,7,810,'Glyphs'),
(9,8,810,'Glyphs'),
(9,9,810,'Glyphs'),
(10,1,810,'Glyphs'),
(10,2,810,'Glyphs'),
(10,9,810,'Glyphs'),
(10,3,810,'Glyphs'),
(10,6,810,'Glyphs'),
(10,4,810,'Glyphs'),
(10,5,810,'Glyphs'),
(10,8,810,'Glyphs'),
(11,6,810,'Glyphs'),
(11,1,810,'Glyphs'),
(11,2,810,'Glyphs'),
(11,3,810,'Glyphs'),
(11,7,810,'Glyphs'),
(11,5,810,'Glyphs'),
(11,8,810,'Glyphs'),
(22,11,810,'Glyphs'),
(22,6,810,'Glyphs'),
(22,1,810,'Glyphs'),
(22,4,810,'Glyphs'),
(22,5,810,'Glyphs'),
(22,8,810,'Glyphs'),
(22,9,810,'Glyphs'),
(22,3,810,'Glyphs');

DELETE FROM `spell_ranks` WHERE `first_spell_id` = IN (89964) AND `rank` IN (1,2);
INSERT INTO `spell_ranks` (`first_spell_id`, `spell_id`, `rank`) VALUES 
(89964, 89964, 1),
(89964, 90647, 2);