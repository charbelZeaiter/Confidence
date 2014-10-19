DELIMITER //
DROP PROCEDURE IF EXISTS  sentence_split //
CREATE PROCEDURE sentence_split
(IN fullstr varchar(100),IN q_id integer,IN sit_id integer)
BEGIN

	DECLARE inipos INTEGER;
    DECLARE endpos INTEGER;
    DECLARE maxlen INTEGER;
    DECLARE item VARCHAR(100);
    DECLARE delim VARCHAR(1);
	DECLARE counter INTEGER;
	
	declare position integer;
	
	SET delim = ' ';
	SET counter = 0;
    SET inipos = 1;
    SET fullstr = CONCAT(fullstr, delim);
    SET maxlen = LENGTH(fullstr);
	set position =0;
	
	-- select ifnull(max(id),0)+1 into sid from sentence_seq ;
	-- insert into answer(a,b) values (fullstr,q_id);
    REPEAT
        SET endpos = LOCATE(delim, fullstr, inipos);
        SET item =  SUBSTR(fullstr, inipos, endpos - inipos);
		set position = position +1;
         IF item <> '' AND item IS NOT NULL and item not in (select distinct word from excluded_word) 
					and length(item)>2 THEN           
			SET counter = counter + 1;
			insert into question_d(id,word_id,word_position,word) values (q_id,counter,endpos,item) ;
         END IF;
		 
        SET inipos = endpos + 1;
		
    UNTIL inipos >= maxlen 
		
	END REPEAT; 
		insert into question_h (id,sentence,nbword,sitting_id) values (q_id,fullstr,counter,sit_id);
	
END //
DELIMITER ;