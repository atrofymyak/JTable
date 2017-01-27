package com.objects.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.internal.LinkedTreeMap;

public class ProcessDataController extends HttpServlet {

	private static final long serialVersionUID = 1204140343352039617L;

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		List<LinkedTreeMap<String, String>> list = new ArrayList<LinkedTreeMap<String, String>>();
		
		for (String line : IOUtils.readLines(request.getReader())) {
			Gson gson = new GsonBuilder().serializeNulls().create();
			System.out.println(line);						
			list =  gson.fromJson(line, List.class);					
		}
		
		System.out.println(list.size());
	}

}
