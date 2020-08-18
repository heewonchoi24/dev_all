<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
String query		= "";
String mode			= ut.inject(request.getParameter("mode"));
String orderNum		= ut.inject(request.getParameter("order_num"));
String adminMemo	= ut.inject(request.getParameter("admin_memo"));

if (mode != null) {
	query		= "UPDATE ESL_ORDER SET ADMIN_MEMO = '"+ adminMemo +"'";
	query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
	try {
		stmt.executeUpdate(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if (true) return;
	}

	ut.jsRedirect(out, "order_view.jsp?ordno="+ orderNum);
}
%>
<%@ include file="../lib/dbclose.jsp" %>