DELIMITER //
DROP PROCEDURE IF EXISTS  sentence_split //
CREATE PROCEDURE sentence_split
(IN fullstr VARCHAR(100))
BEGIN

	DECLARE inipos INTEGER;
    DECLARE endpos INTEGER;
    DECLARE maxlen INTEGER;
    DECLARE item VARCHAR(100);
    DECLARE delim VARCHAR(1);
	DECLARE counter INTEGER;
	DECLARE sid INTEGER;
	declare position integer;
	
	SET delim = ' ';
	SET counter = 0;
    SET inipos = 1;
    SET fullstr = CONCAT(fullstr, delim);
    SET maxlen = LENGTH(fullstr);
	set position =0;
	
	select ifnull(max(id),0)+1 into sid from sentence_seq ;
	
    REPEAT
        SET endpos = LOCATE(delim, fullstr, inipos);
        SET item =  SUBSTR(fullstr, inipos, endpos - inipos);
		set position = position +1;
         IF item <> '' AND item IS NOT NULL THEN           
			SET counter = counter + 1;
			insert into sentence(id,word_id,word_position,word) values (sid,counter,endpos,item) ;
         END IF;
		 
        SET inipos = endpos + 1;
		
    UNTIL inipos >= maxlen 
		
	END REPEAT; 
		insert into sentence_seq (id,sentence,nbword) values (sid,fullstr,counter);
	 -- create table sentence_seq (id integer , sentence varchar(100),nbword integer);
	 -- create table sentence (id integer,word_id integer,word_position integer,word varchar(100));
	

END //
DELIMITER ;