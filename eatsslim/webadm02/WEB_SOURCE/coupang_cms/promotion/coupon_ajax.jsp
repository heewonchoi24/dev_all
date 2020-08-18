<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ include file="../lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String query		= "";
boolean error		= false;
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String instId		= (String)session.getAttribute("cp_admin_id");
String delIds		= "";
String[] arrDelId;
String delId		= "";

if (instId == null || instId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[로그인을 해주세요.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (mode.equals("cancel")) {
	delIds		= ut.inject(request.getParameter("del_ids"));

	arrDelId	= delIds.split(",");
	for (int i = 0; i < arrDelId.length; i++) {
		delId		= arrDelId[i];

		query		= "UPDATE ESL_COUPON_MEMBER SET ";
		query		+= "		USE_YN	= 'C'";
		query		+= " WHERE COUPON_NUM = '"+ delId +"'";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			//out.println(e+"=>"+query);
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		query		= "UPDATE ESL_COUPON_RANDNUM SET ";
		query		+= "		USE_YN	= 'C'";
		query		+= " WHERE RAND_NUM = '"+ delId +"'";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			//out.println(e+"=>"+query);
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}
	}

	if (!code.equals("error")) {
		code		= "success";
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>