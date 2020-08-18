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


// 배송종료안내 6일전(자사몰)
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

while (rs.next()) {
	rcvHp				= rs.getString("RCV_HP");
	productName		= rs.getString("GROUP_NAME");
	endDate			= rs.getString("MAX_DATE");

	if (rcvHp.equals("010-9444-8585") || rcvHp.equals("010-7197-1346")) {
	} else {
		query1		= "INSERT INTO uds_msg (";
		query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
		query1		+= " ) VALUES (";
		query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 식자재 주문을 위해 상품별로 주문마감시간이 다르오니 아래를 참고하여 주문해주셔야 배달 중단 없이 연속 배달 가능합니다.\r\r1. 헬씨퀴진(1식) : 2일전 14시까지 주문\r2. 퀴진(1식), 퀴진+헬씨퀴진(2식), 퀴진+간편식(2식) : 4일전까지 주문\r3. 그 외 전제품 : 6일전까지 주문\r\r재주문을 원하시면 잇슬림 홈페이지  (www.eatsslim.co.kr)를 이용해주세요. \r\r잇슬림을 이용해주셔서 감사합니다^^(본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.)')";
		//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 식자재 주문을 상품별로 주문마감시간이 다르오니 아래를 참고하여 주문해주셔야 배달 중단 없이 연속 배달 가능합니다. 재주문을 원하시면 잇슬림 홈페이지(www.eatsslim.co.kr)를 이용해주세요.\r잇슬림을 이용해주셔서 감사합니다^^ (본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.)')";

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

// 4주 주문 고개 배송종료안내 8일전(자사몰)
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

while (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");
	productName		= rs.getString("GROUP_NAME");
	endDate			= rs.getString("MAX_DATE");
	
	query1		= "INSERT INTO uds_msg (";
	query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
	query1		+= " ) VALUES (";
	query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 식자재 주문을 위해 상품별로 주문마감시간이 다르오니 아래를 참고하여 주문해주셔야 배달 중단 없이 연속 배달 가능합니다.\r\r1. 헬씨퀴진(1식) : 2일전 14시까지 주문\r2. 퀴진(1식), 퀴진+헬씨퀴진(2식), 퀴진+간편식(2식) : 4일전까지 주문\r3. 그 외 전제품 : 6일전까지 주문\r\r재주문을 원하시면 잇슬림 홈페이지  (www.eatsslim.co.kr)를 이용해주세요.\r\r잇슬림을 이용해주셔서 감사합니다^^\r(본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.)')";
	//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 신선한 식자재 관리를 위해 6일 전까지 주문하셔야 연속으로 이용 가능합니다. 재주문을 원하시면 잇슬림 홈페이지(www.eatsslim.co.kr)를 이용해주세요.\r잇슬림을 이용해주셔서 감사합니다^^(본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.)')";

	try {
		stmt1.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}
	i++;

}
rs.close();

// 배송종료안내 7일전(외부몰)
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

while (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");
	productName		= rs.getString("GROUP_NAME");
	endDate			= rs.getString("MAX_DATE");
	shopChannel		= rs.getString("SHOP_CD");

	if (rcvHp.equals("010-9444-8585") || rcvHp.equals("010-7197-1346")) {
	} else {
		
		if (shopChannel.equals("53") || shopChannel.equals("59") || shopChannel.equals("60") ) {
			query1		= "INSERT INTO uds_msg (";
			query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
			query1		+= " ) VALUES (";
			query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 식자재 주문을 위해 상품별로 주문마감시간이 다르오니 아래를 참고하여 주문해주셔야 배달 중단 없이 연속 배달 가능하며, 주문 결제페이지에서 첫 배송일을 지정하거나 배송 메모에 요청사항 남겨주시면 적용해드립니다.\r\r1. 헬씨퀴진(1식) : 2일 전 11시까지 주문\r2. 퀴진(1식), 퀴진+헬씨퀴진(2식),퀴진+간편식(2식) : 4일전 11시까지 주문\r3. 그 외 전제품 : 7일전 11시까지 주문\r\r* 주말이 포함되어 있을 경우 2~3일 더 소요 됩니다.\r\r재주문을 원하시면 잇슬림 홈페이지  (www.eatsslim.co.kr)를 이용해주세요.\r\r잇슬림을 이용해주셔서 감사합니다^^\r(본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.)')";
			//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 신선한 식자재 관리를 위해 7일 전까지 주문하셔야 연속으로 이용 가능하며, 주문 시 주문 결제 페이지에서 첫 배송일을 지정할 수 있습니다. 추가 주문을 원하실 경우 잇슬림 홈페이지(www.eatsslim.co.kr)을 이용하세요^^\r잇슬림을 이용해주셔서 감사합니다. (본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.)')";
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}
		} else {
			query1		= "INSERT INTO uds_msg (";
			query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
			query1		+= " ) VALUES (";
			query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 식자재 주문을 위해 상품별로 주문마감시간이 다르오니 아래를 참고하여 주문해주셔야 배달 중단 없이 연속 배달 가능하며, 배송 메모에 요청사항 남겨주시면 적용해드립니다.\r\r1. 헬씨퀴진(1식) : 3일 전 까지 주문\r2. 퀴진(1식), 퀴진+헬씨퀴진(2식), 퀴진+간편식(2식) : 5일 전 까지 주문\r3. 그 외 전제품 : 7일 전 까지 주문\r\r* 주말이 포함되어 있을 경우 2~3일 더 소요 됩니다.\r\r재주문을 원하시면 잇슬림 홈페이지  (www.eatsslim.co.kr)를 이용해주세요.\r\r잇슬림을 이용해주셔서 감사합니다^^\r(본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.)')";
			//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 신선한 식자재 관리를 위해 7일 전까지 주문하셔야 연속으로 이용 가능하며, 배송 메모에 원하시는 첫 배송일을 남겨주시면 적용해드립니다. 추가 주문을 원하실 경우 잇슬림 홈페이지(www.eatsslim.co.kr)를 이용하세요^^\r잇슬림을 이용해주셔서 감사합니다. (본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.)')";
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}
		}
		
		i++;
	}
}
rs.close();

