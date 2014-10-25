#! /bin/bash 

mysql -u root -proot Confidence < ./table.sql  
mysql -u root -proot Confidence < ./data.sql  
mysql -u root -proot Confidence < ./dictionaryStudyTool.sql  
mysql -u root -proot Confidence < ./question_autocorrect.sql 
mysql -u root -proot Confidence < ./trigger.sql  
mysql -u root -proot Confidence < ./levenshtein.sql  
mysql -u root -proot Confidence < ./sentence_split_noinsert.sql
mysql -u root -proot Confidence < ./sentence_split.sql
mysql -u root -proot Confidence < ./similarity_check.sql
mysql -u root -proot Confidence < ./check_question_similarity.sql  
