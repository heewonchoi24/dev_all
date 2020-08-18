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
String orderDate	= ut.inject(request.getParameter("odate"));

if (orderNum == null || orderNum.equals("")) {
	ut.jsRedirect(out, "/mobile/index.jsp");
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
String groupImg		= "";
String imgUrl		= "";
int goodsTprice		= 0;
/*int orderPrice		= 0;*/
//int payPrice		= 0;
int totalPrice		= 0;
int dayPrice		= 0;
int tagPrice		= 0;
int goodsPrice		= 0;
int devlPrice		= 0;
int bagPrice		= 0;
int couponPrice		= 0;
int zipCnt			= 0;
String devlCheck	= "";
String groupCode	= "";
int goodsId			= 0;
NumberFormat nf = NumberFormat.getNumberInstance();

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
int devlType10301369Count	= 0;
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
String pgNum			= "";
String pgTxt			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String orderDateFrom	= "";
String orderDateTo		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String param			= "";
param		= "&amp;page="+ iPage +"&pgsize="+ pgsize;
%>

<script type="text/javascript" src="/common/js/date.js"></script>
<script type="text/javascript" src="/common/js/jquery.datePicker.js"></script>
<script type="text/javascript" src="/common/js/common.js"></script>

</head>
<body>
<div id="wrap" class="expansioncss">
	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="container">
		<div class="container_inner">
			<section id="index_content" class="contents">
				<header class="cont_header">
					<button type="button" class="loc_back" onclick="history.back();"><img src="/mobile/common/images/ico/ico_loc_back.png" alt=""></button>
					<h2>주문배송조회</h2>
				</header>
				<div id="content">
					<!-- <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">주문배송조회</span></span></h1> -->
					<div id="myOrder" class="detail">
						<h2>주문정보</h2>
			<%
			query		= "SELECT DATE_FORMAT(ORDER_DATE, '%Y%m%d') ORDER_DATE_FROM, DATE_FORMAT(DATE_ADD(ORDER_DATE, INTERVAL 1 MONTH), '%Y%m%d') ORDER_DATE_TO, GOODS_PRICE, PAY_PRICE, ";
			query		+= "	COUPON_PRICE, DEVL_PRICE, PAY_TYPE, PG_CARDNUM, PG_FINANCENAME, PG_ACCOUNTNUM, ORDER_STATE";
			query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
			try {
			rs			= stmt.executeQuery(query);
			} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
			}

			if (rs.next()) {
				orderState		= rs.getString("ORDER_STATE");
				payPrice		= rs.getInt("PAY_PRICE");
				devlPrice		= rs.getInt("DEVL_PRICE");
				payType			= rs.getString("PAY_TYPE");
				pgCardNum		= ut.isnull(rs.getString("PG_CARDNUM"));
				pgFinanceName	= ut.isnull(rs.getString("PG_FINANCENAME"));
				pgAccountNum	= ut.isnull(rs.getString("PG_ACCOUNTNUM"));
				orderDateFrom	= rs.getString("ORDER_DATE_FROM");
				orderDateTo		= rs.getString("ORDER_DATE_TO");
				if (payType.equals("30")) {
					pgNum = pgAccountNum;
					pgTxt = "은행이체";
				}else if (payType.equals("10")) {
					pgNum = pgCardNum;
					pgTxt = "카드결제";
				}
			}
			rs.close();
			%>
						<div class="orderBox info">
							<table>
								<tbody>
									<tr>
										<th>주문번호</th>
										<td><%=orderNum%></td>
									</tr>
									<tr>
										<th>주문일자</th>
										<td><%=orderDate%></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="orderCancelBtns">
							
						</div>

						<h2>주문상품정보</h2>
			<%
			query		= "SELECT COUNT(*)";
			query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
			query		+= " WHERE OG.GROUP_ID = G.ID";
			query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
			query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND OG.DEVL_TYPE = '0001'";
			rs			= stmt.executeQuery(query);
			if (rs.next()) {
				tcnt = rs.getInt(1); //총 레코드 수
			}
			rs.close();

			query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, G.GROUP_IMGM,  O.COUPON_PRICE, OG.ID, G.GROUP_CODE";
			query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
			query		+= " WHERE OG.GROUP_ID = G.ID";
			query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
			query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND OG.DEVL_TYPE = '0001'";
			query		+= " ORDER BY OG.ID ASC";
			pstmt		= conn.prepareStatement(query);
			rs			= pstmt.executeQuery();

			if (tcnt > 0) {
			%>
						<div class="orderBox">
							<h1 class="tit">일배상품</h1>
							<ul class="cartList">
			<%
				while (rs.next()) {
					groupCode	= rs.getString("GROUP_CODE");
					goodsId		= rs.getInt("ID");
					orderCnt	= rs.getInt("ORDER_CNT");
					gubun1		= rs.getString("GUBUN1");
					groupName	= rs.getString("GROUP_NAME");
					couponPrice	+= rs.getInt("COUPON_PRICE");
					devlDate	= rs.getString("WDATE");
					buyBagYn	= rs.getString("BUY_BAG_YN");
					devlDay		= rs.getString("DEVL_DAY");
					devlWeek	= rs.getString("DEVL_WEEK");
					devlPeriod	= devlWeek +"주("+ devlDay +"일)";
					price		= rs.getInt("PRICE");
					goodsPrice	= price * orderCnt;
					/*
					if (buyBagYn.equals("Y")) {
						goodsPrice -= defaultBagPrice;
					}
					*/
					dayPrice += goodsPrice;
					cartImg		= ut.isnull(rs.getString("CART_IMG") );
					groupImg	= ut.isnull(rs.getString("GROUP_IMGM") );
					if (groupImg.equals("") || groupImg == null) {
						imgUrl		= "/images/order_sample.jpg";
					} else {
						imgUrl		= webUploadDir +"goods/"+ groupImg;
					}
					
					devlType1Count++; //-- 일일배송상품 카운팅
					if("0301369".equals(groupCode) ) devlType10301369Count++; //-- 헬씨퀴진 카운팅
					
			%>
								<li>
									<div class="inner">
										<div class="cartTop">
											<p class="cate"><%=ut.getGubun1Name(gubun1)%></p>
											<p class="name"><%=groupName%></p>
										</div>
										<div class="cartBody">
											<div class="photo"><img src="<%=imgUrl%>"></div>
											<div class="info">
												<p>식사기간 : <span><%=devlPeriod%></span></p>
												<p>첫 배송일 : <span><%=devlDate%></span></p>
												<p>수량 : <span><%=orderCnt%></span></p>
											</div>
			<%
			if(Integer.parseInt(orderState) < 2 && Integer.parseInt(orderState) > 0){
			%>
											<div class="opt">
												<a href="javascript:void(0);" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_calendar.jsp?ordno=<%=orderNum%>&goodsId=<%=goodsId%>&groupCode=<%=groupCode%>'});">주문조회변경</a>
												<a href="javascript:void(0);" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_shipping.jsp?ordno=<%=orderNum%>&goodsId=<%=goodsId%>&groupCode=<%=groupCode %>&devlType=0001'});">배송지 확인</a>
											</div>
			<%
			}
			%>
										</div>
										<div class="cartbottom">
											<div class="price"><%=nf.format(goodsPrice)%>원</div>
										</div>
									</div>
			<%
				if (buyBagYn.equals("Y")) {
					bagPrice += defaultBagPrice;
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
				}
				rs.close();
			%>
							</ul>
							<div class="cartTotal">
								총 주문 금액 <span><%=nf.format(dayPrice)%></span> 원
							</div>

						</div>
			<%
			}
			query		= "SELECT COUNT(*)";
			query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
			query		+= " WHERE OG.GROUP_ID = G.ID";
			query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
			query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND OG.DEVL_TYPE = '0002'";
			rs			= stmt.executeQuery(query);
			if (rs.next()) {
				tcnt = rs.getInt(1); //총 레코드 수
			}
			rs.close();

			query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, G.GROUP_IMGM, O.COUPON_PRICE";
			query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
			query		+= " WHERE OG.GROUP_ID = G.ID";
			query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
			query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND OG.DEVL_TYPE = '0002'";
			query		+= " ORDER BY OG.ID ASC";
			pstmt		= conn.prepareStatement(query);
			rs			= pstmt.executeQuery();

			if (tcnt > 0) {
			%>

						<div class="orderBox">
							<h1 class="tit">택배상품</h1>
							<ul class="cartList">
			<%
				while (rs.next()) {
					orderCnt	= rs.getInt("ORDER_CNT");
					gubun1		= rs.getString("GUBUN1");
					groupName	= rs.getString("GROUP_NAME");
					couponPrice	+= rs.getInt("COUPON_PRICE");
					devlDate	= "-";
					buyBagYn	= "N";
					devlPeriod	= "-";
					price		= rs.getInt("PRICE");
					goodsPrice	= price;// * orderCnt;
					tagPrice	+= goodsPrice;
					cartImg		= ut.isnull(rs.getString("CART_IMG") );
					groupImg	= ut.isnull(rs.getString("GROUP_IMGM") );
					if (groupImg.equals("") || groupImg == null) {
						imgUrl		= "/images/order_sample.jpg";
					} else {
						imgUrl		= webUploadDir +"goods/"+ groupImg;
					}
			%>
								<li>
									<div class="inner">
										<div class="cartTop">
											<p class="cate"><%=ut.getGubun1Name(gubun1)%></p>
											<p class="name"><%=groupName%></p>
										</div>
										<div class="cartBody">
											<div class="photo"><img src="<%=imgUrl%>"></div>
											<div class="info">
												<p>수량 : <span><%=orderCnt%></span></p>
											</div>
			<%
			if(Integer.parseInt(orderState) < 2 && Integer.parseInt(orderState) > 0){
			%>
											<div class="opt">
												<a href="javascript:void(0);" onclick="window.open('http://www.doortodoor.co.kr/tracking/jsp/cmn/Tracking_new.jsp?QueryType=1&pOrderNo=<%=orderNum%>1&pFromDate=<%=orderDateFrom%>&pToDate=<%=orderDateTo%>&pCustId=0010049837','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=800,height=600')">배송조회</a>
												<a href="javascript:void(0);" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_shipping.jsp?ordno=<%=orderNum%>&devlType=0002'});">배송지 확인</a>
											</div>
			<%
			}
			%>
										</div>
										<div class="cartbottom">
											<div class="price"><%=nf.format(goodsPrice)%>원</div>
										</div>
									</div>
								</li>
			<%
				}
				rs.close();
			%>
							</ul>
							<div class="cartTotal">
								총 주문 금액 <span><%=nf.format(tagPrice)%></span> 원
							</div>
						</div>
			<%
			}
			totalPrice = dayPrice + tagPrice + bagPrice - couponPrice;
			%>

						<h2>총결제금액 합계</h2>
						<div class="orderBox totalPriceArea">
							<div class="totalPriceTable">
								<table>
									<colgroup>
										<col>
										<col>
									</colgroup>
									<tbody>
										<tr>
											<th>총 상품금액</th>
											<td><span><%=nf.format(dayPrice + tagPrice)%></span> 원</td>
										</tr>
										<tr>
											<th>보냉가방</th>
											<td>(+) <span><%=nf.format(bagPrice)%></span> 원</td>
										</tr>
										<tr>
											<th>할인혜택</th>
											<td>(-) <span><%=nf.format(couponPrice)%></span> 원</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="totalPrice">
								총 주문금액 <span><%=nf.format(totalPrice)%></span> 원
							</div>
						</div>
						<h2>결제정보</h2>
						<div class="orderBox payInfo">
							<div class="boxTable">
								<table>
									<tbody>
										<tr>
											<th>결제방법</th>
											<td class="right"><%=ut.getPayType(payType)%> <%=pgFinanceName%> (<%=pgNum%>)</td>
										</tr>
										<tr>
											<th>결제금액</th>
											<td class="right"><span><%=nf.format(payPrice)%>원</span> (<%=pgTxt%> 금액입니다)</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
			</section>
			<section id="load_content" class="contents">

			</section>
		</div>
	</div>

	<!-- End Content -->
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
<%
//-- 취소버튼 처리
if(devlType1Count > 0){
	//-- 일배 취소가능일
	cancelDay = 3;
	if(devlType1Count == devlType10301369Count && 150000 >= Integer.parseInt(ut.getTimeStamp(10))){ //-- 헬씨퀴진은 15시 전까지는 2일 넘으면 3일을 적용한다.
		cancelDay = 2;
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


if (Integer.parseInt(orderState) < 2 && diffDays > cancelDay) {
%>
<script type="text/javascript">
	function orderCancel() {
		var msg = "정말로 주문을 취소하시겠습니까?"
		if(confirm(msg)){
			location.href="orderCancel.jsp?ono=<%=orderNum%>"
		}else{
			return;
		}
	}
	$(function(){
		$(".orderCancelBtns").html('<button type="button" onclick="orderCancel();">전체주문취소</button>');
	});
</script>
<%	
}
%>

</body>
</html>