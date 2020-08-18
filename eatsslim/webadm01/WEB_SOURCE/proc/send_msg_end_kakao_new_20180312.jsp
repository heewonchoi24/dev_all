<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_kakao.jsp"%>
<%
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();

String customerNum	= "";
String rcvHp		= "";
String productName = "";
String endDate = "";
String shopChannel = "";
String sendYn		= "N";
String sendType	= "01";
String shopCd		= "";
int devlCnt			= 0;
String groupCode	= "";
String dateDif		= "";
String custCd		= "";
String newDate		= "";

int i				= 0;


// 1�� ���� �߼�
query		= "SELECT OGG.GROUP_CODE, OGG.GROUP_NAME, ODD.RCV_HP, DATE_FORMAT(ODD.MAX_DATE, '%Y-%m-%d') AS MAX_DATE, ODD.SHOP_CD";
query		+= " ,DATEDIFF(MAX_DATE, NOW()) DATEDIF, OGG.ORDER_NUM, ODD.DELVCNT, ODD.CUSTOMER_NUM ";
query		+= " , case when ODD.SHOP_CD in ( '51' , '52' ) then";
query		+= "   case ";
query		+= "     when OGG.GROUP_CODE = '0301369' then DATE_FORMAT(DATE_ADD(MAX_DATE, INTERVAL -1 DAY), '%Y-%m-%d')";
query		+= "     when OGG.GROUP_CODE in ('0300717' ,'0301079' ,'0300944' ,'0301385') then DATE_FORMAT(DATE_ADD(MAX_DATE, INTERVAL -3 DAY), '%Y-%m-%d')";
query		+= "   else DATE_FORMAT(DATE_ADD(MAX_DATE, INTERVAL -5 DAY), '%Y-%m-%d') end";
query		+= "  else";
query		+= "  case ";
query		+= "     when OGG.GROUP_CODE = '0301369' then DATE_FORMAT(DATE_ADD(MAX_DATE, INTERVAL -2 DAY), '%Y-%m-%d')";
query		+= "     when OGG.GROUP_CODE in ('0300717' ,'0301079' ,'0300944' ,'0301385') then DATE_FORMAT(DATE_ADD(MAX_DATE, INTERVAL -4 DAY), '%Y-%m-%d')";
query		+= "   else DATE_FORMAT(DATE_ADD(MAX_DATE, INTERVAL -6 DAY), '%Y-%m-%d') end";
query		+= " end AS NEW_DATE";
query		+= " FROM";
query		+= " ( SELECT G.GROUP_NAME, OG.ORDER_NUM, OG.ID, G.GROUP_CODE";
query		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG";
query		+= " WHERE G.ID = OG.GROUP_ID";
query		+= " AND OG.DEVL_TYPE = '0001'";
query		+= " AND OG.ORDER_STATE in ('01', '911')";
query		+= " AND OG.DEVL_DATE >  DATE_ADD(NOW(), INTERVAL -180 DAY)";
query		+= " ) OGG, (";
query		+= " SELECT GOODS_ID, ORDER_NUM, RCV_HP, MAX(DEVL_DATE) MAX_DATE, SHOP_CD, COUNT(ID) AS DELVCNT, CUSTOMER_NUM FROM ESL_ORDER_DEVL_DATE";
query		+= " WHERE STATE in ('01', '02', '911')";
query		+= " AND GUBUN_CODE NOT IN ('0331', '0332', '0300668')";
query		+= " AND DEVL_TYPE = '0001'";
query		+= " AND LEFT(RCV_HP, 4) not in ('0502', '0503', '0504', '0505')";
query		+= " AND ORDER_DATE > DATE_ADD(NOW(), INTERVAL -180 DAY) ";
query		+= "GROUP BY RCV_HP, ORDER_NUM, GOODS_ID";

//query		+= " HAVING MAX_DATE <= DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-%d'), INTERVAL 8 DAY) ";
//query		+= " AND MAX_DATE >= NOW()";
//query		+= " AND COUNT(*) >= 12";

query		+= " HAVING DATEDIFF(MAX_DATE, NOW()) in ( 9, 8, 7, 6, 5, 4, 3, 2, 0 ) ";
//query		+= " AND DATEDIFF(MAX_DATE, NOW()) > 3 ";

