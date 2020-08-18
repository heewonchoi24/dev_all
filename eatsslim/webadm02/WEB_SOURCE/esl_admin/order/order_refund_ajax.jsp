<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_ORDER_CANCEL";
String chkQuery		= "";
String query		= "";
boolean error		= false;
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String instId		= (String)session.getAttribute("esl_admin_id");
String userIp		= request.getRemoteAddr();
String delIds		= "";
String delId		= "";
String[] arrDelId;
int refundId		= 0;
int i				= 0;
if (request.getParameter("rid") != null && request.getParameter("rid").length()>0)
	refundId			= Integer.parseInt(request.getParameter("rid"));

if (instId == null || instId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[no_txt:로그인을 해주세요.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[no_txt:정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[no_txt:정상적으로 접근을 해주십시오.]]></error>";
} else if (mode.equals("upd")) {
	query		= "UPDATE "+ table +" SET ";
	query		+= "	PG_CANCEL		= 'Y'";
	query		+= " WHERE ID = '"+ refundId +"'";
	try {
		stmt.executeUpdate(query);
		code		= "success";
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
} else if (mode.equals("updAll")) {
	delIds		= ut.inject(request.getParameter("del_ids"));

	arrDelId	= delIds.split(",");
	for (i = 0; i < arrDelId.length; i++) {
		delId		= arrDelId[i];
		
		query		= "UPDATE "+ table +" SET ";
		query		+= "	PG_CANCEL		= 'Y'";
		query		+= " WHERE ID = '"+ delId +"'";
		
		try {
			stmt.executeUpdate(query);
			code		= "success";
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>