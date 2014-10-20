

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

	private QuestionManager questionManager;
	private SittingManager sittingManager;

	/**
	 * @throws ClassNotFoundException 
	 * @see HttpServlet#HttpServlet()
	 */
	public Controller() throws ClassNotFoundException {
		super();
		questionManager = new QuestionManager();
		sittingManager = new SittingManager();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Get 'action' parameter from URL.
		String aAction = request.getParameter("aAction");

		// Set default landing page.
		String nextPage = "index.jsp";  

		HttpSession mySession = request.getSession();
		Object sittingIdString = mySession.getAttribute("sittingId");
		int sittingId = 0;
		
		if (sittingIdString != null) {
			sittingId = (Integer) mySession.getAttribute("sittingId");	
		}
		
		if(aAction != null){
			if(aAction.equals("navigation"))
			{
				// Get page to navigate to.
				String toPage = request.getParameter("page");

				// Set page to dispatch to.
				if(toPage.equals("home") || toPage.equals("studentLogin")) {
					
					request.setAttribute("loginType", "studentLogin");
					nextPage = "login.jsp";
					
				} else if(toPage.equals("studentSittingInterface")) {

					request.setAttribute("questions", questionManager.getQuestions("", sittingId));
					nextPage = "studentSittingInterface.jsp";

				}
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
		String sort = request.getParameter("sorted");
		request.setAttribute("sorted", sort); 

		System.out.println(aAction);

		// Access server session.
		HttpSession mySession = request.getSession();
		Object sittingIdString = mySession.getAttribute("sittingId");
		int sittingId = 0;
		
		if (sittingIdString != null) {
			sittingId = (Integer) sittingIdString;
			System.out.println("SITTING ID: " + sittingId);
		}
		
		if(aAction != null)
		{
			String session_id= request.getSession().getId();
			if(aAction.equals("postque")){
				String toPage = request.getParameter("page");
				String question = request.getParameter("questionText");
				
				questionManager.submitQuestion(question, sittingId,session_id);
				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));

				nextPage = "studentSittingInterface.jsp";

			} else if (aAction.equals("upvote")) {

				String que_id = request.getParameter("que_id");
				questionManager.upvoteQuestion(que_id,session_id);
				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));

				nextPage = "studentSittingInterface.jsp";

			} else if (aAction.equals("sittingAccessRequest")) {

				String input = request.getParameter("aSittingId");
				sittingId = 0;
				boolean exists = false;
				String error = "Login failed!";
				
				try {
					sittingId = Integer.parseInt(input);
					String pwd = request.getParameter("aPWD");
					// Check details against database.
					exists = sittingManager.checkSittingDB(sittingId, pwd);
				} catch (NumberFormatException e) {
					error = "ID should be a valid integer";
				}

				if (exists) {
					System.out.println("Sort: " + sort + " sittingId: " + sittingId);
					request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
					
					mySession.setAttribute("sittingId", sittingId);
					
					nextPage = "studentSittingInterface.jsp";

				} else {
					// Failed login
					request.setAttribute("error", error);
					request.setAttribute("loginType", "studentLogin");
					nextPage = "login.jsp";
				}

			} else if (aAction.equals("refresh")) {

				String pwd = request.getParameter("aPWD");

				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
				request.setAttribute("sittingId", sittingId);
				request.setAttribute("accessPWD", pwd);

				nextPage = "studentSittingInterface.jsp";
				
			} else if (aAction.equals("sort")) {
				
				sort = request.getParameter("sortby");
				request.setAttribute("sorted", sort);
				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
				nextPage = "studentSittingInterface.jsp";
				
			}
		}

		RequestDispatcher myRequestDispatcher = request.getRequestDispatcher("/"+nextPage);
		myRequestDispatcher.forward(request, response);
	}

}

