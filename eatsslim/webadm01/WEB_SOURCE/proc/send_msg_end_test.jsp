<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();

String customerNum	= "";
String rcvHp		= "";
String productName = "";
String endDate = "";
String shopChannel = "";
String sendYn		= "N";
int i				= 0;


// �������ȳ� 6����(�ڻ��)
query		= "SELECT OGG.GROUP_NAME, ODD.RCV_HP, DATE_FORMAT(ODD.MAX_DATE, '%Y-%m-%d') AS MAX_DATE, ODD.SHOP_CD FROM";
query		+= " ( SELECT G.GROUP_NAME, OG.ORDER_NUM, OG.ID";
query		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG";
query		+= " WHERE G.ID = OG.GROUP_ID";
query		+= " AND OG.DEVL_TYPE = '0001'";
query		+= " AND OG.ORDER_STATE in ('01', '911')";
query		+= " AND OG.DEVL_DATE >  DATE_ADD(NOW(), INTERVAL -180 DAY)";
query		+= " ) OGG, (";
query		+= " SELECT GOODS_ID, ORDER_NUM, RCV_HP, MAX(DEVL_DATE) MAX_DATE, SHOP_CD FROM ESL_ORDER_DEVL_DATE";
query		+= " WHERE STATE in ('01', '02', '911')";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668')";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND SHOP_CD in ('51', '52' )";
query		+= " AND LEFT(RCV_HP, 4) not in ('0503', '0504')";
query		+= " AND ORDER_DATE BETWEEN DATE_ADD(NOW(), INTERVAL -180 DAY) AND NOW()";
query		+= " GROUP BY RCV_HP, ORDER_NUM, GOODS_ID";
query		+= " HAVING MAX_DATE = DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL 5 DAY)";
query		+= " ) ODD";
query		+= " WHERE OGG.ORDER_NUM = ODD.ORDER_NUM ";
query		+= " AND OGG.ID = ODD.GOODS_ID ";

