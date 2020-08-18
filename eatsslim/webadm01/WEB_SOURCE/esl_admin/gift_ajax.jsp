<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_ORDER_DEVL_DATE";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
boolean error		= false;
String code			= "";
String data			= "";
int ordSeq			= 0;
int i				= 0;
String where		= "";
String orderNum		= ut.inject(request.getParameter("order_num"));
String subNum		= ut.inject(request.getParameter("sub_num"));
String stdate		= ut.inject(request.getParameter("stdate"));
String groupCode	= "";

query		= "SELECT * FROM ESL_ORDER_DEVL_DATE";
query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
if (!subNum.equals("") && subNum.length() > 0) {
	query		+= " AND GOODS_ID = "+ subNum;
}
query		+= " AND GUBUN_CODE != '0300668'";
query		+= " ORDER BY ID DESC LIMIT 1";
try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>1"+query);
	if(true)return;
}

if (rs.next()) {
	groupCode		= "0300719";

	query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
	query1		+= "	ORDER_DATE			= '"+ rs.getString("ORDER_DATE") +"',";
	query1		+= "	ORDER_NUM			= '"+ rs.getString("ORDER_NUM") +"',";
	query1		+= "	CUSTOMER_NUM		= '"+ rs.getString("CUSTOMER_NUM") +"',";
	query1		+= "	ORDER_NAME			= '"+ rs.getString("ORDER_NAME") +"',";
	query1		+= "	RCV_NAME			= '"+ rs.getString("RCV_NAME") +"',";
	query1		+= "	RCV_ZIPCODE			= '"+ rs.getString("RCV_ZIPCODE") +"',";
	query1		+= "	RCV_ADDR1			= '"+ rs.getString("RCV_ADDR1") +"',";
	query1		+= "	RCV_ADDR2			= '"+ rs.getString("RCV_ADDR2") +"',";
	query1		+= "	RCV_TEL				= '"+ rs.getString("RCV_TEL") +"',";
	query1		+= "	RCV_HP				= '"+ rs.getString("RCV_HP") +"',";
	query1		+= "	RCV_EMAIL			= '"+ rs.getString("RCV_EMAIL") +"',";
	query1		+= "	TOT_SELL_PRICE		= '"+ rs.getInt("TOT_SELL_PRICE") +"',";
	query1		+= "	TOT_PAY_PRICE		= '"+ rs.getInt("TOT_PAY_PRICE") +"',";
	query1		+= "	TOT_DEVL_PRICE		= '"+ rs.getInt("TOT_DEVL_PRICE") +"',";
	query1		+= "	TOT_DC_PRICE		= '"+ rs.getInt("TOT_DC_PRICE") +"',";
	query1		+= "	PAY_TYPE			= '"+ rs.getString("PAY_TYPE") +"',";
	query1		+= "	DEVL_TYPE			= '"+ rs.getString("DEVL_TYPE") +"',";
	query1		+= "	AGENCYID			= '"+ rs.getString("AGENCYID") +"',";
	query1		+= "	RCV_REQUEST			= '"+ rs.getString("RCV_REQUEST") +"',";
	query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
	query1		+= "	DEVL_DATE			= '"+ stdate +"',";
	query1		+= "	ORDER_CNT			= 1,";
	query1		+= "	PRICE				= 0,";
	query1		+= "	PAY_PRICE			= 0,";
	query1		+= "	STATE				= '02',";
	query1		+= "	GOODS_ID			= '"+ rs.getInt("GOODS_ID") +"',";
	query1		+= "	SHOP_CD				= '"+ rs.getString("SHOP_CD") +"',";
	query1		+= "	GUBUN_CODE			= '0111',";
	query1		+= "	SHOP_ORDER_NUM		= '"+ rs.getString("SHOP_ORDER_NUM") +"'";
	try {
		stmt1.executeUpdate(query1);
	} catch (Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}
%>
<%@ include file="order/order_phi_copy.jsp" %>
<%
	code		= "success";
} else {
	code		= "error";
	data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose.jsp"%>
<%@ include file="/lib/dbclose_phi.jsp"%>