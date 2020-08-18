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
int groupId			= 0;
if (request.getParameter("group_id") != null && request.getParameter("group_id").length()>0){
	groupId		= Integer.parseInt(request.getParameter("group_id"));
}
int tcnt			= 0;
int buyQty			= 0;
if (request.getParameter("buy_qty") != null && request.getParameter("buy_qty").length()>0){
	buyQty		= Integer.parseInt(request.getParameter("buy_qty"));
}
int price			= 0;
if (request.getParameter("price") != null && request.getParameter("price").length()>0){
	price		= Integer.parseInt(request.getParameter("price"));
}
int salePrice		= 0;
if (request.getParameter("sale_price") != null && request.getParameter("sale_price").length()>0) {
	salePrice	= Integer.parseInt(request.getParameter("sale_price"));
}
String saleType		= ut.inject(request.getParameter("sale_type"));
int buyQty1			= 0;
if (request.getParameter("buy_qty1") != null && request.getParameter("buy_qty1").length()>0) {
	buyQty1		= Integer.parseInt(request.getParameter("buy_qty1"));
}
int buyQty2			= 0;
if (request.getParameter("buy_qty2") != null && request.getParameter("buy_qty2").length()>0) {
	buyQty2		= Integer.parseInt(request.getParameter("buy_qty2"));
}

if (eslMemberId == null || eslMemberId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[로그인을 해주세요.]]></error>";
} else if (mode.equals("addCart")) {
	if (groupId < 1) {
		code		= "error";
		data		= "<error><![CDATA[제품을 선택해주세요.]]></error>";
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

/*			if (salePrice > 0 && !saleType.equals("")) {
				price		= (int)Math.round((double)price * (double)(100 - salePrice) / 100);
			} else {		
				price		=  price;
			}
*/			
			if (salePrice > 0) {
				if ( saleType.equals("P")) {
					price = (int)Math.round((double)price * (double)(100 - salePrice) / 100)  ;
				} else {
					price = (int)Math.round((double)(price - salePrice));
				}
			} else {		
				price		=  price;
			}
			
			if (tcnt > 0) {
				query		= "UPDATE ESL_CART SET ";
				query		+= "	BUY_QTY		= ?";
				query		+= "	,PRICE		= ?";
				query		+= " WHERE MEMBER_ID = ? AND GROUP_ID = ? AND CART_TYPE = ?";
				pstmt		= conn.prepareStatement(query);
				pstmt.setInt(1, buyQty);
				pstmt.setInt(2, price);
				pstmt.setString(3, eslMemberId);
				pstmt.setInt(4, groupId);
				pstmt.setString(5, cartType);
			} else {
				query		= "INSERT INTO ESL_CART ";
				query		+= "	(MEMBER_ID, GROUP_ID, BUY_QTY, DEVL_TYPE, DEVL_DAY, DEVL_WEEK, DEVL_DATE, PRICE, INST_DATE, BUY_BAG_YN, CART_TYPE)";
				query		+= " VALUES";
				query		+= "	(?, ?, ?, '0002', '0', '0', DATE_FORMAT(NOW(), '%Y-%m-%d'), ?, NOW(), 'N', ?)";
				pstmt		= conn.prepareStatement(query);
				pstmt.setString(1, eslMemberId);
				pstmt.setInt(2, groupId);
				pstmt.setInt(3, buyQty);
				pstmt.setInt(4, price);
				pstmt.setString(5, cartType);
			}
			pstmt.executeUpdate();

			query		= "SELECT ID FROM ESL_CART WHERE MEMBER_ID = ? AND GROUP_ID = ? AND CART_TYPE = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, eslMemberId);
			pstmt.setInt(2, groupId);
			pstmt.setString(3, cartType);
			rs			= pstmt.executeQuery();
			
			int cartId		= 0;
			if (rs.next()) {
				cartId		 = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

			query		= "DELETE FROM ESL_CART_DELIVERY WHERE CART_ID = "+ cartId;
			stmt.executeUpdate(query);

			if (cartId > 0) {
				if (buyQty1 > 0) {
					query		= "INSERT INTO ESL_CART_DELIVERY ";
					query		+= "	(CART_ID, GROUP_CODE, BUY_CNT, GROUP_ID)";
					query		+= " VALUES";
					query		+= "	(?, '0301000', ?, ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, cartId);
					pstmt.setInt(2, buyQty1);
					pstmt.setInt(3, groupId);
					pstmt.executeUpdate();
				}
				if (buyQty2 > 0) {
					query		= "INSERT INTO ESL_CART_DELIVERY ";
					query		+= "	(CART_ID, GROUP_CODE, BUY_CNT, GROUP_ID)";
					query		+= " VALUES";
					query		+= "	(?, '0301001', ?, ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, cartId);
					pstmt.setInt(2, buyQty2);
					pstmt.setInt(3, groupId);
					pstmt.executeUpdate();
				}
			}

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
<%@ include file="../lib/dbclose.jsp"%>