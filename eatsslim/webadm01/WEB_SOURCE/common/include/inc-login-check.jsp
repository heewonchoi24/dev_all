<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
if (eslMemberId == null || eslMemberId.equals("")) {
	ut.jsAlert(out, "로그인을 해주세요.");
	ut.jsRedirect(out, "/index_es.jsp");
	if (true) return;
}
%>
