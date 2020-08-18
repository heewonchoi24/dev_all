<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_kakao.jsp"%>
<%
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String couponId	= ut.inject(request.getParameter("id"));
String rcvHp		= "";
String orderNum		= "";
String outOrderNum		= "";
int i				= 0;

String minDate			= "";
String maxDate			= "";
String shopChannel		= "";
String couponName 	= "";
String dDays				= "";

// ���ε� �ֹ� �ȳ�
query		= "select COUPON_NAME, DATE_FORMAT(LTDATE, '%Y-%m-%d') AS LTDATE, ECM.MEMBER_ID, EM.HP AS RCV_HP, DATEDIFF(LTDATE, NOW()) AS DDAYS";
query		+= " from ESL_COUPON EC, ESL_COUPON_MEMBER ECM, ESL_MEMBER EM";
query		+= " where EC.ID = ECM.COUPON_ID and EM.MEM_ID = ECM.MEMBER_ID";
query		+= " and EC.ID = '"+couponId+"'";
query		+= " and ECM.USE_YN = 'N'";
query		+= " and EM.HP is not null";

try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");
	couponName		= rs.getString("COUPON_NAME");
	maxDate	= rs.getString("LTDATE");
	dDays		= rs.getString("DDAYS");
	
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

	query1		+= " ,'[Ǯ�����ս���] ���Բ��� �����Ͻ� ���� ���Ⱓ�� " + dDays + "�� ���ҽ��ϴ�. ���Բ� �� �ʿ��� ���� ��ġ�� ������~\r\r��"+ couponName + "��\r- ���Ⱓ : "+ maxDate + " ����\r- Ȯ�� : �ս��� �α���>����������>�߱޵�����'";
	query1		+= " ,'[Ǯ�����ս���] ��������ȳ�'";
	query1		+= " ,'[Ǯ�����ս���] ���Բ��� �����Ͻ� ���� ���Ⱓ�� " + dDays + "�� ���ҽ��ϴ�. ���Բ� �� �ʿ��� ���� ��ġ�� ������~\r\r��"+ couponName + "��\r- ���Ⱓ : "+ maxDate + " ����\r- Ȯ�� : �ս��� �α���>����������>�߱޵�����'";
	query1		+= ",'001','002','004','"+rcvHp+"'";
	query1		+= " ,'02-6411-8322','R00',SYSDATE,'10102',SYSDATE";
	query1		+= " ,'kakao_es','N','�ս��� Ȩ������','http://www.eatsslim.co.kr','','')";

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
if (stmt1 != null) try { stmt1.close(); } catch (Exception e) {}

out.println("�˸��� �߼ۿ�û �Ǽ� : " + i);

%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_kakao.jsp" %>