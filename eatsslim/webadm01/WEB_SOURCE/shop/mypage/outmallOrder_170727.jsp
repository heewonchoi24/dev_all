<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String table		= "ESL_ORDER";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String query2		= "";
Statement stmt2		= null;
ResultSet rs2		= null;
stmt2				= conn.createStatement();
String where		= "";
String param		= "";
String orderNum		= "";
String orderDate	= "";
/* int payPrice		= 0; */
String payType		= "";
String orderState	= "";
String devlType		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject2(request.getParameter("keyword"));
String invNo		= "";
String devlCd		= "";
int goodsCnt		= 0;
NumberFormat nf		= NumberFormat.getNumberInstance();

///////////////////////////
int pgsize		= 10; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int iPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;

where			= " WHERE ORDER_STATE < 90 AND OUT_ORDER_NUM != ''";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	if (field.equals("RCV_HP")) {
		where		+= " AND ("+ field +" = '"+ keyword +"' OR TAG_HP = '"+ keyword +"')";
	} else {
		where		+= " AND "+ field +" = '"+ keyword +"'";
	}

	query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query); if(true)return;
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();
	if (rs.next()) {
		intTotalCnt = rs.getInt(1); //총 레코드 수		
	}
	if (rs != null) try { rs.close(); } catch (Exception e) {}
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

	totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // 총 페이지 수
	endpage		= startpage + pagelist - 1;
	if (endpage > totalPage) {
		endpage = totalPage;
	}
	curNum		= intTotalCnt-pgsize*(iPage-1);
	param		+= "&amp;pgsize=" + pgsize;

	query		= "SELECT ORDER_NUM, DATE_FORMAT(ORDER_DATE, '%Y.%m.%d') ORDER_DATE, ORDER_NAME, PAY_TYPE, PAY_PRICE,";
	query		+= "	ORDER_STATE, ORDER_ENV";
	query		+= " FROM "+ table + where;
	query		+= " ORDER BY ORDER_NUM DESC";
	query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
	try {
		rs = stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
}
///////////////////////////
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
			<h1> 타쇼핑몰 주문확인 </h1>
			<div class="pageDepth">
				HOME &gt; <strong>타쇼핑몰 주문확인</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<div class="graytitbox orderSearch center">
						<form name="frm_search" method="get" action="<%=request.getRequestURI()%>">
							<p class="marb10">다른 쇼핑몰에서 구매하신 배송정보가 궁금하시면 이곳에서 조회하실 수 있습니다.</p>
							<p class="marb10">핸드폰 번호로 조회 시 '-'를 포함하여 조회를 하셔야 정상적인 조회가 가능합니다.</p>
							<label>
								<select name="field" id="field" style="width:130px;">
									<option value="OUT_ORDER_NUM">주문번호</option>
									<option value="RCV_HP">핸드폰번호</option>
								</select>
							</label>
							<label>
								<input type="text" name="keyword" id="keyword" maxlength="50" value="<%=keyword%>" />
							</label>
							<label>
								<input type="submit" class="button dark small" name="button" value="조회">
							</label>
						</form>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>주문일자/주문번호</th>
							<th class="none">배송구분</th>
							<th>상품명</th>
							<th class="none">수량</th>
							<th>정상금액</th>
							<th>결제금액</th>
							<th>주문상태</th>
						</tr>
						<%
						if (intTotalCnt > 0) {
							while (rs.next()) {
								orderNum	= rs.getString("ORDER_NUM");
								orderDate	= (rs.getString("ORDER_DATE") == null)? "" : rs.getString("ORDER_DATE");
								payPrice	= rs.getInt("PAY_PRICE");
								orderState	= rs.getString("ORDER_STATE");
								payType		= rs.getString("PAY_TYPE");

								query1		= "SELECT ";
								query1		+= "		GROUP_NAME, GUBUN1, GUBUN2, DEVL_TYPE, ORDER_CNT, PRICE, BUY_BAG_YN,";
								query1		+= "		DEVL_DAY, DEVL_WEEK, DEVL_PRICE, DATE_FORMAT(DEVL_DATE, '%Y%m%d') DEVL_DATE";
								query1		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O";
								query1		+= " WHERE G.ID = OG.GROUP_ID";
								query1		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
								query1		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
								query1		+= " ORDER BY O.ID DESC";
								try {
									rs1 = stmt1.executeQuery(query1);
								} catch(Exception e) {
									out.println(e+"=>"+query1);
									if(true)return;
								}

								String devlDiv		= "";
								String goodsDiv		= "";
								String cntDiv		= "";
								String priceDiv		= "";
								String devlDay		= "";
								String devlWeek		= "";
								int price			= 0;
								int i				= 0;
								while (rs1.next()) {
									devlType		= rs1.getString("DEVL_TYPE");
									devlDiv			+= "<div class=\"shipping font-blue\">"+ ut.getDevlType(devlType) +"</div>";
									goodsDiv		+= ut.getGubun1Name(rs1.getString("GUBUN1")) +"<p class=\"option\">("+ ut.getGubun2Name(rs1.getString("GUBUN2")) +": "+ rs1.getString("GROUP_NAME") + ")</p>";
									cntDiv			+= "<div>"+ rs1.getInt("ORDER_CNT") +"</div>";
									devlDay			= rs1.getString("DEVL_DAY");
									devlWeek		= rs1.getString("DEVL_WEEK");
									price			= (devlType.equals("0001"))? rs1.getInt("PRICE") : rs1.getInt("PRICE") + rs1.getInt("DEVL_PRICE");
									price			= (payPrice == 0)? 0 : price;
									priceDiv		+= "<div>"+ nf.format(price) +"원</div>";
									if (rs1.getString("BUY_BAG_YN").equals("Y")) {
										defaultBagPrice	= (payPrice == 0)? 0 : 7000;
										devlDiv			+= "<div class=\"shipping font-blue\">일배</div>";
										goodsDiv		+= "보냉가방<p class=\"option\"></p>";
										cntDiv			+= "<div>"+ rs1.getInt("ORDER_CNT") +"</div>";
										priceDiv		+= "<div>"+ nf.format(defaultBagPrice) +"원</div>";
									}
								}
								rs1.close();
						%>
						<tr>
							<td>
								<%=orderDate%>
								<a class="orderNum" href="/shop/mypage/outOrderInfo.jsp?ono=<%=orderNum + param%>&odate=<%=orderDate%>"><%=orderNum%></a>
							</td>
							<td><%=devlDiv%></td>
							<td>
								<div class="orderName">
									<a href="/shop/mypage/outOrderInfo.jsp?ono=<%=orderNum + param%>&odate=<%=orderDate%>"><%=goodsDiv%></a>
								</div>
							</td>
							<td><%=cntDiv%></td>
							<td><%=priceDiv%></td>
							<td><div><%=nf.format(payPrice)%>원</div></td>
							<td>
								<div class="font-maple">
									<%=ut.getOrderState(orderState)%>
								</div>
							</td>
						</tr>
						<%
							}
						} else {
						%>
						<tr>
							<td colspan="7">주문내역이 없습니다.</td>
						</tr>
						<%
						}
						%>
					</table>
					<!-- End orderList -->
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last  col">
					<div class="pageNavi">
						<!-- <a class="latelypostslink" href="#"><<</a> <a class="previouspostslink" href="#"><</a> --> 
						<span class="current"> 1 </span> 
						<!-- <a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a class="firstpostslink" href="#">></a> <a class="nextpostslink" href="#">>></a> -->
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
<%@ include file="/lib/dbclose_phi.jsp"%>