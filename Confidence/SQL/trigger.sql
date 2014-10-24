DELIMITER $$
DROP TRIGGER IF EXISTS chk_votes $$
CREATE TRIGGER chk_votes  
BEFORE UPDATE ON questions 
FOR EACH ROW  
BEGIN
	DECLARE firstVote integer ;
	set firstVote=0;
	BEGIN  
	select 1 
	into firstvote 
	from votes_audit 
	where que_id=old.que_id 
	and sitting_id =old.sitting_id
	and session_id=new.session_id;

	IF (firstVote =0) then 
		insert into votes_audit (session_id,que_id,sitting_id) 
			values (new.session_id,old.que_id,old.sitting_id);
	else	
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT ='cannot upvote twice the same question';
	END IF;
	END;
END $$







