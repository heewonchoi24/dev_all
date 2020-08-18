<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_FAQ";
String query		= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
int faqId			= 0;

if (mode.equals("upd")) {
	if (request.getParameter("id") == null || request.getParameter("id").length()<1) {
		code		= "error";
		data		= "<error><![CDATA[잘못된 접근입니다.]]></error>";
	} else {
		faqId		= Integer.parseInt(request.getParameter("id"));

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "		HIT_CNT		= HIT_CNT + 1";
			query		+= "	WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, faqId);
			pstmt.executeUpdate();

			code		= "success";
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>