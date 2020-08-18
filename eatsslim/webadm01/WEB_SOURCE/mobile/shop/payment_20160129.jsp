<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
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
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
    <!-- End ui-header -->    
    <!-- Start Content -->
	<div id="content">
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
				orderDate	= rs.getString("ORDER_DATE");
		%>
		<dl class="itemlist">
			<dt style="width:70%;">
				<%=groupName%>/<%=orderCnt%>개
				<p class="font-gray">배송기간:<%=devlPeriod%> / 첫배송일 : <%=devlDate%></p>
			</dt>
			<dd style="width:30%;"><%=nf.format(goodsPrice)%>원</dd>
		</dl>
		<%
				if (buyBagYn.equals("Y")) {		
					bagPrice	+= defaultBagPrice * orderCnt;
		%>
		<dl class="itemlist">
			<dt style="width:70%;">보냉가방/<%=orderCnt%>개<p class="font-gray">첫배송일 : <%=devlDate%></p></dt>
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

    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>