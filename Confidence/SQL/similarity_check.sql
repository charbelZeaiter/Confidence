DELIMITER //
DROP function IF EXISTS  similarity_check //
CREATE function similarity_check
(q1 integer ,q2 integer) returns float
BEGIN
	DECLARE done integer DEFAULT 0;
	declare q1_cur_word varchar(50);
	declare q2_cur_word varchar(50);
	declare totnbword integer default 0;
	
	DECLARE matching integer default 0;
	DECLARE tot_matching integer default 0;
	DECLARE matching2 integer default 0;
	DECLARE matching3 integer default 0;
	DECLARE word varchar(50); 
	DECLARE suf varchar(20); 

	
	DECLARE c_suffix CURSOR FOR select suffix from word_suffix ;
	
	DECLARE CONTINUE handler FOR NOT FOUND SET done =1;
	
	open c_suffix;
	check_word : loop
	fetch c_suffix into suf;
	
	IF done = 1 then 
		LEAVE check_word;
	end if;	
	select count(*)
	into matching
	from sentence_d a, sentence_d b 
	where a.id = 1 and b.id=2 
	and  ( soundex(a.word)=soundex(b.word)
	or soundex(concat(a.word,suf))=soundex(b.word)
	or soundex(a.word)=soundex(concat(b.word,suf)) );
	
	set tot_matching =tot_matching + matching;
	-- insert into answer values (suf,matching);
	end loop;
	close c_suffix;
	
	select count(*) into totnbword from sentence_d where id in (q1,q2);
	
	IF q1=q2 then
	set totnbword=totnbword*2;
	end if;
	
	
	return  tot_matching*2/totnbword ;
END //
DELIMITER ;

