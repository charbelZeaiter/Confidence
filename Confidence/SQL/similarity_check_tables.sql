drop table if exists excluded_word;
drop table if exists word_group;
drop table if exists group_similarity;
drop table if exists word_suffix;
drop table if exists sentence_h;
drop table if exists sentence_d;



create table excluded_word (word varchar(100));
insert into excluded_word values ("is");
insert into excluded_word values ("of");
insert into excluded_word values ("a");
insert into excluded_word values ("an");
insert into excluded_word values ("are");
insert into excluded_word values ("on");
insert into excluded_word values ("at");
insert into excluded_word values ("for");
insert into excluded_word values ("the");
insert into excluded_word values ("do");
insert into excluded_word values ("you");


create table word_group ( category integer , word varchar(50));
insert into word_group (category,word) values (1,"what");
insert into word_group (category,word) values (1,"where");
insert into word_group (category,word) values (1,"why");
insert into word_group (category,word) values (1,"who");
insert into word_group (category,word) values (1,"when");
insert into word_group (category,word) values (1,"how");

create table group_similarity ( category integer , similarity integer);

create table word_suffix ( id integer , suffix varchar(20));
insert into word_suffix values (1 ,"ing");
insert into word_suffix values (1 ,"s");
insert into word_suffix values (1 ,"tion");


  create table question_h (
    id integer , 
    sentence varchar(100),
    nbword integer
    );
  
  create table question_d (
    id integer,
    word_id integer,
    word_position integer,
    word varchar(100)
    );

