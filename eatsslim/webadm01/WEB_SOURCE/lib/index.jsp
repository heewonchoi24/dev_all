<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="KISA_SHA256.jsp" %>

<%

byte[] defaultCipherText = Sha256EncryptB(defaultPlainText);

String method = request.getParameter("method");
String encrypt_plainText = "";
String encrypt_cipherText = "";
String encrypt_cipherText_base64 = "";

if(method != null && method.equals("e")) {
	String plainTextStr = request.getParameter("encrypt_plainText");
	byte[] plainText = plainTextStr.getBytes("UTF-8");
	String cipherTextStr = getString(Sha256EncryptB(plainText));
 
	encrypt_plainText = plainTextStr;
	encrypt_cipherText = cipherTextStr;
	encrypt_cipherText_base64 = Sha256Encrypt(plainText);
	
}



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>SHA256 Example</title>
<script type="text/javascript">
function encrypt()
{
	var frm = document.myform;
	document.getElementById("method").value = "e";
	frm.submit();
}


</script>
</head>
<body>

<center>
<h1>[SHA256] 테스트 페이지</h1>
<form name="myform" method="post" action="index.jsp">
<input type="hidden" name="method" id="method" />
<table border="0">
<tr>
<td style="text-align:center;">
<table border="0">
<tr><td></td><td>&lt;암호화 예제&gt;</td></tr>
<tr>
<td>평문(String) : </td> 
<td><textarea name="encrypt_plainText" style="width:400px;height:100px;"><%=encrypt_plainText %></textarea></td>
</tr>
<tr>
<td></td>
<td><button onclick="encrypt();">▼암호화</button></td>
</tr>
<tr>
<td>암호문(HEX) : </td> 
<td><textarea name="encrypt_cipherText" style="width:400px;height:100px;"><%=encrypt_cipherText %></textarea></td>
</tr>
</table>
</td>
</tr>
</table>
<table border="0">
<tr>
</tr>
</table>
<div style="border: 1px solid #aaaaff; background-color:#ddddff;">
</div>
</form>

</center>
</body>
</html>