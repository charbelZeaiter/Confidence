import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import jdbc.MysqlJDBC;

public class SurveyManager {

	MysqlJDBC mysql;

	public SurveyManager() throws ClassNotFoundException {
		mysql = new MysqlJDBC();
	}

	public ArrayList<HashMap<String, String>> getStats() {
		ArrayList<HashMap<String, String>> stats = new ArrayList<HashMap<String, String>>();

		try {
				String sql = "SELECT sorted.question, sorted.response, count(sorted.response) AS response_count FROM (SELECT question, response FROM survey_responses ORDER BY question) AS sorted GROUP BY sorted.response ORDER BY sorted.response  ";
				ResultSet rs = mysql.select(sql);
				while (rs.next()){
					HashMap<String, String> row = new HashMap<String, String>();
					row.put("question", rs.getString("question"));
					row.put("response", rs.getString("response"));
					row.put("response_count", rs.getString("response_count"));
					stats.add(row);
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return stats;
	}

	public void respondToQuestion(String questionId,String response) {

		try {
			String sql= "insert into survey_responses(question,response) values (\""+questionId+"\",\""+response+"\")";
			mysql.insert(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	public ArrayList<HashMap<String, String>> getQuestions() {

		ArrayList<HashMap<String, String>> questions = new ArrayList<HashMap<String, String>>();

		try {
				String sql = "SELECT id, question FROM survey_questions";
				ResultSet rs = mysql.select(sql);
				while (rs.next()){
					HashMap<String, String> row = new HashMap<String, String>();
					row.put("id", rs.getString("id"));
					row.put("question", rs.getString("question"));
					questions.add(row);
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return questions;

	}

}
