DELIMITER //
DROP procedure IF EXISTS  sentence_split //
CREATE procedure sentence_split
(fullstr varchar(100),q_id integer,sit_id integer ) 
BEGIN
	/* this procedure will read a question as input fullstr', decompose it into words and store it in question_d 
		assuming that original string is error free
	*/
	DECLARE inipos INTEGER;
    DECLARE endpos INTEGER;
    DECLARE maxlen INTEGER;
    DECLARE item VARCHAR(100);
    DECLARE delim VARCHAR(1);
	DECLARE counter INTEGER default 0;
	DECLARE proper integer default 0;
	declare proper_w varchar(100);
	declare position integer;
	declare notfound integer default 0;
	declare final varchar(100) default '';
	declare cat integer default 0;
	DECLARE CONTINUE HANDLER FOR NOT FOUND set notfound=1;
	SET delim = ' ';
	SET counter = 0;
    SET inipos = 1;
    SET fullstr = CONCAT(fullstr, delim);
    SET maxlen = LENGTH(fullstr);
	set position =0;
	

    REPEAT
        SET endpos = LOCATE(delim, fullstr, inipos);
        SET item =  SUBSTR(fullstr, inipos, endpos - inipos);
		set position = position +1;

         IF item <> '' AND item IS NOT NULL and (soundex(item) not in (select soundex(word) from excluded_word) or item='why')
					and length(item)>2 THEN           
			SET counter = counter + 1;
			select category into cat from word_group where word=item limit 1;
			insert into question_d(id,word_id,word_position,word,category) values (q_id,counter,endpos,item,cat) ; 
			set cat=0;
         END IF;
		 
        SET inipos = endpos + 1;
		
    UNTIL inipos >= maxlen 
		
	END REPEAT; 
		 insert into question_h (id,sentence,nbword,sitting_id) values (q_id,fullstr,counter,sit_id);
	
END //
DELIMITER ;