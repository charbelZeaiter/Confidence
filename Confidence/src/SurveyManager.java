import java.sql.PreparedStatement;
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

	public ArrayList<HashMap<String, String>> getStats(String fac_id) {
		ArrayList<HashMap<String, String>> stats = new ArrayList<HashMap<String, String>>();
		ArrayList<HashMap<String, String>> combinedstats = new ArrayList<HashMap<String, String>>();

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
			String sql = "SELECT * FROM survey_results WHERE lecturer_id = " + fac_id + " ORDER BY q_id";
			//where lecturer id...
			ResultSet rs = mysql.select(sql);
			while (rs.next()){
				HashMap<String, String> row = new HashMap<String, String>();
				row.put("q_id", rs.getString("q_id"));
				for (int i=1;i<=5;i++) {
					row.put("o_"+i, rs.getString("o_"+i));
				}
				stats.add(row);
			}
			combinedstats = aggregateScore(stats);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return combinedstats;
	}

	private ArrayList<HashMap<String, String>> aggregateScore(ArrayList<HashMap<String, String>> stats) {
		ArrayList<HashMap<String, String>> combinedstats = new ArrayList<HashMap<String, String>>();
		for (int j = 1; j <= 3; j++) {
			
			int combinedScore1 = 0;
			int combinedScore2 = 0;
			int combinedScore3 = 0;
			int combinedScore4 = 0;
			int combinedScore5 = 0;
			
			for (int i = 0; i < stats.size();i++) {
				HashMap<String, String> item = stats.get(i);
				if (item.get("q_id").equals(Integer.toString(j))) {
					combinedScore1 += Integer.parseInt(item.get("o_1"));
					combinedScore2 += Integer.parseInt(item.get("o_2"));
					combinedScore3 += Integer.parseInt(item.get("o_3"));
					combinedScore4 += Integer.parseInt(item.get("o_4"));
					combinedScore5 += Integer.parseInt(item.get("o_5"));
				}
				
				
			}
			HashMap<String, String> row = new HashMap<String, String>();
			row.put("q_id", Integer.toString(j));
			row.put("o_1", Integer.toString(combinedScore1));
			row.put("o_2", Integer.toString(combinedScore2));
			row.put("o_3", Integer.toString(combinedScore3));
			row.put("o_4", Integer.toString(combinedScore4));
			row.put("o_5", Integer.toString(combinedScore5));
			
			combinedstats.add(row);
		}
		return combinedstats;
	}

	public void respondToQuestion(String questionId,String response, Integer sittingId) {
		String sqlQuery = "";
		String optionID = "";
		if (response.equals("1")) {
			sqlQuery = "UPDATE survey_results SET o_1 = o_1 + 1 WHERE sitting_id = ? AND q_id = ?";
		} else if (response.equals("2")) {
			sqlQuery = "UPDATE survey_results SET o_2 = o_2 + 1 WHERE sitting_id = ? AND q_id = ?";
		} else if (response.equals("3")) {
			sqlQuery = "UPDATE survey_results SET o_3 = o_3 + 1 WHERE sitting_id = ? AND q_id = ?";
		} else if (response.equals("4")) {
			sqlQuery = "UPDATE survey_results SET o_4 = o_4 + 1 WHERE sitting_id = ? AND q_id = ?";
		} else if (response.equals("5")) {
			sqlQuery = "UPDATE survey_results SET o_5 = o_5 + 1 WHERE sitting_id = ? AND q_id = ?";
		}
		
		
		try {
			// Create sql statement and pass values in.
			

			PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery);
			ps.setInt(1, sittingId);
			ps.setString(2, questionId);
			// Set values in query.

			// Execute query and loop through saving results.
			int result = ps.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	public ArrayList<HashMap<String, String>> getQuestions() {

		ArrayList<HashMap<String, String>> questions = new ArrayList<HashMap<String, String>>();
        
		try {
				String sql = "SELECT q_id, question FROM survey_questions";
				ResultSet rs = mysql.select(sql);
				while (rs.next()){
					HashMap<String, String> row = new HashMap<String, String>();
					row.put("q_id", rs.getString("q_id"));
					row.put("question", rs.getString("question"));
					questions.add(row);
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
		return questions;

	}

	public ArrayList<HashMap<String, String>> findFacilitator(String firstname, String lastname) {
		ArrayList<HashMap<String, String>> facilitators = new ArrayList<HashMap<String, String>>();
		boolean both = false;
		String sqlQuery = "";
		
		if (!firstname.equals("") && !lastname.equals("")) {
			sqlQuery = "SELECT firstname, lastname, facilitator_id FROM facilitators WHERE firstname = ? AND lastname = ?";
			both = true;
		} else {
			if (!firstname.equals("")) {
				sqlQuery = "SELECT firstname, lastname, facilitator_id FROM facilitators WHERE firstname = ?";
				
			} else {
				sqlQuery = "SELECT firstname, lastname, facilitator_id FROM facilitators WHERE lastname = ?";
				
			}
		}
		try {
		PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery);
		if (both) {
			ps.setString(1,firstname);
			ps.setString(2,lastname);
			
		} else {
			if (!firstname.equals("")) {
				ps.setString(1,firstname);
				
			} else {
				ps.setString(1,lastname);
				
			}
			
		}
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				HashMap<String, String> row = new HashMap<String, String>();
				row.put("f_id", rs.getString("facilitator_id"));
				row.put("fname", rs.getString("firstname"));
				row.put("lname", rs.getString("lastname"));
				facilitators.add(row);
			}
	    } catch (SQLException e) {
		    e.printStackTrace();
	    }
		
		return facilitators;
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
