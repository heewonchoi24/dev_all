<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.*"%>
<%@ include file="/lib/dbconn_phi2.jsp"%>
<%
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn_phi2.createStatement();
String customerNum	= "";
String rcvHp		= "";
String prdNm		= "";
String lastDate		= "";
int i				= 1;
Calendar cal		= Calendar.getInstance();
cal.setTime(new Date()); //오늘
SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
cal.add(Calendar.DATE, 3);
lastDate			= dt.format(cal.getTime());

query		= "SELECT M.ORD_MOBILENO,";
query		+= "	DECODE(O.GOODS_GROUP_ID,'0001','초기','0002','중기','0003','후기','0004','병행','0005','완료','0007','요리','0008','성찬','0009','요리+성찬','0010','퓨레','0011','보양밥','0012','보양국','0013','완료기3입', '0016','6개월부터', '0017', '8개월부터','8001','가방') AS PRD_NM, ";
query		+= "	(SELECT MIN(MO1.DELIVERY_DATE) FROM BM_ORDER_DELIVERY MO1 WHERE MO1.ORDER_NO = M.ORD_NO) || ' ~ ' || (SELECT MAX(MO2.DELIVERY_DATE) FROM BM_ORDER_DELIVERY MO2 WHERE MO2.ORDER_NO = M.ORD_NO) AS PERIOD";
query		+= "	FROM BM_MEAL_ORDER M,";
query		+= "	BM_ORDER_DELIVERY O"; 
query		+= " WHERE M.ORD_NO = O.ORDER_NO";
query		+= " AND O.GOODS_GROUP_ID != '8001'"; 
query		+= " AND M.PAY_FL = 'Y'"; 
query		+= " AND O.STATUS = '0001'"; 
query		+= " AND M.ORD_NO not like 'S%'";
query		+= " AND O.GOODS_GROUP_ID != '0015'"; 
query		+= " AND (SELECT MIN(MO.DELIVERY_DATE) FROM BM_ORDER_DELIVERY MO WHERE MO.ORDER_NO = M.ORD_NO) = TO_CHAR(SYSDATE+1, 'YYYYMMDD')";
query		+= " GROUP BY M.ORD_NO,"; 
query		+= "		  O.GOODS_GROUP_ID,"; 
query		+= "		  M.ORD_MOBILENO";
try {
	rs_phi2	= stmt_phi2.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
while (rs_phi2.next()) {
	rcvHp			= rs_phi2.getString("ORD_MOBILENO");
	prdNm			= rs_phi2.getString("PRD_NM");

	query1		= "INSERT INTO UDS_MSG (";
	query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
	query1		+= " ) VALUES (";
	query1		+= "	5, TO_CHAR(SYSDATE+"+i+"/(24*60*60), 'yyyymmddHH24MISS'), SYSDATE, SYSDATE, '010-5044-0275', '02-2186-8659', '베이비밀 입금기한 종료 알람', '[풀무원베이비밀]\"주문번호\" \""+ prdNm +"\" 입금기한이 종료되어 주문이 취소되었습니다. 재주문을 원한다면 아래 주소 클릭!! 모바일 주문 바로가기- http://me2.do/x0fwOCjO)";
	try {
		stmt1.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}
/*
	query1		= "INSERT INTO UDS_MSG (";
	query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
	query1		+= " ) VALUES (";
	query1		+= "	5, TO_CHAR(SYSDATE+"+i+"/(24*60*60), 'yyyymmddHH24MISS'), SYSDATE, SYSDATE, '"+ rcvHp +"', '02-2186-8659', '베이비밀 입금기한 종료 알람', '[풀무원베이비밀]\"주문번호\" \""+ prdNm +"\" 입금기한이 종료되어 주문이 취소되었습니다. 재주문을 원한다면 아래 주소 클릭!! 모바일 주문 바로가기- http://me2.do/x0fwOCjO)";
	try {
		stmt1.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}
*/
	if(true)return;
	i++;
}
%>
<%@ include file="/lib/dbclose_phi2.jsp" %>