package com.objects.common;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.objects.DAO.CustomerData;
import com.objects.DAO.DAO_CustomerSearch;
import com.objects.DAO.ErrorData;

public class StoreDataController extends HttpServlet {

	private static final long serialVersionUID = -6994565503831902246L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		CustomerData data = populateData(request, sdf);
		
		String errors = validateUserInput(data);
		
		response.setContentType("application/json");
		Gson gson = new GsonBuilder().serializeNulls().create();			

		if (!errors.isEmpty()) {
			ErrorData errorsData = new ErrorData();
			errorsData.setErrors(errors);
			
			response.getWriter().write(gson.toJson(errorsData));
		} else {

			DAO_CustomerSearch dao = new DAO_CustomerSearch();

			dao.storreCustomerData(data);

			response.getWriter().write(gson.toJson(dao.getAddedItem()));						
		}
	}

	private CustomerData populateData(HttpServletRequest request, SimpleDateFormat sdf) {
		CustomerData data = new CustomerData();
		data.setPartyID(request.getParameter("partyID"));
		data.setNameLast(request.getParameter("nameLast"));
		data.setNameFirst(request.getParameter("nameFirst"));
		data.setNameOther(request.getParameter("nameOther"));
		data.setNameMiddle(request.getParameter("nameMiddle"));
		data.setNameOther(request.getParameter("nameOther"));
		data.setCountryName(request.getParameter("countryName"));
		data.setAddressCity(request.getParameter("addressCity"));
		data.setCitizenship(request.getParameter("citizenship"));
		data.setDocumentID(request.getParameter("documentID"));
		data.setIssueCountry(request.getParameter("issueCountry"));
		data.setAddressLine1(request.getParameter("addressLine1"));
		data.setAddressLine2(request.getParameter("addressLine2"));
		data.setStateProvince(request.getParameter("stateProvince"));
		data.setPostalCode(request.getParameter("postalCode"));
		data.setResidency(request.getParameter("residency"));
		data.setTaxID(request.getParameter("taxID"));
		data.setTypeOfID(request.getParameter("typeOfID"));
		data.setIssuedBy(request.getParameter("issuedBy"));
		data.setCompanyStockSymbol(request.getParameter("companyStockSymbol"));
		data.setParentCompany(request.getParameter("parentCompany"));
		data.setParentCompanyStock(request.getParameter("parentCompanyStock"));

		try {
			data.setDateOfBirth(sdf.parse(request.getParameter("dateOfBirth")));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
	}

	private String validateUserInput(CustomerData data) {
		StringBuilder errors = new StringBuilder();

		if (data.getNameOther() == null || data.getNameOther().trim().isEmpty()) {
			errors.append("nameOther,");
		}
		if (data.getAddressLine1() == null || data.getAddressLine1().trim().isEmpty()) {
			errors.append("addressLine1,");
		}
		if (data.getDateOfBirth() == null) {
			errors.append("dateOfBirthAdd,");
		}
		if (data.getTaxID() == null || data.getTaxID().trim().isEmpty()) {
			errors.append("taxID,");
		}

		if(errors.length() > 0){
			errors.deleteCharAt(errors.length() - 1);
		}

		return errors.toString();
	}
}
