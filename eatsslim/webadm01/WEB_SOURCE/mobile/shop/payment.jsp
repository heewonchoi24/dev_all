<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String promotion	= "";	// 체험단 프로모션

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
	tcnt		= rs.getInt(1); //총 레코드 수
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
		<div class="row" id="shopOrder">
			<div class="orderBox">
				<h1 class="tit">주문리스트 확인</h1>
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
		devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
		gubun1		= rs.getString("GUBUN1");
		gubun2		= rs.getString("GUBUN2");
		groupName	= rs.getString("GROUP_NAME");
		couponPrice	= rs.getInt("COUPON_PRICE");
		arr_groupName.add(rs.getString("GROUP_NAME"));
		arr_orderCnt.add(orderCnt);
		arr_groupCode.add(rs.getString("GROUP_CODE"));
		promotion		= ut.inject(rs.getString("EXP_PROMOTION"));// 체험단 프로모션

		if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
			devlDate	= rs.getString("WDATE");
			buyBagYn	= rs.getString("BUY_BAG_YN");
			devlDay		= rs.getString("DEVL_DAY");
			devlWeek	= rs.getString("DEVL_WEEK");
			devlPeriod	= devlWeek +"주("+ devlDay +"일)";
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
				/* 전체 무료배송
				if (tagPrice1 > 40000) {
					devlPrice		= 0;
				} else {
					devlPrice		= defaultDevlPrice;
				}
				*/
			} else if (groupId == 52 || groupId == 53) {
				/* 전체 무료배송
				devlPrice1		= defaultDevlPrice;
				*/
			}
		}

		if(promotion.equals("01")){// 체험단 프로모션	
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
									<p>식사기간 : <span><%=devlPeriod%></span></p>
									<p>첫 배송일 : <span><%=devlDate%></span></p>
<% } %>
									<p>수량 : <span><%=orderCnt%></span></p>
								</div>
							</div>
							<div class="cartbottom">
								<div class="price"><!-- <span>80,000원</span>  --><%=nf.format(goodsPrice)%>원</div>
							</div>
						</div>
