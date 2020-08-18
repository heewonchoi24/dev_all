
<%
/**
 * @file : dbconn.jsp
 * @date : 2013-08-20
 * @author : Kim Hyungseok
 */
%>
<%@ page import="java.sql.*"%>
<%
    String userIp			= request.getRemoteAddr();
	out.println(userIp);
%>