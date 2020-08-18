<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
int tcnt			= 0;
int cartId			= 0;
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
String gubun2		= "";
String groupName	= "";
String cartImg		= "";
String imgUrl		= "";
int payPrice		= 0;
int totalPrice		= 0;
int totalPrice1		= 0;
int totalPrice2		= 0;
int totalPrice3		= 0;
int tagPrice		= 0;
int tagPrice2		= 0;
int devlPrice		= 0; // 밸런스쉐이크 택배비
int devlPrice1		= 0; // 미니밀/라이스 택배비
int devlPrice2		= 0; // 풀비타 택배비
int bagPrice		= 0;
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "UPDATE ESL_CART SET ORDER_YN = 'N' WHERE MEMBER_ID = '"+ eslMemberId +"'";
try {
	stmt.executeUpdate(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
%>

	<!-- Calendar -->
	<link rel="stylesheet" type="text/css" href="/mobile/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.ext.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;"> 
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<form name="frm_order" id="frm_order" method="post">
		<input type="hidden" name="mode" id="mode" value="" />
		<div id="content">
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">장바구니</span></span></h1>
			<div class="row bg-gray">
				<h2>일배상품</h2>
				<%
				query		= "SELECT COUNT(ID) FROM ESL_CART WHERE MEMBER_ID = ? AND DEVL_TYPE = '0001' AND CART_TYPE = 'C'";
				pstmt		= conn.prepareStatement(query);
				pstmt.setString(1, eslMemberId);
				rs			= pstmt.executeQuery();
				if (rs.next()) {
					tcnt		= rs.getInt(1);
				}

				if (rs != null) try { rs.close(); } catch (Exception e) {}
				if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				
				query		= "SELECT C.ID, C.GROUP_ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK,";
				query		+= "	DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN,";
				query		+= "	G.GUBUN1, G.GUBUN2, G.GROUP_NAME, G.CART_IMG";
				query		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
				query		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = ? AND C.DEVL_TYPE = '0001' AND CART_TYPE = 'C'";
				query		+= " ORDER BY C.DEVL_TYPE";
				pstmt		= conn.prepareStatement(query);
				pstmt.setString(1, eslMemberId);
				rs			= pstmt.executeQuery();

				if (tcnt > 0) {
					while (rs.next()) {
						cartId		= rs.getInt("ID");
						groupId		= rs.getInt("GROUP_ID");
						buyQty		= rs.getInt("BUY_QTY");
						devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
						devlDate	= rs.getString("WDATE");
						devlDate	= devlDate.replace("-", ".");
						gubun1		= rs.getString("GUBUN1");
						gubun2		= rs.getString("GUBUN2");
						groupName	= rs.getString("GROUP_NAME");
						buyBagYn	= rs.getString("BUY_BAG_YN");
						devlDay		= rs.getString("DEVL_DAY");
						devlWeek	= rs.getString("DEVL_WEEK");
						devlPeriod	= devlWeek +"주("+ devlDay +"일)";
						price		= rs.getInt("PRICE");
						payPrice	= price * buyQty;
						totalPrice1	+= payPrice;
				%>
				<input type="hidden" name="cart_id" value="<%=cartId%>" />
				<a href="javascript:;" onclick="chkDel(<%=groupId%>, 'G');"><div class="cartdelete"></div></a>
				<ul class="ui-listview bginner">
					<li class="ui-btn ui-li ui-li-has-thumb">
						<div class="ui-btn-inner ui-li">
                            <h3 class="ui-li-heading">
                            <input id="day_<%=cartId%>" type="checkbox" class="selectable1" value="<%=cartId%>" />
                            <label for="day_<%=cartId%>"><span></span><%=ut.getGubun1Name(gubun1)%></label>
                            </h3>
							<p class="ui-li-desc"><%=ut.getGubun1Name(gubun2)%>(<%=groupName%>)</p>
							<p><%=nf.format(payPrice)%>원</p>
						</div>
					</li>
				</ul>
				<div class="divider"></div>
				<ul class="itembox">
					<li>
						<h3>식사 기간</h3>
						<ul class="form-line ui-inline2">
							<%=devlPeriod%>
						</ul>
					</li>
					<li>
						<h3>첫 배송일 지정</h3>
						<div><input name="devl_date" id="devl_date_<%=cartId%>" class="date-pick" value="<%=devlDate%>" readonly /></div>
						<div class="clear"></div>
					</li>
					<li>
						<h3>수량</h3>
						<div><%=buyQty%></div>
						<input type="hidden" name="buy_qty" id="buy_qty_<%=cartId%>" value="<%=buyQty%>" />
						<div class="clear"></div>
					</li>				
				</ul>
				<%							
						if (buyBagYn.equals("Y")) {
							bagPrice		= defaultBagPrice * buyQty;
							totalPrice1		+= bagPrice;
				%>
			</div>
			<!-- End row -->
			<div class="row bg-gray cartplus">
				<div class="plusicon"></div>
				<a href="javascript:;" onclick="chkDel(<%=groupId%>, 'B');"><div class="cartdelete"></div></a>
				<ul class="ui-listview bginner">
					<li class="ui-btn ui-li ui-li-has-thumb">
						<div class="ui-btn-inner ui-li">
							<h3 class="ui-li-heading">
                            <label for="buy_bag"><span></span>보냉가방</label>
                            </h3>
							<p class="ui-li-desc"></p>
							<p><%=nf.format(bagPrice)%>원</p>
						</div>
					</li>
				</ul>
				<div class="divider"></div>
				<ul class="itembox">
					<li>
						<h3>수량</h3>
						<div><%=buyQty%></div>
						<div class="clear"></div>
					</li>
				</ul>
				<%
						}
					}
				}
				if (rs != null) try { rs.close(); } catch (Exception e) {}
				if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				%>	
			</div>
			<!-- End row -->
			<div class="cart-total">총 일배주문금액 <span class="won"><%=nf.format(totalPrice1)%>원</span></div>
			<!-- End Plus -->
			<div class="row bg-gray">
				<h2>택배상품</h2>
				<%
				query		= "SELECT COUNT(ID) FROM ESL_CART WHERE MEMBER_ID = ? AND DEVL_TYPE = '0002' AND CART_TYPE = 'C'";
				pstmt		= conn.prepareStatement(query);
				pstmt.setString(1, eslMemberId);
				rs			= pstmt.executeQuery();
				if (rs.next()) {
					tcnt		= rs.getInt(1);
				}

				query		= "SELECT C.ID, C.GROUP_ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK, DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG";
				query		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
				query		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = ? AND C.DEVL_TYPE = '0002' AND CART_TYPE = 'C'";
				query		+= " ORDER BY C.DEVL_TYPE";
				pstmt		= conn.prepareStatement(query);
				pstmt.setString(1, eslMemberId);
				rs			= pstmt.executeQuery();
				
				if (tcnt > 0) {
					while (rs.next()) {
						cartId		= rs.getInt("ID");
						groupId		= rs.getInt("GROUP_ID");
						buyQty		= rs.getInt("BUY_QTY");
						devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
						devlDate	= rs.getString("WDATE");
						price		= rs.getInt("PRICE");
						gubun1		= rs.getString("GUBUN1");
						groupName	= rs.getString("GROUP_NAME");
						cartImg		= rs.getString("CART_IMG");
						payPrice	= price * buyQty;
						totalPrice2	+= payPrice;
						if (groupId == 15) {
							tagPrice	+= payPrice;
							if (tagPrice > 40000) {
								devlPrice		= 0;
							} else {
								devlPrice		= defaultDevlPrice;
							}
						} else if (groupId == 52 || groupId == 53) {
							devlPrice1		= defaultDevlPrice;
						} else if (groupId == 75 || groupId == 76 || groupId == 77 || groupId == 78 || groupId == 79 || groupId == 80) {
							tagPrice2	+= payPrice;
							if (tagPrice2 > 40000) {
								devlPrice2		= 0;
							} else {
								devlPrice2		= defaultDevlPrice;
							}
						}
				%>
				<input type="hidden" name="cart_id" value="<%=cartId%>" />
				<input type="hidden" name="devl_date" id="devl_date_<%=cartId%>" value="<%=devlDate%>" />
				<a href="javascript:;" onclick="chkDel(<%=groupId%>, 'G');"><div class="cartdelete"></div></a>
				<ul class="ui-listview bginner">
					<li class="ui-btn ui-li ui-li-has-thumb">
						<div class="ui-btn-inner ui-li">
							<h3 class="ui-li-heading">
							<input id="tag_<%=cartId%>" type="checkbox" class="selectable2" value="<%=cartId%>" />
							<label for="tag_<%=cartId%>"><span></span><%=groupName%></label>
                            </h3>
							<p class="ui-li-desc"></p>
							<p><%=nf.format(payPrice)%>원</p>
						</div>
					</li>
				</ul>
				<div class="divider"></div>
				<ul class="itembox">
					<li>
						<h3>수량</h3>
						<div><%=buyQty%></div>
						<div class="clear"></div>
						<input type="hidden" name="buy_qty" id="buy_qty_<%=cartId%>"value="<%=buyQty%>" />
					</li>
				</ul>
				<%
					}

					devlPrice		= devlPrice + devlPrice1+ devlPrice2;
				}			

				totalPrice3		= totalPrice1 + totalPrice2;
				totalPrice		= totalPrice3 + devlPrice;
				
				%>
			</div>
			<!-- End row -->
			<div class="cart-total">총 택배주문금액 <span class="won"><%=nf.format(totalPrice2)%>원</span></div>
			<!-- End Plus -->
			<dl class="itemlist redline">
				<dt class="f14" style="width:40%;">일배+택배 총 금액</dt>
				<dd class="f16" style="width:60%;"><%=nf.format(totalPrice3)%>원</dd>
				<div class="clear"></div>
				<dt class="f14" style="width:40%;">배송비</dt>
				<dd class="f16" style="width:60%;"><%=nf.format(devlPrice)%>원</dd>
			</dl>
			<dl class="itemlist bg-brown">
				<dt class="f16">총 결제금액</dt>
				<dd class="f16 font-orange"><%=nf.format(totalPrice)%>원</dd>
				<input type="hidden" id="totalPrice" value="<%=totalPrice%>" />
			</dl>
			<div class="grid-navi">
				<table class="navi" border="0" cellspacing="10" cellpadding="0">
					<tr>
						<td><a href="/mobile/shop/dietMeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">계속 쇼핑하기</span></span></a></td>
						<td><a href="javascript:;" onclick="chkOrder('A');" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">주문하기</span></span></a></td>
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
		onDate: $.datepick.noSundays
	});
});

function chkOrder(obj) {
	var chkGoods1	= $(".selectable1:checked");
	var chkGoods2	= $(".selectable2:checked");
	var chkGoods	= parseInt(chkGoods1.length) + parseInt(chkGoods2.length);

	if (chkGoods < 1) {
		alert('선택된 상품이 없습니다.');
	} else {		
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
	}
}

function chkDel(obj1, obj2) {
	$.post("cart_ajax.jsp", {
		mode: 'del',
		group_id: obj1,
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
</script>

<!-- 미디어큐브 픽셀 Start 2016.03.15 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=980597&mt_adid=158356&v1=&v2=&v3=&s1=&s2=&s3='></script>
<!-- 미디어큐브 픽셀 End -->
</body>
</html>