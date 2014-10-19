DROP TABLE `survey_rs`;
DROP TABLE `survey_qs`;

CREATE TABLE `facilitators` (
  `facilitator_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
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

  
  
  
  
  
  
  
  
  