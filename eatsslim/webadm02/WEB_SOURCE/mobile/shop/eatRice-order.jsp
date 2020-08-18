<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String query			= "";
int groupId				= 0;
String groupName		= "";
int totalPrice			= 0;
int tSalePrice			= 0;
int price				= 0;
String groupInfo		= "";
String offerNotice		= "";
int categoryId			= 0;
String categoryName		= "";
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT ID, GROUP_NAME, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE FROM ESL_GOODS_GROUP WHERE GUBUN1 = '03' AND GUBUN2 = '34' AND USE_YN = 'Y' ORDER BY ID LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	groupName		= rs.getString("GROUP_NAME");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");

	totalPrice		= price * 3;
}

rs.close();
pstmt.close();
%>

</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
		<ul class="subnavi">
			<li><a href="/mobile/shop/dietMeal.jsp">식사다이어트</a></li>
			<li><a href="/mobile/shop/weight2weeks.jsp">프로그램다이어트</a></li>
			<li class="current"><a href="/mobile/shop/minimeal.jsp">타입별다이어트</a></li>
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
		<input type="hidden" name="buy_qty" id="buy_qty" value="3" />
		<div id="content" style="margin-top:135px;">
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">잇슬림 라이스 제품구매</span></span></h1>
			<div class="row bg-gray">
				<ul class="itembox">
					<li>
						<h3>배송가능지역 확인</h3>
						<p>배송가능 지역인지 확인해 주세요.</p>
						<a href="/mobile/shop/popup/deliverypossi.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c iframe"><span class="ui-btn-inner"><span class="ui-btn-text">검색</span></span></a>
					</li>
					<li>
						<h3>수량선택</h3>
						<div class="quantity" style="width:100%;">
							A: 흑미곤약무밥 2ea<br />
							<input class="minus" type="button" value="-" onclick="setMinus(1);" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty1" id="buy_qty1" readonly="readonly" />
							<input class="plus" type="button" value="+" onclick="setPlus(1);" />
						</div>
						<div class="quantity" style="width:100%;">
							B: 아마씨드오곡밥 2ea<br />
							<input class="minus" type="button" value="-" onclick="setMinus(2);" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty2" id="buy_qty2" readonly="readonly" />
							<input class="plus" type="button" value="+" onclick="setPlus(2);" />
						</div>
						<div class="quantity" style="width:100%;">
							C: 녹차잎귀리밥 2ea<br />
							<input class="minus" type="button" value="-" onclick="setMinus(3);" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty3" id="buy_qty3" readonly="readonly" />
							<input class="plus" type="button" value="+" onclick="setPlus(3);" />
						</div>
						<div class="quantity" style="width:100%;">
							D: 검은콩율무밥 2ea<br />
							<input class="minus" type="button" value="-" onclick="setMinus(4);" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="0" data-max="0" data-min="1" name="buy_qty4" id="buy_qty4" readonly="readonly" />
							<input class="plus" type="button" value="+" onclick="setPlus(4);" />
						</div>
						<div class="clear"></div>
					</li>
				</ul>
			</div>
			<!--font style="font-weight:bold; color:red;">잇슬림 구매 고객 5만명 돌파 기념! 전제품 5% 할인!(~6/5)</font-->
			<dl class="itemlist redline">
				<dt class="f16">총 구매가격</dt>
				<dd class="f16 font-orange">
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
						<td><a href="javascript:;" onClick="addCart('C');" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">장바구니</span></span></a></td>
						<td><a href="javascript:;" onClick="addCart('L');" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">바로구매</span></span></a></td>
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
});

function setPlus(obj) {
	var totalPrice	= 0;	
	var buyQty		= parseInt($("#buy_qty"+ obj).val());
	if (buyQty < 9) buyQty		+= 1;
	$("#buy_qty"+ obj).val(buyQty);
	var tcnt	= setTcnt();
	var totalPrice	= parseInt($("#price").val()) * tcnt;
	$(".tprice").text(commaSplit(totalPrice)+ "원");
	getSalePrice();
}

function setMinus(obj) {
	var totalPrice	= 0;	
	var buyQty		= parseInt($("#buy_qty"+ obj).val());
	if (buyQty > 0) buyQty		= buyQty - 1;
	$("#buy_qty"+ obj).val(buyQty);
	var tcnt	= setTcnt();
	if (tcnt < 3) {
		alert("최소 주문은 3Set부터 가능합니다.");
		$("#buy_qty"+ obj).val(buyQty + 1);
	}

	tcnt	= setTcnt();
	var totalPrice	= parseInt($("#price").val()) * tcnt;
	$(".tprice").text(commaSplit(totalPrice)+ "원");
	getSalePrice();
}

function setTcnt() {
	var tcnt	= parseInt($("#buy_qty1").val()) + parseInt($("#buy_qty2").val()) + parseInt($("#buy_qty3").val()) + parseInt($("#buy_qty4").val());
	$("#buy_qty").val(tcnt);

	return tcnt;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("eatRice_ajax.jsp", $("#frm_order").serialize(),
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
	var salePrice	= $("#sale_price").val();
	var saleType	= $("#sale_type").val();
	var totalPrice	= parseInt($("#price").val()) * buyQty;
	if (parseInt(salePrice) > 0 && saleType) {
		$("#saleDiv").removeClass("hidden");
		$("#nosaleDiv").addClass("hidden");
		if (saleType == "W") {
			salePrice	= totalPrice - salePrice;
		} else {
			salePrice	= Math.round(parseFloat(totalPrice) * (100 - parseFloat(salePrice)) / 100);
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