	package jdbc;
	import java.sql.*;


public class MysqlJDBC {



	// JDBC driver name and database URL
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	static final String DB_URL = "jdbc:mysql://localhost/teddy";

	//  Database credentials
    static final String USER = "root";
    Connection conn = null;
   
    public MysqlJDBC() throws ClassNotFoundException{
 
    	try{
    		// Register JDBC driver
    		Class.forName("com.mysql.jdbc.Driver");

    		// Open a connection
		   conn = DriverManager.getConnection(DB_URL, USER,null);
		}catch(SQLException se){
			se.printStackTrace();
		}
		      
	} 

		   	
    public void insert(String sql) throws SQLException{
			     
    	Statement stmt = conn.createStatement();

    	stmt.executeUpdate(sql);

  	}

		      
		      


		}//end JDBCExample

