package com.objects.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
//import java.util.TreeMap;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
//import com.objects.common.LoadProperties;
//import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.objects.DAO.DAO_CustomerSearch;
import com.objects.beans.LookUpCodes;

/**
 * Servlet implementation class CentralControl
 */
public class CustomerSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String requestorName = "";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CustomerSearchController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		logMessage(ConstantsVariables.DEBUG_INFO + "->" + this.getClass()
				+ Thread.currentThread().getStackTrace()[1].getMethodName() + " - Entering");

		// CommonFunction oCommonFunction = new CommonFunction();
		HashMap<String, Object> hmParameters = new HashMap<String, Object>();
		HashMap<String, Object> hmUserInputs = new HashMap<String, Object>();
		DAO_CustomerSearch oCustomerSearch = new DAO_CustomerSearch();
		// Map<String, String> mLookUpCodes = null;
		// Map<String, Object> mLookUpObject = null;
		Vector<HashMap<String, String>> vData = new Vector<HashMap<String, String>>();
		// String requestor = "";
		// String keyValue = "";
		// String keyName = "";
		HttpSession APPSession;
		JsonObject oJSON = new JsonObject();
		JsonArray oaJSON = new JsonArray();
		Set<String> oSetObject;
		Iterator<String> oIterator;
		java.util.List<LookUpCodes> oList = new ArrayList<LookUpCodes>();
		LookUpCodes oLookUpCodes = new LookUpCodes();
		String returnValue = "";
		String controlName = "";
//		String requestorName = "";
		HashMap<String, String> screenData = new HashMap<String, String>();

		APPSession = request.getSession(true);

		hmUserInputs = retrieveDataFromScreen(hmParameters, APPSession, request);
		if (hmUserInputs.containsKey("CustomerSearch")) {
			screenData = (HashMap<String, String>) hmUserInputs.get("CustomerSearch");
		}
		
		if(screenData.isEmpty()){
			requestorName = "";
		}

		if (requestorName.trim().equalsIgnoreCase("CustomerSearch")) {
			vData = oCustomerSearch.searchParty(screenData.get("dateOfIncorporation"), screenData.get("businessName"));
			Gson gson = new GsonBuilder().serializeNulls().create();
			returnValue = gson.toJson(vData);
			
			response.setContentType("application/json");
			response.getWriter().write(returnValue);
			
			return;
		} else if (requestorName.trim().equalsIgnoreCase("AddCustomer")) {
			hmUserInputs = validateUserInput(hmUserInputs);
			// Contractor to develop code to convert HashMap to JSON object
		}

//		response.setContentType("application/json");
//		response.getWriter().write(returnValue);

		logMessage(ConstantsVariables.DEBUG_INFO + "->" + this.getClass()
				+ Thread.currentThread().getStackTrace()[1].getMethodName() + " - Leaving");
		
		request.getRequestDispatcher("/CustomerSearch.jsp").forward(request, response);
	}

	private HashMap<String, Object> validateUserInput(HashMap<String, Object> hmUserInputs) {
		logMessage(ConstantsVariables.DEBUG_INFO + "->" + this.getClass()
				+ Thread.currentThread().getStackTrace()[1].getMethodName() + " - Entering");
		HashMap<String, String> screenData = new HashMap<String, String>();
		Set sObject = null;
		Iterator itObject = null;
		String keyValue = "";
		if (hmUserInputs.containsKey("CustomerSearch")) {
			screenData = (HashMap<String, String>) hmUserInputs.get("CustomerSearch");
			sObject = screenData.keySet();
			itObject = sObject.iterator();
			while (itObject.hasNext()) {
				keyValue = (String) itObject.next();
				if (null == screenData.get(keyValue) || screenData.get(keyValue).trim().equalsIgnoreCase("")) {
					screenData.put(keyValue + "-Error", "Yes");
				}
			}
		}
		logMessage(ConstantsVariables.DEBUG_INFO + "->" + this.getClass()
				+ Thread.currentThread().getStackTrace()[1].getMethodName() + " - Leaving");
		return hmUserInputs;
	}

	@SuppressWarnings("unchecked")
	private HashMap<String, Object> retrieveDataFromScreen(HashMap<String, Object> hmParameters, HttpSession APPSession,
			HttpServletRequest request) {
		logMessage(ConstantsVariables.DEBUG_INFO + "->" + this.getClass()
				+ Thread.currentThread().getStackTrace()[1].getMethodName() + " - Entering");
		
		HashMap<String, Object> hmUserInputs = new HashMap<String, Object>();
		HashMap<String, Object> hmTempData = new HashMap<String, Object>();
		HashMap<String, Object> hmSystemInputs = new HashMap<String, Object>();
		String sParameterName = "";
		String sParameterValue = "";
		//String requestorName = "";
		hmUserInputs = (HashMap<String, Object>) APPSession.getAttribute(ConstantsVariables.USERINPUT);
		if(hmUserInputs == null){
			hmUserInputs = new HashMap<>();
		}
		Enumeration<String> enRequestParameters = request.getParameterNames();
		hmUserInputs.remove("CustomerSearch");
		while (enRequestParameters.hasMoreElements()) {
			sParameterName = enRequestParameters.nextElement();
			sParameterValue = checkForNull(request.getParameter(sParameterName));
			hmSystemInputs.put(sParameterName, sParameterValue);
		}
		hmUserInputs.put("CustomerSearch", hmSystemInputs);
		requestorName = "CustomerSearch";

		APPSession.setAttribute(ConstantsVariables.USERINPUT, hmUserInputs);
		logMessage(ConstantsVariables.DEBUG_INFO + "->" + this.getClass()
				+ Thread.currentThread().getStackTrace()[1].getMethodName() + " - Leaving");
		return hmUserInputs;
	}

	private String checkForNull(String sParameterValue) {
		if (null == sParameterValue) {
			// sParameterValue = "";
		}
		return sParameterValue;
	}

	public void logMessage(String sMessage) {
		// String sLOG_MODE = LoadProperties.getPropertyValue("LOG_MODE");
		String sLOG_MODE = "";
		if (sLOG_MODE.equalsIgnoreCase(ConstantsVariables.DEBUG_DETAILS)
				&& (sMessage.startsWith("**DEBUG") || sMessage.startsWith("INFO"))) {
			System.out.println("** " + sMessage);
		} else if (sLOG_MODE.equalsIgnoreCase(ConstantsVariables.DEBUG_ERROR) && sMessage.startsWith("ERROR")) {
			System.out.println("** " + sMessage);
		} else if (sLOG_MODE.equalsIgnoreCase(ConstantsVariables.SETUP_INFO)
				&& (sMessage.startsWith("SETUP") || sMessage.startsWith(ConstantsVariables.DEBUG_INFO))) {
			System.out.println("** " + sMessage);
		}
		return;
	}
}
