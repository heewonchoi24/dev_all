<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////   ���̿���


String query1		= "";
String query2		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
Statement stmt2		= null;
ResultSet rs2		= null;
stmt2				= conn.createStatement();
Statement stmt2_phi	= null;
ResultSet rs2_phi	= null;
stmt2_phi			= conn_phi.createStatement();
String orderNum		= LGD_OID;
String orderName	= "";
String email		= "";
// �Ϲ� ��� ����
String rcvName		= "";
String rcvHp		= "";
String rcvTel		= "";
String rcvZipcode	= "";
String rcvAddr1		= "";
String rcvAddr2		= "";
String rcvBuildingNo	= "";
String rcvType		= "";
String rcvPassYn	= "";
String rcvPass		= "";
String rcvRequest	= "";
// �ù� ��� ����
String tagName		= "";
String tagHp		= "";
String tagTel		= "";
String tagZipcode	= "";
String tagAddr1		= "";
String tagAddr2		= "";
String tagRequest	= "";
String payType		= "";
int payPrice		= 0; //�����ݾ�
int goodsPrice		= 0; //���ֹ��ݾ�
int devlPrice		= 0; //��ۺ�
int couponTprice	= 0; //��ǰ���� ���� �ѱݾ�
int couponPrice		= 0;
String orderDate	= ""; //�ֹ���
String ssType		= "";
if( orderNum.equals("")) {
	out.println("�ֹ���ȣ ����");
	if(true)return;
}

//================PHI ����
int i				= 1;
int k				= 0;
int maxK			= 0;
int ordSeq			= 0;
String rcvPartner	= "";
String tagPartner	= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
Date date			= null;
String groupCode	= "";
int orderCnt		= 0;
String devlType		= "";
String devlDay		= "";
String devlHoliday	= "";
String devlWeek		= "";
String devlDate		= "";
String devlDatePhi	= "";
int price			= 0;
String buyBagYn		= "";
String customerNum	= "";
String gubun1		= "";
String gubun2		= "";
String gubun3		= "";
String gubunCode	= "";
String shopType		= "";
int week			= 1;
int chkCnt			= 0;
int phiCnt			= 0;
int goodsId			= 0;

%>
<%@ include file="/lib/phi_insert_query.jsp"%>