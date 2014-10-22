DROP TABLE if exists `facilitators`;
DROP TABLE if exists `sittings`;
DROP TABLE if exists `questions`;
DROP TABLE if exists `votes_audit`;
drop table if exists excluded_word;
drop table if exists word_group;
drop table if exists group_similarity;
drop table if exists word_suffix;
drop table if exists question_h;
drop table if exists question_d;

CREATE TABLE `facilitators` (
  `facilitator_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`facilitator_id`)
  )
  ;

-- A sitting is another word for a lecture/lab/tute 'session'. Didnt
-- want to use 'session' as it maybe confused with server session.
CREATE TABLE `sittings` (
  `sitting_id` INT NOT NULL AUTO_INCREMENT,
  `facilitator_id` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
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
  `session_id` varchar(100),
  PRIMARY KEY (`que_id`)
  )
  ;

create table  `votes_audit` (
	`sitting_id` INT NOT NULL,
	`session_id` VARCHAR(45) NOT NULL,
	`que_id` INT ,
	`vote_date` DATETIME,
	PRIMARY KEY (`que_id`,`session_id`,`sitting_id`)
);

-- Checking similarity 
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


  
  
  
  
  