<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
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

	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.ext.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
	<!--
	<script type="text/javascript" src="/common/js/jquery.ui.spinner.js"></script>
	<script type="text/javascript" src="/common/js/jquery.ui.button.js"></script>
	-->
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>장바구니</h1>
			<div class="pageDepth">
				<span>HOME</span><strong>장바구니</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one ">
			<div class="row">
				<div class="one last col">
					<ul class="order-step">
						<li class="step1 current"></li>
						<li class="line"></li>
						<li class="step2"></li>
						<li class="line"></li>
						<li class="step3"></li>
					</ul>
				</div>
			</div>
			<!-- End row -->
			<form name="frm_order" id="frm_order" method="post">
				<input type="hidden" name="mode" id="mode" value="" />
				<div class="row">
<%
if(cartCt > 0){
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
%>
					<div class="one last col">
						<div class="sectionHeader">
							<h4>
								<span class="f18 font-blue">일배상품</span>
								<span class="f13">다이어트 식품의 배송기간 동안에 매일 직접 배송되며 상품별 배송비가 차등부과 되지 않습니다.</span>
							</h4>
						</div>
						<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th class="none"><input type="checkbox" id="selectall1" /></th>
								<th width="280">상품명/옵션제품명</th>
							  <th>배송기간</th>
								<th>첫배송일</th>
								<th>수량</th>
								<th>판매가격</th>
								<th class="last">합계</th>
							</tr>
<%
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
							<input type="hidden" name="cart_id" value="<%=cartId%>" />
							<tr>
								<td><input type="checkbox" class="selectable1" value="<%=cartId%>" onclick="chkSum()" />
								<input type="hidden" class="checkSumPrice" value="<%=rs.getInt("PRICE")%>" />
								</td>
								<td><div class="orderName">
										<img class="thumbleft" src="<%=imgUrl%>" width="100" />
										<p class="catetag"><%=ut.getGubun1Name(gubun1)%></p>
										<h4><%=groupName%></h4>
									</div></td>
								<td><%=devlPeriod%></td>
								<td><input name="devl_date" id="devl_date_<%=cartId%>" class="date-pick" value="<%=devlDate%>" readonly /></td>
								<input type="hidden" name="buy_qty" id="buy_qty_<%=cartId%>" value="<%=buyQty%>" />
								<td><%=buyQty%></td>
								<td><%=nf.format(price)%>원</td>
								<td><div class="itemprice">
										<%=nf.format(payPrice)%>원
										<p class="list-delete bg-blue"><a href="javascript:;" onclick="chkDel(<%=cartId%>, 'G');"></p>
									</div></td>
							</tr>
<%							
			if (buyBagYn.equals("Y")) {
				bagPrice		= defaultBagPrice;// * buyQty;
%>
							<tr>
								<td>-</td>
								<td>
									<div class="orderName">
										<img class="thumbleft" src="<%=webUploadDir%>goods/groupCart_0300668.jpg" />
										<h4>보냉가방</h4>
									</div>
								</td>
								<td>-</td>
								<td>-</td>
								<td>1</td>
								<td><%=nf.format(bagPrice)%>원</td>
								<td>
									<div class="itemprice">
										<%=nf.format(bagPrice)%>원
										<p class="list-delete bg-blue"><a href="javascript:;" onclick="chkDel(<%=cartId%>, 'B');"></p>
									</div>
								</td>
							</tr>
<%
			}
		} //-- while (rs.next()) {
	
		if (rs != null) try { rs.close(); } catch (Exception e) {}
		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
%>
							<tr>
								<td colspan="7" class="totalprice">총 주문금액 <span class="won padl50" id="cartType1TotalPrice"><%=nf.format(cartType1TotalPrice)%>원</span></td>
							</tr>
						</table>
						<!-- End orderList -->
					</div>
