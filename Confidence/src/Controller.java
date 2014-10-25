import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		String nextPage = "login.jsp";  

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
				if(toPage.equals("studentLogin")) {
					
					request.setAttribute("loginType", "studentLogin");
					nextPage = "login.jsp";
					
				} else if(toPage.equals("studentSittingInterface")) {
					
					request.setAttribute("questions", questionManager.getQuestions("", sittingId));
					nextPage = "studentSittingInterface.jsp";

				} else if(toPage.equals("home")) {

					request.setAttribute("questions", questionManager.getQuestions("", sittingId));
					nextPage = "studentSittingInterface.jsp";

				}
				
			} else if(aAction.equals("logOut")){
				
				// Clear session.
				request.getSession().invalidate();
				
			} else if(aAction.equals("studentAJAX")){
				
				ArrayList<HashMap<String, String>> questionList = questionManager.getQuestions("", sittingId);
				
				StringBuilder output = new StringBuilder();
				
				for(HashMap<String, String> item : questionList)
				{
					
					output.append(
					"<div class=\"row\">"+
						"<div class=\"panel panel-default question\">"+
							"<div class=\"panel-body\">"+
								"<table>"+
									"<tr>"+
										"<td class=\"col-md-1\">"+
											"<FORM NAME=\"form1\" METHOD=\"POST\" action=\"Controller?aAction=upvote\">"
					);
					
					output.append("<FORM NAME=\"form1\" METHOD=\"POST\" action=\"Controller?aAction=upvote\">");
					output.append("<INPUT TYPE=\"HIDDEN\" NAME=\"que_id\" VALUE=\""+item.get("id")+"\">");
					output.append("<INPUT TYPE=\"HIDDEN\" NAME=\"sorted\" VALUE=\"upvote\">");
					output.append("<input type=\"image\" src=\"images/upvote-small.png\" value=\"Upvote\" style=\"width: 40px;\" />");
					output.append("</FORM></td>");
					output.append("<td class=\"col-md-9\">[ID"+item.get("id")+"] "+item.get("description")+"</td>");
					output.append("<td class=\"col-md-2\" style=\"text-align: center;\">"+item.get("num_votes")+"</td>");
					
					output.append(	
										"</tr>"+
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
		
		if(aAction != null) {
			String session_id= request.getSession().getId();
			if(aAction.equals("postque")){
				String question = request.getParameter("questionText");
				
				if(question.isEmpty()) {
					request.setAttribute("questionError", "Question cannot be empty!");
				} else {
					questionManager.submitQuestion(question, sittingId,session_id);
				}
				
				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));
				
				nextPage = "studentSittingInterface.jsp";

			} else if (aAction.equals("upvote")) {

				String que_id = request.getParameter("que_id");
				questionManager.upvoteQuestion(que_id,session_id);
				request.setAttribute("questions", questionManager.getQuestions(sort, sittingId));

				nextPage = "studentSittingInterface.jsp";

			} else if (aAction.equals("sittingAccessRequest")) {

				String input = request.getParameter("aSittingId");
				String pwd = request.getParameter("aPWD");
				
				// Validate that fields are not empty.
				if (input.isEmpty() && pwd.isEmpty()) {	
					
					nextPage = "login.jsp"; 
					request.setAttribute("loginType", "studentLogin");
					request.setAttribute("error", "'ID' and 'Password' should not be empty");
							
				} else if(input.isEmpty()) {
					
					nextPage = "login.jsp";
					request.setAttribute("loginType", "studentLogin");
					request.setAttribute("error", "'ID' should not be empty");

				} else if(pwd.isEmpty()) {

					nextPage = "login.jsp"; 
					request.setAttribute("loginType", "studentLogin");
					request.setAttribute("error", "'Password' should not be empty");

				} else {

					sittingId = 0;
					boolean exists = false;
					String error = "Login failed - incorrect password.";
					try {
						sittingId = Integer.parseInt(input);
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

