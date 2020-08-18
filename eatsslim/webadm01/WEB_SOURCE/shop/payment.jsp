<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String promotion	= "";	// ü��� ���θ��

String orderNum		= ut.inject(request.getParameter("ono"));
if (orderNum == null || orderNum.equals("")) {
	ut.jsRedirect(out, "/index.jsp");
	if (true) return;
}

String query		= "";
int tcnt			= 0;
int orderCnt		= 0;
String devlType		= "";
String devlDay		= "";
String devlWeek		= "";
String devlDate		= "";
String devlPeriod	= "";
int price			= 0;
int groupId			= 0;
String buyBagYn		= "";
String gubun1		= "";
String groupName	= "";
String cartImg		= "";
String imgUrl		= "";
int goodsTprice		= 0;
int orderPrice		= 0;
/* int payPrice		= 0; */
int totalPrice		= 0;
int dayPrice		= 0;
int tagPrice		= 0;
int tagPrice1		= 0;
int goodsPrice		= 0;
int devlPrice		= 0;
int devlPrice1		= 0;
int bagPrice		= 0;
int couponPrice		= 0;
int zipCnt			= 0;
String devlCheck	= "";
NumberFormat nf = NumberFormat.getNumberInstance();

String payType			= "";
String rcvName			= "";
String rcvTel			= "";
String rcvHp			= "";
String rcvZipcode		= "";
String rcvAddr1			= "";
String rcvAddr2			= "";
String rcvRequest		= "";
String tagName			= "";
String tagTel			= "";
String tagHp			= "";
String tagZipcode		= "";
String tagAddr1			= "";
String tagAddr2			= "";
String tagRequest		= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
int holidayCnt			= 0;

ArrayList<String> arr_groupName = new ArrayList<String>();
ArrayList<Integer> arr_price = new ArrayList<Integer>();
ArrayList<Integer> arr_price2 = new ArrayList<Integer>();
ArrayList<Integer> arr_orderCnt = new ArrayList<Integer>();
ArrayList<String> arr_groupCode = new ArrayList<String>();

query		= "SELECT COUNT(OG.ID) FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID";
query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
query		+= " AND OG.ORDER_NUM = '"+ orderNum  +"' AND O.MEMBER_ID = '"+ eslMemberId +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //�� ���ڵ� ��
}
rs.close();

if (tcnt < 1) {
	ut.jsRedirect(out, "/index.jsp");
	if (true) return;
}

query		= "SELECT G.GROUP_CODE, OG.GROUP_ID, OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.COUPON_PRICE, DEVL_PRICE, EXP_PROMOTION";
query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID";
query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
query		+= " AND OG.ORDER_NUM = '"+ orderNum  +"' AND O.MEMBER_ID = '"+ eslMemberId +"'";
query		+= " ORDER BY OG.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>

<!-- AT 2018-11-29 -->
<script>
var atltems=[];
</script>
<!-- AT -->

<!-- //���� �ֳθ�ƽ�� ��Ŀ�ӽ� -->
<script>

	//�����ݾ��� �޸� ����
	function removeComma(str){
		var removed_str = parseInt(str.replace(/,/g,""));
		return removed_str;
	}
	//��ǰ���� HTML �±� ����
	function removeHtml(str){
		var removed_str = str.replace(/\<.*?\>/g," ");
		return removed_str;
	 }

	//URL���� ��ǰ�ڵ� �ޱ�
	function getProductCode(strCode){
		var strPCode = strCode;
		strPCode = strPCode.match(/product_no=\d+/);
		strPCode = String(strPCode);
		var intPCode = strPCode.match(/\d+/);
		intPCode = Number(intPCode)

		return intPCode;
	}

	var productName;
	var skuCode;
	var productPrice;
	var orderId = '<%=orderNum%>';
	var totalProductPrice;
	var totalShipFee;

	ga('require', 'ecommerce', 'ecommerce.js');           //���� �ֳθ�ƽ�� ��Ŀ�ӽ� �÷�����


	var v_pnc;
	var v_png;
	var v_ea;
	var v_amt;
	var bizPrdIdx = 0;


</script>
<!-- ���� �ֳθ�ƽ�� �̸�Ŀ�� Ʈ��ŷ STEP1 �� -->

</head>
<body>

