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
	String stdate			= (new SimpleDateFormat("yyyy-MM-dd 00:00")).format(cal.getTime());
	cal.add(Calendar.DATE, 3);
	String etdate			= (new SimpleDateFormat("yyyy-MM-dd 23:59")).format(cal.getTime());
	String query = "";
	String snsNowDate			= (new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
	
	int couponCnt			= 0;
	int couponId			= 0;
	int couponId2			= 0;
	int couponId3			= 0;


	if ( !"".equals(memNum) ) {

		try {
				query  = "UPDATE ESL_MEMBER SET ";
				query += " MEM_NAME			= ?, ";
			if ( "Y".equals(chk_email_mod) ) {    //�̸����� �Է��� ���
				query += " EMAIL					= ?, ";
			}
				query += " HP						= ?, ";
				query += " SMS_YN				= ?, ";
				query += " EMAIL_YN			= ? ";
				query += " WHERE CUSTOMER_NUM = ?";

				pstmt = conn.prepareStatement(query);

			if ( "Y".equals(chk_email_mod) ) {    //�̸����� �Է��� ���
				pstmt.setString(1, memName);
				pstmt.setString(2, memEmail);
				pstmt.setString(3, memHp);
				pstmt.setString(4, smsYn);
				pstmt.setString(5, emailYn);
				pstmt.setInt(6, Integer.parseInt(memNum));

			}else{    //�̸��� �Է� ���� ���

				pstmt.setString(1, memName);
				pstmt.setString(2, memHp);
				pstmt.setString(3, smsYn);
				pstmt.setString(4, emailYn);
				pstmt.setInt(5, Integer.parseInt(memNum));
			}

				pstmt.executeUpdate();

		} catch (Exception e) {
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}
		
		// ȸ������ �� ���� ������ ���� �ҽ�
		int	cnIdx = 1;
		//String endDate = "";
		String couponNumStr = "";
		SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
		String couponNum		= "ET" + dt.format(new Date());

		query		= "SELECT ID, DATE_FORMAT(ltdate, '%Y-%m-%d %H:%i') as endDate FROM ESL_COUPON  ";
		query		+= "	WHERE STDATE <= '"+ stdate +"' AND LTDATE >= '"+ stdate +"' ";
		query		+= "		AND VENDOR = '06'  ";

		try {
			rs		= stmt.executeQuery(query);
		
			while (rs.next()) {
				
				if (cnIdx < 10) {
					couponNumStr		= "00" + Integer.toString(cnIdx);
				} else if (cnIdx < 100) {
					couponNumStr		= "0" + Integer.toString(cnIdx);
				} else {
					couponNumStr		= Integer.toString(cnIdx);
				}
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (?,?,?,'N',NOW())";
				try {
					pstmt	= conn.prepareStatement(query);
					pstmt.setInt(1, rs.getInt("ID") );
					pstmt.setString(2, couponNum+couponNumStr);
					pstmt.setString(3, eslMemberId);
					pstmt.executeUpdate();
				} catch (Exception e) {
					out.println(e);
					if(true)return;
				}				
				
				//endDate = rs.getString("endDate");
				cnIdx++;
			}

		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		rs.close();
		
		/*
		query		= "SELECT COUNT(ID) FROM ESL_COUPON";
		query		+= " WHERE COUPON_NAME like '[��������] 2õ�� ��������'";
		query		+= " AND VENDOR = '90' AND STDATE = '" + stdate + "'";
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

		if (couponCnt == 0) {	

			query		= "INSERT INTO ESL_COUPON ";
			query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
			query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE, RAND_NUM_TYPE, ORDERWEEK)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?)";
			pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, "[��������] 2õ�� ��������");
			pstmt.setString(2, "01");
			pstmt.setString(3, stdate);
			pstmt.setString(4, etdate);
			pstmt.setString(5, "90");
			pstmt.setString(6, "W");
			pstmt.setInt(7, 2000);
			pstmt.setString(8, "Y");
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 60000);
			pstmt.setString(11, "01");
			pstmt.setInt(12, 0);
			pstmt.setString(13, "admin");
			pstmt.setString(14, "127.0.0.1");
			pstmt.setString(15, "G");
			pstmt.setString(15, "1,2,4,8,");
			pstmt.executeUpdate();		
			try {
				rs			= pstmt.getGeneratedKeys();
				if (rs.next()) {
					couponId		= rs.getInt(1);
				}
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}
			rs.close();
			
			query		= "INSERT INTO ESL_COUPON ";
			query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
			query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE, RAND_NUM_TYPE, ORDERWEEK)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?m ?)";
			pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, "[��������] 5õ�� ��������");
			pstmt.setString(2, "01");
			pstmt.setString(3, stdate);
			pstmt.setString(4, etdate);
			pstmt.setString(5, "90");
			pstmt.setString(6, "W");
			pstmt.setInt(7, 5000);
			pstmt.setString(8, "Y");
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 120000);
			pstmt.setString(11, "01");
			pstmt.setInt(12, 0);
			pstmt.setString(13, "admin");
			pstmt.setString(14, "127.0.0.1");
			pstmt.setString(15, "G");
			pstmt.setString(16, "1,2,4,8");
			pstmt.executeUpdate();		
			try {
				rs			= pstmt.getGeneratedKeys();
				if (rs.next()) {
					couponId2		= rs.getInt(1);
				}
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}
			rs.close();
			
			query		= "INSERT INTO ESL_COUPON ";
			query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
			query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE, RAND_NUM_TYPE, ORDERWEEK)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?)";
			pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, "[��������] 15õ�� ��������");
			pstmt.setString(2, "01");
			pstmt.setString(3, stdate);
			pstmt.setString(4, etdate);
			pstmt.setString(5, "90");
			pstmt.setString(6, "W");
			pstmt.setInt(7, 15000);
			pstmt.setString(8, "Y");
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 300000);
			pstmt.setString(11, "01");
			pstmt.setInt(12, 0);
			pstmt.setString(13, "admin");
			pstmt.setString(14, "127.0.0.1");
			pstmt.setString(15, "G");
			pstmt.setString(16, "1,2,4,8");
			pstmt.executeUpdate();		
			try {
				rs			= pstmt.getGeneratedKeys();
				if (rs.next()) {
					couponId3		= rs.getInt(1);
				}
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}
			rs.close();
		} else {			
			
			query		= "SELECT ID FROM ESL_COUPON";
			query		+= " WHERE COUPON_NAME like '[��������] 2õ�� ��������'";
			query		+= " AND VENDOR = '90' AND STDATE = '" + stdate + "'";
			try {
				rs		= stmt.executeQuery(query);
				
				if (rs.next()) {
					couponId		= rs.getInt(1);
				}
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
			
			query		= "SELECT ID FROM ESL_COUPON";
			query		+= " WHERE COUPON_NAME like '[��������] 5õ�� ��������'";
			query		+= " AND VENDOR = '90' AND STDATE = '" + stdate + "'";
			try {
				rs		= stmt.executeQuery(query);
				
				if (rs.next()) {
					couponId2		= rs.getInt(1);
				}
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			query		= "SELECT ID FROM ESL_COUPON";
			query		+= " WHERE COUPON_NAME like '[��������] 15õ�� ��������'";
			query		+= " AND VENDOR = '90' AND STDATE = '" + stdate + "'";
			try {
				rs		= stmt.executeQuery(query);
				
				if (rs.next()) {
					couponId3		= rs.getInt(1);
				}
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}			
		}
		
		query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
		query		+= " VALUES (?,?,?,'N',NOW())";
		try {

			if (cnIdx < 10) {
				couponNumStr		= "00" + Integer.toString(cnIdx);
			} else if (cnIdx < 100) {
				couponNumStr		= "0" + Integer.toString(cnIdx);
			} else {
				couponNumStr		= Integer.toString(cnIdx);
			}				
			
			pstmt	= conn.prepareStatement(query);
			pstmt.setInt(1, couponId );
			pstmt.setString(2, couponNum+couponNumStr);
			pstmt.setString(3, eslMemberId);
			pstmt.executeUpdate();
			
			cnIdx++;
		} catch (Exception e) {
			out.println(e);
			if(true)return;
		}
		
		query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
		query		+= " VALUES (?,?,?,'N',NOW())";
		try {

			if (cnIdx < 10) {
				couponNumStr		= "00" + Integer.toString(cnIdx);
			} else if (cnIdx < 100) {
				couponNumStr		= "0" + Integer.toString(cnIdx);
			} else {
				couponNumStr		= Integer.toString(cnIdx);
			}				
			
			pstmt	= conn.prepareStatement(query);
			pstmt.setInt(1, couponId2 );
			pstmt.setString(2, couponNum+couponNumStr);
			pstmt.setString(3, eslMemberId);
			pstmt.executeUpdate();
			
			cnIdx++;
		} catch (Exception e) {
			out.println(e);
			if(true)return;
		}

		query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
		query		+= " VALUES (?,?,?,'N',NOW())";
		try {

			if (cnIdx < 10) {
				couponNumStr		= "00" + Integer.toString(cnIdx);
			} else if (cnIdx < 100) {
				couponNumStr		= "0" + Integer.toString(cnIdx);
			} else {
				couponNumStr		= Integer.toString(cnIdx);
			}				
			
			pstmt	= conn.prepareStatement(query);
			pstmt.setInt(1, couponId3 );
			pstmt.setString(2, couponNum+couponNumStr);
			pstmt.setString(3, eslMemberId);
			pstmt.executeUpdate();
			
			cnIdx++;
		} catch (Exception e) {
			out.println(e);
			if(true)return;
		}	
		*/
		
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
			
			query		+= " ,'[Ǯ�����ս���] �ս����� �������ּż� �����մϴ�. \r�ս����� �Բ� �ǰ��ϰ� ���ִ� Į�θ� ������ �����غ�����! (��Ʈ��)\r\r�� ������ : " + snsNowDate + "\r\r�ٷ� ��밡���� ������ �߱��ص�Ⱦ��~(��)\r\r�� ���������� : "+etdate+"\r * ����Ȯ�� : �α���>����������>��������Ʈ'";
			query		+= " ,'[Ǯ�����ս���] ���԰��� ���� �ȳ�','[Ǯ�����ս���] �ս����� �������ּż� �����մϴ�. \r�ս����� �Բ� �ǰ��ϰ� ���ִ� Į�θ� ������ �����غ�����! (��Ʈ��)\r\r�� ������ : "+ snsNowDate +"\r\r�ٷ� ��밡���� ������ �߱��ص�Ⱦ��~(��)\r\r�� ���������� : "+etdate+"\r * ����Ȯ�� : �α���>����������>��������Ʈ'";
			query		+= " ,'eat23'";
			
			query		+= ",'001','002','004','" + memHp + "'";
			query		+= " ,'02-6411-8322','R00',SYSDATE,SYSDATE";
			query		+= " ,'kakao_es','N','�ս���Ȩ������','http://www.eatsslim.co.kr/mobile/index.jsp','','')";
			
			try {
					stmt_kakao.executeUpdate(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}	
		}		

		ut.jsAlert(out, "�ս��� ȸ�������� �Ϸ�Ǿ����ϴ�.");
		ut.jsRedirect(out, "/");
	}


%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_tbr.jsp"%>
<%@ include file="/lib/dbclose_kakao.jsp" %>