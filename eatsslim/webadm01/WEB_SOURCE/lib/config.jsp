<%
/**
 * @file : config.jsp
 * @date : 2013-08-20
 * @author : Kim Hyungseok
 */
%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<%@ include file="dbconn.jsp" %>
<%@ include file="util.jsp"%>
<%
String httpVersion		= request.getProtocol();
if(httpVersion.equals("HTTP/1.0")) {
	response.setDateHeader("Expires",-1);
	response.setHeader("Pragma","no-cache");
} else if(httpVersion.equals("HTTP/1.1")) {
	response.setHeader("Cache-Control","no-cache");
}

Util ut					= new Util();
boolean viewPage		= false;
String uploadDir		= "/home/webadm01/WEB_SOURCE/data/";
String shopUrl			= "http://" + request.getServerName();
String webUploadDir		= "/data/";

String eslMemberIdx		= (String)session.getAttribute("esl_member_idx");
String eslMemberId		= (String)session.getAttribute("esl_member_id");
String eslMemberName	= (String)session.getAttribute("esl_member_name");
String eslCustomerNum	= (String)session.getAttribute("esl_customer_num");
String eslMemberCode	= (String)session.getAttribute("esl_member_code");

if (eslMemberIdx == null) eslMemberIdx = "0";
if (eslMemberId == null) eslMemberId = "";
if (eslMemberName == null) eslMemberName = "";
if (eslCustomerNum == null) eslCustomerNum = "";
if (eslMemberCode == null) eslMemberCode = "";

int defaultBagPrice		= 4000;
int defaultDevlPrice	= 2700;
%>