<%
	}
	
	
	//-- 택배배송
	if(cartType2Ct > 0){
		query		= "SELECT C.ID, C.GROUP_ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK, DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, G.GROUP_IMGM";
		query		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
		query		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = ? AND C.DEVL_TYPE = '0002' AND CART_TYPE = 'C'";
		query		+= " ORDER BY C.DEVL_TYPE";
		pstmt		= conn.prepareStatement(query);
		pstmt.setString(1, eslMemberId);
		rs			= pstmt.executeQuery();
%>
					<div class="one last col">
						<div class="sectionHeader">
							<h4>
								<span class="f18 font-green">택배상품</span>
								<span class="f13">택배로 발송되는 상품으로 평균 2~5일내에 배송되며 상품별 배송비가 차등부과됩니다.</span>
							</h4>
						</div>
						<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th class="none"><input type="checkbox" id="selectall2" /></th>
								<th>상품명</th>
								<th>수량</th>
								<th>판매가격</th>
								<th class="last">합계</th>
							</tr>
<%

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
							<input type="hidden" name="cart_id" value="<%=cartId%>" />
							<input type="hidden" name="devl_date" id="devl_date_<%=cartId%>" value="<%=devlDate%>" />
							<tr>
								<td><input type="checkbox" class="selectable2" value="<%=cartId%>" onclick="chkSum()" />
								<input type="hidden" class="checkSumPrice" value="<%=rs.getInt("PRICE")%>" /></td>
								<td>
									<div class="orderName">
										<img class="thumbleft" src="<%=imgUrl%>" width="100" />
										<p class="catetag"><%=ut.getGubun1Name(gubun1)%></p>
										<h4><%=groupName%></h4>
									</div>
								</td>
								<td><%=buyQty%></td>
								<input type="hidden" name="buy_qty" id="buy_qty_<%=cartId%>" value="<%=buyQty%>" />
								<td><%=nf.format(price)%>원</td>
								<td>
									<div class="itemprice">
										<%=nf.format(payPrice)%>원
										<p class="list-delete bg-blue"><a href="javascript:;" onClick="chkDel(<%=cartId%>, 'G');"></a></p>
									</div>
								</td>
							</tr>
<%
		}
%>
							<tr>
								<td colspan="5" class="totalprice">총 주문금액 <span class="won padl50" id="cartType2TotalPrice"><%=nf.format(cartType2TotalPrice)%>원</span></td>
							</tr>
						</table>
						<!-- End orderList -->
					</div>
<%
	}
	
%>
<%
}
else{
%>
					<div class="one last col">
						<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>장바구니에 등록된 상품이 없습니다.</td>
							</tr>
						</table>
					</div>
<%
}
%>						
						
						
				</div>
			</form>
			<!-- End row -->
<% if(cartCt > 0){ %>			
			<div class="row">
				<div class="one last col">
					<div class="floatleft">
						<input class="button white small" type="button" value="전체 삭제" onclick="cartAllDel();" />
						<input class="button white small" type="button" value="선택 삭제" onclick="cartSelDel();" />
					</div>
					<div class="divider"></div>
					<div class="sectionHeader">
						<h4><span class="f18 font-maple">전체 주문금액</span></h4>						
					</div>
					<div class="impor-wrap f16 center">
<% 		if(cartType1Ct > 0){ %>
						<span>일배상품 <strong class="font-blue" id="totalCartType1TotalPrice"><%=nf.format(cartType1TotalPrice)%></strong>원</span> +
<% 		} %>
<% 		if(cartType2Ct > 0){ %>
						<span>택배상품 <strong class="font-blue" id="totalCartType2TotalPrice"><%=nf.format(cartType2TotalPrice)%></strong>원</span> +
<% 		} %>
						<span>배송비 <strong class="font-blue" id="totalDevlTotalPrice"><%=nf.format(devlPrice)%></strong>원</span> =
						<span class="won padl50" id="totalCartTotalAmount"><%=nf.format(cartTotalAmount)%>원</span>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="one last col center">
					<div class="divider"></div>
					<!-- <div class="button large darkgreen" style="margin:0 10px;">
						<a href="/shop/orderGuide.jsp">계속 쇼핑하기</a>
					</div> --> 
					<div class="button large dark" style="margin:0 10px;">
						<a href="javascript:;" onClick="chkOrder('S');">선택상품 주문하기</a>
					</div>
					<div class="button large darkbrown" style="margin:0 10px;">
						<a href="javascript:;" onClick="chkOrder('A');">전체주문</a>
					</div>
				</div>
			</div>
<% } %>
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
	</div>
	<!-- End container -->
<!-- 전환페이지 설정 -->
 <script type="text/javascript" src="//wcs.naver.net/wcslog.js"> </script> 
 <script type="text/javascript">
