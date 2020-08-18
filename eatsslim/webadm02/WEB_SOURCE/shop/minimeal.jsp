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
String where			= " WHERE GUBUN1 = '03' AND GUBUN2 = '33' AND USE_YN = 'Y'";
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

	totalPrice		= price * 2;
	
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
                HOME &gt; SHOP &gt; Ÿ�Ժ� ���̾�Ʈ &gt; <strong>�ս��� �̴Ϲ�</strong>
            </div>
            <div class="clear"></div>
        </div>
        <div class="eleven columns offset-by-one ">
            <div class="row">
                <h3 class="marb20">�ս��� Ÿ�Ժ� ���̾�Ʈ</h3>
                <ul class="quizintab_">
                    <li class="quizinA current">
						<a href="minimeal.jsp"></a>
                    </li>
                    <li class="alaCool">
						<a href="secretSoup.jsp"></a>
                    </li>
                </ul>
                <div class="twothird last col" style="width:606px !important; float:right;">
                    <div class="dietcontent">
                        <div class="head">
                            <p class="f18 bold8">Į�θ� �������� ������� �����</p>
                            <p class="f24 bold8">�ս��� �̴Ϲ�</p>
                            <div class="balloon"><img src="/images/balloon-200cal.png" width="67" height="83"></div>
                        </div>
                        <p class="mart20 marb20">�Ѽտ� ��, �����ϰ� ���� �̴��Ź�!</p>
                        <div class="marb10"><img src="/images/minimeal.jpg" width="637" height="314"></div>
                        <ul class="ssoup-list">
                            <li style="width:187px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=120">
									<img src="/images/meal_01_01.jpg" width="185" height="139" alt="�ſ��ѵ������">
									<p>�ſ��ѵ������</p>
								</a>
                            </li>
                            <li style="width:186px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=121">
									<img src="/images/meal_02_01.jpg" width="185" height="139" alt="���������̵���">
									<p>���������̵���</p>
								</a>
                            </li>
                            <li class="last" style="width:187px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=124">
									<img src="/images/meal_03_01.jpg" width="185" height="139" alt="�Ұ�⸶�ĵκκ�����">
									<p>�Ұ�⸶�ĵκκ�����</p>
								</a>
                            </li>
                            <div class="clear"></div>
                        </ul>
                        <ul class="ssoup-list">
							<li style="width:187px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=122">
									<img src="/images/meal_04_01.jpg" width="185" height="139" alt="�������̻�踮����">
									<p>�������̻�踮����</p>
								</a>
							</li>
							<li style="width:186px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=123">
									<img src="/images/meal_05_01.jpg" width="185" height="139" alt="��������ƿ��κΰԻ츮����">
									<p>��������ƿ��κΰԻ츮����</p>
								</a>
							</li>
							<li class="last" style="width:187px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=119">
									<img src="/images/meal_06_01.jpg" width="185" height="139" alt="����̹����͸�������">
									<p>����̹����͸�������</p>
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
			<input type="hidden" name="sale_type" id="sale_type" value="<%=saleType%>" />
			<input type="hidden" name="sale_price" id="sale_price" value="<%=salePrice%>" />
			<input type="hidden" name="buy_qty" id="buy_qty" value="2" />
			<div class="sidebar five columns">
				<h3 class="marb20">�ֹ��ϱ�</h3>
				<div class="sideorder">
					<div class="title">������ǰ ����</div>
					<div class="itembox">
						<ul class="badgecount">
							<li>
								<span class="badge">1</span>
								<p>��۰������� �˻�<br /><font style="font-weight:normal; color:#777;">����� ������ �������� Ȯ��</font></p>
								<div class="button small dark">
								<a href="javascript:;" onclick="window.open('/shop/popup/AddressSearchJiPop.jsp?ztype=0003','chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no')">�˻�</a>
								</div>
							</li>
							<li>
								<span class="badge">2</span>
								<p>��� �޴� �� ���� ����</p>
								<div class="quantity" style="margin:3px 0 5px 0;">
									<span>�ѽ� ��Ʈ(A)</span>
									<input class="minus" type="button" value="-" onclick="setMinus(1);" />
									<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty1" id="buy_qty1" readonly />
									<input class="plus" type="button" value="+" onclick="setPlus(1);" />
								</div>
								<div class="quantity">
									<span>��� ��Ʈ(B) </span>
									<input class="minus" type="button" value="-" style="margin-left:2px;" onclick="setMinus(2);" />
									<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty2" id="buy_qty2" readonly />
									<input class="plus" type="button" value="+" onclick="setPlus(2);" />
								</div>
								<div class="order_menu">
									<div class="hanset">
										<span class="tit" style="font-weight:bold;">�ѽļ�Ʈ ����</span>
										<span>�� �ſ��ѵ��������</span>
										<span>�� �������̻�踮����</span>
										<span>�� ���������̵���</span>
									</div>
									<div class="yangset">
										<span class="tit" style="font-weight:bold;">��ļ�Ʈ ����</span>
										<span>�� ��������ƿ��κΰԻ�<br>&nbsp;&nbsp;������</span>
										<span>�� �Ұ�⸶�ĵκκ�����</span>
										<span>�� ����̹����͸�������</span>
									</div>
								</div>
								<p style="color:#623a1e; font-weight:bold;">
									<br />
									�ּ� �ֹ��� 2Set���� �����մϴ�.
								</p>
								<div class="clear"></div>
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
                <!--        <p class="marb40"><img src="/images/detail_tit.gif" alt="������" width="296" height="65"></p>  -->
                        <p><img src="/images/detail_sample_meal.jpg"></p>
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
                        <p><img src="/images/dietmeal_detail_02_3.jpg"></p>
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
						 <tr>
						  <td>���ǻ���</td>
						  <td style="text-align:left;"><span class="font-maple">�ս����� Į�θ� ���� �Ĵ����� �ӻ��, �����δ� �������� ���ñ� �ٶ��ϴ�.</span></td>
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
	$("a").attr("onfocus", "this.blur()");	
});

