<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.net.*" %>
<%@page import="javax.servlet.http.*" %>
<%@include file="tmaxssocommon.jsp"%>

<%	
	HttpSession httpsession = request.getSession(false);
	String customerNum = (String)httpsession.getAttribute("s_customer_num");	
	String s_user_id = (String)httpsession.getAttribute("s_user_id");

	String sessionLogin = (String)session.getAttribute("sessionLogin");	

	//if (s_user_id != null){
%>
		<script language="javascript">
		<!--
			self.location.href = "https://www.eatsslim.com/";
		//-->
		</script>

		<%
	//}
%>

<script language="javascript">
		<!--
			alert('<%=customerNum%>');
		//-->
		</script>