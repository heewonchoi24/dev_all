<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_ADMIN";
String query			= "";
String mode				= ut.inject(request.getParameter("mode"));
int aid					= 0;
String adminId			= ut.inject(request.getParameter("admin_id"));
String adminPw			= ut.inject(request.getParameter("admin_pw"));
String adminName		= ut.inject(request.getParameter("admin_name"));
String adminHp			= ut.inject(request.getParameter("admin_hp"));
String adminEmail		= ut.inject(request.getParameter("admin_email"));
String adminMenus[]		= request.getParameterValues("admin_menu");
String adminMenu		= "";
String param			= ut.inject(request.getParameter("param"));
String delIds			= "";
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();

if (mode != null) {
	if (mode.equals("ins") || mode.equals("upd")) {
		for (i = 0; i < adminMenus.length; i++) {
			if (i==0) {
				adminMenu	= adminMenus[i];
			} else {
				adminMenu	+= ","+adminMenus[i];
			}
		}
	}
	
	if (mode.equals("ins")) {
		query		= "INSERT INTO ESL_ADMIN_HISTORY";
		query		+= "	(ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_HP, ADMIN_EMAIL, ADMIN_MENU, INST_ID, INST_IP, INST_DATE, INST_TYPE)";
		query		+= " VALUES";
		query		+= "	('"+ adminId +"', PASSWORD('"+ adminPw +"'), '"+ adminName +"', '"+ adminHp +"', '"+ adminEmail +"',";
		query		+= "	'"+ adminMenu +"', '"+ instId +"', '"+ userIp +"', NOW(), 'I')";
		try {
			stmt.executeUpdate(query);
			ut.jsRedirect(out, "admin_list.jsp");
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}		
		
		query		= "INSERT INTO "+ table;
		query		+= "	(ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_HP, ADMIN_EMAIL, ADMIN_MENU, INST_ID, INST_IP, INST_DATE)";
		query		+= " VALUES";
		query		+= "	('"+ adminId +"', PASSWORD('"+ adminPw +"'), '"+ adminName +"', '"+ adminHp +"', '"+ adminEmail +"',";
		query		+= "	'"+ adminMenu +"', '"+ instId +"', '"+ userIp +"', NOW())";
		try {
			stmt.executeUpdate(query);
			ut.jsRedirect(out, "admin_list.jsp");
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}
	} else if (mode.equals("upd")) {
		aid		= Integer.parseInt(request.getParameter("id"));
		
		query		= "INSERT INTO ESL_ADMIN_HISTORY";
		query		+= "	(ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_HP, ADMIN_EMAIL, ADMIN_MENU, INST_ID, INST_IP, INST_DATE, INST_TYPE, PW_UPDATE_DATE)";
		query		+= " VALUES";
		query		+= "	('"+ adminId +"', PASSWORD('"+ adminPw +"'), '"+ adminName +"', '"+ adminHp +"', '"+ adminEmail +"',";
		query		+= "	'"+ adminMenu +"', '"+ instId +"', '"+ userIp +"', NOW(), 'U', NOW())";
		try {
			stmt.executeUpdate(query);
			ut.jsRedirect(out, "admin_list.jsp");
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}		

		query		= "UPDATE "+ table +" SET ";
		if (adminPw != null && adminPw.length() > 0) {
			query		+= "	ADMIN_PW		= PASSWORD('"+ adminPw +"'),";
			query		+= "	PW_UPDATE_DATE	= NOW(),";
		}
		query		+= "	ADMIN_NAME		= '"+ adminName +"',";
		query		+= "	ADMIN_HP		= '"+ adminHp +"',";
		query		+= "	ADMIN_EMAIL		= '"+ adminEmail +"',";
		query		+= "	ADMIN_MENU		= '"+ adminMenu +"',";
		query		+= "	UPDT_ID			= '"+ instId +"',";
		query		+= "	UPDT_IP			= '"+ userIp +"',";
		query		+= "	UPDT_DATE		= NOW()";
		query		+= " WHERE ID = "+ aid;
		try {
			stmt.executeUpdate(query);
			ut.jsRedirect(out, "admin_list.jsp?"+ param);
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}
	} else if (mode.equals("del")) {
		delIds		= ut.inject(request.getParameter("del_ids"));
		
		query		= "INSERT INTO ESL_ADMIN_HISTORY";
		query		+= "	(ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_HP, ADMIN_EMAIL, ADMIN_MENU, INST_ID, INST_IP, INST_DATE, INST_TYPE)";
		query		+= "	(SELECT ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_HP, ADMIN_EMAIL, ADMIN_MENU, '"+ instId +"', '"+ userIp +"', NOW(), 'D' FROM "+ table +" WHERE ID IN ("+ delIds +"))";
		//out.print(query);
		try {
			stmt.executeUpdate(query);
			ut.jsRedirect(out, "admin_list.jsp");
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}

		try {
			query		= "DELETE FROM "+ table +" WHERE ID IN ("+ delIds +")";
			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();

			ut.jsRedirect(out, "admin_list.jsp");
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
		}		
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>