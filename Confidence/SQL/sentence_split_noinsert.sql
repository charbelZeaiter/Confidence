DELIMITER //
DROP FUNCTION IF EXISTS  sentence_split_noinsert //
CREATE FUNCTION sentence_split_noinsert
(fullstr VARCHAR(100)) returns VARCHAR(100)
BEGIN
	/* this function will read a question , and autocorrect each word of the sentence and 
		return the corrected question */
	DECLARE inipos INTEGER;
    DECLARE endpos INTEGER;
    DECLARE maxlen INTEGER;
    DECLARE item VARCHAR(100);
    DECLARE delim VARCHAR(1);
	DECLARE counter INTEGER;
	DECLARE proper INTEGER default 0;
	DECLARE proper_w VARCHAR(100);
	DECLARE position INTEGER;
	DECLARE notfound INTEGER default 0;
	DECLARE final VARCHAR(100) default '';
	DECLARE var3 INTEGER default 1;
	DECLARE len INTEGER;
	DECLARE len1 INTEGER;
	declare cat integer default 0;
	DECLARE var1 VARCHAR(100);
	DECLARE var2 INTEGER;

	DECLARE c_entries CURSOR FOR 
	select word ,count(*) as "a" 
	from entries 
	where length(word) in (len-1,len,len+1) 
	and (left(word,len1) = left( item,len1) 
		or right(word,len1)=right(item,len1)) 
	group by word 
	order by a desc ;


	DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1;
	SET delim    = ' ';
	SET counter  = 0;
    SET inipos   = 1;
    SET fullstr  = CONCAT(fullstr, delim);
    SET maxlen   = LENGTH(fullstr);
	SET position = 0;
	
	

    REPEAT
        SET endpos = LOCATE(delim, fullstr, inipos);
        SET item   =  SUBSTR(fullstr, inipos, endpos - inipos);
		SET position = position +1;
		
		
		if length(item) >= 3 then
		select category into cat
		from word_group where word=item limit 1;
		 if cat = 9 then  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Please do not post any rude words, question has been deleted'; end if;
		
		select ifnull(sum(1),0) into proper 
		from entries 
		where word=item;
			if notfound=1 then set notfound=0; end if;
			if proper=0  then 
				
				SET len=length(item) ,len1=2;
				
				open c_entries;
				entries_loop : loop
				fetch c_entries into var1 ,var2;
				if notfound=1 then

					SET notfound=0; 
					leave entries_loop; 
				end if;
			-- insert into answer values(var1);
					
				select  levenshtein(item,var1) 
				into var3;
				if var3=1 then 
					SET item = var1 ,var3=0; 
					
					leave entries_loop; 
				end if; 
				end loop;
				close c_entries;
			end if;
		end if;
		if trim(item)<>'' and item is not null then 
				SET final = concat(final,concat(' ',lower(item)));
		end if;
        SET inipos = endpos + 1;
		
    UNTIL inipos >= maxlen 		
	END REPEAT; 
	return trim(final);
END //
DELIMITER ;