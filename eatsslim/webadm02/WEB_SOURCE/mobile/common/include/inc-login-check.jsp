<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%
if (eslMemberId == null || eslMemberId.equals("")) {
	ut.jsAlert(out, "�α����� ���ּ���.");
	ut.jsRedirect(out, "/sso/single_sso.jsp");
	if (true) return;
}
%>