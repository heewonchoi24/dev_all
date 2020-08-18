<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
String table			= "ESL_ORDER O, ESL_ORDER_CANCEL OC";
String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
String schOrderName		= ut.inject(request.getParameter("sch_order_name"));
String schOrderNum		= ut.inject(request.getParameter("sch_order_num"));
String schName			= ut.inject(request.getParameter("sch_name"));
String stdate			= ut.inject(request.getParameter("stdate"));
String ltdate			= ut.inject(request.getParameter("ltdate"));
String addr1			= ut.inject(request.getParameter("addr1"));
String schShopType		= ut.inject(request.getParameter("sch_shop_type"));
String hp				= ut.inject(request.getParameter("hp"));
String tel				= ut.inject(request.getParameter("tel"));
String orderStdate		= ut.inject(request.getParameter("order_stdate"));
String orderLtdate		= ut.inject(request.getParameter("order_ltdate"));
String payStdate		= ut.inject(request.getParameter("pay_stdate"));
String payLtdate		= ut.inject(request.getParameter("pay_ltdate"));
String schOrderState	= "";
String schOrderEnv		= "";
String schPayType		= ut.inject(request.getParameter("sch_pay_type"));
if (schPayType.equals("") || schPayType == null) schPayType = "10";
String field			= ut.inject(request.getParameter("field"));
String keyword			= ut.inject(request.getParameter("keyword"));
String where			= "";
String param			= "";
String orderNum			= "";
String orderDate		= "";
String refundDate			= "";
String productName		= "";
String orderName		= "";
String payType			= "";
String payTypeTxt		= "";
int refundPrice			= 0;
String orderState		= "";
String orderEnv			= "";
String shopType			= "";
String memberId			= "";
String pgFinancename	= "";
NumberFormat nf			= NumberFormat.getNumberInstance();

///////////////////////////
int pgsize		= 100; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int iPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;

where			= " WHERE O.ORDER_NUM = OC.ORDER_NUM AND OC.ORDER_STATE IN (96, 97, 971)";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage			= Integer.parseInt(request.getParameter("page"));
	startpage		= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage			= 1;
	startpage		= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize			= Integer.parseInt(request.getParameter("pgsize"));

if (schOrderName != null && schOrderName.length() > 0) {
	schOrderName	= new String(schOrderName.getBytes("8859_1"), "EUC-KR");
	param			+= "&amp;sch_order_name="+ schOrderName;
	where			+= " AND ORDER_NAME LIKE '%"+ schOrderName +"%'";
}

if (schOrderNum != null && schOrderNum.length() > 0) {
	param			+= "&amp;sch_order_num="+ schOrderNum;
	where			+= " AND ORDER_NUM LIKE '%"+ schOrderNum +"%'";
}

if (schName != null && schName.length() > 0) {
	schName			= new String(schName.getBytes("8859_1"), "EUC-KR");
	param			+= "&amp;sch_name="+ schName;
	where			+= " AND (RCV_NAME LIKE '%"+ schName +"%' OR TAG_NAME LIKE '%"+ schName +"%')";
}

if (addr1 != null && addr1.length() > 0) {
	addr1			= new String(addr1.getBytes("8859_1"), "EUC-KR");
	param			+= "&amp;addr1="+ addr1;
	where			+= " AND (RCV_ADDR1 LIKE '%"+ addr1 +"%' OR RCV_ADDR2 LIKE '%"+ addr1 +"%' OR";
	where			+= " TAG_ADDR1 LIKE '%"+ addr1 +"%' OR TAG_ADDR2 LIKE '%"+ addr1 +"%')";
}

if (schShopType != null && schShopType.length() > 0) {
	param			+= "&amp;sch_shop_type="+ schShopType;
	where			+= " AND SHOP_TYPE = '"+ schShopType +"'";
}

if (hp != null && hp.length() > 0) {
	param			+= "&amp;hp="+ hp;
	where			+= " AND (RCV_HP LIKE '%"+ hp +"%' OR TAG_HP LIKE '%"+ hp +"%')";
}

if (tel != null && tel.length() > 0) {
	param			+= "&amp;tel="+ tel;
	where			+= " AND (RCV_TEL LIKE '%"+ tel +"%' OR TAG_TEL LIKE '%"+ tel +"%')";
}

if (orderStdate != null && orderStdate.length() > 0) {
	param			+= "&amp;order_stdate="+ orderStdate;
	where			+= " AND (DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') >= '"+ orderStdate +"')";
}

if (orderLtdate != null && orderLtdate.length() > 0) {
	param			+= "&amp;order_ltdate="+ orderLtdate;
	where			+= " AND (DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') <= '"+ orderLtdate +"')";
}

if (payStdate != null && payStdate.length() > 0) {
	param			+= "&amp;pay_stdate="+ payStdate;
	where			+= " AND (DATE_FORMAT(PAY_DATE, '%Y-%m-%d') >= '"+ payStdate +"')";
}

if (payLtdate != null && payLtdate.length() > 0) {
	param			+= "&amp;pay_stdate="+ payLtdate;
	where			+= " AND (DATE_FORMAT(PAY_DATE, '%Y-%m-%d') <= '"+ payLtdate +"')";
}

