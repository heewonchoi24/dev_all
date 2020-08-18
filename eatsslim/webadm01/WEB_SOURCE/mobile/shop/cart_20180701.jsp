<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
/* int cartId			= 0; */
int groupId			= 0;
int buyQty			= 0;
String devlType		= "";
String devlDay		= "";
String devlWeek		= "";
String devlDate		= "";
String devlPeriod	= "";
int price			= 0;
String buyBagYn		= "";
String gubun1		= "";
String groupName	= "";
String cartImg		= "";
String groupImg		= "";
String imgUrl		= "";
/* int payPrice		= 0; */
//int devlPrice		= 0; // 밸런스쉐이크 택배비
//int devlPrice1		= 0; // 미니밀/라이스 택배비
//int devlPrice2		= 0; // 풀비타 택배비
//int devlPrice3		= 0; // 건강즙 택배비
int bagPrice		= 0;

int cartCt					= 0; //-- 장바구니 전체수
int cartType1TotalPrice		= 0; //-- 일일배송 상품합계
int cartType2TotalPrice		= 0; //-- 택배배송 상품합계
int cartType1Ct				= 0; //-- 일일배송 상품수
int cartType2Ct				= 0; //-- 택배배송 상품수
int cartTotalPrice			= 0; //-- 전체상품합계
int devlPrice				= 0; //-- 배송비
int cartTotalAmount			= 0; //-- 결제예정금액

NumberFormat nf = NumberFormat.getNumberInstance();


