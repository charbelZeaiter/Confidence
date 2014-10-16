import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.MysqlJDBC;


public class LoginManager {

	MysqlJDBC mysql;

	public LoginManager() throws ClassNotFoundException {
		mysql = new MysqlJDBC();
	}

	public int checkLoginDB(String aFacilitatorId, String aPWD) {
		int result = -1;

		try {
			// Create sql statement and pass values in.
			String sqlQuery = "SELECT facilitator_id FROM facilitators WHERE username = ? and password = ?";

			PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery);

			// Set values in query.
			ps.setString(1, aFacilitatorId);
			ps.setString(2, aPWD);

			// Execute query and loop through saving results.
			ResultSet rset = ps.executeQuery();

			// If next returns true it means there are records.
			if(rset.next())
			{
				return rset.getInt("facilitator_id");
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}
	
	public boolean signupDBInsert(String aFacilitatorId, String aPWD, String fname, String lname) {
		boolean success = false;
		try {
			// Create sql statement and pass values in.
			String sqlQuery = "INSERT INTO facilitators (username, password, firstname, lastname) VALUES (?, ?, ?, ?)";
			PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery);

			// Set values in query.
			ps.setString(1, aFacilitatorId);
			ps.setString(2, aPWD);
			ps.setString(3, fname);
			ps.setString(4, lname);

			// Execute query;
			int result = ps.executeUpdate();

			// Check that insert occurred.
			assert(result == 1);
			success = true;
		}
		catch (SQLException e) {
			success = false;
			e.printStackTrace();
		}
		return success;
	}
}
