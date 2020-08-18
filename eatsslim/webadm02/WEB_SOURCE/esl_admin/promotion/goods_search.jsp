<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_GOODS_GROUP";
String query		= "";
String where		= "";
String groupCode	= "";
String groupName	= "";
String schGroupName	= ut.inject(request.getParameter("group_name"));
int intTotalCnt		= 0;

where		= " WHERE ID NOT IN (16, 17, 18)";

if (schGroupName != null && schGroupName.length() > 0) {
	schGroupName	= new String(schGroupName.getBytes("8859_1"), "EUC-KR");
	where			+= " AND GROUP_NAME LIKE '%"+ schGroupName +"%'";
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

query		= "SELECT GROUP_CODE, GROUP_NAME FROM "+ table + where +" ORDER BY GUBUN1, GUBUN2, GROUP_CODE";
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
		<h2>상품등록</h2>
		<table class="table01" border="1" cellspacing="0">
			<colgroup>
					<col width="140px" />
					<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span>상품검색</span></th>
					<td>
						<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="group_name" onfocus="this.select()"/></td>
					</td>
				</tr>
			</tbody>
		</table>
		<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="검색" /></p>
		<table class="table02" border="1" cellspacing="0">
			<colgroup>
				<col width="140px" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">상품코드</th>
					<th scope="col">상품명</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (intTotalCnt > 0) {
					while (rs.next()) {
						groupCode	= rs.getString("GROUP_CODE");
						groupName	= rs.getString("GROUP_NAME");
				%>
				<tr>
					<td><%=groupCode%></td>
					<td><a href="javascript:;" onclick="selection('<%=groupCode%>', '<%=groupName%>');"><%=groupName%></a></td>
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
function selection(gcd ,gnm) {
	var obj = opener.document.getElementById('objProduct');
	oTr = obj.insertRow();
	oTd = oTr.insertCell();
	oTd.innerHTML = gnm;
	oTd = oTr.insertCell();
	oTd.innerHTML = '<a href="javascript:;" onclick="tr_del(this)"><img src="../images/common/btn/btn_close.gif"/></a><input type="hidden" name="group_code" value="'+gcd+'"><input type="hidden" name="group_name" value="'+gnm+'">';
	self.close();
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp" %>