<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>�ֹ�/�����Ϸ�</h1>
			<div class="pageDepth">
				<span>HOME</span><span>SHOP</span><strong>�ֹ�/�����Ϸ�</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one ">
			<div class="row">
				<div class="one last col">
					<ul class="order-step">
						<li class="step1"> </li>
						<li class="line"> </li>
						<li class="step2"> </li>
						<li class="line"> </li>
						<li class="step3 current"> </li>
					</ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last center col">
					<h2 class="f26 marb5">�ս����� �̿��� �ּż� �����մϴ�.</h2>
					<p class="f14 marb10">������ �ֹ��� ���������� �Ϸ�Ǿ����ϴ�.<br />
						�ֹ���ۿ� ���� Ȯ���� �α��� ��, '���������� > �ֹ�������ȸ �Ǵ� ���Ķ����'���� Ȯ���Ͻ� �� �ֽ��ϴ�.</p>
					<p class="f14 bold5">(�ֹ���ȣ <a class="orderNum" href="/shop/mypage/orderInfo.jsp?ono=<%=orderNum%>"><%=orderNum%></a>)</p>
				</div>

				<div style="margin:0px auto; width:200px; height:200px;><a href="http://plus.kakao.com/home/oamlw65x"><img src="http://eatsslim.co.kr/images/qrcode_balloon.png" width="200" height="200" alt="�ս���" border="0" /></a></div>
				<div class="one last center col">
					<p class="f14 marb10">�ֹ� ��ȸ �� ����, �̴��� �Ĵ� Ȯ���� �ս��� ���ο���̵� ���� ���ϰ� �̿� �����մϴ�.<br />
						īī���忡�� 'ID/�÷���ģ�� �˻�'�� �̿��Ͽ� <span class="font-maple">'Ǯ���� �ս���'</span>�� ģ�� �߰����ּ���.<br />
					SNS �α��� �� ���� �� ������ SNS�� �α��� ���� ������ �ֹ����� ��ȸ�� �����մϴ�.<br />
					SNS �α��� ���� īī���� �÷���ģ���� ���� ����� ������ �̿��� �Ϻ� ���ѵ˴ϴ�.<br />
					�ֹ� ��ȸ/������ �ս��� Ȩ�������� �̿����ּ���.</p>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4> <span class="f18 font-blue"> �ֹ�/������ǰ </span> </h4>
						<!--div class="floatright button dark small">

						</div-->
					</div>
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>��۱���</th>
							<th>��ǰ��/�ɼ���ǰ��</th>
							<th>��۱Ⱓ</th>
							<th>ù�����</th>
							<th>����</th>
							<th>�ǸŰ���</th>
							<th class="last">�հ�</th>
						</tr>
						<%
						if (tcnt > 0) {
							while (rs.next()) {
								groupId		= rs.getInt("GROUP_ID");
								orderCnt	= rs.getInt("ORDER_CNT");
								devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "�Ϲ�" : "�ù�";
								gubun1		= rs.getString("GUBUN1");
								groupName	= rs.getString("GROUP_NAME");
								couponPrice	= rs.getInt("COUPON_PRICE");
								arr_groupName.add(rs.getString("GROUP_NAME"));
								arr_orderCnt.add(orderCnt);
								arr_groupCode.add(rs.getString("GROUP_CODE"));
								arr_price2.add(rs.getInt("PRICE"));
								promotion		= ut.inject(rs.getString("EXP_PROMOTION"));// ü��� ���θ��

								if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
									devlDate	= rs.getString("WDATE");
									buyBagYn	= rs.getString("BUY_BAG_YN");
									devlDay		= rs.getString("DEVL_DAY");
									devlWeek	= rs.getString("DEVL_WEEK");
									devlPeriod	= devlWeek +"��("+ devlDay +"��)";
									price		= rs.getInt("PRICE");
									/*
									if (buyBagYn.equals("Y")) {
										price -= defaultBagPrice;
									}
									*/
									goodsPrice	= price * orderCnt;
									dayPrice += goodsPrice;
									arr_price.add(goodsPrice);
								} else {
									devlDate	= "-";
									buyBagYn	= "N";
									devlPeriod	= "-";
									price		= rs.getInt("PRICE");
									goodsPrice	= price * orderCnt;
									tagPrice	+= goodsPrice;
									arr_price.add(goodsPrice);
									if (groupId == 15) {
										tagPrice1	+= goodsPrice;
										/* ��ü ������
										if (tagPrice1 > 40000) {
											devlPrice		= 0;
										} else {
											devlPrice		= defaultDevlPrice;
										}
										*/
									} else if (groupId == 52 || groupId == 53) {
										/* ��ü ������
										devlPrice1		= defaultDevlPrice;
										*/
									}
								}

								if(promotion.equals("01")){// ü��� ���θ��	
									devlDate	= rs.getString("WDATE");
									buyBagYn	= "N";
									devlPeriod	= "-";									
									devlPrice	= rs.getInt("DEVL_PRICE");			
								}

								cartImg		= rs.getString("CART_IMG");
								if (cartImg.equals("") || cartImg == null) {
									imgUrl		= "/images/order_sample.jpg";
								} else {
									imgUrl		= webUploadDir +"goods/"+ cartImg;
								}
						%>
						<tr>
							<td><%=devlType%></td>
							<td>
								<div class="orderName">
									<img class="thumbleft" src="<%=imgUrl%>" width="90" />
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
							<td><%=orderCnt%></td>
							<td><%=nf.format(price)%>��</td>
							<td>
								<div class="itemprice"><%=nf.format(goodsPrice)%>��</div>
							</td>
						</tr>

						<script>
							productName =  '<%=groupName%>';
							productName =   removeHtml(productName);
							productPrice =  '<%=price%>';
							productPrice = removeComma(productPrice);

							ga('ecommerce:addItem', {
								'id': orderId,                     	// Transaction ID. Required.
								'name': productName,   				// Product name. Required.
								'category': '',       				// Category or variation.
								'price': productPrice,              // Unit price.
								'quantity': '<%=orderCnt%>'         // Quantity.
							});
						</script>


						<script>
							if (bizPrdIdx == 0) {
								v_pnc = '<%=gubun1%>';
								v_png = '<%=ut.getGubun1Name(gubun1)%>';
								v_ea = '<%=orderCnt%>';
								v_amt = '<%=price%>';
							} else {
								v_pnc += ';' + '<%=gubun1%>';
								v_png += ';' + '<%=ut.getGubun1Name(gubun1)%>';
								v_ea += ';' + '<%=orderCnt%>';
								v_amt += ';' + '<%=price%>';
							}
							bizPrdIdx++;
						</script>
						<%
								if (buyBagYn.equals("Y")) {
									bagPrice	+= defaultBagPrice;// * orderCnt;
						%>
						<tr>
							<td>�Ϲ�</td>
							<td>
								<div class="orderName">
									<img class="thumbleft" src="<%=webUploadDir%>goods/groupCart_0300668.jpg" />
									<h4>���ð���</h4>
								</div>
							</td>
							<td>-</td>
							<td>-</td>
							<td>1</td>
							<td><%=nf.format(defaultBagPrice)%>��</td>
							<td>
								<div class="itemprice"><%=nf.format(defaultBagPrice)%>��</div>
							</td>
						</tr>
						<%
								}
							}

							rs.close();

							orderPrice		= dayPrice + tagPrice + bagPrice;
							goodsTprice		= dayPrice + tagPrice;
							devlPrice		= devlPrice + devlPrice1;

							totalPrice		= orderPrice + devlPrice - couponPrice;
							if (totalPrice < 1) totalPrice = 0;
						%>

						<script>

							totalProductPrice = '<%=totalPrice%>';
							totalProductPrice = removeComma(totalProductPrice);

							totalShipFee = '<%=bagPrice%>';
							totalShipFee = removeComma(totalShipFee);

							ga('ecommerce:addTransaction', {                      //���� �ֳθ�ƽ�� �ֹ����� ����
								'id': orderId,                                        // Transaction ID. Required.
								'affiliation': 'flat iron',                           // Affiliation or store name.
								'revenue': totalProductPrice,                         // Grand Total.
								'shipping': totalShipFee,                             // Shipping.
								'tax': ''                                             // Tax.
							});
						</script>

						<script>
							ga('ecommerce:send');
						</script>

						<SCRIPT type="text/javascript">
						var _TRK_PI = 'ODR';
						var _TRK_PNC = v_pnc;
						var _TRK_PNG = v_png;
						var _TRK_EA = v_ea;
						var _TRK_AMT = v_amt;
						</SCRIPT>

						<script>
							fbq('track', 'Purchase', {
							value: <%=totalPrice%>,
							currency: 'KRW'
							});
						</script>
						<%
						}
						%>
						<tr>
							<td colspan="7" class="totalprice">
								<span class="font-maple" style="padding-right:15px;">�� �����ݾ� �հ�</span>
								<span>��ǰ�ݾ� <strong class="font-blue"><%=nf.format(goodsTprice)%></strong> ��</span> +
								<span>��۷� <strong class="font-blue"><%=nf.format(devlPrice)%></strong> ��</span> +
								<span>���ð��� <strong class="font-blue"><%=nf.format(bagPrice)%></strong> ��</span> -
								<span>�������� <strong class="font-blue"><%=nf.format(couponPrice)%></strong> ��</span> =
								<span class="font-blue" style="padding-left:15px;">�� �����ݾ�</span>
								<span class="won padl50"><%=nf.format(totalPrice)%>��</span>
							</td>
						</tr>
					</table>
					<!-- End orderList -->
				</div>
			</div>
			<!-- End row -->
			<div class="divider"></div>
			<%
			query		= "SELECT ";
			query		+= "	PAY_TYPE, RCV_NAME, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_REQUEST,";
			query		+= "	TAG_NAME, TAG_TEL, TAG_HP, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_REQUEST, PG_CARDNUM,";
			query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, PAY_PRICE";
			query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum  +"' AND MEMBER_ID = '"+ eslMemberId +"'";
			try {
				rs			= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			if (rs.next()) {
				payType			= rs.getString("PAY_TYPE");
				rcvName			= rs.getString("RCV_NAME");
				rcvTel			= rs.getString("RCV_TEL");
				rcvHp			= rs.getString("RCV_HP");
				rcvZipcode		= rs.getString("RCV_ZIPCODE");
				rcvAddr1		= rs.getString("RCV_ADDR1");
				rcvAddr2		= rs.getString("RCV_ADDR2");
				rcvRequest		= rs.getString("RCV_REQUEST");
				tagName			= rs.getString("TAG_NAME");
				tagTel			= rs.getString("TAG_TEL");
				tagHp			= rs.getString("TAG_HP");
				tagZipcode		= rs.getString("TAG_ZIPCODE");
				tagAddr1		= rs.getString("TAG_ADDR1");
				tagAddr2		= rs.getString("TAG_ADDR2");
				tagRequest		= rs.getString("TAG_REQUEST");
				pgCardNum		= rs.getString("PG_CARDNUM");
				pgFinanceName	= rs.getString("PG_FINANCENAME");
				pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
				payPrice		= rs.getInt("PAY_PRICE");
			}
			%>
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4> <span class="f18"> �������� </span> </h4>
					</div>
					<%if (payType.equals("30")) {%>
					<table class="line-black paymentinfo" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>�������</th>
							<td>�������(�������Ա�)</td>
						</tr>
						<tr>
							<th>�Աݰ��¹�ȣ</th>
							<td><%=pgFinanceName%> <%=pgAccountNum%></td>
						</tr>
						<!--tr>
							<th>�Աݱ���</th>
							<td>2013. 08. 06����</td>
						</tr-->
						<tr>
							<th>�����ݾ�</th>
							<td><span class="won"><%=nf.format(payPrice)%>��</span> (�Ա��� �ֽ� �ݾ��Դϴ�)</td>
						</tr>
					</table>
					<%} else if (payType.equals("10")) {%>
					<table class="line-black paymentinfo" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>�������</th>
							<td>�ſ�ī�� (<%=pgFinanceName%> <%=pgCardNum%>)</td>
						</tr>
						<!--tr>
							<th>�Һ�����</th>
							<td>�Ͻú�</td>
						</tr-->
						<tr>
							<th>�����ݾ�</th>
							<td><span class="won"><%=nf.format(payPrice)%>��</span> (ī����� �ݾ��Դϴ�)</td>
						</tr>
					</table>
					<%} else if (payType.equals("20")) {%>
					<table class="line-black paymentinfo" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>�������</th>
							<td>�ǽð� ������ü</td>
						</tr>
						<!--tr>
							<th>�Һ�����</th>
							<td>�������� : 80339078696189(������:�ս���)</td>
						</tr-->
						<tr>
							<th>�����ݾ�</th>
							<td><span class="won"><%=nf.format(payPrice)%>��</span> (������ü �ݾ��Դϴ�)</td>
						</tr>
					</table>
					<%}%>
				</div>
			</div>
			<!-- End row -->
			<div class="divider"></div>
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4> <span class="f18"> ����� ���� </span> </h4>
					</div>
					<%if (dayPrice > 0) {%>
					<div class="sectionHeader">
						<h4> <span class="f18 font-blue"> �Ϲ��ǰ ����� ���� </span> </h4>
						<div class="floatright button dark small">
							<a href="/shop/mypage/orderList.jsp">���������</a>
						</div>
					</div>
					<table class="paymentinfo line-blue marb30" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>�����ôº�</th>
							<td colspan="3"><%=rcvName%></td>
						</tr>
						<tr>
							<th>��ȭ��ȣ</th>
							<td><%=rcvTel%></td>
							<th>�޴�����ȣ</th>
							<td><%=rcvHp%></td>
						</tr>
						<tr>
							<th>������ּ�</th>
							<td colspan="3">(<%=rcvZipcode%>) <%=rcvAddr1%> <%=rcvAddr2%></td>
						</tr>
						<tr>
							<th>��ۿ�û����</th>
							<td colspan="3"><%=rcvRequest%></td>
						</tr>
					</table>
					<%}%>
					<%if (tagPrice > 0) {%>
					<div class="sectionHeader">
						<h4> <span class="f18 font-green"> �ù��ǰ ����� ���� </span> </h4>
						<div class="floatright button dark small">
							<a href="#">���������</a>
						</div>
					</div>
					<table class="paymentinfo line-green" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>�����ôº�</th>
							<td colspan="3"><%=tagName%></td>
						</tr>
						<tr>
							<th>��ȭ��ȣ</th>
							<td><%=tagTel%></td>
							<th>�޴�����ȣ</th>
							<td><%=tagHp%></td>
						</tr>
						<tr>
							<th>������ּ�</th>
							<td colspan="3">(<%=tagZipcode%>) <%=tagAddr1%> <%=tagAddr2%></td>
						</tr>
						<tr>
							<th>��ۿ�û����</th>
							<td colspan="3"><%=tagRequest%></td>
						</tr>
					</table>
					<%}%>
				</div>
			</div>
			<!-- End row -->
			<div class="row hideprint">
				<div class="one last col center">
					<div class="divider">
					</div>
					<div class="button large darkgreen" style="margin:0 10px;">
						<a href="#" onClick="window.print();return false;">�μ��ϱ�</a>
					</div>
					<div class="button large dark" style="margin:0 10px;">
						<a href="/shop/orderGuide.jsp">��� �����ϱ�</a>
					</div>
				</div>
			</div>
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear">
		</div>
	</div>
	<!-- End container -->

<!-- Google Code for &#51204;&#51088;&#49345;&#44144;&#47000; Conversion Page -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 924441845;
var google_conversion_language = "ko";
var google_conversion_format = "3";
var google_conversion_color = "ffffff";
var google_conversion_label = "FbobCMTa9WUQ9bnnuAM";
var google_conversion_value = <%=totalPrice%>;
var google_conversion_currency = "KRW";
var google_remarketing_only = false;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/924441845/?value=142247.00&amp;currency_code=KRW&amp;label=FbobCMTa9WUQ9bnnuAM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>


	<div id="footer">
<!-- ADWorks Target Script START --><script language="javascript">try{_OPMS_AN='1811';_OPMS_AC='0701';_OPMS_PN='����';_OPMS_PA='����';}catch(e){}</script><!-- ADWorks Target Script END -->
<script language='javascript' type='text/javascript'>
var mr_buy = <%=payPrice%>;		// �ѱ��űݾ� (�űԱ���,�籸�� �м�)
</script>
<!-- ��ȯ������ ���� -->
 <script type="text/javascript" src="//wcs.naver.net/wcslog.js"> </script>
 <script type="text/javascript">
var _nasa={};
 _nasa["cnv"] = wcs.cnv("1","<%=payPrice%>"); // ��ȯ����, ��ȯ��ġ �����ؾ���. ��ġ�Ŵ��� ����
</script>

<!-- Withpang Conversion Tracker v2.0 start -->
<script type="text/javascript">
<!--
	(function (w, d, i) {
		w[i]={
			uid : "ecmdmkt",
			ordcode : "<%=orderNum%>",
			pcode : "",
			qty : "1",
			price : "<%=payPrice%>",
			pnm : encodeURIComponent(encodeURIComponent(""))
		};

		try{
			w[i].price= w[i].price.replace(/[^0-9]/g,"");
			if( w[i].ordcode=="" ) {
				w[i].ordcode = w[i].uid +"-"+ new Date().getTime();
			}
		}catch(e){
			w[i].price= 0;
		}
		if(d.body && w[i]) {
			var _ar = _ar || [];
			var _s = "log.dreamsearch.or.kr/servlet/conv";
			for(x in w[i]) _ar.push(x + "=" + w[i][x]);
			(new Image).src = d.location.protocol +"//"+ _s +"?"+ _ar.join("&");
		}
	})(window, document, "wp_conv");
//-->
</script>
<!-- Withpang Conversion Tracker v2.0 end -->

<!-- daum kakao ��ũ��Ʈ 2016.06.30 -->
<script type="text/javascript">
//<![CDATA[
var DaumConversionDctSv="type=P,orderID=<%=orderNum%>,amount=<%=payPrice%>";
var DaumConversionAccountID="PXhBM5qlN9UaFqhYLxnkJw00";
if(typeof DaumConversionScriptLoaded=="undefined"&&location.protocol!="file:"){
	var DaumConversionScriptLoaded=true;
	document.write(unescape("%3Cscript%20type%3D%22text/javas"+"cript%22%20src%3D%22"+(location.protocol=="https:"?"https":"http")+"%3A//s1.daumcdn.net/svc/original/U03/commonjs/cts/vr200/dcts.js%22%3E%3C/script%3E"));
}
//]]>
</script>
<!-- daum ��ũ��Ʈ -->
<!-- WIDERPLANET PURCHASE SCRIPT START 2015.12.22 -> �߰�����: 2018.11.21 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script type="text/javascript">
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
	return {
		wp_hcuid:"",  	/*Cross device targeting�� ���ϴ� �����ִ� �α����� ������� Unique ID (ex. �α��� ID, ���ѹ� ��)�� ��ȣȭ�Ͽ� ����.
				 *����: �α��� ���� ���� ����ڴ� ��� ���� �������� �ʽ��ϴ�.*/
		ti:"25218",
		ty:"PurchaseComplete",
		device:"web"
		,items:[
            <%
            for(int r=0; r<arr_groupName.size(); r++){
				System.out.println("------------------------");
				System.out.println("i: " + arr_groupCode.get(r));
				System.out.println("t: " + arr_groupName.get(r));
				System.out.println("p: " + arr_price2.get(r));
				System.out.println("q: " + arr_orderCnt.get(r));
				System.out.println("------------------------");
            %>
              , {i:"<%=arr_groupCode.get(r)%>", t:"<%=arr_groupName.get(r)%>", p:"<%=arr_price2.get(r)%>", q:"<%=arr_orderCnt.get(r)%>"} /* ù��° ��ǰ  - i:��ǰ �ĺ���ȣ (Feed�� �����Ǵ� �ĺ���ȣ�� ��ġ ) t:��ǰ��  p:�ܰ�  q:����  */
            <%
            }
            %>
		]
	};
}));
</script>
<script type="text/javascript" async src="//astg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET PURCHASE SCRIPT END 2015.12.22 -->

