<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_GOODS_CATEGORY";
String query		= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String schDong		= ut.inject(request.getParameter("dong"));
String ztype		= ut.inject(request.getParameter("ztype"));
String zipcode		= "";
String sido			= "";
String gugun		= "";
String dong			= "";
String bunji		= "";
String address		= "";
int cnt				= 0;

if (mode.equals("post")) {
	if (schDong == null || schDong.equals("")) {
		code		= "error";
		data		= "<error><![CDATA[검색어를 입력하세요.]]></error>";
	} else {
		try {
			query		= "SELECT ZIPCODE, SIDO, GUGUN, DONG, BUNJI FROM PHIBABY.V_ZIPCODE_OLD WHERE DONG LIKE '%"+ schDong +"%'";
			if (ztype.equals("") || ztype == null) {
				query		+= " AND DLVPTNCD = '01' AND DLVYN = 'Y'";
				query		+= " AND DLVTYPE = '0001'";
			}
			pstmt_phi	= conn_phi.prepareStatement(query);
			rs_phi		= pstmt_phi.executeQuery();

			while (rs_phi.next()) {
				zipcode		= rs_phi.getString("ZIPCODE");
				sido		= rs_phi.getString("SIDO");
				gugun		= rs_phi.getString("GUGUN");
				dong		= rs_phi.getString("DONG");
				bunji		= (rs_phi.getString("BUNJI") != null)? rs_phi.getString("BUNJI") : "";
				address		= sido +" "+ gugun +" "+ dong +" "+ bunji;

				data		+= "<address><![CDATA["+ zipcode +"]]>|<![CDATA["+ address +"]]></address>";

				cnt++;
			}			
			
			if (cnt > 0) {				
				code		= "success";
			} else {
				code		= "success";
				data		= "<address><![CDATA[nodata|검색된 배송가능지역이 없습니다.]]></address>";
			}
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
<%@ include file="../lib/dbclose_phi.jsp"%>