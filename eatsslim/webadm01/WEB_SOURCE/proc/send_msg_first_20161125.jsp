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


// ù��۾ȳ�
query		= "SELECT RCV_HP, MIN(DEVL_DATE) MIN_DATE FROM "+ table;
query		+= " WHERE STATE < 90";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668')";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND LEFT(RCV_HP, 4) not in ('0503', '0504')";
query		+= " GROUP BY RCV_HP";
query		+= " HAVING MIN_DATE = DATE_FORMAT(NOW(), '%Y-%m-%d')";
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
		query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
		query1		+= " ) VALUES (";
		query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���]', '[Ǯ�����ս���] ����. ���� ��ǰ�� �� �����̳���? Ǯ���� �ս��� �̿� �� ���� ���� �ȳ��帳�ϴ�.\rStep 1. ���ö��� ������ �ǵ��� ���庸�� �ϱ� (������� ���� ǥ��)\rStep 2. ���ð���� ���̽����� �״�� ���������� �ɾ�α� (���̽����� ��޽ø��� �󸰰����� ��ü�ص����!)\rStep 3. ����� ������ 3�� ������! (Ȩ������ ����������>��������� �Ǵ� 1:1�Խ����� ���� �������ּ���.) ')";
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


%>
<%@ include file="/lib/dbclose.jsp" %>