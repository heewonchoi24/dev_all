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
String groupCode	= "";
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
String where			= " WHERE GUBUN1 = '03' AND GUBUN2 = '31'";
String sort				= " ORDER BY ID DESC";

query		= "SELECT ID, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE, GROUP_CODE FROM "+ table + where + sort + " LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");
	groupCode		= rs.getString("GROUP_CODE");

	totalPrice		= price * 6 + defaultBagPrice;
	//tSalePrice		= (int)Math.round((double)(price * 6) * (double)(100 - 10) / 100) + defaultBagPrice;
	
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

<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
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
            <h1>�����</h1>
            <div class="pageDepth">
                HOME &gt; SHOP &gt; Ÿ�Ժ� ���̾�Ʈ &gt; <strong>��ũ������</strong>
            </div>
            <div class="clear"></div>
        </div>
        <div class="eleven columns offset-by-one ">
            <div class="row">
                <h3 class="marb20">�ս��� Ÿ�Ժ� ���̾�Ʈ</h3>
                <ul class="quizintab_">
                    <li class="quizinA" style="z-index:0">
						<a href="minimeal.jsp"></a>
                    </li>
                    <li class="alaCool current">
						<a href="secretSoup.jsp"></a>
                    </li>
                </ul>
                <div class="twothird last col" style="width:606px !important; float:right;">
                    <div class="dietcontent">
                        <div class="head">
                            <p class="f18 bold8">6���� ä����</p>
                            <p class="f24 bold8">��ũ������(Hot)</p>
                            <div class="balloon"><img src="/images/balloon-100cal.png" width="67" height="83"></div>
                        </div>
                        <p class="mart20 marb20"><strong class="f14">6���� �������</strong> ���̼��� �ݶ���� ����<strong class="f14">Ȩ���̵� Ÿ���� ����!</p>
                        <div class="marb10"><img src="/images/secretsoup2.jpg" width="637" height="314"></div>
                        <ul class="ssoup-list">
                            <li style="width:187px !important;">
                            <a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=62">
                            <img src="/images/ssoup_01_01.jpg" width="185" height="139" alt="����Ʈ���丶��ǳ���">
                            <p>����Ʈ���丶��ǳ���</p>
                            </a>
                            </li>
                            </a>
                            <li style="width:186px !important;">
                            <a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=63">
                            <img src="/images/ssoup_02_01.jpg" width="185" height="139" alt="���������">
                            <p>���������</p>
                            </a>
                            </li>
                            <li class="last" style="width:187px !important;">
                            <a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=64">
                            <img src="/images/ssoup_03_01.jpg" width="185" height="139" alt="�߰�����̿����">
                            <p>�߰�����̿����</p>
                            </a>
                            </li>
                            <div class="clear"></div>
                        </ul>
                        <div class="clear"></div>
                    </div>
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
        <input type="hidden" name="devl_day" id="devl_day" value="6" />
        <input type="hidden" name="sale_type" id="sale_type" value="<%=saleType%>" />
        <input type="hidden" name="sale_price" id="sale_price" value="<%=salePrice%>" />
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
                        <div class="button small dark"><a class="lightbox" href="/shop/popup/deliverypossi.jsp?lightbox[width]=600&lightbox[height]=600">�˻�</a></div>
                        </li>
                        <li>
                        <span class="badge">2</span>
                        <p>��� ��Ÿ���� ����</p>
                        <select name="ss_type" id="ss_type" style="width:160px;">
                        <option value="0">����(��~��)-��12��/��</option>
                        <option value="1">��3ȸ(������)-��6��/��</option>
                        <option value="2">��3ȸ(ȭ����)-��6��/��</option>
                        </select>
                        </li>
                        <li>
                        <span class="badge">3</span>
                        <p>��۱Ⱓ ����</p>
                        <span id="type_sel">
                        <select name="devl_week" id="devl_week" style="width:130px;" onChange="setTprice();">
                        <option value="1">1��</option>
                        <option value="2">2��</option>
                        <option value="4">4��</option>
                        </select>
                        </span>
                        </li>
                        <li>
                        <span class="badge">4</span>
                        <p class="floatleft">ù ����� ����</p>
                        <div class="floatright">
                            <input id="devl_date" class="dp-applied date-pick" name="devl_date" readonly />
                        </div>
                        <div class="clear"></div>
                        </li>
                        <li>
                        <span class="badge">5</span>
                        <p class="floatleft">����</p>
                        <div class="quantity floatright">
                            <input class="minus" type="button" value="-" />
                            <input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly />
                            <input class="plus" type="button" value="+" />
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
                <font style="font-weight:bold; color:blue;"><%=saleTitle%></font>
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
        <div class="divider"></div>
        <div class="sixteen columns offset-by-one">
            <!--div class="row col grayhalf">
				<h4 class="font-blue marb10">��ǰ����</h4>
				<div class="oneinhalf">
					<a href="#" title="�ս������� ���̾�Ʈ ����">
						<img class="thumbleft" src="/images/notice_sample.jpg" width="160" height="108" title="[����]�ս��� ���� ����ȳ� (�Ұ�� �����)" />
						<span class="meta"><strong>POST BY</strong> hong1004</span>
						<span class="post-title">
							<h3>�ս������� ���̾�Ʈ ����</h3>
							<p>�ȳ��ϼ���. �ս����Դϴ�. �ս����� ���ɸ޴��� "�Ұ������"�� 5�� 30��(��) �����к��� "�����"���� ���� ������ �����Դϴ�. �ż��� �޴� ������ ���� ���� �����ǿ���...</p>
						</span>
					</a>
				</div>
				<div class="oneinhalf last">
					<a href="#" title="�ս������� ���̾�Ʈ ����">
						<img class="thumbleft" src="/images/notice_sample.jpg" width="160" height="108" title="[����]�ս��� ���� ����ȳ� (�Ұ�� �����)" />
						<span class="meta"><strong>POST BY</strong> hong1004</span>
						<span class="post-title">
							<h3>�ս������� ���̾�Ʈ ����</h3>
							<p>�ȳ��ϼ���. �ս����Դϴ�. �ս����� ���ɸ޴��� "�Ұ������"�� 5�� 30��(��) �����к��� "�����"���� ���� ������ �����Դϴ�. �ż��� �޴� ������ ���� ���� �����ǿ���...</p>
						</span>
					</a>
				</div>
				<div class="clear"></div>
			</div-->
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
                        <a href="#detail-notify">��ǰ���� �������</a>
                        </li>
                        <div class="clear"></div>
                    </ul>
                    <div id="detail-item">
                      <!--  <p class="marb40"><img src="/images/detail_tit.gif" alt="������" width="296" height="65"></p> -->
                        <p><img src="/images/detail_sample_soup2.jpg"></p>
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
                        <a href="#detail-notify">��ǰ���� �������</a>
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
                        <a href="#detail-notify">��ǰ���� �������</a>
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
                            <td style="text-align:left;">�Ｎ������ǰ</td>
                        </tr>
                        <tr>
                            <td>������ �� ������</td>
                            <td style="text-align:left;">Ǯ�����ǰ���Ȱ(��)</td>
                        </tr>
                        <tr>
                            <td>������</td>
                            <td style="text-align:left;">��� ���� ���ȸ� ����� 35</td>
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
                            <td style="text-align:left;">9��</td>
                        </tr>
                        <tr>
                            <td>����� �� �Է�</td>
                            <td style="text-align:left;">�Ĵ��� ���Ϻ� �޴��� Ŭ���Ͻø� �丮�� ����� �� �Է��� Ȯ���Ͻ� �� �ֽ��ϴ�.</td>
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
                            <td>������ ����ó</td>
                            <td style="text-align:left;">Ǯ���� ����ݼ��� 080-022-0085(�����ںδ�)</td>
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
getSalePrice();

