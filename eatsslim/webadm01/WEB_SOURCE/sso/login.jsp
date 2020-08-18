<%@ page contentType = "text/html; charset=euc-kr" %>

<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@page import="com.tmax.eam.*"%>

<%
	String fullUrl = javax.servlet.http.HttpUtils.getRequestURL(request).toString(); 
	String serviceServletPath = request.getServletPath();
	int i = fullUrl.indexOf(serviceServletPath);
	String serviceURL = fullUrl.substring(0,i) + "/";
	
	//����� ���� 
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
		returnURL = nextPage;	// �α����Ŀ� ���������� �������� ��������
	}	
	

	// ����� ���� ó�� ���̵� �н����尡 ��ġ�ϴ� ���
	if(f_id.equals(userid) && f_pass!=null && f_pass.equals(passwd)){

		session.setAttribute("userid", userid);
		com.tmax.eam.SessionInfo sessioninfo = SSOTokenManager.getSSOServerSessionInfo(userid,Common.COMMON);
		
		//���� tmax session�� ���� �� ���.
		if(sessioninfo != null){	
	
			String logout2URL = serviceURL + "logout.jsp";
			
			// ���� ����IP Ȯ��	
			String Pre_IP = sessioninfo.clientIp; // �������ǿ� ��ϵ� IP
			boolean IP_Check = Pre_IP.equals(request.getRemoteAddr()); // ���� ������ Ŭ���̾�Ʈ IP �� ��
			
			// ���� ����SessionID Ȯ��
			String sessionidx = sessioninfo.sessionId;
			boolean Session_Check = sessionidx.equals(session.getId());  // ���� ���ǰ� ��
		
		
%>
		<html>
			<script>
				function tmaxeam_submit(){
<%
					if(IP_Check){
							
						if(!Session_Check){
							%>                          
								if(confirm('�̹� �ٸ� �������� ���� �α����� �Ǿ� �ֽ��ϴ�.\n���� �α����� ����ϰ� ���Ӱ� �α��� �Ͻðڽ��ϱ�?\n\n�α��� ID:<%=userid%>')){
									<%=Common.SUBMIT_SCRIPT%>
								}else{
									<!-- ���� ������ �����Ѵ�. �̶� ȣ��Ǵ� logout �������� SSO Token ��� API�� ȣ������ �ʰ� ���� ���� ���Ǹ� �����Ų��.-->
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
							if(confirm('�̹� �ٸ�IP���� �α����� �Ǿ� �ֽ��ϴ�.\n���� �α����� ����ϰ� ���Ӱ� �α��� �Ͻðڽ��ϱ�?\n\n�α���IP:<%=Pre_IP%>, �α��� ID:<%=userid%>')){
								<%=Common.SUBMIT_SCRIPT%>
							}else{
								<!-- ���� ������ �����Ѵ�. �̶� ȣ��Ǵ� logout �������� SSO Token ��� API�� ȣ������ �ʰ� ���� ���� ���Ǹ� �����Ų��.-->
								document.location.href='<%=logout2URL%>';
							}
						<%
					}
%>
   
				} //tmaxeam_submit
			</script>
				
				<body onload='tmaxeam_submit()'>
					//Common.SUBMIT_SCRIPT ���� submit�� ������ �Ʒ��� ��µǰ� ��
					//���� ���� ��� �� ���ο� ��ū ���� �� ���
					<%=SSOTokenManager.getIssueTokenWOSMsg(request, f_id, Common.COMMON, returnURL)%>
				</body>    
		 </html>

				<%
				return;     
					
		} 
		
		// ��ū�� �߱� �Ѵ�.	
		if (SSOTokenManager.issueToken(request, out, f_id, Common.COMMON, etc, returnURL)) {
			return;
		}else{
			%><html><script>alert('token registration failure');document.location.href='first.jsp';</script></html><%
		}
		
	
	} else {
	//���̵� �н����尡 ���� ���� ���.
	%><html><body><br><br><center><font color=red>Login Failure</font></center></body></html><%
		return;
	}
%>

