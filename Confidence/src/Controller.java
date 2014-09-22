

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		// TODO Auto-generated method stub
	}

}
