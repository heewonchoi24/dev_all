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

String table	= "ESL_ADMIN";
String query;
String query1;
String mode		= ut.inject(request.getParameter("mode"));
String adminId	= ut.inject(request.getParameter("admin_id"));
String adminPw	= ut.inject(request.getParameter("admin_pw"));
String saveId	= ut.inject(request.getParameter("save_id"));
String userIp	= request.getRemoteAddr();

if (mode.equals("login")) {
	query			= "SELECT ID, ADMIN_ID, ADMIN_NAME, ADMIN_MENU FROM "+ table +" WHERE ADMIN_ID = ? AND ADMIN_PW = PASSWORD(?)";
	pstmt			= conn.prepareStatement(query);
	pstmt.setString(1, adminId);
	pstmt.setString(2, adminPw);
	rs				= pstmt.executeQuery();

	if (rs.next()) {
		int adminIdx;
		String adminName;
		String adminMenu;
		PreparedStatement pstmt1	= null;

		adminIdx		= rs.getInt("ID");
		adminId			= rs.getString("ADMIN_ID");			
		adminName		= rs.getString("ADMIN_NAME");
		adminMenu		= rs.getString("ADMIN_MENU");

		try {
			query1			= "UPDATE "+ table +" SET LAST_LOGIN_DATE = NOW(),";
			query1			+= "			LAST_LOGIN_IP = ?";
			query1			+= "	WHERE ID = ?";
			pstmt1			= conn.prepareStatement(query1);
			pstmt1.setString(1, userIp);
			pstmt1.setInt(2, adminIdx);
			pstmt1.executeUpdate();

			pstmt1.close();

			session.setMaxInactiveInterval(60*60*24*30);
			session.setAttribute("esl_admin_id", adminId);
			session.setAttribute("esl_admin_name", adminName);
			session.setAttribute("esl_admin_menu", adminMenu);
			out.println("<script type='text/javascript' src='js/jquery-1.8.3.min.js'></script>");
			out.println("<script type='text/javascript' src='js/jquery.cookie.js'></script>");

			if (saveId.equals("Y")) {
				out.println("<script>$.cookie('loginId', '"+ adminId +"', {expires: 365, path: '/'});</script>");
			} else {
				out.println("<script>$.removeCookie('loginId', {path: '/'});</script>");
			}

			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
			if (conn != null) try { conn.close(); } catch (Exception e) {}

			ut.jsRedirect(out, "main/index.jsp");
		} catch (Exception e) {
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		} finally {
			if (pstmt1 != null) try { pstmt1.close(); } catch (Exception e) {}
			if (conn != null) try { conn.close(); } catch (Exception e) {}
		}
	} else {
		ut.jsAlert(out, "아이디 또는 비밀번호를 확인하세요.");
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