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

	public ArrayList<HashMap<String, String>> getQuestions(String sort,int sittingId) {
		ArrayList<HashMap<String, String>> questions = new ArrayList<HashMap<String, String>>();
		
		String order = "";
		if (sort == null || sort.equals("")) {

			order = "num_votes";
		} else if (sort.equals("upvote")) {
			order = "num_votes";
		} else if (sort.equals("date")) {
			System.out.println("huh");
			order = "creation_time";
		}

		try {
			String sql = "SELECT que_id,description,num_votes, creation_time FROM questions " +
					"WHERE hidden = 'F' AND sitting_id= "+sittingId+" ORDER BY "+ order +" DESC";
			ResultSet rs = mysql.select(sql);
			while (rs.next()){
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

	public void submitQuestion(String question, int aSittingId ,String sessionId) {
		java.util.Date dt = new java.util.Date();

		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");

		String currentTime = sdf.format(dt);
		try {
			String sql= "insert into questions(stu_id,forum_id,description,num_votes, sitting_id,session_id, creation_time, hidden )  " +
					"values ('1','1',\""+question+"\",0,\""+aSittingId+"\",\""+sessionId+"\",\""+currentTime+""+"\",\"F"+"\")";
			mysql.insert(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void upvoteQuestion(String questionId,String session_id) {

		try {
			String sql= "UPDATE questions SET num_votes = num_votes + 1 ,session_id = \""+session_id+"\""+"WHERE que_id = " + questionId + ";";
			mysql.insert(sql);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}

	}	
	
	
	public void removeQuestion(String questionId) {
		try {
			MysqlJDBC m=new MysqlJDBC();
			try {
				String sql= "UPDATE questions SET hidden = 'T' WHERE que_id = " + questionId + ";";
				mysql.insert(sql);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
