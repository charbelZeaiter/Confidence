DROP TABLE `facilitators`;
DROP TABLE `sittings`;
DROP TABLE `questions`;
DROP TABLE `votes_audit`;

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
  `stu_id` VARCHAR(45) NOT NULL,
  `forum_id` VARCHAR(45) NOT NULL,
  `sitting_id` VARCHAR(45) NOT NULL,
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
	`sitting_id` VARCHAR(45) NOT NULL,
	`session_id` VARCHAR(45) NOT NULL,
	`que_id` INT ,
	`vote_date` DATETIME,
	PRIMARY KEY (`que_id`,`session_id`,`sitting_id`)
)
	
	 
  
  
  
  
  
  
  
  