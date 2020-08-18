<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String query			= "";
int groupId				= 0;
int price				= 0;
int totalPrice			= 0;
int realPrice			= 0;
int tSalePrice			= 0;
String groupInfo		= "";
String offerNotice		= "";
String groupName		= "";
NumberFormat nf			= NumberFormat.getNumberInstance();
String table			= " ESL_GOODS_GROUP";
String where			= " WHERE GUBUN1 = '01' AND GUBUN2 = '11' AND USE_YN = 'Y'";
String sort				= " ORDER BY ID ASC";

query		= "SELECT ID, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE FROM "+ table + where + sort + " LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");

	totalPrice		= (price * 10) + defaultBagPrice;
	//tSalePrice		= (int)Math.round((double)(price * 10) * (double)(100 - 5) / 100) + defaultBagPrice;
}

rs.close();
pstmt.close();
%>

	<!-- Calendar -->
	<link rel="stylesheet" type="text/css" href="/mobile/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
		<ul class="subnavi">
			<li class="current"><a href="/mobile/shop/dietMeal.jsp">식사다이어트</a></li>
			<li><a href="/mobile/shop/fullStep.jsp">프로그램다이어트</a></li>
			<li><a href="/mobile/shop/secretSoup.jsp">타입별 다이어트</a></li>
		</ul>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<form name="frm_order" id="frm_order" method="post">
		<input type="hidden" name="mode" value="addCart" />
		<input type="hidden" name="cart_type" id="cart_type" />
		<input type="hidden" name="group_id" id="group_id" value="<%=groupId%>" />
		<input type="hidden" name="gubun2" id="gubun2" />
		<input type="hidden" name="price" id="price" value="<%=price%>" />
		<input type="hidden" name="sale_type" id="sale_type" value="P" />
		<input type="hidden" name="sale_price" id="sale_price" value="0" />
		<input type="hidden" name="bag_price" id="bag_price" value="<%=defaultBagPrice%>" />
		<div id="content" style="margin-top:135px;">
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">타입별 다이어트 구매하기</span></span></h1>
			<div class="row bg-gray">
				<ul class="itembox">
					<li>
						<h3>배송가능지역 확인</h3>
						<p>배송가능 지역인지 확인해 주세요.</p>
						<a href="/mobile/shop/popup/deliverypossi.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c iframe"><span class="ui-btn-inner"><span class="ui-btn-text">검색</span></span></a>
					</li>
					<li>
						<ul class="form-line">
							<li>
								<div class="select-box" id="groupSelect">
									<!-- 옵션 선택시 하단에 생성되는 내용이 다름  -->
									<select name="group_code" id="group_code" onchange="selGroup();">
										<option value="간편식- 미니밀">간편식- 미니밀</option>
										<option value="간편식- 라이스">간편식- 라이스</option>
										<option value="간편식- 시크릿수프">간편식- 시크릿수프</option>
										<option value="밸런스쉐이크">밸런스쉐이크</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</li>

					<!-- 1. 미니밀 선택시 생성 -->
					<li>
						<ul class="form-line">
							<li>
								<div class="select-box" id="groupSelect">
									<select name="group_code" id="group_code" onchange="selGroup();">
										<option value="한식메뉴 A">한식메뉴 A</option>
										<option value="양식메뉴 B">양식메뉴 B</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</li>
					<li>
						<h3>첫 배송일 지정</h3>
						<div>
							<input id="devl_date" name="devl_date" class="date-pick" readonly="readonly" />
						</div>	
						<div class="clear"></div>
					</li>
					<li>
						<h3>수량선택</h3>
						<div class="quantity" style="width:100%;">
							<input class="minus" type="button" value="-" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly="readonly" />
							<input class="plus" type="button" value="+" />
						</div>
						<div class="clear"></div>
					</li>
					<li>
						<input name="buy_bag" id="buy_bag" type="checkbox" value="Y" checked="checked" />
						<label for="buy_bag"><span></span><strong class="f16">보냉가방 구매</strong></label>
						<p class="font-green">보냉가방을 필수로 구매하셔야 상품을 신선하게 배송받으실 수 있습니다.</p>
					</li>
					<!-- END // 미니밀 선택시 생성 -->

					<!-- 2. 라이스 선택시 생성 -->
					<li>
						<ul class="form-line">
							<li>
								<div class="select-box" id="groupSelect">
									<select name="group_code" id="group_code" onchange="selGroup();">
										<option value="A: 흑미곤약무밥 2ea">A: 흑미곤약무밥 2ea</option>
										<option value="B: 아마씨드오곡밥 2ea">B: 아마씨드오곡밥 2ea</option>
										<option value="C: 녹차잎귀리밥 2ea">C: 녹차잎귀리밥 2ea</option>
										<option value="D: 검은약콩율무밥 2ea">D: 검은약콩율무밥 2ea</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</li>
					<li>
						<h3>첫 배송일 지정</h3>
						<div>
							<input id="devl_date" name="devl_date" class="date-pick" readonly="readonly" />
						</div>	
						<div class="clear"></div>
					</li>
					<li>
						<h3>수량선택</h3>
						<div class="quantity" style="width:100%;">
							<input class="minus" type="button" value="-" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly="readonly" />
							<input class="plus" type="button" value="+" />
						</div>
						<div class="clear"></div>
					</li>
					<li>
						<input name="buy_bag" id="buy_bag" type="checkbox" value="Y" checked="checked" />
						<label for="buy_bag"><span></span><strong class="f16">보냉가방 구매</strong></label>
						<p class="font-green">보냉가방을 필수로 구매하셔야 상품을 신선하게 배송받으실 수 있습니다.</p>
					</li>
					<!-- END // 라이스 선택시 생성 -->

					<!-- 3. 시크릿수프 선택시 생성 -->
					<li>
						<ul class="form-line">
							<li>
								<div class="select-box" id="groupSelect">
									<select name="group_code" id="group_code" onchange="selGroup();">
										<option value="수프D">수프D</option>
										<option value="수프E">수프E</option>
										<option value="수프F">수프F</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</li>
					<li>
						<h3>배송스타일 선택</h3>
						<ul class="form-line">
							<li>
								<div class="select-box">
									<select name="ss_type" id="ss_type">
										<option value="0">매일(월~토)-총12개/주</option>
										<option value="1">주3회(월수금)-총6개/주</option>
										<option value="2">주3회(화목토)-총6개/주</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</li>
					<li>
						<h3>배송기간 선택</h3>
						<ul class="form-line">
							<li>
								<div class="select-box" id="type_sel">
									<select name="devl_week" id="devl_week" onChange="setTprice();">
										<option value="1">1주</option>
										<option value="2">2주</option>
										<option value="4">4주</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</li>
					<li>
						<h3>첫 배송일 지정</h3>
						<div>
							<input id="devl_date" name="devl_date" class="date-pick" readonly="readonly" />
						</div>	
						<div class="clear"></div>
					</li>
					<li>
						<h3>수량선택</h3>
						<div class="quantity" style="width:100%;">
							<input class="minus" type="button" value="-" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly="readonly" />
							<input class="plus" type="button" value="+" />
						</div>
						<div class="clear"></div>
					</li>
					<li>
						<input name="buy_bag" id="buy_bag" type="checkbox" value="Y" checked="checked" />
						<label for="buy_bag"><span></span><strong class="f16">보냉가방 구매</strong></label>
						<p class="font-green">보냉가방을 필수로 구매하셔야 상품을 신선하게 배송받으실 수 있습니다.</p>
					</li>
					<!-- END // 시크릿수프 선택시 생성 -->

					<!-- 4. 밸런스쉐이크 선택시 생성 -->
					<li>
						<ul class="form-line">
							<li>
								<div class="select-box" id="groupSelect">
									<select name="group_code" id="group_code" onchange="selGroup();">
										<option value="밸런스쉐이크 14포(35*14)">밸런스쉐이크 14포(35*14)</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</li>
					<li>
						<h3>수량선택</h3>
						<div class="quantity" style="width:100%;">
							<input class="minus" type="button" value="-" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly="readonly" />
							<input class="plus" type="button" value="+" />
						</div>
						<div class="clear"></div>
					</li>
					<!-- END // 밸런스쉐이크 선택시 생성 -->
				</ul>
			</div>
			<!--font style="font-weight:bold; color:red;">추석에 송편으로 불어난 내몸, 이제 잇슬림으로 다시 슬림해지자! 최대 20% 할인</font-->
			<dl class="itemlist redline">
				<dt class="f16">총 구매가격</dt>
				<dd class="f16 font-orange" id="tprice">
					<span id="saleDiv" class="hidden">
						<del class="f12 font-brown">
							<span class="tprice"><%=nf.format(totalPrice)%>원</span>
						</del>
						<span id="sprice"><%=nf.format(tSalePrice)%>원</span>
					</span>
					<span id="nosaleDiv">
						<span class="tprice"><%=nf.format(totalPrice)%>원</span>
					</span>
				</dd>
			</dl>
			<div class="grid-navi">
				<table class="navi" border="0" cellspacing="10" cellpadding="0">
					<tr>
						<%if (eslMemberId.equals("")) {%>
						<td><a href="/sso/single_sso.jsp" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">장바구니</span></span></a></td>
						<td><a href="/sso/single_sso.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">바로구매</span></span></a></td>
						<%} else {%>
						<td><a href="javascript:;" onclick="addCart('C');" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">장바구니</span></span></a></td>
						<td><a href="javascript:;" onclick="addCart('L');" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">바로구매</span></span></a></td>
						<%}%>
					</tr>
				</table>
			</div>
		</div>
	</form>
	<!-- End Content -->
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	getSalePrice();

	$(".date-pick").datepick({ 
		dateFormat: "yyyy.mm.dd",
		minDate: +6,
		onDate: $.datepick.noWeekend,
		showTrigger: '#calImg'
	});

	$("#devl_day").change(cngDay);

	$("#devl_week").change(function() {
		totalPrice	= getTprice();
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		getSalePrice()
	});
	$(".plus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty < 9) buyQty		+= 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
		$("#buy_qty").val(buyQty);
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		getSalePrice()
	});
	$(".minus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty > 1) buyQty		= buyQty - 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		$("#buy_qty").val(buyQty);
		getSalePrice()
	});
	$("#buy_bag").click(function() {
		totalPrice	= getTprice();
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		getSalePrice()
	});
	$("#add_goods").change(optionCng);
});

