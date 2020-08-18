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
			<li class="current"><a href="/mobile/shop/dietMeal.jsp">�Ļ���̾�Ʈ</a></li>
			<li><a href="/mobile/shop/reductionProgram.jsp">���α׷����̾�Ʈ</a></li>
			<li><a href="/mobile/shop/secretSoup.jsp">Ÿ�Ժ� ���̾�Ʈ</a></li>
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
		<div id="content" style="margin-top:135px;">
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">�Ļ� ���̾�Ʈ ��ǰ����</span></span></h1>
			<div class="row bg-gray">
				<ul class="itembox">
					<li>
						<h3>��۰������� Ȯ��</h3>
						<p>��۰��� �������� Ȯ���� �ּ���.</p>
						<a href="/mobile/shop/popup/deliverypossi.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c iframe"><span class="ui-btn-inner"><span class="ui-btn-text">�˻�</span></span></a>
					</li>
					<li>
						<h3>1�� ��޽ļ� ����</h3>
						<div class="ordernum">
							<input type="radio" id="gubun11" name="gubun" value="1" checked="checked" onclick="getGroup(this.value);" />
							<label for="gubun11">1��1��</label>
							<input type="radio" id="gubun21" name="gubun" value="2" onclick="getGroup(this.value);" />
							<label for="gubun21">1��2��</label>
							<input type="radio" id="gubun31" name="gubun" value="3" onclick="getGroup(this.value);" />
							<label for="gubun31">1��3��</label>
							<div class="clear"></div>
						</div>
					</li>
					<li>
						<h3>���ϳ��ϼ��� �Ļ罺Ÿ���� ����</h3>
						<ul class="form-line">
							<li>
								<div class="select-box" id="groupSelect">
									<select name="group_code" id="group_code" onchange="selGroup();">
										<%
										query		= "SELECT ID, GROUP_NAME FROM  "+ table + where + sort;
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											groupId			= rs.getInt("ID");
											groupName		= rs.getString("GROUP_NAME");
										%>
										<option value="<%=groupId%>"><%=groupName%></option>
										<%
										}
										%>
									</select>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</li>
					<li>
						<h3>�Ļ� �Ⱓ�� ����</h3>
						<ul class="form-line ui-inline2">
							<li style="margin-right:5px;">
								<div class="select-box">
									<select name="devl_day" id="devl_day">
										<option value="5" selected="selected">5��</option>
									</select>
								</div>
							</li>
							<li>
								<div class="select-box">
									<select name="devl_week" id="devl_week">
										<option value="2" selected="selected">2��</option>
										<option value="4">4��</option>
									</select>
								</div>
							</li>
							<div class="clear"></div>
						</ul>
					</li>
					<li>
						<h3>ù ����� ����</h3>
						<div>
							<input id="devl_date" name="devl_date" class="date-pick" readonly="readonly" />
						</div>	
						<div class="clear"></div>
					</li>
					<li>
						<h3>��������</h3>
						<div class="quantity" style="width:100%;">
							<input class="minus" type="button" value="-" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly="readonly" />
							<input class="plus" type="button" value="+" />
						</div>
						<div class="clear"></div>
					</li>
					<li>
						<input name="buy_bag" id="buy_bag" type="checkbox" value="Y" checked="checked" />
						<label for="buy_bag"><span></span><strong class="f16">���ð��� ����</strong></label>
						<p class="font-green">���ð����� �ʼ��� �����ϼž� ��ǰ�� �ż��ϰ� ��۹����� �� �ֽ��ϴ�.</p>
					</li>
				</ul>
			</div>
			<dl class="itemlist redline">
				<dt class="f16">�� ���Ű���</dt>
				<dd class="f16 font-orange" id="tprice">
					<%=nf.format(totalPrice)%>��
					<!--del class="f12 font-brown">119,400��</del-->
				</dd>
			</dl>
			<div class="grid-navi">
				<table class="navi" border="0" cellspacing="10" cellpadding="0">
					<tr>
						<%if (eslMemberId.equals("")) {%>
						<td><a href="/mobile/shop/mypage/login.jsp" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">��ٱ���</span></span></a></td>
						<td><a href="/mobile/shop/mypage/login.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�ٷα���</span></span></a></td>
						<%} else {%>
						<td><a href="javascript:;" onclick="addCart('C');" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">��ٱ���</span></span></a></td>
						<td><a href="javascript:;" onclick="addCart('L');" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�ٷα���</span></span></a></td>
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
	$(".date-pick").datepick({ 
		dateFormat: "yyyy.mm.dd",
		minDate: +6,
		onDate: $.datepick.noWeekend,
		showTrigger: '#calImg'
	});

	$("#devl_day").change(cngDay);

	$("#devl_week").change(function() {
		totalPrice	= getTprice();
		$("#tprice").text(commaSplit(totalPrice)+ "��");
	});
	$(".plus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty < 9) buyQty		+= 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? 7000 * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
		$("#buy_qty").val(buyQty);
		$("#tprice").text(commaSplit(totalPrice)+ "��");
	});
	$(".minus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty > 1) buyQty		= buyQty - 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? 7000 * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
		$("#tprice").text(commaSplit(totalPrice)+ "��");
		$("#buy_qty").val(buyQty);
	});
	$("#buy_bag").click(function() {
		totalPrice	= getTprice();
		$("#tprice").text(commaSplit(totalPrice)+ "��");
	});
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
	$("#tprice").text(commaSplit(totalPrice)+ "��");
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
	var buyQty		= parseInt($("#buy_qty").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? 7000 * buyQty : 0;
	var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);

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
	$.post("dietMeal_ajax.jsp", {
		mode: 'getGroup',
		gubun2: num
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
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
						$("#tprice").text(commaSplit(totalPrice)+ "��");
					}
					i++;
				});
				groupOptions	+= "</select>"
				$("#groupSelect").html(groupOptions);
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$(".ordernum span").removeClass("active");
						$("#group_id").val("");
						$("#price").val(0);
						totalPrice	= getTprice();
						$("#tprice").text(commaSplit(totalPrice)+ "��");
					});
				});
			}
		});
	}, "xml");
	return false;
}

function selGroup() {
	$.post("dietMeal_ajax.jsp", {
		mode: 'selGroup',
		group_id: $("#group_code").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					$("#group_id").val(groupArr[0]);
					$("#price").val(groupArr[1]);
					$("#detail-item").html(groupArr[2]);
					$("#detail-notify").html(groupArr[3]);
					totalPrice	= getTprice();
					$("#tprice").text(commaSplit(totalPrice)+ "��");
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
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>