$(".date-pick").datepick({
dateFormat: "yyyy.mm.dd",
minDate: +6,
onDate: $.datepick.noSundays,
showTrigger: '#calImg'
});
$("a").attr("onfocus", "this.blur()");
$("#ss_type").change(cngWeek);
$(".plus").click(function() {
var devl_day	= $("#devl_day").val();
var buyQty		= parseInt($("#buy_qty").val());
if (buyQty < 9) buyQty		+= 1;
var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt(devl_day) * buyQty + parseInt(bag_price);
$("#buy_qty").val(buyQty);
$(".tprice").text(commaSplit(totalPrice)+ "��");
getSalePrice();
});
$(".minus").click(function() {
var devl_day	= $("#devl_day").val();
var buyQty		= parseInt($("#buy_qty").val());
if (buyQty > 1) buyQty		= buyQty - 1;
var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt(devl_day) * buyQty + parseInt(bag_price);
$(".tprice").text(commaSplit(totalPrice)+ "��");
$("#buy_qty").val(buyQty);
getSalePrice();
});
$("#buy_bag").click(setTprice);
});

(function($) {
$.extend($.datepick, {
noSundays: function(date) {
return {selectable: date.getDay() != 0};
},
noOdd: function(date) {
return {selectable: date.getDay() != 0 && date.getDay() != 1 && date.getDay() != 3 && date.getDay() != 5};
},
noEven: function(date) {
return {selectable: date.getDay() != 0 && date.getDay() != 2 && date.getDay() != 4 && date.getDay() != 6};
}
});
})(jQuery);

