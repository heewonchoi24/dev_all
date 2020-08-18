<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");
	String _ua = request.getHeader("user-agent").toLowerCase();
	
	if ( _ua.indexOf("iphone") > -1 || _ua.indexOf("ipod") > -1 || _ua.indexOf("ipad") > -1 ) {
		
		out.println("ISO");
	}
	else {
		out.println("ANDROID");
	}
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>