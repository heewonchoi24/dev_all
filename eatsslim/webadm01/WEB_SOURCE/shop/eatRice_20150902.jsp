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
String where			= " WHERE GUBUN1 = '03' AND GUBUN2 = '34' AND USE_YN = 'Y'";
String sort				= " ORDER BY ID ASC";

query		= "SELECT ID, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE FROM "+ table + where + sort + " LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");

	totalPrice		= price * 3;
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
                HOME &gt; SHOP &gt; Ÿ�Ժ� ���̾�Ʈ &gt; <strong>�ս��� ���̽�</strong>
            </div>
            <div class="clear"></div>
        </div>
        <div class="eleven columns offset-by-one ">
            <div class="row">
                <h3 class="marb20">�ս��� Ÿ�Ժ� ���̾�Ʈ</h3>
                <ul class="quizintab_">
                    <li class="quizinA">
						<a href="minimeal.jsp"></a>
                    </li>
                    <li class="quizinB current">
						<a href="eatRice.jsp"></a>
                    </li>
                    <li class="alaCool">
						<a href="secretSoup.jsp"></a>
                    </li>
                </ul>
                <div class="twothird last col" style="width:606px !important; float:right;">
                    <div class="dietcontent">
                        <div class="head">
                            <p class="f18 bold8">�丸 �ٲ��� ���ε�, ������ ��ȭ��! </p>
                            <p class="f24 bold8">�ս��� ���̽�</p>
                            <div class="balloon"><img src="/images/balloon-130cal.png" width="67" height="83"></div>
                        </div>
                        <p class="mart20 marb20">�ս������� ��� �����Ƿ� �Ｎ�� ��� 30%Į�θ��� ���� ���� �Ｎ��!</p>
                        <div class="marb10"><img src="/images/rice.jpg" width="637" height="314"></div>
                        <ul class="ssoup-list">
                            <li style="width:138px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=115">
									<img src="/images/rice_01_01.jpg" width="185" height="139" alt="��̰�๫��">
									<p>��̰�๫��</p>
								</a>
                            </li>
                            <li style="width:139px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=116">
									<img src="/images/rice_02_01.jpg" width="185" height="139" alt="�Ƹ���������">
									<p>�Ƹ���������</p>
								</a>
                            </li>
                            <li class="last" style="width:138px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=117">
									<img src="/images/rice_03_01.jpg" width="185" height="139" alt="�����ٱ͸���">
									<p>�����ٱ͸���</p>
								</a>
                            </li>
                            <li style="width:139px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=118">
									<img src="/images/rice_04_01.jpg" width="185" height="139" alt="��������������">
									<p>��������������</p>
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
			<input type="hidden" name="sale_type" id="sale_type" value="P" />
			<input type="hidden" name="sale_price" id="sale_price" value="0" />
			<input type="hidden" name="buy_qty" id="buy_qty" value="3" />
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
							<p>��� �޴� �� ���� ����</p>
							<div class="clear">
								<span style="width:100%;">A: ��̰�๫�� 2ea</span>
								<div class="quantity floatright" style="margin:3px 0 5px 0; width:59%;">
									<input class="minus" type="button" value="-" onclick="setMinus(1);" />
									<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty1" id="buy_qty1" readonly />
									<input class="plus" type="button" value="+" onclick="setPlus(1);" />
								</div>
							</div>
							<div class="clear">
								<span style="width:100%;">B: �Ƹ��������� 2ea</span>
								<div class="quantity floatright" style="margin:3px 0 5px 0; width:59%;">
									<input class="minus" type="button" value="-" onclick="setMinus(2);" />
									<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty2" id="buy_qty2" readonly />
									<input class="plus" type="button" value="+" onclick="setPlus(2);" />
								</div>
							</div>
							<div class="clear">
								<span style="width:100%;">C: �����ٱ͸��� 2ea</span>
								<div class="quantity floatright" style="margin:3px 0 5px 0; width:59%;">
									<input class="minus" type="button" value="-" onclick="setMinus(3);" />
									<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty3" id="buy_qty3" readonly />
									<input class="plus" type="button" value="+" onclick="setPlus(3);" />
								</div>
							</div>
							<div class="clear">
								<span style="width:100%;">D: ������������ 2ea</span>
								<div class="quantity floatright" style="margin:3px 0 5px 0; width:59%;">
									<input class="minus" type="button" value="-" onclick="setMinus(4);" />
									<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="0" data-max="0" data-min="1" name="buy_qty4" id="buy_qty4" readonly />
									<input class="plus" type="button" value="+" onclick="setPlus(4);" />
								</div>
							</div>
							<div class="clear"></div>
							<span style="display:block; color:#623a1e; font-weight:bold; margin-top:5px;">
							<br />
							�ּ� �ֹ��� 3Set���� �����մϴ�.
							</span>
							<div class="clear"></div>
							</li>
						</ul>
					</div>
				</div>
				<div class="divider"></div>
				<div class="price-wrapper">
					<!--font style="font-weight:bold; color:blue;">�ս��� ���� �� 5���� ���� ���! ����ǰ 5% ����!(~6/5)</font-->
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
                        
                        <p><img src="/images/detail_sample_rice.jpg"></p>
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
	if (tcnt < 3) {
		alert("�ּ� �ֹ��� 3Set���� �����մϴ�.");
		$("#buy_qty"+ obj).val(buyQty + 1);
	}

	tcnt	= setTcnt();
	var totalPrice	= parseInt($("#price").val()) * tcnt;
	$(".tprice").text(commaSplit(totalPrice)+ "��");
	getSalePrice();
}

function setTcnt() {
	var tcnt	= parseInt($("#buy_qty1").val()) + parseInt($("#buy_qty2").val()) + parseInt($("#buy_qty3").val()) + parseInt($("#buy_qty4").val());
	$("#buy_qty").val(tcnt);

	return tcnt;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("eatRice_ajax.jsp", $("#frm_order").serialize(),
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
			salePrice	= totalPrice - salePrice;
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
