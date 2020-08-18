<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="/lib/config.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		 = "";
String table		 = "ESL_MEMBER_INFO";

eslMemberId			 = (String)session.getAttribute("esl_member_id");
eslMemberName		 = (String)session.getAttribute("esl_member_name");
String customerNum	 = (String)session.getAttribute("esl_customer_num");
String gender		 = ut.inject(request.getParameter("gender"));
String year			 = ut.inject(request.getParameter("year"));
String month		 = ut.inject(request.getParameter("month"));
String day			 = ut.inject(request.getParameter("day"));
String weight		 = ut.inject(request.getParameter("weight"));
String height		 = ut.inject(request.getParameter("height"));
String emailYn	     = ut.inject(request.getParameter("email_yn"));
String smsYn		 = ut.inject(request.getParameter("sms_yn"));
String bmi		     = ut.inject(request.getParameter("bmi"));
String bmr		     = ut.inject(request.getParameter("bmr"));
String recKcal		 = ut.inject(request.getParameter("rec_kcal"));
String birthDate     = year + '.' + month + '.' + day;

try {
	query		 = " INSERT INTO "+ table;
	query		+= " (CUSTOMER_NUM, MEM_ID, MEM_NAME, GENDER, BIRTH_DATE, WEIGHT, HEIGHT, EMAIL_YN, SMS_YN, INST_DATE, KCAL, REC_KCAL)";
	query		+= " VALUES";
	query		+= " (?, ?, ? ,?, ?, ?, ?, ?, ?, NOW(), ?, ?)";
	
	pstmt		= conn.prepareStatement(query);
	pstmt.setString(1, customerNum);
	pstmt.setString(2, eslMemberId);
	pstmt.setString(3, eslMemberName);
	pstmt.setString(4, gender);
	pstmt.setString(5, birthDate);
	pstmt.setString(6, weight);
	pstmt.setString(7, height);
	pstmt.setString(8, emailYn);
	pstmt.setString(9, smsYn);
	pstmt.setString(10, bmr);
	pstmt.setString(11, recKcal);
	pstmt.executeUpdate();
	
} catch (Exception e) {
	out.println(e);
	ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
	ut.jsBack(out);
	return;
}

ut.jsRedirect(out, "/promotion/personal2.jsp?bmi="+bmi+"&bmr="+bmr);

%>
<%@ include file="/lib/dbclose.jsp" %>