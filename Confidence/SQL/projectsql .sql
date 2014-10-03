DROP TABLE `Confidence`.`students_login`;
DROP TABLE `Confidence`.`enrolments`;
DROP TABLE `Confidence`.`questions`;
DROP TABLE `Confidence`.`forum`;
DROP TABLE `Confidence`.`lecturer`;
DROP TABLE `Confidence`.`students`;
DROP TABLE `Confidence`.`courses`;

CREATE TABLE `Confidence`.`students` (
  `stu_id` INT NOT NULL,
  `stu_fname` VARCHAR(45) NULL,
  `stu_lname` VARCHAR(45) NULL,
  `stu_major` VARCHAR(45) NULL,
  PRIMARY KEY (`stu_id`));

CREATE TABLE `Confidence`.`courses` (
  `course_id` VARCHAR(15) NOT NULL,
  `course_name` VARCHAR(45) NULL,
  `course_school` VARCHAR(45) NULL,
  PRIMARY KEY (`course_id`));


CREATE TABLE `Confidence`.`enrolments` (
  `stu_id` INT NOT NULL,
  `course_id` VARCHAR(15) NOT NULL,
  `semester` VARCHAR(2) NULL,
  `year` DATETIME NULL,
  PRIMARY KEY (`stu_id`, `course_id`),
  INDEX `course_idx` (`course_id` ASC),
  CONSTRAINT `students`
    FOREIGN KEY (stu_id)
    REFERENCES `Confidence`.`students` (`stu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `courses`
    FOREIGN KEY (course_id)
    REFERENCES `Confidence`.`courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `Confidence`.`forum` (
  `for_id` VARCHAR(10) NOT NULL,
  `for_course` VARCHAR(45) NOT NULL,
  `for_pass` VARCHAR(45) NOT NULL,
  `for_start_time` DATETIME NULL,
  `for_end_time` DATETIME NULL,
  `for_num_quest` INT NULL DEFAULT 0,
  PRIMARY KEY (`for_id`),
  INDEX `course_check_idx` (`for_course` ASC),
  CONSTRAINT `course_check`
    FOREIGN KEY (`for_course`)
    REFERENCES `Confidence`.`courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `Confidence`.`questions` (
  `que_id` VARCHAR(10) NOT NULL,
  `stu_id` INT NOT NULL,
  `forum_id` VARCHAR(45) NOT NULL,
  `desc` VARCHAR(100) NOT NULL,
  `num_votes` INT NULL DEFAULT 0,
  `creation_time` DATETIME NULL,
  `post_time` DATETIME NULL,
  `post_date` DATETIME NULL,
  PRIMARY KEY (`que_id`),
  INDEX `student_fk_idx` (`stu_id` ASC),
  INDEX `forum_fk_idx` (`forum_id` ASC),
  CONSTRAINT `forum_fk`
    FOREIGN KEY (`forum_id`)
    REFERENCES `Confidence`.`forum` (`for_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `student_fk`
    FOREIGN KEY (`stu_id`)
    REFERENCES `Confidence`.`students` (`stu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `Confidence`.`lecturer` (
  `lec_id` VARCHAR(20) NOT NULL,
  `lec_fname` VARCHAR(45) NULL,
  `lec_lame` VARCHAR(45) NULL,
  PRIMARY KEY (`lec_id`));


ALTER TABLE `Confidence`.`forum` 
ADD COLUMN `lec_id` VARCHAR(20) NULL AFTER `for_course`,
ADD COLUMN `fdate` DATETIME NULL AFTER `for_num_quest`,
ADD INDEX `lecturer_fk_idx` (`lec_id` ASC);
ALTER TABLE `Confidence`.`forum` 
ADD CONSTRAINT `lecturer_fk`
  FOREIGN KEY (`lec_id`)
  REFERENCES `Confidence`.`lecturer` (`lec_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `Confidence`.`students_login` (
  `stu_id` INT NOT NULL,
  `forum_id` VARCHAR(20) NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `login_date` DATETIME NOT NULL,
  PRIMARY KEY (`stu_id`, `forum_id`, `login_date`),
  INDEX `forum_id_idx` (`forum_id` ASC),
  CONSTRAINT `stulogin_fk`
    FOREIGN KEY (`stu_id`)
    REFERENCES `Confidence`.`students` (`stu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `forumlogin_fk`
    FOREIGN KEY (`forum_id`)
    REFERENCES `Confidence`.`forum` (`for_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