<!-- �̵��ť�� �ȼ� Start 2016.03.15 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=980594&mt_adid=158356&v1=<%=payPrice%>&v2=&v3=&s1=&s2=&s3='></script>
<!-- �̵��ť�� �ȼ� End -->

<!-- LiveLog TrackingCheck Script Start 2016.06.17 -->
<script>
LLOrderName="<%=rcvName%>";
LLNumber="[<%=orderNum%>]<%=payPrice%>";
LLDBid=LLOrderName+"|dinfo|"+LLNumber;
LLscriptPlugIn.load('//livelog.co.kr/js/plugShow.php', "sg_check.payment('"+LLDBid+"','"+LLNumber+"','Y')");
eval(function(p,a,c,k,e,r){e=function(c){return c.toString(a)};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('0(5);6 0(a){1 b=2 3();1 c=b.4()+a;7(8){b=2 3();9(b.4()>c)d}}',14,14,'sleep|var|new|Date|getTime|2000|function|while|true|if||||return'.split('|'),0,{}));
</script>
<!-- LiveLog TrackingCheck Script End -->

<div id="ord_no" style="display:none;"><%=orderNum%></div>
<div id="ord_price" style="display:none;"><%=payPrice%></div>
<!-- N2S ��ȯ ������ Start -->
<script language="javascript" src="//web.n2s.co.kr/js/_n2s_sp_order_ecmdmkt.js"></script>
<!-- N2S ��ȯ ������ End -->

<!-- ShowGet PaymentCrawling Script Start -->
<script>
SGShowID="ecmdmkt";
SGOrderid="<%=orderNum%>";
SGTotalPrice="<%=payPrice%>";
SGBankTypeCHK=('<%=payType%>'=='30')?'Y':'N';
SGscriptPlugIn.loadSBox('//showget.co.kr/js/plugShow.php?'+SGShowID, "sg_paycheck.payment('"+SGOrderid+"','"+SGTotalPrice+"','"+SGBankTypeCHK+"')");</script>
<!-- ShowGet PaymentCrawling Script End -->

<!-- AT 2018-11-29 -->
<script>
atltems.push({
		<%
		for(int r=0; r<arr_groupName.size(); r++){
		%>
			 id: "<%=arr_groupCode.get(r)%>"/*(�ʼ�)ID���Է�*/,
			 price:"<%=arr_price.get(r)%>", 
			 quantity:"<%=arr_orderCnt.get(r)%>"/*(�ʼ�)���������Է�*/,
			 category:""/*ī�װ� ��|��|��*/,
			 imgUrl:""/*img��ũ���Է� ex)http://example.com/img/img.jpg*/,
			 name:"<%=arr_groupName.get(r)%>"/*(�ʼ�)��ǰ��Ǵ� ��ȯ�޴����Է�*/,
			 desc:""/*��ǰ�� ���� text*/,
			 link:""/*��ǰ�������� URL ex)http://example.com/detail/product.html*/
		<%
		}
		%>
});
</script>
<!-- AT -->

<!-- AT 2018-11-29 -->
<script type="text/javascript" src="//static.tagmanager.toast.com/tag/view/880"></script>
<script type="text/javascript">
 window.ne_tgm_q = window.ne_tgm_q || [];
 window.ne_tgm_q.push(
 {
     tagType: 'conversion',
     device:'web'/*web, mobile, tablet*/,
     uniqValue:'',
     pageEncoding:'utf-8',
     orderNo : '<%=orderNum%>'/*�ֹ���ȣ�Է�*/,
     items : atltems,
     totalPrice:"<%=payPrice%>"/*��ǰ �� �ݾ� �ջ�*/
    
 });
 </script>
 <!-- AT -->

		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>

<!-- Enliple Tracker v3.5 [������ȯ] start -->
<script type="text/javascript">
<!--
	function mobConv(){

        var cn = new EN();
		var sum = 0;

		<%
		for(int r=0; r<arr_groupName.size(); r++){
		%>
		  cnt = "<%=arr_orderCnt.get(r)%>";
		  sum = Number(cnt) + sum;
		<%
		}
		%>

        cn.setData("uid", "eatsslim");
        cn.setData("ordcode", '<%=orderNum%>'); //�ʼ�
        //cn.setData("pcode", "��ǰ �ڵ�"); //�ɼ�
        cn.setData("qty", sum); //�ʼ�
        cn.setData("price", '<%=totalPrice%>'); //�ʼ�
        //cn.setData("pnm", encodeURIComponent(encodeURIComponent("��ǰ��"))); //�ɼ�
        cn.setSSL(true);
        cn.sendConv();
	}
//-->
</script>
<script src="https://cdn.megadata.co.kr/js/en_script/3.5/enliple_sns_min3.5.js" defer="defer" onload="mobConv()"></script>
<!-- Enliple Tracker v3.5 [������ȯ] end -->


</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>
<%@ include file="/lib/dbclose_phi.jsp" %>