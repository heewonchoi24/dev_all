<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
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
String gubun2			= "";
String orderDate		= "";

List<String> groupCode_list = new ArrayList<String>();
List<String> groupName_list = new ArrayList<String>();
List<Integer> price_list = new ArrayList<Integer>();
List<Integer> orderCnt_list = new ArrayList<Integer>();

ArrayList<String> arr_groupName = new ArrayList<String>();
ArrayList<Integer> arr_price = new ArrayList<Integer>();
ArrayList<Integer> arr_orderCnt = new ArrayList<Integer>();
ArrayList<String> arr_groupCode = new ArrayList<String>();

query		= "SELECT COUNT(ID) FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //�� ���ڵ� ��
}
rs.close();

query		= "SELECT OG.GROUP_ID, G.GROUP_CODE, OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GUBUN2, G.GROUP_NAME, G.CART_IMG, O.COUPON_PRICE, DATE_FORMAT(O.ORDER_DATE, '%Y.%m.%d') ORDER_DATE, DEVL_PRICE, EXP_PROMOTION";
query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID";
query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
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

</script>
<!-- ���� �ֳθ�ƽ�� �̸�Ŀ�� Ʈ��ŷ �� -->

</head>
<body>

<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
    <!-- End ui-header -->
    <!-- Start Content -->
	<div id="content" class="oldClass">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">�ֹ����� �Ϸ�</span></span></h1>
		<div class="row" id="shopOrder">
			<div class="orderBox">
				<h1 class="tit">�ֹ�����Ʈ Ȯ��</h1>
				<ul class="cartList">
<%
if (tcnt > 0) {
	while (rs.next()) {
		groupCode_list.add(rs.getString("GROUP_CODE"));
		groupName_list.add(rs.getString("GROUP_NAME"));
		price_list.add(rs.getInt("PRICE"));
		orderCnt_list.add(rs.getInt("ORDER_CNT"));
		groupId		= rs.getInt("GROUP_ID");
		orderCnt	= rs.getInt("ORDER_CNT");
		devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "�Ϲ�" : "�ù�";
		gubun1		= rs.getString("GUBUN1");
		gubun2		= rs.getString("GUBUN2");
		groupName	= rs.getString("GROUP_NAME");
		couponPrice	= rs.getInt("COUPON_PRICE");
		arr_groupName.add(rs.getString("GROUP_NAME"));
		arr_orderCnt.add(orderCnt);
		arr_groupCode.add(rs.getString("GROUP_CODE"));
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
		orderDate	= rs.getString("ORDER_DATE");
%>
					<li>
						<script type="text/javascript">
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
						<div class="inner">
							<div class="cartTop">
								<p class="cate"><%=ut.getGubun1Name(gubun1)%></p>
								<p class="name"><%=groupName%></p>
							</div>
							<div class="cartBody">
								<div class="photo"><img src="<%=imgUrl%>"></div>
								<div class="info">
<% if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) { %>
									<p>�Ļ�Ⱓ : <span><%=devlPeriod%></span></p>
									<p>ù ����� : <span><%=devlDate%></span></p>
<% } %>
									<p>���� : <span><%=orderCnt%></span></p>
								</div>
							</div>
							<div class="cartbottom">
								<div class="price"><!-- <span>80,000��</span>  --><%=nf.format(goodsPrice)%>��</div>
							</div>
						</div>
<%
		if (buyBagYn.equals("Y")) {
			bagPrice	+= defaultBagPrice;
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
	//i++;
}

rs.close();
orderPrice		= dayPrice + tagPrice + bagPrice;
goodsTprice		= dayPrice + tagPrice;
devlPrice		= devlPrice + devlPrice1;

totalPrice		= orderPrice + devlPrice - couponPrice;
if (totalPrice < 1) totalPrice = 0;
}
%>
				</ul>
				<script type="text/javascript">

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
					ga('ecommerce:send');
				</script>
			</div>
