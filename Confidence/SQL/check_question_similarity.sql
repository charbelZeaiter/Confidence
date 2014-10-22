DELIMITER $$
DROP TRIGGER IF EXISTS check_question_similarity $$
CREATE TRIGGER check_question_similarity
after INSERT ON questions 
FOR EACH ROW  
BEGIN
	
	DECLARE done integer default 0;
	DECLARE cur_seq integer;	
	DECLARE max_similarity integer default 0;
	DECLARE similarity float default 0;
	DECLARE new_id integer;
	Declare msg varchar(100);
	Declare m_id integer default 0;
	Declare m_val integer default 0;
	DECLARE c1 CURSOR FOR select distinct id from question_h where id <> new.que_id and sitting_id =new.sitting_id;
	DECLARE CONTINUE handler FOR NOT FOUND SET done =1;

	call sentence_split(new.description,new.que_id,new.sitting_id);
	-- 
	
		open c1;
		get_questions : loop
		fetch c1 into cur_seq;
		IF done = 1 then 
		LEAVE get_questions;
		END IF;
		
		
		select similarity_check(new.que_id,cur_seq) 
		into similarity;
		if similarity >= m_val then 
			set m_val =similarity ; 
			set m_id = cur_seq;

		-- leave get_questions; 
		end if;
		-- if similarity = -2 then SET max_similarity =1; leave get_questions; end if;

		if similarity>max_similarity then 
		set max_similarity = similarity;

		end if;
			
		END LOOP get_questions;
		CLOSE c1;

		if m_id >=1 then
		select concat('similar question already asked: ',sentence)  into msg from question_h where id = m_id;
		-- delete from questions where que_id=new.id;
		 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		end if;
		insert into votes_audit (session_id,que_id,sitting_id) values (new.session_id,new.que_id,new.sitting_id);


END $$
DELIMITER ;