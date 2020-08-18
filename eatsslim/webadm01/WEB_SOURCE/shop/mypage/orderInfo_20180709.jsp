<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderNum		= ut.inject(request.getParameter("ono"));
String orderDate	= ""; //ut.inject(request.getParameter("odate"));
String orderDateFrom= "";
String orderDateTo	= "";
String invNo = "";

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
String devlOpt	= "";
int price			= 0;
int groupId			= 0;
String buyBagYn		= "";
String gubun1		= "";
String groupName	= "";
String cartImg		= "";
String imgUrl		= "";
int goodsTprice		= 0;
int orderPrice		= 0;
/*int payPrice		= 0;*/
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
String groupCode	= "";
int goodsId			= 0;

SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
Calendar cal		= Calendar.getInstance();
cal.setTime(new Date()); //오늘
String cDate		= dt.format(cal.getTime());
Date date1			= dt.parse(cDate);
Date date2			= null;
int compare			= 0;
long diff			= 0;
long diffDays		= 0;
int devlType1Count	= 0;
//int devlType10301369Count	= 0;
int cancelDay = 0;//-- 취소가능일

String orderState		= "";
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
String prtnName				= "";
String prtnTel					= "";
String prtnPhnn				= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String param			= "";
param		= "&amp;page="+ iPage +"&pgsize="+ pgsize;

//if (orderDate.equals("") || orderDate.length() < 1) {
	query		= "SELECT DATE_FORMAT(ORDER_DATE, '%Y.%m.%d') ORDER_DATE, DATE_FORMAT(ORDER_DATE, '%Y%m%d') ORDER_DATE_FROM, DATE_FORMAT(DATE_ADD(ORDER_DATE, INTERVAL 1 MONTH), '%Y%m%d') ORDER_DATE_TO FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
	rs			= stmt.executeQuery(query);
	if (rs.next()) {
		orderDate		= rs.getString("ORDER_DATE");
		orderDateFrom	= rs.getString("ORDER_DATE_FROM");
		orderDateTo		= rs.getString("ORDER_DATE_TO");
	}
	rs.close();
//}

query		= "SELECT COUNT(ID) FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //총 레코드 수
}
rs.close();

