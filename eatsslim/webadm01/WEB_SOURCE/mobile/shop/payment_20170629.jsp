<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

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

query		= "SELECT COUNT(ID) FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //총 레코드 수
}
rs.close();

query		= "SELECT OG.GROUP_ID, OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GUBUN2, G.GROUP_NAME, G.CART_IMG, O.COUPON_PRICE, DATE_FORMAT(O.ORDER_DATE, '%Y.%m.%d') ORDER_DATE";
query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID";
query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
query		+= " ORDER BY OG.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>

<!-- //구글 애널리틱스 이커머스 -->
<script>

	//결제금액의 콤마 제거
	function removeComma(str){
		var removed_str = parseInt(str.replace(/,/g,""));
		return removed_str;
	}
	//상품명의 HTML 태그 제거
	function removeHtml(str){
		var removed_str = str.replace(/\<.*?\>/g," ");
		return removed_str;
	 }

	//URL에서 상품코드 받기
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

	ga('require', 'ecommerce', 'ecommerce.js');           //구글 애널리틱스 이커머스 플러그인

</script>
<!-- 구글 애널리틱스 이머커스 트래킹 끝 -->

</head>
<body>

<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
    <!-- End ui-header -->
    <!-- Start Content -->
	<div id="content" class="oldClass">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">주문결제 완료</span></span></h1>
		<h2 class="ui-title">주문리스트 확인<span class="ui-icon-right"></span></h2>
		<%
		if (tcnt > 0) {
			while (rs.next()) {
				groupId		= rs.getInt("GROUP_ID");
				orderCnt	= rs.getInt("ORDER_CNT");
				devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
				gubun1		= rs.getString("GUBUN1");
				gubun2		= rs.getString("GUBUN2");
				groupName	= rs.getString("GROUP_NAME");
				couponPrice	= rs.getInt("COUPON_PRICE");
				if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
					devlDate	= rs.getString("WDATE");
					buyBagYn	= rs.getString("BUY_BAG_YN");
					devlDay		= rs.getString("DEVL_DAY");
					devlWeek	= rs.getString("DEVL_WEEK");
					devlPeriod	= devlWeek +"주("+ devlDay +"일)";
					price		= rs.getInt("PRICE");
					if (buyBagYn.equals("Y")) {
						price -= defaultBagPrice;
					}
					goodsPrice	= price;// * orderCnt;
					dayPrice += goodsPrice;
				} else {
					devlDate	= "-";
					buyBagYn	= "N";
					devlPeriod	= "-";
					price		= rs.getInt("PRICE");
					goodsPrice	= price;// * orderCnt;
					tagPrice	+= goodsPrice;
					if (groupId == 15) {
						tagPrice1	+= goodsPrice;
						if (tagPrice1 > 40000) {
							devlPrice		= 0;
						} else {
							devlPrice		= defaultDevlPrice;
						}
					} else if (groupId == 52 || groupId == 53) {
						devlPrice1		= defaultDevlPrice;
					}
				}
				cartImg		= rs.getString("CART_IMG");
				if (cartImg.equals("") || cartImg == null) {
					imgUrl		= "/images/order_sample.jpg";
				} else {
					imgUrl		= webUploadDir +"goods/"+ cartImg;
				}
				orderDate	= rs.getString("ORDER_DATE");
		%>

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



		<dl class="itemlist">
			<dt style="width:70%;">
				<%=groupName%>/<%=orderCnt%>개
				<p class="font-gray">배송기간:<%=devlPeriod%> / 첫배송일 : <%=devlDate%></p>
			</dt>
			<dd style="width:30%;"><%=nf.format(goodsPrice)%>원</dd>
		</dl>
		<%
				if (buyBagYn.equals("Y")) {
					bagPrice	+= defaultBagPrice;// * orderCnt;
		%>
		<dl class="itemlist">
			<dt style="width:70%;">보냉가방/1개<p class="font-gray">첫배송일 : <%=devlDate%></p></dt>
			<dd style="width:30%;"><%=nf.format(defaultBagPrice)%>원</dd>
		</dl>
		<%
				}
			}

			rs.close();

			orderPrice		= dayPrice + tagPrice + bagPrice;
			goodsTprice		= dayPrice + tagPrice;
			devlPrice		= devlPrice + devlPrice1;

			totalPrice		= orderPrice + devlPrice - couponPrice;
			if (totalPrice < 1) totalPrice = 0;
		}
		%>
		<script>

			totalProductPrice = '<%=totalPrice%>';
			totalProductPrice = removeComma(totalProductPrice);

			totalShipFee = '<%=bagPrice%>';
			totalShipFee = removeComma(totalShipFee);

			ga('ecommerce:addTransaction', {                      //구글 애널리틱스 주문정보 수집
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
		<h2 class="ui-title">결제정보 확인<span class="ui-icon-right"></span></h2>
		<dl class="itemlist">
			<dt style="width:70%;">결제방법</dt>
			<dd style="width:30%;"><%=ut.getPayType(payType)%></dd>
			<%if (payType.equals("30")) {%>
			<dt style="width:70%;">입금계좌번호</dt>
			<dd style="width:30%;"><%=pgFinanceName%> <%=pgAccountNum%></dd>
			<%} else if (payType.equals("10")) {%>
			<dt style="width:70%;">신용카드</dt>
			<dd style="width:30%;"><%=pgFinanceName%> <%=pgCardNum%></dd>
			<%}%>
			<dt style="width:70%;">주문일시</dt>
			<dd style="width:30%;"><%=orderDate%></dd>
			<dt style="width:70%;">상품합계금액</dt>
			<dd style="width:30%;"><%=goodsTprice%>원</dd>
			<dt style="width:70%;">상품할인</dt>
			<dd style="width:30%;">(-) <%=nf.format(couponPrice)%>원</dd>
			<dt style="width:70%;">전체 배송비</dt>
			<dd style="width:30%;">(+) <%=nf.format(devlPrice)%>원</dd>
		</dl>
		<div class="divider"></div>
		<dl class="itemlist redline">
			<dt class="f16">총 결제금액</dt>
			<dd class="f16 font-orange"><%=nf.format(totalPrice)%>원</dd>
		</dl>
		<div class="divider"></div>
		<h2 class="ui-title">배송정보 확인<span class="ui-icon-right"></span></h2>
		<%if (dayPrice > 0) {%>
		<h3 class="marb10 font-blue">일배상품 배송정보</h3>
		<dl class="itemlist">
			<dt>수령인</dt>
			<dd><%=rcvName%></dd>
			<dt>휴대폰</dt>
			<dd><%=rcvHp%></dd>
			<dt>전화번호</dt>
			<dd><%=rcvTel%></dd>
			<dt>주소</dt>
			<dd>[<%=rcvZipcode%>] <%=rcvAddr1%> <%=rcvAddr2%></dd>
			<!--dt>출입문 비밀번호</dt>
			<dd>4567</dd-->
			<dt>배송유의사항</dt>
			<dd><%=rcvRequest%></dd>
			<!--dt>송장번호</dt>
			<dd>대한통운(61784566)<b>배송중</b></dd-->
		</dl>
		<div class="divider"></div>
		<%}%>
		<%if (tagPrice > 0) {%>
		<h3 class="marb10 font-blue">택배상품 배송정보</h3>
		<dl class="itemlist">
			<dt>수령인</dt>
			<dd><%=tagName%></dd>
			<dt>핸드폰</dt>
			<dd><%=tagHp%></dd>
			<dt>전화번호</dt>
			<dd><%=tagTel%></dd>
			<dt>주소</dt>
			<dd>[<%=tagZipcode%>]<%=tagAddr1%> <%=tagAddr2%></dd>
			<dt>배송유의사항</dt>
			<dd><%=tagRequest%></dd>
			<!--dt>송장번호</dt>
			<dd>대한통운(61784566)<b>배송중</b></dd-->
		</dl>
		<%}%>

<!-- 2017. 03. 08 추가-->
		<div class="divider"></div>
		<h2 class="ui-title">안내사항<span class="ui-icon-right"></span></h2>
		<div  class="marb10">
		<p>주문 조회 및 변경, 이달의 식단 확인은 잇슬림 옐로우 아이디를 통해 편리하게 이용가능합니다.<br />
		카카오톡에서 '풀무원 잇슬림'을 친구 추가해주세요.<br /><br />
		<a href="http://plus.kakao.com/home/oamlw65x"><span class="marb10 font-blue">[친구추가 바로가기 클릭]</span></a></p>
		</div>
		<div  class="marb10">
			<p>SNS 로그인 후 결제 시 동일한 SNS로 로그인 했을 때에만 주문정보 조회가 가능합니다.</p>
			<p>SNS 로그인 고객은 카카오톡 플러스친구를 통한 모바일 고객센터 이용이 일부 제한됩니다.</p>
			<p>주문 조회/변경은 잇슬림 홈페이지를 이용해주세요.</p>
		</div>
		<!-- 여기까지 -->

		<!--p style="text-align:center">해당상품 없음</p-->
		<div class="divider"></div>
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/dietMeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">계속 쇼핑하기</span></span></a></td>
					<td><a href="/mobile/shop/mypage/orderDetail.jsp?ono=<%=orderNum%>" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">주문내역보기</span></span></a></td>
				</tr>
			</table>
		</div>
		<div class="divider"></div>
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

<!-- daum kakao 스크립트 2016.06.30 -->
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
<!-- daum 스크립트 -->

<!-- 미디어큐브 픽셀 Start 2016.03.15 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=980595&mt_adid=158356&v1=<%=payPrice%>&v2=&v3=&s1=&s2=&s3='></script>
<!-- 미디어큐브 픽셀 End -->


<!-- 전환페이지 설정 Start 2016.05.31 -->
<script type="text/javascript" src="http://wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
var _nasa={};
_nasa["cnv"] = wcs.cnv("1","<%=payPrice%>"); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고
</script>
<!-- 전환페이지 설정 End -->

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
<!-- N2S 전환 수집용 Start -->
<script language="javascript" src="//web.n2s.co.kr/js/_n2s_sp_order_ecmdmkt_m.js"></script>
<!-- N2S 전환 수집용 End -->

<!-- ShowGet PaymentCrawling Script Start -->
<script>
SGShowID="ecmdmkt";
SGOrderid="<%=orderNum%>";
SGTotalPrice="<%=payPrice%>";
SGBankTypeCHK=('<%=payType%>'=='30')?'Y':'N';
SGscriptPlugIn.loadSBox('//showget.co.kr/js/plugShow.php?'+SGShowID, "sg_paycheck.payment('"+SGOrderid+"','"+SGTotalPrice+"','"+SGBankTypeCHK+"')");</script>
<!-- ShowGet PaymentCrawling Script End -->

    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>