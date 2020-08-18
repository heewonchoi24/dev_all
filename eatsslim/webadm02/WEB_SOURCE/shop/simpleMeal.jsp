<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String query			= "";
int groupId				= 0;
int price				= 0;
int totalPrice			= 0;
int realPrice			= 0;
int tSalePrice			= 0;
String groupInfo		= "";
String offerNotice		= "";
String groupName		= "";
NumberFormat nf			= NumberFormat.getNumberInstance();
String table			= " ESL_GOODS_GROUP";
String where			= " WHERE GUBUN1 = '01' AND GUBUN2 = '11' AND USE_YN = 'Y'";
String sort				= " ORDER BY ID ASC";
int	tab					= 0;
if (request.getParameter("tab") != null && request.getParameter("tab").length()>0) {
	tab		= Integer.parseInt(request.getParameter("tab"));
} else {
	tab		= 7;
}

query		= "SELECT ID, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE FROM "+ table + where + sort + " LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");

	totalPrice		= (price * 10) + defaultBagPrice;
	//tSalePrice		= (int)Math.round((double)(price * 10) * (double)(100 - 5) / 100) + defaultBagPrice;
}

rs.close();
pstmt.close();
%>

	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.ext.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<input type="hidden" id="tab" value="<%=tab%>" />
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
			<h1>������</h1>
			<div class="pageDepth">
				HOME &gt; SHOP &gt; <strong>������</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="eleven columns offset-by-one ">
			<div class="row">
				<h3 class="marb20">�ս��� �Ļ� ���̾�Ʈ �Ѵ��� ����</h3>
				<div class="twothird last col">
					<div class="quizindiet">
						<ul class="quizintab">
							<li class="quizinA current">
								<a href="javascript:;" onClick="cngMenu(7);"></a>
							</li>
							<li class="quizinB">
								<a href="javascript:;" onClick="cngMenu(8);"></a>
							</li>
							<li class="alaCool">
								<a href="javascript:;" onClick="cngMenu(9);"></a>
							</li>
							<li class="alaCoolB">
								<a href="javascript:;" onClick="cngMenu(10);"></a>
							</li>
						</ul>
						<div class="quizinlist">
							
							
					
						</div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<!-- End eleven columns offset-by-one -->
		<form name="frm_order" id="frm_order" method="post">
			<input type="hidden" name="mode" value="addCart" />
			<input type="hidden" name="cart_type" id="cart_type" />
			<input type="hidden" name="group_id" id="group_id" value="<%=groupId%>" />
			<input type="hidden" name="gubun2" id="gubun2" />
			<input type="hidden" name="price" id="price" value="<%=price%>" />
			<input type="hidden" name="set_holiday" id="set_holiday" />
			<input type="hidden" name="sale_type" id="sale_type" value="P" />
			<input type="hidden" name="sale_price" id="sale_price" value="0" />
			<input type="hidden" name="bag_price" id="bag_price" value="<%=defaultBagPrice%>" />
			<div class="sidebar five columns">
				<h3 class="marb20">�ֹ��ϱ�</h3>
				<div class="sideorder">
					<div class="title">������ǰ ����</div>
					<div class="itembox">
						<ul class="badgecount">
							<li>
								<span class="badge">1</span>
								<p>��۰������� �˻�<br /><font style="font-weight:normal; color:#777;">����� ������ �������� Ȯ��</font></p>
								<div class="button small dark"> <a class="lightbox" href="/shop/popup/deliverypossi.jsp?lightbox[width]=600&lightbox[height]=600">�˻�</a></div>
							</li>
							<li>
								<span class="badge">2</span>
								<p>1�� ��޽ļ��� ����</p>
								<div class="ordernum">
									<span class="active"><a class="ordernum-one" href="javascript:;" onClick="getGroup(0);"></a>1��1��</span>
									<span><a class="ordernum-two" href="javascript:;" onClick="getGroup(1);"></a>1��2��</span>
									<span class="last"><a class="ordernum-three" href="javascript:;" onClick="getGroup(2);"></a>1��3��</span>
									<div class="clear"></div>
								</div>
							</li>
							<li>
								<span class="badge">3</span>
								<p>���ϳ��ϼ��� �Ļ罺Ÿ���� ����</p>
								<div id="groupSelect">
									<select name="group_code" id="group_code" onChange="selGroup();" style="width:235px;">
										<%
										query		= "SELECT ID, GROUP_NAME FROM  "+ table + where + sort;
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											groupId			= rs.getInt("ID");
											groupName		= rs.getString("GROUP_NAME");
										%>
										<option value="<%=groupId%>"><%=groupName%></option>
										<%
										}
										%>
									</select>
								</div>
							</li>
							<li>
								<span class="badge">4</span>
								<p>�Ļ� �Ⱓ�� ����</p>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="110">
											<select name="devl_day" id="devl_day" style="width:100px;">
												<option value="5" selected="selected">5��</option>
											</select>
										</td>
										<td></td>
										<td width="110">
											<select name="devl_week" id="devl_week" style="width:100px;">
												<option value="2" selected="selected">2��</option>
												<option value="4">4��</option>
											</select>
										</td>
									</tr>
								</table>
							</li>
							<li>
								<span class="badge">5</span>
								<p class="floatleft">ù ����� ����</p>
								<div class="floatright" style="width:140px;">
									<input id="devl_date" class="dp-applied date-pick" name="devl_date" readonly />
								</div>	
								<div class="clear"></div>
							</li>
							<li>
								<span class="badge">6</span>
								<p class="floatleft">����</p>
								<div class="quantity floatright" style="width:140px;">
									<input class="minus" type="button" value="-" />
									<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly />
									<input class="plus" type="button" value="+" />
								</div>
								<div class="clear"></div>
							</li>
							<li id="addOption">
								<span class="badge">7</span>
								<p class="floatleft">�ɼǻ�ǰ</p>
								<div class="floatright" style="width:140px;" id="optionSelect">
									<select name="add_goods" id="add_goods" style="width:140px;">
										<option value="0" selected="selected">����</option>
										<option value="2500">���� �뷱������ũ1��</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</div>
				</div>
				<div class="divider"></div>
				<div class="addoption">
					<div class="title">���ð��� ����</div>
					<div class="itembox">
						<ul class="badgecount">
							<li>
								<span class="badge add">1</span>
								<p>
									<input name="buy_bag" id="buy_bag" type="checkbox" value="Y" checked="checked" /> ���ð��� ���� (<%=nf.format(defaultBagPrice)%>��)<br />
									<font style="font-weight:normal; color:#777;">���ð����� �ʼ��� �����ϼž� ��ǰ�� �ż��ϰ� ����� �� �ֽ��ϴ�.</font>
								</p>
							</li>
						</ul>
					</div>
				</div>
				<div class="divider"></div> 
				<div class="price-wrapper">
					<!--font style="font-weight:normal; color:#777;">�������� �Ļ�5%, ���α׷�&Ÿ�Ժ� 10% ����</font-->
					<p class="price">
						�Ѱ���:
						<span id="saleDiv" class="hidden">
							<del>
								<span class="amount tprice"><%=nf.format(totalPrice)%>��</span>
							</del>
							<ins>
								<span class="amount" id="sprice"><%=nf.format(tSalePrice)%>��</span>
							</ins>
						</span>
						<span id="nosaleDiv">
							<ins>
								<span class="amount tprice"><%=nf.format(totalPrice)%>��</span>
							</ins>
						</span>
					</p>
					<%if (eslMemberId.equals("")) {%>
					<div class="button large light"><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">��ٱ���</a></div>
					<div class="button large dark iconBtn"><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350"><span class="star"></span>�ٷα���</a></div>
					<%} else {%>
					<div class="button large light"><a href="javascript:;" onClick="addCart('C');">��ٱ���</a></div>
					<div class="button large dark iconBtn"><a href="javascript:;" onClick="addCart('L');"><span class="star"></span>�ٷα���</a></div>
					<%}%>
					<div class="clear"></div>
				</div>  
			</div>
		</form>
		<!-- End sidebar four columns -->
		<div class="clear"></div>
		<div class="sixteen columns offset-by-one">	
			<div class="divider"></div> 
			<div class="row col">
				<div class="one last col">
					<ul class="tabNavi marb30">
						<li class="active">
							<a href="#detail-item">�� ��ǰ����</a>
						</li>
                        <li>
							<a href="#detail-delivery">��۾ȳ�</a>
						</li>
						<li>
							<a href="#detail-notify">��ǰ���� ��������</a>
						</li>                
						<div class="clear"></div>                  
					</ul>
						
					<div id="detail-item">
						<img src="/images/dietmeal_detail_1.jpg" usemap="#Map" border="0">
                        <map name="Map">
                          <area shape="circle" coords="473,2039,130" href="#" onClick="window.open('/intro/foodmonthplan.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=1013,height=600')">
                        </map>
					</div>
					<div class="divider"></div> 
					<ul class="tabNavi marb30">
						<li>
							<a href="#detail-item">�� ��ǰ����</a>
						</li>
						<li class="active">
							<a href="#detail-delivery">��۾ȳ�</a>
						</li>
						<li>
							<a href="#detail-notify">��ǰ���� ��������</a>
						</li>
						<div class="clear"></div>
					</ul>                   
					<div id="detail-delivery">
						<p><img src="/images/dietmeal_detail_02_1.jpg"></p>
				  </div>
					<div class="divider"></div>
					<ul class="tabNavi marb30">
						<li>
							<a href="#detail-item">�� ��ǰ����</a>
						</li>
						<li>
							<a href="#detail-delivery">��۾ȳ�</a>
						</li>
						<li class="active">
							<a href="#detail-notify">��ǰ���� ��������</a>
						</li>
						<div class="clear"></div>
					</ul>
				  <div id="detail-notify">
                        <table class="orderList clear" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>����</th>
							<th class="last">����</th>
						</tr>
						<tr>
							<td>��ǰ�� ����</td>
							<td style="text-align:left;">�Ｎ�����ǰ</td>
						</tr>
						<tr>
						  <td>������ �� ������</td>
						  <td style="text-align:left;">Ǯ�����ǰ���Ȱ(��)</td>
						  </tr>
						<tr>
						  <td>������</td>
						  <td style="text-align:left;">��� ���� ���ȸ� ������ 35</td>
						  </tr>
						<tr>
						  <td>����ǰ�� ��� ������</td>
						  <td style="text-align:left;">�ش���� ����</td>
						  </tr>
						<tr>
						  <td>��������</td>
						  <td style="text-align:left;">������ ����, 2���� ����� ��ǰ�� ��޵˴ϴ�.<br /><span class="font-maple">�� �ֹ����� �� ������忡�� ���� �ֱٿ� ����� ��ǰ�� �غ��Ͽ�<br />�ż��� ����ϹǷ�, ��Ȯ�� ��������� �ȳ��� ��ƽ��ϴ�.</span></td>
						  </tr>
						<tr>
						  <td>�������</td>
						  <td style="text-align:left;">���� �ð����� ���� 52�ð� �̳�</td>
						  </tr>
						<tr>
						  <td>�߷� �� ����</td>
						  <td style="text-align:left;">�� ���Ϻ� 150g ~ 600g</td>
						  </tr>
						<tr>
						  <td>����� �� �Է�</td>
						  <td style="text-align:left;">�� �޴��� �������� ����</td>
						  </tr>
						<tr>
						  <td>������ �����ս�ǰ ����</td>
						  <td style="text-align:left;">�ش���� ����</td>
						  </tr>
						<tr>
						  <td>�����ƽ�, ü������ ��ǰ<br />ǥ�ñ��� ����������</td>
						  <td style="text-align:left;">�ش���� ����</td>
						  </tr>
						<tr>
						  <td>���Խ�ǰ:<br /><span class="font-maple">��ǰ�������� ���� ���ԽŰ� ����</span></td>
						  <td style="text-align:left;">�ش���� ����</td>
						  </tr>
						<tr>
						  <td>�������� ����ó</td>
						  <td style="text-align:left;">Ǯ���� ������ݼ��� 080-022-0085(�����ںδ�)</td>
						  </tr>
				    </table>
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
	cngMenu($("#tab").val());

	$(".date-pick").datepick({ 
		dateFormat: "yyyy.mm.dd",
		minDate: +6,
		onDate: $.datepick.noWeekend,
		showTrigger: '#calImg'
	});

	$("a").attr("onfocus", "this.blur()");

	$("#devl_day").change(cngDay);

	$("#devl_week").change(function() {
		var addPrice	= parseInt($("#add_goods").val());
		$("#set_holiday").val("");
		totalPrice	= getTprice();
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		getSalePrice();
	});
	$(".plus").click(function() {
		var addPrice	= parseInt($("#add_goods").val());
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty < 9) buyQty		+= 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= (addPrice + parseInt($("#price").val())) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
		$("#buy_qty").val(buyQty);
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		getSalePrice();
	});
	$(".minus").click(function() {
		var addPrice	= parseInt($("#add_goods").val());
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty > 1) buyQty		= buyQty - 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= (addPrice + parseInt($("#price").val())) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		$("#buy_qty").val(buyQty);
		getSalePrice();
	});
	$("#buy_bag").click(function() {
		var addPrice	= parseInt($("#add_goods").val());
		totalPrice	= getTprice();
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		getSalePrice();
	});

	$("#add_goods").change(optionCng);
});

