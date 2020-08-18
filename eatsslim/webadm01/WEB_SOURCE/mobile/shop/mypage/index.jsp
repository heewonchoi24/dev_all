<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String table		= "\n ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O \n";
String query		= "";
String query1		= "";
String query2		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
Statement stmt2		= null;
ResultSet rs2		= null;
String minDate		= "";
String maxDate		= "";
String devlDates	= "";
stmt1				= conn.createStatement();
stmt2				= conn.createStatement();
String stdate		= ut.inject(request.getParameter("stdate"));
String ltdate		= ut.inject(request.getParameter("ltdate"));
String stateType	= ut.inject(request.getParameter("state_type"));
String where		= "";
String param		= "";
String orderNum		= "";
String orderDate	= "";
/* int payPrice		= 0; */
String payType		= "";
String orderState	= "";
int cnt				= 0;
String goodsList	= "";
int listSize		= 0;
String gId			= "";
String groupCode	= "";
String devlType	= "";
ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
String promotion    = "";

NumberFormat nf		= NumberFormat.getNumberInstance();

where			= "  WHERE G.ID = OG.GROUP_ID\n";
where			+= " AND OG.ORDER_NUM = O.ORDER_NUM\n";
where			+= " AND O.ORDER_STATE > 0\n";
where			+= " AND O.ORDER_STATE < 90\n";
where			+= " AND O.ORDER_NUM NOT IN (SELECT ORDER_NUM FROM ESL_ORDER WHERE ORDER_STATE = '00' AND PAY_TYPE = '10')\n";
where			+= " AND TIMESTAMPDIFF(MONTH,O.ORDER_DATE,SYSDATE()) < 11\n"; //-- 10개월 까지
//where			+= " AND OG.DEVL_TYPE = '0001'\n";//-- 일일배송만
where			+= " AND (OG.DEVL_TYPE = '0002' OR O.ORDER_NUM IN (SELECT ORDER_NUM FROM (SELECT ORDER_NUM,MAX(DEVL_DATE) AS DEVL_DATE FROM ESL_ORDER_DEVL_DATE WHERE CUSTOMER_NUM='"+eslCustomerNum+"' GROUP BY ORDER_NUM)A WHERE DEVL_DATE >= NOW()))"; //-- CUSTOMER_NUM INDEX 추가해야 함
where			+= " AND O.MEMBER_ID = '"+ eslMemberId +"'\n";

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

