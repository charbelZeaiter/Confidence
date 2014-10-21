

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
	private SurveyManager surveyManager;

	/**
	 * @throws ClassNotFoundException 
	 * @see HttpServlet#HttpServlet()
	 */
	public Controller() throws ClassNotFoundException {
		super();
		questionManager = new QuestionManager();
		sittingManager = new SittingManager();
		
		surveyManager = new SurveyManager();
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
				} else if(toPage.equals("studentInterface")) {
					request.setAttribute("questions", questionManager.getQuestions());
					nextPage = "studentInterface.jsp";
				} else if(toPage.equals("survey")) {
					request.setAttribute("responses", surveyManager.getStats());
					request.setAttribute("questions", surveyManager.getQuestions());
					request.setAttribute("choices", new String[] {"1","2","3","4","5"});
					nextPage = "surveyResults.jsp";

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

		System.out.println(aAction);

		if(aAction != null)
		{
			if(aAction.equals("postque")){

				// Access server session.
				HttpSession mySession = request.getSession();
				//int sittingId = (Integer) mySession.getAttribute("sittingId");
				int sittingId = 1;
				
				String toPage = request.getParameter("page");
				String question = request.getParameter("questionText");
				questionManager.submitQuestion(question, sittingId);
				request.setAttribute("questions", questionManager.getQuestions());

				nextPage = "studentSittingInterface.jsp";

			} else if(aAction.equals("submitSurvey"))
			{
				for (Integer i=1;i<=3;i++) {
					String in = request.getParameter(i.toString());
					System.out.println(i.toString()+ " : " + in);
					surveyManager.respondToQuestion(i.toString(), in);
				}
				System.out.println("hello there");
				request.setAttribute("responses", surveyManager.getStats());
				request.setAttribute("questions", surveyManager.getQuestions());
				request.setAttribute("choices", new String[] {"1","2","3","4","5"});
				nextPage = "surveyResults.jsp";
			} else if (aAction.equals("upvote")) {

				String que_id = request.getParameter("que_id");
				questionManager.upvoteQuestion(que_id);
				request.setAttribute("questions", questionManager.getQuestions());

				nextPage = "studentSittingInterface.jsp";

			} else if (aAction.equals("upvote")) {
				String que_id = request.getParameter("que_id");
				questionManager.upvoteQuestion(que_id);
				request.setAttribute("questions", questionManager.getQuestions());
				nextPage = "studentSittingInterface.jsp";

			} else if (aAction.equals("sittingAccessRequest")) {

				int sittingId = Integer.parseInt(request.getParameter("aSittingId"));
				String pwd = request.getParameter("aPWD");

				// Check details against database.
				boolean exists = sittingManager.checkSittingDB(sittingId, pwd);

				if(exists) {
					// Setup session.
					HttpSession mySession = request.getSession();
					mySession.setAttribute("sittingId", sittingId);
					request.setAttribute("questions", questionManager.getQuestions());

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

}

