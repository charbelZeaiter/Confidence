import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import jdbc.MysqlJDBC;

public class QuestionManager {

	MysqlJDBC mysql;

	public QuestionManager() throws ClassNotFoundException {
		mysql = new MysqlJDBC();
	}

	public ArrayList<HashMap<String, String>> getQuestions() {
		ArrayList<HashMap<String, String>> questions = new ArrayList<HashMap<String, String>>();

		try {
			String sql = "SELECT que_id,description,num_votes FROM questions ORDER BY num_votes DESC";
			ResultSet rs = mysql.select(sql);
			while (rs.next()){
				HashMap<String, String> row = new HashMap<String, String>();
				row.put("id", rs.getString("que_id"));
				row.put("description", rs.getString("description"));
				row.put("num_votes", rs.getString("num_votes"));
				questions.add(row);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return questions;
	}

	public void submitQuestion(String question, int aSittingId) {

		try {
			String sql= "insert into questions(stu_id,forum_id,description,num_votes, sitting_id)  values ('1','1',\""+question+"\",0,\""+aSittingId+"\")";
			mysql.insert(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void upvoteQuestion(String questionId) {

		try {
			String sql= "UPDATE questions SET num_votes = num_votes + 1 WHERE que_id = " + questionId + ";";
			mysql.insert(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
