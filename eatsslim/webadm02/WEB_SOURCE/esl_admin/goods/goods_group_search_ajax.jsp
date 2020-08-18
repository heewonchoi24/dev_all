<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ include file="../lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String query		= "";
boolean error		= false;
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String text			= ut.inject(request.getParameter("text"));
String instId		= (String)session.getAttribute("esl_admin_id");
String groupImg		= "";
String groupName	= "";
int tcnt			= 0;
String groupCode    = "";

if (instId == null || instId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[�α����� ���ּ���.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[���������� ������ ���ֽʽÿ�.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[���������� ������ ���ֽʽÿ�.]]></error>";
} else if (mode.equals("search")) {
	try {
        query    = " SELECT GROUP_IMGM, GROUP_NAME, GROUP_CODE FROM ESL_GOODS_GROUP WHERE USE_YN = 'Y' AND GROUP_CODE NOT IN ('0300993') AND LIST_VIEW_YN = 'Y' AND SOLD_OUT = 'N' ";
        query   += " AND GROUP_NAME LIKE '%"+text+"%' ORDER BY GROUP_NAME ";
		pstmt	 = conn.prepareStatement(query);
		rs		 = pstmt.executeQuery();
		//System.out.println(query);
		while (rs.next()) {
			groupImg	 = rs.getString("GROUP_IMGM");
			groupName	 = rs.getString("GROUP_NAME");
			groupCode	 = rs.getString("GROUP_CODE");
			data		 += "<group>"+groupName+"|"+groupImg+"|"+groupCode+"</group>";
			//System.out.println(groupName);
			tcnt++;
		}
		if (tcnt > 0) {
			code		= "success";			
		} else {
			code		= "error";
			data		= "<error><![CDATA[��û�Ͻ� ��Ʈ�׷��ڵ尡 �������� �ʽ��ϴ�.]]></error>";
		}
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[��ְ� �߻��Ͽ����ϴ�.\n��� �� �ٽ� �̿��� �ֽʽÿ�.]]></error>";
	}
}
rs.close();
//System.out.println(code);
out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>