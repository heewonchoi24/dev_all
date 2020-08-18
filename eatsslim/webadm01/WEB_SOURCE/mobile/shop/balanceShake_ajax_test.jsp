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

			if (buyQty > 1) {
				price		= (int)Math.round((double)price * (double)(100 - 10) / 100);
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