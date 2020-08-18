<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_COUPON_RANDNUM";
String query		= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String couponNum	= ut.inject(request.getParameter("couponNum"));
int couponCnt		= 0;
int couponId		= 0;
String useYn		= "";

if (mode.equals("setCoupon")) {
	query		= "SELECT COUNT(*) COUPON_CNT FROM "+ table +" WHERE RAND_NUM = '"+ couponNum +"'";
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		couponCnt		= rs.getInt("COUPON_CNT");
	}

	rs.close();

	if (couponCnt < 1) {
		code		= "error";
		data		= "<error><![CDATA[올바른 쿠폰번호를 입력하세요.]]></error>";
	} else {
		query		= "SELECT COUPON_ID, USE_YN FROM "+ table +" WHERE RAND_NUM = '"+ couponNum +"'";
		try {
			rs	= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs.next()) {
			couponId	= rs.getInt("COUPON_ID");
			useYn		= rs.getString("USE_YN");
		}

		rs.close();

		if (useYn.equals("Y")) {
			code		= "error";
			data		= "<error><![CDATA[이미 사용된 쿠폰번호입니다.]]></error>";
		} else if (useYn.equals("C")) {
			code		= "error";
			data		= "<error><![CDATA[사용중지된 쿠폰번호입니다.]]></error>";
		} else {
			query		= "UPDATE "+ table +" SET USE_YN = 'Y' WHERE RAND_NUM = '"+ couponNum +"' AND RAND_NUM_TYPE = 'S'";
			try {
				stmt.executeUpdate(query);

				query		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
				query		+= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND COUPON_ID = "+ couponId +" AND COUPON_NUM = '"+ couponNum +"'";
				try {
					rs		= stmt.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs.next()) {
					couponCnt	= rs.getInt(1);
				}
				rs.close();

				if (couponCnt > 0) {
					code		= "error";
					data		= "<error><![CDATA[이미 등록하신 쿠폰입니다.]]></error>";
				} else {
					query		= "INSERT INTO ESL_COUPON_MEMBER ";
					query		+= "	(COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
					query		+= " VALUES ";
					query		+= "	("+ couponId +", '"+ couponNum +"', '"+ eslMemberId +"', 'N', NOW())";
					try {
						stmt.executeUpdate(query);
						code		= "success";
					} catch(Exception e) {
						//out.println(e+"=>"+query);
						code		= "error";
						data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
					}
				}
			} catch(Exception e) {
				//out.println(e+"=>"+query);
				code		= "error";
				data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
			}			
		}
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>