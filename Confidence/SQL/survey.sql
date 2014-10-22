DROP TABLE `survey_questions`;
DROP TABLE `survey_responses`;
DROP TABLE `survey_results`;

CREATE TABLE `survey_questions` (
  `q_id` INT NOT NULL AUTO_INCREMENT,
  `question` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`)
  )
  ;

  
-- A sitting is another word for a lecture/lab/tute 'session'. Didnt
-- want to use 'session' as it maybe confused with server session.
CREATE TABLE `survey_responses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `question` INT NOT NULL,
  `response` INT NOT NULL,
  FOREIGN KEY (`question`)
  REFERENCES `survey_questions`(`q_id`),
  PRIMARY KEY (`id`)
  )
  ;
  
CREATE TABLE `survey_results` (
   `res_id` INT NOT NULL AUTO_INCREMENT,
   `q_id` INT NOT NULL,
   `lecturer_id` INT NOT NULL,
   `sitting_id` INT NOT NULL,
   `o_1` INT NOT NULL,
   `o_2` INT NOT NULL,
   `o_3` INT NOT NULL,
   `o_4` INT NOT NULL,
   `o_5` INT NOT NULL,
   FOREIGN KEY (`q_id`)
   REFERENCES `survey_questions`(`q_id`),
   FOREIGN KEY (`lecturer_id`)
   REFERENCES `facilitators`(`facilitator_id`),
   PRIMARY KEY (`res_id`)
   );



   )
  
insert into `survey_questions` (`id`, `question`) values(1, 'The lecture was interesting.');
insert into `survey_questions` (`id`, `question`) values(2, 'The lecturer explained things clearly.');
insert into `survey_questions` (`id`, `question`) values(3, 'The lecturer encouraged participation.');
