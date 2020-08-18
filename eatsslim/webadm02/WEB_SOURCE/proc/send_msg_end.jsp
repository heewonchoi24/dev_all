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


// �������ȳ� 6����(�ڻ��)
query		= "SELECT RCV_HP, MAX(DEVL_DATE) MAX_DATE FROM "+ table;
query		+= " WHERE STATE < 90";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668')";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND SHOP_CD in ('51', '52' )";
query		+= " AND LEFT(RCV_HP, 4) not in ('0503', '0504')";
query		+= " GROUP BY RCV_HP, ORDER_NUM";
query		+= " HAVING MAX_DATE = DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL 5 DAY)";
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
		query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���]', '[Ǯ�����ս���]�ȳ��ϼ���. �ս����Դϴ�. �ֹ��Ͻ� ��ǰ�� ����� 6�� �� ��� ����˴ϴ�. �̿��Ͻô� ���� �����Ͻ� ���� �����̴�����~? �ս����� ������ �ֹ��� ���� 6���� �ֹ����ּž� ��� �ߴ� ���� ���� ��� �����Ͻʴϴ�. ���ֹ��� ���Ͻø� �ս��� Ȩ������(www.eatsslim.co.kr) �Ǵ� ��ȭ �ֹ� �̿����ּ���^^')";
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

// 4�� �ֹ� �� �������ȳ� 8����(�ڻ��)
query		= "SELECT ORDER_NUM, RCV_HP, MAX(DEVL_DATE) MAX_DATE FROM "+ table;
query		+= " WHERE STATE < 90";
//query		+= " AND GUBUN_CODE = '02244'";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND SHOP_CD in ('51', '52' )";
query		+= " AND STATE = '01'";
query		+= " AND LEFT(RCV_HP, 4) not in ('0503', '0504')";
query		+= " GROUP BY ORDER_NUM, RCV_HP";
query		+= " HAVING MAX_DATE = DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL 7 DAY) AND COUNT(*) >= 12";
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");

	query1		= "INSERT INTO uds_msg (";
	query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
	query1		+= " ) VALUES (";
	query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���]', '[Ǯ�����ս���]�ȳ��ϼ���. �ս����Դϴ�. �ֹ��Ͻ� ��ǰ�� ����� 8�� �� ��� ����˴ϴ�. �ս����� ������ �ֹ��� ���� ���Ͻô� ����Ϸκ��� 6�� ������ �ֹ����ּž� �ϴ� �� ���� ��Ź�帮��, ���ֹ��� ���Ͻø� �ս��� Ȩ������(www.eatsslim.co.kr) �Ǵ� ��ȭ �ֹ� �̿����ּ���^^')";
	try {
		stmt1.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}
	i++;

}
rs.close();

// �������ȳ� 7����(�ܺθ�)
query		= "SELECT RCV_HP, MAX(DEVL_DATE) MAX_DATE FROM "+ table;
query		+= " WHERE STATE < 90";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668')";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND SHOP_CD not in ( '51', '52' )";
query		+= " AND LEFT(RCV_HP, 4) not in ('0503', '0504')";
query		+= " GROUP BY RCV_HP, ORDER_NUM";
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
		query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
		query1		+= " ) VALUES (";
		query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���]', '[Ǯ�����ս���]�ȳ��ϼ���. �ս����Դϴ�. �ֹ��Ͻ� ��ǰ�� ����� 7�� �� ��� ����˴ϴ�. �̿��Ͻô� ���� �����Ͻ� ���� �����̴�����~? �ս����� ������ �ֹ��� ���� �ս��� Ȩ���������� 6�������� �ֹ����ּž� ��� �ߴ� ���� ���� ��� �����Ͻʴϴ�. ����� ���� ��, ���� �����, ����/�̺�Ʈ �ҽ� �˸� �� �ս��� Ȩ������(www.eatsslim.co.kr) �ֹ��� ���� �پ��� ������ ����������.')";
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

// 4�� �ֹ� �� �������ȳ� 9����(�ܺθ�)
query		= "SELECT ORDER_NUM, RCV_HP, MAX(DEVL_DATE) MAX_DATE FROM "+ table;
query		+= " WHERE STATE < 90";
//query		+= " AND GUBUN_CODE = '02244'";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND SHOP_CD not in ( '51', '52' )";
//query		+= " AND STATE = '01'";
query		+= " AND LEFT(RCV_HP, 4) not in ('0503', '0504')";
query		+= " GROUP BY ORDER_NUM, RCV_HP";
query		+= " HAVING MAX_DATE = DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL 8 DAY) AND COUNT(*) >= 12";
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");

	query1		= "INSERT INTO uds_msg (";
	query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
	query1		+= " ) VALUES (";
	query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���]', '[Ǯ�����ս���]�ȳ��ϼ���. �ս����Դϴ�. �ֹ��Ͻ� ��ǰ�� ����� 9�� �� ��� ����˴ϴ�. �ս����� ������ �ֹ��� ���� �ս��� Ȩ���������� 7�� ������ �ֹ����ּž� ��� �ߴ� ���� ���� ��� �����Ͻʴϴ�. ����� ���� ��, ���� �����, ����/�̺�Ʈ �ҽ� �˸� �� �ս��� Ȩ������(www.eatsslim.co.kr) �ֹ��� ���� �پ��� ������ ����������.')";
	try {
		stmt1.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}
	i++;

}
rs.close();

%>
<%@ include file="/lib/dbclose.jsp" %>