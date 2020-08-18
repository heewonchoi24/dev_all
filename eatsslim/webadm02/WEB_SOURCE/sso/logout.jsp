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
		//GA스크립트를 위해 추가
		String dimension_value = (String)session.getAttribute("DIMENSION_VALUE");
		
		session.invalidate();
		
		//GA스크립트를 위해 추가
		//javax.servlet.http.HttpUtils.setSession(request, "DIMENSION_VALUE", dimension_value);
		
		//HttpSession httpsession = request.getSession(true);
		//httpsession.setAttribute("DIMENSION_VALUE", dimension_value);
		
		return;
	} else {
		response.sendRedirect(returnURL);
	}
	/*********************** tmax eam 을 위한 코드 ************************/

%>
