<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderNum		= ut.inject(request.getParameter("ordno"));

if (orderNum == null || orderNum.equals("")) {
	out.println("<script>self.close();</script>");
	if (true) return;
}

String query			= "";
String payType			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String rcvHp			= "";
String pgTid			= "";
String payYn			= ""; 
int payPrice		= 0;

query		= "SELECT ";
query		+= "	PAY_PRICE, PAY_TYPE, RCV_HP, PG_CARDNUM, PG_FINANCENAME, PG_ACCOUNTNUM, PG_TID, PAY_YN ";
query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {

	payPrice		= rs.getInt("PAY_PRICE");
	payType			= rs.getString("PAY_TYPE");
	pgCardNum		= rs.getString("PG_CARDNUM");
	pgFinanceName	= rs.getString("PG_FINANCENAME");
	pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
	rcvHp			= rs.getString("RCV_HP");
	pgTid			= rs.getString("PG_TID");
	payYn			= rs.getString("PAY_YN");
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>Pulmuone EATSSLIM 관리자시스템</title>

	<link rel="stylesheet" type="text/css" href="../css/styles.css" />
	<style type="text/css">
	html, body { height:auto; background:#fff;}
	</style>

	<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="../js/common.js"></script>
</head>
<body>
	<!-- popup_wrap -->
	<div class="popup_wrap">
		<h2>주문취소</h2>
		<form id="f_submit" name="f_submit" method="post" action="order_all_cancel_db.jsp" >
			<input type="hidden" id="mode" name="mode" value="cancel" />
			<input type="hidden" id="code" name="code" value="CD1" />
			<input type="hidden" id="order_num" name="order_num" value="<%=orderNum %>" />
			<input type="hidden" id="pay_type" name="pay_type" value="<%=payType %>" />
			<input type="hidden" name="payYn" value="<%=payYn%>">
			<input type="hidden" name="pgTID" value="<%=pgTid%>">
			
			<table class="table01 mt_5" border="1" cellspacing="0">
				<colgroup>
					<col width="100px" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><span>취소사유선택</span></th>
						<td>
							<select id="reasonType" name="reasonType" style="min-width: 150px;">
								<option value="1">구매의사취소</option>
								<option value="2">상품 잘못 주문</option>
								<option value="3">상품정보 상이</option>
								<option value="4">서비스 및 상품 불만족</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><span>상세사유입력</span></th>
						<td>
							<textarea id="reason" name="reason" rows="6" style="min-width: 600px;"></textarea>
						</td>
					</tr>
					<%if (payType.equals("30")) {%>
					<tr>
					<th>환불 계좌번호</th>
					<td>
						<select id="bankName" name="bankName" style="width:90px;">
							<option value="경남">경남</option>
							<option value="국민">국민</option>
							<option value="기업">기업</option>
							<option value="농협">농협</option>
							<option value="대구">대구</option>
							<option value="부산">부산</option>
							<option value="수협">수협</option>
							<option value="신한">신한</option>
							<option value="외환">외환</option>
							<option value="우리">우리</option>
							<option value="우체국">우체국</option>
							<option value="하나">하나</option>
							<option value="새마을금고">새마을금고</option>
							<option value="카카오뱅크">카카오뱅크</option>
						</select>
						<input style="width:150px;" name="bankAccount" id="bankAccount" type="text" class="input1" required="" label=""  onBlur="this.value=this.value.replace(/[^0-9-]/g,'');"  placeholder ="계좌번호입력">
						&nbsp;&nbsp;예금주명 : <input maxlength="30" style="width:144px;" maxlength="100" name="bankUser" id="bankUser" type="text" class="input1" required="" label="">
					</td>
				</tr>
				<%}%>
			</tbody>
			</table>
		</form>
		<div style="padding: 20px 0; text-align: center;">
			<a class="function_btn" href="javascript:;" onclick="fnCancelSave();"><span>주문취소 신청</span></a>
			<a class="function_btn" href="javascript:;" onclick="self.close();"><span>취소</span></a>
		</div>
	</div>
	<!-- //popup_wrap -->
	<script>

	$('#reasonType').change(function(e) {
		$("#reasonType").val($(this).val());
	});

	function fnCancelSave(){
        document.f_submit.submit();
		//var reason = $("#reason").val();
		//location.href = 'order_all_cancel_db.jsp?mode=cancel&code=CD1&order_num=<%=orderNum%>&pay_type=<%=payType%>&reasonType='+$("#reasonType").val()+'&reason='+ encodeURI(reason , "euc-kr")+'&bankName='+encodeURI($("#bankName").val(), "euc-kr")+'&bankAccount='+$("#bankAccount").val()+'&bankUser='+encodeURI($("#bankUser").val() , "euc-kr");		
	}
	</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>