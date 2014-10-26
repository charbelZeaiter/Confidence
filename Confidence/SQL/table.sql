DROP TABLE if exists `survey_results`;
DROP TABLE if exists `survey_responses`;
DROP TABLE if exists `survey_questions`;
DROP TABLE if exists `sittings`;
DROP TABLE if exists `questions`;
DROP TABLE if exists `facilitators`;
DROP TABLE if exists `votes_audit`;
drop table if exists excluded_word;
drop table if exists word_group;
drop table if exists group_similarity;
drop table if exists word_suffix;
drop table if exists question_h;
drop table if exists question_d;
drop table if exists punctuation;

CREATE TABLE `facilitators` (
  `facilitator_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(100) NOT NULL,
  `firstname` VARCHAR(100) NOT NULL,
  `lastname` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`facilitator_id`)
);

-- A sitting is another word for a lecture/lab/tute 'session'. Didn't
-- want to use 'session' as it maybe confused with server session.
CREATE TABLE `sittings` (
  `sitting_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `facilitator_id` INT NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `post_allowance` VARCHAR(1) NOT NULL DEFAULT 'T',
  `status` VARCHAR(1) NOT NULL DEFAULT 'O',
  PRIMARY KEY (`sitting_id`),
  FOREIGN KEY (`facilitator_id`) REFERENCES `facilitators`(`facilitator_id`)
);
  
CREATE TABLE `questions` (
  `que_id` INT NOT NULL AUTO_INCREMENT,
  `sitting_id` VARCHAR(45) NOT NULL,
  `session_id` VARCHAR(100) NOT NULL,
  `hidden` VARCHAR(1) NOT NULL DEFAULT 'F',
  `description` VARCHAR(100) NOT NULL,
  `num_votes` INT NULL DEFAULT 0,
  `creation_time` DATETIME NULL,
  `post_time` DATETIME NULL,
  `post_date` DATETIME NULL,
  PRIMARY KEY (`que_id`)
);

CREATE TABLE `votes_audit` (
  `sitting_id` INT NOT NULL,
  `session_id` VARCHAR(45) NOT NULL,
  `que_id` INT,
  `vote_date` DATETIME,
  PRIMARY KEY (`que_id`,`session_id`,`sitting_id`)
);


CREATE TABLE `survey_questions` (
  `q_id` INT NOT NULL AUTO_INCREMENT,
  `question` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`q_id`)
);

CREATE TABLE `survey_responses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `question` INT NOT NULL,
  `response` INT NOT NULL,
  FOREIGN KEY (`question`)
  REFERENCES `survey_questions`(`q_id`),
  PRIMARY KEY (`id`)
);
  
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


create table word_group ( 
  category integer , 
  word varchar(50)
);

create table group_similarity ( 
  category integer , 
  similarity integer
);

create table word_suffix ( 
  id integer , 
  suffix varchar(20)
);

create table question_h (
  id integer , 
  sentence varchar(100),
  nbword integer,
  sitting_id integer
);
  
create table question_d (
  id integer,
  word_id integer,
  word_position integer,
  word varchar(100),
  category integer
);

create table excluded_word (
  word varchar(100)
);

create table punctuation( 
symbol varchar(1)
);
