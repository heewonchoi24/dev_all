<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@page import="javax.servlet.http.*" %>
<%
	System.out.println("================ 티맥스 로그인 시작=====================");
	HttpSession httpsession = request.getSession(false);
	
	String customerNum	= (String)httpsession.getAttribute("s_customer_num");	
	String eslMemberId	= (String)httpsession.getAttribute("esl_member_id");
	String s_member_no	= (String)httpsession.getAttribute("member_no");
	String return_url	= (String)httpsession.getAttribute("returnurl");

	//out.println("[" +  Sdate1() + "] [single_sso.jsp] strMemNo : " + httpsession.getAttribute("s_customer_num") + ", s_user : " + s_user_id);
 
	System.out.println("================싱글 에스에스 ==============================");
	System.out.println("return_url : " + return_url);
	System.out.println("==============================================");


	if(eslMemberId != null){
		response.sendRedirect("https://www.eatsslim.co.kr/proc/checkMember.jsp?id="+ eslMemberId);
		return;	
	}
%>