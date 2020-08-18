<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_kakao.jsp"%>
<%
String query		= "";
String query1		= "";
String table		= "ESL_ORDER_DEVL_DATE";
String customerNum	= "";
String rcvHp		= "";
String sendYn		= "N";
int i				= 0;


// 첫배송안내
query		= "SELECT RCV_HP, MIN(DEVL_DATE) MIN_DATE FROM "+ table;
query		+= " WHERE STATE < 90";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668', '7001')";
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
		
		query1		= "INSERT INTO CUST_DELV_ALL.TSMS_AGENT_MESSAGE (";
		query1		+= " MESSAGE_SEQNO, SERVICE_SEQNO";
		query1		+= " ,SEND_MESSAGE";
		query1		+= " ,SUBJECT,BACKUP_MESSAGE";
		query1		+= " ,BACKUP_PROCESS_CODE,MESSAGE_TYPE,CONTENTS_TYPE,RECEIVE_MOBILE_NO";
		query1		+= " ,CALLBACK_NO,JOB_TYPE,SEND_RESERVE_DATE,TEMPLATE_CODE,REGISTER_DATE";
		query1		+= " ,REGISTER_BY, SEND_FLAG, KKO_BTN_NAME, KKO_BTN_URL, TAX_LEVEL1_NM ,TAX_LEVEL2_NM";
		query1		+= " ) VALUES (";
		query1		+= " CUST_DELV_ALL.TSMS_MESSAGE_SEQ.nextval ,'1710002662'";
		query1		+= " ,'[풀무원잇슬림] 고객님. 금일 상품은 잘 받으셨나요? 풀무원 잇슬림 이용 시 유의 사항 안내드립니다.\rStep 1. 도시락은 꺼내어 되도록 냉장보관 하기 (유통기한 옆면 표시)\rStep 2. 보냉가방과 아이스젤은 그대로 현관 문고리에 걸어두기 (아이스젤은 배달 시 매일 얼린것으로 교체해드려요!)\rStep 3. 배송일 조정은 3일 전까지! (배송일정 조정은 아래 링크된 풀무원 고객기쁨센터에서 조정 가능합니다. 풀무원 고객기쁨센터> 주문조회/변경 > 배송스케줄 확인 / 변경)'";
		query1		+= " ,'[풀무원잇슬림] 첫배송 안내','[풀무원잇슬림] 고객님. 금일 상품은 잘 받으셨나요? 풀무원 잇슬림 이용 시 유의 사항 안내드립니다.\rStep 1. 도시락은 꺼내어 되도록 냉장보관 하기 (유통기한 옆면 표시)\rStep 2. 보냉가방과 아이스젤은 그대로 현관문고리에 걸어두기 (아이스젤은 배달시마다 얼린것으로 교체해드려요!)\rStep 3. 배송일 조정은 3일 전까지! (홈페이지 마이페이지>배송일조정 또는 1:1게시판을 통해 문의해주세요.)'";
		query1		+= ",'001','002','004','"+ rcvHp +"'";
		query1		+= " ,'02-6411-8322','R00',SYSDATE,'eat2',SYSDATE";
		query1		+= " ,'kakao_es','N','고객기쁨센터바로가기','http://plus.kakao.com/talk/home/@pmo_cs','','')";
		
		//out.println(query1);		
		try {
			stmt_kakao.executeUpdate(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}
		
		i++;
	}
}
//rs.close();


%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_kakao.jsp" %>