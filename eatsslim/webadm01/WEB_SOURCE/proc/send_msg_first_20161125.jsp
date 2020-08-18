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


// 첫배송안내
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
		query1		+= "	5, now()+"+i+", now(), now(), '"+ rcvHp +"', '02-6411-8322', '[풀무원잇슬림]', '[풀무원잇슬림] 고객님. 금일 상품은 잘 받으셨나요? 풀무원 잇슬림 이용 시 유의 사항 안내드립니다.\rStep 1. 도시락은 꺼내어 되도록 냉장보관 하기 (유통기한 옆면 표시)\rStep 2. 보냉가방과 아이스젤은 그대로 현관문고리에 걸어두기 (아이스젤은 배달시마다 얼린것으로 교체해드려요!)\rStep 3. 배송일 조정은 3일 전까지! (홈페이지 마이페이지>배송일조정 또는 1:1게시판을 통해 문의해주세요.) ')";
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