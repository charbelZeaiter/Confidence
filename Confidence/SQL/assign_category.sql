DELIMITER $$
DROP TRIGGER IF EXISTS chk_word_category $$
CREATE TRIGGER chk_word_category  
BEFORE INSERT ON question_d 
FOR EACH ROW  
BEGIN
	Declare cate integer default 0;
	select category into cate 
	from word_group 
	where word=new.word;

	SET new.category=cate;


END $$
DELIMITER ;

