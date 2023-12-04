CREATE SCHEMA corentin_lgp_dm;
CREATE TABLE phrase_originale(phrase_id INT NOT NULL AUTO_INCREMENT, phrase_texte TEXT NULL, trad_auto INT NULL, trad_hum INT NULL, PRIMARY KEY (phrase_id));
CREATE TABLE trad_auto(trad_auto_id INT NOT NULL AUTO_INCREMENT, texte_auto TEXT NULL, phrase_originale INT NULL, trad_hum INT NULL, PRIMARY KEY (trad_auto_id));
CREATE TABLE trad_hum(trad_hum_id INT NOT NULL AUTO_INCREMENT, texte_hum TEXT NULL, phrase_originale INT NULL, trad_auto INT NULL, PRIMARY KEY (trad_hum_id));
INSERT INTO phrase_originale (phrase_id, phrase_texte) 
VALUES 
(1, 'From this day natural philosophy, and particularly chemistry, in the most comprehensive sense of the term, became nearly my sole occupation.'),
(2, 'I read with ardour those works, so full of genius and discrimination, which modern inquirers have written on these subjects.'),
(3, 'As I applied so closely, it may be easily conceived that my progress was rapid.'),
(4, 'My ardour was indeed the astonishment of the students, and my proficiency that of the masters.');
INSERT INTO trad_auto (trad_auto_id, texte_auto) 
VALUES 
(1, 'À partir de ce jour, la philosophie naturelle, et en particulier la chimie, dans le sens le plus large du terme, est devenue presque ma seule occupation.'),
(2, "J'ai lu avec ardeur les ouvrages, si pleins de génie et de discernement, que les chercheurs modernes ont écrits sur ces sujets."),
(3, "Comme je m'appliquais de très près, on peut facilement imaginer que mes progrès ont été rapides."),
(4, "Mon ardeur faisait l'étonnement des étudiants et ma compétence celui des maîtres.");
INSERT INTO trad_hum (trad_hum_id, texte_hum) 
VALUES 
(1, "Depuis ce jour, je me livrai presqu'exclusivement à l'étude de la philosophie naturelle, et surtout de l'alchimie, dans le sens le plus étendu de ce mot."),
(2, "Je lus avec ardeur les ouvrages qui ont été composés sur cette science par les observateurs modernes, et où brillent à un haut degré leur génie et leur discernement."),
(3, "Avec une application aussi opiniâtre, il est facile de concevoir que je fis de rapides progrès."),
(4, "Mon ardeur faisait l'étonnement des étudiants, et mes succès celui des maîtres.");
ALTER TABLE `corentin_lgp_dm`.`phrase_originale` 
ADD INDEX `fk_trad_auto_idx` (`trad_auto` ASC) VISIBLE;
;
ALTER TABLE `corentin_lgp_dm`.`phrase_originale` 
ADD CONSTRAINT `fk_trad_auto`
  FOREIGN KEY (`trad_auto`)
  REFERENCES `corentin_lgp_dm`.`trad_auto` (`trad_auto_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `corentin_lgp_dm`.`phrase_originale` 
ADD INDEX `fk_trad_hum_idx` (`trad_hum` ASC) VISIBLE;
;
ALTER TABLE `corentin_lgp_dm`.`phrase_originale` 
ADD CONSTRAINT `fk_trad_hum`
  FOREIGN KEY (`trad_hum`)
  REFERENCES `corentin_lgp_dm`.`trad_hum` (`trad_hum_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `corentin_lgp_dm`.`trad_hum` 
ADD INDEX `fk_phrase_original_1_idx` (`phrase_originale` ASC) VISIBLE;
;
ALTER TABLE `corentin_lgp_dm`.`trad_hum` 
ADD CONSTRAINT `fk_phrase_original_1`
  FOREIGN KEY (`phrase_originale`)
  REFERENCES `corentin_lgp_dm`.`phrase_originale` (`phrase_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `corentin_lgp_dm`.`trad_hum` 
ADD INDEX `fk_trad_auto_1_idx` (`trad_auto` ASC) VISIBLE;
;
ALTER TABLE `corentin_lgp_dm`.`trad_hum` 
ADD CONSTRAINT `fk_trad_auto_1`
  FOREIGN KEY (`trad_auto`)
  REFERENCES `corentin_lgp_dm`.`trad_auto` (`trad_auto_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `corentin_lgp_dm`.`trad_auto` 
ADD INDEX `fk_originale_idx` (`phrase_originale` ASC) VISIBLE;
;
ALTER TABLE `corentin_lgp_dm`.`trad_auto` 
ADD CONSTRAINT `fk_originale`
  FOREIGN KEY (`phrase_originale`)
  REFERENCES `corentin_lgp_dm`.`phrase_originale` (`phrase_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `corentin_lgp_dm`.`trad_auto` 
ADD INDEX `fk_hum_idx` (`trad_hum` ASC) VISIBLE;
;
ALTER TABLE `corentin_lgp_dm`.`trad_auto` 
ADD CONSTRAINT `fk_hum`
  FOREIGN KEY (`trad_hum`)
  REFERENCES `corentin_lgp_dm`.`trad_hum` (`trad_hum_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
