DROP TABLE `survey_results`;
DROP TABLE `survey_responses`;
DROP TABLE `survey_questions`;
DROP TABLE `facilitators`;
DROP TABLE `sittings`;
DROP TABLE `questions`;
DROP TABLE `votes_audit`;

CREATE TABLE `facilitators` (
  `facilitator_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(100) NOT NULL,
  `firstname` VARCHAR(100) NOT NULL,
  `lastname` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`facilitator_id`)
  )
  ;

-- A sitting is another word for a lecture/lab/tute 'session'. Didnt
-- want to use 'session' as it maybe confused with server session.
CREATE TABLE `sittings` (
  `sitting_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `facilitator_id` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `post_allowance` VARCHAR(1) NOT NULL DEFAULT 'T',
  `status` VARCHAR(1) NOT NULL DEFAULT 'O',
  PRIMARY KEY (`sitting_id`)
  )
  ;
  
CREATE TABLE `questions` (
  `que_id` INT NOT NULL AUTO_INCREMENT,
  `stu_id` INT NOT NULL,
  `forum_id` VARCHAR(45) NOT NULL,
  `sitting_id` VARCHAR(45) NOT NULL,
  `hidden` VARCHAR(1) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `num_votes` INT NULL DEFAULT 0,
  `creation_time` DATETIME NULL,
  `post_time` DATETIME NULL,
  `post_date` DATETIME NULL,
  PRIMARY KEY (`que_id`)
  )
  ;
alter table questions add session_id varchar(100);
create table  `votes_audit` (
	`sitting_id` INT NOT NULL,
	`session_id` VARCHAR(45) NOT NULL,
	`que_id` INT ,
	`vote_date` DATETIME,
	PRIMARY KEY (`que_id`,`session_id`,`sitting_id`)
);

CREATE TABLE `survey_questions` (
  `q_id` INT NOT NULL AUTO_INCREMENT,
  `question` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`q_id`)
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



   
  
insert into `survey_questions` (`q_id`, `question`) values(1, 'The lecture was interesting.');
insert into `survey_questions` (`q_id`, `question`) values(2, 'The lecturer explained things clearly.');
insert into `survey_questions` (`q_id`, `question`) values(3, 'The lecturer encouraged participation.');

  
  
  
  
  
  
  
  