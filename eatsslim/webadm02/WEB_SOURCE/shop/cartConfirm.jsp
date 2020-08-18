<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%
String query		= "";
int tcnt			= 0;

int cartId			= 0;
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
String imgUrl		= "";
int payPrice		= 0;
int totalPrice		= 0;
int bagPrice		= 0;
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "UPDATE ESL_CART SET ORDER_YN = 'N' WHERE MEMBER_ID = '"+ eslMemberId +"'";
try {
	stmt.executeUpdate(query);			
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

query		= "SELECT COUNT(ID) FROM ESL_CART WHERE MEMBER_ID = ?"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
pstmt.setString(1, eslMemberId);
rs			= pstmt.executeQuery();
if (rs.next()) {
	tcnt		= rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

query		= "SELECT C.ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK, DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE,";
query		+= "	C.PRICE, C.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG";
query		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
query		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = ? AND C.CART_TYPE = 'C'";
query		+= " ORDER BY C.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
pstmt.setString(1, eslMemberId);
rs			= pstmt.executeQuery();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>선택 제품 확인</title>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>선택 제품 확인</h2>
		<p>고객님께서 선택하신 메뉴를 최종 확인해 주세요.</p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one"> 
				<div class="row">
				   <div class="one last col">
					   <div class="sectionHeader">
					<h4>
						<span class="f18 font-blue">
						고객님이 선택하신 제품
						</span>
					</h4>
					<!--div class="floatright button dark small"></div-->
				</div>
				<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th class="none"><input type="checkbox" id="selectall" /></th>
						<th>배송구분</th>
						<th>상품명/옵션제품명</th>
						<th>식사기간</th>
						<th>첫배송일</th>
						<th>수량</th>
						<th>판매가격</th>
						<th class="last">합계</th>
					</tr>
					<%
					if (tcnt > 0) {
						while (rs.next()) {
							cartId		= rs.getInt("ID");
							buyQty		= rs.getInt("BUY_QTY");
							devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";							
							gubun1		= rs.getString("GUBUN1");
							groupName	= rs.getString("GROUP_NAME");
							if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
								devlDate	= rs.getString("WDATE");
								buyBagYn	= rs.getString("BUY_BAG_YN");
								devlDay		= rs.getString("DEVL_DAY");
								devlWeek	= rs.getString("DEVL_WEEK");
								devlPeriod	= devlWeek +"주("+ devlDay +"일)";
								price		= rs.getInt("PRICE");
								payPrice	= price * buyQty;
							} else {
								devlDate	= "-";
								buyBagYn	= "N";
								devlPeriod	= "-";
								price		= rs.getInt("PRICE");
								payPrice	= price * buyQty;
							}
							cartImg		= rs.getString("CART_IMG");
							if (cartImg.equals("") || cartImg == null) {
								imgUrl		= "/images/order_sample.jpg";
							} else {										
								imgUrl		= webUploadDir +"goods/"+ cartImg;
							}
							totalPrice	+= payPrice;
					%>
					<tr class="tr<%=cartId%>">
						<td><input type="checkbox" class="selectable" value="<%=cartId%>" /></td>
						<td><%=devlType%></td>
						<td>
							<div class="orderName">
								<img class="thumbleft" src="<%=imgUrl%>" />
								<p class="catetag">
									<%=ut.getGubun1Name(gubun1)%>
								</p>
								<h4>
									<%=groupName%>
								</h4>
							</div>
						</td>
						<td><%=devlPeriod%></td>
						<td><%=devlDate%></td>
						<td><%=buyQty%></td>
						<td><%=nf.format(price)%>원</td>
						<td>
							<div class="itemprice">
								<%=nf.format(payPrice)%>원
								<!--p class="list-delete bg-blue"><a href="javascript:;" onclick="chkDel(<%=cartId%>, 'G');"></a></p-->
							</div>
						</td>
					</tr>
					<%
							if (buyBagYn.equals("Y")) {
								bagPrice	= defaultBagPrice * buyQty;
								totalPrice	+= bagPrice;
					%>
					<tr class="tr<%=cartId%>B">
						<td>-</td>
						<td>일배</td>
						<td>
							<div class="orderName">
								<img class="thumbleft" src="<%=webUploadDir%>goods/groupCart_0300668.jpg" />
								<h4>보냉가방</h4>
							</div>
						</td>
						<td>-</td>
						<td>-</td>
						<td><%=buyQty%></td>
						<td><%=nf.format(defaultBagPrice)%>원</td>
						<td>
							<div class="itemprice">
								<%=nf.format(bagPrice)%>원
								<!--p class="list-delete bg-blue"><a href="javascript:;" onclick="chkDel(<%=cartId%>, 'B');"></a></p-->
							</div>
						</td>
					</tr>
					<%
							}
						}
					}
					%>
					<tr>
						<td colspan="8" class="totalprice">
							총 주문금액
							<span class="won padl50"><%=nf.format(totalPrice)%>원</span>
						</td>
					</tr>
				</table>
				<!-- End orderList -->
				   </div>
				</div>
				<!-- End row -->
				<div class="row">
				   <div class="one last col center">
						<span class="padr50">선택한 제품을 최종 구매하시겠습니까?
							<span class="button large dark"><a href="javascript:;" onclick="chkOrder();">선택구매</a></span>
						</span>
						<span>쇼핑을 계속 하시겠습니까?
							<span class="button large light"><a href="javascript:;" onclick="$.lightbox().close();">쇼핑 계속하기</a></span>
						</span>
				   </div>
				</div>
				<!-- End row -->
		  </div>
		  <!-- End popup columns offset-by-one -->	
	</div>
	<!-- End contentpop -->
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#selectall").click(function() {
		selectAll();
	});
});

function selectAll() {
	var checked = $("#selectall").is(":checked");

	$(".selectable").each(function(){
		var subChecked = $(this).attr("checked");
		if (subChecked != checked) {
			$(this).click();
		}
	});
}

function chkOrder() {
	var chkGoods	= $(".selectable:checked");

	if (chkGoods.length < 1) {
		alert("선택된 상품이 없습니다.");
	} else {
		var sel_arr			= new Array();
		var i = 0;
		$(".selectable:checked").each(function() {
			sel_arr[i]		 = $(this).val();
			i++;
		});
		var sel_ids_val		= sel_arr.join();
		$.post("cartConfirm_ajax.jsp", {
			mode: "cartSel",
			cart_ids: sel_ids_val
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
	$.post("cartConfirm_ajax.jsp", {
		mode: 'del',
		cart_id: obj1,
		bag_yn: obj2
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				if (obj2 == "B") {
					$(".tr"+obj1+"B").remove();
				} else {
					$(".tr"+obj1).remove();
					$(".tr"+obj1+"B").remove();
				}
			} else {
				alert($(this).text());
			}
		});
	}, "xml");
	return false;
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp"%>