<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:4,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 주문관리 &gt; <strong>관리자 주문등록</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="order_write_db.jsp">
					<input type="hidden" name="mode" value="addCart" />
					<input type="hidden" name="cart_type" id="cart_type" />
					<input type="hidden" name="group_id" id="group_id" />
					<input type="hidden" name="price" id="price" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>구분1</span></th>
								<td style="height:45px;padding-top:5px;">
									<select name="gubun1" id="gubun1" onchange="getGubun2()">
										<option value="">선택</option>
										<option value="01">식사다이어트</option>
										<option value="02">프로그램다이어트</option>
										<option value="03">타입별다이어트</option>
									</select>
								</td>
								<th scope="row"><span>구분2</span></th>
								<td>
									<select name="gubun2" id="gubun2" onchange="getPeriod()">
										<option value="">선택</option>
									</select>
									<span id="groupSelect"></span>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>배송기간</span></th>
								<td id="period">구분1을 먼저 선택하세요.</td>
								<th scope="row"><span>첫배송일</span></th>
								<td>
									<input id="devl_date" name="devl_date" class="input1" maxlength="10" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>수량</span></th>
								<td>
									<input type="text" name="order_cnt" id="order_cnt" class="input1" style="width:30px;" dir="rtl" maxlength="1" value="1" onkeyup="onlyNum(this);" />개
								</td>
								<th scope="row"><span>보냉가방</span></th>
								<td id="bagYn"><input name="buy_bag" id="buy_bag" type="checkbox" value="Y" checked="checked" /> 보냉가방 구매</td>
							</tr>
							<tr>
								<th scope="row"><span>금액</span></th>
								<td colspan="3"><span id="tprice">0원</span></td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<!--a href="javascript:;" onclick="ckForm(document.frm_write)" class="function_btn"><span>장바구니</span></a-->
						<a href="javascript:;" onclick="addCart('L');" class="function_btn"><span>주문하기</span></a>
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
	$("#devl_date").datepick({ 
		dateFormat: "yyyy.mm.dd",
		minDate: +6,
		onDate: $.datepick.noWeekend,
		showTrigger: '#calImg'
	});
});

(function($) {
	$.extend($.datepick, {
		noWeekend: function(date) {
			return {selectable: date.getDay() != 0 && date.getDay() != 6};
		},
		noSundays: function(date) {
			return {selectable: date.getDay() != 0};
		},
		noOdd: function(date) {
			return {selectable: date.getDay() != 0 && date.getDay() != 1 && date.getDay() != 3 && date.getDay() != 5};
		},
		noEven: function(date) {
			return {selectable: date.getDay() != 0 && date.getDay() != 2 && date.getDay() != 4 && date.getDay() != 6};
		}
	});
})(jQuery);

function getTprice() {
	var gubun1		= $("#gubun1").val();
	var buyQty		= parseInt($("#order_cnt").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? 7000 * buyQty : 0;
	var totalPrice	= 0;
	if (gubun1 == '02') {
		totalPrice	= parseInt($("#price").val()) * buyQty + parseInt(bag_price);
	} else {
		totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
	}

	$("#tprice").text(commaSplit(totalPrice)+ "원");
}

function getGubun2() {
	var gubun1		= $("#gubun1").val();
	$("#devl_date").datepick('clear');
	$("#devl_date").datepick('destroy');
	$("#devl_date").datepick({ 
		dateFormat: "yyyy.mm.dd",
		onDate: $.datepick.noWeekend,
		showTrigger: '#calImg'
	});
	if (gubun1 == "01") {
		newOptions	= {
			'11' : '1식',
			'12' : '2식',
			'13' : '3식',
			'14' : '2식+간식',
			'15' : '3식+간식'
		}
		selectedOption	= '11';		
	} else if (gubun1 == "02") {
		newOptions	= {
			'21' : '감량',
			'22' : '유지',
			'23' : 'FULL-STEP'
		}
		selectedOption	= '21';
		$("#group_code").remove();
	} else if (gubun1 == "03") {
		newOptions	= {
			'31' : '시크릿수프(SS)',
			'32' : '밸런스쉐이크'
		}
		selectedOption	= '31';
		$("#group_code").remove();
	} else {
		newOptions	= {'' : '선택'};
		selectedOption	= '';
		$("#period").text("구분1을 먼저 선택하세요.");
		$("#group_code").remove();
		$("#tprice").text("0원");
	}
	makeOption(newOptions, $("#gubun2"), selectedOption);

	if (gubun1) {
		var gubun3	= (gubun1 == '02')? '2' : '';
		getPeriodOpt(gubun1, selectedOption);
		getGroup(gubun1, selectedOption, gubun3);
	}
}

function getGroup(gubun1, gubun2, gubun3) {
	$.post("order_write_ajax.jsp", {
		mode: 'getGroup',
		gubun1: gubun1,
		gubun2: gubun2,
		gubun3: gubun3
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				var groupOptions	= '<select name="group_code" id="group_code" onchange="selGroup();">';
				var i				= 0;
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					groupOptions	+= '<option value="'+ groupArr[0] +'">'+ groupArr[1] +"</option>\n";
					if (i == 0) {
						$("#group_id").val(groupArr[0]);
						$("#price").val(groupArr[2]);
						totalPrice	= getTprice();
					}
					i++;
				});
				groupOptions	+= "</select>"
				if (gubun1 == '01') {
					$("#groupSelect").html(groupOptions);
				}				
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$("#group_id").val("");
						$("#price").val(0);
						totalPrice	= getTprice();
					});
				});
			}
		});
	}, "xml");
}

