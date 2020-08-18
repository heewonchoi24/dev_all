<%@ page contentType="text/html; charset=euc-kr"%>
<%@page import="java.util.Enumeration" %>
<%@page import="com.tmax.eam.*" %>
<%@page import="javax.servlet.http.*" %>

<%
	String f_id = request.getParameter("f_id");
	String f_pass = request.getParameter("f_pass");
	String id=(String)session.getAttribute("userid");

	String sf_id ="";
	String sf_pass="";
	
	if(id != null && id.length() != 0){
%>
	<html><script>alert("이미 로그인된 사용자 입니다. first.jsp로 이동합니다!");document.location.href="/sso/first.jsp";</script></html>
<%   	return; 
	}
%>
<html>
<head>
<script>
function send()
{
<%
request.setAttribute("sf_id",f_id);
request.setAttribute("sf_pass",f_pass);
%>
<%--
session.setAttribute("sf_id","test-id");
session.setAttribute("sf_pass","test-pass");
--%>
document.f.submit();
}
</script>
</head>
	<body onload='tmaxeam_submit()' >
		<form name='f' action=login.jsp method=post>
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
					<center>
					<h3>일반사이트의 사용자 인증 (SSO Agent2 시스템)</h3>
					</center>
					<br>
				</tr>
			</table>	
			<table width="800" border="0" cellpadding="0" cellspacing="0">
				<tr><td style="font-size:10pt;"  width="400" height=30 align="right">사용자 계정&nbsp;</td><td style="font-size:10pt;" ><input type=text name=f_id value='SSOUser'></td></tr>
				<tr><td style="font-size:10pt;"  width="400" height=30 align="right">사용자 암호&nbsp;</td><td style="font-size:10pt;" ><input type=password name=f_pass value='test'></td></tr>
				<tr><td style="font-size:10pt;"  colspan=2 height=20 ></td></tr>
				<tr><td style="font-size:10pt;"  colspan=2 align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=reset value="다시입력">&nbsp;<input type=button onclick='send();' value="인증요청"></td></tr>
			</table>
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
		</form>	
	</body>
</html>