try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	rcvHp				= rs.getString("RCV_HP");
	productName		= rs.getString("GROUP_NAME");
	endDate			= rs.getString("MAX_DATE");

	if (rcvHp.equals("010-9444-8585") || rcvHp.equals("010-7197-1346")) {
	} else {
		query1		= "INSERT INTO uds_msg (";
		query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
		query1		+= " ) VALUES (";
		query1		+= "	5, now()+"+i+", now(), now(), '01087947980', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '1[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� ������ �ֹ��� ���� ��ǰ���� �ֹ������ð��� �ٸ����� �Ʒ��� �����Ͽ� �ֹ����ּž� ��� �ߴ� ���� ���� ��� �����մϴ�.\r\r1. �ﾾ����(1��) : 2���� 14�ñ��� �ֹ�\r2. ����(1��), ����+�ﾾ����(2��), ����+������(2��) : 4�������� �ֹ�\r3. �� �� ����ǰ : 6�������� �ֹ�\r\r���ֹ��� ���Ͻø� �ս��� Ȩ������  (www.eatsslim.co.kr)�� �̿����ּ���. \r\r�ս����� �̿����ּż� �����մϴ�^^(�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.)')";
		//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� ������ �ֹ��� ��ǰ���� �ֹ������ð��� �ٸ����� �Ʒ��� �����Ͽ� �ֹ����ּž� ��� �ߴ� ���� ���� ��� �����մϴ�. ���ֹ��� ���Ͻø� �ս��� Ȩ������(www.eatsslim.co.kr)�� �̿����ּ���.\r�ս����� �̿����ּż� �����մϴ�^^ (�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.)')";

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

// 4�� �ֹ� ���� �������ȳ� 8����(�ڻ��)
query		= "SELECT OGG.GROUP_NAME, ODD.RCV_HP, DATE_FORMAT(ODD.MAX_DATE, '%Y-%m-%d') AS MAX_DATE, ODD.SHOP_CD FROM";
query		+= " ( SELECT G.GROUP_NAME, OG.ORDER_NUM, OG.ID";
query		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG";
query		+= " WHERE G.ID = OG.GROUP_ID";
query		+= " AND OG.DEVL_TYPE = '0001'";
query		+= " AND OG.ORDER_STATE in ('01', '911')";
query		+= " AND OG.DEVL_DATE >  DATE_ADD(NOW(), INTERVAL -180 DAY)";
query		+= " ) OGG, (";
query		+= " SELECT GOODS_ID, ORDER_NUM, RCV_HP, MAX(DEVL_DATE) MAX_DATE, SHOP_CD FROM ESL_ORDER_DEVL_DATE";
query		+= " WHERE STATE in ('01', '02', '911')";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668')";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND SHOP_CD in ('51', '52' )";
query		+= " AND LEFT(RCV_HP, 4) not in ('0503', '0504')";
query		+= " AND ORDER_DATE BETWEEN DATE_ADD(NOW(), INTERVAL -180 DAY) AND NOW()";
query		+= " GROUP BY RCV_HP, ORDER_NUM, GOODS_ID";
query		+= " HAVING MAX_DATE = DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL 7 DAY) AND COUNT(*) >= 12";
query		+= " ) ODD";
query		+= " WHERE OGG.ORDER_NUM = ODD.ORDER_NUM ";
query		+= " AND OGG.ID = ODD.GOODS_ID ";

try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");
	productName		= rs.getString("GROUP_NAME");
	endDate			= rs.getString("MAX_DATE");
	
	query1		= "INSERT INTO uds_msg (";
	query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
	query1		+= " ) VALUES (";
	query1		+= "	5, now()+"+i+", now(), now(), '01087947980', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '2[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� ������ �ֹ��� ���� ��ǰ���� �ֹ������ð��� �ٸ����� �Ʒ��� �����Ͽ� �ֹ����ּž� ��� �ߴ� ���� ���� ��� �����մϴ�.\r\r1. �ﾾ����(1��) : 2���� 14�ñ��� �ֹ�\r2. ����(1��), ����+�ﾾ����(2��), ����+������(2��) : 4�������� �ֹ�\r3. �� �� ����ǰ : 6�������� �ֹ�\r\r���ֹ��� ���Ͻø� �ս��� Ȩ������  (www.eatsslim.co.kr)�� �̿����ּ���.\r\r�ս����� �̿����ּż� �����մϴ�^^\r(�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.)')";
	//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� �ż��� ������ ������ ���� 6�� ������ �ֹ��ϼž� �������� �̿� �����մϴ�. ���ֹ��� ���Ͻø� �ս��� Ȩ������(www.eatsslim.co.kr)�� �̿����ּ���.\r�ս����� �̿����ּż� �����մϴ�^^(�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.)')";

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
query		= "SELECT OGG.GROUP_NAME, ODD.RCV_HP, DATE_FORMAT(ODD.MAX_DATE, '%Y-%m-%d') AS MAX_DATE, ODD.SHOP_CD FROM";
query		+= " ( SELECT G.GROUP_NAME, OG.ORDER_NUM, OG.ID";
query		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG";
query		+= " WHERE G.ID = OG.GROUP_ID";
query		+= " AND OG.DEVL_TYPE = '0001'";
query		+= " AND OG.ORDER_STATE in ('01', '911')";
query		+= " AND OG.DEVL_DATE >  DATE_ADD(NOW(), INTERVAL -180 DAY)";
query		+= " ) OGG, (";
query		+= " SELECT GOODS_ID, ORDER_NUM, RCV_HP, MAX(DEVL_DATE) MAX_DATE, SHOP_CD FROM ESL_ORDER_DEVL_DATE";
query		+= " WHERE STATE in ('01', '02', '911')";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668')";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND SHOP_CD not in ('51', '52' )";
query		+= " AND LEFT(RCV_HP, 4) not in ('0503', '0504')";
query		+= " AND ORDER_DATE BETWEEN DATE_ADD(NOW(), INTERVAL -180 DAY) AND NOW()";
query		+= " GROUP BY RCV_HP, ORDER_NUM, GOODS_ID";
query		+= " HAVING MAX_DATE = DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL 6 DAY)";
query		+= " ) ODD";
query		+= " WHERE OGG.ORDER_NUM = ODD.ORDER_NUM ";
query		+= " AND OGG.ID = ODD.GOODS_ID ";

try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");
	productName		= rs.getString("GROUP_NAME");
	endDate			= rs.getString("MAX_DATE");
	shopChannel		= rs.getString("SHOP_CD");

	if (rcvHp.equals("010-9444-8585") || rcvHp.equals("010-7197-1346")) {
	} else {
		
		//if (shopChannel.equals("53") || shopChannel.equals("59") || shopChannel.equals("60") ) {
			query1		= "INSERT INTO uds_msg (";
			query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
			query1		+= " ) VALUES (";
			query1		+= "	5, now()+"+i+", now(), now(), '01087947980', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '3[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� ������ �ֹ��� ���� ��ǰ���� �ֹ������ð��� �ٸ����� �Ʒ��� �����Ͽ� �ֹ����ּž� ��� �ߴ� ���� ���� ��� �����ϸ�, �ֹ� �������������� ù ������� �����ϰų� ��� �޸� ��û���� �����ֽø� �����ص帳�ϴ�.\r\r1. �ﾾ����(1��) : 2�� �� 11�ñ��� �ֹ�\r2. ����(1��), ����+�ﾾ����(2��),����+������(2��) : 4���� 11�ñ��� �ֹ�\r3. �� �� ����ǰ : 7���� 11�ñ��� �ֹ�\r\r* �ָ��� ���ԵǾ� ���� ��� 2~3�� �� �ҿ� �˴ϴ�.\r\r���ֹ��� ���Ͻø� �ս��� Ȩ������  (www.eatsslim.co.kr)�� �̿����ּ���.\r\r�ս����� �̿����ּż� �����մϴ�^^\r(�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.)')";
			//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� �ż��� ������ ������ ���� 7�� ������ �ֹ��ϼž� �������� �̿� �����ϸ�, �ֹ� �� �ֹ� ���� ���������� ù ������� ������ �� �ֽ��ϴ�. �߰� �ֹ��� ���Ͻ� ��� �ս��� Ȩ������(www.eatsslim.co.kr)�� �̿��ϼ���^^\r�ս����� �̿����ּż� �����մϴ�. (�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.)')";
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}
			i++;
		//} else {
			query1		= "INSERT INTO uds_msg (";
			query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
			query1		+= " ) VALUES (";
			query1		+= "	5, now()+"+i+", now(), now(), '01087947980', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '4[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� ������ �ֹ��� ���� ��ǰ���� �ֹ������ð��� �ٸ����� �Ʒ��� �����Ͽ� �ֹ����ּž� ��� �ߴ� ���� ���� ��� �����ϸ�, ��� �޸� ��û���� �����ֽø� �����ص帳�ϴ�.\r\r1. �ﾾ����(1��) : 3�� �� ���� �ֹ�\r2. ����(1��), ����+�ﾾ����(2��), ����+������(2��) : 5�� �� ���� �ֹ�\r3. �� �� ����ǰ : 7�� �� ���� �ֹ�\r\r* �ָ��� ���ԵǾ� ���� ��� 2~3�� �� �ҿ� �˴ϴ�.\r\r���ֹ��� ���Ͻø� �ս��� Ȩ������  (www.eatsslim.co.kr)�� �̿����ּ���.\r\r�ս����� �̿����ּż� �����մϴ�^^\r(�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.)')";
			//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� �ż��� ������ ������ ���� 7�� ������ �ֹ��ϼž� �������� �̿� �����ϸ�, ��� �޸� ���Ͻô� ù ������� �����ֽø� �����ص帳�ϴ�. �߰� �ֹ��� ���Ͻ� ��� �ս��� Ȩ������(www.eatsslim.co.kr)�� �̿��ϼ���^^\r�ս����� �̿����ּż� �����մϴ�. (�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.)')";
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}
		//}
		
		i++;
	}
}
rs.close();