query		= "SELECT OG.GROUP_ID, OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.COUPON_PRICE, OG.ID, G.GROUP_CODE";
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
				<span>홈</span><span>마이페이지</span><strong>주문상세</strong>
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
						<div class="floatright button dark small orderCancelBtns" style="margin-bottom: 0;">

						</div>
					</div>
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>배송구분</th>
							<th>상품명/옵션제품명/배송기간</th>
							<th>배송조회변경</th>
							<th>첫배송일</th>
							<th>수량</th>
							<th>판매가격</th>
							<th class="last">합계</th>
						</tr>
						<%
						if (tcnt > 0) {
							while (rs.next()) {
								groupId		= rs.getInt("GROUP_ID");
								groupCode	= rs.getString("GROUP_CODE");
								goodsId		= rs.getInt("ID");
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
									devlPeriod	= devlWeek +"주("+ Integer.parseInt(devlWeek)*Integer.parseInt(devlDay) +"일)";
									price		= rs.getInt("PRICE");
									/*
									if (buyBagYn.equals("Y")) {
										price -= defaultBagPrice;
									}
									*/
									goodsPrice	= price * orderCnt;
									dayPrice += goodsPrice;
									devlOpt = "<a href=\"/shop/mypage/calendar.jsp?jsOrderNum="+orderNum+"&jsGoodsId="+goodsId+"&jsGroupCode="+groupCode+"\">주문조회변경</a>";
									//devlOpt += "<a href=\"/shop/mypage/orderAreaList.jsp?jsOrderNum="+orderNum+"&jsGoodsId="+goodsId+"&jsGroupCode="+groupCode+"&devlType="+rs.getString("DEVL_TYPE")+"\">배송지 확인</a>";
									devlOpt += "<a href=\"javascript:void(0);\" onclick=\"window.open('/shop/mypage/orderAreaList.jsp?jsOrderNum="+orderNum+"&jsGoodsId="+goodsId+"&jsGroupCode="+groupCode+"&devlType="+rs.getString("DEVL_TYPE")+"','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=600,height=600')\">배송지 확인</a>";
								} else {

									query		= "SELECT INVOICENO FROM PHIBABY.P_ORDERNEW WHERE ORDERID = '"+ orderNum +"1'";
									rs_phi		= stmt_phi.executeQuery(query);

									if (rs_phi.next()) {
										invNo		= rs_phi.getString("INVOICENO");
									}

									rs_phi.close();

									buyBagYn	= "N";
									devlDate	= "-";
									//devlPeriod	= "<a href=\"javascript:;\" onclick=\"window.open('http://www.doortodoor.co.kr/tracking/jsp/cmn/Tracking_new.jsp?QueryType=1&pOrderNo="+orderNum+"1&pFromDate="+orderDateFrom+"&pToDate="+orderDateTo+"&pCustId=0010049837','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=800,height=600')\"><p class=\"catetag\">배송조회</p></a>";
									//devlPeriod	= "<a href=\"javascript:;\" onclick=\"window.open('https://www.lotteglogis.com/open/tracking?invno="+invNo+"','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=600,height=600')\"><p class=\"catetag\">배송조회</p></a>";
									devlPeriod = "";
									price		= rs.getInt("PRICE");
									goodsPrice	= price * orderCnt;
									tagPrice	+= goodsPrice;
									if (groupId == 15) {
										tagPrice1	+= goodsPrice;
										/* 전체상품 무료배송
										if (tagPrice1 > 40000) {
											devlPrice		= 0;
										} else {
											devlPrice		= defaultDevlPrice;
										}
										*/
									} else if (groupId == 52 || groupId == 53) {
										/*
										devlPrice1		= defaultDevlPrice;
										*/
									}
									devlOpt = "<a href=\"javascript:void(0);\" onclick=\"window.open('https://www.lotteglogis.com/open/tracking?invno="+invNo+"','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=600,height=600')\">배송조회</a>";
									//devlOpt += "<a href=\"/shop/mypage/orderAreaList.jsp?jsOrderNum="+orderNum+"&jsGoodsId="+goodsId+"&jsGroupCode="+groupCode+"&devlType="+rs.getString("DEVL_TYPE")+"\">배송지 확인</a>";
									devlOpt = "<a href=\"javascript:;\" onclick=\"window.open('http://www.doortodoor.co.kr/tracking/jsp/cmn/Tracking_new.jsp?QueryType=1&pOrderNo="+orderNum+"1&pFromDate="+orderDateFrom+"&pToDate="+orderDateTo+"&pCustId=30280287','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=800,height=600')\"><p class=\"catetag\">배송조회</p></a>";
									devlOpt += "<a href=\"javascript:void(0);\" onclick=\"window.open('/shop/mypage/orderAreaList.jsp?jsOrderNum="+orderNum+"&jsGoodsId="+goodsId+"&jsGroupCode="+groupCode+"&devlType="+rs.getString("DEVL_TYPE")+"','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=600,height=600')\">배송지 확인</a>";
								}
								cartImg		= rs.getString("CART_IMG");
								if (cartImg.equals("") || cartImg == null) {
									imgUrl		= "/images/order_sample.jpg";
								} else {
									imgUrl		= webUploadDir +"goods/"+ cartImg;
								}

								if (rs.getString("DEVL_TYPE").equals("0001")) {
									devlType1Count++; //-- 일일배송상품 카운팅
									//if("0301369".equals(groupCode) ) devlType10301369Count++; //-- 헬씨퀴진 카운팅
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
									<span><%=devlPeriod%></span>
								</div>
							</td>
							<td>
								<div class="opt">
									<%=devlOpt%>
								</div>
							</td>
							<td><%=devlDate%></td>
							<td><%=orderCnt%></td>
							<td><div class="itemprice"><%=nf.format(price)%>원</div></td>
							<td>
								<div class="itemprice"><%=nf.format(goodsPrice)%>원</div>
							</td>
						</tr>
						<%
								if (buyBagYn.equals("Y")) {
									bagPrice	+= defaultBagPrice;// * orderCnt;
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
							<td><div class="itemprice"><%=nf.format(defaultBagPrice)%>원</div></td>
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
							<td><div class="itemprice">0원</div></td>
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
			query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, ORDER_STATE, AGENCY_NAME, TELNO, HPNO";
			query		+= " FROM ESL_ORDER EO LEFT JOIN ";
			query		+= "  ( SELECT EODA.AGENCY_NAME, EODA.TELNO, EODA.HPNO, EODD.ORDER_NUM FROM ESL_ORDER_DEVL_DATE EODD, ESL_ORDER_DEVL_AGENCY EODA ";
			query		+= "    WHERE EODD.ORDER_NUM = '" + orderNum + "'";
			query		+= "     AND EODD.AGENCYID = EODA.AGENCY_ID ";
			query		+= "     LIMIT 1 ) EOD ";
			query		+= "  ON EO.ORDER_NUM = EOD.ORDER_NUM ";
			query		+= " 	WHERE EO.ORDER_NUM = '"+ orderNum +"'";
			try {
				rs			= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			if (rs.next()) {
				orderState		= rs.getString("ORDER_STATE");
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
				prtnName			= rs.getString("AGENCY_NAME");
				prtnTel				= rs.getString("TELNO");
				prtnPhnn			= rs.getString("HPNO");
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
						<!-- <div class="floatright button dark small">
							<a href="/shop/mypage/calendar.jsp">배송지변경</a>
						</div> -->
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
						<tr>
							<th>배송점 정보</th>
							<td colspan="3">
							<% if ( prtnName != null ) { %>
								<%=prtnName%>( <%=prtnTel%>, <%=prtnPhnn%>)
							<% } %>
							</td>
						</tr>
					</table>
					<%}%>
					<%if (tagPrice > 0) {%>
					<div class="sectionHeader">
						<h4> <span class="f18 font-green"> 택배상품 배송지 정보 </span> </h4>
						<!-- <div class="floatright button dark small">
							<a href="#">배송지변경</a>
						</div> -->
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
<%
//-- 취소버튼 처리
if(devlType1Count > 0){
	//-- 일배 취소가능일
	cancelDay = 4;
	if( 150000 >= Integer.parseInt(ut.getTimeStamp(10))){ //-- 헬씨퀴진은 15시 전까지는 2일 넘으면 3일을 적용한다.
		cancelDay = 3;
	}
}
else{
	//-- 택배 취소가능일
	cancelDay = 1;
}

if (Integer.parseInt(orderState) > 0) {
	query	= "SELECT MIN(DATE_FORMAT(DEVL_DATE, '%Y%m%d')) DEVL_DATE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
} else {
	query	= "SELECT MIN(DATE_FORMAT(DEVL_DATE, '%Y%m%d')) DEVL_DATE FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'";
}
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	devlDate	= rs.getString("DEVL_DATE");
	date2		= dt.parse(devlDate);
	diff		= date2.getTime() - date1.getTime();
	diffDays	= diff / (24 * 60 * 60 * 1000);

	//System.out.println(dt.format(date1.getTime()) +":"+ dt.format(date2.getTime()) +":"+ diffDays +":"+ cancelDay);
}
rs.close();


if (Integer.parseInt(orderState) < 2 && diffDays >= cancelDay) {
%>
<script type="text/javascript">
	$(function(){
		$(".orderCancelBtns").html('<a class="lightbox" href="/shop/popup/orderCancel.jsp?lightbox[width]=800&lightbox[height]=550&ono=<%=orderNum%>&odate=<%=orderDate%>">전체주문취소</a>');
	});
</script>
<%
}
%>
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
<%@ include file="/lib/dbclose_phi.jsp" %>
<%@ include file="/lib/dbclose.jsp"%>