query		= "SELECT \n";
query		+= " O.ORDER_NUM, DATE_FORMAT(O.ORDER_DATE, '%Y.%m.%d') ORDER_DATE, O.ORDER_NAME, O.PAY_TYPE, O.PAY_PRICE,\n";
query		+= " O.ORDER_STATE, O.ORDER_ENV,\n";
query		+= " GROUP_NAME, GUBUN1, GUBUN2, DEVL_TYPE, ORDER_CNT, PRICE, BUY_BAG_YN,\n";
query		+= " DEVL_DAY, DEVL_WEEK, DEVL_PRICE, DATE_FORMAT(DEVL_DATE, '%Y%m%d') DEVL_DATE, OG.ID, G.GROUP_CODE,G.ID AS GROUP_ID,\n";
query		+= " RCV_ADDR1, RCV_ADDR2, DEVL_DAY, DEVL_TYPE, CART_IMG, GROUP_IMGM, PRICE, DEVL_PRICE, EXP_PROMOTION\n";
query		+= " FROM "+ table + where;
query		+= " ORDER BY O.ORDER_NUM DESC, OG.DEVL_DATE"; //out.print(query); if(true)return;
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
<div id="wrap" class="expansioncss">
	<%@ include file="/mobile/common/include/inc-header.jsp"%>
	<!-- End header -->
	<div id="container">
		<div class="container_inner">
			<section id="index_content" class="contents">
				<header class="cont_header">
					<h2>마이페이지</h2>
				</header>
				<div class="content">
					<div class="recent_goods">
					<%if (cnt > 0) {%>
						<dl>
							<dt><img src="/mobile/common/images/ico/ico_order_recent.png" alt="" /><span>최근 구매한 상품</span></dt>
							<dd>
								<ul>
									<%
									int cnt2 = 0;
									while (rs.next()) {
										String groupId		= "";
										String goodsDiv		= "";
										String cartImg		= "";
										String groupImg		= "";
										String imgUrl		= "";
										String groupName    = "";
										int price			= 0;
										int goodsId			= 0;
										String rcvAddr1		= "";
										String rcvAddr2		= "";
										String devlDay 		= "";
										minDate				= "";
										maxDate				= "";
										devlDates			= "";

										orderNum	= rs.getString("ORDER_NUM");
										orderDate	= (rs.getString("ORDER_DATE") == null)? "" : rs.getString("ORDER_DATE");
										payPrice	= rs.getInt("PAY_PRICE");
										orderState	= rs.getString("ORDER_STATE");
										payType		= rs.getString("PAY_TYPE");
										groupName	= rs.getString("GROUP_NAME");
										devlType	= rs.getString("DEVL_TYPE");


										groupId		= rs.getString("GROUP_ID");
										goodsId		= rs.getInt("ID");
										devlDay		= rs.getString("DEVL_DAY");
										groupCode	= rs.getString("GROUP_CODE");
										rcvAddr1	= rs.getString("RCV_ADDR1");
										rcvAddr2	= rs.getString("RCV_ADDR2");
										promotion	= ut.inject(rs.getString("EXP_PROMOTION"));

										/* goodsDiv		+= ut.getGubun1Name(rs.getString("GUBUN1")) +"<p class=\"option\">("+ ut.getGubun2Name(rs.getString("GUBUN2")) +": "+ rs.getString("GROUP_NAME") + ")</p>"; */
										/*
										goodsDiv		= ut.getGubun1Name(rs.getString("GUBUN1"));
										goodsDiv		+= "(";
										if(!"&nbsp;".equals(ut.getGubun2Name(rs.getString("GUBUN2")))) goodsDiv		+= ut.getGubun2Name(rs.getString("GUBUN2")) +": ";
										goodsDiv		+= rs.getString("GROUP_NAME") + ")";
										*/
										goodsDiv		= "";
										//if(!"&nbsp;".equals(ut.getGubun2Name(rs.getString("GUBUN2")))) goodsDiv		+= ut.getGubun2Name(rs.getString("GUBUN2")) +": ";
										goodsDiv		+= rs.getString("GROUP_NAME");

										if (rs.getString("DEVL_TYPE").equals("0001")) {
											query2		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
											query2		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
											query2		+= " AND GOODS_ID = '"+ goodsId +"'";
											query2		+= " AND GROUP_CODE <> '0300668'"; //-- 장바구니는 노출하지 않는다.

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
										}

										price			= (rs.getString("DEVL_TYPE").equals("0001"))? rs.getInt("PRICE") : rs.getInt("PRICE") + rs.getInt("DEVL_PRICE");
										groupImg		= rs.getString("GROUP_IMGM");
										if (groupImg.equals("") || groupImg == null) {
											imgUrl		= "/mobile/images/nivo_sample01.png";
										} else {
											imgUrl		= webUploadDir +"goods/"+ groupImg;
										}

									%>
									<li>
										<div class="img"><a href="../order_view.jsp?cateCode=0&cartId=<%=groupId%>"><img src="<%=imgUrl%>" alt=""></a></div>
										<div class="desc">
											<div class="title"><a href="../order_view.jsp?cateCode=0&cartId=<%=groupId%>">[<%=goodsDiv %>]</a></div>
											<div class="d_period">
											<%
												if(devlDay.equals("5")){
													%>
													<span>월~금</span>
													<%
												}
												if(devlDay.equals("3")){
													%>
													<span>월/수/금</span>
													<%
												}
											%>
												<Strong><%=devlDates %></Strong>
											</div>
											<div class="d_destination">
												<%=rcvAddr1 %> <%=rcvAddr2 %>
											</div>
											<div class="bx_btn">
												<button type="button" class="btn small btn_dgray" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_detail.jsp?ordno=<%=orderNum%>&devlDates=<%=devlDates %>&devlDay=<%=devlDay %>&devlType=<%=devlType %>'});">주문상세</button>
												<% if(!promotion.equals("01") && devlType.equals("0001")){ %>
												<button type="button" class="btn small btn_white" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_calendar.jsp?ordno=<%=orderNum %>&goodsId=<%=goodsId%>&groupCode=<%=groupCode %>'});">배송캘린더</button>
												<% } %>
											</div>
										</div>
									</li>
									<%
									}
									%>
								</ul>
							</dd>
						</dl>
						<%} else {%>
			            <!-- myorder-empty -->
			            <div class="myorder-empty">
			                <div class="emptyimg"></div>
			                <p>최근 구매하신 내역이 없습니다.</p>
			            </div>
						<%}%>
					</div>
					<div class="order_link">
						<ul>
							<li><a href="/mobile/shop/mypage/orderList.jsp">주문내역조회<span></span></a></li>
							<li><a href="/mobile/shop/mypage/couponSearch.jsp">쿠폰 리스트<span></span></a></li>
							<li><a href="/mobile/shop/mypage/myqna.jsp">1:1 문의<span></span></a></li>
							
							<% if("U".equals(eslMemberCode))	//통합회원 구분
							{ 
							%>
								<li><a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span></span> 회원정보수정</a></li>
							<% 
							} 
							else 
							{ 
							%>
								<li><a href="/mobile/shop/mypage/member_edit.jsp">회원정보수정<span></span></a></li>
								<li><a href="/mobile/shop/mypage/member_leave.jsp">회원탈퇴<span></span></a></li>
							<% 
							} 
							%>
						</ul>
					</div>
				</div>
			</section>
			<section id="load_content" class="contents">

			</section>
		</div>
	</div>
	<!-- End container -->

		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	<!-- End footer -->
</div>
</body>
</html>
