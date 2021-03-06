import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.SittingBean;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/FacilitatorController")
public class FacilitatorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String PRIVATE_PATH = "WEB-INF/FacilitatorsPages/";

	private QuestionManager questionManager;
	private SittingManager sittingManager;
	private LoginManager loginManager;
	private SurveyManager surveyManager;

	/**
	 * @throws ClassNotFoundException 
	 * @see HttpServlet#HttpServlet()
	 */
	public FacilitatorController() throws ClassNotFoundException {
		super();
		questionManager = new QuestionManager();
		sittingManager = new SittingManager();
		loginManager = new LoginManager();
		surveyManager = new SurveyManager();
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

		if (aAction != null) {
			if(aAction.equals("navigation")) {
				// Get page to navigate to.
				String toPage = request.getParameter("page");

				// Set page to dispatch to.
				if(toPage.equals("signup")) {
					
					request.setAttribute("loginType", "facilitatorSignup");

				} else if (toPage.equals("facilitatorLogin")) {
					
					request.setAttribute("loginType", "facilitatorLogin");
					
				} else if(toPage.equals("createSitting")) {

					nextPage = this.PRIVATE_PATH+"createSitting.jsp";
					
				} else if(toPage.equals("facilitatorHome")) {
					
					int facilitatorRecordId =  (Integer) request.getSession().getAttribute("facilitatorRecId");
					
					// Set up to display all facilitators sittings for next page.
					this.setUpToDisplayAllSittings(request, facilitatorRecordId);
					
					nextPage = this.PRIVATE_PATH+"facilitatorHome.jsp";
					
				} else if(toPage.equals("facilitatorInterface")) {
										
					String sort = request.getParameter("sorted");
					request.setAttribute("sorted", sort);
					
					int sittingId = Integer.parseInt(request.getParameter("sittingId"));
					String sittingName = request.getParameter("sittingName");
					String sittingPwd = request.getParameter("qwerty");
					
					request.setAttribute("sittingId", sittingId);
					request.setAttribute("sittingName", sittingName);
					request.setAttribute("sittingPwd", sittingPwd);
					request.getSession().setAttribute("sittingId", sittingId);
					request.getSession().setAttribute("sittingName", sittingName);
					request.getSession().setAttribute("sittingPwd", sittingPwd);
					request.getSession().setAttribute("sorted", sort);
					
					request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
					
					nextPage = this.PRIVATE_PATH+"facilitatorInterface.jsp";
				}
				

			} else if(aAction.equals("logOut")){
				
				// Clear session.
				request.getSession().invalidate();
				
			} else if(aAction.equals("facilitatorAJAX")){
				
				int sittingId = (Integer) request.getSession().getAttribute("sittingId");
				String sort = (String) request.getSession().getAttribute("sorted");
				
				ArrayList<HashMap<String, String>> questionList = questionManager.getQuestions(sort, sittingId);
				
				StringBuilder output = new StringBuilder();
				
				for(HashMap<String, String> item : questionList)
				{
					output.append(
							"<div class=\"row questionPanel\">" +
								"<div class=\"panel panel-default question\">" +
									"<div class=\"panel-body\">" +
									"<table>" +
										"<tr>" +
											"<td class=\"col-md-1\">" +
												"<FORM NAME=\"form1\" METHOD=\"POST\" action=\"FacilitatorController?aAction=remove\">"
							);
					output.append("<INPUT TYPE=\"HIDDEN\" NAME=\"que_id\" VALUE=\""+item.get("id")+"\">");
					output.append("<INPUT TYPE=\"HIDDEN\" NAME=\"sorted\" VALUE=\""+sort+"\">");
					output.append("<input type=\"image\" src=\"images/tick.png\" value=\"Remove\" style=\"width: 40px;\" />");
					output.append("</FORM></td>");
					output.append("<td class=\"col-md-9\">"+item.get("description")+"</td>");
					output.append("<td class=\"col-md-2\" style=\"text-align: center;\">Votes: "+item.get("num_votes")+"</td>");
					output.append(			"</tr>"+
										"</table>"+
									"</div>"+
								"</div>"+
							"</div>"
					);
					
					
				}
				
			    response.setContentType("text/html");  // Set content type of the response so that jQuery knows what it can expect.
			    response.setCharacterEncoding("UTF-8"); 
			    response.getWriter().write(output.toString());  // Write response body.
			    
			    return;
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
		 * Need to protect against multiple posts on refresh and back actions.
		 */

		String aAction = request.getParameter("aAction");

		String nextPage = "facilitatorLogin.jsp";
		String sort = request.getParameter("sorted");
		request.setAttribute("sorted", sort);
		String canPost = request.getParameter("canPost");
		request.setAttribute("canPost", canPost);

		System.out.println(aAction);
		
		HttpSession mySession = request.getSession();
		
		Object sittingIdString = mySession.getAttribute("sittingId");
		int sittingId = 0;
		
		if (sittingIdString != null) {
			sittingId = (Integer) mySession.getAttribute("sittingId");	
		}
		
		if(aAction != null)	{
			if(aAction.equals("signupRequest")) {

				// Get form fields.
				String facilitatorId = request.getParameter("aFacilitatorId");
				String pwd = request.getParameter("aPWD");
				String fname = request.getParameter("fname");
				String lname = request.getParameter("lname");
				nextPage = "login.jsp";
				
				// Validate that fields are not empty.
				if (facilitatorId.isEmpty()) {
					
					request.setAttribute("loginType", "facilitatorSignup");
					request.setAttribute("error", "'Username' should not be empty");
							
				} else if (pwd.isEmpty()) {
					
					request.setAttribute("loginType", "facilitatorSignup");
					request.setAttribute("error", "'Password' should not be empty");
					
				} else if (fname.isEmpty()) {
					
					request.setAttribute("loginType", "facilitatorSignup");
					request.setAttribute("error", "'First Name' should not be empty");
					
				} else if (lname.isEmpty()) {
					
					request.setAttribute("loginType", "facilitatorSignup");
					request.setAttribute("error", "'Last Name' should not be empty");
					
				} else {
					
					if (!facilitatorId.matches("[A-Za-z0-9]+") || !pwd.matches("[A-Za-z0-9]+") || !fname.matches("[A-Za-z0-9]+") || !lname.matches("[A-Za-z0-9]+")) {
						
						request.setAttribute("error", "Only alphanumeric characters permitted.");
						request.setAttribute("loginType", "facilitatorSignup");

					} else {
						
						if (pwd.length() < 8) {
							
							request.setAttribute("error", "Password should be at least 8 characters long.");
							request.setAttribute("loginType", "facilitatorSignup");
							
						} else {
						
							// Insert entry into database and get resultString.
							String resultString = loginManager.signupDBInsert(facilitatorId, pwd, fname, lname);
							
							if (resultString.equals("SUCCESS")) {
								
								// Proceed to facilitator login.
								request.setAttribute("message", "Sign up successful! Please log in.");
								request.setAttribute("loginType", "facilitatorLogin");
								
							} else {
								
								request.setAttribute("error", resultString);
								request.setAttribute("loginType", "facilitatorSignup");
								
							}

						}
					}
					
				}
				
			} else if(aAction.equals("loginRequest")) {

				// Get form fields.
				String facilitatorId = request.getParameter("aFacilitatorId");
				String pwd = request.getParameter("aPWD");

				System.out.println("ID: " + facilitatorId + " pwd: " + pwd);
				
				// Validate that fields are not empty.
				if (facilitatorId.isEmpty() && pwd.isEmpty()) {	
					
					nextPage = "login.jsp"; 
					request.setAttribute("loginType", "facilitatorLogin");
					request.setAttribute("error", "'Username' and 'Password' should not be empty");
							
				} else if(facilitatorId.isEmpty()) {
					
					nextPage = "login.jsp";
					request.setAttribute("loginType", "facilitatorLogin");
					request.setAttribute("error", "'Username' should not be empty");
							
				} else if(pwd.isEmpty()) {
					
					nextPage = "login.jsp"; 
					request.setAttribute("loginType", "facilitatorLogin");
					request.setAttribute("error", "'Password' should not be empty");
					
				} else {
				
					// Check login details in database and return record Id.
					int facilitatorRecId = loginManager.checkLoginDB(facilitatorId, pwd);
	
					if (facilitatorRecId > 0) {
	
						// Setup session.
						mySession.setAttribute("facilitatorRecId", facilitatorRecId);
						request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
						
						// Set up to display all facilitators sittings for next page.
						this.setUpToDisplayAllSittings(request, facilitatorRecId);
						
						// Proceed to facilitator login.
						nextPage = PRIVATE_PATH+"facilitatorHome.jsp";
	
					} else if (facilitatorRecId == 0) {
						
						// Invalid username
						request.setAttribute("error", "Invalid username.");
						request.setAttribute("loginType", "facilitatorLogin");
						nextPage = "login.jsp";
						
					} else {

						// Failed login.
						request.setAttribute("error", "Login failed - incorrect password.");
						request.setAttribute("loginType", "facilitatorLogin");
						nextPage = "login.jsp";
						
					}
				}

			} else if (aAction.equals("createSittingRequest")) {

				String pwd = request.getParameter("aPWD");
				String name = request.getParameter("aName");
				// Default (for errors)
				nextPage = PRIVATE_PATH+"createSitting.jsp";
				
				// Validate that fields are not empty.
				if (name.isEmpty() && pwd.isEmpty()) {
					
					request.setAttribute("formError", "'Sitting Name' and 'Password' should not be empty");
							
				} else if(name.isEmpty()) {
					
					request.setAttribute("formError", "'Sitting Name' should not be empty");
							
				} else if(pwd.isEmpty()) {
					
					request.setAttribute("formError", "'Password' should not be empty");
					
				} else if (!pwd.matches("[A-Za-z0-9]+")) {
						
					request.setAttribute("error", "Only alphanumeric characters permitted for the password.");
				
				} else if (pwd.length() < 4) {
						
					request.setAttribute("error", "Password should be at least 4 characters long.");
						
				} else {

					int facilitatorRecordId =  (Integer) request.getSession().getAttribute("facilitatorRecId");

					// Insert sitting into database.
					int newId = sittingManager.insertNewSitting(facilitatorRecordId, pwd, name);
					surveyManager.insertNewSitting(facilitatorRecordId, newId);
					
					if (newId > -1) {
						
						// Set up to display all facilitators sittings for next page.
						this.setUpToDisplayAllSittings(request, facilitatorRecordId);

						request.setAttribute("message", "New sitting successfully created! (ID = " + newId + ")");
						
						nextPage = PRIVATE_PATH+"facilitatorHome.jsp";
						
					} else {
						
						request.setAttribute("error", "Error encountered when creating session. Please try again.");
						
					}

				}

			} else if (aAction.equals("refresh")) {

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
				request.getSession().setAttribute("sorted", sort);
				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
				request.setAttribute("sittingId", sittingId);
				request.setAttribute("accessPWD", pwd);
				
				nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";

			} else if (aAction.equals("closeSitting")) {
				
				int facilitatorRecordId =  (Integer) request.getSession().getAttribute("facilitatorRecId");
				int sittingID = Integer.parseInt(request.getParameter("sittingId"));
				sittingManager.closeSitting(sittingID);
				
				this.setUpToDisplayAllSittings(request, facilitatorRecordId);
				nextPage = PRIVATE_PATH+"facilitatorHome.jsp";

			}  else if (aAction.equals("canPost")) {
				
                String pwd = request.getParameter("aPWD");
				
				canPost = request.getParameter("canPost");
				
				if (canPost.equals("open")) {
					sittingManager.setSittingCanPost(sittingId, "T");
				} else if (canPost.equals("close")) {
					sittingManager.setSittingCanPost(sittingId, "F");
				}
				
				request.setAttribute("canPost", canPost);
				request.getSession().setAttribute("canPost", canPost);
				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
				request.setAttribute("sittingId", sittingId);
				request.setAttribute("accessPWD", pwd);
				
				nextPage = PRIVATE_PATH+"facilitatorInterface.jsp";
				
			} 

		}

		RequestDispatcher myRequestDispatcher = request.getRequestDispatcher("/"+nextPage);
		myRequestDispatcher.forward(request, response);
	}
	
	private void setUpToDisplayAllSittings(HttpServletRequest request, int facilitatorRecId) {
		// Get any existing sittings from db.
		List<SittingBean> sittingList = sittingManager.getFacilitatorSittingsDB(facilitatorRecId); 
		request.setAttribute("sittingListSize", sittingList.size());
		request.setAttribute("sittingList", sittingList);
	}
}
