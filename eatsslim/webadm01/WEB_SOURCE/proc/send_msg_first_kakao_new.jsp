<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_kakao.jsp"%>
<%
String query		= "";
String query1		= "";
Statement stmt1	= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String customerNum	= "";
String orderNum		= "";
String rcvHp				= "";
String sendYn			= "N";
int i				= 0;
int j				= 0;

String minDate			= "";
String maxDate			= "";
String shopChannel		= "";
String goodsID			= "";
String productName 	= "";

// ù��۾ȳ�
query		= "SELECT "; 
query		+= " (SELECT GROUP_NAME FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS EOG";
query		+= " WHERE G.ID = EOG.GROUP_ID AND EOG.ID = GOODS_ID) AS GROUP_NAME,";
query		+= " RCV_HP, DATE_FORMAT(MIN(DEVL_DATE), '%Y-%m-%d') AS MIN_DATE, DATE_FORMAT(MAX(DEVL_DATE), '%Y-%m-%d') AS MAX_DATE, SHOP_CD, SHOP_ORDER_NUM ";
query		+= " FROM ESL_ORDER_DEVL_DATE";
query		+= " WHERE STATE < 90";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668', '7001')";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND LEFT(RCV_HP, 4) not in ('0502', '0503', '0504', '0505')";
query		+= " AND ORDER_DATE > DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL -90 DAY)";
query		+= " GROUP BY ORDER_NUM, GOODS_ID";
//query		+= " HAVING MIN_DATE = DATE_FORMAT(NOW(), '%Y-%m-%d')";
query		+= " HAVING MIN_DATE = DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL 1 DAY)";

try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs.next()) {
	rcvHp			= rs.getString("RCV_HP");
	orderNum		= rs.getString("SHOP_ORDER_NUM");
	shopChannel	= rs.getString("SHOP_CD");
	productName	= rs.getString("GROUP_NAME");
	minDate		= rs.getString("MIN_DATE");
	maxDate		= rs.getString("MAX_DATE");

	if (rcvHp.equals("010-9444-8585") || rcvHp.equals("010-7197-1346")) {
	} else {
		
		query1		= "INSERT INTO CUST_DELV_ALL.TSMS_AGENT_MESSAGE ("; 
		query1		+= " MESSAGE_SEQNO, SERVICE_SEQNO";
		query1		+= " ,SEND_MESSAGE";
		query1		+= " ,SUBJECT,BACKUP_MESSAGE,TEMPLATE_CODE";
		query1		+= " ,BACKUP_PROCESS_CODE,MESSAGE_TYPE,CONTENTS_TYPE,RECEIVE_MOBILE_NO";
		query1		+= " ,CALLBACK_NO,JOB_TYPE,SEND_RESERVE_DATE,REGISTER_DATE";
		query1		+= " ,REGISTER_BY, SEND_FLAG, KKO_BTN_NAME, KKO_BTN_URL, TAX_LEVEL1_NM ,TAX_LEVEL2_NM";
		query1		+= " ) VALUES (";
		query1		+= " CUST_DELV_ALL.TSMS_MESSAGE_SEQ.nextval ,'1710002662'";
		
		if (shopChannel.equals("51") || shopChannel.equals("52") ) {
			query1		+= " ,'[Ǯ�����ս���] �ֹ��Ͻ� �ս����� ����� ���Ϻ��� ���۵˴ϴ�.\r\r�� �ֹ���ǰ : " + productName + "\r�� ��۱Ⱓ : " + minDate + "~" +maxDate + "\r\r�� �ս��� �̿� TIP!\rStep 1. ��۵� ���ö��� ������ ���庸�� ���ּ���.\rStep 2. ���ð���� ���̽����� ������ �տ� �ɾ��ּ���.\rStep 3. ����� ������ 3�������� ����ݼ��� �Ǵ� �ս��� Ȩ���������� �����մϴ�.\r\r�� ����ݼ��� �̿��� Ȯ���ϱ�\rhttps://goo.gl/yQGCmi'";
			query1		+= " ,'[Ǯ�����ս���] ù��� �ȳ�','[Ǯ�����ս���] �ֹ��Ͻ� �ս����� ����� ���Ϻ��� ���۵˴ϴ�.\r�� �ֹ���ǰ : " + productName + "\r�� ��۱Ⱓ : " + minDate + "~" +maxDate + "\r�� �ս��� �̿� TIP!\rStep 1. ��۵� ���ö��� ������ ���庸�� ���ּ���.\rStep 2. ���ð���� ���̽����� ������ �տ� �ɾ��ּ���.\rStep 3. ����� ������ 3�������� ����ݼ��� �Ǵ� �ս��� Ȩ���������� �����մϴ�.\r\r�� ����ݼ��� �̿��� Ȯ���ϱ�\rhttps://goo.gl/yQGCmi'";
			query1		+= " ,'eat25'";
		} else {
			query1		+= " ,'[Ǯ�����ս���] �ֹ��Ͻ� �ս����� ����� ���Ϻ��� ���۵˴ϴ�.\r\r�� �ֹ���ǰ : " + productName + "\r�� ��۱Ⱓ : " + minDate + "~" +maxDate + "\r�� �ֹ���ȣ : " + orderNum + "\r\r�� �ս��� �̿� TIP!\rStep 1. ��۵� ���ö��� ������ ���庸�� ���ּ���.\rStep 2. ���ð���� ���̽����� ������ �տ� �ɾ��ּ���.\rStep 3. ����� ������ 3�������� ����ݼ��Ϳ��� �����մϴ�.\r\r�� ����ݼ��� �̿��� Ȯ���ϱ�\rhttps://goo.gl/yQGCmi'";
			query1		+= " ,'[Ǯ�����ս���] ù��� �ȳ�','[Ǯ�����ս���] �ֹ��Ͻ� �ս����� ����� ���Ϻ��� ���۵˴ϴ�.\r�� �ֹ���ǰ : " + productName + "\r�� ��۱Ⱓ : " + minDate + "~" +maxDate + "\r�� �ս��� �̿� TIP!\rStep 1. ��۵� ���ö��� ������ ���庸�� ���ּ���.\rStep 2. ���ð���� ���̽����� ������ �տ� �ɾ��ּ���.\rStep 3. ����� ������ 3�������� ����ݼ��Ϳ��� �����մϴ�.\r\r�� ����ݼ��� �̿��� Ȯ���ϱ�\rhttps://goo.gl/yQGCmi'";
			query1		+= " ,'eat26'";
		}
		
		query1		+= ",'001','002','004','"+ rcvHp +"'";
		query1		+= " ,'02-6411-8322','R00',SYSDATE,SYSDATE";
		query1		+= " ,'kakao_es','N','�ս����ٷΰ���','http://www.eatsslim.co.kr','','')";
		
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
rs.close();
if (stmt1 != null) try { stmt1.close(); } catch (Exception e) {}

%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_kakao.jsp" %>