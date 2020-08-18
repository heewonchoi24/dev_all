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
int purchaseCnt		= 0;
String delIds		= "";

if (mode.equals("del")) {
	int groupId		= Integer.parseInt(request.getParameter("group_id"));

	if (bagYn.equals("B")) {
		query		= "SELECT COUNT(*) PURCHASE_CNT FROM ESL_ORDER O, ESL_ORDER_GOODS OG WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.MEMBER_ID = '"+ eslMemberId +"' AND ((O.ORDER_STATE > 0 AND O.ORDER_STATE < 90) OR O.ORDER_STATE = '911') AND OG.DEVL_TYPE = '0001'";
		try {
			rs	= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs.next()) {
			purchaseCnt		= rs.getInt("PURCHASE_CNT");
		}

		if (purchaseCnt < 1) {
			code		= "error";
			data		= "<error><![CDATA[신규 구매 시 보냉가방은 필수로 구매하셔야 합니다.]]></error>";
		} else {
			try {
				query		= "UPDATE "+ table +" SET BUY_BAG_YN = 'N' WHERE GROUP_ID = ?";
				pstmt		= conn.prepareStatement(query);
				pstmt.setInt(1, groupId);
				pstmt.executeUpdate();

				code		= "success";
			} catch (Exception e) {
				code		= "error";
				data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
			}
		}
	} else {
		try {
			query		= "DELETE FROM "+ table +" WHERE GROUP_ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, groupId);
			pstmt.executeUpdate();

			code		= "success";
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
	}
} else if (mode.equals("cartAll")) {
	for (i = 0; i < cartIds.length; i++) {
		cartId			= Integer.parseInt(cartIds[i]);
		devlDate		= devlDates[i];
		buyQty			= Integer.parseInt(buyQtys[i]);

		query		= "UPDATE "+ table +" SET ";
		if (devlDate != null || !devlDate.equals("")) {
			query		+= "		DEVL_DATE		= '"+ devlDate +"'";
		}
		query		+= "		, BUY_QTY		= "+ buyQty;
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
} else if (mode.equals("cartSel")) {
	cartIds		= ut.inject(request.getParameter("cart_ids")).split(",");
	devlDates	= ut.inject(request.getParameter("devl_dates")).split(",");
	buyQtys		= ut.inject(request.getParameter("buy_qtys")).split(",");

	for (i = 0; i < cartIds.length; i++) {
		cartId			= Integer.parseInt(cartIds[i]);
		devlDate		= devlDates[i];
		buyQty			= Integer.parseInt(buyQtys[i]);

		query		= "UPDATE "+ table +" SET ";
		query		+= "		DEVL_DATE		= '"+ devlDate +"'";
		query		+= "		, BUY_QTY		= "+ buyQty;
		query		+= "		, ORDER_YN		= 'Y'";
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
} else if (mode.equals("cartAllDel")) {
	query		= "DELETE FROM "+ table +" WHERE MEMBER_ID = '"+ eslMemberId +"'";
		
	try {
		stmt.executeUpdate(query);
		code		= "success";
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	}
} else if (mode.equals("cartSelDel")) {
	delIds		= ut.inject(request.getParameter("del_ids"));

	query		= "DELETE FROM "+ table +" WHERE ID IN ("+ delIds +")";
		
	try {
		stmt.executeUpdate(query);
		code		= "success";
	} catch (Exception e) {
		out.println(e+"=>"+query);
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