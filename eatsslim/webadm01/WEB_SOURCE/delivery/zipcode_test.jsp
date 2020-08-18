<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");
%>
	<script type="text/javascript" src="/common/js/common.js"></script>
	<script type="text/javascript" src="/common/js/order.js"></script>
</head>
<body>
<div class="sectionHeader">
	<h4>
		<span class="f13">
			<input name="devl_type" type="radio" value="N" onclick="newAddr('R');" />
			새 배송지 입력
		</span>
	</h4>
</div>
<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<th>변경체계 주소<br />(도로명)</th>
		<td colspan="3">
			<input name="rcv_zipcode" id="rcv_zipcode" type="hidden" required label="우편번호" maxlength="6" />
			<input name="rcv_new_addr1" id="rcv_new_addr1" type="text" class="ftfd" style="width:340px; margin-top:5px;" required label="도로명 주소" readonly="readonly" maxlength="50" />
			<input name="rcv_new_addr2" id="rcv_new_addr2" type="text" class="ftfd" style="width:340px; margin-top:5px;" readonly="readonly" maxlength="50" />
		</td>
	</tr>
	<tr>
		<th>현 사용 주소<br />(지번명)</th>
		<td colspan="3">
			<input name="rcv_old_addr1" id="rcv_old_addr1" type="text" class="ftfd" style="width:340px; margin-top:5px;" required label="지번명 주소" readonly="readonly" maxlength="50" />
			<input name="rcv_old_addr2" id="rcv_old_addr2" type="text" class="ftfd" style="width:340px; margin-top:5px;" readonly="readonly" maxlength="50" />
		</td>
	</tr>
</table>
<div id="floatMenu">
	<%@ include file="/common/include/inc-floating.jsp"%>
</div>
<script type="text/javascript">
function newAddr(str) {
	window.open('/shop/popup/oldAddress.jsp?ztype=1','chk_zipcode','width=900,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>