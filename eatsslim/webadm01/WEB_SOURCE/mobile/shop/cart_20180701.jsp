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
//int devlPrice		= 0; // �뷱������ũ �ù��
//int devlPrice1		= 0; // �̴Ϲ�/���̽� �ù��
//int devlPrice2		= 0; // Ǯ��Ÿ �ù��
//int devlPrice3		= 0; // �ǰ��� �ù��
int bagPrice		= 0;

int cartCt					= 0; //-- ��ٱ��� ��ü��
int cartType1TotalPrice		= 0; //-- ���Ϲ�� ��ǰ�հ�
int cartType2TotalPrice		= 0; //-- �ù��� ��ǰ�հ�
int cartType1Ct				= 0; //-- ���Ϲ�� ��ǰ��
int cartType2Ct				= 0; //-- �ù��� ��ǰ��
int cartTotalPrice			= 0; //-- ��ü��ǰ�հ�
int devlPrice				= 0; //-- ��ۺ�
int cartTotalAmount			= 0; //-- ���������ݾ�

NumberFormat nf = NumberFormat.getNumberInstance();


if (!eslMemberId.equals("")) {

	query		= "UPDATE ESL_CART SET ORDER_YN = 'N' WHERE MEMBER_ID = '"+ eslMemberId +"'";
	try {
		stmt.executeUpdate(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	//-- ���Ϲ��
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

	//-- �ù���
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

	//-- ��ü ��ٱ��ϼ�
	cartCt = cartType1Ct + cartType2Ct;

	//-- ��ǰ�հ�ݾ�
	cartTotalPrice = cartType1TotalPrice + cartType2TotalPrice;

	//-- ��ۺ�
	/* ��ü ���� ��� ����
	if(cartCt > 0 && cartTotalPrice < 40000){
		devlPrice = defaultDevlPrice;
	}
	*/

	//-- �� �����ݾ�
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
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">��ٱ���</span></span></h1>
			<div class="row" id="shopCart">
				<div class="cartListArea">
<%
if(cartCt > 0){
%>
					<div class="orderBox">
						<h1 class="tit">�Ϲ��ǰ</h1>
						<ul class="cartList">
<%
	//-- ���Ϲ��
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
			devlType	= "�Ϲ�";
			devlDate	= ut.isnull(rs.getString("WDATE") );
			gubun1		= ut.isnull(rs.getString("GUBUN1") );
			groupName	= ut.isnull(rs.getString("GROUP_NAME") );
			buyBagYn	= ut.isnull(rs.getString("BUY_BAG_YN") );
			devlDay		= ut.isnull(rs.getString("DEVL_DAY") );
			devlWeek	= ut.isnull(rs.getString("DEVL_WEEK") );
			devlPeriod	= devlWeek +"��("+ devlDay +"��)";
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
										<a href="javascript:void(0);" class="cartDelete" onclick="chkDel(<%=groupId%>, 'G');">����</a>
										<p class="cate"><%=ut.getGubun1Name(gubun1)%></p>
										<p class="name"><%=groupName%></p>
									</div>
									<div class="cartBody">
										<div class="photo"><img src="<%=imgUrl%>"></div>
										<div class="info">
											<p>�Ļ�Ⱓ : <span><%=devlPeriod%></span></p>
											<p>ù ����� : <span><%=devlDate%></span></p>
											<p>���� : <span><%=buyQty%></span></p>
										</div>
									</div>
									<div class="cartbottom">
										<div class="price"><!-- <span>80,000��</span>  --><%=nf.format(payPrice)%>��</div>
									</div>
								</div>
<%
			if (buyBagYn.equals("Y")) {
				bagPrice += defaultBagPrice;// * buyQty;
%>
								<div class="buyBag">
									<div class="bagTit">���ð���<span>(����:<strong>1</strong>)</span></div>
									<div class="bagPrice"><%=nf.format(defaultBagPrice)%>��</div>
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
							�� �ֹ� �ݾ� <span id="cartType1TotalPrice"><%=nf.format(cartType1TotalPrice)%></span> ��
						</div>
					</div>
<%
	}

	//-- �ù���
	if(cartType2Ct > 0){
%>
					<div class="orderBox">
						<h1 class="tit">�ù��ǰ</h1>
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
			devlType	= "�ù�";
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
										<a href="javascript:void(0);" class="cartDelete" onclick="chkDel(<%=groupId%>, 'G');">����</a>
										<p class="cate"><%=ut.getGubun1Name(gubun1)%></p>
										<p class="name"><%=groupName%></p>
									</div>
									<div class="cartBody">
										<div class="photo"><img src="<%=imgUrl%>"></div>
										<div class="info">
											<p>���� : <span><%=buyQty%></span></p>
										</div>
									</div>
									<div class="cartbottom">
										<div class="price"><!-- <span>80,000��</span>  --><%=nf.format(payPrice)%>��</div>
									</div>
								</div>
							</li>
<%
		}
%>
						</ul>
						<div class="cartTotal">
							�� �ֹ� �ݾ� <span id="cartType2TotalPrice"><%=nf.format(cartType2TotalPrice)%></span> ��
						</div>
					</div>
					<!-- <div class="cartDeleteTotal">
						<a href="javascript:void(0);" onclick="chkDelAll();">��ü ����</a>
						<a href="javascript:void(0);" onclick="chkDelSelect();">���� ����</a>
					</div> -->
<%
	}

}else{
%>
					<div class="cartNoneBox">
						��ٱ��Ͽ� ��ϵ� ��ǰ�� �����ϴ�.
					</div>
<%
}
%>
				</div>
<% if(cartCt > 0){ %>
				<div class="totalPriceArea">
					<div class="totalPriceTop">��ü �ֹ� �ݾ�</div>
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
									<th>�Ϲ��ǰ</th>
									<td><span id="totalCartType1TotalPrice"><%=nf.format(cartType1TotalPrice)%></span> ��</td>
								</tr>
<%
}
if(cartType2Ct > 0){
%>
								<tr>
									<th>�ù��ǰ</th>
									<td><span id="totalCartType2TotalPrice"><%=nf.format(cartType2TotalPrice)%></span> ��</td>
								</tr>
<%
}
%>
							</tbody>
						</table>
					</div>
					<div class="totalPrice">
						�� �ֹ��ݾ� <span id="totalDevlTotalPrice"><%=nf.format(cartTotalAmount)%></span> ��
						<input type="hidden" id="totalPrice" value="<%=cartTotalAmount%>" />
					</div>
					<div class="orderBtns">
						<button type="button" class="btn btn_white square" onclick="chkOrder('S');">���û�ǰ �ֹ��ϱ�</button>
						<button type="button" class="btn btn_dgray square" onclick="chkOrder('A');">��ü�ֹ��ϱ�</button>
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
		var msg		= (obj == 'S')? '���õ� ��ǰ�� �����ϴ�.' : '��ٱ��ϰ� ����ֽ��ϴ�.';
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

	//-- �����Ѱ��� ���ٸ� ��ü �ݾ��� �����ش�.
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
//�޸� ���� �ٿ��ֱ�
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

<!-- �̵��ť�� �ȼ� Start 2016.03.15 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=980597&mt_adid=158356&v1=&v2=&v3=&s1=&s2=&s3='></script>
<!-- �̵��ť�� �ȼ� End -->
</body>
</html>
