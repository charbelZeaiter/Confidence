
CREATE TABLE `survey_questions` (
  `id` INT NOT NULL AUTO_INCREMENT,
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
  REFERENCES `survey_questions`(`id`),
  PRIMARY KEY (`id`)
  )
  ;
  
insert into `survey_questions` (`id`, `question`) values(1, 'the lecture was interesting.');
insert into `survey_questions` (`id`, `question`) values(2, 'the lecturer explained things clearly.');
insert into `survey_questions` (`id`, `question`) values(3, 'the lecturer encouraged participation.');
insert into `survey_responses` (`id`, `question`,`response`) values(1, 1, 1);
insert into `survey_responses` (`id`, `question`,`response`) values(2, 1, 1);
insert into `survey_responses` (`id`, `question`,`response`) values(3, 1, 1);
insert into `survey_responses` (`id`, `question`,`response`) values(4, 1, 2);
insert into `survey_responses` (`id`, `question`,`response`) values(5, 1, 3);
insert into `survey_responses` (`id`, `question`,`response`) values(6, 2, 5);
insert into `survey_responses` (`id`, `question`,`response`) values(7, 2, 5);
insert into `survey_responses` (`id`, `question`,`response`) values(8, 2, 5);
