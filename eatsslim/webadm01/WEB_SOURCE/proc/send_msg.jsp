<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String table		= "ESL_ORDER_DEVL_DATE";
String customerNum	= "";
String rcvHp		= "";
String sendYn		= "N";
int i				= 0;

query		= "SELECT RCV_HP, MAX(DEVL_DATE) MAX_DATE FROM "+ table;
query		+= " WHERE STATE < 90";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668')";
query		+= " GROUP BY RCV_HP";
query		+= " HAVING MAX_DATE = DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL 6 DAY)";
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");

	if (rcvHp.equals("010-9444-8585") || rcvHp.equals("010-7197-1346")) {
	} else {
		query1		= "INSERT INTO uds_msg (";
		query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, MSG_BODY";
		query1		+= " ) VALUES (";
		query1		+= "	0, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[잇슬림]배송종료 7일전입니다.연속배송 원하시면 바로주문!(문의0800220085)')";
		try {
			stmt1.executeUpdate(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}
		i++;
	}
}
rs.close();

query		= "SELECT RCV_HP, MAX(DEVL_DATE) MAX_DATE FROM "+ table;
query		+= " WHERE STATE < 90";
query		+= " AND GUBUN_CODE = '0331'";
query		+= " GROUP BY RCV_HP";
query		+= " HAVING MAX_DATE = DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL 2 DAY)";
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

sendYn		= "N";

while (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");
/*
	query1		= "INSERT INTO uds_msg (";
	query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, MSG_BODY";
	query1		+= " ) VALUES (";
	query1		+= "	0, now()+"+i+", now(), now(), '"+ rcvHp +"', '080-022-0085', '[잇슬림]배송종료 3일전입니다.연속배송 원하시면 바로주문!(문의0800220085)')";
	try {
		stmt1.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}
	i++;
*/
}
%>
<%@ include file="/lib/dbclose.jsp" %>