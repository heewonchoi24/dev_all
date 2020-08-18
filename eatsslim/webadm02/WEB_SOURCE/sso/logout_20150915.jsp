<%@page contentType = "text/html; charset=euc-kr" %>
<%@page import="java.net.*" %>
<%@page import="java.util.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="com.tmax.eam.*"%>
<% 

	String fullUrl = javax.servlet.http.HttpUtils.getRequestURL(request).toString();
	String serviceServletPath = request.getServletPath();
	int i = fullUrl.indexOf(serviceServletPath);
	String serviceURL = fullUrl.substring(0,i) + "/";

	/*********************** tmax eam 을 위한 코드 ************************/
	String returnURL = serviceURL + "index.jsp";
	if (SSOTokenManager.allLogout(request, out, returnURL)) {
		session.invalidate();
		return;
	} else {
		response.sendRedirect(returnURL);
	}
	/*********************** tmax eam 을 위한 코드 ************************/

%>