if (!eslMemberId.equals("")) {

	query		= "UPDATE ESL_CART SET ORDER_YN = 'N' WHERE MEMBER_ID = '"+ eslMemberId +"'";
	try {
		stmt.executeUpdate(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	//-- 일일배송
	query		= "SELECT COUNT(ID) AS CT,IFNULL(SUM(PRICE),0) AS TOTAL_PRICE FROM ESL_CART WHERE DEVL_TYPE = '0001' AND CART_TYPE = 'C' AND MEMBER_ID = ? ";
	pstmt		= conn.prepareStatement(query);
	pstmt.setString(1, eslMemberId);
	rs		= pstmt.executeQuery();
	if(rs.next()){
		cartType1Ct				 = rs.getInt("CT");
		cartType1TotalPrice		 = rs.getInt("TOTAL_PRICE");
	}
	if (rs != null) try { rs.close(); } catch (Exception e) {}
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

	//-- 택배배송
	query		= "SELECT COUNT(ID) AS CT,IFNULL(SUM(PRICE),0) AS TOTAL_PRICE FROM ESL_CART WHERE DEVL_TYPE = '0002' AND CART_TYPE = 'C' AND MEMBER_ID = ? ";
	pstmt		= conn.prepareStatement(query);
	pstmt.setString(1, eslMemberId);
	rs		= pstmt.executeQuery();
	if(rs.next()){
		cartType2Ct				 = rs.getInt("CT");
		cartType2TotalPrice		 = rs.getInt("TOTAL_PRICE");
	}
	if (rs != null) try { rs.close(); } catch (Exception e) {}
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

	//-- 전체 장바구니수
	cartCt = cartType1Ct + cartType2Ct;

	//-- 상품합계금액
	cartTotalPrice = cartType1TotalPrice + cartType2TotalPrice;

	//-- 배송비
	/* 전체 무료 배송 설정
	if(cartCt > 0 && cartTotalPrice < 40000){
		devlPrice = defaultDevlPrice;
	}
	*/

	//-- 총 결제금액
	cartTotalAmount = cartTotalPrice + devlPrice;
}
%>

	<!-- Calendar -->
	<link rel="stylesheet" type="text/css" href="/mobile/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.ext.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick-ko.js"></script>

<script type="text/javascript">
_TRK_PI="OCV";
</script>
</head>
<body>
<div id="wrap" class="expansioncss">
	<div class="ui-header-fixed" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<form name="frm_order" id="frm_order" method="post">
		<input type="hidden" name="mode" id="mode" value="" />
		<div id="content" class="oldClass">
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">장바구니</span></span></h1>
			<div class="row" id="shopCart">
				<div class="cartListArea">
<%
if(cartCt > 0){
%>
					<div class="orderBox">
						<h1 class="tit">일배상품</h1>
						<ul class="cartList">
<%
	//-- 일일배송
	if(cartType1Ct > 0){
		query		= "SELECT C.ID, C.GROUP_ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK,";
		query		+= "	DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN,";
		query		+= "	G.GUBUN1, G.GROUP_NAME, G.CART_IMG, G.GROUP_IMGM";
		query		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
		query		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = ? AND C.DEVL_TYPE = '0001' AND CART_TYPE = 'C'";
		query		+= " ORDER BY C.DEVL_TYPE";
		pstmt		= conn.prepareStatement(query);
		pstmt.setString(1, eslMemberId);
		rs			= pstmt.executeQuery();

		while (rs.next()) {
			cartId		= rs.getInt("ID");
			groupId		= rs.getInt("GROUP_ID");
			buyQty		= rs.getInt("BUY_QTY");
			devlType	= "일배";
			devlDate	= ut.isnull(rs.getString("WDATE") );
			gubun1		= ut.isnull(rs.getString("GUBUN1") );
			groupName	= ut.isnull(rs.getString("GROUP_NAME") );
			buyBagYn	= ut.isnull(rs.getString("BUY_BAG_YN") );
			devlDay		= ut.isnull(rs.getString("DEVL_DAY") );
			devlWeek	= ut.isnull(rs.getString("DEVL_WEEK") );
			devlPeriod	= devlWeek +"주("+ devlDay +"일)";
			payPrice		= rs.getInt("PRICE");
			if (buyBagYn.equals("Y")) {
				payPrice -= defaultBagPrice;
			}
			price	= (payPrice / buyQty);// * buyQty;
			cartImg		= ut.isnull(rs.getString("CART_IMG") );
			groupImg	= ut.isnull(rs.getString("GROUP_IMGM") );
			if (groupImg.equals("") || groupImg == null) {
				imgUrl		= "/images/order_sample.jpg";
			} else {
				imgUrl		= webUploadDir +"goods/"+ groupImg;
			}
%>
							<li>
								<div class="inner">
									<div class="cartTop">
										<input type="hidden" name="cart_id" value="<%=cartId%>" />
										<input type="hidden" name="devl_date" id="devl_date_<%=cartId%>" value="<%=devlDate%>" />
										<input type="hidden" name="buy_qty" id="buy_qty_<%=cartId%>" value="<%=buyQty%>" />
										<input type="hidden" class="checkSumPrice" value="<%=rs.getInt("PRICE")%>" />
										<input id="day_<%=cartId%>" type="checkbox" class="selectable1" value="<%=cartId%>" onclick="chkSum()" />
										<label for="day_<%=cartId%>">
											<span></span>
										</label>
										<a href="javascript:void(0);" class="cartDelete" onclick="chkDel(<%=groupId%>, 'G');">삭제</a>
										<p class="cate"><%=ut.getGubun1Name(gubun1)%></p>
										<p class="name"><%=groupName%></p>
									</div>
									<div class="cartBody">
										<div class="photo"><img src="<%=imgUrl%>"></div>
										<div class="info">
											<p>식사기간 : <span><%=devlPeriod%></span></p>
											<p>첫 배송일 : <span><%=devlDate%></span></p>
											<p>수량 : <span><%=buyQty%></span></p>
										</div>
									</div>
									<div class="cartbottom">
										<div class="price"><!-- <span>80,000원</span>  --><%=nf.format(payPrice)%>원</div>
									</div>
								</div>
<%
			if (buyBagYn.equals("Y")) {
				bagPrice += defaultBagPrice;// * buyQty;
%>
								<div class="buyBag">
									<div class="bagTit">보냉가방<span>(수량:<strong>1</strong>)</span></div>
									<div class="bagPrice"><%=nf.format(defaultBagPrice)%>원</div>
								</div>
<%
			}
%>
							</li>
<%
		}
		if (rs != null) try { rs.close(); } catch (Exception e) {}
		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
%>
						</ul>
						<div class="cartTotal">
							총 주문 금액 <span id="cartType1TotalPrice"><%=nf.format(cartType1TotalPrice)%></span> 원
						</div>
					</div>
<%
	}

	//-- 택배배송
	if(cartType2Ct > 0){
%>
					<div class="orderBox">
						<h1 class="tit">택배상품</h1>
						<ul class="cartList">
<%
		query		= "SELECT C.ID, C.GROUP_ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK, DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, G.GROUP_IMGM";
		query		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
		query		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = ? AND C.DEVL_TYPE = '0002' AND CART_TYPE = 'C'";
		query		+= " ORDER BY C.DEVL_TYPE";
		pstmt		= conn.prepareStatement(query);
		pstmt.setString(1, eslMemberId);
		rs			= pstmt.executeQuery();

		while (rs.next()) {
			cartId		= rs.getInt("ID");
			groupId		= rs.getInt("GROUP_ID");
			buyQty		= rs.getInt("BUY_QTY");
			devlType	= "택배";
			devlDate	= ut.isnull(rs.getString("WDATE") );
			payPrice	= rs.getInt("PRICE");
			gubun1		= ut.isnull(rs.getString("GUBUN1") );
			groupName	= ut.isnull(rs.getString("GROUP_NAME") );
			cartImg		= ut.isnull(rs.getString("CART_IMG") );
			groupImg	= ut.isnull(rs.getString("GROUP_IMGM") );
			if (groupImg.equals("") || groupImg == null) {
				imgUrl		= "/images/order_sample.jpg";
			} else {
				imgUrl		= webUploadDir +"goods/"+ groupImg;
			}
			price	= payPrice / buyQty;
%>
							<li>
								<div class="inner">
									<div class="cartTop">
										<input type="hidden" name="cart_id" value="<%=cartId%>" />
										<input type="hidden" name="devl_date" id="devl_date_<%=cartId%>" value="<%=devlDate%>" />
										<input type="hidden" name="buy_qty" id="buy_qty_<%=cartId%>" value="<%=buyQty%>" />
										<input type="hidden" class="checkSumPrice" value="<%=rs.getInt("PRICE")%>" />
										<input type="checkbox" id="day_<%=cartId%>" class="selectable2" value="<%=cartId%>" onclick="chkSum()" />
										<label for="day_<%=cartId%>">
											<span></span>
										</label>
										<a href="javascript:void(0);" class="cartDelete" onclick="chkDel(<%=groupId%>, 'G');">삭제</a>
										<p class="cate"><%=ut.getGubun1Name(gubun1)%></p>
										<p class="name"><%=groupName%></p>
									</div>
									<div class="cartBody">
										<div class="photo"><img src="<%=imgUrl%>"></div>
										<div class="info">
											<p>수량 : <span><%=buyQty%></span></p>
										</div>
									</div>
									<div class="cartbottom">
										<div class="price"><!-- <span>80,000원</span>  --><%=nf.format(payPrice)%>원</div>
									</div>
								</div>
							</li>
<%
		}
%>
						</ul>
						<div class="cartTotal">
							총 주문 금액 <span id="cartType2TotalPrice"><%=nf.format(cartType2TotalPrice)%></span> 원
						</div>
					</div>
					<!-- <div class="cartDeleteTotal">
						<a href="javascript:void(0);" onclick="chkDelAll();">전체 삭제</a>
						<a href="javascript:void(0);" onclick="chkDelSelect();">선택 삭제</a>
					</div> -->
<%
	}

}else{
%>
					<div class="cartNoneBox">
						장바구니에 등록된 상품이 없습니다.
					</div>
<%
}
%>
				</div>
<% if(cartCt > 0){ %>
				<div class="totalPriceArea">
					<div class="totalPriceTop">전체 주문 금액</div>
					<div class="totalPriceTable">
						<table>
							<colgroup>
								<col>
								<col>
							</colgroup>
							<tbody>
<%
if(cartCt > 0){
%>
								<tr>
									<th>일배상품</th>
									<td><span id="totalCartType1TotalPrice"><%=nf.format(cartType1TotalPrice)%></span> 원</td>
								</tr>
<%
}
if(cartType2Ct > 0){
%>
								<tr>
									<th>택배상품</th>
									<td><span id="totalCartType2TotalPrice"><%=nf.format(cartType2TotalPrice)%></span> 원</td>
								</tr>
<%
}
%>
							</tbody>
						</table>
					</div>
					<div class="totalPrice">
						총 주문금액 <span id="totalDevlTotalPrice"><%=nf.format(cartTotalAmount)%></span> 원
						<input type="hidden" id="totalPrice" value="<%=cartTotalAmount%>" />
					</div>
					<div class="orderBtns">
						<button type="button" class="btn btn_white square" onclick="chkOrder('S');">선택상품 주문하기</button>
						<button type="button" class="btn btn_dgray square" onclick="chkOrder('A');">전체주문하기</button>
					</div>
				</div>
<% } %>
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
		onDate: $.datepick.noSundays
	});
});

