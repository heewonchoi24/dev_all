<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////   파이연동


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
// 일배 배송 정보
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
// 택배 배송 정보
String tagName		= "";
String tagHp		= "";
String tagTel		= "";
String tagZipcode	= "";
String tagAddr1		= "";
String tagAddr2		= "";
String tagRequest	= "";
String payType		= "";
int payPrice		= 0; //결제금액
int goodsPrice		= 0; //총주문금액
int devlPrice		= 0; //배송비
int couponTprice	= 0; //상품할인 쿠폰 총금액
int couponPrice		= 0;
String orderDate	= ""; //주문일
String ssType		= "";
if( orderNum.equals("")) {
	out.println("주문번호 누락");
	if(true)return;
}

//================PHI 연동
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