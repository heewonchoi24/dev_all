<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("euc-kr");

int i					= 0;
int cnt					= 0;
int topLevelNo			= 0;
String[] arrTopMenu		= new String[] {"member", "goods", "order", "board", "counsel", "promotion", "option", "statistic"};
String linkpath			= request.getRequestURI(); //URL
String[] linkname		= linkpath.split("/"); //폴더단위 나누기
int linkcount			= (int)linkname.length-1; //split 갯수
String dirName			= linkname[linkcount - 1]; //폴더네임 1depth아래
String[] arrMyMenu		= new String[] {};

String eslAdminId		= (String)session.getAttribute("esl_admin_id");
String eslAdminName		= (String)session.getAttribute("esl_admin_name");
String eslAdminMenu		= (String)session.getAttribute("esl_admin_menu");

if (eslAdminId == null || eslAdminId.equals("")) {
	ut.jsRedirect(out, "../login.jsp");
	if (true) return;
}

if(eslAdminMenu != null && eslAdminMenu.length() > 0){
	arrMyMenu	= eslAdminMenu.split(",");
	for (i=0; i<arrTopMenu.length; i++) {
		if (dirName.equals(arrTopMenu[i])) { //현재 디렉토리 찾음
			for (cnt=0; cnt<arrMyMenu.length; cnt++) {
				//out.println("<br>cnt="+String.valueOf(cnt)+",i+1="+String.valueOf((i+1)));
				if (Integer.parseInt(arrMyMenu[cnt])==(i+1)) topLevelNo = cnt+2;
			}
		}
	}
}
%>