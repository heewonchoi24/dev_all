<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String savePath = uploadDir + "banner/"; // 저장할 디렉토리 (절대경로)
int sizeLimit = 2 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi=new MultipartRequest(request, savePath, sizeLimit, "euc-kr");

String sql			= "";
String banner1 = ut.inject(multi.getParameter("banner1_"));
String banner2 = ut.inject(multi.getParameter("banner2_"));
String banner3 = ut.inject(multi.getParameter("banner3_"));
String banner4 = ut.inject(multi.getParameter("banner4_"));
String banner5 = ut.inject(multi.getParameter("banner5_"));
String banner6 = ut.inject(multi.getParameter("banner6_"));
String banner7 = ut.inject(multi.getParameter("banner7_"));
String banner1_link = ut.inject(multi.getParameter("banner1_link"));
String banner2_link = ut.inject(multi.getParameter("banner2_link"));
String banner3_link = ut.inject(multi.getParameter("banner3_link"));
String banner4_link = ut.inject(multi.getParameter("banner4_link"));
String banner5_link = ut.inject(multi.getParameter("banner5_link"));
String banner6_link = ut.inject(multi.getParameter("banner6_link"));
String banner7_link = ut.inject(multi.getParameter("banner7_link"));
String banner1_title = ut.inject(multi.getParameter("banner1_title"));
String banner2_title = ut.inject(multi.getParameter("banner2_title"));
String banner3_title = ut.inject(multi.getParameter("banner3_title"));
String banner4_title = ut.inject(multi.getParameter("banner4_title"));

try
{
	String formName = "";
	Enumeration formNames = multi.getFileNames();

	while(formNames.hasMoreElements())
	{
		formName = (String)formNames.nextElement();
		
		if(formName.equals("banner1") && multi.getFilesystemName(formName) != null){
			banner1=multi.getFilesystemName(formName);
		}else if(formName.equals("banner2") && multi.getFilesystemName(formName) != null){				
			banner2=multi.getFilesystemName(formName);
		}else if(formName.equals("banner3") && multi.getFilesystemName(formName) != null){
			banner3=multi.getFilesystemName(formName);
		}else if(formName.equals("banner4") && multi.getFilesystemName(formName) != null){
			banner4=multi.getFilesystemName(formName);
		}else if(formName.equals("banner5") && multi.getFilesystemName(formName) != null){
			banner5=multi.getFilesystemName(formName);
		}else if(formName.equals("banner6") && multi.getFilesystemName(formName) != null){
			banner6=multi.getFilesystemName(formName);
		}else if(formName.equals("banner7") && multi.getFilesystemName(formName) != null){
			banner7=multi.getFilesystemName(formName);
		}
	}
} catch(Exception e) {
	out.print("화일 업로드 에러..! "+e+"<br>");
}

sql ="update ESL_BANNER set";
sql+=" banner1='"+banner1+"',";
sql+=" banner2='"+banner2+"',";
sql+=" banner3='"+banner3+"',";
sql+=" banner4='"+banner4+"',";
sql+=" banner5='"+banner5+"',";
sql+=" banner6='"+banner6+"',";
sql+=" banner7='"+banner7+"',";
sql+=" banner1_link='"+banner1_link+"',";
sql+=" banner2_link='"+banner2_link+"',";
sql+=" banner3_link='"+banner3_link+"',";
sql+=" banner4_link='"+banner4_link+"',";
sql+=" banner5_link='"+banner5_link+"',";
sql+=" banner6_link='"+banner6_link+"',";
sql+=" banner7_link='"+banner7_link+"',";
sql+=" banner1_title='"+banner1_title+"',";
sql+=" banner2_title='"+banner2_title+"',";
sql+=" banner3_title='"+banner3_title+"',";
sql+=" banner4_title='"+banner4_title+"'";
sql+=" where no=2";


try{stmt.executeUpdate(sql);}catch(Exception e){out.println(e);if(true)return;}
%>
<script>alert("변경완료");parent.location.href="/esl_admin/board/banner.jsp";</script>
<%@ include file="../lib/dbclose.jsp" %>