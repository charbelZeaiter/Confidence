DROP TABLE `questions`;
DROP TABLE `sitting`;

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

-- A sitting is another word for a lecture/lab/tute 'session'. Didnt
-- want to use 'session' as it maybe confused with server session.
CREATE TABLE `sitting` (
  `sitting_id` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`sitting_id`)
  )
  ;