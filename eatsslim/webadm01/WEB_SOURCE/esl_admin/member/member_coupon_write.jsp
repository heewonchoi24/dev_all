<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String memberId		= ut.inject(request.getParameter("mid"));

if (memberId == null || memberId.equals("")) {
	out.println("<script>self.close();</script>");
	if (true) return;
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
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
	<div style="display: none;">
		<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
	</div>
	<!-- popup_wrap -->
	<div class="popup_wrap">
		<div class="tab_con tab_style2"><!-------------------------------------->
			<h3 class="tit_style1 mt_25">신규큐폰발급</h3>
			<form name="frm_write" id="frm_write" method="post" action="member_coupon_db.jsp">
				<input type="hidden" name="mode" value="ins" />
				<input type="hidden" name="member_id" id="member_id" value="<%=memberId%>" />
				<input type="hidden" name="coupon_type" value="01" />
				<input type="hidden" name="vendor" value="04" />
				<table class="tableView" border="1" cellspacing="0">
					<colgroup>
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" colspan="4"><span>쿠폰정보입력</span></th>
						</tr>
						<tr>
							<th scope="row"><span>쿠폰명</span></th>
							<td>
								<input type="text" name="coupon_name" id="coupon_name" class="input1" style="width:300px;" maxlength="100" value="" />
							</td>
						</tr>
						<tr>
							<th scope="row"><span>사용기간</span></th>
							<td>
								<input type="text" name="stdate" id="stdate" class="input1" maxlength="10" readonly="readonly" value="" />
								~
								<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="10" readonly="readonly" value="" />
							</td>
						</tr>
						<tr>
							<th scope="row"><span>쿠폰할인금액</span></th>
							<td>
								<input type="radio" name="sale_type" value="P" checked="checked" />
								상품판매가격의
								<input type="text" name="sale_price1" id="sale_price1" value="0" class="input1" style="width:60px;" maxlength="3" dir="rtl" onblur="this.value=this.value.replace(/[^0-9]/g,'');" />
								% 할인
								<input type="radio" name="sale_type" value="W" />
								상품판매가격의
								<input type="text" name="sale_price2" id="sale_price2" value="0" class="input1" style="width:60px;" maxlength="7" dir="rtl" onkeyup="onlyNum(this);" />
								원 할인
							</td>
						</tr>
						<input type="hidden" name="sale_use_yn" value="Y" />
						<tr>
							<th scope="row"><span>사용제한</span></th>
							<td>
								구매최소수량
								<input type="text" name="use_limit_cnt" id="use_limit_cnt" class="input1" style="width:60px;" maxlength="2" dir="rtl" value="0" onkeyup="onlyNum(this);" />
								개 /
								상품판매가격의
								<input type="text" name="use_limit_price" id="use_limit_price" class="input1" style="width:60px;" maxlength="7" dir="rtl" value="0" onkeyup="onlyNum(this);" />
								원 이상
							</td>
						</tr>
						<tr>
							<th scope="row"><span>사용가능<br />상품설정</span></th>
							<td colspan="3">
								<span class="mr_10">
									<input type="radio" name="use_goods" value="01" checked="checked" />
									전체상품에 쿠폰 사용가능
								</span>
								<span class="mr_10">
									<input type="radio" name="use_goods" value="02" />
									특정 상품에만 쿠폰 사용가능
								</span>
								<span class="mr_10">
									<input type="radio" name="use_goods" value="03" />
									일배 상품 전체 사용가능
								</span>
								<span class="mr_10">
									<input type="radio" name="use_goods" value="04" />
									택배 상품 전체 사용가능
								</span>
								<div id="selGoods" class="cag01 hidden">
									<p class="mt_5">
										<div style="overflow:auto;height:200px;">
											<table cellspacing="0" class="table01" style="width:500px;">
												<%
												query		= "SELECT GROUP_CODE, GROUP_NAME";
												query		+= " FROM ESL_GOODS_GROUP";
												query		+= " WHERE USE_YN = 'Y'";
												query		+= " ORDER BY GUBUN1, GUBUN2, GROUP_CODE";
												try {
													rs		= stmt.executeQuery(query);
												} catch(Exception e) {
													out.println(e+"=>"+query);
													if (true) return;
												}

												while (rs.next()) {
												%>
												<tr>
													<td><input type="checkbox" name="group_code" value="<%=rs.getString("GROUP_CODE")+","+rs.getString("GROUP_NAME")%>" /></td>
													<td><%=rs.getString("GROUP_CODE")%></td>
													<td><%=rs.getString("GROUP_NAME")%></td>
												</tr>
												<%
												}
												rs.close();
												%>
											</table>
										</div>
									</p>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_center">
					<a href="javascript:;" onclick="chkWrite();" class="function_btn"><span>저장</span></a>
					<a href="member_coupon_list.jsp?mid=<%=memberId%>" class="function_btn"><span>목록</span></a>
				</div>
			</form>
		</div>
	</div>
	<!-- //popup_wrap -->
<script type="text/javascript">
$(document).ready(function() {
	$("#coupon_name").focus();

	$('#in_stdate,#in_ltdate').datepick({ 
		onSelect: setPeriod,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});

	$('#stdate,#ltdate').datepick({ 
		onSelect: setPeriod1,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});

	$("input[name=coupon_type]").click(function() {
		var couponType	= $("input[name=coupon_type]:checked").val();
		if (couponType == '01') {
			$("#offline").addClass("hidden");
		} else {
			$("#offline").removeClass("hidden");
		}
	});

	$("input[name=use_goods]").click(function() {
		var useGoods	= $("input[name=use_goods]:checked").val();
		if (useGoods == '02') {
			$("#selGoods").removeClass("hidden");
		} else {
			$("#selGoods").addClass("hidden");
		}
	});
});

function setPeriod(dates) {
	var stdate		= $("#in_stdate").val();
	var ltdate		= $("#in_ltdate").val();

	if (this.id == 'in_stdate') {
		$('#in_ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#in_stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}

function setPeriod1(dates) {
	var stdate		= $("#stdate").val();
	var ltdate		= $("#ltdate").val();

	if (this.id == 'stdate') {
		$('#ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}

function tr_del(el){
	var td=el.parentNode; //  부모 즉 TD
	var tr=td.parentNode; // td의 부모 즉 TR .. 
	var table=tr.parentNode; // tr의 부모 즉 TABLE ..
	table.removeChild(tr);
}

function chkWrite() {
	var saleType	= $("input[name=sale_type]:checked").val();

	if (!$("#member_id").val()) {
		alert("쿠폰을 발급해줄 회원을 선택하세요.");
		return;
	}
	if (!$.trim($("#coupon_name").val())) {
		alert("쿠폰명을 입력해주세요.");
		$("#coupon_name").focus();
		return;
	}
	if (!$.trim($("#stdate").val())) {
		alert("사용기간을 입력해주세요.");
		$("#stdate").focus();
		return;
	}
	if (!$.trim($("#ltdate").val())) {
		alert("사용기간을 입력해주세요.");
		$("#ltdate").focus();
		return;
	}
	if (saleType == "P" && (!$("#sale_price1").val() || parseInt($("#sale_price1").val()) < 1)) {
		alert("쿠폰할인금액을 입력하세요.");
		$("#sale_price1").select();
		return;
	}
	if (saleType == "W" && (!$("#sale_price2").val() || parseInt($("#sale_price2").val()) < 1)) {
		alert("쿠폰할인금액을 입력하세요.");
		$("#sale_price2").select();
		return;
	}
	if ($("input[name=use_goods]:checked").val() == "02" && !$("input[name=group_code]:checked").val() && !$("input[name=group_name]:checked").val()) {
		alert("상품을 등록하세요.");
		return;
	}

	document.frm_write.submit();
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>