(function($) {
	$.extend($.datepick, {
		noSundays: function(date) {
			return {selectable: date.getDay() != 0};
		},
		noWeekend: function(date) {
			return {selectable: date.getDay() != 0  && date.getDay() != 6};
		}
	});
})(jQuery);

function optionCng() {
	var addPrice	= parseInt($("#add_goods").val());
	totalPrice	= getTprice();
	$(".tprice").text(commaSplit(totalPrice)+ "��");
	var buyQty		= parseInt($("#buy_qty").val());
	var bagPrice	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	getSalePrice();
}

function cngDay() {
	var addPrice	= parseInt($("#add_goods").val());
	$("#set_holiday").val("");
	var devlDay		= $("#devl_day").val();
	$(".date-pick").datepick('clear');
	$(".date-pick").datepick('destroy');
	if (devlDay == 5) {
		$(".date-pick").datepick({ 
			dateFormat: "yyyy.mm.dd",
			minDate: +6,
			onDate: $.datepick.noWeekend,
			showTrigger: '#calImg'
		});
	} else {
		$(".date-pick").datepick({ 
			dateFormat: "yyyy.mm.dd",
			minDate: +6,
			onDate: $.datepick.noSundays,
			showTrigger: '#calImg'
		});
	}
	totalPrice	= getTprice();
	$(".tprice").text(commaSplit(totalPrice)+ "��");
	getSalePrice();
}