function chkOrder(obj) {
	var chkGoods1	= (obj == 'S')? $(".selectable1:checked") : $(".selectable1");
	var chkGoods2	= (obj == 'S')? $(".selectable2:checked") : $(".selectable2");
	var chkGoods	= parseInt(chkGoods1.length) + parseInt(chkGoods2.length);

	if (chkGoods < 1) {
		var msg		= (obj == 'S')? '선택된 상품이 없습니다.' : '장바구니가 비어있습니다.';
		alert(msg);
	} else {
		if (obj == 'S') {
			$("#mode").val("cartSel");
			var sel_arr			= new Array();
			var devl_date_arr	= new Array();
			var buy_qty_arr		= new Array();
			var i = 0;
			$(".selectable1:checked").each(function() {
				sel_arr[i]		 = $(this).val();
				devl_date_arr[i] = $("#devl_date_"+ $(this).val()).val();
				buy_qty_arr[i]	 = $("#buy_qty_"+ $(this).val()).val();
				i++;
			});
			$(".selectable2:checked").each(function() {
				sel_arr[i]		 = $(this).val();
				devl_date_arr[i] = $("#devl_date_"+ $(this).val()).val();
				buy_qty_arr[i]	 = $("#buy_qty_"+ $(this).val()).val();
				i++;
			});
			var sel_ids_val		= sel_arr.join();
			var devl_date_val	= devl_date_arr.join();
			var buy_qty_val		= buy_qty_arr.join();
			$.post("cart_ajax.jsp", {
				mode: "cartSel",
				cart_ids: sel_ids_val,
				devl_dates: devl_date_val,
				buy_qtys: buy_qty_val
			},
			function(data) {
				$(data).find('result').each(function() {
					if ($(this).text() == 'success') {
						location.href = "order.jsp?mode=C&oyn=Y";
					} else {
						$(data).find('error').each(function() {
							alert($(this).text());
						});
					}
				});
			}, "xml");
		} else {
			$("#mode").val("cartAll");
			$.post("cart_ajax.jsp", $("#frm_order").serialize(),
			function(data) {
				$(data).find("result").each(function() {
					if ($(this).text() == "success") {
						location.href = "order.jsp?mode=C";
					} else {
						$(data).find("error").each(function() {
							$(data).find("error").each(function() {
								alert($(this).text());
							});
						});
					}
				});
			}, "xml");
		}
	}
}

