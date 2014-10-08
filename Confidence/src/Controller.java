

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jdbc.MysqlJDBC;

/**
 * Servlet implementation class Contoller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Controller() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Get 'action' parameter from URL.
		String aAction = request.getParameter("aAction");

		// Set default landing page.
		String nextPage = "index.jsp";  

		if(aAction != null){
			if(aAction.equals("navigation"))
			{
				// Get page to navigate to.
				String toPage = request.getParameter("page");

				// Set page to dispatch to.
				if(toPage.equals("home"))
				{
					
					nextPage = "index.jsp";
					
				} else if(toPage.equals("createSitting")) {
					
					nextPage = "createSitting.jsp";

				} else if(toPage.equals("studentInterface")) {
					
					request.setAttribute("questions", getQuestions());
					nextPage = "studentInterface.jsp";

				} else if(toPage.equals("lecturerInterface")) {
					
					request.setAttribute("questions", getQuestions());
					nextPage = "lecturerInterface.jsp";

				} else if(toPage.equals("questions")) {
					
					nextPage = "questions.jsp";
					
				}

			}
			if(aAction.equals("Controller")){
				nextPage = "index.jsp";
			}
		}

		// Dispatch Control.
		RequestDispatcher myRequestDispatcher = request.getRequestDispatcher("/"+nextPage);
		myRequestDispatcher.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String aAction = request.getParameter("aAction");
		String nextPage = "studentInterface.jsp";  
		
		if(aAction != null){
			System.out.println(aAction);
			if(aAction.equals("postque")){
				String toPage = request.getParameter("page");
				String question = request.getParameter("questionText");
				submitQuestion(question);
				request.setAttribute("questions", getQuestions());
				
				nextPage = "studentInterface.jsp";
				
			} else if (aAction.equals("upvote")) {
				
				String que_id = request.getParameter("que_id");
				upvoteQuestion(que_id);
				request.setAttribute("questions", getQuestions());
				
				nextPage = "studentInterface.jsp";
				
			} else if (aAction.equals("createSitting")) {

				String pwd = request.getParameter("aPWD");
				int sittingId = this.insertNewSitting(pwd);
				
				request.setAttribute("sittingId", sittingId);
				request.setAttribute("pwd", pwd);
				
				System.out.println("Sitting Id: "+sittingId);
				System.out.println("Password: "+pwd);
				
				nextPage = "createSitting.jsp";
			}
		}
		
		RequestDispatcher myRequestDispatcher = request.getRequestDispatcher("/"+nextPage);
		myRequestDispatcher.forward(request, response);
	}
	
	public void submitQuestion(String question) {
		try {
			MysqlJDBC m=new MysqlJDBC();
			try {
				String sql= "insert into questions(stu_id,forum_id,description,num_votes)  values ('1','1',\""+question+"\",0)";
				m.insert(sql);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public void upvoteQuestion(String questionId) {
		try {
			MysqlJDBC m=new MysqlJDBC();
			try {
				String sql= "UPDATE questions SET num_votes = num_votes + 1 WHERE que_id = " + questionId + ";";
				m.insert(sql);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private int insertNewSitting(String aPWD) {
		
		try {
			
			MysqlJDBC m=new MysqlJDBC();

            // Create sql statement and pass values in.
            String sqlQuery = "INSERT INTO sitting (password) VALUES (?)";
            
            PreparedStatement ps = m.getConnection().prepareStatement(sqlQuery, Statement.RETURN_GENERATED_KEYS);
            
            ps.setString(1, aPWD);
            
            // Execute query;
            
            int result = ps.executeUpdate();
            
            assert(result == 1);
            
            ResultSet myRS = ps.getGeneratedKeys();
            myRS.next();
            int id = myRS.getInt(1);
        
            return id;
		}
		catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	public ArrayList getQuestions() {
		ArrayList questions = new ArrayList();
		try {
			MysqlJDBC m=new MysqlJDBC();
			try {
				// Get all questions
				String sql = "SELECT que_id,description,num_votes FROM questions ORDER BY num_votes DESC";
				ResultSet rs = m.select(sql);
				while (rs.next()){
					HashMap<String, String> row = new HashMap<String, String>();
					row.put("id", rs.getString("que_id"));
					row.put("description", rs.getString("description"));
					row.put("num_votes", rs.getString("num_votes"));
					questions.add(row);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return questions;
	}
}

