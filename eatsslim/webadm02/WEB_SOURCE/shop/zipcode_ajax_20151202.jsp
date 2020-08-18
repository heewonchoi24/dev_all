<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String query		= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String ztype		= ut.inject(request.getParameter("ztype"));
String schDong		= ut.inject(request.getParameter("dong"));
String zipcode		= "";
String zipcode1		= "";
String zipcode2		= "";
String sido			= "";
String gugun		= "";
String dong			= "";
String bunji		= "";
String address		= "";
String devltype		= "";
String devltype1	= "";
String devltype2	= "";
String devlPtnCd	= "";
int cnt				= 0;

if (mode.equals("post")) {
	if (schDong == null || schDong.equals("")) {
		code		= "error";
		data		= "<error><![CDATA[검색어를 입력하세요.]]></error>";
	} else {
		try {
			query		= "SELECT ZIPCODE, SIDO, GUGUN, DONG, BUNJI, DLVTYPE, DLVPTNCD FROM PHIBABY.V_ZIPCODE_OLD_5";
			query		+= " WHERE DONG LIKE '%"+ schDong +"%'";
			if (ztype.equals("1")) {
				query		+= " AND DLVPTNCD = '01' AND DLVYN = 'Y'";
				query		+= " AND DLVTYPE = '000"+ ztype +"'";
			}
			pstmt_phi	= conn_phi.prepareStatement(query);
			rs_phi		= pstmt_phi.executeQuery();

			while (rs_phi.next()) {
				zipcode		= rs_phi.getString("ZIPCODE");
				if (zipcode.length() == 6) {
					zipcode1	= zipcode.substring(0,3);
					zipcode2	= zipcode.substring(3,6);
				}
				sido		= rs_phi.getString("SIDO");
				gugun		= rs_phi.getString("GUGUN");
				dong		= rs_phi.getString("DONG");
				bunji		= (rs_phi.getString("BUNJI") != null)? rs_phi.getString("BUNJI") : "";
				address		= sido +" "+ gugun +" "+ dong +" "+ bunji;
				devltype	= rs_phi.getString("DLVTYPE");
				devlPtnCd	= rs_phi.getString("DLVPTNCD");
				if (devltype.equals("0001") && devlPtnCd.equals("01")) {
					devltype1	= "O";
					devltype2	= "O";

					data		+= "<address><![CDATA["+ zipcode +"]]>|<![CDATA["+ address +"]]>|<![CDATA["+ zipcode1 +"]]>|<![CDATA["+ zipcode2 +"]]>|<![CDATA["+ devltype1 +"]]>|<![CDATA["+ devltype2 +"]]></address>";

					cnt++;
				} else {
					devltype1	= "X";
					devltype2	= (sido.equals("제주특별자치도"))? "X" : "O";

					data		+= "<address><![CDATA["+ zipcode +"]]>|<![CDATA["+ address +"]]>|<![CDATA["+ zipcode1 +"]]>|<![CDATA["+ zipcode2 +"]]>|<![CDATA["+ devltype1 +"]]>|<![CDATA["+ devltype2 +"]]></address>";

					if (!sido.equals("제주특별자치도")) {
						cnt++;
					}
				}
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