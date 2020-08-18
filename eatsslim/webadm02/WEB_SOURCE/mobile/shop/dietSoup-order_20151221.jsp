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
String groupCode		= "";
String offerNotice		= "";
String groupName		= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
String saleTitle = 	"";
String saleType = 	"";
int salePrice = 	0;
String useGoods = 	"";
NumberFormat nf			= NumberFormat.getNumberInstance();
String table			= " ESL_GOODS_GROUP";
String where			= " WHERE GUBUN1 = '03' AND GUBUN2 = '31'";
String sort				= " ORDER BY ID DESC";

query		= "SELECT ID, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE, GROUP_CODE FROM "+ table + where + sort + " LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");
	groupCode		= rs.getString("GROUP_CODE");

	totalPrice		= price * 6 + defaultBagPrice;
	
	String where1			= " WHERE  ('"+today+"' BETWEEN STDATE AND LTDATE) AND (GROUP_CODE = '"+groupCode+"'  or GROUP_CODE is null) ";
	String sort1			=  " ORDER BY ES.ID DESC";
	query		= "SELECT TITLE, SALE_TYPE, SALE_PRICE, USE_GOODS FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID " + where1 + sort1 + " LIMIT 0, 1";
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();

	if (rs.next()) {		
		saleTitle			= rs.getString("TITLE");
		saleType			= rs.getString("SALE_TYPE");
		salePrice		= rs.getInt("SALE_PRICE");
		useGoods		= rs.getString("USE_GOODS");
		
		if (saleType.equals("P")) {
			tSalePrice		= (int)Math.round((double)(price * 10) * (double)(100 - salePrice) / 100) + defaultBagPrice;
		} else {
			tSalePrice		= (int)Math.round((double)( (price - salePrice) * 10)) + defaultBagPrice;
		}
		
	}	
}

rs.close();
pstmt.close();
%>

	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
		<ul class="subnavi">
			<li><a href="/mobile/shop/dietMeal.jsp">�Ļ���̾�Ʈ</a></li>
			<li><a href="/mobile/shop/weight2weeks.jsp">���α׷����̾�Ʈ</a></li>
			<li class="current"><a href="/mobile/shop/minimeal.jsp">Ÿ�Ժ����̾�Ʈ</a></li>
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
		<input type="hidden" name="devl_day" id="devl_day" value="6" />
		<input type="hidden" name="sale_type" id="sale_type" value="<%=saleType%>" />
		<input type="hidden" name="sale_price" id="sale_price" value="<%=salePrice%>" />
		<input type="hidden" name="bag_price" id="bag_price" value="<%=defaultBagPrice%>" />
		<div id="content" style="margin-top:135px;">
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">��ũ������ ��ǰ����</span></span></h1>
			<div class="row bg-gray">
				<ul class="itembox">
					<li>
						<h3>��۰������� Ȯ��</h3>
						<p>��۰��� �������� Ȯ���� �ּ���.</p>
						<a href="/mobile/shop/popup/deliverypossi.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c iframe"><span class="ui-btn-inner"><span class="ui-btn-text">�˻�</span></span></a>
					</li>
					<li>
						<h3>��۽�Ÿ�� ����</h3>
						<ul class="form-line">
							<li>
								<div class="select-box">
									<select name="ss_type" id="ss_type">
										<option value="0">����(��~��)-��12��/��</option>
										<option value="1">��3ȸ(������)-��6��/��</option>
										<option value="2">��3ȸ(ȭ����)-��6��/��</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</li>
					<li>
						<h3>��۱Ⱓ ����</h3>
						<ul class="form-line">
							<li>
								<div class="select-box" id="type_sel">
									<select name="devl_week" id="devl_week" onChange="setTprice();">
										<option value="1">1��</option>
										<option value="2">2��</option>
										<option value="4">4��</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
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
			<font name="saleTitle" id="saleTitle" style="font-weight:bold; color:blue;" class="<% if ( saleTitle.equals("") )  { out.println("hidden"); }%>"><%=saleTitle%></font>
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
						<td><a href="/sso/single_sso.jsp" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">��ٱ���</span></span></a></td>
						<td><a href="/sso/single_sso.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�ٷα���</span></span></a></td>
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
	setTprice();

	$(".date-pick").datepick({ 
		dateFormat: "yyyy.mm.dd",
		minDate: +6,
		onDate: $.datepick.noSundays,
		showTrigger: '#calImg'
	});
	$("a").attr("onfocus", "this.blur()");
	$("#ss_type").change(cngWeek);
	$(".plus").click(function() {
		var devl_day	= $("#devl_day").val();
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty < 9) buyQty		+= 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt(devl_day) * buyQty + parseInt(bag_price);
		$("#buy_qty").val(buyQty);
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		getSalePrice();
	});
	$(".minus").click(function() {
		var devl_day	= $("#devl_day").val();
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty > 1) buyQty		= buyQty - 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt(devl_day) * buyQty + parseInt(bag_price);
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		$("#buy_qty").val(buyQty);
		getSalePrice();
	});
	$("#buy_bag").click(setTprice);
});