// 4�� �ֹ� ���� �������ȳ� 9����(�ܺθ�)
query		= "SELECT OGG.GROUP_NAME, ODD.RCV_HP, DATE_FORMAT(ODD.MAX_DATE, '%Y-%m-%d') AS MAX_DATE, ODD.SHOP_CD FROM";
query		+= " ( SELECT G.GROUP_NAME, OG.ORDER_NUM, OG.ID";
query		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG";
query		+= " WHERE G.ID = OG.GROUP_ID";
query		+= " AND OG.DEVL_TYPE = '0001'";
query		+= " AND OG.ORDER_STATE in ('01', '911')";
query		+= " AND OG.DEVL_DATE >  DATE_ADD(NOW(), INTERVAL -180 DAY)";
query		+= " ) OGG, (";
query		+= " SELECT GOODS_ID, ORDER_NUM, RCV_HP, MAX(DEVL_DATE) MAX_DATE, SHOP_CD FROM ESL_ORDER_DEVL_DATE";
query		+= " WHERE STATE in ('01', '02', '911')";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668')";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND SHOP_CD not in ('51', '52' )";
query		+= " AND LEFT(RCV_HP, 4) not in ('0503', '0504')";
query		+= " AND ORDER_DATE BETWEEN DATE_ADD(NOW(), INTERVAL -180 DAY) AND NOW()";
query		+= " GROUP BY RCV_HP, ORDER_NUM, GOODS_ID";
query		+= " HAVING MAX_DATE = DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL 8 DAY) AND COUNT(*) >= 12";
query		+= " ) ODD";
query		+= " WHERE OGG.ORDER_NUM = ODD.ORDER_NUM ";
query		+= " AND OGG.ID = ODD.GOODS_ID ";

