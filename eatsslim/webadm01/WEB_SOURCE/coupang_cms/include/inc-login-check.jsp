<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("euc-kr");

int i					= 0;
int cnt					= 0;
int topLevelNo			= 0;
String[] arrTopMenu		= new String[] {"promotion"};
String linkpath			= request.getRequestURI(); //URL
String[] linkname		= linkpath.split("/"); //폴더단위 나누기
int linkcount			= (int)linkname.length-1; //split 갯수
String dirName			= linkname[linkcount - 1]; //폴더네임 1depth아래
String[] arrMyMenu		= new String[] {};

String cpAdminId		= (String)session.getAttribute("cp_admin_id");

if (cpAdminId == null || cpAdminId.equals("")) {
	ut.jsRedirect(out, "../login.jsp");
	if (true) return;
}
%>