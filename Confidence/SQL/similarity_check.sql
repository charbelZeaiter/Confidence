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
	declare abs integer;
	DECLARE matching integer default 0;
	declare var integer default 0;
	declare var1 integer default 0;
	DECLARE exact_test  integer default 0;
	DECLARE category_test  integer default 0;
	DECLARE suffix_test  integer default 0;
	declare v1 integer;
	declare v2 integer;
	DECLARE tot_matching integer default 0;
	DECLARE word varchar(50); 
	DECLARE suf varchar(20) ; 
	DECLARE diff integer default 0;
	DECLARE sameque integer default 0;
	
	
	DECLARE c_suffix CURSOR FOR select suffix from word_suffix ;
	
	DECLARE CONTINUE handler FOR NOT FOUND SET done =1;
	
	select count(*)
	into exact_test
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
	where a.id=q1 and b.id=q2 
	and a.word not in
			(select a.word from question_d a ,question_d b  where a.id=q1 and b.id=q2  and a.word=b.word)
	and b.word not in
			(select b.word from question_d a ,question_d b  where a.id=q1 and b.id=q2 and a.word=b.word)
	and ( 
		soundex(a.word)=soundex(b.word)
	 or soundex(concat(a.word,suf))=soundex(b.word)
	 or soundex(a.word)=soundex(concat(b.word,suf)) 
		)
	and b.category !=1
	and a.category !=1;

	-- set tot_matching =tot_matching + matching;
	if matching > suffix_test then set suffix_test=matching; end if;
	end loop;
	close c_suffix;
	
	select count(*)
	into category_test
	from question_d a, question_d b 
	where a.id = q1 and b.id=q2 
	and a.word != b.word
	and a.word not in ( select a.word from question_d a, question_d b where a.id = q1 and b.id=q2 and a.word=b.word)
	and b.word not in ( select b.word from question_d a, question_d b where a.id = q1 and b.id=q2 and a.word=b.word)
	and a.category = b.category and a.category >1;

	select count(*) into v1 from question_d where category =2 and id=q1;
	select count(*) into v2 from question_d where category =2 and id=q2;
	if category_test > v1 then set category_test=v1; end if;
	if category_test > v2 then set category_test=v2; end if;
	
	set tot_matching = category_test + exact_test + suffix_test;
   
	select nbword into q1_len from question_h where id =q1;
 	select nbword into q2_len from question_h where id =q2;
	select abs(q1_len - q2_len ) into abs ;-- from question_h where id =q2;
	
	if tot_matching >=q2_len or tot_matching >=q1_len then 
		-- set tot_matching = -2; 
		select count(distinct(word)) into var from question_d  where id in (q1,q2) and category =1;
		select count(*) into var1 from question_d  where id in (q1,q2) and word='what';
		if abs = 1   and var =1 then set tot_matching=3; end if;
		if abs > 1 and var >1 then set tot_matching=-1; end if;
		if abs=0 and (tot_matching = q2_len or tot_matching =q1_len) then set tot_matching = 4; end if;
		if abs >2 then set tot_matching = 5;end if; 
		-- if abs >= 1 and var =0 and var1=1 then set tot_matching=6; end if;
		if abs >= 1 and var =0 then set tot_matching=6; end if;
	else 
		set tot_matching = -4; -- tot_matching *2/(q2_len+q1_len);
	end if;

	return    tot_matching;-- *2/(q2_len+q1_len); 
END //
DELIMITER ;

