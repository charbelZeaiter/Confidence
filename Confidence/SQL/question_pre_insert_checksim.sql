DELIMITER $$
DROP TRIGGER IF EXISTS check_question_similarity $$
CREATE TRIGGER check_question_similarity
BEFORE INSERT ON questions 
FOR EACH ROW  
BEGIN
	
	DECLARE done integer default 0;
	DECLARE cur_seq integer;	
	DECLARE max_similarity integer default 0;
	DECLARE similarity float default 0;
	DECLARE new_id integer;
	Declare msg varchar(100);
	declare sim_id integer default 0;
	DECLARE c1 CURSOR FOR select distinct id from question_h where id <> new.que_id;
	DECLARE CONTINUE handler FOR NOT FOUND SET done =1;
	select ifnull(max(que_id),0)+1 into new_id from questions;
	call sentence_split(new.description,new.que_id);
	-- 


		-- need to link it to sitting id as well
		open c1;
		get_questions : loop
		fetch c1 into cur_seq;
		IF done = 1 then 
		LEAVE get_questions;
		END IF;
		
		
		select similarity_check(new.que_id,cur_seq) 
		into similarity;
		if similarity>max_similarity then 
		set max_similarity = similarity;
		set sim_id =cur_seq;
		end if;
			
		END LOOP get_questions;
		CLOSE c1;

		if max_similarity >0.65 then 
		select concat('similar question already asked: ',sentence)  into msg from question_h where id = sim_id;
		-- insert into answer (b,a)values ( 1 , msg);
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		end if;
END $$
DELIMITER ;