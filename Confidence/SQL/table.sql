CREATE TABLE `questions` (
  `que_id` INT NOT NULL AUTO_INCREMENT,
  `stu_id` VARCHAR(45) NOT NULL,
  `forum_id` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `num_votes` INT NULL DEFAULT 0,
  `creation_time` DATETIME NULL,
  `post_time` DATETIME NULL,
  `post_date` DATETIME NULL,
  PRIMARY KEY (`que_id`)
  )
  ;