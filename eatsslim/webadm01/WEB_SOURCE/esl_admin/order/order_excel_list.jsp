<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>

	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:6,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
	})
	//]]>
	</script><link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
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
		<%@ include file="../include/inc-sidebar-order.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 주문관리 &gt; <strong>주문/출고실적 조회</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_list">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>기간</span>
								</th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="10" readonly="readonly" value="" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="10" readonly="readonly" value="" />
								</td>
								<th scope="row">
									<span>집계기준</span>
								</th>
								<td>
									<select style="width:80px;" name="sort" id="sort">
										<option value="1">합계</option>
										<option value="2">일자별</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>매출/증정</span>
								</th>
								<td>
									<select style="width:80px;" name="pay_type">
										<option value="">전체</option>
										<option value="1">매출</option>
										<option value="2">증정</option>
									</select>
								</td>
								<th scope="row">
									<span>채널</span>
								</th>
								<td>
									<span>
										<select style="width:80px;" name="shop_type">
											<option value="">전체</option>
											<option value="51">홈페이지</option>
											<option value="53">이샵(전화)결제</option>
											<option value="59">임직원몰 주문</option>
											<option value="60">이샵(홈페이지)결제</option>
											<option value="54">GS샵</option>
											<option value="55">롯데닷컴</option>
											<option value="56">쿠팡</option>
											<option value="57">티몬</option>
											<option value="58">홈쇼핑</option>
											<option value="61">NOOM</option>
										</select>
									</span>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>주문/출고</span>
								</th>
								<td>
									<select style="width:80px;" name="etype">
										<option value="1">주문</option>
										<option value="2">출고</option>
										<option value="3">주문(취소)</option>
										<option value="4">출고(취소)</option>
									</select>
								</td>
								<th scope="row">
									<span>상품구분</span>
								</th>
								<td>
									<span>
										<select style="width:80px;" name="category">
											<option value="">전체</option>
											<option value="01">식사</option>
											<option value="02">프로그램</option>
											<option value="03">타입별</option>
										</select>
									</span>
								</td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center"><a href="javascript:;" onclick="excelDown();" class="function_btn"><span>엑셀다운로드</span></a></p>
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
		onSelect: customRange,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
});

function customRange(dates) {
	if (this.id == 'stdate') { 
        $('#ltdate').datepick('option', 'minDate', dates[0] || null); 
    } else { 
        $('#stdate').datepick('option', 'maxDate', dates[0] || null); 
    }
}

function excelDown(){
	if (!$("#stdate").val()) {
		alert("시작기간을 입력하세요.");
		$("#stdate").focus();
		return;
	}
	if (!$("#ltdate").val()) {
		alert("마감기간을 입력하세요.");
		$("#ltdate").focus();
		return;
	}
	var f	= document.frm_list;
	//f.target	= "ifrmHidden";
	if ($("#sort").val() == "1") {
		f.action	= "order_excel1.jsp";
	} else {
		f.action	= "order_excel2.jsp";
	}
	f.encoding="application/x-www-form-urlencoded";
	f.submit();	
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>