function getTprice() {
	var devl_day	= $("#devl_day").val();
	var buyQty		= parseInt($("#buy_qty").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt(devl_day) * buyQty + parseInt(bag_price);

	return totalPrice;
}

function setTprice() {
	totalPrice	= getTprice();
	$(".tprice").text(commaSplit(totalPrice)+ "��");
	getSalePrice();
}

function cngWeek() {
	var devlType		= $("#ss_type").val();
	var typeOptions	= '<select name="devl_week" id="devl_week" style="width:130px;" onchange="setTprice();">';
	$(".date-pick").datepick('clear');
	$(".date-pick").datepick('destroy');
	if (devlType == "0") {
		typeOptions	+= '<option value="1">1��</option>';
		typeOptions	+= '<option value="2">2��</option>';
		typeOptions	+= '<option value="4">4��</option>';
		$(".date-pick").datepick({
		dateFormat: "yyyy.mm.dd",
		minDate: +6,
		onDate: $.datepick.noSundays,
		showTrigger: '#calImg'
		});
	}
	else {
		typeOptions	+= '<option value="1">2��</option>';
		typeOptions	+= '<option value="2">4��</option>';
		typeOptions	+= '<option value="4">8��</option>';
		if (devlType == "1") {
			$(".date-pick").datepick({
			dateFormat: "yyyy.mm.dd",
			minDate: +6,
			onDate: $.datepick.noEven,
			showTrigger: '#calImg'
			});
		}
		else {
			$(".date-pick").datepick({
			dateFormat: "yyyy.mm.dd",
			minDate: +6,
			onDate: $.datepick.noOdd,
			showTrigger: '#calImg'
			});
		}
	}

	typeOptions	+= "</select>"
	$("#type_sel").html(typeOptions);
	$("#devl_week").selectBox();
	setTprice();
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("secretSoup_ajax.jsp", $("#frm_order").serialize(),
	function(data) {
	$(data).find("result").each(function() {
	if ($(this).text() == "success") {
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
			if ( $("#ss_type").val() == "0" ) {
				salePrice	= (totalPrice - bagPrice) - salePrice * parseInt($("#devl_week").val()) * 6 * buyQty + bagPrice;
			} else { 
				salePrice	= (totalPrice - bagPrice) - salePrice * parseInt($("#devl_week").val()) * 6 * buyQty + bagPrice;
			}
			
			
		}
		else {
			salePrice	= Math.round(parseFloat(totalPrice - bagPrice) * (100 - parseFloat(salePrice)) / 100) + bagPrice;
		}
		$("#sprice").text(commaSplit(salePrice)+ "��");
	}
	else {
		$("#saleDiv").addClass("hidden");
		$("#nosaleDiv").removeClass("hidden");
	}
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>
