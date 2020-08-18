<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:9,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 프로모션관리 &gt; <strong>정율할인</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="sale_db.jsp">
					<input type="hidden" name="mode" value="ins" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>할인명</span></th>
								<td colspan="3">
									<input type="text" name="title" id="title" class="input1" style="width:300px;" maxlength="100" value="" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>사용기간</span></th>
								<td colspan="3">
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="10" readonly="readonly" value="" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="10" readonly="readonly" value="" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>할인금액</span></th>
								<td colspan="3">
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
							<tr>
								<th scope="row"><span>적용 상품설정</span></th>
								<td colspan="3">
									<span class="mr_10">
										<input type="radio" name="use_goods" value="01" checked="checked" />
										전체상품에 적용
									</span>
									<span class="mr_10">
										<input type="radio" name="use_goods" value="02" />
										특정 상품에만 적용
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
						<a href="sale_list.jsp" class="function_btn"><span>목록</span></a>
					</div>
				</form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
<script type="text/javascript">
$(document).ready(function() {
	$('#stdate,#ltdate').datepick({ 
		onSelect: setPeriod,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
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
	var stdate		= $("#stdate").val();
	var ltdate		= $("#ltdate").val();

	if (this.id == 'stdate') {
		$('#ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}

function chkWrite() {
	var saleType	= $("input[name=sale_type]:checked").val();

	if (!$.trim($("#title").val())) {
		alert("할인명을 입력해주세요.");
		$("#title").focus();
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
		alert("할인금액을 입력하세요.");
		$("#sale_price1").select();
		return;
	}
	if (saleType == "W" && (!$("#sale_price2").val() || parseInt($("#sale_price2").val()) < 1)) {
		alert("할인금액을 입력하세요.");
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