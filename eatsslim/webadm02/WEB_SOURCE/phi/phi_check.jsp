<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
String query		= "";
String query1		= "";
String orderNum		= "";
String devlDate		= "";

query		= "SELECT ORD_NO, TO_DATE(DELV_DATE, 'YYYYMMDD') DELV_DATE FROM PHIBABY.P_ORDER_MALL_PHI_ITF";
query		+= " WHERE INTERFACE_FLAG_YN = 'Y'";
query		+= " AND   PROC_FLAG = 'Y'";
query		+= " AND   ORD_TYPE = 'I'";
query		+= " AND   ORD_NO > 'ESS131013000000000'";
query		+= " AND   GOODS_NO = '0300668'";
query		+= " ORDER BY ORD_NO";
try {
	rs_phi		= stmt_phi.executeQuery(query);
} catch(Exception e) {
	out.println(e);
	if(true)return;
}
int i = 0;
while (rs_phi.next()) {
	orderNum	= rs_phi.getString("ORD_NO");
	devlDate	= rs_phi.getString("DELV_DATE").substring(0,10);

	out.println(orderNum +"<br />");
	query1		= "UPDATE ESL_ORDER_DEVL_DATE SET DEVL_DATE = '"+ devlDate +"'";
	query1		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GROUP_CODE = '0300668'";
	try {
		stmt.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}
	i++;
	//if (i == 5) return;
}

out.println(i);
%>