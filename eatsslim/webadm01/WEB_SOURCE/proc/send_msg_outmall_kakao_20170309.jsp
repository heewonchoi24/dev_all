<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_kakao.jsp"%>
<%
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String table		= "ESL_ORDER_DEVL_DATE";
//String customerNum	= "";
String rcvHp		= "";
String orderNum		= "";
//String sendYn		= "N";
int i				= 0;
int j				= 0;

String minDate			= "";
String maxDate			= "";
String shopChannel	= "";
String productName 		= "";

// 업로드 주문 안내
query		= "SELECT ORDER_NUM, RCV_HP FROM "+ table;
query		+= " WHERE STATE < 90";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668')";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND LEFT(RCV_HP, 4) not in ('0503', '0504')";
query		+= " AND SHOP_CD not in ('51', '52')";
query		+= " AND SUBSTRING(DATE_FORMAT(NOW(), '%Y%m%d'), 3, 6) = SUBSTRING(ORDER_NUM, 4, 6)";
query		+= " GROUP BY RCV_HP";

try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");
	orderNum		= rs.getString("ORDER_NUM");

	//상품명
	query1		= "SELECT GROUP_NAME, RCV_HP";
	query1		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O";
	query1		+= " WHERE G.ID = OG.GROUP_ID";
	query1		+= " AND OG.ORDER_NUM = O.ORDER_NUM AND OG.ORDER_NUM = '"+ orderNum +"'";
	query1		+= " ORDER BY O.ID DESC";
	try {
		rs1 = stmt1.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	j		= 0;
	while (rs1.next()) {
		if (j > 0) {
			productName	= rs1.getString("GROUP_NAME")+" 외 "+ j +"건";
		} else {
			productName	= rs1.getString("GROUP_NAME");
		}
		j++;
	}
	rs1.close();


	query1		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE, SHOP_CD";
	query1		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"' AND GROUP_CODE != '0300578'";
	try {
		rs1			= stmt1.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	if (rs1.next()) {
		minDate			= ut.isnull(rs1.getString("MIN_DATE"));
		maxDate			= ut.isnull(rs1.getString("MAX_DATE"));
		shopChannel			= ut.isnull(rs1.getString("SHOP_CD"));
	}
	rs1.close();

	query1		= "INSERT INTO CUST_DELV_ALL.TSMS_AGENT_MESSAGE (";
	query1		+= " MESSAGE_SEQNO, SERVICE_SEQNO";
	query1		+= " ,SEND_MESSAGE";
	query1		+= " ,SUBJECT";
	query1		+= " ,BACKUP_MESSAGE";
	query1		+= " ,BACKUP_PROCESS_CODE,MESSAGE_TYPE,CONTENTS_TYPE,RECEIVE_MOBILE_NO";
	query1		+= " ,CALLBACK_NO,JOB_TYPE,SEND_RESERVE_DATE,TEMPLATE_CODE,REGISTER_DATE";
	query1		+= " ,REGISTER_BY, SEND_FLAG, KKO_BTN_NAME, KKO_BTN_URL, TAX_LEVEL1_NM ,TAX_LEVEL2_NM";
	query1		+= " ) VALUES (";
	query1		+= " CUST_DELV_ALL.TSMS_MESSAGE_SEQ.nextval ,'1710002662'";

	if (shopChannel.equals("53") || shopChannel.equals("59") || shopChannel.equals("60") ) {
	query1		+= " ,'[풀무원잇슬림] 잇슬림 주문이 완료되었습니다. 주문하신 잇슬림 \""+ productName + "\"이 \"" + minDate + "~" +maxDate + "\" 동안 배달 예정입니다.\r\r- 이달의 식단 안내 : http://www.eatsslim.co.kr/mobile/intro/schedule.jsp\r- 상세 주문 조회 및 배송 일정/배송지 변경 등을 원하실 경우 아래 링크된 풀무원고객기쁨센터를 통해 조정 가능하십니다. 감사합니다.  (풀무원고객기쁨센터 > 외부몰 주문조회)\r*풀무원샵 잇슬림 주문 건은, 잇슬림 자사몰과 다르므로 꼭 외부몰 주문조회를 이용해주세요.'";
	query1		+= " ,'[풀무원잇슬림] 배송안내'";
	query1		+= " ,'[풀무원잇슬림] 잇슬림 \""+ productName + "\" \"" + minDate + "~" +maxDate + "\"동안 배달 예정입니다. 식단 안내 : 잇슬림 이달의 식단 스케쥴 URL 안내 ( http://www.eatsslim.co.kr/mobile/intro/schedule.jsp ) 배송일 변경은 받으시는 날 3일전까지 잇슬림 홈페이지( www.eatsslim.co.kr )를 통하여 가능하시며, 기타 문의사항은 고객센터(02-6411-8322) 또는 문의 게시판을 통해 남겨주세요. 감사합니다.'";
	query1		+= ",'001','002','004','"+rcvHp+"'";
	query1		+= " ,'02-6411-8322','R00',SYSDATE,'eat4',SYSDATE";
	} else {
	query1		+= " ,'[풀무원잇슬림] 잇슬림 주문이 완료되었습니다. 주문하신 잇슬림 \""+ productName + "\"이 \"" + minDate + "~" +maxDate + "\" 동안 배달 예정입니다.\r\r- 이달의 식단 안내 : http://www.eatsslim.co.kr/mobile/intro/schedule.jsp\r- 상세 주문 조회 및 배송 일정/배송지 변경 등을 원하실 경우 아래 링크된 풀무원고객기쁨센터를 통해 조정 가능하십니다. 감사합니다.\r(풀무원고객기쁨센터 > 외부몰 주문조회)'";
	query1		+= " ,'[풀무원잇슬림] 배송안내'";
	query1		+= " ,'[풀무원잇슬림] 잇슬림 \""+ productName + "\" \"" + minDate + "~" +maxDate + "\"동안 배달 예정입니다. 식단 안내 : 잇슬림 이달의 식단 스케쥴 URL 안내 ( http://www.eatsslim.co.kr/mobile/intro/schedule.jsp ) 배송일 변경은 받으시는 날 3일전까지 잇슬림 홈페이지( www.eatsslim.co.kr )를 통하여 가능하시며, 기타 문의사항은 고객센터(02-6411-8322) 또는 문의 게시판을 통해 남겨주세요. 감사합니다.'";
	query1		+= ",'001','002','004','"+rcvHp+"'";
	query1		+= " ,'02-6411-8322','R00',SYSDATE,'eat5',SYSDATE";
	}

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
rs.close();


%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_kakao.jsp" %>