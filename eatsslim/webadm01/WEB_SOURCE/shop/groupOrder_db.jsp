<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="/lib/config.jsp"%>

<%
request.setCharacterEncoding("euc-kr");

String savePath			= uploadDir + "board/"; // 저장할 디렉토리 (절대경로)
int sizeLimit			= 3 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String table			= "ESL_ORDER_GROUP";
String query			= "";
String query1			= "";

String customerNum		= "";
String mode				= ut.inject(multi.getParameter("mode"));
String orderName		= ut.inject(multi.getParameter("order_name"));
String payType			= ut.inject(multi.getParameter("payment"));
String orderTel1		= ut.inject(multi.getParameter("order_tel1"));
String orderTel2		= ut.inject(multi.getParameter("order_tel2"));
String orderTel3		= ut.inject(multi.getParameter("order_tel3"));
String orderHp1			= ut.inject(multi.getParameter("order_hp1"));
String orderHp2			= ut.inject(multi.getParameter("order_hp2"));
String orderHp3			= ut.inject(multi.getParameter("order_hp3"));
String orderRequest		= ut.inject(multi.getParameter("order_request"));
String rcvName			= ut.inject(multi.getParameter("rcv_name"));
String devlDate			= ut.inject(multi.getParameter("devl_date"));
String rcvTel1			= ut.inject(multi.getParameter("rcv_tel1"));
String rcvTel2			= ut.inject(multi.getParameter("rcv_tel2"));
String rcvTel3			= ut.inject(multi.getParameter("rcv_tel3"));
String rcvHp1			= ut.inject(multi.getParameter("rcv_hp1"));
String rcvHp2			= ut.inject(multi.getParameter("rcv_hp2"));
String rcvHp3			= ut.inject(multi.getParameter("rcv_hp3"));
String rcvZip			= ut.inject(multi.getParameter("rcv_zipcode"));
String rcvAddr1			= ut.inject(multi.getParameter("rcv_addr1"));
String rcvAddr2			= ut.inject(multi.getParameter("rcv_addr2"));
String rcvType			= ut.inject(multi.getParameter("rcv_type"));
String rcvPassYn		= ut.inject(multi.getParameter("rcv_pass_yn"));
String rcvPass			= ut.inject(multi.getParameter("rcv_pass"));
String rcvRequest		= ut.inject(multi.getParameter("rcv_request"));

String orderTel			= orderTel1 +"-"+ orderTel2 +"-"+ orderTel3;
String orderHp			= orderHp1 +"-"+ orderHp2 +"-"+ orderHp3;
String rcvTel			= rcvTel1 +"-"+ rcvTel2 +"-"+ rcvTel3;
String rcvHp			= rcvHp1 +"-"+ rcvHp2 +"-"+ rcvHp3;
String userIp			= request.getRemoteAddr();

if (mode != null) {
	query		= "SELECT CUSTOMER_NUM FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"'";
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		customerNum		= rs.getString("CUSTOMER_NUM");
	}
	rs.close();

	if ( mode.equals("ins") ) {
		try {
			String devlDatePhi	= "";
			SimpleDateFormat dt	= new SimpleDateFormat("yyyy.MM.dd");
			Date date			= dt.parse(devlDate);
			Calendar cal	= Calendar.getInstance();
			cal.setTime(date);
			devlDatePhi		= dt.format(cal.getTime());

			query		= "INSERT INTO "+ table;
			query		+= "	(MEMBER_ID, ORDER_NAME, PAY_TYPE, ORDER_TEL, ORDER_HP, ORDER_REQUEST, RCV_NAME, RCV_DATE, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_TYPE, RCV_PASS_YN, RCV_PASS, RCV_REQUEST, ORDER_IP, ORDER_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, customerNum);
			pstmt.setString(2, orderName);
			pstmt.setString(3, payType);
			pstmt.setString(4, orderTel);
			pstmt.setString(5, orderHp);
			pstmt.setString(6, orderRequest);
			pstmt.setString(7, rcvName);
			pstmt.setString(8, devlDatePhi);
			pstmt.setString(9, rcvTel);
			pstmt.setString(10, rcvHp);
			pstmt.setString(11, rcvZip);
			pstmt.setString(12, rcvAddr1);
			pstmt.setString(13, rcvAddr2);
			pstmt.setString(14, rcvType);
			pstmt.setString(15, rcvPassYn);
			pstmt.setString(16, rcvPass);
			pstmt.setString(17, rcvRequest);
			pstmt.setString(18, userIp);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e+"=>"+query);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}
		
		ut.jsAlert(out, "단체주문이 등록되었습니다.");
		ut.jsRedirect(out, "/shop/groupOrder.jsp");
	}
	else if ( mode.equals("mod") ) {
		try {
			query  = "UPDATE "+ table +" SET ";
			//query += " counsel_type	= ?, ";
			query += " ORDER_NAME		= ?, ";
			query += " ORDER_HP			= ?, ";
			query += " WHERE id = ?";

			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, orderName);
			pstmt.setString(2, orderHp);

			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e+"=>"+query);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsAlert(out, "수정이 완료되었습니다.");
		//ut.jsRedirect(out, "/shop/groupOrder.jsp?counselID="+ counselID);
	}
}
%>
<%@ include file="/lib/dbclose.jsp" %>