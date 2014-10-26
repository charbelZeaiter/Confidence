#! /bin/bash 

mysql -u root -ppassword Confidence < ./table.sql 
mysql -u root -ppassword Confidence < ./comments.sql   
mysql -u root -ppassword Confidence < ./data.sql  
mysql -u root -ppassword Confidence < ./dictionaryStudyTool.sql  
mysql -u root -ppassword Confidence < ./question_autocorrect.sql 
mysql -u root -ppassword Confidence < ./trigger.sql  
mysql -u root -ppassword Confidence < ./levenshtein.sql  
mysql -u root -ppassword Confidence < ./sentence_split_noinsert.sql
mysql -u root -ppassword Confidence < ./sentence_split.sql
mysql -u root -ppassword Confidence < ./similarity_check.sql
mysql -u root -ppassword Confidence < ./check_question_similarity.sql  
