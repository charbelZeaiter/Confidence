DELIMITER //
DROP function IF EXISTS  similarity_check //
CREATE function similarity_check
(q1 integer ,q2 integer) returns float
BEGIN
	DECLARE done integer DEFAULT 0;
	declare q1_cur_word varchar(50);
	declare q2_cur_word varchar(50);
	declare totnbword integer default 0;
	declare q1_len integer;
	declare q2_len integer;
	DECLARE matching integer default 0;
	DECLARE suffix integer default 0;
	DECLARE exact  integer default 0;
	DECLARE category  integer default 0;

	DECLARE tot_matching integer default 0;

	DECLARE word varchar(50); 
	DECLARE suf varchar(20) ; 
	DECLARE diff integer default 0;
	
	DECLARE c_suffix CURSOR FOR select suffix from word_suffix ;
	
	DECLARE CONTINUE handler FOR NOT FOUND SET done =1;
	
	select count(*)
	into exact
	from question_d a, question_d b 
	where a.id = q1 and b.id=q2 and a.word=b.word;


	open c_suffix;
	check_word : loop
	fetch c_suffix into suf;
	IF done = 1 then 
		LEAVE check_word;
	end if;	
	select count(*)
	into matching
	from question_d a, question_d b 
	where a.id = q1 and b.id=q2 
	and a.word != b.word and 
	( soundex(a.word)=soundex(b.word)
	or soundex(concat(a.word,suf))=soundex(b.word)
	or soundex(a.word)=soundex(concat(b.word,suf)) );

	-- set tot_matching =tot_matching + matching;
	if matching > suffix then set suffix=matching; end if;
	end loop;
	close c_suffix;
	
	select count(*)
	into category
	from question_d a, question_d b 
	where a.id = q1 and b.id=q2 
	and a.category = b.category and a.category >1;
	
	select 1 into diff from question_d a, question_d b  
	where a.id = q1 and b.id=q2 and a.category =b.category and a.category=1 
	and soundex(a.word) != soundex(b.word) ;
	if diff=1 then return -1 ; end if;
	
	select count(*) into totnbword from question_d where id in (q1,q2);
	
	IF q1=q2 then return 1 ; end if;
	select length(q1) into q1_len from question_h where id =q1;
	select length(q2) into q2_len from question_h where id =q2;
	
	

	set tot_matching = exact +suffix + category;
	if q1_len <= tot_matching or q2_len <= tot_matching then 
		return tot_matching;
	end if;
	
	-- insert into answer values ('a',tot_matching*2/(q1_len+q2_len));
	return  tot_matching*2/(q1_len+q2_len) ;
END //
DELIMITER ;

