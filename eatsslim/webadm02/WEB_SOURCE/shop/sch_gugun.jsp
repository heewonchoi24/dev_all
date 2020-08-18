<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String sido			= ut.inject(request.getParameter("sido"));
if (sido != null && sido.length() > 0) {
	sido		= new String(sido.getBytes("8859_1"), "EUC-KR");
}
String gugun		= "";

if (mode.equals("sch")) {
	if (sido.equals("") || sido == null) {
		code		= "error";
		data		= "<error><![CDATA[�õ��� �����ϼ���.]]></error>";
	} else {
		query		= "SELECT DISTINCT PARTNERID, GUGUN FROM PHIBABY.V_ZIPCODE_OLD";
		query		+= " WHERE SIDO LIKE '%"+ sido +"%'";
		query		+= " ORDER BY GUGUN";
		try {
			rs_phi	= stmt_phi.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		int cnt		= 0;
		data		= "<option value=\"\">����</option>";
		while (rs_phi.next()) {
			gugun		= rs_phi.getString("GUGUN");

			data		+= "<option value=\""+ gugun +"\">"+ gugun +"</option>";

			cnt++;
		}

		if (cnt > 0) {
			out.println("<script type='text/javascript'>$('#gugun', parent.document).html('"+ data +"');</script>");
		} else {
			out.println("<script type='text/javascript'>alert('�˻��� ������ �����ϴ�.');</script>");
			out.println("<script type='text/javascript'>$('#gugun', parent.document).html('"+ data +"');</script>");
		}
	}
}
%>
<%@ include file="/lib/dbclose_phi.jsp"%>