<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_ORDER";
String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
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
String schPayType		= "";
String[] schOrderStates;
String[] schOrderEnvs;
String[] schPayTypes;
String field			= ut.inject(request.getParameter("field"));
String keyword			= ut.inject(request.getParameter("keyword"));
String minDate			= "";
String maxDate			= "";
String where			= "";
String param			= "";
String orderNum			= "";
String orderDate		= "";
String payDate			= "";
String productName		= "";
String orderName		= "";
String payType			= "";
String payTypeTxt		= "";
int payPrice			= 0;
String orderState		= "";
String orderEnv			= "";
String shopType			= "";
String outOrderNum		= ut.inject(request.getParameter("out_order_num"));
NumberFormat nf			= NumberFormat.getNumberInstance();

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

where			= " WHERE (ORDER_STATE < 90 OR ORDER_STATE IN (91, 911))";
where			+= "  AND ORDER_NUM NOT IN (SELECT ORDER_NUM FROM ESL_ORDER WHERE ORDER_STATE = '00' AND PAY_TYPE = '10')";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage			= Integer.parseInt(request.getParameter("page"));
	startpage		= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage			= 1;
	startpage		= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize			= Integer.parseInt(request.getParameter("pgsize"));

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	if (field.equals("RCV_NAME")) {
		where			+= " AND (RCV_NAME LIKE '%"+ keyword +"%' OR TAG_NAME LIKE '%"+ keyword +"%')";
	} else {
		where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
	}
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

if (stdate != null && stdate.length() > 0) {
	param			+= "&amp;stdate="+ stdate;
	where			+= " AND (DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') >= '"+ stdate +"')";
}

