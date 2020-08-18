<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_EVENT_VERSUS";
String query		= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String versus		= ut.inject(request.getParameter("versus"));
String cnt			= ut.inject(request.getParameter("cnt"));
String userIp		= request.getRemoteAddr();
int myCnt			= 0;

if (eslMemberId == null || eslMemberId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[로그인을 해주세요.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (mode.equals("versus")) {
	query		= "SELECT CNT FROM "+ table +" WHERE MEMBER_ID = '"+ eslMemberId +"'";
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if (true) return;
	}

	if (rs.next()) {
		myCnt	= rs.getInt("CNT");
	}

	rs.close();

	if (myCnt < 1) {
		query		= "INSERT INTO "+ table;
		query		+= "	(MEMBER_ID, VERSUS, CNT, INST_IP, INST_DATE)";
		query		+= " VALUES ";
		query		+= "	('"+ eslMemberId +"', '"+ versus +"', '1', '"+ userIp +"', NOW())";
		try {
			stmt.executeUpdate(query);
			code		= "success";
		} catch(Exception e) {
			//out.println(e+"=>"+query);
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
	} else if (myCnt > 0) {
		query		= "UPDATE "+ table +" SET ";
		query		+= "		VERSUS			= '"+ versus +"'";
		query		+= "		, CNT			= CNT + 1";
		query		+= "		, UPDT_IP		= '"+ userIp +"'";
		query		+= "		, UPDT_DATE		= NOW()";
		query		+= " WHERE MEMBER_ID = '"+ eslMemberId +"'";
		try {
			stmt.executeUpdate(query);
			code		= "success";
		} catch(Exception e) {
			//out.println(e+"=>"+query);
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