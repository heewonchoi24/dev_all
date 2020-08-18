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
String groupName	= "";
String cartImg		= "";
String imgUrl		= "";
int payPrice		= 0;
int totalPrice		= 0;
int totalPrice1		= 0;
int totalPrice2		= 0;
int totalPrice3		= 0;
int devlPrice		= 0;
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
				HOME &gt; SHOP &gt; <strong>��ٱ���</strong>
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
					<div class="one last col">
						<div class="sectionHeader">
							<h4>
								<span class="f18 font-blue">�Ϲ��ǰ</span>
								<span class="f13">���̾�Ʈ ��ǰ�� �Ļ�Ⱓ ���ȿ� ���� ���� ��۵Ǹ� ��ǰ�� ��ۺ� ����ΰ� ���� �ʽ��ϴ�.</span>
							</h4>
						</div>
						<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th class="none"><input type="checkbox" id="selectall1" /></th>
								<th width="280">��ǰ��/�ɼ���ǰ��</th>
							  <th>�Ļ�Ⱓ</th>
								<th>ù�����</th>
								<th>����</th>
								<th>�ǸŰ���</th>
								<th class="last">�հ�</th>
							</tr>
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
							query		+= "	G.GUBUN1, G.GROUP_NAME, G.CART_IMG";
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
									devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "�Ϲ�" : "�ù�";
									devlDate	= rs.getString("WDATE");
									devlDate	= devlDate.replace("-", ".");
									gubun1		= rs.getString("GUBUN1");
									groupName	= rs.getString("GROUP_NAME");
									buyBagYn	= rs.getString("BUY_BAG_YN");
									devlDay		= rs.getString("DEVL_DAY");
									devlWeek	= rs.getString("DEVL_WEEK");
									devlPeriod	= devlWeek +"��("+ devlDay +"��)";
									price		= rs.getInt("PRICE");
									payPrice	= price * buyQty;
									totalPrice1	+= payPrice;
									cartImg		= rs.getString("CART_IMG");
									if (cartImg.equals("") || cartImg == null) {
										imgUrl		= "/images/order_sample.jpg";
									} else {										
										imgUrl		= webUploadDir +"goods/"+ cartImg;
									}
							%>
							<input type="hidden" name="cart_id" value="<%=cartId%>" />
							<tr>
								<td><input type="checkbox" class="selectable1" value="<%=cartId%>" /></td>
								<td><div class="orderName">
										<img class="thumbleft" src="<%=imgUrl%>" />
										<p class="catetag"><%=ut.getGubun1Name(gubun1)%></p>
										<h4><%=groupName%></h4>
									</div></td>
								<td><%=devlPeriod%></td>
								<td><input name="devl_date" id="devl_date_<%=cartId%>" class="date-pick" value="<%=devlDate%>" readonly /></td>
								<input type="hidden" name="buy_qty" id="buy_qty_<%=cartId%>" value="<%=buyQty%>" />
								<td><%=buyQty%></td>
								<!--td><input class="spinner" name="buy_qty" id="buy_qty_<%=cartId%>" style="width:30px;" value="<%=buyQty%>" /></td-->
								<td><%=nf.format(price)%>��</td>
								<td><div class="itemprice">
										<%=nf.format(payPrice)%>��
										<p class="list-delete bg-blue"><a href="javascript:;" onclick="chkDel(<%=groupId%>, 'G');"></p>
									</div></td>
							</tr>
							<%							
									if (buyBagYn.equals("Y")) {
										bagPrice		= defaultBagPrice * buyQty;
										totalPrice1		+= bagPrice;
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
								<td><%=buyQty%></td>
								<td><%=nf.format(defaultBagPrice)%>��</td>
								<td>
									<div class="itemprice">
										<%=nf.format(bagPrice)%>��
										<p class="list-delete bg-blue"><a href="javascript:;" onclick="chkDel(<%=groupId%>, 'B');"></p>
									</div>
								</td>
							</tr>
							<%
									}
								}

								if (rs != null) try { rs.close(); } catch (Exception e) {}
								if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
							%>
							<tr>
								<td colspan="7" class="totalprice">�� �ֹ��ݾ� <span class="won padl50"><%=nf.format(totalPrice1)%>��</span></td>
							</tr>
							<%
							} else {
							%>
							<tr>
								<td colspan="7">��ٱ��Ͽ� ��ϵ� ��ǰ�� �����ϴ�.</td>
							</tr>
							<%
							}
							%>
						</table>
						<!-- End orderList -->
					</div>
					<div class="one last col">
						<div class="sectionHeader">
							<h4>
								<span class="f18 font-green">�ù��ǰ</span>
								<span class="f13">�ù�� �߼۵Ǵ� ��ǰ���� ��� 2~5�ϳ��� ��۵Ǹ� ��ǰ�� ��ۺ� ����ΰ��˴ϴ�.</span>
							</h4>
							<div class="floatright" style="display:none;">
                              <input class="button white small" type="submit" value="��ü ����" name="button">
                              <input class="button white small" type="submit" value="����" name="button">
                            </div>
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
									devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "�Ϲ�" : "�ù�";
									devlDate	= rs.getString("WDATE");
									price		= rs.getInt("PRICE");
									gubun1		= rs.getString("GUBUN1");
									groupName	= rs.getString("GROUP_NAME");
									cartImg		= rs.getString("CART_IMG");
									if (cartImg.equals("") || cartImg == null) {
										imgUrl		= "/images/order_sample.jpg";
									} else {										
										imgUrl		= webUploadDir +"goods/"+ cartImg;
									}
									payPrice	= price * buyQty;
									totalPrice2	+= payPrice;
							%>
							<input type="hidden" name="cart_id" value="<%=cartId%>" />
							<input type="hidden" name="devl_date" id="devl_date_<%=cartId%>" value="<%=devlDate%>" />
							<tr>
								<td><input type="checkbox" class="selectable2" value="<%=cartId%>" /></td>
								<td>
									<div class="orderName">
										<img class="thumbleft" src="<%=imgUrl%>" />
										<p class="catetag"><%=ut.getGubun1Name(gubun1)%></p>
										<h4><%=groupName%></h4>
									</div>
								</td>
								<td><%=buyQty%></td>
								<input type="hidden" name="buy_qty" id="buy_qty_<%=cartId%>"value="<%=buyQty%>" />
								<!--td><input class="spinner" name="buy_qty" id="buy_qty_<%=cartId%>" style="width:30px;" value="<%=buyQty%>" /></td-->
								<td><%=nf.format(price)%>��</td>
								<td>
									<div class="itemprice">
										<%=nf.format(payPrice)%>��
										<p class="list-delete bg-blue"><a href="javascript:;" onClick="chkDel(<%=groupId%>, 'G');"></a></p>
									</div>
								</td>
							</tr>
							<%
								}
							%>
							<tr>
								<td colspan="5" class="totalprice">�� �ֹ��ݾ� <span class="won padl50"><%=nf.format(totalPrice2)%>��</span></td>
							</tr>
							<%
								if (totalPrice2 > 40000) {
									devlPrice		= 0;
								} else {
									devlPrice		= defaultDevlPrice;
								}
							} else {
							%>
							<tr>
								<td colspan="5">��ٱ��Ͽ� ��ϵ� ��ǰ�� �����ϴ�.</td>
							</tr>
							<%
							}

							totalPrice3		= totalPrice1 + totalPrice2;
							totalPrice		= totalPrice3 + devlPrice;
							%>
						</table>
						<!-- End orderList -->
					</div>
				</div>
			</form>
			<!-- End row -->
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
						<span>�Ϲ��ǰ <strong class="font-blue"><%=nf.format(totalPrice1)%></strong>��</span>
						+ <span>�ù��ǰ <strong class="font-blue"><%=nf.format(totalPrice2)%></strong>��</span>
						+ <span>��ۺ� <strong class="font-blue"><%=nf.format(devlPrice)%></strong>��</span>
						= <span class="won padl50"><%=nf.format(totalPrice)%>��</span>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="one last col center">
					<div class="divider"></div>
					<div class="button large darkgreen" style="margin:0 10px;">
						<a href="/shop/orderGuide.jsp">��� �����ϱ�</a>
					</div>
					<div class="button large dark" style="margin:0 10px;">
						<a href="javascript:;" onClick="chkOrder('S');">���û�ǰ �ֹ��ϱ�</a>
					</div>
					<div class="button large darkbrown" style="margin:0 10px;">
						<a href="javascript:;" onClick="chkOrder('A');">��ü�ֹ�</a>
					</div>
				</div>
			</div>
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
	</div>
	<!-- End container -->
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
		minDate: +6,
		onDate: $.datepick.noSundays,
		showTrigger: '#calImg'
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
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>