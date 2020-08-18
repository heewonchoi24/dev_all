<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_kakao.jsp"%>
<%
String query		= "";
String query1		= "";
//Statement stmt1		= null;
//ResultSet rs1		= null;
//stmt1				= conn.createStatement();
String table		= "TEMP_SMS_LIST";
String customerNum	= "";
String rcvHp		= "";
String sendYn		= "N";
int i				= 0;

// 배송종료안내 6일전(자사몰)
query		= "SELECT phonenum FROM "+ table;
//query		+= " WHERE idx = 1";
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs.next()) {
	rcvHp			= rs.getString("phonenum");

	query1		= "INSERT INTO CUST_DELV_ALL.TSMS_AGENT_MESSAGE ("; 
	query1		+= " MESSAGE_SEQNO, SERVICE_SEQNO";
	query1		+= " ,SEND_MESSAGE";
	query1		+= " ,SUBJECT,BACKUP_MESSAGE,TEMPLATE_CODE";
	query1		+= " ,BACKUP_PROCESS_CODE,MESSAGE_TYPE,CONTENTS_TYPE,RECEIVE_MOBILE_NO";
	query1		+= " ,CALLBACK_NO,JOB_TYPE,SEND_RESERVE_DATE,REGISTER_DATE";
	query1		+= " ,REGISTER_BY, SEND_FLAG, KKO_BTN_NAME, KKO_BTN_URL, TAX_LEVEL1_NM ,TAX_LEVEL2_NM";
	query1		+= " ) VALUES (";
	query1		+= " CUST_DELV_ALL.TSMS_MESSAGE_SEQ.nextval ,'1710002662'";
	
	query1		+= " ,'안녕하세요. 풀무원녹즙입니다.\r자사 서버에 문제가 발생하여 고객님께 3/5~3/6 정상적으로 제품 배송을 진행하지 못하였습니다. 제품을 이용하시는데 불편을 드려 다시 한 번 죄송의 말씀 드리며, 음용 못하신 날짜에 대해서는 일정 연기해드렸고 추가로 음용일 증정해 드렸습니다. 동일한 문제가 발생하지 않도록 철저히 점검하겠사오니 앞으로도 풀무원녹즙 많은 사랑 부탁드립니다.'";
	query1		+= " ,'[풀무원녹즙 안내]','안녕하세요. 풀무원녹즙입니다.\r자사 서버에 문제가 발생하여 고객님께 3/5~3/6 정상적으로 제품 배송을 진행하지 못하였습니다. 제품을 이용하시는데 불편을 드려 다시 한 번 죄송의 말씀 드리며, 음용 못하신 날짜에 대해서는 일정 변경하였고 사죄의 마음으로 음용일 추가 증정해 드렸습니다. 동일한 문제가 발생하지 않도록 철저히 점검하겠사오니 앞으로도 풀무원녹즙 많은 사랑 부탁드립니다.'";
	query1		+= " ,'eat23'";
	
	query1		+= ",'001','002','004','"+ rcvHp +"'";
	query1		+= " ,'02-2186-8721','R00',SYSDATE,SYSDATE";
	query1		+= " ,'kakao_es','N','잇슬림홈페이지','http://www.eatsslim.co.kr/index_es.jsp','','')";
	
	try {
			stmt_kakao.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}
}
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_kakao.jsp" %>