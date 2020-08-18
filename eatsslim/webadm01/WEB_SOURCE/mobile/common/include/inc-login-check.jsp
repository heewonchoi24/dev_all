<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
if (eslMemberId == null || eslMemberId.equals("")) {
%>
<script type="text/javascript">
var returnUrl = document.referrer;
if(returnUrl == null && returnUrl == "") returnUrl = "/";
document.cookie = "returnUrl" + "=" + escape(returnUrl) + "; path=/;";
</script>
<%
	ut.jsAlert(out, "로그인을 해주세요.");
	ut.jsRedirect(out, "/mobile/customer/login.jsp");
	if (true) return;
}
%>