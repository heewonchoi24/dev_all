<%@page contentType = "text/html; charset=euc-kr" %>

<%@page import="java.util.*" %>
<%@page import="javax.servlet.http.*" %>

<%@page import="com.tmax.eam.*" %>

<%

	//SSO 서버로부터 토큰을 받아 인증을 실행하는 페이지
	String userid = "SSOUser";//테스트1
	String userid2 = "administrator";	// 유저 2
	String passwd = "test";
	String common = "999999-1111111"; 
	
	/*********************** tmax eam 을 위한 코드 ************************/
	String tokenStr = (String)request.getParameter(Common.PARAM_TOKEN);
	String nextPage = (String)request.getParameter(Common.PARAM_NEXTURL);
	
	/*********************** ServiceURL을 가져옮 ***********************/
	String fullUrl = javax.servlet.http.HttpUtils.getRequestURL(request).toString(); 
	String serviceServletPath = request.getServletPath();
	int i = fullUrl.indexOf(serviceServletPath);
	String serviceURL = fullUrl.substring(0,i) + "/";
	/*********************** ServiceURL을 가져옮 ***********************/

	if(nextPage==null) {
		nextPage="first.jsp";
	} else {
		nextPage = Common.decode(nextPage);
	}

	TmaxSSOToken token = null;

	try {
		token = new TmaxSSOToken(tokenStr, EAMFilter.logger);
	} catch (Exception e) {
		if (tokenStr != null)  
			e.printStackTrace();
	}

	String id = null;

	//성공적으로 SSO 서버로부터 토큰을 받았으면. 
	if(tokenStr != null){

		id=token.getUserId();
		String pass=token.getSecret();
		String cmm=token.getCommon();
		String etc = token.getETC();
	
		if(!TmaxSSOSession.verifyToken(token)){
				%><html><body>invalid token</body></html><%
				return;
		}
		
		boolean loginCheck = cmm.equals(userid) || cmm.equals(userid2);
	
		if(loginCheck) {
		
			session.setAttribute("userid", cmm);
		
			if(TmaxSSOSession.login(request,token)){
					response.sendRedirect(nextPage);
			} else {
				%><html><script>alert("이미 세션이 존재합니다. 다시 로그인하십시오."); document.location.href='index.jsp';</script></html><%
			}

			return;	
		
		} else {
			response.sendRedirect(serviceURL + "index.jsp");
		}
	
	} else {

		TmaxSSOSession.tokenDistributionFail(request);
		response.sendRedirect(serviceURL + "index.jsp");
		%>login fail:userid=<%=userid%>,id=<%=id%><%	

	}


%>

