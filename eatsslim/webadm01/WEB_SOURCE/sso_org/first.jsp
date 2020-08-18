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
				<h3>Main 페이지 입니다. (SSO Agent2 시스템) : <%=id%> </h3>
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
				-. &nbsp;정상적으로 사용자(<%=id%>) 토큰이 발급 되어 SSO Agent Session 에 등록(로그인) 되었습니다. 
				</td>
			</tr>
			<tr>
				<td style="font-size:9pt;"  colspan=2 >
				-. &nbsp;아래 "SSO Agent1 시스템" 링크를 선택 하여 토큰 분배를 확인 하실 수 있습니다.  
				</td>
			</tr>	
			</tr>
				<tr>
				<td style="font-size:9pt;"  colspan=2 >
				-. &nbsp;아래 "페이지로 이동"을 선택 하면 새로 토큰 생성하고, 업데이트를 수행한 후 업무 페이지로 이동 합니다.   
				</td>
				
			</tr>
		</table>	
		
		<br>
		<br>

		<table width="800" border="0" cellpadding="0" cellspacing="0">
			
			<tr>
				
				<td style="font-size:10pt;"  colspan=2 >
				&nbsp; &nbsp; &nbsp; &nbsp; 
				<a href="logout.jsp" >로그아웃</a>
				&nbsp; &nbsp; &nbsp; &nbsp; 
				<a href="http://192.1.5.171:8026/first.jsp" target="_blank">SSO Agent1 시스템(다른 Agent를 이용한 토큰 분배)</a>
				<br>
				<br> 
				&nbsp; &nbsp; &nbsp; &nbsp; 
				<a href="third.jsp" > 업무 페이지로 이동</a> 
				&nbsp; &nbsp; &nbsp; &nbsp; 
				<a href="second.jsp" > 토큰생성/업데이트</a>
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
		         <em>Copyrightⓒ2008 TmaxSoft Co., Ltd. All Rights Reserved. <br> TmaxSoft Co., Ltd.</em>
		        </font>
		       </td>
		   </tr>
		</table>
</body>
</HTML>
