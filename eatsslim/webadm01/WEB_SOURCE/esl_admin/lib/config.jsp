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
String uploadDir		= application.getRealPath("/data").replaceAll("\\\\","/") + "/";//"/home/webadm01/WEB_SOURCE/data/";
String shopUrl			= "http://" + request.getServerName();
String webUploadDir		= "/data/";

int defaultBagPrice		= 4000;
int defaultDevlPrice	= 2700;
%>