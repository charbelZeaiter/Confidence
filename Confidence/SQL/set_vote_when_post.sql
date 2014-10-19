DELIMITER $$
DROP TRIGGER IF EXISTS set_vote_when_post $$
CREATE TRIGGER set_vote_when_post 
AFTER INSERT ON questions 
FOR EACH ROW  
BEGIN
	
		insert into votes_audit (session_id,que_id,sitting_id) 
			values (new.session_id,new.que_id,new.sitting_id);
END $$
DELIMITER ;
