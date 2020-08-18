<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderNum		= ut.inject(request.getParameter("ono"));
String orderDate	= ut.inject(request.getParameter("odate"));

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
int goodsPrice		= 0;
int devlPrice		= 0;
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
String rcvZipcode1		= "";
String rcvZipcode2		= "";
String rcvAddr1			= "";
String rcvAddr2			= "";
String rcvRequest		= "";
String tagName			= "";
String tagTel			= "";
String tagHp			= "";
String tagZipcode		= "";
String tagZipcode1		= "";
String tagZipcode2		= "";
String tagAddr1			= "";
String tagAddr2			= "";
String tagRequest		= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String param			= "";
param		= "&amp;page="+ iPage +"&pgsize="+ pgsize;

query		= "SELECT COUNT(ID) FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //총 레코드 수		
}
rs.close();

query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.COUPON_PRICE";
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
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> 주문상세 </h1>
			<div class="pageDepth">
				HOME &gt; My Eatsslim &gt; <strong>주문상세</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one ">
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4>
							<span class="f14">주문번호</span>
							<span class="f18 font-blue" style="padding-right:20px;"><%=orderNum%></span>
							<span class="f14">주문일자</span>
							<span class="f18 font-blue"><%=orderDate%></span>
						</h4>
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
								orderCnt		= rs.getInt("ORDER_CNT");
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

								if (gubun1.equals("01") && Integer.parseInt(orderDate.replace(".", "")) < 20131031) {
						%>
						<tr>
							<td>증정</td>
							<td>
								<div class="orderName">
									<img class="thumbleft" src="<%=webUploadDir%>goods/groupCart_0300576.jpg" />
									<h4>쉐이크믹스(2포)</h4>
								</div>
							</td>
							<td>-</td>
							<td>-</td>
							<td><%=orderCnt%></td>
							<td>0원</td>
							<td>
								<div class="itemprice">0원</div>
							</td>
						</tr>
						<%
								}
							}

							rs.close();

							orderPrice		= dayPrice + tagPrice + bagPrice;
							goodsTprice		= dayPrice + tagPrice;
							if (tagPrice > 0 && tagPrice < 40000) {
								devlPrice		= defaultDevlPrice;
							} else {
								devlPrice		= 0;
							}

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
			query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, ORDER_STATE";
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
				if (rcvZipcode.length() == 6) {
					rcvZipcode1	= rcvZipcode.substring(0,3);
					rcvZipcode2	= rcvZipcode.substring(3,6);
				}
				rcvAddr1		= rs.getString("RCV_ADDR1");
				rcvAddr2		= rs.getString("RCV_ADDR2");
				rcvRequest		= rs.getString("RCV_REQUEST");
				tagName			= rs.getString("TAG_NAME");
				tagTel			= rs.getString("TAG_TEL");
				tagHp			= rs.getString("TAG_HP");
				tagZipcode		= rs.getString("TAG_ZIPCODE");
				if (tagZipcode.length() == 6) {
					tagZipcode1	= tagZipcode.substring(0,3);
					tagZipcode2	= tagZipcode.substring(3,6);
				}
				tagAddr1		= rs.getString("TAG_ADDR1");
				tagAddr2		= rs.getString("TAG_ADDR2");
				tagRequest		= rs.getString("TAG_REQUEST");
				pgCardNum		= rs.getString("PG_CARDNUM");
				pgFinanceName	= rs.getString("PG_FINANCENAME");
				pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
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
							<td><span class="won"><%=nf.format(totalPrice)%>원</span> (입금해 주실 금액입니다)</td>
						</tr>
					</table>
					<%} else if (payType.equals("10")) {%>
					<table class="line-black paymentinfo" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>결제방법</th>
							<td>
								신용카드
								<%if (rs.getInt("ORDER_STATE") > 0) {%>
								(<%=pgFinanceName%> <%=pgCardNum%>)
								<%}%>
							</td>
						</tr>
						<!--tr>
							<th>할부형태</th>
							<td>일시불</td>
						</tr-->
						<tr>
							<th>결제금액</th>
							<td>
								<%if (rs.getInt("ORDER_STATE") == 0) {%>
								결제를 취소하셨습니다.
								<%} else {%>
								<span class="won"><%=nf.format(totalPrice)%>원</span> (카드결제 금액입니다)
								<%}%>
							</td>
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
							<td><span class="won"><%=nf.format(totalPrice)%>원</span> (계좌이체 금액입니다)</td>
						</tr>
					</table>
					<%}%>
				</div>
			</div>
			<!-- End row -->
			<div class="divider">
			</div>
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
							<td colspan="3">(<%=rcvZipcode1%>-<%=rcvZipcode2%>) <%=rcvAddr1%> <%=rcvAddr2%></td>
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
							<td colspan="3">(<%=tagZipcode1%>-<%=tagZipcode2%>) <%=tagAddr1%> <%=tagAddr2%></td>
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
			<div class="row">
				<div class="one last col center">
					<div class="divider"></div>
					<div class="button large darkgreen" style="margin:0 10px;">
						<a href="javascript:print();">인쇄하기</a>
					</div>
					<div class="button large dark" style="margin:0 10px;">
						<a href="orderList.jsp">목록으로</a>
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