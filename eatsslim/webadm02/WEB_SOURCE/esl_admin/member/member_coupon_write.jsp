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
	<title>Pulmuone EATSSLIM �����ڽý���</title>

	<link rel="stylesheet" type="text/css" href="../css/styles.css" />
	<style type="text/css">
	html, body { height:auto; background:#fff;}
	</style>

	<!-- Bootstrap 3 DateTimepicker v4 Docs -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/css/bootstrap-datetimepicker.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.1/moment.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/js/bootstrap-datetimepicker.min.js"></script> 	

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
			<h3 class="tit_style1 mt_25">�ű�ť���߱�</h3>
			<form name="frm_write" id="frm_write" method="post" action="member_coupon_db.jsp">
				<input type="hidden" name="mode" value="ins" />
				<input type="hidden" name="member_id" id="member_id" value="<%=memberId%>" />
				<input type="hidden" name="coupon_type" value="01" />
				<input type="hidden" name="vendor" value="04" />
				<table class="tableView" border="1" cellspacing="0">
					<colgroup>
						<col width="220px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" colspan="4"><span>���������Է�</span></th>
						</tr>
						<tr>
							<th scope="row"><span>������</span></th>
							<td>
								<input type="text" name="coupon_name" id="coupon_name" style="width:300px;height:24px;"  maxlength="100" value="" />
							</td>
						</tr>
						<tr>
							<th scope="row"><span>���Ⱓ</span></th>
							<td>
								<div class="container" style="width:620px;">
									<div class='col-md-5'>
										<div class="form-group" style="margin-bottom:0">
											<div class='input-group date' id='datetimepicker6' style="width:250px">
												<input type='text' class="form-control" name="stdate" id="stdate"/>
												<span class="input-group-addon">
													<span class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>~
									<div class='col-md-5'>
										<div class="form-group" style="margin-bottom:0">
											<div class='input-group date' id='datetimepicker7' style="width:250px">
												<input type='text' class="form-control" name="ltdate" id="ltdate"/>
												<span class="input-group-addon">
													<span class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
								</div>
								<script type="text/javascript">
									$(function () {
										$('#datetimepicker6').datetimepicker({
											format: "YYYY-MM-DD HH:mm",
											useCurrent: false //Important! See issue #1075
										});
										$('#datetimepicker7').datetimepicker({
											format: "YYYY-MM-DD HH:mm",
											useCurrent: false //Important! See issue #1075
										});
										$("#datetimepicker6").on("dp.change", function (e) {
											$('#datetimepicker7').data("DateTimePicker").minDate(e.date);
										});
										$("#datetimepicker7").on("dp.change", function (e) {
											$('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
										});
									});
								</script>
							</td>
							<!-- <th scope="row"><span>���Ⱓ</span></th>
							<td>
								<input type="text" name="stdate" id="stdate" class="input1" maxlength="10" readonly="readonly" value="" />
								~
								<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="10" readonly="readonly" value="" />
							</td> -->
						</tr>
						<tr>
							<th scope="row"><span>�������αݾ�</span></th>
							<td>
								<input type="radio" name="sale_type" value="P" checked="checked" />
								��ǰ�ǸŰ�����
								<input type="text" name="sale_price1" id="sale_price1" value="0" style="width:60px;height:24px;"  style="width:60px;" maxlength="3" dir="rtl" onblur="this.value=this.value.replace(/[^0-9]/g,'');" />
								% ����
								<input type="radio" name="sale_type" value="W" />
								��ǰ�ǸŰ�����
								<input type="text" name="sale_price2" id="sale_price2" value="0" style="width:60px;height:24px;"  style="width:60px;" maxlength="7" dir="rtl" onkeyup="onlyNum(this);" />
								�� ����
							</td>
						</tr>
						<input type="hidden" name="sale_use_yn" value="Y" />
						<tr>
							<th scope="row"><span>�������</span></th>
							<td>
								�����ּҼ���
								<input type="text" name="use_limit_cnt" id="use_limit_cnt" style="width:60px;height:24px;"  style="width:60px;" maxlength="2" dir="rtl" value="0" onkeyup="onlyNum(this);" />
								�� /
								��ǰ�ǸŰ�����
								<input type="text" name="use_limit_price" id="use_limit_price" style="width:60px;height:24px;"  style="width:60px;" maxlength="7" dir="rtl" value="0" onkeyup="onlyNum(this);" />
								�� �̻�
							</td>
						</tr>
						<tr>
							<th scope="row"><span>�ֹ��Ⱓ</span></th>
							<td>
								<input type="checkbox" id="order_week" name="order_week" value="1" checked="checked"/>1��
								<input type="checkbox" id="order_week" name="order_week" value="2" />2��
								<input type="checkbox" id="order_week" name="order_week" value="4" />4��
								<input type="checkbox" id="order_week" name="order_week" value="8" />8��
							</td>
						</tr>
						<tr>
							<th scope="row"><span>��밡��<br />��ǰ����</span></th>
							<td colspan="3">
								<span class="mr_10">
									<input type="radio" name="use_goods" value="01" checked="checked" />
									��ü��ǰ�� ���� ��밡��
								</span>
								<span class="mr_10">
									<input type="radio" name="use_goods" value="02" />
									Ư�� ��ǰ���� ���� ��밡��
								</span>
								<span class="mr_10">
									<input type="radio" name="use_goods" value="03" />
									�Ϲ� ��ǰ ��ü ��밡��
								</span>
								<span class="mr_10">
									<input type="radio" name="use_goods" value="04" />
									�ù� ��ǰ ��ü ��밡��
								</span>
								<div id="selGoods" class="cag01 hidden">
									<p class="mt_5">
										<div style="overflow:auto;height:200px;">
											<table cellspacing="0" class="table01" style="width:300px;">
													<%
													query		= "SELECT ID, GUBUN1, GROUP_CODE, GROUP_NAME, DEVL_GOODS_TYPE";
													query		+= " FROM ESL_GOODS_GROUP";
													query		+= " WHERE USE_YN = 'Y' AND LIST_VIEW_YN = 'Y' ";
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
														<td><input goodsId="<%=rs.getInt("ID")%>" goodsGubun1="<%=rs.getInt("GUBUN1")%>" devlType="<%=rs.getInt("DEVL_GOODS_TYPE")%>" type="checkbox" name="group_code" value="<%=rs.getString("GROUP_CODE")+","+rs.getString("GROUP_NAME")%>" /></td>
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
					<a href="javascript:;" onclick="chkWrite();" class="function_btn"><span>����</span></a>
					<a href="member_coupon_list.jsp?mid=<%=memberId%>" class="function_btn"><span>���</span></a>
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

	$("input[name=use_goods]").click(function() {
		var useGoods	= $("input[name=use_goods]:checked").val();
		if (useGoods == '04') {
			alert("�ù� ��ǰ ��ü ��밡�� ������ �߱��� ��� �ֹ��Ⱓ�� ������� �ʽ��ϴ�."); 
			$("input[name=order_week]").prop("checked",false);
			$("input[name=order_week]").prop("disabled", true);
		}else{
			$("input[name=order_week]").prop("disabled", false);
		}
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
	var td=el.parentNode; //  �θ� �� TD
	var tr=td.parentNode; // td�� �θ� �� TR .. 
	var table=tr.parentNode; // tr�� �θ� �� TABLE ..
	table.removeChild(tr);
}

function chkWrite() {
	var saleType	= $("input[name=sale_type]:checked").val();

	if (!$("#member_id").val()) {
		alert("������ �߱����� ȸ���� �����ϼ���.");
		return;
	}
	if (!$.trim($("#coupon_name").val())) {
		alert("�������� �Է����ּ���.");
		$("#coupon_name").focus();
		return;
	}
	if (!$.trim($("#stdate").val())) {
		alert("���Ⱓ�� �Է����ּ���.");
		$("#stdate").focus();
		return;
	}
	if (!$.trim($("#ltdate").val())) {
		alert("���Ⱓ�� �Է����ּ���.");
		$("#ltdate").focus();
		return;
	}
	if (saleType == "P" && (!$("#sale_price1").val() || parseInt($("#sale_price1").val()) < 1)) {
		alert("�������αݾ��� �Է��ϼ���.");
		$("#sale_price1").select();
		return;
	}
	if (saleType == "W" && (!$("#sale_price2").val() || parseInt($("#sale_price2").val()) < 1)) {
		alert("�������αݾ��� �Է��ϼ���.");
		$("#sale_price2").select();
		return;
	}
	var useGoods	= $("input[name=use_goods]:checked").val();
	if (useGoods == 01 || useGoods == 03) {// ��ü, Ư��, �Ϲ�
		if($("input[name=order_week]:checked").length == 0){// �ֹ��Ⱓ�� üũ�� �ȵǾ� ������
			alert("�ֹ��Ⱓ�� �������ּ���.");
			return;
		}
	}
	var chk = 0;
	if(useGoods == 02){
		$("input[name=group_code]:checked").each(function(){
		   var goodsId = $(this).attr("goodsId");
		   var goodsGubun1 = $(this).attr("goodsGubun1");
		   var devlType = $(this).attr("devlType");
			if(devlType == 0002){
			}else{
				if($("input[name=order_week]:checked").length == 0){// �ֹ��Ⱓ�� üũ�� �ȵǾ� ������
					chk = 1;
				}
			}
		});	
	}
	if(chk == 1){
		alert("������ �Ϲ� ��ǰ�� ���� �ֹ��Ⱓ�� �������ּ���.");
		return;
	}
	if ($("input[name=use_goods]:checked").val() == "02" && !$("input[name=group_code]:checked").val() && !$("input[name=group_name]:checked").val()) {
		alert("��ǰ�� ����ϼ���.");
		return;
	}

	var msg = "���� �Ͻðڽ��ϱ�?"
	if(confirm(msg)){
		document.frm_write.submit();
	}
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>