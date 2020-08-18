<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String query			= "";
int groupId				= 0;
int price				= 0;
int totalPrice			= 0;
int realPrice			= 0;
int tSalePrice			= 0;
String groupInfo		= "";
String groupCode		= "";
String offerNotice		= "";
String groupName		= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
String saleTitle = 	"";
String saleType = 	"";
int salePrice = 	0;
String useGoods = 	"";
NumberFormat nf			= NumberFormat.getNumberInstance();
String table			= " ESL_GOODS_GROUP";
String where			= " WHERE GUBUN1 = '02' AND GUBUN2 = '28'";
String sort				= " ORDER BY ID ASC";

query		= "SELECT ID, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE, GROUP_CODE FROM "+ table + where + sort + " LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");
	groupCode		= rs.getString("GROUP_CODE");

	totalPrice		= price + defaultBagPrice;
	
	String where1			= " WHERE  ('"+today+"' BETWEEN STDATE AND LTDATE) AND (GROUP_CODE = '"+groupCode+"'  or GROUP_CODE is null) ";
	String sort1			=  " ORDER BY ES.ID DESC";
	query		= "SELECT TITLE, SALE_TYPE, SALE_PRICE, USE_GOODS FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID " + where1 + sort1 + " LIMIT 0, 1";
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();

	if (rs.next()) {		
		saleTitle			= rs.getString("TITLE");
		saleType			= rs.getString("SALE_TYPE");
		salePrice		= rs.getInt("SALE_PRICE");
		useGoods		= rs.getString("USE_GOODS");
		
		if (saleType.equals("P")) {
			tSalePrice		= (int)Math.round((double)(price * 10) * (double)(100 - salePrice) / 100) + defaultBagPrice;
		} else {
			tSalePrice		= (int)Math.round((double)( (price - salePrice) * 10)) + defaultBagPrice;
		}
		
	}	
}

rs.close();
pstmt.close();
%>

	<link rel="stylesheet" type="text/css" href="/mobile/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.ext.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
		<ul class="subnavi">
			<li><a href="/mobile/shop/dietMeal.jsp">�Ļ���̾�Ʈ</a></li>
			<li class="current"><a href="/mobile/shop/weight2weeks.jsp">���α׷����̾�Ʈ</a></li>
			<li><a href="/mobile/shop/minimeal.jsp">Ÿ�Ժ����̾�Ʈ</a></li>
			<li><a href="/mobile/shop/dietCLA.jsp">Ǯ��Ÿ</a></li>
		</ul>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<form name="frm_order" id="frm_order" method="post">
		<input type="hidden" name="mode" value="addCart" />
		<input type="hidden" name="cart_type" id="cart_type" />
		<input type="hidden" name="group_id" id="group_id" value="<%=groupId%>" />
		<input type="hidden" name="price" id="price" value="<%=price%>" />
		<input type="hidden" name="sale_type" id="sale_type" value="<%=saleType%>" />
		<input type="hidden" name="sale_price" id="sale_price" value="<%=salePrice%>" />
		<input type="hidden" name="bag_price" id="bag_price" value="<%=defaultBagPrice%>" />
		<div id="content" style="margin-top:135px;">
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">Ŭ���� ���α׷� ��ǰ����</span></span></h1>
			<div class="row bg-gray">
				<ul class="itembox">
					<li>
						<h3>��۰������� Ȯ��</h3>
						<p>��۰��� �������� Ȯ���� �ּ���.</p>
						<a href="/mobile/shop/popup/deliverypossi.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c iframe"><span class="ui-btn-inner"><span class="ui-btn-text">�˻�</span></span></a>
					</li>
					<li>
						<h3>�Ļ� �Ⱓ�� ����</h3>
						<ul class="form-line ui-inline2">
							<li>
								<div class="select-box">
									<select name="devl_week" id="devl_week" style="width:100px;">
										<option value="27">1��</option>
										<option value="28" selected="selected">2��</option>
										<option value="29">4��</option>
									</select>
								</div>
							</li>
							<div class="clear"></div>
						</ul>
						<input type="hidden" name="gubun3" id="gubun3" value="2" />
						<!--h3>���α׷� ����Ⱓ</h3>
						<p>4��(�ָ� ����, ���� 20�ϵ��� ���� ���)</p-->
					</li>
					<li>
						<h3>ù ����� ����</h3>
						<div>
							<input id="devl_date" name="devl_date" class="date-pick" readonly="readonly" />
						</div>	
						<div class="clear"></div>
					</li>
					<li>
						<h3>��������</h3>
						<div class="quantity" style="width:100%;">
							<input class="minus" type="button" value="-" />
							<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly="readonly" />
							<input class="plus" type="button" value="+" />
						</div>
						<div class="clear"></div>
					</li>
					<li>
						<input name="buy_bag" id="buy_bag" type="checkbox" value="Y" checked="checked" />
						<label for="buy_bag"><span></span><strong class="f16">���ð��� ����</strong></label>
						<p class="font-green">���ð����� �ʼ��� �����ϼž� ��ǰ�� �ż��ϰ� ��۹����� �� �ֽ��ϴ�.</p>
					</li>
				</ul>
			</div>
			<font name="saleTitle" id="saleTitle" style="font-weight:bold; color:blue;" class="<% if ( saleTitle.equals("") )  { out.println("hidden"); }%>"><%=saleTitle%></font>
			<dl class="itemlist redline">
				<dt class="f16">�� ���Ű���</dt>
				<dd class="f16 font-orange">
					<span id="saleDiv" class="hidden">
						<del class="f12 font-brown">
							<span class="tprice"><%=nf.format(totalPrice)%>��</span>
						</del>
						<span id="sprice"><%=nf.format(tSalePrice)%>��</span>
					</span>
					<span id="nosaleDiv">
						<span class="tprice"><%=nf.format(totalPrice)%>��</span>
					</span>
				</dd>
			</dl>
			<div class="grid-navi">
				<table class="navi" border="0" cellspacing="10" cellpadding="0">
					<tr>
						<%if (eslMemberId.equals("")) {%>
						<td><a href="/sso/single_sso.jsp" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">��ٱ���</span></span></a></td>
						<td><a href="/sso/single_sso.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�ٷα���</span></span></a></td>
						<%} else {%>
						<td><a href="javascript:;" onClick="addCart('C');" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">��ٱ���</span></span></a></td>
						<td><a href="javascript:;" onClick="addCart('L');" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�ٷα���</span></span></a></td>
						<%}%>
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
	totalPrice	= getTprice();
	$(".tprice").text(commaSplit(totalPrice)+ "��");
	getSalePrice();

	$(".date-pick").datepick({ 
		dateFormat: "yyyy.mm.dd",
		minDate: +6,
		onDate: $.datepick.noWeekends,
		showTrigger: '#calImg'
	});

	$(".plus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty < 9) buyQty		+= 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * buyQty + parseInt(bag_price);
		$("#buy_qty").val(buyQty);
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		getSalePrice();
	});
	$(".minus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty > 1) buyQty		= buyQty - 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * buyQty + parseInt(bag_price);
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		$("#buy_qty").val(buyQty);
		getSalePrice();
	});
	$("#buy_bag").click(function() {
		totalPrice	= getTprice();
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		getSalePrice();
	});
	
	$("#devl_week").change(function() {

		/*
		if ( parseInt($("#devl_week").val()) == 1 ) {
			$("#price").val(12000);
		} else if ( parseInt($("#devl_week").val()) == 2 ) {
			$("#price").val(20000);
		} else {
			$("#price").val(40000);
		}
		*/
		
		$.post("cleanseProgram_ajax.jsp", {
			mode: 'getGroup',
			gubun2: $("#devl_week").val()
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					var groupArr		= "";
					$(data).find("group").each(function() {
						groupArr			= $(this).text().split("|");

						$("#group_id").val(groupArr[0]);
						$("#price").val(groupArr[2]);
						$("#gubun3").val(groupArr[4]);
						$("#saleTitle").text(groupArr[5]);
						$("#sale_type").val(groupArr[6]);
						$("#sale_price").val(groupArr[7]);

						totalPrice	= getTprice();
						$(".tprice").text(commaSplit(totalPrice)+ "��");
						getSalePrice();
					});
				} else {
					$(data).find("error").each(function() {
						$(data).find("error").each(function() {
							alert($(this).text());
							$("#price").val(0);
							totalPrice	= getTprice();
							$(".tprice").text(commaSplit(totalPrice)+ "��");
						});
					});
				}
				 
			});
		}, "xml");
		
		//totalPrice	= getTprice();
		//$(".tprice").text(commaSplit(totalPrice)+ "��");
		//getSalePrice();	
	
	});	
});

