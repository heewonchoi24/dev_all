<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
String period		= ut.inject(request.getParameter("period"));
if (period.equals("") || period == null) {
	period				= "";
}
String where		= "";
String param		= "";
String orderNum		= "";
String orderDate	= "";
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
/*
if (stdate != null && stdate.length() > 0 && ltdate != null && ltdate.length() > 0) {
	param		+= "&amp;stdate="+ stdate +"&amp;ltdate="+ ltdate;
	where		+= " AND DATE_FORMAT(ORDER_DATE, '%Y.%m.%d') BETWEEN '"+ stdate +"' AND '"+ ltdate +"'";
}
*/
if("1".equals(period) || "2".equals(period) || "3".equals(period)){
	where		+= " AND DATE_FORMAT(ORDER_DATE, '%Y/%m/%d') BETWEEN DATE_FORMAT(DATE_ADD(SYSDATE(), INTERVAL -" + period + " MONTH),'%Y/%m/%d') AND DATE_FORMAT(SYSDATE(), '%Y/%m/%d')";
}
else{
	where		+= " AND DATE_FORMAT(ORDER_DATE, '%Y/%m/%d') BETWEEN DATE_FORMAT(DATE_ADD(SYSDATE(), INTERVAL -1 MONTH),'%Y/%m/%d') AND DATE_FORMAT(SYSDATE(), '%Y/%m/%d')";
}

if (period != null && period.length() > 0) {
	param		+= "&amp;period="+ period;
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
	<script type="text/javascript" src="/common/js/common.js"></script>
</head>
<body>

<div id="wrap">

	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->

	<!-- Start Content -->
	<div id="content" class="oldClass">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">주문배송조회</span></span></h1>

		<div id="myOrder">
			<ul class="guide">
				<!-- <li">* 자세한 주문 조회 및 변경, 배송지 변경은 PC 또는 고객기쁨센터(080-800-0434) 진행 가능합니다.<br />또는 잇슬림 옐로우 아이디를 통해 편리하게 이용 가능합니다. 카카오톡에서 '풀무원 잇슬림'을 친구 추가해주세요. <br />
				<span class="font-orange"><a href="http://plus.kakao.com/home/oamlw65x">[친구 추가 바로가기 클릭]</a></span></li> -->
	            <li>최근 3개월 이후 주문내역은 웹에서 조회하실 수 있습니다.</li>
				<li>기타 관련문의는 고객센터(080-800-0434)로 연락바랍니다.</li>
			</ul>
			<div class="selectBox">
				<form name="frm_search" method="get" action="delichange.jsp">
					<input type="hidden" name="stdate" id="stdate" class="date-pick" value="<%=stdate%>" />
					<input type="hidden" name="ltdate" id="ltdate" class="date-pick" value="<%=ltdate%>" />
					<!--select name="period" id="period" class="inp_st" onchange="setDate(this.value)">
                       	<option value="1"<%if (period.equals("1")) out.println(" selected=\"selected\"");%>>1개월</option>
						<option value="2"<%if (period.equals("2")) out.println(" selected=\"selected\"");%>>2개월</option>
						<option value="3"<%if (period.equals("3")) out.println(" selected=\"selected\"");%>>3개월</option>
                   	</select-->
				</form>
			</div>

			<ul class="tab-navi">
				<li>
					<a href="orderList.jsp">주문/배송 조회</a>
				</li>
				<li class="active">
					<a href="delichange.jsp">취소내역 조회</a>
				</li>
			</ul>

			<ul class="orderList">
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
%>
				<li>
					<a href="orderDetail.jsp?ono=<%=orderNum + param%>&odate=<%=orderDate%>" class="orderHead">
						<p class="date"><%=orderDate%></p>
						<p class="orderNum">주문번호 <%=orderNum%></p>
					</a>
					<div class="orderBody">
						<ul class="orderItem">
<%while (rs1.next()) {%>
							<li>
								<p class="cate"><span>[<%=ut.getDevlType(rs1.getString("DEVL_TYPE"))%>]</span> <%=ut.getGubun1Name(rs1.getString("GUBUN1")) %></p>
								<p class="itemNmae"><%=ut.getGubun2Name(rs1.getString("GUBUN2"))%> : <%=rs1.getString("GROUP_NAME")%> x <%=rs1.getString("ORDER_CNT")%></p>
							</li>
<%}rs1.close();%>
						</ul>
					</div>
					<div class="orderFoot">
						<p class="price"><%=nf.format(payPrice)%>원</p>
						<p class="state"><%=ut.getOrderState(orderState)%></p>
					</div>
				</li>
<%
	}
} else {
%>
				<li class="none">
					취소/교환/반품내역이 없습니다.
				</li>
<%
}
%>
			</ul>


		</div>
	</div>
	<!-- End Content -->

	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
<script type="text/javascript">
function setDate(val) {
	var settingDate = new Date();

	$("#ltdate").val(settingDate.asString()); //오늘날짜

	settingDate.setMonth(settingDate.getMonth()-val); // ?개월 전
	$("#stdate").val(settingDate.asString());

	document.frm_search.submit();
}
</script>
</body>
</html>