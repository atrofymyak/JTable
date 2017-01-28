package com.objects.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Properties;
import java.util.Vector;

//import com.objects.common.LoadProperties;

public class DAO_CustomerSearch {

	public final String EXPECTEDDELIMETER = ",";
	private static ResultSet rs = null;
	private static PreparedStatement psSelect;
	public static Vector<HashMap<String, String>> vAvailableParties = new Vector<HashMap<String, String>>();

	public DAO_CustomerSearch() {
		super();
	}
	
	public Vector<HashMap<String, String>> processItems(String ids) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException ex) {
			System.out.println("Error: unable to load driver class!");
			System.exit(1);
		}

		// logMessage("DEBUG::" + this.getClass() + "::getAvailableProducts" +
		// "::Entering");
		Connection dbConn = null;
		if(!ids.isEmpty()){
			ids = ids.trim();								
			
			ids = ids.substring(0, ids.lastIndexOf(',') );	
		}
		String sSQL = "SELECT * FROM customerinformation WHERE uniqueID IN (" + ids +")";
		String sSortOrder = "";
		boolean bReturnCode = false;
		try {
			// Contractor to use his/her DB connection here
			// dbConn =
			// getConnection(LoadProperties.getPropertyValue("Vishakha_User.DB.URL"),
			// LoadProperties.getPropertyValue("Vishakha_User.DB.UserID"),
			// LoadProperties.getPropertyValue("Vishakha_User.DB.Password"),
			// LoadProperties.getPropertyValue("Vishakha_User.DB.Driver"));
			Properties connectionProps = new Properties();
			connectionProps.put("user", "root");
			connectionProps.put("password", "1");
			dbConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/realbank_user", connectionProps);
			bReturnCode = retrieveData(sSQL, dbConn, sSortOrder);
			if (null != dbConn) {
				dbConn.close();
			}
		} catch (Exception e) {
			// logMessage("ERROR::" + this.getClass() + "::getCaseDetail" +
			// e.toString());
		}
		// logMessage("DEBUG::" + this.getClass() + "::getAvailableProducts" +
		// "::Leaving");
		return vAvailableParties;
	} 

	
	public boolean removeData(String ids){
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException ex) {
			System.out.println("Error: unable to load driver class!");
			System.exit(1);
		}
		
		Properties connectionProps = new Properties();
		connectionProps.put("user", "root");
		connectionProps.put("password", "1");
		
		try {
			Connection dbConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/realbank_user", connectionProps);
			
			if(!ids.isEmpty()){
				ids = ids.trim();								
				
				ids = ids.substring(0, ids.lastIndexOf(',') );								
				
				String queryStr = "DELETE FROM customerinformation WHERE uniqueID IN (" + ids +")"; 
				
				Statement stmt = dbConn.createStatement();
				stmt.executeUpdate(queryStr);
				
				dbConn.close();
			}
			
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}

	public boolean storreCustomerData(CustomerData data) {

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException ex) {
			System.out.println("Error: unable to load driver class!");
			System.exit(1);
		}
		
		Properties connectionProps = new Properties();
		connectionProps.put("user", "root");
		connectionProps.put("password", "1");
		try {
			Connection dbConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/realbank_user", connectionProps);
			
			
			String insertTableSQL = "INSERT INTO customerinformation"
					+ "(uniqueID,partyID,nameLast,nameFirst,nameMiddle,nameOther,dateOfBirth,countryName,addressLine1,addressLine2,addressCity,stateProvince,postalCode,citizenship,residency,taxID,"+
					"documentID,typeOfID,issuedBy,issueCountry,companyStockSymbol,parentCompany,parentCompanyStock) VALUES"
					+ "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			PreparedStatement preparedStatement = dbConn.prepareStatement(insertTableSQL);
			
			Statement stmt = dbConn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT uniqueID from customerinformation order by uniqueID desc limit 1;");
			
			int autoIncKeyFromFunc = 1;
			
			if (rs.next()) {
		        autoIncKeyFromFunc = rs.getInt(1);
		    }
			
			//rs.getInt(1);
//			stmt.executeUpdate(
//		            "INSERT INTO autoIncTutorial (dataField) "
//		            + "values (" + autoIncKeyFromFunc + 1 + ")");
			
			
			preparedStatement.setInt(1, ++autoIncKeyFromFunc);
			preparedStatement.setString(2, data.getPartyID());
			preparedStatement.setString(3, data.getNameLast());
			preparedStatement.setString(4, data.getNameFirst());
			preparedStatement.setString(5, data.getNameMiddle());
			preparedStatement.setString(6, data.getNameOther());			
			java.sql.Timestamp timestamp = new java.sql.Timestamp(data.getDateOfBirth().getTime());
			preparedStatement.setTimestamp(7, timestamp);
			preparedStatement.setString(8, data.getCountryName());
			preparedStatement.setString(9, data.getAddressLine1());
			preparedStatement.setString(10, data.getAddressLine2());
			preparedStatement.setString(11, data.getAddressCity());
			preparedStatement.setString(12, data.getStateProvince());
			preparedStatement.setString(13, data.getPostalCode());
			preparedStatement.setString(14, data.getCitizenship());
			preparedStatement.setString(15, data.getResidency());
			preparedStatement.setString(16, data.getTaxID());
			preparedStatement.setString(17, data.getTypeOfID());
			preparedStatement.setString(18, data.getDocumentID());
			preparedStatement.setString(19, data.getIssuedBy());
			preparedStatement.setString(20, data.getIssueCountry());
			preparedStatement.setString(21, data.getCompanyStockSymbol());
			preparedStatement.setString(22, data.getParentCompany());
			preparedStatement.setString(23, data.getParentCompanyStock());
			// execute insert SQL stetement
			preparedStatement .executeUpdate();
			
			dbConn.close();
			
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}

	public PreparedStatement buildPreparedStatement(String sSQL, Connection dbConn) {
		// logMessage("DEBUG::" + this.getClass() + "::buildPreparedStatement" +
		// "::Entering");
		try {
			psSelect = dbConn.prepareStatement(sSQL);
			// logMessage("DEBUG::" + this.getClass() +
			// "::buildPreparedStatement" + "::Leaving");
			return psSelect;
		} catch (SQLException e) {
			// logMessage("ERROR::" + this.getClass() +
			// "::buildPreparedStatement" + sSQL + " :: " + e.toString());
			return null;
		} catch (Exception e) {
			// logMessage("ERROR::" + this.getClass() +
			// "::buildPreparedStatement" + sSQL + " :: " + e.toString());
			return null;
		}
	}

	public boolean retrieveData(String sSQL, Connection dbConn, String sSortOrder) {
		// logMessage("DEBUG::" + this.getClass() + "::retrieveData" +
		// "::Entering");
		PreparedStatement psSelect = buildPreparedStatement(sSQL, dbConn);
		HashMap<String, String> hmParty = new HashMap<String, String>();
		boolean bReturnCode = true;
		ResultSetMetaData rsmdObject;
		vAvailableParties.clear();
		if (psSelect != null) {
			try {
				rs = psSelect.executeQuery();
				if (rs != null) {
					rsmdObject = rs.getMetaData();
					while (rs.next()) {
						hmParty = new HashMap<String, String>();
						for (int iPos = 1; iPos < rsmdObject.getColumnCount(); iPos++) {
							hmParty.put(rsmdObject.getColumnName(iPos), rs.getString(iPos));
						}
						vAvailableParties.addElement(hmParty);
					}
				}
			} catch (SQLException e) {
				rs = null;
				// logMessage("ERROR::" + this.getClass() + "::retrieveData" +
				// sSQL + " :: " + e.toString());
				bReturnCode = false;
			} catch (Exception e) {
				rs = null;
				// logMessage("ERROR::" + this.getClass() + "::retrieveData" +
				// sSQL + " :: " + e.toString());
				bReturnCode = false;
			}
		}
		// logMessage("DEBUG::" + this.getClass() + "::retrieveData" +
		// "::Leaving");
		return bReturnCode;
	}
	
	public Vector<HashMap<String, String>> getAddedItem() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException ex) {
			System.out.println("Error: unable to load driver class!");
			System.exit(1);
		}

		// logMessage("DEBUG::" + this.getClass() + "::getAvailableProducts" +
		// "::Entering");
		Connection dbConn = null;
		String sSQL = "SELECT * from customerinformation order by uniqueID desc limit 1";
		String sSortOrder = "";
		boolean bReturnCode = false;
		try {
			// Contractor to use his/her DB connection here
			// dbConn =
			// getConnection(LoadProperties.getPropertyValue("Vishakha_User.DB.URL"),
			// LoadProperties.getPropertyValue("Vishakha_User.DB.UserID"),
			// LoadProperties.getPropertyValue("Vishakha_User.DB.Password"),
			// LoadProperties.getPropertyValue("Vishakha_User.DB.Driver"));
			Properties connectionProps = new Properties();
			connectionProps.put("user", "root");
			connectionProps.put("password", "1");
			dbConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/realbank_user", connectionProps);
			bReturnCode = retrieveData(sSQL, dbConn, sSortOrder);
			if (null != dbConn) {
				dbConn.close();
			}
		} catch (Exception e) {
			// logMessage("ERROR::" + this.getClass() + "::getCaseDetail" +
			// e.toString());
		}
		// logMessage("DEBUG::" + this.getClass() + "::getAvailableProducts" +
		// "::Leaving");
		return vAvailableParties;
	} 

	public Vector<HashMap<String, String>> searchParty(String dateOfBirth, String customerName) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException ex) {
			System.out.println("Error: unable to load driver class!");
			System.exit(1);
		}

		// logMessage("DEBUG::" + this.getClass() + "::getAvailableProducts" +
		// "::Entering");
		Connection dbConn = null;
		String sSQL = "SELECT * FROM realbank_user.customerinformation WHERE dateOfBirth = '" + dateOfBirth
				+ "' AND nameOther like '" + customerName + "%' ORDER BY nameOther ";
		String sSortOrder = "";
		boolean bReturnCode = false;
		try {
			// Contractor to use his/her DB connection here
			// dbConn =
			// getConnection(LoadProperties.getPropertyValue("Vishakha_User.DB.URL"),
			// LoadProperties.getPropertyValue("Vishakha_User.DB.UserID"),
			// LoadProperties.getPropertyValue("Vishakha_User.DB.Password"),
			// LoadProperties.getPropertyValue("Vishakha_User.DB.Driver"));
			Properties connectionProps = new Properties();
			connectionProps.put("user", "root");
			connectionProps.put("password", "1");
			dbConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/realbank_user", connectionProps);
			bReturnCode = retrieveData(sSQL, dbConn, sSortOrder);
			if (null != dbConn) {
				dbConn.close();
			}
		} catch (Exception e) {
			// logMessage("ERROR::" + this.getClass() + "::getCaseDetail" +
			// e.toString());
		}
		// logMessage("DEBUG::" + this.getClass() + "::getAvailableProducts" +
		// "::Leaving");
		return vAvailableParties;
	}

}