function cngMenu(num) {
	$(".quizintab li").removeClass("current");
	if (num == 4) {
		$(".quizinA").css("z-index", "10");
		$(".quizinB").css("z-index", "7");
		$(".alaCool").css("z-index", "4");
		$(".alaCoolB").css("z-index", "1");
		$("#titleImg").attr("src", "/images/headcopy_04.png");
		$("#topImg1").attr("src", "/images/snack_subject.png");
		$("#topImg2").attr("src", "/images/quizinA_feature.png");
		$(".foodlist").addClass("hidden");
		$(".snack").addClass("current");
		$(".snacklist").removeClass("hidden");
	} else {
		$.post("dietMeal_ajax.jsp", {
			mode: 'cngMenu',
			cate_id: num
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					var menuArr		= "";
					var menuHtml	= "";
					var i			= 0;
					var divNum		= 0;
					var divClass	= "";

					$(data).find("menu").each(function() {
						divNum		= i % 4;
						if (divNum == 0) {
							divClass	= " first";
						} else if (divNum == 3) {
							divClass	= " last";
						} else {
							divClass	= "";
						}

						menuArr			= $(this).text().split("|");
						menuHtml		+= '<div class="food'+ divClass +'">';
						menuHtml		+= '<div>';
						menuHtml		+= '<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id='+ menuArr[0] +'" title="'+ menuArr[2] +'"><img src="'+ menuArr[1] +'" alt="'+ menuArr[2] +'" /></a> ';
						menuHtml		+= '<a class="food-link lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id='+ menuArr[0] +'">';
						menuHtml		+= '<div class="food-calorie">'+ menuArr[3] +'</div>';
						menuHtml		+= '<div class="food-title">'+ menuArr[2] +'</div>';
						menuHtml		+= '</a>';
						menuHtml		+= '</div>';
						menuHtml		+= '</div>';

						$(".foodlist").removeClass("hidden");
						$(".snacklist").addClass("hidden");
						
						$("."+ menuArr[4]).addClass("current");						
						$("#titleImg").attr("src", "/images/"+ menuArr[5] +".png");
						$("#topImg1").attr("src", "/images/"+ menuArr[6] +".png");
						$("#topImg2").attr("src", "/images/"+ menuArr[7] +".png");
						
						if (num == 7) {
							$(".quizinA").css("z-index", "10");
							$(".quizinB").css("z-index", "7");
							$(".alaCool").css("z-index", "4");
							$(".alaCoolB").css("z-index", "1");
						} else if (num == 8) {
							$(".quizinA").css("z-index", "1");
							$(".quizinB").css("z-index", "10");
							$(".alaCool").css("z-index", "7");
							$(".alaCoolB").css("z-index", "4");
						} else if (num == 9) {
							$(".quizinA").css("z-index", "1");
							$(".quizinB").css("z-index", "4");
							$(".alaCool").css("z-index", "10");
							$(".alaCoolB").css("z-index", "7");
						} else if (num == 10) {
							$(".quizinA").css("z-index", "1");
							$(".quizinB").css("z-index", "4");
							$(".alaCool").css("z-index", "7");
							$(".alaCoolB").css("z-index", "10");
						}
						i++;
					});

					$(".foodlist").html(menuHtml);
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
}

function getTprice() {
	var addPrice	= parseInt($("#add_goods").val());
	var buyQty		= parseInt($("#buy_qty").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var totalPrice;
	if (addPrice > 0 ) {
		totalPrice		= (addPrice + parseInt($("#price").val())) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty;
		totalPrice		= totalPrice + parseInt(bag_price);
	} else {
		totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
	}

	return totalPrice;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("dietMeal_ajax.jsp", $("#frm_order").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if (!$("#set_holiday").val() && $(this).text() == 'setHoliday') {
				window.open("popup/deliveryDate.jsp?devl_date="+ $("#devl_date").val() +"&devl_day="+ $("#devl_day").val() +"&devl_week="+ $("#devl_week").val() +"&gid="+ $("#group_code").val(),'popDelivery','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=960,height=500');
			} else if ($(this).text() == "success") {
				if (t == 'C') {
					$.lightbox("/shop/cartConfirm.jsp?lightbox[width]=960&lightbox[height]=500");
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

function getGroup(num) {
	$(".ordernum span").removeClass("active");
	$(".ordernum span:eq("+ num +")").addClass("active");
	$("#set_holiday").val("");
	var addPrice;
	if (num > 0) {
		addPrice	= 0;
	} else {
		addPrice	= parseInt($("#add_goods").val());
	}

	$.post("dietMeal_ajax.jsp", {
		mode: 'getGroup',
		gubun2: num + 1
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {				
				var addOptions		= '<select name="add_goods" id="add_goods" style="width:140px;" onchange="optionCng();">';
				addOptions		+= '<option value="0" selected="selected">����</option>';
				addOptions		+= '<option value="2500">���� �뷱������ũ1��</option>';
				addOptions		+= "</select>";
				if (num > 0) {
					$("#addOption").addClass("hidden");
					$("#optionSelect").html(addOptions);
					$("#add_goods").selectBox();
					$("#saleDiv").addClass("hidden");
					$("#nosaleDiv").removeClass("hidden");
				} else {
					$("#addOption").removeClass("hidden");
					$("#optionSelect").html(addOptions);
					$("#add_goods").selectBox();
				}
				var groupArr		= "";
				var groupOptions	= '<select name="group_code" id="group_code" class="formsel" onchange="selGroup();" style="width:235px;">';
				var i				= 0;
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					groupOptions	+= '<option value="'+ groupArr[0] +'">'+ groupArr[1] +"</option>\n";
					if (i == 0) {
						$("#group_id").val(groupArr[0]);
						$("#price").val(groupArr[2]);
						totalPrice	= getTprice();
						$(".tprice").text(commaSplit(totalPrice)+ "��");
					}
					i++;
				});
				groupOptions	+= "</select>"
				$("#groupSelect").html(groupOptions);
				$("#group_code").selectBox();
				getSalePrice();
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$(".ordernum span").removeClass("active");
						$("#group_id").val("");
						$("#price").val(0);
						totalPrice	= getTprice();
						$(".tprice").text(commaSplit(totalPrice)+ "��");
					});
				});
			}
		});
	}, "xml");
	return false;
}

