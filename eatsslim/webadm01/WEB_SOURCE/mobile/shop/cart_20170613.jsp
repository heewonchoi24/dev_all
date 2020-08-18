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


<%
if(cartCt > 0){
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
%>
<%
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
				<div class="row bg-gray cartBox">
				<h2>�Ϲ��ǰ</h2>
				<input type="hidden" name="cart_id" value="<%=cartId%>" />
				<a href="javascript:;" onclick="chkDel(<%=groupId%>, 'G');"><div class="cartdelete"></div></a>
				<ul class="ui-listview bginner">
					<li class="ui-btn ui-li ui-li-has-thumb">
						<div class="ui-btn-inner ui-li">
                            <h3 class="ui-li-heading">
                            <input id="day_<%=cartId%>" type="checkbox" class="selectable1" value="<%=cartId%>" />
                            <label for="day_<%=cartId%>"><span></span><%=ut.getGubun1Name(gubun1)%></label>
                            </h3>
							<p class="ui-li-desc"><%=groupName%></p>
							<p><%=nf.format(payPrice)%>��</p>
						</div>
					</li>
				</ul>
				<div class="divider"></div>
				<ul class="itembox">
					<li>
						<h3>�Ļ� �Ⱓ</h3>
						<ul class="form-line ui-inline2">
							<%=devlPeriod%>
						</ul>
					</li>
					<li>
						<h3>ù ����� ����</h3>
						<div><input name="devl_date" id="devl_date_<%=cartId%>" class="date-pick" value="<%=devlDate%>" readonly /></div>
						<div class="clear"></div>
					</li>
					<li>
						<h3>����</h3>
						<div><%=buyQty%></div>
						<input type="hidden" name="buy_qty" id="buy_qty_<%=cartId%>" value="<%=buyQty%>" />
						<div class="clear"></div>
					</li>
				</ul>
			</div>
<%
			if (buyBagYn.equals("Y")) {
				bagPrice		= defaultBagPrice;// * buyQty;
%>
			<!-- End row -->
			<div class="row bg-gray cartplus cartBox">
				<div class="plusicon"></div>
				<%-- <a href="javascript:;" onclick="chkDel(<%=groupId%>, 'B');"><div class="cartdelete"></div></a> --%>
				<ul class="ui-listview bginner">
					<li class="ui-btn ui-li ui-li-has-thumb">
						<div class="ui-btn-inner ui-li">
							<h3 class="ui-li-heading">
                            <label for="buy_bag"><span></span>���ð���</label>
                            </h3>
							<p class="ui-li-desc"></p>
							<p><%=nf.format(bagPrice)%>��</p>
						</div>
					</li>
				</ul>
				<div class="divider"></div>
				<ul class="itembox">
					<li>
						<h3>����</h3>
						<div>1</div>
						<div class="clear"></div>
					</li>
				</ul>
			</div>
<%
			}
		} //-- while (rs.next()) {

		if (rs != null) try { rs.close(); } catch (Exception e) {}
		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
%>
			<!-- End row -->
			<div class="cart-total">�� �Ϲ��ֹ��ݾ� <span class="won"><%=nf.format(cartType1TotalPrice)%>��</span></div>
			<!-- End Plus -->

<%
	}


	//-- �ù���
	if(cartType2Ct > 0){
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
				<div class="row bg-gray cartBox">
				<h2>�ù��ǰ</h2>
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
							<p><%=nf.format(payPrice)%>��</p>
						</div>
					</li>
				</ul>
				<div class="divider"></div>
				<ul class="itembox">
					<li>
						<h3>����</h3>
						<div><%=buyQty%></div>
						<div class="clear"></div>
						<input type="hidden" name="buy_qty" id="buy_qty_<%=cartId%>"value="<%=buyQty%>" />
					</li>
				</ul>
			</div>
<%
		}
%>
			<!-- End row -->
			<div class="cart-total">�� �ù��ֹ��ݾ� <span class="won"><%=nf.format(cartType2TotalPrice)%>��</span></div>
			<!-- End Plus -->
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
								<td>��ٱ��Ͽ� ��ϵ� ��ǰ�� �����ϴ�.</td>
							</tr>
						</table>
					</div>
<%
}
%>
<% if(cartCt > 0){ %>
			<dl class="itemlist redline">
				<dt class="f14" style="width:40%;">�Ϲ�+�ù� �� �ݾ�</dt>
				<dd class="f16" style="width:60%;"><%=nf.format(cartType1TotalPrice+cartType2TotalPrice)%>��</dd>
				<div class="clear"></div>
				<dt class="f14" style="width:40%;">��ۺ�</dt>
				<dd class="f16" style="width:60%;"><%=nf.format(devlPrice)%>��</dd>
			</dl>
			<dl class="itemlist bg-brown ta-c">
				<dt class="fz-b2">�� �����ݾ�</dt>
				<dd class="fz-b2  fw-b font-orange"><%=nf.format(cartTotalAmount)%>��</dd>
				<input type="hidden" id="totalPrice" value="<%=cartTotalAmount%>" />
			</dl>
			<div class="grid-navi">
				<table class="navi" border="0" cellspacing="10" cellpadding="0">
					<tr>
<!-- 						<td><a href="/mobile/shop/dietMeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">��� �����ϱ�</span></span></a></td> -->
						<td><a href="javascript:;" onclick="chkOrder('A');" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�ֹ��ϱ�</span></span></a></td>
					</tr>
				</table>
			</div>
<% } %>
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
</script>

<!-- �̵��ť�� �ȼ� Start 2016.03.15 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=980597&mt_adid=158356&v1=&v2=&v3=&s1=&s2=&s3='></script>
<!-- �̵��ť�� �ȼ� End -->
</body>
</html>