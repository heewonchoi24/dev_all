<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_MEMBER_HOLIDAY";
String query		= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String groupCode	= ut.inject(request.getParameter("group_code"));
String holidays[]	= request.getParameterValues("holiday");
String holiday		= "";
String devlYns[]	= request.getParameterValues("devl_yn");
String devlYn		= "";
int chkCnt			= 0;
int i				= 0;

if (mode.equals("ins")) {
	for (i = 0; i < holidays.length; i++) {
		holiday		= ut.inject(holidays[i]);
		devlYn		= ut.inject(devlYns[i]);

		query		= "SELECT COUNT(ID) FROM "+ table;
		query		+= " WHERE MEMBER_ID ='"+ eslMemberId +"'";
		query		+= " AND GROUP_CODE = '"+ groupCode +"'";
		query		+= " AND HOLIDAY = '"+ holiday +"'";
		try {
			rs	= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs.next()) {
			chkCnt		= rs.getInt(1);
		}
		rs.close();

		if (chkCnt > 0) {
			query		= "UPDATE "+ table +" SET ";
			query		+= "			DEVL_YN		= '"+ devlYn +"'";
			query		+= " WHERE MEMBER_ID = '"+ eslMemberId +"'";
			query		+= " AND GROUP_CODE = '"+ groupCode +"'";
			query		+= " AND HOLIDAY = '"+ holiday +"'";
		} else {
			query		= "INSERT INTO "+ table;
			query		+= "	(MEMBER_ID, GROUP_CODE, HOLIDAY, DEVL_YN)";
			query		+= " VALUES";
			query		+= "	('"+ eslMemberId +"', '"+ groupCode +"', '"+ holiday +"', '"+ devlYn +"')";
		}
		try {
			stmt.executeUpdate(query);			
		} catch(Exception e) {
			out.println(e+"=>"+query);			
		}
	}

	if (i == holidays.length) {
		code		= "success";
	} else {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose.jsp"%>