function getTprice() {
	var buyQty		= parseInt($("#buy_qty").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var totalPrice	= parseInt($("#price").val()) * buyQty + parseInt(bag_price);

	return totalPrice;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("dietProgram_ajax.jsp", $("#frm_order").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				if (t == 'C') {
					location.href = "cart.jsp";
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

function getGroup() {
	var gubun2Val		= $("#gubun2").val();
	var gubun3Val		= $("#gubun3").val()

	if (gubun2Val == "21") {
		newOptions	= {
			'2' : '2�ְ�',
			'4' : '4�ְ�'
		}

		selectedOption = gubun3Val;
	} else if (gubun2Val == "22") {
		newOptions	= {
			'2' : '2�ְ�'
		}
		selectedOption = "2";
	} else if (gubun2Val == "23") {
		newOptions	= {
			'4' : '4�ְ�'
		}
		selectedOption = "4";
	}
	makeOption(newOptions, $("#gubun3"), selectedOption);

	$.post("dietProgram_ajax.jsp", {
		mode: 'getGroup',
		gubun2: gubun2Val,
		gubun3: $("#gubun3").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				var i				= 0;
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					if (i == 0) {
						$("#group_id").val(groupArr[0]);
						$("#price").val(groupArr[2]);
						$("#detail-item").html(groupArr[3]);
						$("#detail-notify").html(groupArr[4]);
						totalPrice	= getTprice();
						$(".tprice").text(commaSplit(totalPrice)+ "��");
					}
					i++;
				});
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

function getSalePrice() {
	var buyQty		= parseInt($("#buy_qty").val());
	var bagPrice	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var salePrice	= $("#sale_price").val();
	var saleType	= $("#sale_type").val();
	var totalPrice	= getTprice();
	if (parseInt(salePrice) > 0 && saleType) {
		$("#saleDiv").removeClass("hidden");
		$("#nosaleDiv").addClass("hidden");
		if (saleType == "W") {
			salePrice	= (totalPrice - bagPrice) - salePrice * buyQty + bagPrice;
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