try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");
	productName		= rs.getString("GROUP_NAME");
	endDate			= rs.getString("MAX_DATE");
	shopChannel		= rs.getString("SHOP_CD");

	if (rcvHp.equals("010-9444-8585") || rcvHp.equals("010-7197-1346")) {
	} else {
		
		//if (shopChannel.equals("53") || shopChannel.equals("59") || shopChannel.equals("60") ) {
			query1		= "INSERT INTO uds_msg (";
			query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
			query1		+= " ) VALUES (";
			query1		+= "	5, now()+"+i+", now(), now(), '01087947980', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '5[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� ������ �ֹ��� ���� ��ǰ���� �ֹ������ð��� �ٸ����� �Ʒ��� �����Ͽ� �ֹ����ּž� ��� �ߴ� ���� ���� ��� �����ϸ�, �ֹ� �������������� ù ������� �����ϰų� ��� �޸� ��û���� �����ֽø� �����ص帳�ϴ�.\r\r1. �ﾾ����(1��) : 2�� �� 11�ñ��� �ֹ�\r2. ����(1��), ����+�ﾾ����(2��),����+������(2��) : 4���� 11�ñ��� �ֹ�\r3. �� �� ����ǰ : 7���� 11�ñ��� �ֹ�\r\r* �ָ��� ���ԵǾ� ���� ��� 2~3�� �� �ҿ� �˴ϴ�.\r���ֹ��� ���Ͻø� �ս��� Ȩ������  (www.eatsslim.co.kr)�� �̿����ּ���.\r\r�ս����� �̿����ּż� �����մϴ�^^\r(�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.)')";
			//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� �ż��� ������ ������ ���� 7�� ������ �ֹ��ϼž� �������� �̿� �����ϸ�, �ֹ� �� �ֹ� ���� ���������� ù ������� ������ �� �ֽ��ϴ�. �߰� �ֹ��� ���Ͻ� ��� �ս��� Ȩ������(www.eatsslim.co.kr)�� �̿��ϼ���^^ �ս����� �̿����ּż� �����մϴ�. (�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.')";
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}			
			i++;
		//} else {
			query1		= "INSERT INTO uds_msg (";
			query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
			query1		+= " ) VALUES (";
			query1		+= "	5, now()+"+i+", now(), now(), '01087947980', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '6[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� ������ �ֹ��� ���� ��ǰ���� �ֹ������ð��� �ٸ����� �Ʒ��� �����Ͽ� �ֹ����ּž� ��� �ߴ� ���� ���� ��� �����ϸ�, ��� �޸� ��û���� �����ֽø� �����ص帳�ϴ�.\r\r1. �ﾾ����(1��) : 3�� �� ���� �ֹ�\r2. ����(1��), ����+�ﾾ����(2��), ����+������(2��) : 5�� �� ���� �ֹ�\r3. �� �� ����ǰ : 7�� �� ���� �ֹ�\r\r* �ָ��� ���ԵǾ� ���� ��� 2~3�� �� �ҿ� �˴ϴ�.\r\r���ֹ��� ���Ͻø� �ս��� Ȩ������  (www.eatsslim.co.kr)�� �̿����ּ���.\r\r�ս����� �̿����ּż� �����մϴ�^^\r(�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.)')";
			//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���] �������ȳ�', '[Ǯ�����ս���] �ȳ��ϼ���. �ǰ��ϰ� ���ִ� ���̾�Ʈ, Ǯ���� �ս����Դϴ�. �ֹ��Ͻ� \""+ productName +"\"�� ������ ������� \""+ endDate +"\"�Դϴ�. �ս����� �ż��� ������ ������ ���� 7�� ������ �ֹ��ϼž� �������� �̿� �����ϸ� ��� �޸� ���Ͻô� ù ������� �����ֽø� �����ص帳�ϴ�. �߰� �ֹ��� ���Ͻ� ��� �ս��� Ȩ������(www.eatsslim.co.kr)�� �̿��ϼ���^^ �ս����� �̿����ּż� �����մϴ�. (�� �޽����� �߽ſ����� �߰� ���� �� �ս��� ��������(080-800-0434) �Ǵ� Ȩ������ 1:1 �Խ��� �̿� ��Ź�帳�ϴ�.')";
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}
		//}
		
		i++;
	}
}
rs.close();

%>
<%@ include file="/lib/dbclose.jsp" %>