<%
		if (buyBagYn.equals("Y")) {
			bagPrice	+= defaultBagPrice;
%>
						<div class="buyBag">
							<div class="bagTit">보냉가방<span>(수량:<strong>1</strong>)</span></div>
							<div class="bagPrice"><%=nf.format(defaultBagPrice)%>원</div>
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

					ga('ecommerce:addTransaction', {                      //구글 애널리틱스 주문정보 수집
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
				<h1 class="tit">결제정보 확인</h1>
				<div class="totalPriceTable">
					<table>
						<colgroup>
							<col>
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th>결제방법</th>
								<%if (payType.equals("30")) {%>
								<td>입금계좌번호 <%=pgFinanceName%> (<%=pgAccountNum%>)</td>
								<%} else if (payType.equals("10")) {%>
								<td>신용카드 <%=pgFinanceName%> (<%=pgCardNum%>)</td>
								<%}%>
							</tr>
							<tr>
								<th>주문일시</th>
								<td><%=orderDate%></td>
							</tr>
							<tr>
								<th>상품합계금액</th>
								<td><span><%=nf.format(goodsTprice)%></span> 원</td>
							</tr>
							<tr>
								<th>상품할인</th>
								<td>(-) <span><%=nf.format(couponPrice)%></span> 원</td>
							</tr>
							<tr>
								<th>전체 배송비</th>
								<td>(+) <span><%=nf.format(devlPrice)%></span> 원</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="totalPrice">
					총 주문금액 <span id="tprice"><%=nf.format(totalPrice)%></span> 원
				</div>
			</div>
			<div class="orderBox">
				<h1 class="tit">배송정보 확인</h1>
<%if (dayPrice > 0) {%>
				<div class="topArea">
					<div class="topAreaTit" style="border: 0;">일배상품 배송정보</div>
				</div>
				<div class="boxTable">
					<table>
						<tbody>
							<tr>
								<th>수령인</th>
								<td><%=rcvName%></td>
							</tr>
							<tr>
								<th>휴대폰</th>
								<td><%=rcvHp%></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><%=rcvTel%></td>
							</tr>
							<tr>
								<th>주소</th>
								<td>[<%=rcvZipcode%>] <%=rcvAddr1%> <%=rcvAddr2%></td>
							</tr>
							<tr>
								<th>배송유의사항</th>
								<td><%=rcvRequest%></td>
							</tr>
						</tbody>
					</table>
				</div>
<%}if (tagPrice > 0) {%>
				<div class="topArea">
					<div class="topAreaTit" style="border: 0;">택배상품 배송정보</div>
				</div>
				<div class="boxTable">
					<table>
						<tbody>
							<tr>
								<th>수령인</th>
								<td><%=tagName%></td>
							</tr>
							<tr>
								<th>휴대폰</th>
								<td><%=tagHp%></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><%=tagTel%></td>
							</tr>
							<tr>
								<th>주소</th>
								<td>[<%=tagZipcode%>] <%=tagAddr1%> <%=tagAddr2%></td>
							</tr>
							<tr>
								<th>배송유의사항</th>
								<td><%=tagRequest%></td>
							</tr>
						</tbody>
					</table>
				</div>
<%}%>
			</div>
			<div class="orderBox">
				<h1 class="tit">안내사항</h1>
				<div class="boxTable">
					<table>
						<tbody>
							<tr>
								<td>
									<p>주문 조회 및 변경, 이달의 식단 확인은 잇슬림 옐로우 아이디를 통해 편리하게 이용가능합니다. <br />카카오톡에서 '풀무원 잇슬림'을 친구 추가해주세요.
									<br/><a href="http://plus.kakao.com/home/oamlw65x"><span class="marb10 font-blue">[친구추가 바로가기 클릭]</span></a></p>
									<br/>
									<p>SNS 로그인 후 결제 시 동일한 SNS로 로그인 했을 때에만 주문정보 조회가 가능합니다.</p>
									<p>SNS 로그인 고객은 카카오톡 플러스친구를 통한 모바일 고객센터 이용이 일부 제한됩니다.</p>
									<p>주문 조회/변경은 잇슬림 홈페이지를 이용해주세요.</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="orderBtns">
					<a href="/mobile/index.jsp"><button type="button" class="btn btn_white square">계속 쇼핑하기</button></a>
					<a href="/mobile/shop/mypage/orderDetail.jsp?ono=<%=orderNum%>"><button type="button" class="btn btn_dgray square">주문내역보기</button></a>
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
			 id: "<%=arr_groupCode.get(r)%>"/*(필수)ID값입력*/,
			 price:"<%=arr_price.get(r)%>", 
			 quantity:"<%=arr_orderCnt.get(r)%>"/*(필수)갯수정보입력*/,
			 category:""/*카테고리 대|중|소*/,
			 imgUrl:""/*img링크값입력 ex)http://example.com/img/img.jpg*/,
			 name:"<%=arr_groupName.get(r)%>"/*(필수)제품명또는 전환메뉴명입력*/,
			 desc:""/*상품상세 설명 text*/,
			 link:""/*상품상세페이지 URL ex)http://example.com/detail/product.html*/
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
     orderNo : '<%=orderNum%>'/*주문번호입력*/,
     items : atltems,
     totalPrice:"<%=payPrice%>"/*상품 총 금액 합산*/
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
		wp_hcuid:"",  	/*고객넘버 등 Unique ID (ex. 로그인  ID, 고객넘버 등 )를 암호화하여 대입.
				 *주의 : 로그인 하지 않은 사용자는 어떠한 값도 대입하지 않습니다.*/
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
			  ,{i:'<%=groupCode_list.get(r)%>', t:'<%=groupName_list.get(r)%>', p:'<%=price_list.get(r)%>', q:'<%=orderCnt_list.get(r)%>'}  /* 첫번째 상품  - i:상품 식별번호 (Feed로 제공되는 식별번호와 일치 ) t:상품명  p:단가  q:수량  */
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

<!-- Enliple Tracker v3.5 [결제전환] start -->
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
        cn.setData("ordcode", '<%=orderNum%>'); //필수
        //cn.setData("pcode", "제품 코드"); //옵션
        cn.setData("qty", sum); //필수
        cn.setData("price", '<%=totalPrice%>'); //필수
        //cn.setData("pnm", encodeURIComponent(encodeURIComponent("제품명"))); //옵션
        cn.setSSL(true);
        cn.sendConv();
	}
//-->
</script>
<script src="https://cdn.megadata.co.kr/js/en_script/3.5/enliple_sns_min3.5.js" defer="defer" onload="mobConv()"></script>
<!-- Enliple Tracker v3.5 [결제전환] end -->


</body>
</html>