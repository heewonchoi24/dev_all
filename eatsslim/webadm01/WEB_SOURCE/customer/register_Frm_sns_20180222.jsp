<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import="java.text.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_tbr.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%

	request.setCharacterEncoding("UTF-8");

	String memName = request.getParameter("memName");
	String memNum = request.getParameter("memNum");
	String memEmail = request.getParameter("memEmail");
	String memHp = request.getParameter("memHp");
	String smsYn = request.getParameter("memSmsYn");
	String emailYn = request.getParameter("memEmailYn");
	String chk_email_mod = request.getParameter("emailMod");

	String query = "";


	if ( !"".equals(memNum) ) {

		try {
				query  = "UPDATE ESL_MEMBER SET ";
				query += " MEM_NAME			= ?, ";
			if ( "Y".equals(chk_email_mod) ) {    //이메일을 입력한 경우
				query += " EMAIL					= ?, ";
			}
				query += " HP						= ?, ";
				query += " SMS_YN				= ?, ";
				query += " EMAIL_YN			= ? ";
				query += " WHERE CUSTOMER_NUM = ?";

				pstmt = conn.prepareStatement(query);

			if ( "Y".equals(chk_email_mod) ) {    //이메일을 입력한 경우
				pstmt.setString(1, memName);
				pstmt.setString(2, memEmail);
				pstmt.setString(3, memHp);
				pstmt.setString(4, smsYn);
				pstmt.setString(5, emailYn);
				pstmt.setInt(6, Integer.parseInt(memNum));

			}else{    //이메일 입력 안한 경우

				pstmt.setString(1, memName);
				pstmt.setString(2, memHp);
				pstmt.setString(3, smsYn);
				pstmt.setString(4, emailYn);
				pstmt.setInt(5, Integer.parseInt(memNum));
			}

				pstmt.executeUpdate();

		} catch (Exception e) {
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsAlert(out, "잇슬림 회원가입이 완료되었습니다.");
		ut.jsRedirect(out, "/");
	}


%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_tbr.jsp"%>