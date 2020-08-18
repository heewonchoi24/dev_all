<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%
int ftCartTotalPrice		= 0; //-- 상품전체 합계
int ftDevlPrice				= 0; //-- 배송비
int ftCartTotalAmount		= 0; //-- 결제금액
int ftCartCt				= 0; //-- 장바구니갯수

String ftQuery				= "";
PreparedStatement ftPstmt	= null;
ResultSet ftRs				= null;
if (!eslMemberId.equals("")) {

	//-- 장바구니
	ftQuery		= "SELECT COUNT(ID) AS CT,IFNULL(SUM(PRICE),0) AS TOTAL_PRICE FROM ESL_CART WHERE CART_TYPE = 'C' AND MEMBER_ID = ? ";
	ftPstmt		= conn.prepareStatement(ftQuery);
	ftPstmt.setString(1, eslMemberId);
	ftRs		= ftPstmt.executeQuery();
	if(ftRs.next()){
		ftCartCt = ftRs.getInt("CT");
		ftCartTotalPrice = ftRs.getInt("TOTAL_PRICE");
	}
	if (ftRs != null) try { ftRs.close(); } catch (Exception e) {}
	if (ftPstmt != null) try { ftPstmt.close(); } catch (Exception e) {}

	//-- 장바구니 총 금액
	if(ftCartCt > 0 && ftCartTotalPrice < 40000){
		ftDevlPrice = defaultDevlPrice;
	}
	ftCartTotalAmount = ftCartTotalPrice + ftDevlPrice;
}
%>

