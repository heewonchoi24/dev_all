<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_COUPON";
String query		= "";
String where		= "";
int couponId		= 0;
String couponName	= "";
String saleType		= "";
int salePrice		= 0;
String saleTxt		= "";
String stdate		= "";
String ltdate		= "";
String schCname		= ut.inject(request.getParameter("sch_cname"));
int intTotalCnt		= 0;
NumberFormat nf		= NumberFormat.getNumberInstance();

where		= " WHERE LTDATE >= DATE_FORMAT(NOW(), '%Y-%m-%d') AND COUPON_TYPE = '01'";

if (!schCname.equals("") && schCname != null) {
	schCname	= new String(schCname.getBytes("8859_1"), "EUC-KR");
	where		+= " AND COUPON_NAME LIKE '%"+ schCname +"%'";
}

query		= "SELECT COUNT(ID) FROM "+ table + where;
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if (true) return;
}

if (rs.next()) {
	intTotalCnt		= rs.getInt(1); //총 레코드 수		
}
rs.close();

query		= "SELECT ID, COUPON_NAME, STDATE, LTDATE, SALE_TYPE, SALE_PRICE FROM "+ table + where +" ORDER BY ID DESC";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if (true) return;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>Pulmuone EATSSLIM 관리자시스템</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css" />
	<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
	<style type="text/css">
	html, body { height:auto; background:#fff;}
	</style>
</head>
<body>
<!-- popup_wrap -->
<div class="popup_wrap" style="width:400px;">
	<form method="get" name="search_call" action="<%=request.getRequestURI()%>">
		<input type="hidden" name="mode" value="search">
		<input type="hidden" name="id">
		<h2>쿠폰검색</h2>
		<table class="table01" border="1" cellspacing="0">
			<colgroup>
					<col width="140px" />
					<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span>쿠폰명</span></th>
					<td>
						<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="sch_cname" onfocus="this.select()"/></td>
					</td>
				</tr>
			</tbody>
		</table>
		<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="검색" /></p>
		<table class="table02" border="1" cellspacing="0">
			<colgroup>
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">쿠폰명</th>
					<th scope="col">쿠폰금액</th>
					<th scope="col">사용기간</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (intTotalCnt > 0) {
					while (rs.next()) {
						couponId	= rs.getInt("ID");
						couponName	= rs.getString("COUPON_NAME");
						saleType	= rs.getString("SALE_TYPE");
						salePrice	= rs.getInt("SALE_PRICE");
						saleTxt		= (saleType.equals("P"))? "%할인" : "원";
						stdate		= rs.getString("STDATE");
						ltdate		= rs.getString("LTDATE");
				%>
				<tr>
					<td><a href="javascript:;" onclick="setCoupon(<%=couponId%>);"><%=couponName%></a></td>
					<td><%=nf.format(salePrice)+saleTxt%></td>
					<td><%=stdate%>~<%=ltdate%></td>
				</tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
	</form>
</div>
<!-- //popup_wrap -->
<script type="text/javascript">
function setCoupon(cid) {
	if (confirm("해당쿠폰을 지급하시겠습니까?")) {
		$("#coupon_id", opener.document).val(cid);
		$("#mode", opener.document).val("member");
		opener.document.frm_list.submit();
		self.close();
	}
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp" %>