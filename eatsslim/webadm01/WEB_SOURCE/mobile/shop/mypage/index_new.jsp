<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String table		= "ESL_ORDER";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String stdate		= ut.inject(request.getParameter("stdate"));
String ltdate		= ut.inject(request.getParameter("ltdate"));
String stateType	= ut.inject(request.getParameter("state_type"));
String where		= "";
String param		= "";
String orderNum		= "";
String orderDate	= "";
int payPrice		= 0;
String payType		= "";
String orderState	= "";
int cnt				= 0;
NumberFormat nf		= NumberFormat.getNumberInstance();
Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //오늘
String cDate=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
cal.add ( Calendar.MONTH, -10 ); //1개월전
String preMonth3=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
where			= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND ORDER_STATE > 0 AND ORDER_STATE < 90";
where			+= " AND DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') BETWEEN '"+ preMonth3 +"' AND '"+ cDate +"'";

query		= "SELECT COUNT(*)";
query		+= " FROM "+ table + where; //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	cnt		= rs.getInt(1);
}
rs.close();

query		= "SELECT ORDER_NUM, DATE_FORMAT(ORDER_DATE, '%Y.%m.%d') ORDER_DATE, ORDER_NAME, PAY_TYPE, PAY_PRICE,";
query		+= "	ORDER_STATE, ORDER_ENV";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ORDER_NUM DESC"; //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
///////////////////////////
%>

	<script type="text/javascript" src="/common/js/date.js"></script>
	<script type="text/javascript" src="/common/js/jquery.datePicker.js"></script>
	<script type="text/javascript" src="/common/js/common.js"></script>
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header --> 
	
	<!-- Start Content -->
	<div id="content">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">최근 구매한 상품</span></span></h1>
		<div class="row bg-gray">
			<!-- 구매내역 없을때 하단 영역 전체 Hidden처리 (myorder-empty 부분 노출함) -->
			<%if (cnt > 0) {%>
			<div class="myorder-wrap">
				<div class="nivobox">
					<a class="arrow-left" href="#"></a> <a class="arrow-right" href="#"></a>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<%
							int cntdd			= 0;
							while (rs.next()) {
								orderNum	= rs.getString("ORDER_NUM");
								orderDate	= (rs.getString("ORDER_DATE") == null)? "" : rs.getString("ORDER_DATE");
								payPrice	= rs.getInt("PAY_PRICE");
								orderState	= rs.getString("ORDER_STATE");
								payType		= rs.getString("PAY_TYPE");   

								query1		= "SELECT ";
								query1		+= "		OG.ID, GROUP_NAME, GUBUN1, GUBUN2, DEVL_TYPE, CART_IMG, PRICE, DEVL_PRICE";
								query1		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O";
								query1		+= " WHERE G.ID = OG.GROUP_ID";
								query1		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
								query1		+= " AND O.MEMBER_ID = '"+ eslMemberId +"' AND OG.ORDER_NUM = '"+ orderNum +"'";
								query1		+= " ORDER BY O.ID DESC";
								try {
									rs1 = stmt1.executeQuery(query1);
								} catch(Exception e) {
									out.println(e+"=>"+query1);
									if(true)return;
								}

								String goodsDiv		= "";
								String cartImg		= "";
								String imgUrl		= "";
								int price			= 0;
								int goodsId			= 0;
								
								while (rs1.next()) {
									goodsId			= rs1.getInt("ID");
									if (rs1.getString("DEVL_TYPE").equals("0002")) {
										goodsDiv		+= ut.getGubun1Name(rs1.getString("GUBUN1")) +"<p class=\"option\">("+ ut.getGubun2Name(rs1.getString("GUBUN2")) + ")</p>";
									} else {
										goodsDiv		+= ut.getGubun1Name(rs1.getString("GUBUN1")) +"<p class=\"option\">("+ ut.getGubun2Name(rs1.getString("GUBUN2")) +": "+ rs1.getString("GROUP_NAME") + ")</p>";
									}
									price			= (rs1.getString("DEVL_TYPE").equals("0001"))? rs1.getInt("PRICE") : rs1.getInt("PRICE") + rs1.getInt("DEVL_PRICE");
									cartImg		= rs1.getString("CART_IMG");
									if (cartImg.equals("") || cartImg == null) {
										imgUrl		= "/mobile/images/nivo_sample01.png";
									} else {										
										imgUrl		= webUploadDir +"goods/"+ cartImg;
									}
									cntdd += 1;
									
									System.out.println("goodsDiv : "+goodsDiv);
								}
								
							%>
							<div class="swiper-slide">
								<div class="content-slide">
									<p class="thumb-img"><img src="<%=imgUrl%>" width="85" height="78"></p>
									<p><%=goodsDiv%><!-- (외 0건) --></p>
									<p class="nivo-price"><%=nf.format(payPrice)%>원</p>
								</div>
							</div>
							<%
							}
							System.out.println("cntdd : "+cntdd);
							%>
						</div>
					</div>
					<div class="pagination">
					</div>
					<div class="clear">
					</div>
				</div>
				<div class="grid-navi">
					<table class="navi" border="0" cellspacing="10" cellpadding="0">
						<tr>
							<td><a href="/mobile/shop/cart.jsp" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">장바구니</span></span></a></td>
							<!--td><a href="/mobile/shop/dietMeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">다시구매</span></span></a></td-->
						</tr>
					</table>
				</div>
				<ul class="guide">
					<li>* 최근 1개월간 구매하신 내역입니다.</li>
				</ul>
            </div>
            <!-- End myorder-wrap -->
			<%} else {%>
            <!-- myorder-empty -->
            <div class="myorder-empty">
                <div class="emptyimg"></div>
                <p>최근 구매하신 내역이 없습니다.</p>
            </div>
			<%}%>
		</div>
		<ul class="ui-listview">
			<li class="ui-li ui-btn-up-e ui-btn-icon-right ui-li-has-arrow ui-first-child"> <a href="/mobile/shop/mypage/orderList.jsp" class="font-green"><span class="ui-btn-inner"><span class="ui-btn-text">주문배송조회</span></span></a><span class="ui-icon ui-icon-arrow-r"> </span> </li>
			<li class="ui-li ui-btn-up-e ui-btn-icon-right ui-li-has-arrow"> <a href="/mobile/shop/mypage/couponSearch.jsp" class="font-green"><span class="ui-btn-inner"><span class="ui-btn-text">쿠폰내역</span></span></a><span class="ui-icon ui-icon-arrow-r"> </span> </li>
			<li class="ui-li ui-btn-up-e ui-btn-icon-right ui-li-has-arrow ui-last-child"> <a href="/mobile/shop/mypage/myqna.jsp" class="font-green"><span class="ui-btn-inner"><span class="ui-btn-text">1:1문의내역</span></span></a><span class="ui-icon ui-icon-arrow-r"> </span> </li>
		</ul>
	</div>
	<!-- End Content -->	
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
<script src="/mobile/common/js/idangerous.swiper-2.1.min.js"></script> 
<script>
	var mySwiper = new Swiper('.swiper-container',{
		pagination: '.pagination',
		loop:true,
		grabCursor: true,
		paginationClickable: true
	})
	$('.arrow-left').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	})
	$('.arrow-right').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	})
	</script>
</body>
</html>