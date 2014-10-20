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
@WebServlet("/FacilitatorController")
public class FacilitatorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String PRIVATE_PATH = "WEB-INF/FacilitatorsPages/";

	private QuestionManager questionManager;
	private SittingManager sittingManager;
	private LoginManager loginManager;

	/**
	 * @throws ClassNotFoundException 
	 * @see HttpServlet#HttpServlet()
	 */
	public FacilitatorController() throws ClassNotFoundException {
		super();
		questionManager = new QuestionManager();
		sittingManager = new SittingManager();
		loginManager = new LoginManager();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/*
		 * TODO: 
		 * 1. Need to add security checks when accessing pages after login. 
		 */

		// Get 'action' parameter from URL.
		String aAction = request.getParameter("aAction");

		// Set default landing page.
		String nextPage = "login.jsp";  

		if(aAction != null){
			if(aAction.equals("navigation"))
			{
				// Get page to navigate to.
				String toPage = request.getParameter("page");

				// Set page to dispatch to.
				if(toPage.equals("signup")) {
					
					request.setAttribute("loginType", "facilitatorSignup");

				} else if (toPage.equals("facilitatorLogin")) {
					
					request.setAttribute("loginType", "facilitatorLogin");
					
				} else if(toPage.equals("createSitting")) {

					nextPage = this.PRIVATE_PATH+"createSitting.jsp";
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
		 * 1. Need to protect against multiple posts on refresh and back actions.
		 * 2. Need to validate form data.		 
		 */

		String aAction = request.getParameter("aAction");

		String nextPage = "facilitatorLogin.jsp";
		String sort = request.getParameter("sorted");
		request.setAttribute("sorted", sort);

		System.out.println(aAction);
		
		HttpSession mySession = request.getSession();
		
		Object sittingIdString = mySession.getAttribute("sittingId");
		int sittingId = 0;
		
		if (sittingIdString != null) {
			sittingId = (Integer) mySession.getAttribute("sittingId");	
		}
		
		if(aAction != null)
		{
			if(aAction.equals("signupRequest")){

				// Get form fields.
				String facilitatorId = request.getParameter("aFacilitatorId");
				String pwd = request.getParameter("aPWD");

				// Insert entry into database.
				if (loginManager.signupDBInsert(facilitatorId, pwd)) {
					// Proceed to facilitator login.
					request.setAttribute("loginType", "facilitatorLogin");
					nextPage = "login.jsp";
				} else {
					request.setAttribute("error", "Sign up failed!");
					request.setAttribute("loginType", "facilitatorSignup");
					nextPage = "login.jsp";
				}

			} else if(aAction.equals("loginRequest")) {

				// Get form fields.
				String facilitatorId = request.getParameter("aFacilitatorId");
				String pwd = request.getParameter("aPWD");

				// Check login details in database and return record Id.
				int facilitatorRecId = loginManager.checkLoginDB(facilitatorId, pwd);

				if (facilitatorRecId > -1) {

					// Setup session.
					mySession.setAttribute("facilitatorRecId", facilitatorRecId);
					request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));

					// Proceed to facilitator login.
					nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";

				} else {

					// Failed login.
					request.setAttribute("error", "Login failed!");
					request.setAttribute("loginType", "facilitatorLogin");
					nextPage = "login.jsp";

				} 

			} else if (aAction.equals("createSittingRequest")) {

				String pwd = request.getParameter("aPWD");
				int facilitatorRecordId =  (Integer) request.getSession().getAttribute("facilitatorRecId");

				// Insert sitting into database.
				sittingId = sittingManager.insertNewSitting(facilitatorRecordId, pwd);

				request.setAttribute("sittingId", sittingId);
				request.setAttribute("accessPWD", pwd);

				nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";

			}  else if (aAction.equals("refresh")) {

				// TODO: CHECK IF THESE PARAMETERS EXIST FIRST, OTHERWISE THIS FAILS WHEN NO SITTING HAS BEEN CREATED YET				
				
				String pwd = request.getParameter("aPWD");

				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
				request.setAttribute("sittingId", sittingId);
				request.setAttribute("accessPWD", pwd);

				nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";

			} else if (aAction.equals("remove")) {
				
				String pwd = request.getParameter("aPWD");
				
				String que_id = request.getParameter("que_id");
				questionManager.removeQuestion(que_id);
				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
				
				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
				request.setAttribute("sittingId", sittingId);
				request.setAttribute("accessPWD", pwd);
				
				nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";

			} else if (aAction.equals("sort")) {
				
				String pwd = request.getParameter("aPWD");
				
				sort = request.getParameter("sortby");
				request.setAttribute("sorted", sort);
				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
				request.setAttribute("sittingId", sittingId);
				request.setAttribute("accessPWD", pwd);
				
				nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";

			} 

		}

		RequestDispatcher myRequestDispatcher = request.getRequestDispatcher("/"+nextPage);
		myRequestDispatcher.forward(request, response);
	}
}

