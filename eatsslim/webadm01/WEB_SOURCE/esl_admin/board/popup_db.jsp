<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_POPUP";
String query		= "";
String mode			= ut.inject(request.getParameter("mode"));
int popupId			= 0;
String title		= ut.inject(request.getParameter("title"));
String attr			= ut.inject(request.getParameter("attr"));
String openYn		= ut.inject(request.getParameter("open_yn"));
String stdate		= ut.inject(request.getParameter("stdate"));
String ltdate		= ut.inject(request.getParameter("ltdate"));
String content		= ut.inject(request.getParameter("content"));
String link			= ut.inject(request.getParameter("link"));
String param		= ut.inject(request.getParameter("param"));
String delIds		= "";
String instId		= (String)session.getAttribute("esl_admin_id");
String userIp		= request.getRemoteAddr();

if (mode != null) {
	if (mode.equals("ins")) {
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(TITLE, ATTR, OPEN_YN, STDATE, LTDATE, CONTENT, LINK, INST_ID, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	('"+ title +"', '"+ attr +"', '"+ openYn +"', '"+ stdate +"', '"+ ltdate +"',";
			query		+= "	'"+ content +"', '"+ link +"', '"+ instId +"', '"+ userIp +"', NOW())";
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}

		ut.jsRedirect(out, "popup_list.jsp");
	} else if (mode.equals("upd")) {
		popupId		= Integer.parseInt(request.getParameter("id"));

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	TITLE			= '"+ title +"',";
			query		+= "	ATTR			= '"+ attr +"',";
			query		+= "	OPEN_YN			= '"+ openYn +"',";
			query		+= "	STDATE			= '"+ stdate +"',";
			query		+= "	LTDATE			= '"+ ltdate +"',";
			query		+= "	CONTENT			= '"+ content +"',";
			query		+= "	LINK			= '"+ link +"',";
			query		+= "	UPDT_ID			= '"+ instId +"',";
			query		+= "	UPDT_IP			= '"+ userIp +"',";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE ID = "+ popupId;
			stmt.executeUpdate(query);

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "popup_list.jsp?"+ param);
	} else if (mode.equals("del")) {
		delIds		= ut.inject(request.getParameter("del_ids"));

		try {
			query		= "DELETE FROM "+ table +" WHERE ID IN ("+ delIds +")";
			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();

			ut.jsRedirect(out, "popup_list.jsp");
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
		}		
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>