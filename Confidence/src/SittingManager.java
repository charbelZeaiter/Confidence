import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.SittingBean;

import jdbc.MysqlJDBC;


public class SittingManager {

	MysqlJDBC mysql;

	public SittingManager() throws ClassNotFoundException {
		mysql = new MysqlJDBC();
	}

	public int insertNewSitting(int aFacilitatorRecordId, String aPWD, String aName) {
		int result = -1;

		try {
			// Create sql statement and pass values in.
			String sqlQuery = "INSERT INTO sittings (facilitator_id, password, name) VALUES (?, ?, ?)";
			PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery, Statement.RETURN_GENERATED_KEYS);

			// Set query values.
			ps.setInt(1, aFacilitatorRecordId);
			ps.setString(2, aPWD);
			ps.setString(3, aName);

			// Execute query;
			result = ps.executeUpdate();
			ResultSet rset = ps.getGeneratedKeys();

			// Check if result set has rows.
			if(rset.next())
			{
				return rset.getInt(1);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	public boolean checkSittingDB(int aSittingId, String aPWD) {
		boolean result = false;

		try {
			// Create sql statement and pass values in.
			String sqlQuery = "SELECT password FROM sittings WHERE sitting_id = ?";

			PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery);

			// Set values in query.
			ps.setInt(1, aSittingId);

			// Execute query and loop through saving results.
			ResultSet rset = ps.executeQuery();

			// If next returns true it means there are records.
			if(rset.next()) {
				// Check that passwords match.
				String databasePWD = rset.getString("password");
				if(aPWD.equals(databasePWD)) {
					result = true;
				}
			}  
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}
	
	public List<SittingBean> getFacilitatorSittingsDB(int aFacilitatorId) {
		
		// Create result list.
		List<SittingBean> myResultList = new ArrayList<SittingBean>();
		
		try {
			// Create sql statement and pass values in.
			String sqlQuery = "SELECT sitting_id, name, password FROM sittings WHERE facilitator_id = ?";

			PreparedStatement ps = mysql.getConnection().prepareStatement(sqlQuery);

			// Set values in query.
			ps.setInt(1, aFacilitatorId);

			// Execute query and loop through saving results.
			ResultSet rset = ps.executeQuery();

			while(rset.next()) {
				
				int idDB = Integer.parseInt(rset.getString("sitting_id"));
				String nameDB = rset.getString("name");
				String pwdDB = rset.getString("password");
				
				// Create new bean and add to list.
				SittingBean newSittingBean = new SittingBean(idDB, nameDB, pwdDB);
				myResultList.add(newSittingBean);
			} 
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return myResultList;
	}
}
