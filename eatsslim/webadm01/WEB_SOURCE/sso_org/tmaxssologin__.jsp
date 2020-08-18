<%@page contentType = "text/html; charset=euc-kr" %>

<%@page import="java.util.*" %>
<%@page import="javax.servlet.http.*" %>

<%@page import="com.tmax.eam.*" %>

<%

	//SSO �����κ��� ��ū�� �޾� ������ �����ϴ� ������
	String userid = "SSOUser";//�׽�Ʈ1
	String userid2 = "administrator";	// ���� 2
	String passwd = "test";
	String common = "999999-1111111"; 
	
	/*********************** tmax eam �� ���� �ڵ� ************************/
	String tokenStr = (String)request.getParameter(Common.PARAM_TOKEN);
	String nextPage = (String)request.getParameter(Common.PARAM_NEXTURL);
	
	/*********************** ServiceURL�� ������ ***********************/
	String fullUrl = javax.servlet.http.HttpUtils.getRequestURL(request).toString(); 
	String serviceServletPath = request.getServletPath();
	int i = fullUrl.indexOf(serviceServletPath);
	String serviceURL = fullUrl.substring(0,i) + "/";
	/*********************** ServiceURL�� ������ ***********************/

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

	//���������� SSO �����κ��� ��ū�� �޾�����. 
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
				%><html><script>alert("�̹� ������ �����մϴ�. �ٽ� �α����Ͻʽÿ�."); document.location.href='index.jsp';</script></html><%
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

