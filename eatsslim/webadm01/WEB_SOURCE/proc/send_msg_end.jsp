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


// 배송종료안내 6일전(자사몰)
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
		query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림]', '[풀무원잇슬림]안녕하세요. 잇슬림입니다. 주문하신 상품의 배송이 6일 후 배송 종료됩니다. 이용하시는 데에 불편하신 점은 없으셨는지요~? 잇슬림은 식자재 주문을 위해 6일전 주문해주셔야 배송 중단 없이 연속 배송 가능하십니다. 재주문을 원하시면 잇슬림 홈페이지(www.eatsslim.co.kr) 또는 전화 주문 이용해주세요^^')";
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
	query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림]', '[풀무원잇슬림]안녕하세요. 잇슬림입니다. 주문하신 상품의 배송이 8일 후 배송 종료됩니다. 잇슬림은 식자재 주문을 위해 원하시는 배송일로부터 6일 전까지 주문해주셔야 하는 점 참고 부탁드리며, 재주문을 원하시면 잇슬림 홈페이지(www.eatsslim.co.kr) 또는 전화 주문 이용해주세요^^')";
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
		query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림]', '[풀무원잇슬림]안녕하세요. 잇슬림입니다. 주문하신 상품의 배송이 7일 후 배송 종료됩니다. 이용하시는 데에 불편하신 점은 없으셨는지요~? 잇슬림은 식자재 주문을 위해 잇슬림 홈페이지에서 6일전까지 주문해주셔야 배송 중단 없이 연속 배송 가능하십니다. 배송일 수정 편리, 빠른 배송일, 할인/이벤트 소식 알림 등 잇슬림 홈페이지(www.eatsslim.co.kr) 주문을 통해 다양한 혜택을 누려보세요.')";
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

// 4주 주문 고개 배송종료안내 9일전(외부몰)
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
	query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림]', '[풀무원잇슬림]안녕하세요. 잇슬림입니다. 주문하신 상품의 배송이 9일 후 배송 종료됩니다. 잇슬림은 식자재 주문을 위해 잇슬림 홈페이지에서 7일 전까지 주문해주셔야 배송 중단 없이 연속 배송 가능하십니다. 배송일 수정 편리, 빠른 배송일, 할인/이벤트 소식 알림 등 잇슬림 홈페이지(www.eatsslim.co.kr) 주문을 통해 다양한 혜택을 누려보세요.')";
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