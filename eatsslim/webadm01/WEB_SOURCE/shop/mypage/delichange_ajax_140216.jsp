<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("utf-8");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String orderNum		= ut.inject(request.getParameter("order_num"));
String groupCode	= ut.inject(request.getParameter("group_code"));
String devlDate1	= ut.inject(request.getParameter("devl_date1"));
String devlDate2	= ut.inject(request.getParameter("devl_date2"));
int chkMyDate		= 0;
int chkHoliday		= 0;
String devlDay		= "";
int week			= 0;
String minDevlDate	= "";

if (mode.equals("editDevl")) {
	query		= "SELECT COUNT(ID) FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM ='"+ orderNum +"' AND GROUP_CODE = '"+ groupCode +"' AND DEVL_DATE = '"+ devlDate1 +"'";
	try {
		rs			= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		chkMyDate		= rs.getInt(1);
	}

	rs.close();

	query		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDate2 +"' AND HOLIDAY_TYPE = '02'";
	try {
		rs			= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		chkHoliday		= rs.getInt(1);
	}

	query		= "SELECT DEVL_DAY, DAYOFWEEK('"+ devlDate2 +"') WEEK FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'";
	query		+= " AND GROUP_ID = (SELECT ID FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ groupCode +"')";
	try {
		rs			= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		devlDay		= rs.getString("DEVL_DAY");
		week		= rs.getInt("WEEK");
	}

	rs.close();

	if (devlDate1.equals("") || devlDate1 == null) {
		code		= "error";
		data		= "<error><![CDATA[변경 가능한 배송일을 선택해주세요.]]></error>";
	} else if (devlDate2.equals("") || devlDate2 == null) {
		code		= "error";
		data		= "<error><![CDATA[변경될 배송일을 선택해주세요.]]></error>";
	} else if (chkMyDate < 1) {
		code		= "error";
		data		= "<error><![CDATA[변경 가능한 배송일이 아닙니다.]]></error>";
	} else if (chkHoliday > 0) {
		code		= "error";
		data		= "<error><![CDATA[관리자 휴무일에는 배송이 불가능합니다.]]></error>";
	} else if (devlDay.equals("5") && (week == 1 || week == 7)) {
		code		= "error";
		data		= "<error><![CDATA[토,일 배송이 불가능한 상품입니다.]]></error>";
	} else if ((devlDay.equals("6") || devlDay.equals("7")) && (week == 1)) {
		code		= "error";
		data		= "<error><![CDATA[일 배송이 불가능한 상품입니다.]]></error>";
	} else {
		query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
		query		+= "		DEVL_DATE = '"+ devlDate2 +"'";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GROUP_CODE = '"+ groupCode +"' AND DEVL_DATE = '"+ devlDate1 +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
/*
		query		= "SELECT MIN(DEVL_DATE) MIN_DATE FROM ESL_ORDER_DEVL_DATE";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		if (groupCode.length() < 7) {
			query		+= " AND (GROUP_CODE IN (SELECT DISTINCT GROUP_CODE FROM ESL_PG_DELIVERY_SCHEDULE))";
		} else {
			query		+= " AND GROUP_CODE = '"+ groupCode +"'";
		}
		try {
			rs			= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs.next()) {
			minDevlDate		= rs.getString("MIN_DATE");
		}
		rs.close();

		query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
		query		+= "		DEVL_DATE = '"+ minDevlDate +"'";
		query		+= " WHERE GROUP_CODE = '0300668' AND ORDER_NUM = '"+ orderNum +"'";
		if (groupCode.length() < 7) {
			query		+= " AND (GROUP_CODE IN (SELECT DISTINCT GROUP_CODE FROM ESL_PG_DELIVERY_SCHEDULE))";
		} else {
			query		+= " AND GROUP_CODE = '"+ groupCode +"'";
		}
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
*/
		query		= "UPDATE ESL_ORDER SET ";
		query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n사용자 배송일 변경 ("+ devlDate1 +" => "+ devlDate2 +") ', NOW())";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		code		= "success";
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose.jsp"%>
<%@ include file="/lib/dbclose_phi.jsp"%>