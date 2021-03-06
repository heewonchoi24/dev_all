<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String query		= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String cartType		= ut.inject(request.getParameter("cart_type"));
String gubun2		= ut.inject(request.getParameter("gubun2"));
String gubun3		= ut.inject(request.getParameter("gubun3"));
int groupId			= 0;
if (request.getParameter("group_id") != null && request.getParameter("group_id").length()>0) {
	groupId		= Integer.parseInt(request.getParameter("group_id"));
}
int tcnt			= 0;
String ssType		= ut.inject(request.getParameter("ss_type"));
String devlDay		= (ssType.equals("0"))? ut.inject(request.getParameter("devl_day")) : "3";
String devlWeek		= ut.inject(request.getParameter("devl_week"));
devlWeek			= (ssType.equals("0"))? devlWeek : Integer.toString(Integer.parseInt(devlWeek) * 2);
String devlDate		= ut.inject(request.getParameter("devl_date"));
int buyQty			= 0;
if (request.getParameter("buy_qty") != null && request.getParameter("buy_qty").length()>0) {
	buyQty		= Integer.parseInt(request.getParameter("buy_qty"));
}
int price			= 0;
if (request.getParameter("price") != null && request.getParameter("price").length()>0) {
	price		= Integer.parseInt(request.getParameter("price"));
}
String buyBagYn		= (request.getParameter("buy_bag") != null && request.getParameter("buy_bag").length()>0)? ut.inject(request.getParameter("buy_bag")) : "N";
int totalPrice		= 0;
int realPrice		= 0;
String groupInfo	= "";
String offerNotice	= "";
String groupName	= "";
int purchaseCnt		= 0;

if (mode.equals("addCart")) {
	query		= "SELECT COUNT(*) PURCHASE_CNT FROM ESL_ORDER O, ESL_ORDER_GOODS OG WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.MEMBER_ID = '"+ eslMemberId +"' AND ((O.ORDER_STATE > 0 AND O.ORDER_STATE < 90) OR O.ORDER_STATE = '911') AND OG.DEVL_TYPE = '0001'";
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		purchaseCnt		 = rs.getInt("PURCHASE_CNT");
	}

	rs.close();

	if (devlDate.equals("") || devlDate == null) {
		code		= "error";
		data		= "<error><![CDATA[첫 배송일을 지정해주세요.]]></error>";
	} else if (!buyBagYn.equals("Y") && purchaseCnt < 1) {
		code		= "error";
		data		= "<error><![CDATA[신규 구매 시 보냉가방은 필수로 구매하셔야 합니다.]]></error>";
	} else {		
		query		= "DELETE FROM ESL_CART WHERE MEMBER_ID = '"+ eslMemberId +"' AND CART_TYPE = 'L'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		try {
			query		= "SELECT COUNT(ID) FROM ESL_CART WHERE MEMBER_ID = ? AND GROUP_ID = ? AND CART_TYPE = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, eslMemberId);
			pstmt.setInt(2, groupId);
			pstmt.setString(3, cartType);
			rs			= pstmt.executeQuery();

			if (rs.next()) {
				tcnt		 = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

			price		=  price * (Integer.parseInt(devlDay) * Integer.parseInt(devlWeek));
			
			if (buyQty > 0) {
				price		= (int)Math.round((double)price * (double)(100 - 10) / 100);
			} else {		
				price		=  price;
			}

			if (tcnt > 0) {
				query		= "UPDATE ESL_CART SET ";
				query		+= "	DEVL_DAY	= ?,";
				query		+= "	DEVL_WEEK	= ?,";
				query		+= "	DEVL_DATE	= ?,";
				query		+= "	BUY_QTY		= ?,";
				query		+= "	PRICE		= ?,";
				query		+= "	BUY_BAG_YN	= ?,";
				query		+= "	SS_TYPE		= ?";
				query		+= " WHERE MEMBER_ID = ? AND GROUP_ID = ? AND CART_TYPE = ?";
				pstmt		= conn.prepareStatement(query);
				pstmt.setString(1, devlDay);
				pstmt.setString(2, devlWeek);
				pstmt.setString(3, devlDate);
				pstmt.setInt(4, buyQty);
				pstmt.setInt(5, price);
				pstmt.setString(6, buyBagYn);
				pstmt.setString(7, ssType);
				pstmt.setString(8, eslMemberId);
				pstmt.setInt(9, groupId);
				pstmt.setString(10, cartType);
			} else {
				query		= "INSERT INTO ESL_CART ";
				query		+= "	(MEMBER_ID, GROUP_ID, BUY_QTY, DEVL_TYPE, DEVL_DAY, DEVL_WEEK, DEVL_DATE, PRICE, INST_DATE, BUY_BAG_YN, CART_TYPE, SS_TYPE)";
				query		+= " VALUES";
				query		+= "	(?, ?, ?, '0001', ?, ?, ?, ?, NOW(), ?, ?, ?)";
				pstmt		= conn.prepareStatement(query);
				pstmt.setString(1, eslMemberId);
				pstmt.setInt(2, groupId);
				pstmt.setInt(3, buyQty);
				pstmt.setString(4, devlDay);
				pstmt.setString(5, devlWeek);
				pstmt.setString(6, devlDate);
				pstmt.setInt(7, price);
				pstmt.setString(8, buyBagYn);
				pstmt.setString(9, cartType);
				pstmt.setString(10, ssType);
			}
			pstmt.executeUpdate();

			code		= "success";
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose.jsp"%>