DELIMITER $$
DROP TRIGGER IF EXISTS chk_votes $$
CREATE TRIGGER chk_votes  
BEFORE UPDATE ON questions 
FOR EACH ROW  
BEGIN
	DECLARE firstVote integer ;
	set firstVote=0;
	BEGIN  
	if new.num_votes <> old.num_votes then
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
	end if;
	END IF;
	END;
END $$
DELIMITER ;
/*
DELIMITER ;
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
*/
