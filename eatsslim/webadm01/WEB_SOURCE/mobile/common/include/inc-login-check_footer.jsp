<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%
if (eslMemberId == null || eslMemberId.equals("")) {
%>
<script type="text/javascript">
var returnUrl = document.referrer;
if(returnUrl == null && returnUrl == "") returnUrl = "/";
document.cookie = "returnUrl" + "=" + escape(returnUrl) + "; path=/;";
</script>
<%
	ut.jsRedirect(out, "/sso/single_sso.jsp");
	if (true) return;
}
%>