<%
query		= "SELECT ";
query		+= "	PAY_TYPE, RCV_NAME, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_REQUEST,";
query		+= "	TAG_NAME, TAG_TEL, TAG_HP, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_REQUEST, PG_CARDNUM,";
query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, PAY_PRICE";
query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
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
			<div class="orderBox totalPriceArea">
				<h1 class="tit">�������� Ȯ��</h1>
				<div class="totalPriceTable">
					<table>
						<colgroup>
							<col>
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th>�������</th>
								<%if (payType.equals("30")) {%>
								<td>�Աݰ��¹�ȣ <%=pgFinanceName%> (<%=pgAccountNum%>)</td>
								<%} else if (payType.equals("10")) {%>
								<td>�ſ�ī�� <%=pgFinanceName%> (<%=pgCardNum%>)</td>
								<%}%>
							</tr>
							<tr>
								<th>�ֹ��Ͻ�</th>
								<td><%=orderDate%></td>
							</tr>
							<tr>
								<th>��ǰ�հ�ݾ�</th>
								<td><span><%=nf.format(goodsTprice)%></span> ��</td>
							</tr>
							<tr>
								<th>��ǰ����</th>
								<td>(-) <span><%=nf.format(couponPrice)%></span> ��</td>
							</tr>
							<tr>
								<th>��ü ��ۺ�</th>
								<td>(+) <span><%=nf.format(devlPrice)%></span> ��</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="totalPrice">
					�� �ֹ��ݾ� <span id="tprice"><%=nf.format(totalPrice)%></span> ��
				</div>
			</div>
			<div class="orderBox">
				<h1 class="tit">������� Ȯ��</h1>
<%if (dayPrice > 0) {%>
				<div class="topArea">
					<div class="topAreaTit" style="border: 0;">�Ϲ��ǰ �������</div>
				</div>
				<div class="boxTable">
					<table>
						<tbody>
							<tr>
								<th>������</th>
								<td><%=rcvName%></td>
							</tr>
							<tr>
								<th>�޴���</th>
								<td><%=rcvHp%></td>
							</tr>
							<tr>
								<th>��ȭ��ȣ</th>
								<td><%=rcvTel%></td>
							</tr>
							<tr>
								<th>�ּ�</th>
								<td>[<%=rcvZipcode%>] <%=rcvAddr1%> <%=rcvAddr2%></td>
							</tr>
							<tr>
								<th>������ǻ���</th>
								<td><%=rcvRequest%></td>
							</tr>
						</tbody>
					</table>
				</div>
<%}if (tagPrice > 0) {%>
				<div class="topArea">
					<div class="topAreaTit" style="border: 0;">�ù��ǰ �������</div>
				</div>
				<div class="boxTable">
					<table>
						<tbody>
							<tr>
								<th>������</th>
								<td><%=tagName%></td>
							</tr>
							<tr>
								<th>�޴���</th>
								<td><%=tagHp%></td>
							</tr>
							<tr>
								<th>��ȭ��ȣ</th>
								<td><%=tagTel%></td>
							</tr>
							<tr>
								<th>�ּ�</th>
								<td>[<%=tagZipcode%>] <%=tagAddr1%> <%=tagAddr2%></td>
							</tr>
							<tr>
								<th>������ǻ���</th>
								<td><%=tagRequest%></td>
							</tr>
						</tbody>
					</table>
				</div>
<%}%>
			</div>
			<div class="orderBox">
				<h1 class="tit">�ȳ�����</h1>
				<div class="boxTable">
					<table>
						<tbody>
							<tr>
								<td>
									<p>�ֹ� ��ȸ �� ����, �̴��� �Ĵ� Ȯ���� �ս��� ���ο� ���̵� ���� ���ϰ� �̿밡���մϴ�. <br />īī���忡�� 'Ǯ���� �ս���'�� ģ�� �߰����ּ���.
									<br/><a href="http://plus.kakao.com/home/oamlw65x"><span class="marb10 font-blue">[ģ���߰� �ٷΰ��� Ŭ��]</span></a></p>
									<br/>
									<p>SNS �α��� �� ���� �� ������ SNS�� �α��� ���� ������ �ֹ����� ��ȸ�� �����մϴ�.</p>
									<p>SNS �α��� ���� īī���� �÷���ģ���� ���� ����� ������ �̿��� �Ϻ� ���ѵ˴ϴ�.</p>
									<p>�ֹ� ��ȸ/������ �ս��� Ȩ�������� �̿����ּ���.</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="orderBtns">
					<a href="/mobile/index.jsp"><button type="button" class="btn btn_white square">��� �����ϱ�</button></a>
					<a href="/mobile/shop/mypage/orderDetail.jsp?ono=<%=orderNum%>"><button type="button" class="btn btn_dgray square">�ֹ���������</button></a>
				</div>
			</div>
		</div>
	</div>
    <!-- End Content -->

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

