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
String period		= ut.inject(request.getParameter("period"));
if (period.equals("") || period == null) {
	period				= "1";
}
String where		= "";
String param		= "";
String orderNum		= "";
String orderDate	= "";
int payPrice		= 0;
String payType		= "";
String orderState	= "";
int orderCnt		= 0;
NumberFormat nf		= NumberFormat.getNumberInstance();
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String rcvHp			= "";
String pgTid			= "";
String devlType			= "";

SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
Calendar cal		= Calendar.getInstance();
cal.setTime(new Date()); //오늘
String cDate		= dt.format(cal.getTime());
Date date1			= dt.parse(cDate);
Date date2			= null;
String devlDate		= "";
int compare			= 0;
long diff			= 0;
long diffDays		= 0;

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

where			= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND ORDER_STATE < 90";
where			+= "  AND ORDER_NUM NOT IN (SELECT ORDER_NUM FROM ESL_ORDER WHERE ORDER_STATE = '00' AND PAY_TYPE = '10')";

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
	where		+= " AND DATE_FORMAT(ORDER_DATE, '%Y/%m/%d') BETWEEN '"+ stdate +"' AND '"+ ltdate +"'";
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
	<div id="content">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">주문배송조회</span></span></h1>
		<form name="frm_search" method="get" action="orderList.jsp">
			<input type="hidden" name="stdate" id="stdate" class="date-pick" value="<%=stdate%>" />
			<input type="hidden" name="ltdate" id="ltdate" class="date-pick" value="<%=ltdate%>" />
			<ul class="form-line">
				<li>
					<div class="select-box">
						<select name="period" onchange="setDate(this.value)">
							<option value="1"<%if (period.equals("1")) out.println(" selected=\"selected\"");%>>1개월</option>
							<option value="2"<%if (period.equals("2")) out.println(" selected=\"selected\"");%>>2개월</option>
							<option value="3"<%if (period.equals("3")) out.println(" selected=\"selected\"");%>>3개월</option>
						</select>
					</div>
					<div class="clear"></div>
				</li>
			</ul>
		</form>
		<ul class="guide">
			<li>* 교환/반품/배송지 변경 요청은 PC웹 또는 고객센터에서 신청 가능합니다.</li>
            <li>* 최근 3개월 이후 주문내역은 웹에서 조회하실 수 있습니다.</li>
			<li>* 기타 관련문의는 고객센터(080-022-0085)로 연락바랍니다.</li>
		</ul>
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="orderList.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">주문/배송 조회</span></span><span class="active"></span></a></td>
					<td><a href="delichange.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">취소내역 조회</span></span></a></td>
				</tr>
			</table>
		</div>
		<div class="divider"></div>
		<ul class="itemlist bg-gray">
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
					int i				= 0;
					while (rs1.next()) {
						devlType		= rs1.getString("DEVL_TYPE");
						devlDiv			+= "<span class=\"shipping font-blue\">"+ ut.getDevlType(devlType) +"</span>";
						goodsDiv		+= ut.getGubun1Name(rs1.getString("GUBUN1")) +"<p class=\"option\">("+ ut.getGubun2Name(rs1.getString("GUBUN2")) +": "+ rs1.getString("GROUP_NAME") + ")</p>";
						cntDiv			+= "<div>"+ rs1.getInt("ORDER_CNT") +"</div>";
						devlDay			= rs1.getString("DEVL_DAY");
						devlWeek		= rs1.getString("DEVL_WEEK");
						price			= (devlType.equals("0001"))? rs1.getInt("PRICE") : rs1.getInt("PRICE") + rs1.getInt("DEVL_PRICE");
						priceDiv		+= "<div>"+ nf.format(price) +"원</div>";

						if (devlType.equals("0002")) {
							i++;
						}
					}
					rs1.close();

					if (Integer.parseInt(orderState) > 0) {
						query1	= "SELECT MIN(DATE_FORMAT(DEVL_DATE, '%Y%m%d')) DEVL_DATE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
					} else {
						query1	= "SELECT MIN(DATE_FORMAT(DEVL_DATE, '%Y%m%d')) DEVL_DATE FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'";
					}
					if (i > 0) {
						query1		+= " AND DEVL_TYPE = '0002'";
					}
					try {
						rs1	= stmt1.executeQuery(query1);
					} catch(Exception e) {
						out.println(e+"=>"+query1);
						if(true)return;
					}

					if (rs1.next()) {
						devlDate	= rs1.getString("DEVL_DATE");
						date2		= dt.parse(devlDate);
					 
						diff		= date2.getTime() - date1.getTime();
						diffDays	= diff / (24 * 60 * 60 * 1000);

						//out.println(date1 +":"+ date2 +":"+ diffDays);
					}

					rs1.close();
			%>
			<li>
				<a href="orderDetail.jsp?ono=<%=orderNum + param%>&odate=<%=orderDate%>">
					<p class="title">[<%=devlDiv%>]주문번호 <%=orderNum%></p>
					<span class="date"><%=orderDate%></span>
					<p><%=goodsDiv%></p>
					<p>
						총결제금액: <span class="won"><%=nf.format(payPrice)%>원
						<%=ut.getOrderState(orderState)%></span>
					</p>
				</a>
					<%
					query1		= "SELECT ";
					query1		+= "	PAY_PRICE, PAY_TYPE, RCV_HP, PG_CARDNUM, PG_FINANCENAME, PG_ACCOUNTNUM, PG_TID";
					query1		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
					try {
						rs1			= stmt1.executeQuery(query1);
					} catch(Exception e) {
						out.println(e+"=>"+query1);
						if(true)return;
					}

					if (rs1.next()) {
						payPrice		= rs1.getInt("PAY_PRICE");
						payType			= rs1.getString("PAY_TYPE");
						pgCardNum		= rs1.getString("PG_CARDNUM");
						pgFinanceName	= rs1.getString("PG_FINANCENAME");
						pgAccountNum	= rs1.getString("PG_ACCOUNTNUM");
						rcvHp			= rs1.getString("RCV_HP");
						pgTid			= rs1.getString("PG_TID");
					}

					rs1.close();
					%>					
				<input type="hidden" name="order_num" id="order_num_<%=orderNum%>" value="<%=orderNum%>">
				<input type="hidden" name="pay_type" id="pay_type_<%=orderNum%>" value="<%=payType%>">
				<input type="hidden" name="LGD_RFPHONE" id="LGD_RFPHONE_<%=orderNum%>" value="<%=rcvHp%>">
				<input type="hidden" name="item_cnt" id="item_cnt_<%=orderNum%>" value="<%=orderCnt%>">
				<input type="hidden" name="rprice" id="rprice_<%=orderNum%>" value="<%=payPrice%>">
				<input type="hidden" name="rfee" id="rfee_<%=orderNum%>" value="1">
				<input type="hidden" name="pgTID" id="pgTID_<%=orderNum%>" value="<%=pgTid%>">
				<%
				if (Integer.parseInt(orderState) < 2) {
					if (i > 0) {
						if (diffDays > 1) {
				%>
				<a href="javascript:orderCancel('<%=orderNum%>')" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c"><span class="ui-btn-inner"><span class="ui-btn-text">주문취소</span></span></a>
				<%
						}
					} else {									
						if (diffDays > 2) {
				%>
				<a href="javascript:orderCancel('<%=orderNum%>')" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c"><span class="ui-btn-inner"><span class="ui-btn-text">주문취소</span></span></a>
				<%
						}
					}
				}
				%>
			</li>
			<%
				}
			} else {
			%>
			<li>
				<p class="title">주문내역이 없습니다.</p>
			</li>
			<%
			}
			%>
		</ul>
		<ul class="guide">
			<li>* 교환/반품/배송지변경 요청은 PC웹 또는 고객센터에서 신청 가능합니다.</li>
		</ul>
	</div>
	<!-- End Content -->	
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
<form name="frm_cancel" method="post" action="/proc/order_edit_proc.jsp">
	<input type="hidden" name="mode" value="cancel">
	<input type="hidden" name="order_num" id="order_num" value="">
	<input type="hidden" name="code" value="CD1">
	<input type="hidden" name="pay_type" id="pay_type" value="">
	<input type="hidden" name="LGD_RFPHONE" id="LGD_RFPHONE" value="">
	<input type="hidden" name="item_cnt" id="item_cnt" value="">
	<input type="hidden" name="rprice" id="rprice" value="">
	<input type="hidden" name="rfee" id="rfee" value="0">
	<input type="hidden" name="pgTID" id="pgTID" value="">
	<input type="hidden" name="cancelFrom" value="mobile" />
</form>
<script type="text/javascript">
function orderCancel(ono) {
	var msg = "정말로 주문을 취소하시겠습니까?"
	if(confirm(msg)){
		$("#order_num").val(ono);
		$("#pay_type").val($("#pay_type_"+ono).val());
		$("#LGD_RFPHONE").val($("#LGD_RFPHONE_"+ono).val());
		$("#item_cnt").val($("#item_cnt_"+ono).val());
		$("#rprice").val($("#rprice_"+ono).val());
		$("#rfee").val($("#rfee_"+ono).val());
		$("#pgTID").val($("#pgTID_"+ono).val());

		document.frm_cancel.submit();
	}else{
		return;
	}
}

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