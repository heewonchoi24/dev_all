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

query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.COUPON_PRICE";
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
								if (gubun1.equals("01")) {
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
<%
/*
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////   파이연동
String query1		= "";
String query2		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
Statement stmt2		= null;
ResultSet rs2		= null;
stmt2				= conn.createStatement();
Statement stmt2_phi	= null;
ResultSet rs2_phi	= null;
stmt2_phi			= conn_phi.createStatement();
String orderName	= "";
String email		= "";
String rcvType		= "";
String rcvPassYn	= "";
String rcvPass		= "";
int couponTprice	= 0; //상품할인 쿠폰 총금액
String orderDate	= ""; //주문일
String ssType		= "";

//================PHI 연동
int i				= 1;
int k				= 0;
int maxK			= 0;
int ordSeq			= 0;
String rcvPartner	= "";
String tagPartner	= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
String instDate		= dt.format(new Date());
Date date			= null;
String groupCode	= "";
String devlDatePhi	= "";
String customerNum	= "";
String gubun2		= "";
String gubun3		= "";
int week			= 1;
int chkCnt			= 0;
int phiCnt			= 0;

query		= "SELECT COUNT(ORD_SEQ) FROM PHIBABY.P_ORDER_MALL_PHI_ITF WHERE ORD_NO = '"+ orderNum +"'";
try {
	rs_phi		= stmt_phi.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs_phi.next()) {
	phiCnt		= rs_phi.getInt(1);
}

rs_phi.close();

if (phiCnt < 1) {
	query		= "SELECT CUSTOMER_NUM, ORDER_NAME, RCV_NAME, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_HP, RCV_TEL, RCV_PASS_YN,";
	query		+= "		RCV_PASS, RCV_REQUEST, TAG_NAME, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_HP, TAG_TEL, TAG_REQUEST,";
	query		+= "		DATE_FORMAT(ORDER_DATE, '%Y%m%d') ORDER_DATE, GOODS_PRICE, DEVL_PRICE, COUPON_PRICE, PAY_PRICE,";
	query		+= "		PAY_TYPE";
	query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		customerNum			= rs.getString("CUSTOMER_NUM");
		orderName			= rs.getString("ORDER_NAME");
		rcvName				= rs.getString("RCV_NAME");
		rcvZipcode			= rs.getString("RCV_ZIPCODE");
		rcvAddr1			= rs.getString("RCV_ADDR1");
		rcvAddr2			= rs.getString("RCV_ADDR2");
		rcvHp				= rs.getString("RCV_HP");
		rcvTel				= rs.getString("RCV_TEL");
		if (rcvTel.equals("") || rcvTel == null) {
			rcvTel				= "--";
		}
		rcvPassYn			= rs.getString("RCV_PASS_YN");
		rcvPass				= rs.getString("RCV_PASS");
		rcvRequest			= rs.getString("RCV_REQUEST");
		tagName				= rs.getString("TAG_NAME");
		tagZipcode			= rs.getString("TAG_ZIPCODE");
		tagAddr1			= rs.getString("TAG_ADDR1");
		tagAddr2			= rs.getString("TAG_ADDR2");
		tagHp				= rs.getString("TAG_HP");
		tagTel				= rs.getString("TAG_TEL");
		if (tagTel.equals("") || tagTel == null) {
			tagTel				= "--";
		}
		tagRequest			= rs.getString("TAG_REQUEST");
		orderDate			= rs.getString("ORDER_DATE");
		goodsPrice			= rs.getInt("GOODS_PRICE");
		devlPrice			= rs.getInt("DEVL_PRICE");
		payPrice			= rs.getInt("PAY_PRICE");
		couponPrice			= rs.getInt("COUPON_PRICE");
		payType				= rs.getString("PAY_TYPE");
	}


	// 일배 위탁점 조회
	query		= "SELECT PARTNERID FROM PHIBABY.V_ZIPCODE WHERE ZIPCODE = '"+ rcvZipcode +"'";
	try {
		rs_phi		= stmt_phi.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs_phi.next()) {
		rcvPartner		= rs_phi.getString("PARTNERID");
	}
	rs_phi.close();


	// 택배 위탁점 조회
	query		= "SELECT PARTNERID FROM PHIBABY.V_ZIPCODE WHERE ZIPCODE = '"+ tagZipcode +"'";
	try {
		rs_phi		= stmt_phi.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs_phi.next()) {
		tagPartner		= rs_phi.getString("PARTNERID");
	}
	rs_phi.close();

	query		= "UPDATE PHIBABY.P_ORDER_MALL_PHI_ITF SET INTERFACE_FLAG_YN = 'Y' WHERE ORD_NO = '"+ orderNum +"'";
	try {
		stmt_phi.executeUpdate(query);
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}

	query		= "SELECT ";
	query		+= "	GROUP_CODE, GROUP_ID, ORDER_CNT, DEVL_TYPE, DEVL_DAY, DEVL_WEEK, GUBUN1, GUBUN2,";
	query		+= "	DATE_FORMAT(DEVL_DATE, '%Y%m%d') DEVL_DATE, PRICE, BUY_BAG_YN, SS_TYPE";
	query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G";
	query		+= " WHERE OG.GROUP_ID = G.ID AND OG.ORDER_NUM = '"+ orderNum +"'";
	try {
		rs = stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	while (rs.next()) {
		// 시퀀스 조회
		query		= "SELECT MAX(ORD_SEQ) FROM PHIBABY.P_ORDER_MALL_PHI_ITF";
		try {
			rs_phi		= stmt_phi.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs_phi.next()) {
			ordSeq		= rs_phi.getInt(1) + 1;
		}
		rs_phi.close();

		i			= 1;
		groupCode	= rs.getString("GROUP_CODE");
		orderCnt	= rs.getInt("ORDER_CNT");
		devlType	= rs.getString("DEVL_TYPE");
		devlDay		= rs.getString("DEVL_DAY");
		devlWeek	= rs.getString("DEVL_WEEK");
		devlDate	= rs.getString("DEVL_DATE");
		buyBagYn	= rs.getString("BUY_BAG_YN");
		gubun1		= rs.getString("GUBUN1");
		gubun2		= rs.getString("GUBUN2");
		ssType		= rs.getString("SS_TYPE");
		price		= (gubun1.equals("01"))? rs.getInt("PRICE") / (Integer.parseInt(devlDay) * Integer.parseInt(devlWeek)) : rs.getInt("PRICE");

		query1		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
		query1		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM)";
		query1		+= "	VALUES";
		query1		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
		pstmt_phi					= conn_phi.prepareStatement(query1);
		if (gubun2.equals("31")) {
			k			= 0;
			maxK		= (Integer.parseInt(devlDay) * Integer.parseInt(devlWeek)) - 1;

			for (int j = 0; j < 50; j++) {
				date			= dt.parse(devlDate);
				Calendar cal	= Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.DATE, j);
				if (ssType.equals("1")) {					
					if (cal.get(cal.DAY_OF_WEEK) == 1 || cal.get(cal.DAY_OF_WEEK) == 3 || cal.get(cal.DAY_OF_WEEK) == 5 || cal.get(cal.DAY_OF_WEEK) == 7) { //일요일, 화목토는 배송을 하지 않는다
					} else {
						query2		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE WHERE GUBUN2 = '"+ gubun2 +"'";
						query2		+= " AND DAY_OF_WEEK = '"+ cal.get(cal.DAY_OF_WEEK) +"'";
						try {
							rs2 = stmt2.executeQuery(query2);
						} catch(Exception e) {
							out.println(e+"=>"+query2);
							if(true)return;
						}

						if (rs2.next()) {
							groupCode		= rs2.getString("GROUP_CODE");
							price			= rs2.getInt("PRICE");
						}
						devlDatePhi		= dt.format(cal.getTime());
						pstmt_phi.setInt(1, ordSeq);
						pstmt_phi.setString(2, instDate);
						pstmt_phi.setString(3, orderNum);
						pstmt_phi.setString(4, customerNum);
						pstmt_phi.setString(5, "I");
						pstmt_phi.setString(6, orderName);
						pstmt_phi.setString(7, rcvName);
						pstmt_phi.setString(8, rcvZipcode);
						pstmt_phi.setString(9, rcvAddr1);
						pstmt_phi.setString(10, rcvAddr2);
						pstmt_phi.setString(11, rcvTel);
						pstmt_phi.setString(12, rcvHp);
						pstmt_phi.setString(13, email);
						pstmt_phi.setInt(14, goodsPrice);
						pstmt_phi.setInt(15, payPrice);
						pstmt_phi.setInt(16, devlPrice);
						pstmt_phi.setInt(17, couponPrice);
						pstmt_phi.setString(18, payType);
						pstmt_phi.setString(19, "0001");
						pstmt_phi.setString(20, rcvPartner);
						pstmt_phi.setString(21, rcvRequest);
						pstmt_phi.setInt(22, i);
						pstmt_phi.setString(23, devlDatePhi);
						pstmt_phi.setString(24, groupCode);
						pstmt_phi.setInt(25, orderCnt);
						pstmt_phi.setInt(26, price);
						pstmt_phi.setInt(27, price);
						try {
							pstmt_phi.executeUpdate();
						} catch (Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}
						k++;
					}
				} else if (ssType.equals("2")) {
					if (cal.get(cal.DAY_OF_WEEK) == 1 || cal.get(cal.DAY_OF_WEEK) == 2 || cal.get(cal.DAY_OF_WEEK) == 4 || cal.get(cal.DAY_OF_WEEK) == 6) { //일요일, 월수금은 배송을 하지 않는다
					} else {
						query2		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE WHERE GUBUN2 = '"+ gubun2 +"'";
						query2		+= " AND DAY_OF_WEEK = '"+ cal.get(cal.DAY_OF_WEEK) +"'";
						try {
							rs2 = stmt2.executeQuery(query2);
						} catch(Exception e) {
							out.println(e+"=>"+query2);
							if(true)return;
						}

						if (rs2.next()) {
							groupCode		= rs2.getString("GROUP_CODE");
							price			= rs2.getInt("PRICE");
						}
						devlDatePhi		= dt.format(cal.getTime());
						pstmt_phi.setInt(1, ordSeq);
						pstmt_phi.setString(2, instDate);
						pstmt_phi.setString(3, orderNum);
						pstmt_phi.setString(4, customerNum);
						pstmt_phi.setString(5, "I");
						pstmt_phi.setString(6, orderName);
						pstmt_phi.setString(7, rcvName);
						pstmt_phi.setString(8, rcvZipcode);
						pstmt_phi.setString(9, rcvAddr1);
						pstmt_phi.setString(10, rcvAddr2);
						pstmt_phi.setString(11, rcvTel);
						pstmt_phi.setString(12, rcvHp);
						pstmt_phi.setString(13, email);
						pstmt_phi.setInt(14, goodsPrice);
						pstmt_phi.setInt(15, payPrice);
						pstmt_phi.setInt(16, devlPrice);
						pstmt_phi.setInt(17, couponPrice);
						pstmt_phi.setString(18, payType);
						pstmt_phi.setString(19, "0001");
						pstmt_phi.setString(20, rcvPartner);
						pstmt_phi.setString(21, rcvRequest);
						pstmt_phi.setInt(22, i);
						pstmt_phi.setString(23, devlDatePhi);
						pstmt_phi.setString(24, groupCode);
						pstmt_phi.setInt(25, orderCnt);
						pstmt_phi.setInt(26, price);
						pstmt_phi.setInt(27, price);
						try {
							pstmt_phi.executeUpdate();
						} catch (Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}
						k++;
					}
				} else {
					if (cal.get(cal.DAY_OF_WEEK) == 1) { //일요일은 배송을 하지 않는다
					} else {
						query2		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE WHERE GUBUN2 = '"+ gubun2 +"'";
						query2		+= " AND DAY_OF_WEEK = '"+ cal.get(cal.DAY_OF_WEEK) +"'";
						try {
							rs2 = stmt2.executeQuery(query2);
						} catch(Exception e) {
							out.println(e+"=>"+query2);
							if(true)return;
						}

						if (rs2.next()) {
							groupCode		= rs2.getString("GROUP_CODE");
							price			= rs2.getInt("PRICE");
						}

						rs2.close();

						devlDatePhi		= dt.format(cal.getTime());
						pstmt_phi.setInt(1, ordSeq);
						pstmt_phi.setString(2, instDate);
						pstmt_phi.setString(3, orderNum);
						pstmt_phi.setString(4, customerNum);
						pstmt_phi.setString(5, "I");
						pstmt_phi.setString(6, orderName);
						pstmt_phi.setString(7, rcvName);
						pstmt_phi.setString(8, rcvZipcode);
						pstmt_phi.setString(9, rcvAddr1);
						pstmt_phi.setString(10, rcvAddr2);
						pstmt_phi.setString(11, rcvTel);
						pstmt_phi.setString(12, rcvHp);
						pstmt_phi.setString(13, email);
						pstmt_phi.setInt(14, goodsPrice);
						pstmt_phi.setInt(15, payPrice);
						pstmt_phi.setInt(16, devlPrice);
						pstmt_phi.setInt(17, couponPrice);
						pstmt_phi.setString(18, payType);
						pstmt_phi.setString(19, "0001");
						pstmt_phi.setString(20, rcvPartner);
						pstmt_phi.setString(21, rcvRequest);
						pstmt_phi.setInt(22, i);
						pstmt_phi.setString(23, devlDatePhi);
						pstmt_phi.setString(24, groupCode);
						pstmt_phi.setInt(25, orderCnt);
						pstmt_phi.setInt(26, price);
						pstmt_phi.setInt(27, price);
						try {
							pstmt_phi.executeUpdate();
						} catch (Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}
						k++;
					}
				}

				i++;
				ordSeq++;
				if (k > maxK) break;
			}

			if (buyBagYn.equals("Y")) {
				pstmt_phi.setInt(1, ordSeq);
				pstmt_phi.setString(2, instDate);
				pstmt_phi.setString(3, orderNum);
				pstmt_phi.setString(4, customerNum);
				pstmt_phi.setString(5, "I");
				pstmt_phi.setString(6, orderName);
				pstmt_phi.setString(7, rcvName);
				pstmt_phi.setString(8, rcvZipcode);
				pstmt_phi.setString(9, rcvAddr1);
				pstmt_phi.setString(10, rcvAddr2);
				pstmt_phi.setString(11, rcvTel);
				pstmt_phi.setString(12, rcvHp);
				pstmt_phi.setString(13, email);
				pstmt_phi.setInt(14, goodsPrice);
				pstmt_phi.setInt(15, payPrice);
				pstmt_phi.setInt(16, devlPrice);
				pstmt_phi.setInt(17, couponPrice);
				pstmt_phi.setString(18, payType);
				pstmt_phi.setString(19, "0001");
				pstmt_phi.setString(20, rcvPartner);
				pstmt_phi.setString(21, rcvRequest);
				pstmt_phi.setInt(22, i);
				pstmt_phi.setString(23, devlDate);
				pstmt_phi.setString(24, "0300668");
				pstmt_phi.setInt(25, orderCnt);
				pstmt_phi.setInt(26, defaultBagPrice);
				pstmt_phi.setInt(27, defaultBagPrice);
				try {
					pstmt_phi.executeUpdate();
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}
			}
			
		} else if (devlType.equals("0001")) {
			k			= 0;
			maxK		= (Integer.parseInt(devlDay) * Integer.parseInt(devlWeek)) - 1;

			for (int j = 0; j < 50; j++) {
				date			= dt.parse(devlDate);
				Calendar cal	= Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.DATE, j);
				if (devlDay.equals("6")) {
					if (cal.get(cal.DAY_OF_WEEK) == 1) { //일요일은 배송을 하지 않는다
					} else {
						devlDatePhi		= dt.format(cal.getTime());
						pstmt_phi.setInt(1, ordSeq);
						pstmt_phi.setString(2, instDate);
						pstmt_phi.setString(3, orderNum);
						pstmt_phi.setString(4, customerNum);
						pstmt_phi.setString(5, "I");
						pstmt_phi.setString(6, orderName);
						pstmt_phi.setString(7, rcvName);
						pstmt_phi.setString(8, rcvZipcode);
						pstmt_phi.setString(9, rcvAddr1);
						pstmt_phi.setString(10, rcvAddr2);
						pstmt_phi.setString(11, rcvTel);
						pstmt_phi.setString(12, rcvHp);
						pstmt_phi.setString(13, email);
						pstmt_phi.setInt(14, goodsPrice);
						pstmt_phi.setInt(15, payPrice);
						pstmt_phi.setInt(16, devlPrice);
						pstmt_phi.setInt(17, couponPrice);
						pstmt_phi.setString(18, payType);
						pstmt_phi.setString(19, "0001");
						pstmt_phi.setString(20, rcvPartner);
						pstmt_phi.setString(21, rcvRequest);
						pstmt_phi.setInt(22, i);
						pstmt_phi.setString(23, devlDatePhi);
						pstmt_phi.setString(24, groupCode);
						pstmt_phi.setInt(25, orderCnt);
						pstmt_phi.setInt(26, price);
						pstmt_phi.setInt(27, price);
						try {
							pstmt_phi.executeUpdate();
						} catch (Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}
						k++;
					}
				} else {
					if (cal.get(cal.DAY_OF_WEEK) == 7 || cal.get(cal.DAY_OF_WEEK) == 1) { // 토, 일요일은 배송을 하지 않는다	
					} else {
						if (gubun1.equals("02")) {
							query2		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE WHERE GUBUN2 = '"+ gubun2 +"'";
							query2		+= " AND DAY_OF_WEEK = '"+ cal.get(cal.DAY_OF_WEEK) +"' AND GUBUN3 = '"+ week +"'";
							try {
								rs2 = stmt2.executeQuery(query2);
							} catch(Exception e) {
								out.println(e+"=>"+query2);
								if(true)return;
							}

							if (rs2.next()) {
								groupCode		= rs2.getString("GROUP_CODE");
								price			= rs2.getInt("PRICE");
							}
						}
						devlDatePhi		= dt.format(cal.getTime());
						pstmt_phi.setInt(1, ordSeq);
						pstmt_phi.setString(2, instDate);
						pstmt_phi.setString(3, orderNum);
						pstmt_phi.setString(4, customerNum);
						pstmt_phi.setString(5, "I");
						pstmt_phi.setString(6, orderName);
						pstmt_phi.setString(7, rcvName);
						pstmt_phi.setString(8, rcvZipcode);
						pstmt_phi.setString(9, rcvAddr1);
						pstmt_phi.setString(10, rcvAddr2);
						pstmt_phi.setString(11, rcvTel);
						pstmt_phi.setString(12, rcvHp);
						pstmt_phi.setString(13, email);
						pstmt_phi.setInt(14, goodsPrice);
						pstmt_phi.setInt(15, payPrice);
						pstmt_phi.setInt(16, devlPrice);
						pstmt_phi.setInt(17, couponPrice);
						pstmt_phi.setString(18, payType);
						pstmt_phi.setString(19, "0001");
						pstmt_phi.setString(20, rcvPartner);
						pstmt_phi.setString(21, rcvRequest);
						pstmt_phi.setInt(22, i);
						pstmt_phi.setString(23, devlDatePhi);
						pstmt_phi.setString(24, groupCode);
						pstmt_phi.setInt(25, orderCnt);
						pstmt_phi.setInt(26, price);
						pstmt_phi.setInt(27, price);
						try {
							pstmt_phi.executeUpdate();
						} catch (Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}
						k++;
						if (gubun1.equals("02")) {
							if (k % 5 == 0) week++;
						}
					}
				}

				i++;
				ordSeq++;
				if (k > maxK) break;
			}

			if (buyBagYn.equals("Y")) {
				pstmt_phi.setInt(1, ordSeq);
				pstmt_phi.setString(2, instDate);
				pstmt_phi.setString(3, orderNum);
				pstmt_phi.setString(4, customerNum);
				pstmt_phi.setString(5, "I");
				pstmt_phi.setString(6, orderName);
				pstmt_phi.setString(7, rcvName);
				pstmt_phi.setString(8, rcvZipcode);
				pstmt_phi.setString(9, rcvAddr1);
				pstmt_phi.setString(10, rcvAddr2);
				pstmt_phi.setString(11, rcvTel);
				pstmt_phi.setString(12, rcvHp);
				pstmt_phi.setString(13, email);
				pstmt_phi.setInt(14, goodsPrice);
				pstmt_phi.setInt(15, payPrice);
				pstmt_phi.setInt(16, devlPrice);
				pstmt_phi.setInt(17, couponPrice);
				pstmt_phi.setString(18, payType);
				pstmt_phi.setString(19, "0001");
				pstmt_phi.setString(20, rcvPartner);
				pstmt_phi.setString(21, rcvRequest);
				pstmt_phi.setInt(22, i);
				pstmt_phi.setString(23, devlDate);
				pstmt_phi.setString(24, "0300668");
				pstmt_phi.setInt(25, orderCnt);
				pstmt_phi.setInt(26, defaultBagPrice);
				pstmt_phi.setInt(27, defaultBagPrice);
				try {
					pstmt_phi.executeUpdate();
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}
			}

			ordSeq++;

			if (gubun1.equals("01")) {
				pstmt_phi.setInt(1, ordSeq);
				pstmt_phi.setString(2, instDate);
				pstmt_phi.setString(3, orderNum);
				pstmt_phi.setString(4, customerNum);
				pstmt_phi.setString(5, "I");
				pstmt_phi.setString(6, orderName);
				pstmt_phi.setString(7, rcvName);
				pstmt_phi.setString(8, rcvZipcode);
				pstmt_phi.setString(9, rcvAddr1);
				pstmt_phi.setString(10, rcvAddr2);
				pstmt_phi.setString(11, rcvTel);
				pstmt_phi.setString(12, rcvHp);
				pstmt_phi.setString(13, email);
				pstmt_phi.setInt(14, goodsPrice);
				pstmt_phi.setInt(15, payPrice);
				pstmt_phi.setInt(16, devlPrice);
				pstmt_phi.setInt(17, couponPrice);
				pstmt_phi.setString(18, payType);
				pstmt_phi.setString(19, "0001");
				pstmt_phi.setString(20, rcvPartner);
				pstmt_phi.setString(21, rcvRequest);
				pstmt_phi.setInt(22, i);
				pstmt_phi.setString(23, devlDate);
				pstmt_phi.setString(24, "0300576");
				pstmt_phi.setInt(25, orderCnt);
				pstmt_phi.setInt(26, 0);
				pstmt_phi.setInt(27, 0);
				try {
					pstmt_phi.executeUpdate();
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}
			}
		} else {
			Date date1	= null;
			date1		= dt.parse(devlDate);

			Calendar cal	= Calendar.getInstance();
			cal.setTime(date1);
			cal.add(Calendar.DATE, 2);
			devlDatePhi		= dt.format(cal.getTime());

			pstmt_phi.setInt(1, ordSeq);
			pstmt_phi.setString(2, instDate);
			pstmt_phi.setString(3, orderNum);
			pstmt_phi.setString(4, customerNum);
			pstmt_phi.setString(5, "I");
			pstmt_phi.setString(6, orderName);
			pstmt_phi.setString(7, tagName);
			pstmt_phi.setString(8, tagZipcode);
			pstmt_phi.setString(9, tagAddr1);
			pstmt_phi.setString(10, tagAddr2);
			pstmt_phi.setString(11, tagTel);
			pstmt_phi.setString(12, tagHp);
			pstmt_phi.setString(13, email);
			pstmt_phi.setInt(14, goodsPrice);
			pstmt_phi.setInt(15, payPrice);
			pstmt_phi.setInt(16, devlPrice);
			pstmt_phi.setInt(17, couponPrice);
			pstmt_phi.setString(18, payType);
			pstmt_phi.setString(19, "0002");
			pstmt_phi.setString(20, tagPartner);
			pstmt_phi.setString(21, tagRequest);
			pstmt_phi.setInt(22, i);
			pstmt_phi.setString(23, devlDatePhi);
			pstmt_phi.setString(24, groupCode);
			pstmt_phi.setInt(25, orderCnt);
			pstmt_phi.setInt(26, price);
			pstmt_phi.setInt(27, price);
			try {
				pstmt_phi.executeUpdate();
			} catch (Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}
		}
	}

	query		= "SELECT COUNT(ID) FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		chkCnt		= rs.getInt(1);
	}

	if (chkCnt < 1) {
		// 파이에서 데이터를 받아서 몰에 주문 처리 한다
		query		= "SELECT * FROM PHIBABY.P_ORDER_MALL_PHI_ITF WHERE ORD_NO = '"+ orderNum +"'";
		try {
			rs_phi		= stmt_phi.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		while (rs_phi.next()) {
			query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
			query1		+= "		ORDER_DATE			= '"+ rs_phi.getString("ORD_DATE") +"'";
			query1		+= "		, ORDER_NUM			= '"+ orderNum +"'";
			query1		+= "		, CUSTOMER_NUM		= '"+ rs_phi.getString("PARTNERID") +"'";
			query1		+= "		, ORDER_NAME		= '"+ rs_phi.getString("ORD_NM") +"'";
			query1		+= "		, RCV_NAME			= '"+ rs_phi.getString("RCVR_NM") +"'";
			query1		+= "		, RCV_ZIPCODE		= '"+ rs_phi.getString("RCVR_ZIPCD") +"'";
			query1		+= "		, RCV_ADDR1			= '"+ rs_phi.getString("RCVR_ADDR1") +"'";
			query1		+= "		, RCV_ADDR2			= '"+ rs_phi.getString("RCVR_ADDR2") +"'";
			query1		+= "		, RCV_TEL			= '"+ rs_phi.getString("RCVR_TELNO") +"'";
			query1		+= "		, RCV_HP			= '"+ rs_phi.getString("RCVR_MOBILENO") +"'";
			query1		+= "		, RCV_EMAIL			= '"+ rs_phi.getString("RCVR_EMAIL") +"'";
			query1		+= "		, TOT_SELL_PRICE	= '"+ rs_phi.getInt("TOT_SELL_PRICE") +"'";
			query1		+= "		, TOT_PAY_PRICE		= '"+ rs_phi.getInt("TOT_REC_PRICE") +"'";
			query1		+= "		, TOT_DEVL_PRICE	= '"+ rs_phi.getInt("TOT_DELV_PRICE") +"'";
			query1		+= "		, TOT_DC_PRICE		= '"+ rs_phi.getInt("TOT_DC_PRICE") +"'";
			query1		+= "		, PAY_TYPE			= '"+ rs_phi.getString("REC_TYPE") +"'";
			query1		+= "		, DEVL_TYPE			= '"+ rs_phi.getString("DELV_TYPE") +"'";
			query1		+= "		, AGENCYID			= '"+ rs_phi.getString("AGENCYID") +"'";
			query1		+= "		, RCV_REQUEST		= '"+ rs_phi.getString("ORD_MEMO") +"'";
			query1		+= "		, GROUP_CODE		= '"+ rs_phi.getString("GOODS_NO") +"'";
			query1		+= "		, DEVL_DATE			= '"+ rs_phi.getString("DELV_DATE") +"'";
			query1		+= "		, ORDER_CNT			= '"+ rs_phi.getInt("ORD_CNT") +"'";
			query1		+= "		, PRICE				= '"+ rs_phi.getInt("SELL_PRICE") +"'";
			query1		+= "		, PAY_PRICE			= '"+ rs_phi.getInt("REC_PRICE") +"'";
			query1		+= "		, STATE				= '01'";
			try {
				stmt.executeUpdate(query1);
			} catch (Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}
		}
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////////
*/
%>
<%@ include file="/lib/dbclose.jsp"%>
<%@ include file="/lib/dbclose_phi.jsp" %>