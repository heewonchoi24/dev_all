<%@ page contentType = "text/html; charset=euc-kr" %>

<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@page import="com.tmax.eam.*"%>

<%
	String fullUrl = javax.servlet.http.HttpUtils.getRequestURL(request).toString(); 
	String serviceServletPath = request.getServletPath();
	int i = fullUrl.indexOf(serviceServletPath);
	String serviceURL = fullUrl.substring(0,i) + "/";
	
	//사용자 정보 
	String userid = "SSOUser";
	String passwd = "test";
	String etc = "B";	
	
	String f_id = request.getParameter("f_id");
	String f_pass = request.getParameter("f_pass");

	String sf_id = (String)request.getAttribute("sf_id");
	String sf_pass = (String)request.getAttribute("sf_pass");
	
	String nextPage = (String)session.getAttribute(Common.PARAM_NEXTURL);
	String returnURL = null;
	
	if (nextPage == null) {	
			returnURL = serviceURL + "/sso/first.jsp";
	} else {
		returnURL = nextPage;	// 로그인후에 원래가려던 페이지로 가기위해
	}	
	

	// 사용자 인증 처리 아이디 패스워드가 일치하는 경우
	if(f_id.equals(userid) && f_pass!=null && f_pass.equals(passwd)){

		session.setAttribute("userid", userid);
		com.tmax.eam.SessionInfo sessioninfo = SSOTokenManager.getSSOServerSessionInfo(userid,Common.COMMON);
		
		//기존 tmax session이 존재 할 경우.
		if(sessioninfo != null){	
	
			String logout2URL = serviceURL + "logout.jsp";
			
			// 기존 세션IP 확인	
			String Pre_IP = sessioninfo.clientIp; // 서버세션에 등록된 IP
			boolean IP_Check = Pre_IP.equals(request.getRemoteAddr()); // 현재 접속한 클라이언트 IP 와 비교
			
			// 기존 세션SessionID 확인
			String sessionidx = sessioninfo.sessionId;
			boolean Session_Check = sessionidx.equals(session.getId());  // 현재 세션과 비교
		
		
%>
		<html>
			<script>
				function tmaxeam_submit(){
<%
					if(IP_Check){
							
						if(!Session_Check){
							%>                          
								if(confirm('이미 다른 브라우져에 의해 로그인이 되어 있습니다.\n기존 로그인을 취소하고 새롭게 로그인 하시겠습니까?\n\n로그인 ID:<%=userid%>')){
									<%=Common.SUBMIT_SCRIPT%>
								}else{
									<!-- 현재 세션을 종료한다. 이때 호출되는 logout 페이지는 SSO Token 폐기 API를 호출하지 않고 현재 서비스 세션만 종료시킨다.-->
									document.location.href='<%=logout2URL%>';
								}
							<%
						}else{
							%>
								<%=Common.SUBMIT_SCRIPT%>
							<%
						}
							
					} else {
						%>                          
							if(confirm('이미 다른IP에서 로그인이 되어 있습니다.\n기존 로그인을 취소하고 새롭게 로그인 하시겠습니까?\n\n로그인IP:<%=Pre_IP%>, 로그인 ID:<%=userid%>')){
								<%=Common.SUBMIT_SCRIPT%>
							}else{
								<!-- 현재 세션을 종료한다. 이때 호출되는 logout 페이지는 SSO Token 폐기 API를 호출하지 않고 현재 서비스 세션만 종료시킨다.-->
								document.location.href='<%=logout2URL%>';
							}
						<%
					}
%>
   
				} //tmaxeam_submit
			</script>
				
				<body onload='tmaxeam_submit()'>
					//Common.SUBMIT_SCRIPT 에서 submit될 내용이 아래에 출력되게 함
					//이전 세션 폐기 후 새로운 토큰 생성 및 등록
					<%=SSOTokenManager.getIssueTokenWOSMsg(request, f_id, Common.COMMON, returnURL)%>
				</body>    
		 </html>

				<%
				return;     
					
		} 
		
		// 토큰을 발급 한다.	
		if (SSOTokenManager.issueToken(request, out, f_id, Common.COMMON, etc, returnURL)) {
			return;
		}else{
			%><html><script>alert('token registration failure');document.location.href='first.jsp';</script></html><%
		}
		
	
	} else {
	//아이디 패스워드가 맞지 않은 경우.
	%><html><body><br><br><center><font color=red>Login Failure</font></center></body></html><%
		return;
	}
%>

