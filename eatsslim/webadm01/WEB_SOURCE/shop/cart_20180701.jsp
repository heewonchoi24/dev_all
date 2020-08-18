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
			<h1>��ٱ���</h1>
			<div class="pageDepth">
				<span>HOME</span><strong>��ٱ���</strong>
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
					<div class="one last col">
						<div class="sectionHeader">
							<h4>
								<span class="f18 font-blue">�Ϲ��ǰ</span>
								<span class="f13">���̾�Ʈ ��ǰ�� ��۱Ⱓ ���ȿ� ���� ���� ��۵Ǹ� ��ǰ�� ��ۺ� ����ΰ� ���� �ʽ��ϴ�.</span>
							</h4>
						</div>
						<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th class="none"><input type="checkbox" id="selectall1" /></th>
								<th width="280">��ǰ��/�ɼ���ǰ��</th>
							  <th>��۱Ⱓ</th>
								<th>ù�����</th>
								<th>����</th>
								<th>�ǸŰ���</th>
								<th class="last">�հ�</th>
							</tr>
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
								<td><%=nf.format(price)%>��</td>
								<td><div class="itemprice">
										<%=nf.format(payPrice)%>��
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
										<h4>���ð���</h4>
									</div>
								</td>
								<td>-</td>
								<td>-</td>
								<td>1</td>
								<td><%=nf.format(bagPrice)%>��</td>
								<td>
									<div class="itemprice">
										<%=nf.format(bagPrice)%>��
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
								<td colspan="7" class="totalprice">�� �ֹ��ݾ� <span class="won padl50" id="cartType1TotalPrice"><%=nf.format(cartType1TotalPrice)%>��</span></td>
							</tr>
						</table>
						<!-- End orderList -->
					</div>
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
%>
					<div class="one last col">
						<div class="sectionHeader">
							<h4>
								<span class="f18 font-green">�ù��ǰ</span>
								<span class="f13">�ù�� �߼۵Ǵ� ��ǰ���� ��� 2~5�ϳ��� ��۵Ǹ� ��ǰ�� ��ۺ� ����ΰ��˴ϴ�.</span>
							</h4>
						</div>
						<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th class="none"><input type="checkbox" id="selectall2" /></th>
								<th>��ǰ��</th>
								<th>����</th>
								<th>�ǸŰ���</th>
								<th class="last">�հ�</th>
							</tr>
<%

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
								<td><%=nf.format(price)%>��</td>
								<td>
									<div class="itemprice">
										<%=nf.format(payPrice)%>��
										<p class="list-delete bg-blue"><a href="javascript:;" onClick="chkDel(<%=cartId%>, 'G');"></a></p>
									</div>
								</td>
							</tr>
<%
		}
%>
							<tr>
								<td colspan="5" class="totalprice">�� �ֹ��ݾ� <span class="won padl50" id="cartType2TotalPrice"><%=nf.format(cartType2TotalPrice)%>��</span></td>
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
								<td>��ٱ��Ͽ� ��ϵ� ��ǰ�� �����ϴ�.</td>
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
						<input class="button white small" type="button" value="��ü ����" onclick="cartAllDel();" />
						<input class="button white small" type="button" value="���� ����" onclick="cartSelDel();" />
					</div>
					<div class="divider"></div>
					<div class="sectionHeader">
						<h4><span class="f18 font-maple">��ü �ֹ��ݾ�</span></h4>						
					</div>
					<div class="impor-wrap f16 center">
<% 		if(cartType1Ct > 0){ %>
						<span>�Ϲ��ǰ <strong class="font-blue" id="totalCartType1TotalPrice"><%=nf.format(cartType1TotalPrice)%></strong>��</span> +
<% 		} %>
<% 		if(cartType2Ct > 0){ %>
						<span>�ù��ǰ <strong class="font-blue" id="totalCartType2TotalPrice"><%=nf.format(cartType2TotalPrice)%></strong>��</span> +
<% 		} %>
						<span>��ۺ� <strong class="font-blue" id="totalDevlTotalPrice"><%=nf.format(devlPrice)%></strong>��</span> =
						<span class="won padl50" id="totalCartTotalAmount"><%=nf.format(cartTotalAmount)%>��</span>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="one last col center">
					<div class="divider"></div>
					<!-- <div class="button large darkgreen" style="margin:0 10px;">
						<a href="/shop/orderGuide.jsp">��� �����ϱ�</a>
					</div> --> 
					<div class="button large dark" style="margin:0 10px;">
						<a href="javascript:;" onClick="chkOrder('S');">���û�ǰ �ֹ��ϱ�</a>
					</div>
					<div class="button large darkbrown" style="margin:0 10px;">
						<a href="javascript:;" onClick="chkOrder('A');">��ü�ֹ�</a>
					</div>
				</div>
			</div>
<% } %>
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
	</div>
	<!-- End container -->
<!-- ��ȯ������ ���� -->
 <script type="text/javascript" src="//wcs.naver.net/wcslog.js"> </script> 
 <script type="text/javascript">
var _nasa={};
 _nasa["cnv"] = wcs.cnv("3","1"); // ��ȯ����, ��ȯ��ġ �����ؾ���. ��ġ�Ŵ��� ����
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
	if(!confirm("�����Ͻðڽ��ϱ�?")) return;
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
	if (confirm("������ �����Ͻðڽ��ϱ�?")) {
		$.post("cart_ajax.jsp", {
			mode: 'cartAllDel'
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					alert('�����Ǿ����ϴ�.');
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
		alert("������ ��ǰ�� �����ϼ���!");
	} else {
		if (confirm("������ �����Ͻðڽ��ϱ�?")) {
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
						alert('�����Ǿ����ϴ�.');
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
	
	//-- �����Ѱ��� ���ٸ� ��ü �ݾ��� �����ش�.
	if(cartType1TotalPrice == 0 && cartType2TotalPrice == 0){
		$("#cartType1TotalPrice").html(totalComma(<%=cartType1TotalPrice%>)+"��");
		$("#cartType2TotalPrice").html(totalComma(<%=cartType2TotalPrice%>)+"��");
		

		$("#totalCartType1TotalPrice").html(totalComma(<%=cartType1TotalPrice%>));
		$("#totalCartType2TotalPrice").html(totalComma(<%=cartType2TotalPrice%>));
		$("#totalCartTotalAmount").html(totalComma(<%=cartTotalAmount%>)+"��");
	}
	else{
		$("#cartType1TotalPrice").html(totalComma(cartType1TotalPrice)+"��");
		$("#cartType2TotalPrice").html(totalComma(cartType2TotalPrice)+"��");
		

		$("#totalCartType1TotalPrice").html(totalComma(cartType1TotalPrice));
		$("#totalCartType2TotalPrice").html(totalComma(cartType2TotalPrice));
		$("#totalCartTotalAmount").html(totalComma(cartType1TotalPrice + cartType2TotalPrice)+"��");
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
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=980596&mt_adid=158356&v1=&v2=&v3=&s1=&s2=&s3='></script>
<!-- �̵��ť�� �ȼ� End -->
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>