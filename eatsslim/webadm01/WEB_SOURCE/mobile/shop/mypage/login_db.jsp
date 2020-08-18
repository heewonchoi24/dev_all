<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.*,java.text.*"%>
<%@ page import="java.sql.*, java.util.Vector"%>
<%@ page import="com.pulmuone.encrypt.*"%>
<%@ include file="/lib/config.jsp"%>
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

Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //오늘
String cDate			= (new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());
String table		= "ESL_MEMBER";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null; 
stmt1				= conn.createStatement();
String mode			= ut.inject(request.getParameter("mode"));
String memberId		= ut.inject(request.getParameter("member_id"));
String memberPw		= ut.inject(request.getParameter("member_pw"));
String returnUrl	= ut.inject(request.getParameter("return_url"));
if (returnUrl == null || returnUrl.equals("") || returnUrl.equals("null")) {
	returnUrl			= "/mobile/index.jsp";
}
String saveId		= ut.inject(request.getParameter("save_id"));
String enc_memberPw	= "";
String userIp		= request.getRemoteAddr();
String memberIdx	= "";
String memberName	= "";
String customerNum	= "";
int couponCnt		= 0;
String couponNum	= "";

if (mode.equals("login")) {
	EncryptHash enc	= new EncryptHash();
	enc_memberPw	= enc.pEncrypt(memberPw);

	query			= "SELECT ID, MEM_ID, MEM_NAME, MEM_PW, CUSTOMER_NUM FROM "+ table +"";
	query			+= " WHERE MEM_ID = '"+ memberId +"'";
	try {
		rs = stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e);
		if (true) return;
	}

	if (rs.next()) {
		if (rs.getString("MEM_PW").equals(enc_memberPw)) {
			memberIdx		= rs.getString("ID");
			memberId		= rs.getString("MEM_ID");			
			memberName		= rs.getString("MEM_NAME");
			customerNum		= rs.getString("CUSTOMER_NUM");

			query1			= "UPDATE "+ table +" SET LAST_LOGIN_DATE = NOW(),";
			query1			+= "			LAST_LOGIN_IP = '"+ userIp +"'";
			query1			+= "	WHERE ID = "+ memberIdx;
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e);
				if (true) return;
			}

			session.setMaxInactiveInterval(60*60*24*30);
			session.setAttribute("esl_member_idx", memberIdx);
			session.setAttribute("esl_member_id", memberId);
			session.setAttribute("esl_member_name", memberName);
			session.setAttribute("esl_customer_num", customerNum);
			out.println("<script src='//code.jquery.com/jquery-1.9.1.min.js'></script>");
			out.println("<script type='text/javascript' src='/common/js/jquery.cookie.js'></script>");

			if (saveId.equals("Y")) {
				out.println("<script>$.cookie('userLoginId', '"+ memberId +"', {expires: 365, path: '/'});</script>");
			} else {
				out.println("<script>$.removeCookie('userLoginId', {path: '/'});</script>");
			}

			// 로그인 시 쿠폰 지급을 위한 소스
			if (Integer.parseInt(cDate) >= 20141017 && Integer.parseInt(cDate) <= 20141030) {
				query		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
				query		+= " WHERE MEMBER_ID = '"+ memberId +"' AND COUPON_ID = 988";
				try {
					rs		= stmt.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs.next()) {
					couponCnt	= rs.getInt(1);
				}
				rs.close();

				if (couponCnt > 0) {
				} else {
					SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
					couponNum		= "ET" + dt.format(new Date()) + "001";

					query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
					query		+= " VALUES (988,'"+ couponNum +"','"+ memberId +"','N',NOW())";
					try {
						stmt.executeUpdate(query);
					} catch (Exception e) {
						out.println(e);
						if(true)return;
					}
				}
				rs.close();
			}

			ut.jsRedirect(out, returnUrl);
		} else {
			ut.jsAlert(out, "아이디 또는 비밀번호를 확인하세요.");
			ut.jsBack(out);
		}
	}
%>
<%@ include file="/lib/dbclose.jsp"%>
<%
} else if (mode.equals("logout")) {
	session.invalidate();
	ut.jsRedirect(out, "/mobile/index.jsp");
} else {
	ut.jsRedirect(out, "/mobile/");
}
%>