<!-- �̵��ť�� �ȼ� Start 2016.03.15 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=980595&mt_adid=158356&v1=<%=payPrice%>&v2=&v3=&s1=&s2=&s3='></script>
<!-- �̵��ť�� �ȼ� End -->


<!-- ��ȯ������ ���� Start 2016.05.31 -->
<script type="text/javascript" src="http://wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
var _nasa={};
_nasa["cnv"] = wcs.cnv("1","<%=payPrice%>"); // ��ȯ����, ��ȯ��ġ �����ؾ���. ��ġ�Ŵ��� ����
</script>
<!-- ��ȯ������ ���� End -->

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
<script language="javascript" src="//web.n2s.co.kr/js/_n2s_sp_order_ecmdmkt_m.js"></script>
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
			 System.out.println("------------------------");
			 System.out.println("id: " + arr_groupCode.get(r));
			 System.out.println("price: " + arr_price.get(r));
			 System.out.println("quantity: " + arr_orderCnt.get(r));
			 System.out.println("name: " + arr_groupName.get(r));
			 System.out.println("------------------------");
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
     device:'mobile'/*web, mobile, tablet*/,
     uniqValue:'',
     pageEncoding:'utf-8',
     orderNo : '<%=orderNum%>'/*�ֹ���ȣ�Է�*/,
     items : atltems,
     totalPrice:"<%=payPrice%>"/*��ǰ �� �ݾ� �ջ�*/
 });
 </script>
 <!-- AT -->

 <script>
  fbq('track', 'Purchase', {
    value: <%=totalPrice%>,
    currency: 'KRW',
  });
</script>

<!-- WIDERPLANET PURCHASE SCRIPT START 2018.9.6 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script type="text/javascript">
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
	return {
		wp_hcuid:"",  	/*���ѹ� �� Unique ID (ex. �α���  ID, ���ѹ� �� )�� ��ȣȭ�Ͽ� ����.
				 *���� : �α��� ���� ���� ����ڴ� ��� ���� �������� �ʽ��ϴ�.*/
		ti:"25218",
		ty:"PurchaseComplete",
		device:"mobile"
		,items:[
			<%
			for(int r=0; r<groupCode_list.size(); r++){
				System.out.println("------------------------");
				System.out.println("i: " + groupCode_list.get(r));
				System.out.println("t: " + groupName_list.get(r));
				System.out.println("p: " + price_list.get(r));
				System.out.println("q: " + orderCnt_list.get(r));
				System.out.println("------------------------");
			%>
			  ,{i:'<%=groupCode_list.get(r)%>', t:'<%=groupName_list.get(r)%>', p:'<%=price_list.get(r)%>', q:'<%=orderCnt_list.get(r)%>'}  /* ù��° ��ǰ  - i:��ǰ �ĺ���ȣ (Feed�� �����Ǵ� �ĺ���ȣ�� ��ġ ) t:��ǰ��  p:�ܰ�  q:����  */
			<%
			}
			%>
		]
	};
}));
</script>
<script type="text/javascript" async src="//cdn-aitg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET PURCHASE SCRIPT END 2018.9.6 -->

    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
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