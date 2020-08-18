<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
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

where			= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND ORDER_STATE > 90";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

if (stdate != null && stdate.length() > 0 && ltdate != null && ltdate.length() > 0) {
	param		+= "&amp;stdate="+ stdate +"&amp;ltdate="+ ltdate;
	where		+= " AND DATE_FORMAT(ORDER_DATE, '%Y.%m.%d') BETWEEN '"+ stdate +"' AND '"+ ltdate +"'";
}

if (stateType != null && stateType.length() > 0) {
	param		+= "&amp;state_type="+ stateType +"&amp;ltdate="+ ltdate;
	where		+= " AND ORDER_STATE = '"+ stateType +"'";
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
///////////////////////////
%>

	<script type="text/javascript" src="/common/js/date.js"></script>
	<script type="text/javascript" src="/common/js/jquery.datePicker.js"></script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> 주문배송 조회 </h1>
			<div class="pageDepth">
				HOME > My Eatsslim > <strong>주문/배송</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last  col">
					<ul class="tabNavi">
						<li> <a href="index.jsp">홈</a> </li>
						<li class="active"> <a href="orderList.jsp">주문/배송</a> </li>
						<li> <a href="couponList.jsp">쿠폰내역</a> </li>
						<li> <a href="myqna.jsp">1:1 문의내역</a> </li>
						<div class="button small iconBtn light">
							<a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span class="gear"></span> 회원정보수정</a>
						</div>
					</ul>
					<div class="clear">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<ul class="listSort">
						<li> <a href="/shop/mypage/orderList.jsp">주문/배송조회</a> </li>
						<li> <span class="current"> 취소/교환/반품조회 </span> </li>
						<li> <a href="/shop/mypage/delichange.jsp">배송일자변경</a> </li>
					</ul>
					<div class="clear">
					</div>
				</div>
			</div>
			<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
				<div class="row">
					<div class="one last col">
						<div class="graytitbox orderSearch">
							<div class="floatleft">
								<h5> 기간별조회 </h5>
								<input type="radio" id="radio1" name="radios" value="all" checked="checked" onclick="setDate(1)">
								<label for="radio1">1개월</label>
								<input type="radio" id="radio2" name="radios" value="false" onclick="setDate(3)">
								<label for="radio2">3개월</label>
								<input type="radio" id="radio3" name="radios" value="true" onclick="setDate(6)">
								<label for="radio3">6개월</label>
								<input name="stdate" id="stdate" class="date-pick" value="<%=stdate%>" />
								-
								<input name="ltdate" id="ltdate" class="date-pick" value="<%=ltdate%>" />
								<span class="button dark small"><a href="javascript:;" onclick="document.frm_search.submit();">검색</a></span>
							</div>
							<div class="floatright">
								<h5>상태</h5>
								<select name="state_type" id="state_type" style="width:90px;" onchange="document.frm_search.submit();">
									<option value="">전체</option>
									<option value="91"<%if (stateType.equals("91")) out.println(" selected=\"selected\"");%>>취소완료</option>
									<option value="92"<%if (stateType.equals("1")) out.println(" selected=\"selected\"");%>>교환요청</option>
									<option value="921"<%if (stateType.equals("2")) out.println(" selected=\"selected\"");%>>교환처리중</option>
									<option value="922"<%if (stateType.equals("3")) out.println(" selected=\"selected\"");%>>교환완료</option>
									<option value="923"<%if (stateType.equals("4")) out.println(" selected=\"selected\"");%>>교환불가</option>
									<option value="93"<%if (stateType.equals("5")) out.println(" selected=\"selected\"");%>>반품요청</option>
									<option value="931"<%if (stateType.equals("5")) out.println(" selected=\"selected\"");%>>반품처리중</option>
									<option value="932"<%if (stateType.equals("5")) out.println(" selected=\"selected\"");%>>반품완료</option>
									<option value="933"<%if (stateType.equals("5")) out.println(" selected=\"selected\"");%>>반품불가</option>
								</select>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
			</form>
			<div class="row">
				<div class="one last col">
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>주문일자/주문번호</th>
							<th class="none">배송구분</th>
							<th>상품명</th>
							<th class="none">수량</th>
							<th>결제수단</th>
							<th>결제금액</th>
							<th>처리상태</th>
							<th class="last">취소/교환/반품</th>
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
								query1		+= "		DEVL_DAY, DEVL_WEEK, DEVL_PRICE";
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

								String devlDiv		= "";
								String goodsDiv		= "";
								String cntDiv		= "";
								String priceDiv		= "";
								String devlDay		= "";
								String devlWeek		= "";
								int price			= 0;
								while (rs1.next()) {
									devlDiv			+= "<div class=\"shipping font-blue\">"+ ut.getDevlType(rs1.getString("DEVL_TYPE")) +"</div>";
									goodsDiv		+= ut.getGubun1Name(rs1.getString("GUBUN1")) +"<p class=\"option\">("+ ut.getGubun2Name(rs1.getString("GUBUN2")) +": "+ rs1.getString("GROUP_NAME") + ")</p>";
									cntDiv			+= "<div>"+ rs1.getInt("ORDER_CNT") +"</div>";
									devlDay			= rs1.getString("DEVL_DAY");
									devlWeek		= rs1.getString("DEVL_WEEK");
									price			= (rs1.getString("DEVL_TYPE").equals("0001"))? rs1.getInt("PRICE") : rs1.getInt("PRICE") + rs1.getInt("DEVL_PRICE");
									priceDiv		+= "<div>"+ nf.format(price) +"원</div>";
									if (rs1.getString("BUY_BAG_YN").equals("Y")) {
										devlDiv			+= "<div class=\"shipping font-blue\">일배</div>";
										goodsDiv		+= "보냉가방<p class=\"option\"></p>";
										cntDiv			+= "<div>1</div>";
										priceDiv		+= "<div>"+ nf.format(defaultBagPrice) +"원</div>";
									}
								}
						%>
						<tr>
							<td>
								<%=orderDate%><br />
								<span class="orderNum"><%=orderNum%></span>
							</td>
							<td><%=devlDiv%></td>
							<td>
								<div class="orderName">
									<a href="javascript:;"><%=goodsDiv%></a>
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
							<td>
								<div class="button light small">
									<a class="lightbox" href="/shop/popup/cancelResult.jsp?lightbox[width]=700&lightbox[height]=550&ono=<%=orderNum%>">자세히보기</a>
								</div>
							</td>
						</tr>
						<%
							}
						} else {
						%>
						<tr>
							<td colspan="8">취소/교환/반품내역이 없습니다.</td>
						</tr>
						<%
						}
						%>
						<!--
						<tr>
							<td>2013.08.01<a class="orderNum" href="#">A2013080138441</a></td>
							<td><div class="shipping font-blue">
									일배
								</div></td>
							<td><div class="orderName">
									<a href="#">다이어트식사 3식
									<p class="option"> (퀴진A+퀴진B) </p>
									</a>
								</div></td>
							<td><div>
									1
								</div></td>
							<td>실시간 계좌이체</td>
							<td><div>
									104,400원
								</div></td>
							<td><div class="font-maple">
									교환요청
								</div></td>
							<td><div class="button light small">
									<a href="#">교환철회</a>
								</div></td>
						</tr>
						<tr>
							<td>2013.08.01<a class="orderNum" href="#">A2013080138441</a></td>
							<td><div class="shipping font-blue">
									일배
								</div></td>
							<td><div class="orderName">
									<a href="#">Full-Step프로그램
									<p class="option"> 4주 </p>
									</a><a href="#">보냉가방</a>
								</div></td>
							<td><div>
									1
								</div>
								<div>
									-
								</div></td>
							<td>가상계좌</td>
							<td><div>
									94,400원
								</div>
								<div>
									<%=nf.format(defaultBagPrice)%>원
								</div></td>
							<td><div class="font-maple">
									반품요청(1개)
								</div></td>
							<td><div class="button light small">
									<a href="#">반품철회</a>
								</div></td>
						</tr>
						<tr>
							<td>2013.08.01<a class="orderNum" href="#">A2013080138441</a></td>
							<td><div class="shipping font-green">
									택배
								</div></td>
							<td><div class="orderName">
									<a href="#"> 뷰티워터티(BOX) </a>
								</div></td>
							<td><div>
									1
								</div></td>
							<td>신용카드</td>
							<td><div>
									84,400원
								</div></td>
							<td><div class="font-maple">
									반품완료
								</div></td>
							<td><div class="button light small">
									<a href="#">자세히보기</a>
								</div></td>
						</tr>
						<tr>
							<td colspan="8">주문내역이 없습니다.</td>
						</tr>
						-->
					</table>
					<!-- End orderList -->
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last  col">
					<%@ include file="/common/include/inc-paging.jsp"%>
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
<script type="text/javascript">  
$(document).ready(function() {
	Date.format	= 'yyyy.mm.dd';
	$('.date-pick').datePicker({
		startDate: '2013.09.01',
		clickInput:true
	});
});

function setDate(val) {
	var settingDate = new Date();

	$("#ltdate").val(settingDate.asString()); //오늘날짜

	settingDate.setMonth(settingDate.getMonth()-val); // ?개월 전
	$("#stdate").val(settingDate.asString());

}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>