query		+= " ) ODD";
query		+= " WHERE OGG.ORDER_NUM = ODD.ORDER_NUM ";
query		+= " AND OGG.ID = ODD.GOODS_ID ";
 
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs.next()) {
	sendYn			= "N";
	rcvHp				= rs.getString("RCV_HP");
	groupCode		= rs.getString("GROUP_CODE");
	productName	= rs.getString("GROUP_NAME");
	dateDif			= rs.getString("DATEDIF");
	endDate			= rs.getString("MAX_DATE");
	shopCd			= rs.getString("SHOP_CD");
	devlCnt			= rs.getInt("DELVCNT");
	custCd			= rs.getString("CUSTOMER_NUM");
	newDate			= rs.getString("NEW_DATE");

	if (rcvHp.equals("010-9444-8585") || rcvHp.equals("010-7197-1346")) {
	} else {
		
		if (dateDif.equals("0")) {
			sendYn		= "Y";
			sendType		= "09";
		} else if ( groupCode.equals("0300717") || groupCode.equals("0301079") || groupCode.equals("0300944") || groupCode.equals("0301385") ) {
			if ( shopCd.equals("51") || shopCd.equals("52") ) {
				if (dateDif.equals("6") && devlCnt >= 15) {				
					sendYn			= "Y";
					sendType		= "01";
				} else if (dateDif.equals("3") && devlCnt >= 5) {				
					sendYn			= "Y";
					sendType		= "02";
				}				
			} else {
				if (dateDif.equals("7") && devlCnt >= 15) {
					sendYn			= "Y";
					sendType		= "01";
				} else if (dateDif.equals("4") && devlCnt >= 5) {
					sendYn			= "Y";
					sendType		= "02";
				}
			}
		} else if ( groupCode.equals("0301369") ) {
			if ( shopCd.equals("51") || shopCd.equals("52") ) {
				if (dateDif.equals("4") && devlCnt >= 15) {
					sendYn			= "Y";
					sendType		= "01";
				} else if (dateDif.equals("1") && devlCnt >= 5) {		
					sendYn			= "Y";
					sendType		= "03";
				}				
			} else {
				if (dateDif.equals("5") && devlCnt >= 15) {
					sendYn			= "Y";
					sendType		= "01";
				} else if (dateDif.equals("2") && devlCnt >= 5) {
					sendYn			= "Y";
					sendType		= "02";
				}
			}
		} else {
			if ( shopCd.equals("51") || shopCd.equals("52") ) {
				if (dateDif.equals("8") && devlCnt >= 15) {
					sendYn		= "Y";
					sendType		= "01";
				} else if (dateDif.equals("5") && devlCnt >= 5) {
					sendYn		= "Y";
					sendType		= "02";
				}
			} else {
				if (dateDif.equals("9") && devlCnt >= 15) {
					sendYn		= "Y";
					sendType		= "01";
				} else if (dateDif.equals("6") && devlCnt >= 5) {
					sendYn		= "Y";
					sendType		= "02";
				}
			}
		}
		
		if (sendYn.equals("Y")) {
			query1		= "INSERT INTO CUST_DELV_ALL.TSMS_AGENT_MESSAGE ("; 
			query1		+= " MESSAGE_SEQNO, SERVICE_SEQNO";
			query1		+= " ,SEND_MESSAGE";
			query1		+= " ,TEMPLATE_CODE";
			query1		+= " ,SUBJECT";
			query1		+= " ,BACKUP_MESSAGE";
			query1		+= " ,BACKUP_PROCESS_CODE,MESSAGE_TYPE,CONTENTS_TYPE,RECEIVE_MOBILE_NO";
			query1		+= " ,CALLBACK_NO,JOB_TYPE,SEND_RESERVE_DATE, REGISTER_DATE";
			query1		+= " ,REGISTER_BY, SEND_FLAG, KKO_BTN_NAME, KKO_BTN_URL, TAX_LEVEL1_NM ,TAX_LEVEL2_NM";
			query1		+= " ) VALUES (";
			query1		+= " CUST_DELV_ALL.TSMS_MESSAGE_SEQ.nextval ,'1710002662'";
			
			if (sendType.equals("01")) {
				query1		+= " ,'[Ǯ�����ս���] ���� �ֹ� �� ����ؼ� ��� ������ �ִ� ���� ��� ���� �ֹ����ڸ� �ȳ��帳�ϴ�.\r\r�� �ֹ���ǰ : "+ productName +"\r�� ��������� : "+ endDate +"\r�� ���ӹ�۰����ֹ��� : " + newDate + "����\r\r�� �ս����� �ż��� ���� ���ް� ������ ���� �ֹ� ���� ������� ����˴ϴ�.\r�� ���ӹ�� �����ֹ��ϱ��� �ֹ��Ͻø� �ߴ� ���� ��� ������ �� �ֽ��ϴ�.'";
				query1		+= ",'eat15'";
				query1		+= " ,'[Ǯ�����ս���] �������ȳ�'";
				query1		+= " ,'[Ǯ�����ս���] ���� �ֹ� �� ����ؼ� ��� ������ �ִ� ���� ��� ���� �ֹ����ڸ� �ȳ��帳�ϴ�.\r\r�� �ֹ���ǰ : "+ productName +"\r�� ��������� : "+ endDate +"\r�� ���ӹ�۰����ֹ��� : " + newDate + "����\r\r�� �ս����� �ż��� ���� ���ް� ������ ���� �ֹ� ���� ������� ����˴ϴ�.\r�� ���ӹ�� �����ֹ��ϱ��� �ֹ��Ͻø� �ߴ� ���� ��� ������ �� �ֽ��ϴ�.\rhttp://www.eatsslim.co.kr'";				
			} else if (sendType.equals("02")) {
				query1		+= " ,'[Ǯ�����ս���] �ս����� �����ؼ� ��� ������ �ִ� �ֹ����� ���ñ��� �Դϴ�.\r\r�� �ֹ���ǰ : "+ productName +"\r�� ��������� : "+ endDate +"\r�� ���ӹ�۰����ֹ� : " + newDate + "����\r\r�� �ս����� �ż��� ���� ���ް� ������ ���� �ֹ����� ������� ����˴ϴ�.\r�� ���ӹ���� ���Ͻø� �� ���ñ��� �ֹ��� �ּ���.'";
				query1		+= ",'eat16'";
				query1		+= " ,'[Ǯ�����ս���] �������ȳ�'";
				query1		+= " ,'[Ǯ�����ս���] �ս����� �����ؼ� ��� ������ �ִ� �ֹ����� ���ñ��� �Դϴ�.\r\r�� �ֹ���ǰ : "+ productName +"\r�� ��������� : "+ endDate +"\r�� ���ӹ�۰����ֹ� : " + newDate + "����\r\r�� �ս����� �ż��� ���� ���ް� ������ ���� �ֹ����� ������� ����˴ϴ�.\r�� ���ӹ���� ���Ͻø� �� ���ñ��� �ֹ��� �ּ���.\rhttp://www.eatsslim.co.kr'";				
			} else if (sendType.equals("03")) {
				query1		+= " ,'[Ǯ�����ս���] �ս����� �����ؼ� ��� ������ �ִ� �ֹ����� ���ñ��� �Դϴ�.\r\r�� �ֹ���ǰ : "+ productName +"\r�� ��������� : "+ endDate +"\r�� ���ӹ�۰����ֹ� : " + newDate + " 15�ñ���\r\r�� �ս����� �ż��� ���� ���ް� ������ ���� �ֹ����� ������� ����˴ϴ�.\r�� ���ӹ���� ���Ͻø� �� ���ñ��� �ֹ��� �ּ���.'";
				query1		+= ",'eat16'";
				query1		+= " ,'[Ǯ�����ս���] �������ȳ�'";
				query1		+= " ,'[Ǯ�����ս���] �ս����� �����ؼ� ��� ������ �ִ� �ֹ����� ���ñ��� �Դϴ�.\r\r�� �ֹ���ǰ : "+ productName +"\r�� ��������� : "+ endDate +"\r�� ���ӹ�۰����ֹ� : " + newDate + "����\r\r�� �ս����� �ż��� ���� ���ް� ������ ���� �ֹ����� ������� ����˴ϴ�.\r�� ���ӹ���� ���Ͻø� �� ���ñ��� �ֹ��� �ּ���.\rhttp://www.eatsslim.co.kr'";				
			} else {
				query1		+= " ,'[Ǯ�����ս���] �ս��� ����� ���÷� ����˴ϴ�.\r�׵��� �ս����� �̿��� �ּż� �����մϴ�.\r\r�� �ֹ���ǰ : "+ productName +"\r�� ��������� : "+ endDate +"\r\r�� �ս����� ������ �ǰ��� ���̾�Ʈ�� �����մϴ�!'";
				query1		+= ",'eat17'";
				query1		+= " ,'[Ǯ�����ս���] �������ȳ�'";
				query1		+= " ,'[Ǯ�����ս���] �ս��� ����� ���÷� ����˴ϴ�.\r�׵��� �ս����� �̿��� �ּż� �����մϴ�.\r\r�� �ֹ���ǰ : "+ productName +"\r�� ��������� : "+ endDate +"\r\r�� �ս����� ������ �ǰ��� ���̾�Ʈ�� �����մϴ�!\rhttp://www.eatsslim.co.kr'";
			}			

			query1		+= ",'001','002','004','"+rcvHp+"'";
			query1		+= " ,'02-6411-8322','R00',SYSDATE,SYSDATE";
			query1		+= " ,'kakao_es','N','�ս����ٷΰ���','http://www.eatsslim.co.kr','','')";
			
			//out.println(query1);		
			try {
				stmt_kakao.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}
		}

	}
}
rs.close();
if (stmt1 != null) try { stmt1.close(); } catch (Exception e) {}
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_kakao.jsp" %>