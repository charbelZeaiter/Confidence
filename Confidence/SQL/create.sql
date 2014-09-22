/*
 * Example of a difference 
 *  
 CREATE TABLE RoomType (
	room_type_id INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	name VARCHAR(30) NOT NULL,
	price INTEGER NOT NULL,
	num_beds INTEGER NOT NULL,
	total_available INTEGER NOT NULL,
	PRIMARY KEY (room_type_id)
	);
*/
	
CREATE TABLE students (
  stu_id VARCHAR(30) NOT NULL,
  stu_fname VARCHAR(45),
  stu_lname VARCHAR(45),
  stu_major VARCHAR(45),
  PRIMARY KEY (stu_id));

CREATE TABLE courses (
  course_id VARCHAR(15) NOT NULL,
  course_name VARCHAR(45) NULL,
  course_school VARCHAR(45) NULL,
  PRIMARY KEY (course_id));


CREATE TABLE enrolments (
  stu_id VARCHAR(30) NOT NULL,
  course_id VARCHAR(15) NOT NULL,
  semester VARCHAR(2) NULL,
  year INT NULL,
  PRIMARY KEY (stu_id, course_id),
  INDEX course_idx (course_id ASC),
  CONSTRAINT enrolment_student_fk
    FOREIGN KEY (stu_id)
    REFERENCES students (stu_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT enrolments_course_fk
    FOREIGN KEY (course_id)
    REFERENCES courses (course_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE forum (
  for_id VARCHAR(30) NOT NULL,
  for_course VARCHAR(45) NOT NULL,
  for_pass VARCHAR(45) NOT NULL,
  for_start_time DATETIME NULL,
  for_end_time DATETIME NULL,
    url VARCHAR(100),
  for_num_quest INT NULL DEFAULT 0,
  PRIMARY KEY (for_id),
  INDEX course_check_idx (for_course ASC),
  CONSTRAINT forum_course_fk
    FOREIGN KEY (for_course)
    REFERENCES courses (course_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE questions (
  que_id VARCHAR(30) NOT NULL,
  stu_id VARCHAR(30) NOT NULL,
  forum_id VARCHAR(30) NOT NULL,
  description VARCHAR(100) NOT NULL,
  status VARCHAR(1) NOT NULL,
  num_votes INT NULL DEFAULT 0,
  creation_time DATETIME NULL,
  post_time DATETIME NULL,
  PRIMARY KEY (que_id),
  INDEX student_fk_idx (stu_id ASC),
  INDEX forum_fk_idx (forum_id ASC),
  CONSTRAINT questions_forum_fk
    FOREIGN KEY (forum_id)
    REFERENCES forum (for_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT questions_student_fk
    FOREIGN KEY (stu_id)
    REFERENCES students (stu_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE lecturer (
  lec_id VARCHAR(30) NOT NULL,
  lec_fname VARCHAR(45) NULL,
  lec_lame VARCHAR(45) NULL,
  PRIMARY KEY (lec_id));


ALTER TABLE forum 
ADD COLUMN lec_id VARCHAR(30) NULL AFTER for_course,
ADD COLUMN fdate DATETIME NULL AFTER for_num_quest,
ADD INDEX lecturer_fk_idx (lec_id ASC);
ALTER TABLE forum 
ADD CONSTRAINT forum_lecturer_fk
  FOREIGN KEY (lec_id)
  REFERENCES lecturer (lec_id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE students_login (
  stu_id VARCHAR(30) NOT NULL,
  forum_id VARCHAR(30) NOT NULL,
  status VARCHAR(20) NOT NULL,
  login_date DATETIME NOT NULL,
  PRIMARY KEY (stu_id, forum_id, login_date),
  INDEX forum_id_idx (forum_id ASC),
  CONSTRAINT stulogin_fk
    FOREIGN KEY (stu_id)
    REFERENCES students (stu_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT slogin_forum_fk
    FOREIGN KEY (forum_id)
    REFERENCES forum (for_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



