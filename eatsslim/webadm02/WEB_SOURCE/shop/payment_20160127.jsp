<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp" %>
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
int payPrice		= 0;
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

query		= "SELECT COUNT(OG.ID) FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID";
query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
query		+= " AND OG.ORDER_NUM = '"+ orderNum  +"' AND O.MEMBER_ID = '"+ eslMemberId +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //총 레코드 수		
}
rs.close();

if (tcnt < 1) {
	ut.jsRedirect(out, "/index.jsp");
	if (true) return;
}

query		= "SELECT OG.GROUP_ID, OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.COUPON_PRICE";
query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID";
query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
query		+= " AND OG.ORDER_NUM = '"+ orderNum  +"' AND O.MEMBER_ID = '"+ eslMemberId +"'";
query		+= " ORDER BY OG.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>주문/결제완료</h1>
			<div class="pageDepth">
				HOME > SHOP > <strong>주문/결제완료</strong>
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
					<h2 class="f26 marb5">잇슬림을 이용해 주셔서 감사합니다.</h2>
					<p class="f14 bold7 marb10">고객님의 주문이 정상적으로 완료되었습니다.<br />
						주문배송에 대한 확인은 마이잇슬림 > 주문배송에서 확인하실 수 있습니다.</p>
					<p class="f14 bold7">(주문번호 <a class="orderNum" href="/shop/mypage/orderInfo.jsp?ono=<%=orderNum%>"><%=orderNum%></a>)</p>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4> <span class="f18 font-blue"> 주문/결제상품 </span> </h4>
						<!--div class="floatright button dark small">
							
						</div-->
					</div>
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>배송구분</th>
							<th>상품명/옵션제품명</th>
							<th>식사기간</th>
							<th>첫배송일</th>
							<th>수량</th>
							<th>판매가격</th>
							<th class="last">합계</th>
						</tr>
						<%
						if (tcnt > 0) {
							while (rs.next()) {
								groupId		= rs.getInt("GROUP_ID");
								orderCnt	= rs.getInt("ORDER_CNT");
								devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
								gubun1		= rs.getString("GUBUN1");
								groupName	= rs.getString("GROUP_NAME");
								couponPrice	= rs.getInt("COUPON_PRICE");
								if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
									devlDate	= rs.getString("WDATE");
									buyBagYn	= rs.getString("BUY_BAG_YN");
									devlDay		= rs.getString("DEVL_DAY");
									devlWeek	= rs.getString("DEVL_WEEK");
									devlPeriod	= devlWeek +"주("+ devlDay +"일)";
									price		= rs.getInt("PRICE");
									goodsPrice	= price * orderCnt;
									dayPrice += goodsPrice;
								} else {
									devlDate	= "-";
									buyBagYn	= "N";
									devlPeriod	= "-";
									price		= rs.getInt("PRICE");
									goodsPrice	= price * orderCnt;
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
						%>
						<tr>
							<td><%=devlType%></td>
							<td>
								<div class="orderName">
									<img class="thumbleft" src="<%=imgUrl%>" />
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
							<td><%=nf.format(price)%>원</td>
							<td>
								<div class="itemprice"><%=nf.format(goodsPrice)%>원</div>
							</td>
						</tr>
						<%
								if (buyBagYn.equals("Y")) {		
									bagPrice	+= defaultBagPrice * orderCnt;
						%>
						<tr>
							<td>일배</td>
							<td>
								<div class="orderName">
									<img class="thumbleft" src="<%=webUploadDir%>goods/groupCart_0300668.jpg" />
									<h4>보냉가방</h4>
								</div>
							</td>
							<td>-</td>
							<td>-</td>
							<td><%=orderCnt%></td>
							<td><%=nf.format(defaultBagPrice)%>원</td>
							<td>
								<div class="itemprice"><%=nf.format(bagPrice)%>원</div>
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
						}
						%>
						<tr>
							<td colspan="7" class="totalprice">
								<span class="font-maple" style="padding-right:15px;">총 결제금액 합계</span>
								<span>상품금액 <strong class="font-blue"><%=nf.format(goodsTprice)%></strong> 원</span> + 
								<span>배송료 <strong class="font-blue"><%=nf.format(devlPrice)%></strong> 원</span> +
								<span>보냉가방 <strong class="font-blue"><%=nf.format(bagPrice)%></strong> 원</span> -
								<span>할인혜택 <strong class="font-blue"><%=nf.format(couponPrice)%></strong> 원</span> =
								<span class="font-blue" style="padding-left:15px;">총 결제금액</span>
								<span class="won padl50"><%=nf.format(totalPrice)%>원</span>
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
						<h4> <span class="f18"> 결제정보 </span> </h4>
					</div>
					<%if (payType.equals("30")) {%>
					<table class="line-black paymentinfo" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>결제방법</th>
							<td>가상계좌(무통장입금)</td>
						</tr>
						<tr>
							<th>입금계좌번호</th>
							<td><%=pgFinanceName%> <%=pgAccountNum%></td>
						</tr>
						<!--tr>
							<th>입금기한</th>
							<td>2013. 08. 06까지</td>
						</tr-->
						<tr>
							<th>결제금액</th>
							<td><span class="won"><%=nf.format(payPrice)%>원</span> (입금해 주실 금액입니다)</td>
						</tr>
					</table>
					<%} else if (payType.equals("10")) {%>
					<table class="line-black paymentinfo" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>결제방법</th>
							<td>신용카드 (<%=pgFinanceName%> <%=pgCardNum%>)</td>
						</tr>
						<!--tr>
							<th>할부형태</th>
							<td>일시불</td>
						</tr-->
						<tr>
							<th>결제금액</th>
							<td><span class="won"><%=nf.format(payPrice)%>원</span> (카드결제 금액입니다)</td>
						</tr>
					</table>
					<%} else if (payType.equals("20")) {%>
					<table class="line-black paymentinfo" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>결제방법</th>
							<td>실시간 계좌이체</td>
						</tr>
						<!--tr>
							<th>할부형태</th>
							<td>국민은행 : 80339078696189(예금주:잇슬림)</td>
						</tr-->
						<tr>
							<th>결제금액</th>
							<td><span class="won"><%=nf.format(payPrice)%>원</span> (계좌이체 금액입니다)</td>
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
						<h4> <span class="f18"> 배송지 정보 </span> </h4>
					</div>
					<%if (dayPrice > 0) {%>
					<div class="sectionHeader">
						<h4> <span class="f18 font-blue"> 일배상품 배송지 정보 </span> </h4>
						<div class="floatright button dark small">
							<a href="/shop/mypage/orderList.jsp">배송지변경</a>
						</div>
					</div>
					<table class="paymentinfo line-blue marb30" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>받으시는분</th>
							<td colspan="3"><%=rcvName%></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><%=rcvTel%></td>
							<th>휴대폰번호</th>
							<td><%=rcvHp%></td>
						</tr>
						<tr>
							<th>배송지주소</th>
							<td colspan="3">(<%=rcvZipcode%>) <%=rcvAddr1%> <%=rcvAddr2%></td>
						</tr>
						<tr>
							<th>배송요청사항</th>
							<td colspan="3"><%=rcvRequest%></td>
						</tr>
					</table>
					<%}%>
					<%if (tagPrice > 0) {%>
					<div class="sectionHeader">
						<h4> <span class="f18 font-green"> 택배상품 배송지 정보 </span> </h4>
						<div class="floatright button dark small">
							<a href="#">배송지변경</a>
						</div>
					</div>
					<table class="paymentinfo line-green" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>받으시는분</th>
							<td colspan="3"><%=tagName%></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><%=tagTel%></td>
							<th>휴대폰번호</th>
							<td><%=tagHp%></td>
						</tr>
						<tr>
							<th>배송지주소</th>
							<td colspan="3">(<%=tagZipcode%>) <%=tagAddr1%> <%=tagAddr2%></td>
						</tr>
						<tr>
							<th>배송요청사항</th>
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
						<a href="#" onClick="window.print();return false;">인쇄하기</a>
					</div>
					<div class="button large dark" style="margin:0 10px;">
						<a href="/shop/orderGuide.jsp">계속 쇼핑하기</a>
					</div>
				</div>
			</div>
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear">
		</div>
	</div>
	<!-- End container -->
	<div id="footer">
<!-- ADWorks Target Script START --><script language="javascript">try{_OPMS_AN='1811';_OPMS_AC='0701';_OPMS_PN='구매';_OPMS_PA='가격';}catch(e){}</script><!-- ADWorks Target Script END -->
<script language='javascript' type='text/javascript'>
var mr_buy = <%=payPrice%>;		// 총구매금액 (신규구매,재구매 분석)
</script> 
<!-- 전환페이지 설정 -->
 <script type="text/javascript" src="//wcs.naver.net/wcslog.js"> </script> 
 <script type="text/javascript">
var _nasa={};
 _nasa["cnv"] = wcs.cnv("1","<%=payPrice%>"); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고
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

<!-- daum 스크립트 -->
<script type="text/javascript"> 
//<![CDATA[ 
var DaumConversionDctSv="type=P,orderID=<%=orderNum%>,amount=<%=payPrice%>"; 
var DaumConversionAccountID="fJS3zx4iKJK.Rb5FRDs.Iw00"; 
if(typeof DaumConversionScriptLoaded=="undefined"&&location.protocol!="file:"){ 
	var DaumConversionScriptLoaded=true; 
	document.write(unescape("%3Cscript%20type%3D%22text/javas"+"cript%22%20src%3D%22"+(location.protocol=="https:"?"https":"http")+"%3A//t1.daumcdn.net/cssjs/common/cts/vr200/dcts.js%22%3E%3C/script%3E")); 
} 
//]]> 
</script>
<!-- daum 스크립트 -->


<!-- WIDERPLANET PURCHASE SCRIPT START 2015.12.22 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script type="text/javascript">
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
	return {
		wp_hcuid:"",  	/*Cross device targeting을 원하는 광고주는 로그인한 사용자의 Unique ID (ex. 로그인 ID, 고객넘버 등)를 암호화하여 대입.
				 *주의: 로그인 하지 않은 사용자는 어떠한 값도 대입하지 않습니다.*/
		ti:"25218",
		ty:"PurchaseComplete",
		device:"web"
		,items:[
			 {i:"<%=groupName%>", t:"<%=groupName%>", p:"<%=payPrice%>", q:"1"}
		]
	};
}));
</script>
<script type="text/javascript" async src="//astg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET PURCHASE SCRIPT END 2015.12.22 -->


		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>
<%@ include file="/lib/dbclose_phi.jsp" %>