(function($) {
	$.extend($.datepick, {
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
	var devl_day	= $("#devl_day").val();
	var buyQty		= parseInt($("#buy_qty").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt(devl_day) * buyQty + parseInt(bag_price);

	return totalPrice;
}

function setTprice() {
	totalPrice	= getTprice();
	$(".tprice").text(commaSplit(totalPrice)+ "��");
	getSalePrice();
}

function cngWeek() {
	var devlType		= $("#ss_type").val();
	var typeOptions	= '<select name="devl_week" id="devl_week" onchange="setTprice();">';
	$(".date-pick").datepick('clear');
	$(".date-pick").datepick('destroy');
	if (devlType == "0") {
		typeOptions	+= '<option value="1">1��</option>';
		typeOptions	+= '<option value="2">2��</option>';
		typeOptions	+= '<option value="4">4��</option>';
		$(".date-pick").datepick({ 
			dateFormat: "yyyy.mm.dd",
			minDate: +6,
			onDate: $.datepick.noSundays,
			showTrigger: '#calImg'
		});
	} else {
		typeOptions	+= '<option value="1">2��</option>';
		typeOptions	+= '<option value="2">4��</option>';
		typeOptions	+= '<option value="4">8��</option>';
		if (devlType == "1") {
			$(".date-pick").datepick({ 
				dateFormat: "yyyy.mm.dd",
				minDate: +6,
				onDate: $.datepick.noEven,
				showTrigger: '#calImg'
			});
		} else {
			$(".date-pick").datepick({ 
				dateFormat: "yyyy.mm.dd",
				minDate: +6,
				onDate: $.datepick.noOdd,
				showTrigger: '#calImg'
			});
		}		
	}

	typeOptions	+= "</select>"
	$("#type_sel").html(typeOptions);
	setTprice();
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("dietSoup_ajax.jsp", $("#frm_order").serialize(),
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

function getSalePrice() {
	var buyQty		= parseInt($("#buy_qty").val());
	var bagPrice	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var salePrice	= $("#sale_price").val();
	var saleType	= $("#sale_type").val();
	var totalPrice	= getTprice();
	if (parseInt(salePrice) > 0 && saleType) {
		$("#saleDiv").removeClass("hidden");
		$("#nosaleDiv").addClass("hidden");
		if (saleType == "W") {
			salePrice	= (totalPrice - bagPrice) - salePrice * buyQty + bagPrice;
		} else {
			salePrice	= Math.round(parseFloat(totalPrice - bagPrice) * (100 - parseFloat(salePrice)) / 100) + bagPrice;
		}
		$("#sprice").text(commaSplit(salePrice)+ "��");
	} else {
		$("#saleDiv").addClass("hidden");
		$("#nosaleDiv").removeClass("hidden");
	}
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>