<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="lib/config.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

if (request.getHeader("REFERER")==null) {
	ut.jsAlert(out, "���������� ������ ���ֽʽÿ�.");
	ut.jsBack(out);
	if (true) return;
} else if(request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	ut.jsAlert(out, "���������� ������ ���ֽʽÿ�.");
	ut.jsBack(out);
	if (true) return;
}

String table	= "ESL_ADMIN";
String query;
String query1;
String mode		= ut.inject(request.getParameter("mode"));
String adminId	= ut.inject(request.getParameter("admin_id"));
String adminPw	= ut.inject(request.getParameter("admin_pw"));
String saveId	= ut.inject(request.getParameter("save_id"));
String userIp	= request.getRemoteAddr();

if (mode.equals("login")) {
	if (adminId.equals("coupang") && adminPw.equals("znvkd!@#")) {
		session.setMaxInactiveInterval(60*60*24*30);
		session.setAttribute("cp_admin_id", adminId);
		out.println("<script type='text/javascript' src='js/jquery-1.8.3.min.js'></script>");
		out.println("<script type='text/javascript' src='js/jquery.cookie.js'></script>");

		if (saveId.equals("Y")) {
			out.println("<script>$.cookie('vendorId', '"+ adminId +"', {expires: 365, path: '/'});</script>");
		} else {
			out.println("<script>$.removeCookie('vendorId', {path: '/'});</script>");
		}

		ut.jsRedirect(out, "promotion/coupon_list.jsp");
	} else {
		ut.jsAlert(out, "���̵� �Ǵ� ��й�ȣ�� Ȯ���ϼ���.");
		ut.jsBack(out);
	}
%>
<%@ include file="lib/dbclose.jsp"%>
<%
} else if (mode.equals("logout")) {
	session.invalidate();
	ut.jsRedirect(out, "login.jsp");
} else {
	ut.jsRedirect(out, "/");
}
%>