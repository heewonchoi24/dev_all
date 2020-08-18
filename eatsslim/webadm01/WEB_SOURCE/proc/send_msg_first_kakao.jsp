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


// ù��۾ȳ�
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
		query1		+= " ,'[Ǯ�����ս���] ����. ���� ��ǰ�� �� �����̳���? Ǯ���� �ս��� �̿� �� ���� ���� �ȳ��帳�ϴ�.\rStep 1. ���ö��� ������ �ǵ��� ���庸�� �ϱ� (������� ���� ǥ��)\rStep 2. ���ð���� ���̽����� �״�� ���� ������ �ɾ�α� (���̽����� ��� �� ���� �󸰰����� ��ü�ص����!)\rStep 3. ����� ������ 3�� ������! (������� ������ �Ʒ� ��ũ�� Ǯ���� ����ݼ��Ϳ��� ���� �����մϴ�. Ǯ���� ����ݼ���> �ֹ���ȸ/���� > ��۽����� Ȯ�� / ����)'";
		query1		+= " ,'[Ǯ�����ս���] ù��� �ȳ�','[Ǯ�����ս���] ����. ���� ��ǰ�� �� �����̳���? Ǯ���� �ս��� �̿� �� ���� ���� �ȳ��帳�ϴ�.\rStep 1. ���ö��� ������ �ǵ��� ���庸�� �ϱ� (������� ���� ǥ��)\rStep 2. ���ð���� ���̽����� �״�� ���������� �ɾ�α� (���̽����� ��޽ø��� �󸰰����� ��ü�ص����!)\rStep 3. ����� ������ 3�� ������! (Ȩ������ ����������>��������� �Ǵ� 1:1�Խ����� ���� �������ּ���.)'";
		query1		+= ",'001','002','004','"+ rcvHp +"'";
		query1		+= " ,'02-6411-8322','R00',SYSDATE,'eat2',SYSDATE";
		query1		+= " ,'kakao_es','N','����ݼ��͹ٷΰ���','http://plus.kakao.com/talk/home/@pmo_cs','','')";
		
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