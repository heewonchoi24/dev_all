<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="lib/config.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

if (request.getHeader("REFERER")==null) {
	ut.jsAlert(out, "정상적으로 접근을 해주십시오.");
	ut.jsBack(out);
	if (true) return;
} else if(request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	ut.jsAlert(out, "정상적으로 접근을 해주십시오.");
	ut.jsBack(out);
	if (true) return;
}

String table	= "ESL_MEMBER";
String query;
String query1;
String mode		= ut.inject(request.getParameter("mode"));
String userId	= ut.inject(request.getParameter("user_id"));
String saveId	= ut.inject(request.getParameter("save_id"));
String userIp	= request.getRemoteAddr();

if (mode.equals("login")) {

	query			= "SELECT ID, MEM_ID, MEM_NAME, CUSTOMER_NUM FROM "+ table +" WHERE MEM_ID = ?";
	pstmt			= conn.prepareStatement(query);
	pstmt.setString(1, userId);
	rs				= pstmt.executeQuery();

	if (rs.next()) {
		String userIdx;
		String userName;
		String customerNum;
		PreparedStatement pstmt1	= null;

		userIdx			= rs.getString("ID");
		userId			= rs.getString("MEM_ID");			
		userName		= rs.getString("MEM_NAME");
		customerNum		= rs.getString("CUSTOMER_NUM");


		session.setMaxInactiveInterval(60*60*24*30);
		session.setAttribute("esl_member_idx", userIdx);
		session.setAttribute("esl_member_id", userId);
		session.setAttribute("esl_member_name", userName);
		session.setAttribute("esl_customer_num", customerNum);
		out.println("<script type='text/javascript' src='js/jquery-1.8.3.min.js'></script>");
		out.println("<script type='text/javascript' src='js/jquery.cookie.js'></script>");

		if (saveId.equals("Y")) {
			out.println("<script>$.cookie('frontLoginId', '"+ userId +"', {expires: 365, path: '/'});</script>");
		} else {
			out.println("<script>$.removeCookie('frontLoginId', {path: '/'});</script>");
		}

		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		if (conn != null) try { conn.close(); } catch (Exception e) {}

		ut.jsRedirect(out, "/index.jsp");
	} else {
		ut.jsAlert(out, "아이디를 확인하세요.");
		ut.jsBack(out);
	}
%>
<%@ include file="lib/dbclose.jsp"%>
<%
} else if (mode.equals("logout")) {
	session.invalidate();
	ut.jsRedirect(out, "test_login.jsp");
	if (true) return;
} else {
	ut.jsRedirect(out, "/");
	if (true) return;
}
%>