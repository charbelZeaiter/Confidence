DELIMITER $$
DROP TRIGGER IF EXISTS question_autocorrect $$
CREATE TRIGGER question_autocorrect
before INSERT ON questions 
FOR EACH ROW  
BEGIN
	/* launch the autocorrect before storing the question */
	declare b varchar(100);
	set b = sentence_split_noinsert(new.description);

	set new.description=b;
END $$
DELIMITER ;