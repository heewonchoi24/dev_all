<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ include file="/lib/util.jsp"%>
<%
String eslMemberIdx = "67534";
String eslMemberId = "ka_432399836";
String eslMemberName = "���ϳ�";
String eslCustomerNum = "100000003";

eslMemberIdx = "67536";
eslMemberId = "fa_10212955456782117";
eslMemberName = "Tiberius Hewar";
eslCustomerNum = "100000005";

session.setAttribute("esl_member_idx", eslMemberIdx);
session.setAttribute("esl_customer_num", eslCustomerNum);
session.setAttribute("esl_member_id", eslMemberId);    
session.setAttribute("esl_member_name", eslMemberName);  

/*
session.setAttribute("esl_member_idx", "29556");
// session.setAttribute("esl_member_id", "realshian0");    
// session.setAttribute("esl_member_name", "��ܿ�");  
session.setAttribute("esl_customer_num", "21859545");
session.setAttribute("esl_member_id", "jykwon");    
session.setAttribute("esl_member_name", "���翬");  
*/
response.sendRedirect("/index.jsp");
%>