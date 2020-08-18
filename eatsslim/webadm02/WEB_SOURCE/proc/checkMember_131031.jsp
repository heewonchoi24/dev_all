<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_mssql.jsp" %>
<%
request.setCharacterEncoding("euc-kr");
session.setMaxInactiveInterval(60*60*60);

String etc	= ut.inject(request.getParameter("id"));
if (etc == null || etc.length()==0) etc = "";

Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //����
String cDate			= (new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
String chkQuery			= "";
String query			= "";
String query1			= "";
String addQuery			= "";
String memberIdx		= "";
String moveUrl			= "https://www.eatsslim.co.kr/";
int couponCnt			= 0;
String couponNum		= "";
String preNum			= "";
int seq					= 0;

if (!etc.equals("")) {
	chkQuery	= "SELECT TOP 1";
	chkQuery	+= "	NAME, MEM_PWD, HPHONE_TYPE+'-'+HPHONE_FIRST+'-'+HPHONE_SECOND HP,";
	chkQuery	+= "	HOME_PHONEAREA+'-'+HOME_PHONEFIRST+'-'+HOME_PHONESECOND TEL, EMAIL, HOME_POST, HOME_ADDR1, HOME_ADDR2,";
	chkQuery	+= "	SEX, BIRTH_DT, SMS_YN, EMAIL_YN, A.CUSTOMER_NUM, SITE_USE";
	chkQuery	+= " FROM MEMBER_INFO A, SITE_USED_YN B";
	chkQuery	+= " WHERE A.CUSTOMER_NUM = B.CUSTOMER_NUM";
	chkQuery	+= " AND A.DEREG_APP_YN = 'N'";
	//chkQuery	+= " AND B.SITE_USE = 'Y'";
	chkQuery	+= " AND B.SITE_NO = '0002400000'";
	chkQuery	+= " AND A.MEM_ID='"+ etc +"'";
	try {
		rs_mssql	= stmt_mssql.executeQuery(chkQuery);
	} catch(Exception e) {
		out.println(e+"=>"+chkQuery);
		if(true)return;
	}

	if (rs_mssql.next()) {

		if(rs_mssql.getString("SITE_USE").equals("N")){
			session.setAttribute("esl_member_idx", "1");
			session.setAttribute("esl_member_id", etc);
			session.setAttribute("esl_member_name", "1");
			session.setAttribute("esl_customer_num", "1");
			session.setAttribute("esl_member_code", "U"); //����ȸ�� ����
%>
			<script language="javascript">
				alert("ȸ������ ���� ����Ʈ(http://www.eatsslim.co.kr)�� ���ԵǾ� ���� �ʽ��ϴ�.\n���� ����Ʈ Ȯ�� �������� ���� ���� ����Ʈ�� üũ���ּ���.");
				location.href = "https://member.pulmuone.co.kr/customer/custSite_R1.jsp?siteno=0002400000";		
			</script>		
<% 
			if(true)return;
		}

		String table			= "ESL_MEMBER";
		String memberId			= etc;
		String memberPw			= rs_mssql.getString("MEM_PWD");
		String memberName		= rs_mssql.getString("NAME");
		String hp				= rs_mssql.getString("HP");
		String tel				= rs_mssql.getString("TEL");
		String email			= rs_mssql.getString("EMAIL");
		String zipcode			= rs_mssql.getString("HOME_POST");
		String address			= rs_mssql.getString("HOME_ADDR1");
		String addressDetail	= rs_mssql.getString("HOME_ADDR2");
		String sex				= rs_mssql.getString("SEX");
		String birthDate		= rs_mssql.getString("BIRTH_DT");
		String smsYn			= rs_mssql.getString("SMS_YN");
		String customerNum		= rs_mssql.getString("CUSTOMER_NUM");
		if (smsYn == null || smsYn.length()==0) smsYn = "N";
		String emailYn			= rs_mssql.getString("EMAIL_YN");
		if (emailYn == null || emailYn.length()==0) emailYn	= "N";
		
		query		= "SELECT ";
		query		+= "	ID, MEM_NAME, MEM_ID, EMAIL, EMAIL_YN, ZIPCODE, ADDRESS, ADDRESS_DETAIL, HP, SMS_YN, TEL";
		query		+= " FROM "+ table +" WHERE MEM_ID = '"+ memberId +"'"; 
		try {
			stmt		= conn.createStatement();
			rs			= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		int cnt	= 0;
		if (rs.next()) {
			cnt			= 1;
			memberIdx	= rs.getString("ID");
			memberName	= rs.getString("MEM_NAME");
			addQuery	= "";
			if (!rs.getString("EMAIL").equals(email)) {
				addQuery	+= ", EMAIL = '"+ email +"'";
			}
			if (!rs.getString("ZIPCODE").equals(zipcode)) {
				addQuery	+= ", ZIPCODE = '"+ zipcode +"'";
			}
			if (!rs.getString("ADDRESS").equals(address)){
				addQuery	+= ", ADDRESS = '"+ address +"'";
			}
			if (!rs.getString("ADDRESS_DETAIL").equals(addressDetail)){
				addQuery	+= ", ADDRESS_DETAIL = '"+ addressDetail +"'";
			}
			if (!rs.getString("HP").equals(hp)) {
				addQuery	+= ", HP ='"+ hp +"'";
			}
			if (!rs.getString("TEL").equals(tel)){
				addQuery	+= ", TEL = '"+ tel +"'";
			}
			if (!rs.getString("SMS_YN").equals(smsYn)){
				addQuery	+= ", SMS_YN = '"+ smsYn +"'";
			}
			if(!rs.getString("EMAIL_YN").equals(emailYn)){
				addQuery	+= ", EMAIL_YN = '"+ emailYn +"'";
			}

			if (!addQuery.equals("")) { //ȸ������ ������� ����
				query1		=	"UPDATE "+ table +" SET MEMO = CONCAT(MEMO, '\n����ȸ����������(',now(),')')"+ addQuery +" WHERE MEM_ID = '"+ memberId +"'";
				try {
					stmt.executeUpdate(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
				}
			}

			query		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
			query		= " WHERE MEMBER_ID = '"+ memberId +"' AND COUPON_ID = 67";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e);
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
				query		+= " VALUES (67,'"+ couponNum +"','"+ memberId +"','N',NOW())";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e);
					if(true)return;
				}
			}
			rs.close();

			query		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
			query		= " WHERE MEMBER_ID = '"+ memberId +"' AND COUPON_ID = 68";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}

			if (rs.next()) {
				couponCnt	= rs.getInt(1);
			}

			rs.close();

			if (couponCnt > 0) {
			} else {
				SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
				couponNum		= "ET" + dt.format(new Date()) + "002";

				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (68,'"+ couponNum +"','"+ memberId +"','N',NOW())";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e);
					if(true)return;
				}
			}
		} else {
			cnt			= 0;
		}

		if (cnt == 0) {
			query		= "INSERT INTO "+ table;
			query		+= "	(CUSTOMER_NUM, MEM_NAME, MEM_ID, MEM_PW, SEX, BIRTH_DATE, EMAIL, EMAIL_YN, ZIPCODE, ADDRESS,";
			query		+= "	ADDRESS_DETAIL, HP, SMS_YN, TEL, INST_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
			try {
				pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
				pstmt.setString(1, customerNum);
				pstmt.setString(2, memberName);
				pstmt.setString(3, memberId);
				pstmt.setString(4, memberPw);
				pstmt.setString(5, sex);
				pstmt.setString(6, birthDate);
				pstmt.setString(7, email);
				pstmt.setString(8, emailYn);
				pstmt.setString(9, zipcode);
				pstmt.setString(10, address);
				pstmt.setString(11, addressDetail);
				pstmt.setString(12, hp);
				pstmt.setString(13, smsYn);
				pstmt.setString(14, tel);
				pstmt.executeUpdate();

				rs			= pstmt.getGeneratedKeys();
				if (rs.next()) {
					memberIdx		= rs.getString(1);
				}
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}

			rs.close();

			query		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
			query		= " WHERE MEMBER_ID = '"+ memberId +"' AND COUPON_ID = 67";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e);
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
				query		+= " VALUES (67,'"+ couponNum +"','"+ memberId +"','N',NOW())";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e);
					if(true)return;
				}
			}
			rs.close();

			query		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
			query		= " WHERE MEMBER_ID = '"+ memberId +"' AND COUPON_ID = 68";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}

			if (rs.next()) {
				couponCnt	= rs.getInt(1);
			}

			rs.close();

			if (couponCnt > 0) {
			} else {
				SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
				couponNum		= "ET" + dt.format(new Date()) + "002";

				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (68,'"+ couponNum +"','"+ memberId +"','N',NOW())";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e);
					if(true)return;
				}
			}

			moveUrl		= "https://www.eatsslim.co.kr/shop/mypage/index.jsp";
		}
		rs.close();
		//if(true)return;

		if (rs_mssql.getString("SITE_USE").equals("N")) {
			session.setAttribute("esl_member_idx","1");
			session.setAttribute("esl_member_id",etc);
			session.setAttribute("esl_member_name","1");
			session.setAttribute("esl_customer_num", "1");
			session.setAttribute("esl_member_code","U"); //����ȸ�� ����
%>
			<script language="javascript">
				alert("ȸ������ ���� ����Ʈ(http://www.eatsslim.co.kr)�� ���ԵǾ� ���� �ʽ��ϴ�.\n���� ����Ʈ Ȯ�� �������� ���� ���� ����Ʈ�� üũ���ּ���.");
				location.href = "https://member.pulmuone.co.kr/customer/custSite_R1.jsp?siteno=0002400000";
			</script>		
<% 
			if(true)return;
		}

		session.setAttribute("esl_member_idx", memberIdx);
		session.setAttribute("esl_member_id", memberId);
		session.setAttribute("esl_member_name", memberName);
		session.setAttribute("esl_customer_num", customerNum);
		session.setAttribute("esl_member_code","U"); //����ȸ�� ����
		
		//out.print(rs_mssql.getString("SITE_NO"));if(true)return;
	} else {
		session.setAttribute("esl_member_idx", "1");
		session.setAttribute("esl_member_id", etc);
		session.setAttribute("esl_member_name", "1");
		session.setAttribute("esl_customer_num", "1");
		session.setAttribute("esl_member_code", "U"); //����ȸ�� ����
%>
		<script language="javascript">
			alert("ȸ������ ���� ����Ʈ(http://www.eatsslim.co.kr)�� ���ԵǾ� ���� �ʽ��ϴ�.\n���� ����Ʈ Ȯ�� �������� ���� ���� ����Ʈ�� üũ���ּ���.");
				location.href = "https://member.pulmuone.co.kr/customer/custSite_R1.jsp?siteno=0002400000";
		</script>		
<% 
		if(true)return;	
	} //if(rs_mssql.next()){
	rs_mssql.close();
}

if (request.getParameter("mode")==null || request.getParameter("mode").length()==0) {
	//response.sendRedirect("http://www.pulmuonecaf.com/");
	response.sendRedirect(moveUrl);	
} else {
	if (memberIdx.equals("")) {
		out.println("<script>alert('�Է��Ͻ� ȸ�������� �������� �ʽ��ϴ�.');location.href='https://www.eatsslim.com/mobile/login.jsp';</script>");
	} else {
		//out.println("<script>opener.location.href='http://www.pulmuonecaf.com/mobile';self.close();</script>");
		out.println("<script>location.href='https://www.eatsslim.com/mobile';</script>");
	}
}
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_mssql.jsp" %>