<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_tbr.jsp"%>
<%
String query		= "";

query		= "SELECT * FROM TBITF_VOICE_IF WHERE RECEIPT_ROOT = '10001' ORDER BY RECEIPT_DATE DESC, BOARD_SEQ DESC";
try {
	rs_tbr	= stmt_tbr.executeQuery(query);			
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs_tbr.next()) {
	out.println(rs_tbr.getString("BOARD_DIV") +",");
	out.println(rs_tbr.getString("BOARD_SEQ") +",");
	out.println(rs_tbr.getString("CUSTOMER_NUM") +",");
	out.println(rs_tbr.getString("CUSTOMER_NAME") +",");
	out.println(rs_tbr.getString("CUSTOMER_PHONEAREA") +",");
	out.println(rs_tbr.getString("CUSTOMER_PHONEFIRST") +",");
	out.println(rs_tbr.getString("CUSTOMER_PHONESECOND") +",");
	out.println(rs_tbr.getString("CUSTOMER_EMAIL") +",");
	out.println(rs_tbr.getString("HD_BCODE") +",");
	out.println(rs_tbr.getString("HD_SCODE") +",");
	out.println(rs_tbr.getString("CLAIM_GUBUN") +",");
	out.println(rs_tbr.getString("COUNSEL_DESC") +",");
	out.println(rs_tbr.getString("REPLY") +",");
	out.println(rs_tbr.getString("ITEM_DESC") +",");
	out.println(rs_tbr.getString("SEC_CODE") +",");
	out.println(rs_tbr.getString("ITEM_SCODE") +",");
	out.println(rs_tbr.getString("FRAN_SCODE") +",");
	out.println(rs_tbr.getString("COUNSELER") +",");
	out.println(rs_tbr.getString("RECEIPT_DATE") +",");
	out.println(rs_tbr.getString("MODIFY_DATE") +",");
	out.println(rs_tbr.getString("ORG_FILENM1") +",");
	out.println(rs_tbr.getString("CNV_FILENM1") +",");
	out.println(rs_tbr.getString("PRCS_YN") +",");
	out.println(rs_tbr.getString("DEL_YN") +",");
	out.println(rs_tbr.getString("SEQ") +",");
	out.println(rs_tbr.getString("ITEM_NAME") +"<br />");
}
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_tbr.jsp" %>