DROP TABLE if exists `survey_comments`;

CREATE TABLE `survey_comments` (
   `com_id` INT NOT NULL AUTO_INCREMENT,
   `lecturer_id` INT NOT NULL,
   `sitting_id` INT NOT NULL,
   `description` VARCHAR(500) NOT NULL,
   FOREIGN KEY (`lecturer_id`)
   REFERENCES `facilitators`(`facilitator_id`),
   PRIMARY KEY (`com_id`)
);