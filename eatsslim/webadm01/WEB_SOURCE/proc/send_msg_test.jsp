<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_kakao.jsp"%>
<%
String query		= "";
String query1		= "";
//Statement stmt1		= null;
//ResultSet rs1		= null;
//stmt1				= conn.createStatement();
String table		= "ESL_ORDER_DEVL_DATE";
String customerNum	= "";
String rcvHp		= "";
String sendYn		= "N";
int i				= 0;

	query1		= "INSERT INTO CUST_DELV_ALL.TSMS_AGENT_MESSAGE ("; 
	query1		+= " MESSAGE_SEQNO, SERVICE_SEQNO";
	query1		+= " ,SEND_MESSAGE";
	query1		+= " ,SUBJECT,BACKUP_MESSAGE,TEMPLATE_CODE";
	query1		+= " ,BACKUP_PROCESS_CODE,MESSAGE_TYPE,CONTENTS_TYPE,RECEIVE_MOBILE_NO";
	query1		+= " ,CALLBACK_NO,JOB_TYPE,SEND_RESERVE_DATE,REGISTER_DATE";
	query1		+= " ,REGISTER_BY, SEND_FLAG, KKO_BTN_NAME, KKO_BTN_URL, TAX_LEVEL1_NM ,TAX_LEVEL2_NM";
	query1		+= " ) VALUES (";
	query1		+= " CUST_DELV_ALL.TSMS_MESSAGE_SEQ.nextval ,'1710002662'";
	
			query1		+= " ,'[Ǯ�����ս���] �ֹ��Ͻ� �ս����� ����� ���Ϻ��� ���۵˴ϴ�.\r\r�� �ֹ���ǰ : ����\r�� ��۱Ⱓ : 2018-03-11 ~ 2018-03-20\r\r�� �ս��� �̿� TIP!\rStep 1. ��۵� ���ö��� ������ ���庸�� ���ּ���.\rStep 2. ���ð���� ���̽����� ������ �տ� �ɾ��ּ���.\rStep 3. ����� ������ 3�������� ����ݼ��� �Ǵ� �ս��� Ȩ���������� �����մϴ�.\r\r�� ����ݼ��� �̿��� Ȯ���ϱ�\rhttps://goo.gl/yQGCmi'";
			query1		+= " ,'[Ǯ�����ս���] ù��� �ȳ�','[Ǯ�����ս���] �ֹ��Ͻ� �ս����� ����� ���Ϻ��� ���۵˴ϴ�.\r�� �ֹ���ǰ : ����\r�� ��۱Ⱓ : 2018-03-11 ~ 2018-03-20\r�� �ս��� �̿� TIP!\rStep 1. ��۵� ���ö��� ������ ���庸�� ���ּ���.\rStep 2. ���ð���� ���̽����� ������ �տ� �ɾ��ּ���.\rStep 3. ����� ������ 3�������� ����ݼ��� �Ǵ� �ս��� Ȩ���������� �����մϴ�.\r\r�� ����ݼ��� �̿��� Ȯ���ϱ�\rhttps://goo.gl/yQGCmi'";
			query1		+= " ,'eat25'";
	
	query1		+= ",'001','002','004','01072066245'";
	query1		+= " ,'02-6411-8322','R00',SYSDATE,SYSDATE";
	query1		+= " ,'kakao_es','N','�ս���Ȩ������','http://www.eatsslim.co.kr/index_es.jsp','','')";
	
	try {
			stmt_kakao.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_kakao.jsp" %>