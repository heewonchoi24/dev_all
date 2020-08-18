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
String where			= " WHERE GUBUN1 = '02' AND GUBUN2 = '24'";
String sort				= " ORDER BY ID ASC";

query		= "SELECT ID, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE FROM "+ table + where + sort + " LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");

	totalPrice		= price + defaultBagPrice;
}

rs.close();
pstmt.close();
%>

	<link rel="stylesheet" type="text/css" href="/mobile/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.ext.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
		<ul class="subnavi">
			<li><a href="/mobile/shop/dietMeal.jsp">�Ļ���̾�Ʈ</a></li>
			<li class="current"><a href="/mobile/shop/reductionProgram.jsp">���α׷����̾�Ʈ</a></li>
			<li><a href="/mobile/shop/secretSoup.jsp">Ÿ�Ժ����̾�Ʈ</a></li>
		</ul>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<form name="frm_order" id="frm_order" method="post">
		<input type="hidden" name="mode" value="addCart" />
		<input type="hidden" name="cart_type" id="cart_type" />
		<input type="hidden" name="group_id" id="group_id" value="<%=groupId%>" />
		<input type="hidden" name="price" id="price" value="<%=price%>" />
		<input type="hidden" name="sale_type" id="sale_type" value="%" />
		<input type="hidden" name="sale_price" id="sale_price" value="0" />
		<div id="content" style="margin-top:135px;">
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">���̾�Ʈ ���α׷� ��ǰ����</span></span></h1>
			<div class="row bg-gray">
				<ul class="itembox">
					<li>
						<h3>��۰������� Ȯ��</h3>
						<p>��۰��� �������� Ȯ���� �ּ���.</p>
						<a href="/mobile/shop/popup/deliverypossi.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c iframe"><span class="ui-btn-inner"><span class="ui-btn-text">�˻�</span></span></a>
					</li>
					<li>
						<h3>���α׷� ���� ����</h3>
						<ul class="form-line">
							<li>
								<div class="select-box">
									<select name="gubun2" id="gubun2">
										<option value="24">New Full-Step ���α׷�</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</li>
					<li>
						<h3>�Ļ� �Ⱓ�� ����</h3>
						<ul class="form-line ui-inline2">
							<li>
								<div class="select-box">
									<select name="gubun3" id="gubun3">
										<option value="4">4�ְ�</option>
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
				<dd class="f16 font-orange">
					<span id="saleDiv" class="hidden">
						<del class="f12 font-brown">
							<span class="tprice"><%=nf.format(totalPrice)%>��</span>
						</del>
						<span id="sprice"><%=nf.format(tSalePrice)%>��</span>
					</span>
					<span id="nosaleDiv">
						<span class="tprice"><%=nf.format(totalPrice)%>��</span>
					</span>
				</dd>
			</dl>
			<div class="grid-navi">
				<table class="navi" border="0" cellspacing="10" cellpadding="0">
					<tr>
						<%if (eslMemberId.equals("")) {%>
						<td><a href="/mobile/shop/mypage/login.jsp" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">��ٱ���</span></span></a></td>
						<td><a href="/mobile/shop/mypage/login.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�ٷα���</span></span></a></td>
						<%} else {%>
						<td><a href="javascript:;" onClick="addCart('C');" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">��ٱ���</span></span></a></td>
						<td><a href="javascript:;" onClick="addCart('L');" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�ٷα���</span></span></a></td>
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
		onDate: $.datepick.noWeekends,
		showTrigger: '#calImg'
	});

	$(".plus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty < 9) buyQty		+= 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? 7000 * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * buyQty + parseInt(bag_price);
		$("#buy_qty").val(buyQty);
		$(".tprice").text(commaSplit(totalPrice)+ "��");
	});
	$(".minus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty > 1) buyQty		= buyQty - 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? 7000 * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * buyQty + parseInt(bag_price);
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		$("#buy_qty").val(buyQty);
	});
	$("#buy_bag").click(function() {
		totalPrice	= getTprice();
		$(".tprice").text(commaSplit(totalPrice)+ "��");
	});
});

function getTprice() {
	var buyQty		= parseInt($("#buy_qty").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? 7000 * buyQty : 0;
	var totalPrice	= parseInt($("#price").val()) * buyQty + parseInt(bag_price);

	return totalPrice;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("dietProgram_ajax.jsp", $("#frm_order").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				if (t == 'C') {
					location.href = "cart.jsp";
				} else {
					location.href = "order.jsp?mode=L";
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

function getGroup() {
	var gubun2Val		= $("#gubun2").val();
	var gubun3Val		= $("#gubun3").val()

	if (gubun2Val == "21") {
		newOptions	= {
			'2' : '2�ְ�',
			'4' : '4�ְ�'
		}

		selectedOption = gubun3Val;
	} else if (gubun2Val == "22") {
		newOptions	= {
			'2' : '2�ְ�'
		}
		selectedOption = "2";
	} else if (gubun2Val == "23") {
		newOptions	= {
			'4' : '4�ְ�'
		}
		selectedOption = "4";
	}
	makeOption(newOptions, $("#gubun3"), selectedOption);

	$.post("dietProgram_ajax.jsp", {
		mode: 'getGroup',
		gubun2: gubun2Val,
		gubun3: $("#gubun3").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				var i				= 0;
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					if (i == 0) {
						$("#group_id").val(groupArr[0]);
						$("#price").val(groupArr[2]);
						$("#detail-item").html(groupArr[3]);
						$("#detail-notify").html(groupArr[4]);
						totalPrice	= getTprice();
						$(".tprice").text(commaSplit(totalPrice)+ "��");
					}
					i++;
				});
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$(".ordernum span").removeClass("active");
						$("#group_id").val("");
						$("#price").val(0);
						totalPrice	= getTprice();
						$(".tprice").text(commaSplit(totalPrice)+ "��");
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