(function($) {
	$.extend($.datepick, {
		noSundays: function(date) {
			return {selectable: date.getDay() != 0};
		},
		noWeekend: function(date) {
			return {selectable: date.getDay() != 0  && date.getDay() != 6};
		}
	});
})(jQuery);

function optionCng() {
	var addPrice	= parseInt($("#add_goods").val());
	totalPrice	= getTprice();
	$(".tprice").text(commaSplit(totalPrice)+ "원");
	getSalePrice()
}

function cngDay() {
	var devlDay		= $("#devl_day").val();
	$(".date-pick").datepick('clear');
	$(".date-pick").datepick('destroy');
	if (devlDay == 5) {
		$(".date-pick").datepick({ 
			dateFormat: "yyyy.mm.dd",
			minDate: +6,
			onDate: $.datepick.noWeekend,
			showTrigger: '#calImg'
		});
	} else {
		$(".date-pick").datepick({ 
			dateFormat: "yyyy.mm.dd",
			minDate: +6,
			onDate: $.datepick.noSundays,
			showTrigger: '#calImg'
		});
	}
	totalPrice	= getTprice();
	$(".tprice").text(commaSplit(totalPrice)+ "원");
	getSalePrice()
}

function cngMenu(num) {
	$.post("dietMeal_ajax.jsp", {
		mode: 'cngMenu',
		cate_id: num
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var menuArr		= "";
				var menuHtml	= "";
				var i			= 0;
				var divNum		= 0;
				var divClass	= "";

				$(data).find("menu").each(function() {
					divNum		= i % 4;
					if (divNum == 0) {
						divClass	= " first";
					} else if (divNum == 3) {
						divClass	= " last";
					} else {
						divClass	= "";
					}

					menuArr			= $(this).text().split("|");
					menuHtml		+= '<div class="food'+ divClass +'">';
					menuHtml		+= '<div>';
					menuHtml		+= '<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id='+ menuArr[0] +'" title="'+ menuArr[2] +'"><img src="'+ menuArr[1] +'" alt="'+ menuArr[2] +'" /></a> ';
					menuHtml		+= '<a class="food-link lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id='+ menuArr[0] +'">';
					menuHtml		+= '<div class="food-calorie">'+ menuArr[3] +'</div>';
					menuHtml		+= '<div class="food-title">'+ menuArr[2] +'</div>';
					menuHtml		+= '</a>';
					menuHtml		+= '</div>';
					menuHtml		+= '</div>';

					$(".quizintab li").removeClass("current");
					$("#titleImg").attr("src", "/images/"+ menuArr[5] +".png");
					$("#topImg1").attr("src", "/images/"+ menuArr[6] +".png");
					$("#topImg2").attr("src", "/images/"+ menuArr[7] +".png");
					$("."+ menuArr[4]).addClass("current");
					if (num == 3) {
						$(".quizinA").css("z-index", "1");
					} else if (num == 2) {
						$(".quizinA").css("z-index", "10");
					}
					i++;
				});

				$(".foodlist").html(menuHtml);
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

function getTprice() {
	var addPrice	= parseInt($("#add_goods").val());
	var buyQty		= parseInt($("#buy_qty").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var totalPrice;
	if (addPrice > 0 ) {
		totalPrice		= (addPrice + parseInt($("#price").val())) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty;
		totalPrice		= totalPrice + parseInt(bag_price);
	} else {
		totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
	}

	return totalPrice;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("dietMeal_ajax.jsp", $("#frm_order").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				if (t == 'C') {
					location.href = "/mobile/shop/cart.jsp";
				} else {
					location.href = "/mobile/shop/order.jsp?mode=L";
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

function getGroup(num) {
	var addPrice;
	if (num > 0) {
		addPrice	= 0;
	} else {
		addPrice	= parseInt($("#add_goods").val());
	}
	$.post("dietMeal_ajax.jsp", {
		mode: 'getGroup',
		gubun2: num
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var addOptions		= '<select name="add_goods" id="add_goods" style="width:140px;" onchange="optionCng();">';
				addOptions		+= '<option value="0" selected="selected">없음</option>';
				addOptions		+= '<option value="2500">매일 밸런스쉐이크1포</option>';
				addOptions		+= "</select>";
				if (num > 1) {
					$("#addOption").addClass("hidden");
					$("#optionSelect").html(addOptions);
					$("#saleDiv").addClass("hidden");
					$("#nosaleDiv").removeClass("hidden");
				} else {
					$("#addOption").removeClass("hidden");
					$("#optionSelect").html(addOptions);
				}
				var groupArr		= "";
				var groupOptions	= '<select name="group_code" id="group_code" class="formsel" onchange="selGroup();">';
				var i				= 0;
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					groupOptions	+= '<option value="'+ groupArr[0] +'">'+ groupArr[1] +"</option>\n";
					if (i == 0) {
						$("#group_id").val(groupArr[0]);
						$("#price").val(groupArr[2]);
						$("#detail-item").html(groupArr[3]);
						$("#detail-notify").html(groupArr[4]);
						totalPrice	= getTprice();
						$(".tprice").text(commaSplit(totalPrice)+ "원");
					}
					i++;
				});
				groupOptions	+= "</select>"
				$("#groupSelect").html(groupOptions);
				getSalePrice()
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$(".ordernum span").removeClass("active");
						$("#group_id").val("");
						$("#price").val(0);
						totalPrice	= getTprice();
						$(".tprice").text(commaSplit(totalPrice)+ "원");
					});
				});
			}
		});
	}, "xml");
	return false;
}

