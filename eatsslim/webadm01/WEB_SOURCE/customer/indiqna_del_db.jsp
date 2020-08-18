<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_tbr.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_COUNSEL";
String query			= "";
String mode				= ut.inject(request.getParameter("mode"));
String counselID		= ut.inject(request.getParameter("counselID"));


//out.println (counselID);
//if ( true ) return;

if (mode != null) {

	if ( mode.equals("del") ) {
		query  = "UPDATE TBITF_VOICE_IF SET ";
		query += " DEL_YN				= 'Y'";
		query += " WHERE BOARD_SEQ = '"+ counselID +"' AND RECEIPT_ROOT = '10011'";
		
		try {
			stmt_tbr.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}

		try {
			query  = "DELETE FROM "+ table + " WHERE id = ?";

			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, counselID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e+"=>"+query);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsAlert(out, "1:1 문의가 삭제되었습니다.");
		ut.jsRedirect(out, "/shop/mypage/myqna.jsp");
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_tbr.jsp"%>