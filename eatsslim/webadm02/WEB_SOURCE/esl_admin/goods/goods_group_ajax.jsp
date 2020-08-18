<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ include file="../lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String savePath		= uploadDir + "goods/"; // 저장할 디렉토리 (절대경로)
String table		= "ESL_GOODS_GROUP";
String query		= "";
boolean error		= false;
String goodsCode	= "";
String goodsName	= "";
int goodsPrice		= 0;
String code			= "";
String data			= "";
int tcnt			= 0;
String mode			= ut.inject(request.getParameter("mode"));
String gubun1		= ut.inject(request.getParameter("gubun1"));
String gubun2		= ut.inject(request.getParameter("gubun2"));
String groupCode	= ut.inject(request.getParameter("group_code"));
String instId		= (String)session.getAttribute("esl_admin_id");
String delIds		= "";
String[] arrDelId;
int delId;
String cartImg		= "";

if (instId == null || instId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[로그인을 해주세요.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (mode.equals("getCode")) {
	try {
		query	= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_TYPE = 'G' AND GUBUN1 = ? AND GUBUN2 = ? AND GOODS_CODE NOT IN (SELECT GROUP_CODE FROM ESL_GOODS_GROUP)";
		pstmt	= conn.prepareStatement(query);
		pstmt.setString(1, gubun1);
		pstmt.setString(2, gubun2);
		rs		= pstmt.executeQuery();

		while (rs.next()) {
			goodsName	= rs.getString("GOODS_NAME");
			goodsCode	= rs.getString("GOODS_CODE");

			data		+= "<group><![CDATA["+ goodsCode +"]]>|<![CDATA["+ goodsName +"]]></group>";
			tcnt++;
		}
		
		if (tcnt > 0) {
			code		= "success";			
		} else {
			code		= "error";
			data		= "<error><![CDATA[요청하신 세트그룹코드가 존재하지 않습니다.]]></error>";
		}
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	}
} else if (mode.equals("getGroup")) {
	try {
		query	= "SELECT GOODS_NAME, GOODS_PRICE FROM ESL_GOODS_SETTING WHERE GOODS_CODE = ? AND GOODS_TYPE = 'G'";
		pstmt	= conn.prepareStatement(query);
		pstmt.setString(1, groupCode);
		rs		= pstmt.executeQuery();

		if (rs.next()) {
			goodsName	= rs.getString("GOODS_NAME");
			goodsPrice	= rs.getInt("GOODS_PRICE");

			code		= "success";
			data		= "<goodsName><![CDATA["+ goodsName +"]]></goodsName>";
			data		+= "<goodsPrice>"+ goodsPrice +"</goodsPrice>";
			//data		+= "<goodsPrice>10000</goodsPrice>";
		} else {
			code		= "error";
			data		= "<error><![CDATA[요청하신 카테고리명이 존재하지 않습니다.]]></error>";
		}
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	}
} else if (mode.equals("del")) {
	delIds		= ut.inject(request.getParameter("del_ids"));

	arrDelId	= delIds.split(",");
	for (int i = 0; i < arrDelId.length; i++) {
		delId		= Integer.parseInt(arrDelId[i]);

		try {
			query		= "SELECT CART_IMG FROM "+ table +" WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, delId);
			rs			= pstmt.executeQuery();

			if (rs.next()) {
				cartImg		= rs.getString("CART_IMG");

				if (cartImg != null && cartImg.length() > 0) {
					File f1		= new File(savePath+cartImg);
					if (f1.exists()) f1.delete();
				}
			}

			rs.close();
			pstmt.close();
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}
	}

	try {
		query		= "DELETE FROM "+ table +"_EXTEND WHERE SET_ID IN ("+ delIds +")";
		pstmt		= conn.prepareStatement(query);
		pstmt.executeUpdate();
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	} finally {
		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
	}

	try {
		query		= "DELETE FROM "+ table +" WHERE ID IN ("+ delIds +")";
		pstmt		= conn.prepareStatement(query);
		pstmt.executeUpdate();	
		
		code		= "success";
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>