if (ltdate != null && ltdate.length() > 0) {
	param			+= "&amp;ltdate="+ ltdate;
	where			+= " AND (DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') <= '"+ ltdate +"')";
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

if (request.getParameter("sch_order_state") != null) {
	schOrderState	= "'"+ request.getParameter("sch_order_state") +"'";
	param += "&sch_order_state=" + request.getParameter("sch_order_state");
} else if (request.getParameterValues("sch_order_state") != null){
	schOrderStates	= request.getParameterValues("sch_order_state");
	for( i = 0; i < schOrderStates.length; i++ ){
		if (i==0) {
			schOrderState	= "'"+ schOrderStates[i] +"'";
		} else {
			schOrderState	+= ",'"+ schOrderStates[i] +"'";
		}
	}
	param += "&sch_order_state=" + schOrderState;
}

if (!schOrderState.equals("")) where += " AND ORDER_STATE IN ("+schOrderState+")";

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

if (request.getParameter("sch_order_env") != null) {
	schOrderEnv		= "'"+ request.getParameter("sch_order_env") +"'";
	param += "&sch_order_env=" + request.getParameter("sch_order_env");
} else if (request.getParameterValues("sch_order_env") != null){
	schOrderEnvs	= request.getParameterValues("sch_order_env");
	for( i = 0; i < schOrderEnvs.length; i++ ){
		if (i==0) {
			schOrderEnv	= "'"+ schOrderEnvs[i] +"'";
		} else {
			schOrderEnv	+= ",'"+ schOrderEnvs[i] +"'";
		}
	}
	param += "&sch_order_env=" + schOrderEnv;
}

if (!schOrderEnv.equals("")) where += " AND ORDER_ENV IN ("+schOrderEnv+")";

if (request.getParameter("sch_pay_type") != null) {
	schPayType		= "'"+ request.getParameter("sch_pay_type") +"'";
	param += "&sch_pay_type=" + request.getParameter("sch_pay_type");
} else if (request.getParameterValues("sch_pay_type") != null){
	schPayTypes	= request.getParameterValues("sch_pay_type");
	for( i = 0; i < schPayTypes.length; i++ ){
		if (i==0) {
			schPayType	= "'"+ schPayTypes[i] +"'";
		} else {
			schPayType	+= ",'"+ schPayTypes[i] +"'";
		}
	}
	param += "&sch_pay_type=" + schPayType;
}

if (!schPayType.equals("")) where += " AND PAY_TYPE IN ("+schPayType+")";

if (outOrderNum != null && outOrderNum.length() > 0) {
	param			+= "&amp;out_order_num="+ outOrderNum;
	where			+= " AND OUT_ORDER_NUM LIKE '%"+ outOrderNum +"%'";
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

query		= "SELECT ORDER_NUM, DATE_FORMAT(PAY_DATE, '%Y-%m-%d %H:%i') PAY_DATE, ORDER_NAME, PAY_TYPE, PAY_PRICE,";
query		+= "	ORDER_STATE, ORDER_ENV, SHOP_TYPE";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ORDER_NUM DESC";
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
		$('#lnb').menuModel2({hightLight:{level_1:1,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
	})
	//]]>
	</script><link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>	
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 주문관리 &gt; <strong>주문상세관리</strong></p>
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
									<span>
										<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
											<option value="RCV_NAME"<%if(field.equals("RCV_NAME")){out.print(" selected=\"selected\"");}%>>고객명</option>
											<option value="MEMBER_ID"<%if(field.equals("MEMBER_ID")){out.print(" selected=\"selected\"");}%>>아이디</option>
										</select>
									</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()" /></td>
								<th scope="row">
									<span>주문번호</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="sch_order_num" value="<%=schOrderNum%>" onfocus="this.select()" /></td>
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
										<select name="sch_shop_type">
											<option value="">전체</option>
											<option value="51"<%if(schShopType.equals("51")){out.print(" selected=\"selected\"");}%>>홈페이지</option>
											<option value="53"<%if(schShopType.equals("53")){out.print(" selected=\"selected\"");}%>>이샵(전화)결제</option>
											<option value="59"<%if(schShopType.equals("59")){out.print(" selected=\"selected\"");}%>>임직원몰 주문</option>
											<option value="60"<%if(schShopType.equals("60")){out.print(" selected=\"selected\"");}%>>이샵(홈페이지)결제</option>
											<option value="54"<%if(schShopType.equals("54")){out.print(" selected=\"selected\"");}%>>GS샵</option>
											<option value="55"<%if(schShopType.equals("55")){out.print(" selected=\"selected\"");}%>>롯데닷컴</option>
											<option value="56"<%if(schShopType.equals("56")){out.print(" selected=\"selected\"");}%>>쿠팡</option>
											<option value="57"<%if(schShopType.equals("57")){out.print(" selected=\"selected\"");}%>>티몬</option>
											<option value="58"<%if(schShopType.equals("58")){out.print(" selected=\"selected\"");}%>>홈쇼핑</option>
											<option value="61"<%if(schShopType.equals("61")){out.print(" selected=\"selected\"");}%>>NOOM</option>
											<option value="62"<%if(schShopType.equals("62")){out.print(" selected=\"selected\"");}%>>삼성웰스토리몰</option>
											<option value="63"<%if(schShopType.equals("63")){out.print(" selected=\"selected\"");}%>>CJ몰</option>
											<option value="64"<%if(schShopType.equals("64")){out.print(" selected=\"selected\"");}%>>위메프</option>
											<option value="65"<%if(schShopType.equals("65")){out.print(" selected=\"selected\"");}%>>현대H몰</option>
											<option value="66"<%if(schShopType.equals("66")){out.print(" selected=\"selected\"");}%>>11번가</option>
											<option value="67"<%if(schShopType.equals("67")){out.print(" selected=\"selected\"");}%>>다이어트신</option>
											<option value="68"<%if(schShopType.equals("68")){out.print(" selected=\"selected\"");}%>>스포애니(Gym)</option>
											<option value="69"<%if(schShopType.equals("69")){out.print(" selected=\"selected\"");}%>>서초구보건소</option>
											<option value="70"<%if(schShopType.equals("70")){out.print(" selected=\"selected\"");}%>>잇슬림_비에비스병원</option>
											<option value="71"<%if(schShopType.equals("71")){out.print(" selected=\"selected\"");}%>>잇슬림_G마켓</option>
											<option value="90"<%if(schShopType.equals("90")){out.print(" selected=\"selected\"");}%>>FD_성인식(오프라인)</option>
											<option value="99"<%if(schShopType.equals("99")){out.print(" selected=\"selected\"");}%>>잇슬림(증정)</option>
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
									<span>주문상태</span>
								</th>
								<td colspan="3">
									<input type="checkbox" name="sch_order_state" value="00"<%=ut.getArrCheck(schOrderState, "00", " checked=\"checked\"")%> />
									주문접수
									<input type="checkbox" name="sch_order_state" value="01"<%=ut.getArrCheck(schOrderState, "01", " checked=\"checked\"")%> />
									결제완료
									<input type="checkbox" name="sch_order_state" value="02"<%=ut.getArrCheck(schOrderState, "02", " checked=\"checked\"")%> />
									상품준비중
									<input type="checkbox" name="sch_order_state" value="03"<%=ut.getArrCheck(schOrderState, "03", " checked=\"checked\"")%> />
									배송중
									<input type="checkbox" name="sch_order_state" value="04"<%=ut.getArrCheck(schOrderState, "04", " checked=\"checked\"")%> />
									배송완료
									<input type="checkbox" name="sch_order_state" value="05"<%=ut.getArrCheck(schOrderState, "05", " checked=\"checked\"")%> />
									주문완료
									<input type="checkbox" name="sch_order_state" value="91"<%=ut.getArrCheck(schOrderState, "91", " checked=\"checked\"")%> />
									취소완료
									<input type="checkbox" name="sch_order_state" value="911"<%=ut.getArrCheck(schOrderState, "911", " checked=\"checked\"")%> />
									부분취소완료
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>주문일</span>
								</th>
								<td>
									<input type="text" name="order_stdate" id="order_stdate" class="input1" maxlength="10" readonly="readonly" />
									~
									<input type="text" name="order_ltdate" id="order_ltdate" class="input1" maxlength="10" readonly="readonly" />
								</td>
								<th scope="row">
									<span>입금일</span>
								</th>
								<td>
									<input type="text" name="pay_stdate" id="pay_stdate" class="input1" maxlength="10" readonly="readonly" />
									~
									<input type="text" name="pay_ltdate" id="pay_ltdate" class="input1" maxlength="10" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>주문환경</span>
								</th>
								<td>
									<input type="checkbox" name="sch_order_env" value="P"<%=ut.getArrCheck(schOrderEnv, "P", " checked=\"checked\"")%> />
									PC
									<input type="checkbox" name="sch_order_env" value="M"<%=ut.getArrCheck(schOrderEnv, "M", " checked=\"checked\"")%> />
									Mobile
								</td>
								<th scope="row">
									<span>결제수단</span>
								</th>
								<td>
									<input type="checkbox" name="sch_pay_type" value="10"<%=ut.getArrCheck(schPayType, "10", " checked=\"checked\"")%> />
									신용카드
									<input type="checkbox" name="sch_pay_type" value="20"<%=ut.getArrCheck(schPayType, "20", " checked=\"checked\"")%> />
									계좌이체
									<input type="checkbox" name="sch_pay_type" value="30"<%=ut.getArrCheck(schPayType, "30", " checked=\"checked\"")%> />
									가상계좌(무통장)
									<input type="checkbox" name="sch_pay_type" value="40"<%=ut.getArrCheck(schPayType, "40", " checked=\"checked\"")%> />
									소셜(기타)
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>외부몰주문번호</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="out_order_num" value="<%=outOrderNum%>" onfocus="this.select()"/></td>
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
				<form name="frm_list" id="frm_list" method="post" action="order_list_ajax.jsp">
					<input type="hidden" name="mode" value="del" />
					<input type="hidden" name="del_ids" id="del_ids" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="4%" />
							<col width="4%" />
							<col width="10%" />
							<col width="10%" />
							<col width="*" />
							<col width="10%" />
							<col width="6%" />
							<col width="10%" />
							<col width="8%" />
							<col width="8%" />
							<col width="6%" />
							<col width="8%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span><input type="checkbox" id="selectall" /></span></td>
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>주문번호</span></th>
								<th scope="col"><span>입금일시</span></th>
								<th scope="col"><span>주문상품</span></th>
								<th scope="col"><span>주문기간</span></th>
								<th scope="col"><span>주문자</span></th>
								<th scope="col"><span>결제수단</span></th>
								<th scope="col"><span>결제금액</span></th>
								<th scope="col"><span>주문상태</span></th>
								<th scope="col"><span>환경</span></th>
								<th scope="col"><span>판매SHOP</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									orderNum	= rs.getString("ORDER_NUM");
									payDate	= (rs.getString("PAY_DATE") == null)? "" : rs.getString("PAY_DATE");
									query1		= "SELECT ";
									query1		+= "		GROUP_NAME, GUBUN1, GUBUN2, DEVL_TYPE, ORDER_CNT, PRICE, BUY_BAG_YN,";
									query1		+= "		DEVL_DAY, DEVL_WEEK";
									query1		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O";
									query1		+= " WHERE G.ID = OG.GROUP_ID";
									query1		+= " AND OG.ORDER_NUM = O.ORDER_NUM AND OG.ORDER_NUM = '"+ orderNum +"'";
									query1		+= " ORDER BY O.ID DESC";
									try {
										rs1 = stmt1.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}

									i		= 0;
									while (rs1.next()) {
										if (i > 0) {
											productName	= rs1.getString("GROUP_NAME")+" 외 "+ i +"건";
										} else {
											productName	= rs1.getString("GROUP_NAME");
										}
										i++;
									}
									orderName	= rs.getString("ORDER_NAME");
									payType		= rs.getString("PAY_TYPE");
									payPrice	= rs.getInt("PAY_PRICE");
									orderState	= rs.getString("ORDER_STATE");
									orderEnv	= (rs.getString("ORDER_ENV").equals("P"))? "PC" : "Mobile";
									shopType	= rs.getString("SHOP_TYPE");
									
									
									query1		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
									query1		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"' AND GROUP_CODE != '0300578'";
									try {
										rs1			= stmt.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}

									if (rs1.next()) {
										minDate			= ut.isnull(rs1.getString("MIN_DATE"));
										maxDate			= ut.isnull(rs1.getString("MAX_DATE"));
										//devlDates		= ut.isnull(rs1.getString("MIN_DATE")) +"~"+ ut.isnull(rs1.getString("MAX_DATE"));
									} else {
										//devlDates		= "-";
									}

									rs1.close();
									
									
							%>
							<tr>
								<td>
								<input type="checkbox" class="selectable" value="<%=orderNum%>"  <% if (shopType.equals("51")) {%>disabled <% } %>/>
								</td>
								<td><%=curNum%></td>
								<td><a href="javascript:;" onclick="popup('order_view.jsp?ordno=<%=orderNum%>',900,720,'order_view');"><%=orderNum%></a></td>
								<td>
									<%if (Integer.parseInt(orderState) > 0) {%>
									<%=payDate%>
									<%}%>
								</td>
								<td><%=productName%></td>
								<td><%=minDate%><br>~<%=maxDate%></td>
								<td><%=orderName%></td>
								<td><%=ut.getPayType(payType)%></td>
								<td><%=nf.format(payPrice)%></td>
								<td>
									<%
									if (payType.equals("10") && Integer.parseInt(orderState)==0) {
										out.print("결제실패");
									} else {
										out.println(ut.getOrderState(orderState));
									}
									%>
								</td>
								<td><%=orderEnv%></td>
								<td><%=ut.getShopType(shopType)%></td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="10">등록된 주문내역이 없습니다.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<div class="btn_style1">
					<p class="left_btn">
						<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>삭제</span></a>						
					</p>
				</div>
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
	$("#selectall").click(selectAll);
	
	$('#order_stdate,#order_ltdate').datepick({ 
		onSelect: customRange1,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$('#pay_stdate,#pay_ltdate').datepick({ 
		onSelect: customRange2,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$('#stdate,#ltdate').datepick({ 
		onSelect: customRange3,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
});

function customRange1(dates) {
	if (this.id == 'order_stdate') { 
        $('#order_ltdate').datepick('option', 'minDate', dates[0] || null); 
    } else { 
        $('#order_stdate').datepick('option', 'maxDate', dates[0] || null); 
    }
}

function customRange2(dates) {
	if (this.id == 'pay_stdate') { 
        $('#pay_ltdate').datepick('option', 'minDate', dates[0] || null); 
    } else { 
        $('#pay_stdate').datepick('option', 'maxDate', dates[0] || null); 
    }
}

function customRange3(dates) {
	if (this.id == 'stdate') { 
        $('#ltdate').datepick('option', 'minDate', dates[0] || null); 
    } else { 
        $('#stdate').datepick('option', 'maxDate', dates[0] || null); 
    }
}

function selectAll() {
    var checked = $("#selectall").attr("checked");

    $(".selectable").each(function(){
       var subChecked = $(this).attr("checked");
       if (subChecked != checked)
          $(this).click();
    });
}

function chkDel() {
	var chk_del = $(".selectable:checked");

	if(chk_del.length < 1) {
		alert("삭제할 메뉴를 선택하세요!");
	} else {
		if (confirm("정말로 삭제하시겠습니까?")) {
			var del_arr = new Array();
			var i = 0;
			$(".selectable:checked").each(function() {
				del_arr[i] = $(this).val();
				i++;
			});
			var del_ids_val = del_arr.join();
			
			$("#del_ids").val(del_ids_val);
			document.frm_list.submit();
/*
			$.post("order_list_ajax.jsp", {
				mode: 'del', 
				del_ids: del_ids_val
			},
			function(data) {
				$(data).find('result').each(function() {
					if ($(this).text() == 'success') {
						alert('삭제되었습니다.');
						location.href = 'order_list.jsp';
					} else {
						$(data).find('error').each(function() {
							alert($(this).text());
						});
					}
				});
			}, "xml");
			*/
		}
	}
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>