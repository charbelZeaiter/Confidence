import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

import jdbc.MysqlJDBC;

public class LoginManager {

	MysqlJDBC mysql;

	public LoginManager() throws ClassNotFoundException {
		mysql = new MysqlJDBC();
	}

	public int checkLoginDB(String aFacilitatorId, String aPWD) {
		int result = -1;
		
		// First check whether the username exists
		try {
			// Create sql statement and pass values in.
			String sqlQuery = "SELECT facilitator_id FROM facilitators WHERE username = ?";
			PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery);

			// Set values in query.
			ps.setString(1, aFacilitatorId);

			// Execute query and loop through saving results.
			ResultSet rs = ps.executeQuery();
			if (!rs.next()) {
				return 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// Now check the username/password combination
		try {
			// Create sql statement and pass values in.
			String sqlQuery = "SELECT facilitator_id FROM facilitators WHERE username = ? and password = ?";
			PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery);

			// Set values in query.
			ps.setString(1, aFacilitatorId);
			ps.setString(2, aPWD);

			// Execute query and loop through saving results.
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt("facilitator_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}
	
	public String signupDBInsert(String aFacilitatorId, String aPWD) {
		String resultString = null;
		try {
			// Create sql statement and pass values in.
			String sqlQuery = "INSERT INTO facilitators (username, password) VALUES (?, ?)";
			PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery);

			// Set values in query.
			ps.setString(1, aFacilitatorId);
			ps.setString(2, aPWD);

			// Execute query;
			int result = ps.executeUpdate();

			// Check that insert occurred.
			assert(result == 1);
			resultString = "SUCCESS";
		} catch (MySQLIntegrityConstraintViolationException e) {
			if (e.getErrorCode() == 1062) {
				resultString = "That username has already been taken.";
			}
		} catch (SQLException e) {
			resultString = "Sign up failed. Please try again.";
			e.printStackTrace();
		}
		return resultString;
	}
}