if (schPayType != null && schPayType.length() > 0){
	param			+= "&amp;sch_pay_type="+ schPayType;
	where			+= " AND PAY_TYPE = '"+ schPayType +"'";
}

query		= "SELECT COUNT(*) FROM "+ table + where; //out.print(query); if(true)return;
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

query		= "SELECT OC.ORDER_NUM, DATE_FORMAT(REFUND_DATE, '%Y-%m-%d %H:%m') REFUND_DATE, ORDER_NAME, PAY_TYPE, REFUND_PRICE,";
query		+= "	OC.ORDER_STATE, ORDER_ENV, SHOP_TYPE, MEMBER_ID, REFUND_DATE, PG_FINANCENAME";
query		+= " FROM "+ table + where;
query		+= " ORDER BY OC.ORDER_NUM DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>
<%@ include file="../include/inc-cal-script.jsp" %>

	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:3,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
	})
	//]]>
	</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-order.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 주문관리 &gt; <strong>택배반품 및 교환처리</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>고객명</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="sch_order_name" value="<%=schOrderName%>" onfocus="this.select()"/></td>
								<th scope="row">
									<span>주문번호</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="sch_order_num" value="<%=schOrderNum%>" onfocus="this.select()"/></td>
							</tr>
							<tr>
								<th scope="row">
									<span>수령자명</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="sch_name" value="<%=schName%>" onfocus="this.select()"/></td>
								<th scope="row">
									<span>수령일</span>
								</th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="10" readonly="readonly" value="<%=stdate%>" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="10" readonly="readonly" value="<%=ltdate%>" />
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>주소</span>
								</th>
								<td colspan="3"><input type="text" class="input1" style="width:500px;" maxlength="30" name="addr1" value="<%=addr1%>" onfocus="this.select()"/></td>
							</tr>
							<tr>
								<th scope="row">
									<span>판매Shop</span>
								</th>
								<td>
									<span>
										<select style="width:80px;" name="sch_shop_type">
											<option value="">전체</option>
											<option value="01"<%if(schShopType.equals("01")){out.print(" selected=\"selected\"");}%>>홈페이지</option>
											<option value="02"<%if(schShopType.equals("02")){out.print(" selected=\"selected\"");}%>>이샵(전화주문)</option>
											<option value="03"<%if(schShopType.equals("03")){out.print(" selected=\"selected\"");}%>>GS샵</option>
											<option value="04"<%if(schShopType.equals("04")){out.print(" selected=\"selected\"");}%>>롯데닷컴</option>
											<option value="05"<%if(schShopType.equals("05")){out.print(" selected=\"selected\"");}%>>쿠팡</option>
											<option value="06"<%if(schShopType.equals("06")){out.print(" selected=\"selected\"");}%>>티몬</option>
											<option value="07"<%if(schShopType.equals("07")){out.print(" selected=\"selected\"");}%>>홈쇼핑</option>
										</select>
									</span>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>휴대폰번호</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="hp" value="<%=hp%>" onfocus="this.select()"/></td>
								<th scope="row">
									<span>자택번호</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="tel" value="<%=tel%>" onfocus="this.select()"/></td>
							</tr>
							<tr>
								<th scope="row">
									<span>기간</span>
								</th>
								<td colspan="3">
									<input type="text" name="cancel_stdate" id="cancel_stdate" class="input1" maxlength="10" readonly="readonly" value="<%=payStdate%>" />
									~
									<input type="text" name="cancel_ltdate" id="cancel_ltdate" class="input1" maxlength="10" readonly="readonly" value="<%=payLtdate%>" />
								</td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="검색" /></p>			
					<div class="member_box">
						<p class="search_result">총 <strong><%=intTotalCnt%></strong>개</p>
						<p class="right_box">
							<select name="pgsize" onchange="this.form.submit()">
								<option value="10"<%if(pgsize==10)out.print(" selected");%>>10개씩보기</option>
								<option value="20"<%if(pgsize==20)out.print(" selected");%>>20개씩보기</option>
								<option value="30"<%if(pgsize==30)out.print(" selected");%>>30개씩보기</option>
								<option value="100"<%if(pgsize==100)out.print(" selected");%>>100개씩보기</option>
							</select>
						</p>
					</div>
				</form>
				<form name="frm_list" id="frm_list" method="post">
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="10%" />
							<col width="10%" />
							<col width="6%" />
							<col width="6%" />
							<col width="10%" />
							<col width="*" />
							<col width="10%" />
							<col width="10%" />							
							<col width="10%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>취소일자</span></th>
								<th scope="col"><span>주문번호</span></th>
								<th scope="col"><span>아이디</span></th>
								<th scope="col"><span>고객명</span></th>
								<th scope="col"><span>배송구분</span></th>
								<th scope="col"><span>상품명</span></th>
								<th scope="col"><span>카드사</span></th>
								<th scope="col"><span>환불금액</span></th>
								<th scope="col"><span>진행상태</span></th>
							</tr>
							<tr>
								<td colspan="19">등록된 반품/교환내역이 없습니다.</td>
							</tr>
						</tbody>
					</table>
				</form>
				<%@ include file="../include/inc-paging.jsp"%>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
<script type="text/javascript">
$(document).ready(function() {
	$("#order_stdate, #order_ltdate, #pay_stdate, #pay_ltdate").datepicker({
	    buttonText: ''
	});
});
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>