function chkDel(obj1, obj2) {
	$.post("cart_ajax.jsp", {
		mode: 'del',
		cartId: obj1,
		bag_yn: obj2
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				document.location.reload();
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function chkDelAll() {

}

function chkDelSelect() {

}


function chkSum(){
	var cartType1TotalPrice = 0;
	var cartType2TotalPrice = 0;
	$(".selectable1:checked").each(function() {
		cartType1TotalPrice += parseInt($(this).closest(".cartTop").find(".checkSumPrice").val(),10);
	});
	$(".selectable2:checked").each(function() {
		cartType2TotalPrice += parseInt($(this).closest(".cartTop").find(".checkSumPrice").val(),10);
	});

	console.log(cartType1TotalPrice, cartType2TotalPrice);

	//-- 선택한것이 없다면 전체 금액을 보여준다.
	if(cartType1TotalPrice == 0 && cartType2TotalPrice == 0){
		$("#cartType1TotalPrice").html(totalComma(<%=cartType1TotalPrice%>));
		$("#cartType2TotalPrice").html(totalComma(<%=cartType2TotalPrice%>));


		$("#totalCartType1TotalPrice").html(totalComma(<%=cartType1TotalPrice%>));
		$("#totalCartType2TotalPrice").html(totalComma(<%=cartType2TotalPrice%>));
		$("#totalDevlTotalPrice").html(totalComma(<%=cartTotalAmount%>));
		$("#totalPrice").val(<%=cartTotalAmount%>);
	}
	else{
		$("#cartType1TotalPrice").html(totalComma(cartType1TotalPrice));
		$("#cartType2TotalPrice").html(totalComma(cartType2TotalPrice));


		$("#totalCartType1TotalPrice").html(totalComma(cartType1TotalPrice));
		$("#totalCartType2TotalPrice").html(totalComma(cartType2TotalPrice));
		$("#totalDevlTotalPrice").html(totalComma(cartType1TotalPrice + cartType2TotalPrice));
		$("#totalPrice").val((cartType1TotalPrice + cartType2TotalPrice));

	}
}
//콤마 가격 붙여주기
function totalComma(total){
	total = total + "";
	point = total.length % 3 ;
	len = total.length;
	str = total.substring(0, point);
	while (point < len) {
	    if (str != "") str += ",";
	    str += total.substring(point, point + 3);
	    point += 3;
	}
	return str;
}
</script>

<!-- 미디어큐브 픽셀 Start 2016.03.15 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=980597&mt_adid=158356&v1=&v2=&v3=&s1=&s2=&s3='></script>
<!-- 미디어큐브 픽셀 End -->
</body>
</html>
