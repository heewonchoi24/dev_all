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

// �������ȳ� 6����(�ڻ��)
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
	
	query1		+= " ,'�ȳ��ϼ���. Ǯ���������Դϴ�.\r�ڻ� ������ ������ �߻��Ͽ� ���Բ� 3/5~3/6 ���������� ��ǰ ����� �������� ���Ͽ����ϴ�. ��ǰ�� �̿��Ͻôµ� ������ ��� �ٽ� �� �� �˼��� ���� �帮��, ���� ���Ͻ� ��¥�� ���ؼ��� ���� �����ص�Ȱ� �߰��� ������ ������ ��Ƚ��ϴ�. ������ ������ �߻����� �ʵ��� ö���� �����ϰڻ���� �����ε� Ǯ�������� ���� ��� ��Ź�帳�ϴ�.'";
	query1		+= " ,'[Ǯ�������� �ȳ�]','�ȳ��ϼ���. Ǯ���������Դϴ�.\r�ڻ� ������ ������ �߻��Ͽ� ���Բ� 3/5~3/6 ���������� ��ǰ ����� �������� ���Ͽ����ϴ�. ��ǰ�� �̿��Ͻôµ� ������ ��� �ٽ� �� �� �˼��� ���� �帮��, ���� ���Ͻ� ��¥�� ���ؼ��� ���� �����Ͽ��� ������ �������� ������ �߰� ������ ��Ƚ��ϴ�. ������ ������ �߻����� �ʵ��� ö���� �����ϰڻ���� �����ε� Ǯ�������� ���� ��� ��Ź�帳�ϴ�.'";
	query1		+= " ,'eat23'";
	
	query1		+= ",'001','002','004','"+ rcvHp +"'";
	query1		+= " ,'02-2186-8721','R00',SYSDATE,SYSDATE";
	query1		+= " ,'kakao_es','N','�ս���Ȩ������','http://www.eatsslim.co.kr/index_es.jsp','','')";
	
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