package com.objects.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.objects.DAO.DAO_CustomerSearch;

public class RemoveDataController extends HttpServlet{

	
	private static final long serialVersionUID = -81061751127994349L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String ids = request.getParameter("ids");
		
		DAO_CustomerSearch dao = new DAO_CustomerSearch();
		
		dao.removeData(ids);
	}
}