function selGroup() {
	var addPrice		= parseInt($("#add_goods").val());
	var groupCode	= $("#group_code").val();
	$.post("dietMeal_ajax.jsp", {
		mode: 'selGroup',
		group_id: $("#group_code").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var addOptions		= '<select name="add_goods" id="add_goods" style="width:140px;" onchange="optionCng();">';
				addOptions		+= '<option value="0" selected="selected">없음</option>';
				addOptions		+= '<option value="2500">매일 밸런스쉐이크1포</option>';
				addOptions		+= "</select>";
				if (groupCode == 32 || groupCode == 33 || groupCode == 34 || groupCode == 43) {
					$("#addOption").removeClass("hidden");
					$("#optionSelect").html(addOptions);
				} else {
					$("#addOption").addClass("hidden");
					$("#optionSelect").html(addOptions);					
				}
				var groupArr		= "";
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					$("#group_id").val(groupArr[0]);
					$("#price").val(groupArr[1]);
					$("#detail-item").html(groupArr[2]);
					$("#detail-notify").html(groupArr[3]);
					totalPrice	= getTprice();
					$(".tprice").text(commaSplit(totalPrice)+ "원");
					getSalePrice()
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

function getSalePrice() {
	var groupCode	= $("#group_code").val();
	var buyQty		= parseInt($("#buy_qty").val());
	var bagPrice	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var salePrice	= $("#sale_price").val();
	var saleType	= $("#sale_type").val();
	var totalPrice	= getTprice();
	if (parseInt(salePrice) > 0 && saleType) {
		$("#saleDiv").removeClass("hidden");
		$("#nosaleDiv").addClass("hidden");
		if (saleType == "W") {
			salePrice	= (totalPrice - bagPrice) - salePrice + bagPrice;
		} else {
			salePrice	= Math.round(parseFloat(totalPrice - bagPrice) * (100 - parseFloat(salePrice)) / 100) + bagPrice;
		}
		$("#sprice").text(commaSplit(salePrice)+ "원");
	} else {
		$("#saleDiv").addClass("hidden");
		$("#nosaleDiv").removeClass("hidden");
	}
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>