function setPlus(obj) {
	var totalPrice	= 0;	
	var buyQty		= parseInt($("#buy_qty"+ obj).val());
	if (buyQty < 9) buyQty		+= 1;
	$("#buy_qty"+ obj).val(buyQty);
	var tcnt	= setTcnt();
	var totalPrice	= parseInt($("#price").val()) * tcnt;
	$(".tprice").text(commaSplit(totalPrice)+ "��");
	getSalePrice();
}

function setMinus(obj) {
	var totalPrice	= 0;	
	var buyQty		= parseInt($("#buy_qty"+ obj).val());
	if (buyQty > 0) buyQty		= buyQty - 1;
	$("#buy_qty"+ obj).val(buyQty);
	var tcnt	= setTcnt();
	if (tcnt < 2) {
		alert("�ּ� �ֹ��� 2Set���� �����մϴ�.");
		$("#buy_qty"+ obj).val(buyQty + 1);
	}

	tcnt	= setTcnt();
	var totalPrice	= parseInt($("#price").val()) * tcnt;
	$(".tprice").text(commaSplit(totalPrice)+ "��");
	getSalePrice();
}

function setTcnt() {
	var tcnt	= parseInt($("#buy_qty1").val()) + parseInt($("#buy_qty2").val());
	$("#buy_qty").val(tcnt);

	return tcnt;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("minimeal_ajax.jsp", $("#frm_order").serialize(),
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
	var salePrice	= $("#sale_price").val();
	var saleType	= $("#sale_type").val();
	var totalPrice	= parseInt($("#price").val()) * buyQty;
	if (parseInt(salePrice) > 0 && saleType) {
		$("#saleDiv").removeClass("hidden");
		$("#nosaleDiv").addClass("hidden");
		if (saleType == "W") {
			salePrice	= totalPrice - salePrice * buyQty;
		} else {
			salePrice	= Math.round(parseFloat(totalPrice) * (100 - parseFloat(salePrice)) / 100);
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
