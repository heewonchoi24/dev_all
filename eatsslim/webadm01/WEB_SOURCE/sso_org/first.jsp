<%@ page contentType = "text/html; charset=euc-kr" %>

<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@page import="com.tmax.eam.*"%>
<%
	
	String id=(String) session.getAttribute("userid");



	String nextPage = (String)request.getParameter(Common.PARAM_NEXTURL);
	String fullUrl = javax.servlet.http.HttpUtils.getRequestURL(request).toString(); 
	String serviceServletPath = request.getServletPath();
	int i = fullUrl.indexOf(serviceServletPath);
	String serviceURL = fullUrl.substring(0,i) + "/";

	if(nextPage==null) {
		nextPage="first.jsp";
	} else {
		nextPage = Common.decode(nextPage);
	}
	int urllength=nextPage.length();
	String urltest="https"+nextPage.substring(4,urllength);

//=====================================================================================================================


	//String sprotocol=%><html><script>document.location.protocol</script></html><%;
	//if( sprotocol == "https:")
	//{
	//int URLLen=+returnURL.length();
	//String httpsUrl="https"++returnURL.substring(4,URLLen);
	//}

	String sf_id=(String)request.getAttribute("sf_id");
	String sf_pass=(String)request.getAttribute("sf_pass");



//=====================================================================================================================


	if(id==null || id.length()==0){
%>
	<html><script>alert("no auth info for this website");document.location.href="index.jsp";</script></html>
<%
		return;
	}
%>

<html>
	<head>
	<meta http-equiv="Pragma" content="no-cache">

<script>alert("protocol : "+ document.location.protocol );</script>
	</head>
	<body>
		
		
		<table width="800" border="0" cellpadding="0" cellspacing="0" >
 			<tr>
 				<td style="font-size:10pt;" background="images/sso.jpg"  width="800" height="65" ></td>
 			</tr>
 			<tr><td style="font-size:10pt;" ><hr noshade="noshade" size="1"/></td></tr>
		</table>
		
		<table width="800" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<br>
				<br>
				<h3>Main ������ �Դϴ�. (SSO Agent2 �ý���) : <%=id%> </h3>
				<br>testurl = <%=urltest%> 
				<br>
				<br>## session test ##
				<br>sf_id = <%=sf_id%>
				<br>sf_pass = <%=sf_pass%>
			</tr>
		</table>
		
		
		<table width="800" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td style="font-size:9pt;"  colspan=2 >
				-. &nbsp;���������� �����(<%=id%>) ��ū�� �߱� �Ǿ� SSO Agent Session �� ���(�α���) �Ǿ����ϴ�. 
				</td>
			</tr>
			<tr>
				<td style="font-size:9pt;"  colspan=2 >
				-. &nbsp;�Ʒ� "SSO Agent1 �ý���" ��ũ�� ���� �Ͽ� ��ū �й踦 Ȯ�� �Ͻ� �� �ֽ��ϴ�.  
				</td>
			</tr>	
			</tr>
				<tr>
				<td style="font-size:9pt;"  colspan=2 >
				-. &nbsp;�Ʒ� "�������� �̵�"�� ���� �ϸ� ���� ��ū �����ϰ�, ������Ʈ�� ������ �� ���� �������� �̵� �մϴ�.   
				</td>
				
			</tr>
		</table>	
		
		<br>
		<br>

		<table width="800" border="0" cellpadding="0" cellspacing="0">
			
			<tr>
				
				<td style="font-size:10pt;"  colspan=2 >
				&nbsp; &nbsp; &nbsp; &nbsp; 
				<a href="logout.jsp" >�α׾ƿ�</a>
				&nbsp; &nbsp; &nbsp; &nbsp; 
				<a href="http://192.1.5.171:8026/first.jsp" target="_blank">SSO Agent1 �ý���(�ٸ� Agent�� �̿��� ��ū �й�)</a>
				<br>
				<br> 
				&nbsp; &nbsp; &nbsp; &nbsp; 
				<a href="third.jsp" > ���� �������� �̵�</a> 
				&nbsp; &nbsp; &nbsp; &nbsp; 
				<a href="second.jsp" > ��ū����/������Ʈ</a>
				&nbsp; &nbsp; &nbsp; &nbsp; 
				</td>
				
			</tr>

		</table>
		
		<br>
		<br>
		<br>
		<br>

		<table width="800" border="0" cellspacing="0" cellpadding="2" >
		   <tr><td style="font-size:10pt;"  colspan="2"><hr noshade="noshade" size="1"/></td></tr>
		   <tr><td style="font-size:10pt;"  colspan="2" align="center">
		        <font size="-1">
		         <em>Copyright��2008 TmaxSoft Co., Ltd. All Rights Reserved. <br> TmaxSoft Co., Ltd.</em>
		        </font>
		       </td>
		   </tr>
		</table>
</body>
</HTML>
