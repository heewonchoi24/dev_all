<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_FAQ";
String query			= "";
String mode				= ut.inject(request.getParameter("mode"));
int faqId			= 0;
String faqType			= ut.inject(request.getParameter("faq_type"));
String title			= ut.inject(request.getParameter("title"));
String content			= ut.inject(request.getParameter("content"));
String param			= ut.inject(request.getParameter("param"));
String delIds			= "";
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();

if (mode != null) {
	if (mode.equals("ins")) {
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(FAQ_TYPE, TITLE, CONTENT, HIT_CNT, INST_ID, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, 0, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, faqType);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, instId);
			pstmt.setString(5, userIp);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "faq_list.jsp");
	} else if (mode.equals("upd")) {
		faqId		= Integer.parseInt(request.getParameter("id"));

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	FAQ_TYPE		= ?,";
			query		+= "	TITLE			= ?,";
			query		+= "	CONTENT			= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, faqType);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, instId);
			pstmt.setString(5, userIp);
			pstmt.setInt(6, faqId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "faq_list.jsp?"+ param);
	} else if (mode.equals("del")) {
		delIds		= ut.inject(request.getParameter("del_ids"));

		try {
			query		= "DELETE FROM "+ table +" WHERE ID IN ("+ delIds +")";
			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();

			ut.jsRedirect(out, "faq_list.jsp");
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
		}		
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>