

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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
				} else if(toPage.equals("studentInterface")) {
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

		String aAction = request.getParameter("aAction");
		String text= request.getParameter("questionText");
		String nextPage = "studentInterface.jsp";  

		if(aAction != null){
			System.out.println(aAction);
			if(aAction.equals("postque")){
				String toPage = request.getParameter("page");
				try {
					MysqlJDBC m=new MysqlJDBC();
					try {
						String sql= "insert into questions(stu_id,forum_id,description,num_votes)  values ('1','1',\""+text+"\",0)";
						m.insert(sql);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				RequestDispatcher myRequestDispatcher = request.getRequestDispatcher("/"+nextPage);
				myRequestDispatcher.forward(request, response);  
			} else if (aAction.equals("upvote")) {
				try {
					MysqlJDBC m=new MysqlJDBC();

					String que_id = request.getParameter("que_id");
					System.out.println("upvoting!" + que_id);
					String sql= "UPDATE questions SET num_votes = num_votes + 1 WHERE que_id = " + que_id + ";";
					m.insert(sql);
					RequestDispatcher myRequestDispatcher = request.getRequestDispatcher("/"+nextPage);
					myRequestDispatcher.forward(request, response);  
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}
	}
}

