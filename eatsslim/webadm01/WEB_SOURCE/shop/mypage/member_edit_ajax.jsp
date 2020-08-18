<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%@ page import="java.io.File"%>
<%
request.setCharacterEncoding("utf-8");

String query		= "";
boolean error		= false;
String code			= "";
String data			= "";

String memName		= ut.inject(request.getParameter("p_mem_name"));
String memHp		= ut.inject(request.getParameter("p_mem_hp"));
String memEmail		= ut.inject(request.getParameter("p_mem_email"));
String snsYn		= ut.inject(request.getParameter("p_cb_sns_yn"));
String emailYn		= ut.inject(request.getParameter("p_cb_email_yn"));

System.out.println(memName);
System.out.println(memHp);
System.out.println(memEmail);
System.out.println(snsYn);
System.out.println(emailYn);

try {
query				= " UPDATE ESL_MEMBER SET MEM_NAME = ?, HP = ?, EMAIL = ? , SMS_YN = ?, EMAIL_YN = ? WHERE MEM_ID = '"+ eslMemberId +"' AND CUSTOMER_NUM = '"+ eslCustomerNum +"'";
pstmt				= conn.prepareStatement(query);
pstmt.setString(1, memName);
pstmt.setString(2, memHp);
pstmt.setString(3, memEmail);
pstmt.setString(4, snsYn);
pstmt.setString(5, emailYn);
pstmt.executeUpdate();
code		= "success";
} catch (Exception e) {
code		= "error";
data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
} finally {
	 if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
}
out.println("<response>");
out.println("<result>"+code+"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose.jsp"%>