var _nasa={};
 _nasa["cnv"] = wcs.cnv("3","1"); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고
</script>

<script type="text/javascript"> 
_TRK_PI="OCV"; 
</script>

	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
<script type="text/javascript">  
$(document).ready(function() {
	$(".date-pick").datepick({ 
		dateFormat: "yyyy.mm.dd",
		minDate: +3,
		onDate: $.datepick.noWeekend,
		showTrigger: '#calImg',
		beforeShowDay: function(date){
			var day = date.getDay();
			return [(day != 0 && day != 6)];
		}
	});
/*
	$(".spinner").spinner({
		max: 9,
		min: 1
	});
*/
	$("#selectall1").click(function() {
		selectAll(1);
	});
	$("#selectall2").click(function() {
		selectAll(2);
	});
});

function selectAll(num) {
	var checked = $("#selectall"+ num).is(":checked");

	$(".selectable"+ num).each(function(){
		var subChecked = $(this).attr("checked");
		if (subChecked != checked) {
			$(this).click();
		}
	});
}

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
	if(!confirm("삭제하시겠습니까?")) return;
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

function cartAllDel() {
	if (confirm("정말로 삭제하시겠습니까?")) {
		$.post("cart_ajax.jsp", {
			mode: 'cartAllDel'
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					alert('삭제되었습니다.');
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
}

function cartSelDel() {
	var chkGoods1	= $(".selectable1:checked");
	var chkGoods2	= $(".selectable2:checked");
	var chkGoods	= parseInt(chkGoods1.length) + parseInt(chkGoods2.length);

	if(chkGoods < 1) {
		alert("삭제할 상품을 선택하세요!");
	} else {
		if (confirm("정말로 삭제하시겠습니까?")) {
			var del_arr = new Array();
			var i = 0;
			$(".selectable1:checked").each(function() {
				del_arr[i] = $(this).val();
				i++;
			});
			$(".selectable2:checked").each(function() {
				del_arr[i] = $(this).val();
				i++;
			});
			var del_ids_val = del_arr.join();
			$.post("cart_ajax.jsp", {
				mode: 'cartSelDel', 
				del_ids: del_ids_val
			},
			function(data) {
				$(data).find('result').each(function() {
					if ($(this).text() == 'success') {
						alert('삭제되었습니다.');
						document.location.reload();
					} else {
						$(data).find('error').each(function() {
							alert($(this).text());
						});
					}
				});
			}, "xml");
		}
	}
}
function chkSum(){
	var cartType1TotalPrice = 0;
	var cartType2TotalPrice = 0;
	$(".selectable1:checked").each(function() {
		cartType1TotalPrice += parseInt($(this).closest("tr").find(".checkSumPrice").val(),10);
	});
	$(".selectable2:checked").each(function() {
		cartType2TotalPrice += parseInt($(this).closest("tr").find(".checkSumPrice").val(),10);
	});
	
	//-- 선택한것이 없다면 전체 금액을 보여준다.
	if(cartType1TotalPrice == 0 && cartType2TotalPrice == 0){
		$("#cartType1TotalPrice").html(totalComma(<%=cartType1TotalPrice%>)+"원");
		$("#cartType2TotalPrice").html(totalComma(<%=cartType2TotalPrice%>)+"원");
		

		$("#totalCartType1TotalPrice").html(totalComma(<%=cartType1TotalPrice%>));
		$("#totalCartType2TotalPrice").html(totalComma(<%=cartType2TotalPrice%>));
		$("#totalCartTotalAmount").html(totalComma(<%=cartTotalAmount%>)+"원");
	}
	else{
		$("#cartType1TotalPrice").html(totalComma(cartType1TotalPrice)+"원");
		$("#cartType2TotalPrice").html(totalComma(cartType2TotalPrice)+"원");
		

		$("#totalCartType1TotalPrice").html(totalComma(cartType1TotalPrice));
		$("#totalCartType2TotalPrice").html(totalComma(cartType2TotalPrice));
		$("#totalCartTotalAmount").html(totalComma(cartType1TotalPrice + cartType2TotalPrice)+"원");
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
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=980596&mt_adid=158356&v1=&v2=&v3=&s1=&s2=&s3='></script>
<!-- 미디어큐브 픽셀 End -->
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>