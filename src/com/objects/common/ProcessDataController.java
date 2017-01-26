package com.objects.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class ProcessDataController extends HttpServlet {

	private static final long serialVersionUID = 1204140343352039617L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		for (String line : IOUtils.readLines(request.getReader())) {
			Gson gson = new GsonBuilder().serializeNulls().create();
			System.out.println(line);			
			System.out.println(gson.toJson(line));
		}
	}

}
