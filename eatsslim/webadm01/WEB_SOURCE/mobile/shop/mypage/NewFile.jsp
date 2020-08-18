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
/* cal.add ( Calendar.MONTH, -1 ); */ //1개월전
cal.add ( Calendar.MONTH, -10 ); //10개월전
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
	<div id="header">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="container_inner">
			<section id="index_content" class="contents">
				<header class="cont_header">
					<h2>마이 잇슬림</h2>
				</header>
				<div class="content">
					<div class="recent_goods">
						<dl>
							<dt><span>최근 구매한 상품</span></dt>
							<dd>
								<ul>
									<%
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
											String groupName    = "";
											int price			= 0;
											int goodsId			= 0;
											while (rs1.next()) {
												goodsId			= rs1.getInt("ID");
												
												
												if (rs1.getString("DEVL_TYPE").equals("0002")) {
													goodsDiv		+= ut.getGubun1Name(rs1.getString("GUBUN1")) +"<p class=\"option\">("+ ut.getGubun2Name(rs1.getString("GUBUN2")) + ")</p>";
													query2		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
													query2		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
													query2		+= " AND GOODS_ID = '"+ goodsId +"'";
													
													try {
														rs2			= stmt2.executeQuery(query2);
													} catch(Exception e) {
														out.println(e+"=>"+query2);
														if(true)return;
													}
													if (rs2.next()) {
														minDate			= rs2.getString("MIN_DATE");
														maxDate			= rs2.getString("MAX_DATE");
														devlDates		= ut.isnull(minDate) +"~"+ ut.isnull(maxDate);
													}
												} else {
													goodsDiv		+= ut.getGubun1Name(rs1.getString("GUBUN1")) +"<p class=\"option\">("+ ut.getGubun2Name(rs1.getString("GUBUN2")) +": "+ rs1.getString("GROUP_NAME") + ")</p>";
													query2		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
													query2		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
													query2		+= " AND GOODS_ID = '"+ goodsId +"'";
													
													try {
														rs2			= stmt2.executeQuery(query2);
													} catch(Exception e) {
														out.println(e+"=>"+query2);
														if(true)return;
													}
													if (rs2.next()) {
														minDate			= rs2.getString("MIN_DATE");
														maxDate			= rs2.getString("MAX_DATE");
														devlDates		= ut.isnull(minDate) +"~"+ ut.isnull(maxDate);
													}
													
													
													groupName = rs1.getString("GROUP_NAME");
												}
												price			= (rs1.getString("DEVL_TYPE").equals("0001"))? rs1.getInt("PRICE") : rs1.getInt("PRICE") + rs1.getInt("DEVL_PRICE");
												cartImg		= rs1.getString("CART_IMG");
												if (cartImg.equals("") || cartImg == null) {
													imgUrl		= "/mobile/images/nivo_sample01.png";
												} else {										
													imgUrl		= webUploadDir +"goods/"+ cartImg;
													System.out.println(imgUrl);
												}
											}
											
										%>
									<li>
										<div class="img"><a href="javascript:void(0);"><img src="<%=imgUrl%>" alt=""></a></div>
										<div class="desc">
											<div class="title"><a href="javascript:void(0);">[<%=goodsDiv %>]</a></div>
											<div class="d_period"><span>m i</span><Strong><%=devlDates %></Strong></div>
											<div class="d_destination">
												<%=nf.format(payPrice)%>원
											</div>
											</div>
											<div class="bx_btn">
												<button type="button" class="btn small btn_dgray" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_detail.jsp'});">주문상세</button>
												<button type="button" class="btn small btn_white" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_calendar.html'});">배송캘린더</button>
											</div>
										</div>
									</li>
									<%
									}
									%>
								</ul>
							</dd>
						</dl>
					</div>
					<div class="order_link">
						<ul>
							<li><a href="javascript:void(0);">주문전체 리스트<span></span></a></li>
							<li><a href="javascript:void(0);">쿠폰 리스트<span></span></a></li>
							<li><a href="javascript:void(0);">1:1 문의<span></span></a></li>
						</ul>
					</div>
				</div>
			</section>
			<section id="load_content" class="contents">
				
			</section>
		</div>
	</div>
	<!-- End container -->

	<div id="footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
</div>
</body>
</html>