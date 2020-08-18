<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String gubun1		= ut.inject(request.getParameter("gubun1"));
String gubun2		= ut.inject(request.getParameter("gubun2"));

if (mode.equals("period")) {
	if (gubun1.equals("01")) {
		data		+= "<select name='devl_day' id='devl_day' onchange='cngDay()'>\n";
		data		+= "<option value='5' selected='selected'>5일</option>\n";
		data		+= "<option value='6'>6일</option>\n";
		data		+= "</select>\n";
		data		+= "<select name='devl_week' id='devl_week' onchange='cngWeek()'>\n";
		data		+= "<option value='2' selected='selected'>2주</option>\n";
		data		+= "<option value='4'>4주</option>\n";
		data		+= "</select>\n";
		data		+= "<input type='hidden' name='ss_type' value='' />\n";
	} else if (gubun1.equals("02")) {
		data		+= "<select name='devl_week' id='devl_week' onchange='cngWeek()'>\n";
		data		+= "<option value='2' selected='selected'>2주</option>\n";
		data		+= "<option value='4'>4주</option>\n";
		data		+= "</select>\n";
		data		+= "<input type='hidden' name='devl_day' value='5' />\n";
		data		+= "<input type='hidden' name='ss_type' value='' />\n";
	} else if (gubun1.equals("03")) {
		if (gubun2.equals("31")) {
			data		+= "<select name='ss_type' id='ss_type' onchange='cngWeek()'>\n";
			data		+= "<option value='0'>매일(월~토)-총12개/주</option>\n";
			data		+= "<option value='1'>주3회(월수금)-총6개/주</option>\n";
			data		+= "<option value='2'>주3회(화목토)-총6개/주</option>\n";
			data		+= "</select>\n";
			data		+= "<select name='devl_week' id='devl_week'>\n";
			data		+= "<option value='1' selected='selected'>1주</option>\n";
			data		+= "<option value='2'>2주</option>\n";
			data		+= "<option value='4'>4주</option>\n";
			data		+= "</select>\n";
			data		+= "<input type='hidden' name='devl_day' id='devl_day' value='6' />\n";
		} else if (gubun2.equals("32")) {
			data		+= "선택사항없음\n";
			data		+= "<input type='hidden' name='devl_day' value='0' />\n";
			data		+= "<input type='hidden' name='devl_week' value='0' />\n";
			data		+= "<input type='hidden' name='ss_type' value='' />\n";
		}
	}
} else {
	data		= "잘못된 접근입니다.";
}

out.println(data);
%>