<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("UTF-8");

String table			= "ESL_MEMBER";
String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
String mode				= ut.inject(request.getParameter("mode"));
String name				= ut.inject(request.getParameter("userName"));
String hp1				= ut.inject(request.getParameter("htel1"));
String hp2				= ut.inject(request.getParameter("htel2"));
String hp3				= ut.inject(request.getParameter("htel3"));
String hp				= hp1 +"-"+ hp2 +"-"+ hp3;
String emailId			= ut.inject(request.getParameter("email1"));
String emailAddr		= ut.inject(request.getParameter("email2"));
String email			= emailId +"@"+ emailAddr;
String smsYn 			= request.getParameter("memSmsYn");
String emailYn 			= request.getParameter("memEmailYn");
String chk_email_mod 	= request.getParameter("emailMod");
//String userIp			= request.getRemoteAddr();
String customerNum		= "";

if (mode != null) {

	if ( mode.equals("mod") ) {
		try {
			query  = "UPDATE "+ table +" SET ";
			query += " mem_name	= ?, ";
			query += " hp					= ?, ";
			query += " email				= ?, ";
			query += " sms_yn			= ?, ";
			query += " email_yn		= ? ";
			query += " WHERE mem_id = ?";

			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, name);
			pstmt.setString(2, hp);
			pstmt.setString(3, email);
			pstmt.setString(4, smsYn);	
			pstmt.setString(5, emailYn);	
			pstmt.setString(6, eslMemberId);	
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e+"=>"+query);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}

		ut.jsAlert(out, "������ ������ �Ϸ�Ǿ����ϴ�.");
		ut.jsRedirect(out, "/");
	}
}
%>
<%@ include file="/lib/dbclose.jsp" %>