function selGroup() {
	var groupCode	= $("#group_code").val();
	$.post("order_write_ajax.jsp", {
		mode: 'selGroup',
		group_id: groupCode
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					$("#group_id").val(groupArr[0]);
					$("#price").val(groupArr[1]);
					totalPrice	= getTprice();
				});
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$("#group_id").val("");
					});
				});
			}
		});
	}, "xml");
	return false;
}

function getPeriodOpt(gubun1, gubun2) {
	$.post("order_write_option.jsp", {
		mode: 'period',
		gubun1: gubun1,
		gubun2: gubun2		
	},
	function(data) {
		$("#period").html(data);
	});

	if (gubun1 == '01' || gubun1 == '02') {		
		$("#bagYn").html('<input name="buy_bag" id="buy_bag" type="checkbox" value="Y" checked="checked" onclick="getTprice();" /> 보냉가방 구매');
		return false;
	} else if (gubun1 == '03') {
		if (gubun2 == '31') {
			$("#bagYn").html('<input name="buy_bag" id="buy_bag" type="checkbox" value="Y" checked="checked" onclick="getTprice();" /> 보냉가방 구매');
		} else {
			$("#bagYn").html('선택사항없음<input name="buy_bag" type="hidden" value="N" checked="checked" />');
		}
		
		return false;
	}
}

function getPeriod() {
	var gubun1		= $("#gubun1").val();
	var gubun2		= $("#gubun2").val();
	if (gubun1 == '01') {
		getGroup(gubun1, gubun2, '');		
	} else if (gubun1 == '03') {
		$("#devl_date").datepick('clear');
		$("#devl_date").datepick('destroy');
		$("#devl_date").datepick({ 
			dateFormat: "yyyy.mm.dd",
			onDate: $.datepick.noSundays,
			showTrigger: '#calImg'
		});

		getPeriodOpt(gubun1, gubun2);
	}
}

function cngDay() {
	var devlDay		= $("#devl_day").val();
	$("#devl_date").datepick('clear');
	$("#devl_date").datepick('destroy');
	if (devlDay == 5) {
		$("#devl_date").datepick({ 
			dateFormat: "yyyy.mm.dd",
			onDate: $.datepick.noWeekend,
			showTrigger: '#calImg'
		});
	} else {
		$("#devl_date").datepick({ 
			dateFormat: "yyyy.mm.dd",
			onDate: $.datepick.noSundays,
			showTrigger: '#calImg'
		});
	}
	totalPrice	= getTprice();
}

function cngWeek() {
	var devlType	= $("#ss_type").val();
	if (gubun1 == '03') {	
		var typeOptions	= "";
		$("#devl_date").datepick('clear');
		$("#devl_date").datepick('destroy');
		if (devlType == "0") {
			typeOptions	+= '<option value="1">1주</option>';
			typeOptions	+= '<option value="2">2주</option>';
			typeOptions	+= '<option value="4">4주</option>';
			$("#devl_date").datepick({ 
				dateFormat: "yyyy.mm.dd",
				onDate: $.datepick.noSundays,
				showTrigger: '#calImg'
			});
		} else {
			typeOptions	+= '<option value="1">2주</option>';
			typeOptions	+= '<option value="2">4주</option>';
			typeOptions	+= '<option value="4">8주</option>';
			if (devlType == "1") {
				$("#devl_date").datepick({ 
					dateFormat: "yyyy.mm.dd",
					onDate: $.datepick.noEven,
					showTrigger: '#calImg'
				});
			} else {
				$("#devl_date").datepick({ 
					dateFormat: "yyyy.mm.dd",
					onDate: $.datepick.noOdd,
					showTrigger: '#calImg'
				});
			}
		}	
		$("#devl_week").html(typeOptions);
	}

	totalPrice	= getTprice();
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("order_write_ajax.jsp", $("#frm_write").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				if (t == 'C') {
					document.location.reload();
				} else {
					location.href = "order_write_step2.jsp?mode=L";
				}
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
					});
				});
			}
		});
	}, "xml");
	return false;
}
</script>
</body>
</html>