<% if ( !"".equals(eslMemberId) && ftCartCt > 0 ) { %>
<div class="cart_summary">
	<div class="btn_toggle"><button type="button" onclick="cartFn.onFold();"><img src="/mobile/common/images/common/ico_cart_toggle.png" alt=""></button></div>

	<div class="notice_area">
		<dl class="goods_count">
			<dt><img src="/mobile/common/images/common/ico_cart.png" alt=""></dt>
			<dd><span id="cart_qty"><%=ut.getComma(ftCartCt)%></span>개</dd>
		</dl>
		<!-- <dl class="pay_count">
			<dt>총 상품 금액</dt>
			<%-- <dd><span id="cart_price"><%=nf.format(totalPrice1)%></span> 원</dd> --%>
			<dd><span id="cart_price"></span> 원</dd>
		</dl> -->
	</div>
	<div class="button_area">
		<!-- <button type="button" onclick="chkOrder('A');">바로 구매</button> -->
		<button type="button" onclick="location.href='/mobile/shop/cart.jsp';">주문하기</button>
	</div>
</div>
<div class="cart_detail">
<%
if(ftCartCt > 0){
	ftQuery		= "SELECT C.ID, C.GROUP_ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK,";
	ftQuery		+= "	DATE_FORMAT(C.DEVL_DATE, '%Y-%m-%d') WDATE, C.PRICE, C.BUY_BAG_YN,";
	ftQuery		+= "	G.GUBUN1, G.GROUP_NAME, G.CART_IMG, G.GROUP_IMGM";
	ftQuery		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
	ftQuery		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = ? AND CART_TYPE = 'C'";
	ftQuery		+= " ORDER BY C.ID DESC";
	ftPstmt		= conn.prepareStatement(ftQuery);
	ftPstmt.setString(1, eslMemberId);
	ftRs		= ftPstmt.executeQuery();
	while(ftRs.next()){
		String ftCartId = ut.isnull(ftRs.getString("ID") );
		String ftGroupId = ut.isnull(ftRs.getString("GROUP_ID") );
		String ftBuyQty = ut.isnull(ftRs.getString("BUY_QTY") );
		String ftDevlType = ut.isnull(ftRs.getString("DEVL_TYPE") );
		String ftDevlDay = ut.isnull(ftRs.getString("DEVL_DAY") );
		String ftDevlWeek = ut.isnull(ftRs.getString("DEVL_WEEK") );
		String ftCartWdate = ut.isnull(ftRs.getString("WDATE") );
		String ftPrice = ut.isnull(ftRs.getString("PRICE") );
		String ftBuyBagYN = ut.isnull(ftRs.getString("BUY_BAG_YN") );
		String ftGubun1 = ut.isnull(ftRs.getString("GUBUN1") );
		String ftGroupName = ut.isnull(ftRs.getString("GROUP_NAME") );
		String ftGroupImg = ut.isnull(ftRs.getString("GROUP_IMGM") );
		if("".equals(ftGroupImg)){
			ftGroupImg = "/images/order_sample.jpg";
		}
		else{
			ftGroupImg = webUploadDir +"goods/"+ ftGroupImg;
		}
%>
	<div class="bx_item">
		<div class="bx_item_inner">
			<button type="button" class="btn_item_close" onclick="ftCartChkDel(<%=ftCartId%>, 'G');"></button>
			<div class="item_thumb">
				<div class="centered">
					<img src="<%=ftGroupImg%>" alt="">
				</div>
			</div>
			<div class="item_desc">
				<div class="item_head">
					<div class="item_title"><%=ftGroupName%></div>
					<div id="price1" class="item_price"><%=ut.getComma(ftPrice) %>원</div>
					<div class="item_caption">
<%
		if(!"02".equals(ftGubun1) && !"0".equals(ftDevlDay) && !"0".equals(ftDevlWeek) ){
			if("5".equals(ftDevlDay) ) out.print("월~금 / ");
			else if("3".equals(ftDevlDay) ) out.print("월/수/금 / ");

			out.print(ftDevlWeek + "주일분");
		}
%>
					</div>
				</div>
				<button type="button" class="item_options" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/order/__ajax_goods_set_options_select.jsp?cartId=<%=ftCartId%>'});">옵션변경</button>
			</div>
		</div>
	</div>
<%
	}
	if (ftRs != null) try { ftRs.close(); } catch (Exception e) {}
	if (ftPstmt != null) try { ftPstmt.close(); } catch (Exception e) {}

}
%>

	<!-- <div class="bx_item">
		<div class="bx_item_inner">
			<button type="button" class="btn_item_close" onclick="chkDel(34, 'G');"></button>
			<div class="item_thumb">
				<div class="centered">
					<img src="/dist/images/order/sample_order_list1.jpg" alt="">
				</div>
			</div>
			<div class="item_desc">
				<div class="item_head">
					<div class="item_title">알라까르떼 슬림</div>
					<div id="price1" class="item_price">73,000원</div>
					<div class="item_caption">월~금 / 2 주일분</div>
				</div>
				<button type="button" class="item_options" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/order/__ajax_goods_set_options.jsp?payPrice=73,000&amp;idevlDay=5&amp;idevlWeek=2&amp;ibuyQty=1&amp;cartId=179539&amp;idevlType=0001&amp;igroupId=34'});">옵션변경</button>
			</div>
		</div>
	</div>
	<div class="bx_item">
		<div class="bx_item_inner">
			<button type="button" class="btn_item_close" onclick="chkDel(34, 'G');"></button>
			<div class="item_thumb">
				<div class="centered">
					<img src="/dist/images/order/sample_order_list1.jpg" alt="">
				</div>
			</div>
			<div class="item_desc">
				<div class="item_head">
					<div class="item_title">알라까르떼 슬림</div>
					<div id="price1" class="item_price">73,000원</div>
					<div class="item_caption">월~금 / 2 주일분</div>
				</div>
				<button type="button" class="item_options" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/order/__ajax_goods_set_options.jsp?payPrice=73,000&amp;idevlDay=5&amp;idevlWeek=2&amp;ibuyQty=1&amp;cartId=179539&amp;idevlType=0001&amp;igroupId=34'});">옵션변경</button>
			</div>
		</div>
	</div>
	<div class="bx_item">
		<div class="bx_item_inner">
			<button type="button" class="btn_item_close" onclick="chkDel(34, 'G');"></button>
			<div class="item_thumb">
				<div class="centered">
					<img src="/dist/images/order/sample_order_list1.jpg" alt="">
				</div>
			</div>
			<div class="item_desc">
				<div class="item_head">
					<div class="item_title">알라까르떼 슬림</div>
					<div id="price1" class="item_price">73,000원</div>
					<div class="item_caption">월~금 / 2 주일분</div>
				</div>
				<button type="button" class="item_options" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/order/__ajax_goods_set_options.jsp?payPrice=73,000&amp;idevlDay=5&amp;idevlWeek=2&amp;ibuyQty=1&amp;cartId=179539&amp;idevlType=0001&amp;igroupId=34'});">옵션변경</button>
			</div>
		</div>
	</div>
	<div class="bx_item">
		<div class="bx_item_inner">
			<button type="button" class="btn_item_close" onclick="chkDel(34, 'G');"></button>
			<div class="item_thumb">
				<div class="centered">
					<img src="/dist/images/order/sample_order_list1.jpg" alt="">
				</div>
			</div>
			<div class="item_desc">
				<div class="item_head">
					<div class="item_title">알라까르떼 슬림</div>
					<div id="price1" class="item_price">73,000원</div>
					<div class="item_caption">월~금 / 2 주일분</div>
				</div>
				<button type="button" class="item_options" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/order/__ajax_goods_set_options.jsp?payPrice=73,000&amp;idevlDay=5&amp;idevlWeek=2&amp;ibuyQty=1&amp;cartId=179539&amp;idevlType=0001&amp;igroupId=34'});">옵션변경</button>
			</div>
		</div>
	</div> -->
</div>
<script>
$(function () {
	$(".cart_detail").slick({
		infinite: false,
		slidesToShow: 2,
		slidesToScroll: 2,
		arrows: false
	});
});

function ftCartChkDel(obj1, obj2) {
	if(!confirm("삭제하시겠습니까?")) return;
	$.post("/mobile/common/include/inc_cart_ajax.jsp", {
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
var price1 = "";
var price2 = "";
var total  = 0;
var totalPrice = "";
price1 = $("#tt1").val();
price2 = $("#tt2").val();
if(price1 == ""){
	price1 = "0원";
}

if(price2 == ""){
	price2 = "0원";
}

total += Number(price1) + Number(price2);
// 가격 , 붙여서 작업
var len, point, str;

total = total + "";
point = total.length % 3 ;
len = total.length;
str = total.substring(0, point);
while (point < len) {
    if (str != "") str += ",";
    str += total.substring(point, point + 3);
    point += 3;
}

totalPrice = str;
$("#cart_price").html(totalPrice);
function chkOrder(obj) {

	var cFrame = $("#cart");
	var itemLength = cFrame.find(".bx_item").length;

	alert("itemLength : "+itemLength);
	if (itemLength < 1) {
		var msg		= '장바구니가 비어있습니다.';
		alert(msg);
	} else {
		$("#mode").val("cartAll");
		$.post("/mobile/common/include/inc_cart_ajax.jsp", $("#frm_order").serialize(),
		function(data) {
			alert("in");
			alert("data : "+data);
			$(data).find("result").each(function() {
				alert("function in");
				if ($(this).text() == "success") {
					alert("$(this).text() :"+$(this).text());
					location.href = "/mobile/shop/order.jsp?mode=C";
				} else {
					alert("error");
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
</script>
<% } %>