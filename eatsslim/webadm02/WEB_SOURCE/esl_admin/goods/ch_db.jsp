<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_CHANNEL";
String query			= "";
String mode				= ut.inject(request.getParameter("mode"));
int chId			= 0;
String chCode			= ut.inject(request.getParameter("ch_code"));
String chName			= ut.inject(request.getParameter("ch_name"));
String comment			= ut.inject(request.getParameter("comment"));
String param			= ut.inject(request.getParameter("param"));
String delIds			= "";
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();

if (mode != null) {
	if (mode.equals("ins")) {
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(CH_CODE, CH_NAME, COMMENT, INST_ID, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, chCode);
			pstmt.setString(2, chName);
			pstmt.setString(3, comment);
			pstmt.setString(4, instId);
			pstmt.setString(5, userIp);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "ch_list.jsp");
	} else if (mode.equals("upd")) {
		chId		= Integer.parseInt(request.getParameter("id"));

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	CH_CODE	= ?,";
			query		+= "	CH_NAME	= ?,";
			query		+= "	COMMENT			= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, chCode);
			pstmt.setString(2, chName);
			pstmt.setString(3, comment);
			pstmt.setString(4, instId);
			pstmt.setString(5, userIp);
			pstmt.setInt(6, chId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "ch_list.jsp?"+ param);
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>