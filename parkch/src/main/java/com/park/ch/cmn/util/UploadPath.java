package com.park.ch.cmn.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.File;


public class UploadPath {

	public static String attach_path = "resources/upload/";

	public static String path(HttpServletRequest req) {

		HttpSession session = req.getSession();

		String uploadPath = "";
		try {
			String root_path = session.getServletContext().getRealPath("/");

			uploadPath = root_path + attach_path.replace('/', File.separatorChar);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return uploadPath;
	}

}

