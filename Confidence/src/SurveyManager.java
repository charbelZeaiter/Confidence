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
//				//rename sorted
//				String sql = "SELECT sorted.question, sorted.response, count(sorted.response) AS response_count FROM (SELECT question, response FROM survey_responses ORDER BY question) AS sorted GROUP BY sorted.response ORDER BY sorted.response  ";
//				System.out.println(sql);
//				ResultSet rs = mysql.select(sql);
//				while (rs.next()){
//					HashMap<String, String> row = new HashMap<String, String>();
//					row.put("question", rs.getString("question"));
//					row.put("response", rs.getString("response"));
//					row.put("response_count", rs.getString("response_count"));
//					stats.add(row);
//				}
			String sql = "SELECT * FROM survey_results WHERE lecturer_id = 1 ORDER BY q_id";
			//where lecturer id...
			System.out.println(sql);
			ResultSet rs = mysql.select(sql);
			while (rs.next()){
				HashMap<String, String> row = new HashMap<String, String>();
				row.put("q_id", rs.getString("q_id"));
				for (int i=1;i<=5;i++) {
					row.put("o_"+i, rs.getString("o_"+i));
					System.out.println("o_"+i + " : " + rs.getString("o_"+i));
				}
				stats.add(row);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return stats;
	}

//	public void respondToQuestion(String questionId,String response) {
//
//		try {
//			String sql= "insert into survey_results(q_id,response) values (\""+questionId+"\",\""+response+"\")";
//			mysql.insert(sql);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//
//	}
	
	public ArrayList<HashMap<String, String>> getQuestions() {

		ArrayList<HashMap<String, String>> questions = new ArrayList<HashMap<String, String>>();

		try {
				String sql = "SELECT q_id, question FROM survey_questions";
				ResultSet rs = mysql.select(sql);
				while (rs.next()){
					HashMap<String, String> row = new HashMap<String, String>();
					row.put("id", rs.getString("q_id"));
					row.put("question", rs.getString("question"));
					questions.add(row);
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return questions;

	}

	public void insertNewSitting(int facilitatorRecordId, int sittingId) {
		try {
			for (int i=1;i<=3;i++) {
				String sql= "insert into survey_results(q_id,lecturer_id,sitting_id,o_1,o_2,o_3,o_4,o_5) values (\""+i+"\",\""+facilitatorRecordId+"\",\""+sittingId+"\",0,0,0,0,0)";
				mysql.insert(sql);
			}
				
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
