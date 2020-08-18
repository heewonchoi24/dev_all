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
String lastDate		= "";
int i				= 1;
Calendar cal		= Calendar.getInstance();
cal.setTime(new Date()); //����
SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
cal.add(Calendar.DATE, 3);
lastDate			= dt.format(cal.getTime());

query		= "SELECT DISTINCT ORD_MOBILENO FROM (";
query		+= "	SELECT M.ORD_NO, M.ORD_MOBILENO, FN_END_DELIVERY_DATE2(M.ORD_NO) AS D_DAY FROM BM_MEAL_ORDER M, BM_ORDER_DELIVERY O WHERE M.ORD_NO = O.ORDER_NO";
query		+= "	AND O.DELIVERY_DATE = '"+ lastDate +"'";
query		+= "	AND M.ORD_NO NOT LIKE 'S%'";
query		+= "	AND O.GOODS_GROUP_ID != '0010'";
query		+= "	AND M.DELIVERY_TYPE = '0001'";
query		+= "	AND M.PAY_FL = 'Y' ";
query		+= "	AND O.STATUS = '0001'";
query		+= "	GROUP BY M.ORD_NO, M.ORD_MOBILENO";
query		+= ") WHERE D_DAY = '"+ lastDate +"'";
try {
	rs_phi2	= stmt_phi2.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
while (rs_phi2.next()) {
	rcvHp			= rs_phi2.getString("ORD_MOBILENO");

	query1		= "INSERT INTO UDS_MSG (";
	query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
	query1		+= " ) VALUES (";
	query1		+= "	5, TO_CHAR(SYSDATE+"+i+"/(24*60*60), 'yyyymmddHH24MISS'), SYSDATE, SYSDATE, '"+ rcvHp +"', '02-6411-8321', '���̺�� ������� �˶�', '���̺�а����� ����������� "+ lastDate.substring(4, 6)+"-"+lastDate.substring(6, 8) +"�Դϴ�.  �ֹ������� ���Ͻ� ��� �������� 3�������� ���ֹ��� �ּ���.  ����� �ֹ� �ٷΰ���- http://me2.do/x0fwOCjO')";
	try {
		stmt1.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}
	i++;
}
%>
<%@ include file="/lib/dbclose_phi2.jsp" %>