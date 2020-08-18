<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_CART";
String query		= "";
boolean error		= false;
int i				= 0;
String goodsName	= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String bagYn		= ut.inject(request.getParameter("bag_yn"));
int cartId			= 0;
String devlDate		= "";
int buyQty			= 0;
String cartIds[]	= request.getParameterValues("cart_id");
String devlDates[]	= request.getParameterValues("devl_date");
String buyQtys[]	= request.getParameterValues("buy_qty");

if (mode.equals("del")) {
	cartId		= Integer.parseInt(request.getParameter("cart_id"));

	if (bagYn.equals("B")) {
		try {
			query		= "UPDATE "+ table +" SET BUY_BAG_YN = 'N' WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, cartId);
			pstmt.executeUpdate();

			code		= "success";
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
	} else {
		try {
			query		= "DELETE FROM "+ table +" WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, cartId);
			pstmt.executeUpdate();

			code		= "success";
			
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
	}
} else if (mode.equals("cartSel")) {
	cartIds		= ut.inject(request.getParameter("cart_ids")).split(",");

	for (i = 0; i < cartIds.length; i++) {
		cartId			= Integer.parseInt(cartIds[i]);

		query		= "UPDATE "+ table +" SET ";
		query		+= "		ORDER_YN		= 'Y'";
		query		+= " WHERE ID = "+ cartId;
		try {
			stmt.executeUpdate(query);			
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
	}

	if (i == cartIds.length) {
		code		= "success";
	} else {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose.jsp"%>