function selGroup() {
	var addPrice		= parseInt($("#add_goods").val());
	var groupCode	= $("#group_code").val();
	$("#set_holiday").val("");
	$.post("dietMeal_ajax.jsp", {
		mode: 'selGroup',
		group_id: groupCode
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var addOptions		= '<select name="add_goods" id="add_goods" style="width:140px;" onchange="optionCng();">';
				addOptions		+= '<option value="0" selected="selected">����</option>';
				addOptions		+= '<option value="2500">���� �뷱������ũ1��</option>';
				addOptions		+= "</select>";
				if (groupCode == 32 || groupCode == 33 || groupCode == 34 || groupCode == 43) {
					$("#addOption").removeClass("hidden");
					$("#optionSelect").html(addOptions);
					$("#add_goods").selectBox();
				} else {
					$("#addOption").addClass("hidden");
					$("#optionSelect").html(addOptions);
					$("#add_goods").selectBox();					
				}
				var groupArr		= "";
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					$("#group_id").val(groupArr[0]);
					$("#price").val(groupArr[1]);
					totalPrice	= getTprice();
					$(".tprice").text(commaSplit(totalPrice)+ "��");
					getSalePrice();
				});
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$("#group_id").val("");
					});
				});
			}
		});
	}, "xml");
	return false;
}

function getSalePrice() {
	var groupCode	= $("#group_code").val();
	var buyQty		= parseInt($("#buy_qty").val());
	var bagPrice	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var salePrice	= $("#sale_price").val();
	var saleType	= $("#sale_type").val();
	var totalPrice	= getTprice();
	if (parseInt(salePrice) > 0 && saleType) {
		$("#saleDiv").removeClass("hidden");
		$("#nosaleDiv").addClass("hidden");
		if (saleType == "W") {
			salePrice	= (totalPrice - bagPrice) - salePrice + bagPrice;
		} else {
			salePrice	= Math.round(parseFloat(totalPrice - bagPrice) * (100 - parseFloat(salePrice)) / 100) + bagPrice;
		}
		$("#sprice").text(commaSplit(salePrice)+ "��");
	} else {
		$("#saleDiv").addClass("hidden");
		$("#nosaleDiv").removeClass("hidden");
	}
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>