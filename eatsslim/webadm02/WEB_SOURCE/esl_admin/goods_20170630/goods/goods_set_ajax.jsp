<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ include file="../lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String savePath		= uploadDir + "goods/"; // 저장할 디렉토리 (절대경로)
String table		= "ESL_GOODS_SET";
String query		= "";
boolean error		= false;
String goodsName	= "";
int goodsPrice		= 0;
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String setCode		= ut.inject(request.getParameter("set_code"));
String instId		= (String)session.getAttribute("esl_admin_id");
String delIds		= "";
String[] arrDelId;
int delId;
int cateId			= 0;
String thumbImg		= "";
String bigImg		= "";

if (instId == null || instId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[로그인을 해주세요.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (mode.equals("getSet")) {
	try {
		query	= "SELECT GOODS_NAME, GOODS_PRICE FROM ESL_GOODS_SETTING WHERE GOODS_CODE = ? AND GOODS_TYPE = 'S'";
		pstmt	= conn.prepareStatement(query);
		pstmt.setString(1, setCode);
		rs		= pstmt.executeQuery();

		if (rs.next()) {
			goodsName	= rs.getString("GOODS_NAME");
			goodsPrice	= rs.getInt("GOODS_PRICE");

			code		= "success";
			data		= "<goodsName><![CDATA["+ goodsName +"]]></goodsName>";
			data		+= "<goodsPrice>"+ goodsPrice +"</goodsPrice>";
		} else {
			code		= "error";
			data		= "<error><![CDATA[요청하신 카테고리명이 존재하지 않습니다.]]></error>";
		}
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	} finally {
	}
} else if (mode.equals("del")) {
	delIds		= ut.inject(request.getParameter("del_ids"));

	arrDelId	= delIds.split(",");
	for (int i = 0; i < arrDelId.length; i++) {
		delId		= Integer.parseInt(arrDelId[i]);

		try {
			query		= "SELECT CATEGORY_ID, THUMB_IMG, BIG_IMG FROM "+ table +" WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, delId);
			rs			= pstmt.executeQuery();

			if (rs.next()) {
				cateId		= rs.getInt("CATEGORY_ID");
				thumbImg	= rs.getString("THUMB_IMG");
				bigImg		= rs.getString("BIG_IMG");

				if (thumbImg != null && thumbImg.length() > 0) {
					File f1		= new File(savePath+thumbImg);
					if (f1.exists()) f1.delete();
				}
				if (bigImg != null && bigImg.length() > 0) {
					File f1		= new File(savePath+bigImg);
					if (f1.exists()) f1.delete();
				}
			}

			rs.close();
			pstmt.close();

			query		= "UPDATE ESL_GOODS_CATEGORY SET ";
			query		+= "		GOODS_SET_CNT = GOODS_SET_CNT - 1";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, cateId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}
	}

	try {
		query		= "DELETE FROM "+ table +"_CONTENT WHERE SET_ID IN ("+ delIds +")";
		pstmt		= conn.prepareStatement(query);
		pstmt.executeUpdate();
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	} finally {
		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
	}

	try {
		query		= "DELETE FROM "+ table +"_CONTENT_EXTEND WHERE SET_ID IN ("+ delIds +")";
		pstmt		= conn.prepareStatement(query);
		pstmt.executeUpdate();
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	} finally {
		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
	}

	try {
		query		= "DELETE FROM "+ table +"_ORIGIN WHERE SET_ID IN ("+ delIds +")";
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