<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_GOODS_CATEGORY";
String query		= "";
boolean error		= false;
String goodsName	= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String cateName		= ut.inject(request.getParameter("cate_name"));
String cateCode		= ut.inject(request.getParameter("cate_code"));
String openYn		= ut.inject(request.getParameter("open_yn"));
String scheduleYn	= ut.inject(request.getParameter("schedule_yn"));
String instId		= (String)session.getAttribute("esl_admin_id");
String userIp		= request.getRemoteAddr();

if (instId == null || instId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[로그인을 해주세요.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (mode.equals("getCate")) {
	try {
		query	= "SELECT GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_CODE = ? AND GOODS_TYPE = 'C'";
		pstmt	= conn.prepareStatement(query);
		pstmt.setString(1, cateCode);
		rs		= pstmt.executeQuery();

		if (rs.next()) {
			goodsName	= rs.getString("GOODS_NAME");

			code		= "success";
			data		= "<goodsName><![CDATA["+ goodsName +"]]></goodsName>";
		} else {
			code		= "error";
			data		= "<error><![CDATA[요청하신 카테고리명이 존재하지 않습니다.]]></error>";
		}
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	} finally {
	}
} else if (mode.equals("ins")) {
	if (cateCode == null || cateCode.equals("")) {
		error		= true;
		data		= "<error><![CDATA[cate_code:카테고리코드를 선택하세요.]]></error>";
	} else if (cateName == null || cateName.equals("")) {
		error		= true;
		data		= "<error><![CDATA[cate_code:카테고리코드를 선택하세요.]]></error>";
	}

	if (error) {
		code		= "error";
	} else {
		try {
			query	= "INSERT INTO "+ table;
			query	+= "	(CATE_NAME, CATE_CODE, OPEN_YN, SCHEDULE_YN, INST_ID, INST_IP, INST_DATE)";
			query	+= " VALUES";
			query	+= "	(?, ?, ?, ?, ?, ?, NOW())";
			pstmt					= conn.prepareStatement(query);
			pstmt.setString(1, cateName);
			pstmt.setString(2, cateCode);
			pstmt.setString(3, openYn);
			pstmt.setString(4, scheduleYn);
			pstmt.setString(5, instId);
			pstmt.setString(6, userIp);
			pstmt.executeUpdate();

			code		= "success";
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[no_txt:장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		} finally {
		}
	}
} else if (mode.equals("upd")) {
	int cateId			= Integer.parseInt(request.getParameter("cate_id"));

	try {
		query		= "UPDATE "+ table +" SET ";
		query		+= "		OPEN_YN			= ?,";
		query		+= "		SCHEDULE_YN		= ?,";
		query		+= "		UPDT_ID			= ?,";
		query		+= "		UPDT_IP			= ?,";
		query		+= "		UPDT_DATE		= NOW()";
		query		+= "	WHERE ID = ?";
		pstmt		= conn.prepareStatement(query);
		pstmt.setString(1, openYn);
		pstmt.setString(2, scheduleYn);
		pstmt.setString(3, instId);
		pstmt.setString(4, userIp);
		pstmt.setInt(5, cateId);
		pstmt.executeUpdate();

		code		= "success";
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	} finally {
	}
} else if (mode.equals("del")) {
	int cateId			= Integer.parseInt(request.getParameter("cate_id"));

	try {
		query		= "DELETE FROM "+ table +" WHERE ID = ?";
		pstmt		= conn.prepareStatement(query);
		pstmt.setInt(1, cateId);
		pstmt.executeUpdate();

		code		= "success";
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	} finally {
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>