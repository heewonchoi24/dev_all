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
String groupCode		= "";
String offerNotice		= "";
int categoryId			= 0;
String categoryName		= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
String saleTitle = 	"";
String saleType = 	"";
int salePrice = 	0;
String useGoods = 	"";
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT ID, GROUP_NAME, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE, GROUP_CODE FROM ESL_GOODS_GROUP WHERE GUBUN1 = '03' AND GUBUN2 = '33' AND USE_YN = 'Y' ORDER BY ID LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	groupName		= rs.getString("GROUP_NAME");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");
	groupCode		= rs.getString("GROUP_CODE");

	totalPrice		= price * 2;
	
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

</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
		<ul class="subnavi">
			<li><a href="/mobile/shop/dietMeal.jsp">식사다이어트</a></li>
			<li><a href="/mobile/shop/weight2weeks.jsp">프로그램다이어트</a></li>
			<li class="current"><a href="/mobile/shop/minimeal.jsp">타입별다이어트</a></li>
			<li><a href="/mobile/shop/dietCLA.jsp">풀비타</a></li>
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
		<input type="hidden" name="sale_type" id="sale_type" value="<%=saleType%>" />
		<input type="hidden" name="sale_price" id="sale_price" value="<%=salePrice%>" />
		<input type="hidden" name="buy_qty" id="buy_qty" value="2" />
		<div id="content" style="margin-top:135px;">
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">잇슬림 미니밀 제품구매</span></span></h1>
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
							한식 세트(A)<br />
							<input class="minus" type="button" value="-" onclick="setMinus(1);" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty1" id="buy_qty1" readonly="readonly" />
							<input class="plus" type="button" value="+" onclick="setPlus(1);" />
						</div>
						<div class="quantity" style="width:100%;">
							양식 세트(B)<br />
							<input class="minus" type="button" value="-" onclick="setMinus(2);" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty2" id="buy_qty2" readonly="readonly" />
							<input class="plus" type="button" value="+" onclick="setPlus(2);" />
						</div>
						<div class="clear"></div>
					</li>
				</ul>
			</div>
			<font name="saleTitle" id="saleTitle" style="font-weight:bold; color:red;" class="<% if ( saleTitle.equals("") )  { out.println("hidden"); }%>"><%=saleTitle%></font>
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
	if (tcnt < 2) {
		alert("최소 주문은 2Set부터 가능합니다.");
		$("#buy_qty"+ obj).val(buyQty + 1);
	}

	tcnt	= setTcnt();
	var totalPrice	= parseInt($("#price").val()) * tcnt;
	$(".tprice").text(commaSplit(totalPrice)+ "원");
	getSalePrice();
}

function setTcnt() {
	var tcnt	= parseInt($("#buy_qty1").val()) + parseInt($("#buy_qty2").val());
	$("#buy_qty").val(tcnt);

	return tcnt;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("minimeal_ajax.jsp", $("#frm_order").serialize(),
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
			salePrice	= totalPrice - salePrice * buyQty;
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