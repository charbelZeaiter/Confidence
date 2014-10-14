

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
public class FacilitatorContoller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String PRIVATE_PATH = "WEB-INF/FacilitatorsPages/";

	private QuestionManager questionManager;
	private SittingManager sittingManager;
	private LoginManager loginManager;

	/**
	 * @throws ClassNotFoundException 
	 * @see HttpServlet#HttpServlet()
	 */
	public FacilitatorContoller() throws ClassNotFoundException {
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
		String nextPage = "facilitatorLogin.jsp";  

		if(aAction != null){
			if(aAction.equals("navigation"))
			{
				// Get page to navigate to.
				String toPage = request.getParameter("page");

				// Set page to dispatch to.
				if(toPage.equals("signup"))
				{
					nextPage = this.PRIVATE_PATH+"facilitatorSignup.jsp";	

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

		if(aAction != null)
		{
			if(aAction.equals("signupRequest")){

				// Get form fields.
				String facilitatorId = request.getParameter("aFacilitatorId");
				String pwd = request.getParameter("aPWD");

				// Insert entry into database.
				this.signupDBInsert(facilitatorId, pwd);

				// Proceed to facilitator login.
				nextPage = "facilitatorLogin.jsp";

			} else if(aAction.equals("loginRequest")) {

				// Get form fields.
				String facilitatorId = request.getParameter("aFacilitatorId");
				String pwd = request.getParameter("aPWD");

				// Check login details in database and return record Id.
				int facilitatorRecId = loginManager.checkLoginDB(facilitatorId, pwd);

				if(facilitatorRecId > -1) {

					// Setup session.
					HttpSession mySession = request.getSession();
					mySession.setAttribute("facilitatorRecId", facilitatorRecId);
					request.setAttribute("questions", questionManager.getQuestions(sort));

					// Proceed to facilitator login.
					nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";

				} else {

					// Failed login.
					request.setAttribute("loginFailed", 1);
				} 

			} else if (aAction.equals("createSittingRequest")) {

				String pwd = request.getParameter("aPWD");
				int facilitatorRecordId =  (Integer) request.getSession().getAttribute("facilitatorRecId");

				// Insert sitting into database.
				int sittingId = sittingManager.insertNewSitting(facilitatorRecordId, pwd);

				request.setAttribute("sittingId", sittingId);
				request.setAttribute("accessPWD", pwd);

				nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";
			}  else if (aAction.equals("refresh")) {
				String sittingId = request.getParameter("sittingId");
				String pwd = request.getParameter("aPWD");

				// Insert sitting into database.

				request.setAttribute("questions", questionManager.getQuestions(sort));
				request.setAttribute("sittingId", sittingId);
				request.setAttribute("accessPWD", pwd);

				nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";
			} else if (aAction.equals("remove")) {
				
				String sittingId = request.getParameter("sittingId");
				String pwd = request.getParameter("aPWD");
				
				String que_id = request.getParameter("que_id");
				questionManager.removeQuestion(que_id);
				request.setAttribute("questions", questionManager.getQuestions(sort));
				
				request.setAttribute("questions", questionManager.getQuestions(sort));
				request.setAttribute("sittingId", sittingId);
				request.setAttribute("accessPWD", pwd);
				
				nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";
			} else if (aAction.equals("sort")) {
				
				String sittingId = request.getParameter("sittingId");
				String pwd = request.getParameter("aPWD");
				
				sort = request.getParameter("sortby");
				request.setAttribute("sorted", sort);
				request.setAttribute("questions", questionManager.getQuestions(sort));
				request.setAttribute("sittingId", sittingId);
				request.setAttribute("accessPWD", pwd);
				
				nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";

			} 

		}

		RequestDispatcher myRequestDispatcher = request.getRequestDispatcher("/"+nextPage);
		myRequestDispatcher.forward(request, response);
	}


	private void signupDBInsert(String aFacilitatorId, String aPWD) {

		try {

			MysqlJDBC m = new MysqlJDBC();

			// Create sql statement and pass values in.
			String sqlQuery = "INSERT INTO facilitators (username, password) VALUES (?, ?)";
			PreparedStatement ps = m.getConnection().prepareStatement(sqlQuery);

			// Set values in query.
			ps.setString(1, aFacilitatorId);
			ps.setString(2, aPWD);

			// Execute query;
			int result = ps.executeUpdate();

			// Check that insert occurred.
			assert(result == 1);

		}
		catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}



}

