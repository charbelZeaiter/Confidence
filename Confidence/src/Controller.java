

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
import javax.servlet.http.HttpSession;

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
		
		/*
		 * TODO: 
		 * 1. Action = Controller ?? fix please: line 75. 
		 */
		
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
					
				} else if(toPage.equals("studentInterface")) {
					
					request.setAttribute("questions", getQuestions());
					nextPage = "studentInterface.jsp";

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
		
		/*
		 * TODO: 
		 * 1. Database queries need to be done like in facilitator section with 'preparedstatements'.
		 * 2. Need to validate form data.
		 * 3. Need to protect against multiple posts on refresh and back actions.		 
		 */
		
		String aAction = request.getParameter("aAction");
		String nextPage = "sittingAccess.jsp";  
		
		System.out.println(aAction);
		
		if(aAction != null)
		{
			if(aAction.equals("postque")){
				
				// Access server session.
				HttpSession mySession = request.getSession();
				int sittingId = (Integer) mySession.getAttribute("sittingId");
				
				String toPage = request.getParameter("page");
				String question = request.getParameter("questionText");
				submitQuestion(question, sittingId);
				request.setAttribute("questions", getQuestions());
				
				nextPage = "studentSittingInterface.jsp";
				
			} else if (aAction.equals("upvote")) {
				
				String que_id = request.getParameter("que_id");
				upvoteQuestion(que_id);
				request.setAttribute("questions", getQuestions());
				
				nextPage = "studentSittingInterface.jsp";
				
			} else if (aAction.equals("sittingAccessRequest")) {
				
				int sittingId = Integer.parseInt(request.getParameter("aSittingId"));
				String pwd = request.getParameter("aPWD");
				
				// Check details against database.
				boolean exists = checkSittingDB(sittingId, pwd);
				
				if(exists) {
					// Setup session.
					HttpSession mySession = request.getSession();
					mySession.setAttribute("sittingId", sittingId);
					
					
					nextPage = "studentSittingInterface.jsp";
				} else {
					// Turn 'invalid sitting' flag on.
					request.setAttribute("invalidSitting", 1);
				}

			}
		}
		
		RequestDispatcher myRequestDispatcher = request.getRequestDispatcher("/"+nextPage);
		myRequestDispatcher.forward(request, response);
	}
	
	public void submitQuestion(String question, int aSittingId) {
		try {
			MysqlJDBC m=new MysqlJDBC();
			try {
				String sql= "insert into questions(stu_id,forum_id,description,num_votes, sitting_id)  values ('1','1',\""+question+"\",0,\""+aSittingId+"\")";
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
	
	private boolean checkSittingDB(int aSittingId, String aPWD)
	{
		boolean result = false;
		
		try{
			MysqlJDBC m = new MysqlJDBC();
			
			// Create sql statement and pass values in.
            String sqlQuery = "SELECT password FROM sittings WHERE sitting_id = ?";
            
            PreparedStatement ps = m.getConnection().prepareStatement(sqlQuery);
            
            // Set values in query.
            ps.setInt(1, aSittingId);
            
            // Execute query and loop through saving results.
            ResultSet rset = ps.executeQuery();
            
            // If next returns true it means there are records.
            if(rset.next())
            {
            	// Check that passwords match.
	           String databasePWD = rset.getString("password");
	           if(aPWD.equals(databasePWD))
	           {
	        	   result = true;
	           }
            }  
		}
		catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return result;
	}


}

