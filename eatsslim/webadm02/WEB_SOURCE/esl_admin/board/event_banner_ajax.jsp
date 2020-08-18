<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table				= "ESL_MAIN_BANNER";
String query                = "";
String instId				= (String)session.getAttribute("esl_admin_id");
String userIp				= request.getRemoteAddr();
String mode					= ut.inject(request.getParameter("mode"));
String imgFileId			= ut.inject(request.getParameter("imgFileId"));

if (mode.equals("deleteImg")) {
	try {
		query		= "UPDATE "+ table +" SET ";
		query		+= imgFileId			   + " = '',";
		query		+= "	UPDT_ID					= '"+ instId +"',";
		query		+= "	UPDT_IP					= '"+ userIp +"',";
		query		+= "	UPDT_DATE				= NOW()";
		query		+= " WHERE ID = "+ 1;
		stmt.executeUpdate(query);
		System.out.println(query);

	} catch (Exception e) {
		//out.println(e);
		ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
		ut.jsBack(out);
		return;
	}
	ut.jsRedirect(out, "event_banner.jsp");
} 
%>
<%@ include file="../lib/dbclose.jsp" %>