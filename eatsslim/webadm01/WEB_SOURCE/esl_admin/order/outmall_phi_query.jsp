<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
query1		+= "	ORDER_NAME			= '"+ orderName +"',";
query1		+= "	RCV_NAME			= '"+ tagName +"',";
query1		+= "	RCV_ZIPCODE			= '"+ tagZipcode +"',";
query1		+= "	RCV_ADDR1			= '"+ tagAddr1 +"',";
query1		+= "	RCV_ADDR2			= '"+ tagAddr2 +"',";
query1		+= "	RCV_TEL				= '"+ tagTel +"',";
query1		+= "	RCV_HP				= '"+ tagHp +"',";
query1		+= "	RCV_EMAIL			= '"+ email +"',";
query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
query1		+= "	PAY_TYPE			= '"+ payType +"',";
query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
query1		+= "	AGENCYID			= '"+ tagPartner +"',";
query1		+= "	RCV_REQUEST			= '"+ tagRequest +"',";
query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
query1		+= "	DEVL_DATE			= '"+ devlDate +"',";
query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
query1		+= "	PRICE				= '"+ price +"',";
query1		+= "	PAY_PRICE			= '"+ price +"',";
query1		+= "	STATE				= '01',";
query1		+= "	GOODS_ID			= '"+ goodsId +"',";
query1		+= "	SHOP_CD				= '"+ shopType +"',";
query1		+= "	GUBUN_CODE			= '"+ gubunCode +"',";
query1		+= "	SHOP_ORDER_NUM		= '"+ outOrderNum +"'";
try {
	stmt1.executeUpdate(query1);
} catch (Exception e) {
	out.println(e+"=>"+query1);
	if(true)return;
}
%>