// 4주 주문 고개 배송종료안내 9일전(외부몰)
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

while (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");
	productName		= rs.getString("GROUP_NAME");
	endDate			= rs.getString("MAX_DATE");
	shopChannel		= rs.getString("SHOP_CD");

	if (rcvHp.equals("010-9444-8585") || rcvHp.equals("010-7197-1346")) {
	} else {
		
		if (shopChannel.equals("53") || shopChannel.equals("59") || shopChannel.equals("60") ) {
			query1		= "INSERT INTO uds_msg (";
			query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
			query1		+= " ) VALUES (";
			query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 식자재 주문을 위해 상품별로 주문마감시간이 다르오니 아래를 참고하여 주문해주셔야 배달 중단 없이 연속 배달 가능하며, 주문 결제페이지에서 첫 배송일을 지정하거나 배송 메모에 요청사항 남겨주시면 적용해드립니다.\r\r1. 헬씨퀴진(1식) : 2일 전 11시까지 주문\r2. 퀴진(1식), 퀴진+헬씨퀴진(2식),퀴진+간편식(2식) : 4일전 11시까지 주문\r3. 그 외 전제품 : 7일전 11시까지 주문\r\r* 주말이 포함되어 있을 경우 2~3일 더 소요 됩니다.\r재주문을 원하시면 잇슬림 홈페이지  (www.eatsslim.co.kr)를 이용해주세요.\r\r잇슬림을 이용해주셔서 감사합니다^^\r(본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.)')";
			//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 신선한 식자재 관리를 위해 7일 전까지 주문하셔야 연속으로 이용 가능하며, 주문 시 주문 결제 페이지에서 첫 배송일을 지정할 수 있습니다. 추가 주문을 원하실 경우 잇슬림 홈페이지(www.eatsslim.co.kr)을 이용하세요^^ 잇슬림을 이용해주셔서 감사합니다. (본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.')";
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}			
		} else {
			query1		= "INSERT INTO uds_msg (";
			query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
			query1		+= " ) VALUES (";
			query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 식자재 주문을 위해 상품별로 주문마감시간이 다르오니 아래를 참고하여 주문해주셔야 배달 중단 없이 연속 배달 가능하며, 배송 메모에 요청사항 남겨주시면 적용해드립니다.\r\r1. 헬씨퀴진(1식) : 3일 전 까지 주문\r2. 퀴진(1식), 퀴진+헬씨퀴진(2식), 퀴진+간편식(2식) : 5일 전 까지 주문\r3. 그 외 전제품 : 7일 전 까지 주문\r\r* 주말이 포함되어 있을 경우 2~3일 더 소요 됩니다.\r\r재주문을 원하시면 잇슬림 홈페이지  (www.eatsslim.co.kr)를 이용해주세요.\r\r잇슬림을 이용해주셔서 감사합니다^^\r(본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.)')";
			//query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림] 배송종료안내', '[풀무원잇슬림] 안녕하세요. 건강하고 맛있는 다이어트, 풀무원 잇슬림입니다. 주문하신 \""+ productName +"\"의 마지막 배송일은 \""+ endDate +"\"입니다. 잇슬림은 신선한 식자재 관리를 위해 7일 전까지 주문하셔야 연속으로 이용 가능하며 배송 메모에 원하시는 첫 배송일을 남겨주시면 적용해드립니다. 추가 주문을 원하실 경우 잇슬림 홈페이지(www.eatsslim.co.kr)을 이용하세요^^ 잇슬림을 이용해주셔서 감사합니다. (본 메시지는 발신용으로 추가 문의 시 잇슬림 고객센터(080-800-0434) 또는 홈페이지 1:1 게시판 이용 부탁드립니다.')";
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}
		}
		
		i++;
	}
}
rs.close();

%>
<%@ include file="/lib/dbclose.jsp" %>