import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import jdbc.MysqlJDBC;

public class QuestionManager {

	MysqlJDBC mysql;

	public QuestionManager() throws ClassNotFoundException {
		mysql = new MysqlJDBC();
	}

	public ArrayList<HashMap<String, String>> getQuestions(String sort,int sittingId) {
		ArrayList<HashMap<String, String>> questions = new ArrayList<HashMap<String, String>>();
		String sqlQuery = "";
		
		String order = "num_votes";
		if (sort == null || sort.equals("") || sort.equals("upvote")) {
			sqlQuery = "SELECT que_id, description, num_votes, creation_time FROM questions " +
					"WHERE hidden = 'F' AND sitting_id = ? ORDER BY num_votes DESC";
		} else if (sort.equals("date")) {
			sqlQuery = "SELECT que_id, description, num_votes, creation_time FROM questions " +
					"WHERE hidden = 'F' AND sitting_id = ? ORDER BY creation_time DESC";
		}

		try {
			System.out.println(order);
			// Create sql statement and pass values in.
			
			PreparedStatement ps =  mysql.getConnection().prepareStatement(sqlQuery);

			// Set values in query.
			ps.setInt(1, sittingId);
			//ps.setString(2, order);
			
			// Execute query and loop through saving results.
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				HashMap<String, String> row = new HashMap<String, String>();
				row.put("id", rs.getString("que_id"));
				row.put("description", rs.getString("description"));
				row.put("num_votes", rs.getString("num_votes"));
				row.put("creation_time", rs.getString("creation_time"));
				questions.add(row);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return questions;
	}

	public void submitQuestion(String question, int sittingId ,String sessionId) {
		Date dt = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime = sdf.format(dt);
		
		try {
			// Create sql statement and pass values in.
			String sqlQuery = "insert into questions(description, sitting_id,session_id, creation_time) values (?, ?, ?, ?)";
			PreparedStatement ps =  mysql.getConnection().prepareStatement(sqlQuery);

			// Set values in query.
			ps.setString(1, question);
			ps.setInt(2, sittingId);
			ps.setString(3, sessionId);
			ps.setString(4, currentTime);
			
			// Execute query.
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void upvoteQuestion(String questionId, String sessionId) {
		try {
			// Create sql statement and pass values in.
			String sqlQuery = "UPDATE questions SET num_votes = num_votes + 1 ,session_id = ? WHERE que_id = ?;";
			PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery);

			// Set query values.
			ps.setString(1, sessionId);
			ps.setString(2, questionId);

			// Execute query.
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}	
	
	
	public void removeQuestion(String questionId) {
		try {
			// Create sql statement and pass values in.
			String sqlQuery = "UPDATE questions SET hidden = 'T' WHERE que_id = ?;";
			PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery);

			// Set query values.
			ps.setString(1, questionId);

			// Execute query.
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}