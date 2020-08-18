<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_SYSTEM_HOLIDAY";
String query			= "";
String mode				= ut.inject(request.getParameter("mode"));
int holidayId			= 0;
String holidayType		= ut.inject(request.getParameter("holiday_type"));
String holiday			= ut.inject(request.getParameter("holiday"));
String holidayName		= ut.inject(request.getParameter("holiday_name"));
String comment			= ut.inject(request.getParameter("comment"));
String param			= ut.inject(request.getParameter("param"));
String delIds			= "";
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();

if (mode != null) {
	if (mode.equals("ins")) {
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(HOLIDAY_TYPE, HOLIDAY, HOLIDAY_NAME, COMMENT, INST_ID, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, holidayType);
			pstmt.setString(2, holiday);
			pstmt.setString(3, holidayName);
			pstmt.setString(4, comment);
			pstmt.setString(5, instId);
			pstmt.setString(6, userIp);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "holiday_list.jsp");
	} else if (mode.equals("upd")) {
		holidayId		= Integer.parseInt(request.getParameter("id"));

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	HOLIDAY_TYPE	= ?,";
			query		+= "	HOLIDAY			= ?,";
			query		+= "	HOLIDAY_NAME	= ?,";
			query		+= "	COMMENT			= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, holidayType);
			pstmt.setString(2, holiday);
			pstmt.setString(3, holidayName);
			pstmt.setString(4, comment);
			pstmt.setString(5, instId);
			pstmt.setString(6, userIp);
			pstmt.setInt(7, holidayId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "holiday_list.jsp?"+ param);
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>