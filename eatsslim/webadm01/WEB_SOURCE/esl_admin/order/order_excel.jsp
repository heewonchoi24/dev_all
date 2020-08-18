<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

response.setHeader("Content-Disposition", "attachment; filename=order_list.xls"); 
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setHeader("Content-Type", "application/vnd.ms-excel; name='excel', text/html; charset=euc-kr");
response.setContentType("text/plain;charset=euc-kr");

<%@ include file="../lib/dbclose.jsp" %>