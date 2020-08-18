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
<%@ include file="/lib/dbconn_kakao.jsp"%>
<%

	request.setCharacterEncoding("UTF-8");

	String memName = request.getParameter("memName");
	String memNum = request.getParameter("memNum");
	String memEmail = request.getParameter("memEmail");
	String memHp = request.getParameter("memHp");
	String smsYn = request.getParameter("memSmsYn");
	String emailYn = request.getParameter("memEmailYn");
	String chk_email_mod = request.getParameter("emailMod");
	Calendar cal = Calendar.getInstance();
	String stdate			= (new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());

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
		
		// 회원가입 시 쿠폰 지급을 위한 소스
		int	cnIdx = 1;
		String endDate = "";
		query		= "SELECT ID, DATE_FORMAT(ltdate, '%Y-%m-%d') as endDate FROM ESL_COUPON  ";
		query		+= "	WHERE STDATE <= '"+ stdate +"' AND LTDATE >= '"+ stdate +"' ";
		query		+= "		AND VENDOR = '06'  ";

		try {
			rs		= stmt.executeQuery(query);
			
			SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
			String couponNum		= "ET" + dt.format(new Date());
			
			String couponNumStr = ""; 

			while (rs.next()) {
				endDate = rs.getString("endDate");
				cnIdx++;
			}

		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		rs.close();
		
		if ( cnIdx > 1) {
		
			query		= "INSERT INTO CUST_DELV_ALL.TSMS_AGENT_MESSAGE ("; 
			query		+= " MESSAGE_SEQNO, SERVICE_SEQNO";
			query		+= " ,SEND_MESSAGE";
			query		+= " ,SUBJECT,BACKUP_MESSAGE,TEMPLATE_CODE";
			query		+= " ,BACKUP_PROCESS_CODE,MESSAGE_TYPE,CONTENTS_TYPE,RECEIVE_MOBILE_NO";
			query		+= " ,CALLBACK_NO,JOB_TYPE,SEND_RESERVE_DATE,REGISTER_DATE";
			query		+= " ,REGISTER_BY, SEND_FLAG, KKO_BTN_NAME, KKO_BTN_URL, TAX_LEVEL1_NM ,TAX_LEVEL2_NM";
			query		+= " ) VALUES (";
			query		+= " CUST_DELV_ALL.TSMS_MESSAGE_SEQ.nextval ,'1710002662'";
			
			query		+= " ,'[풀무원잇슬림] 잇슬림에 가입해주셔서 감사합니다. \r잇슬림과 함께 건강하고 맛있는 칼로리 조절을 시작해보세요! (하트뿅)\r\r▶ 가입일 : " + stdate + "\r\r바로 사용가능한 쿠폰도 발급해드렸어요~(굿)\r\r▶ 쿠폰종료일 : "+endDate+"\r * 쿠폰확인 : 로그인>마이페이지>쿠폰리스트'";
			query		+= " ,'[풀무원잇슬림] 가입감사 쿠폰 안내','[풀무원잇슬림] 잇슬림에 가입해주셔서 감사합니다. \r잇슬림과 함께 건강하고 맛있는 칼로리 조절을 시작해보세요! (하트뿅)\r\r▶ 가입일 : "+ stdate +"\r\r바로 사용가능한 쿠폰도 발급해드렸어요~(굿)\r\r▶ 쿠폰종료일 : "+endDate+"\r * 쿠폰확인 : 로그인>마이페이지>쿠폰리스트'";
			query		+= " ,'eat23'";
			
			query		+= ",'001','002','004','" + memHp + "'";
			query		+= " ,'02-6411-8322','R00',SYSDATE,SYSDATE";
			query		+= " ,'kakao_es','N','잇슬림홈페이지','http://www.eatsslim.co.kr/mobile/index.jsp','','')";
			
			try {
					stmt_kakao.executeUpdate(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}	
		}		

		ut.jsAlert(out, "잇슬림 회원가입이 완료되었습니다.");
		ut.jsRedirect(out, "/");
	}


%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_tbr.jsp"%>
<%@ include file="/lib/dbclose_kakao.jsp" %>