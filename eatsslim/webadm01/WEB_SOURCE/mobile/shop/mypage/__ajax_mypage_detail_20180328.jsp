<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>

<%
String goods		= "";// ut.inject(request.getParameter("goods"));
String orderNum		= ut.inject(request.getParameter("ordno"));
//String goodId		= ut.inject(request.getParameter("goodsId"));
//String gCode 		= ut.inject(request.getParameter("groupCode"));
String devlDay		= ut.inject(request.getParameter("devlDay"));
String devlDates	= ut.inject(request.getParameter("devlDates"));
String devlType		= ut.inject(request.getParameter("devlType"));

NumberFormat nf		= NumberFormat.getNumberInstance();
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
String tagName		= "";
String orderDate	= "";
String payType 		= "";
int payPrice		= 0 ;
String orderState	= "";
String payDate		= "";
String tagZipcode	= "";
String tagAddr1		= "";
String tagAddr2		= "";
String tagHp		= "";
String tagTel		= "";
String tagRequest	= "";
int goodsPrice 		= 0;
int devlPrice 		= 0;
int couponPrice		= 0;
int orderPrice		= 0;
int tcnt			= 0;
int couponTprice	= 0;
int goodsId   		= 0;
int orderCnt  		= 0;
String gubun1 		= "";
String groupName 	= "";
String devlDate 	= "";
String buyBagYn 	= "";
//String devlDay  	= "";
String devlWeek 	= "";
String groupCode 	= "";
String minDate  	= "";
String maxDate  	= "";
//String devlDates 	= "";
String devlPeriod 	= "";
int price	  		= 0;
int dayPrice  		= 0;
int tagPrice  		= 0;
int bagPrice  		= 0;
int goodsTprice 	= 0;
int totalPrice 		= 0;

String pgCardNum = "";
String pgFinanceName = "";

query		= "SELECT ";
query		+= "	O.MEMBER_ID, O.PAY_TYPE, O.RCV_NAME, O.RCV_TEL, O.RCV_HP, O.RCV_ZIPCODE, O.RCV_ADDR1, O.RCV_ADDR2, O.RCV_REQUEST,";
query		+= "	O.TAG_NAME, O.TAG_TEL, O.TAG_HP, O.TAG_ZIPCODE, O.TAG_ADDR1, O.TAG_ADDR2, O.TAG_REQUEST, O.PG_TID, O.PG_CARDNUM,";
query		+= "	O.PG_FINANCENAME, O.PG_ACCOUNTNUM, O.ORDER_STATE, O.ORDER_DATE, O.PAY_DATE, O.DEVL_PRICE, O.COUPON_PRICE, O.ADMIN_MEMO, O.ORDER_LOG,";
query		+= "	O.ORDER_NAME, O.SHOP_TYPE, O.OUT_ORDER_NUM";
query		+= " FROM ESL_ORDER O LEFT JOIN ESL_ORDER_GOODS OG ON O.ORDER_NUM = OG.ORDER_NUM ";
query		+= " WHERE O.ORDER_NUM = '"+ orderNum +"'";
query		+= "   AND OG.DEVL_TYPE='"+ devlType +"'";
try {
	rs			= stmt.executeQuery(query);

} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
if(rs.next()){
	tagName 		= rs.getString("RCV_NAME");
	orderDate 		= rs.getString("ORDER_DATE");
	payType			= rs.getString("PAY_TYPE");
	orderState		= rs.getString("ORDER_STATE");
	payDate			= (rs.getString("PAY_DATE") == null)? "" : rs.getString("PAY_DATE");
	tagHp			= rs.getString("RCV_HP");
	tagTel			= rs.getString("RCV_TEL");
	tagZipcode		= rs.getString("RCV_ZIPCODE");
	tagAddr1		= rs.getString("RCV_ADDR1");
	tagAddr2		= rs.getString("RCV_ADDR2");
	tagRequest 		= rs.getString("RCV_REQUEST");
	couponTprice	= rs.getInt("COUPON_PRICE");


	pgCardNum 		= rs.getString("PG_CARDNUM");
	pgFinanceName	= rs.getString("PG_FINANCENAME");
}
%>
<%
query		= "SELECT COUNT(ID) FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //총 레코드 수
}
rs.close();

query		= "SELECT OG.ID, OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, OG.ORDER_STATE,";
query		+= "	DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN,";
query		+= "	G.GUBUN1, G.GUBUN2, G.GROUP_NAME, G.GROUP_CODE, G.CART_IMG, OG.COUPON_PRICE, G.GROUP_CODE, O.PAY_TYPE";
query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID";
query		+= "  AND OG.DEVL_TYPE='"+ devlType +"'";
query		+= "  AND OG.ORDER_NUM = O.ORDER_NUM";
query		+= "  AND OG.ORDER_NUM = '"+ orderNum +"'";
query		+= " ORDER BY OG.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
query1   = "";


if (tcnt > 0) {
	while (rs.next()) {
		goodsId		= rs.getInt("ID");
		orderCnt	= rs.getInt("ORDER_CNT");
		gubun1		= rs.getString("GUBUN1");
		groupCode	= rs.getString("GROUP_CODE");
		couponPrice	= rs.getInt("COUPON_PRICE");
		if (rs.getString("DEVL_TYPE").equals("0001")) {
			groupName	= rs.getString("GROUP_NAME");
			devlDate	= rs.getString("WDATE");
			buyBagYn	= rs.getString("BUY_BAG_YN");
			devlDay		= rs.getString("DEVL_DAY");
			devlWeek	= rs.getString("DEVL_WEEK");
			price		= rs.getInt("PRICE");
			goodsPrice	= price * orderCnt;
			dayPrice += goodsPrice;

			query1		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
			query1		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
			query1		+= " AND GOODS_ID = '"+ goodsId +"'";
			try {
				rs1			= stmt.executeQuery(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

			if (rs1.next()) {
				minDate			= rs1.getString("MIN_DATE");
				maxDate			= rs1.getString("MAX_DATE");
			}

			devlDates		= ut.isnull(minDate) +"<br />~<br />"+ ut.isnull(maxDate);
		} else {
			groupName		+= ut.getGubun2Name(rs.getString("GUBUN2"));
			devlDate	= "-";
			buyBagYn	= "N";
			devlPeriod	= "-";
			price		= rs.getInt("PRICE");
			goodsPrice	= price * orderCnt;
			tagPrice	+= goodsPrice;
			devlDates	= "-";
		}
		orderPrice	= goodsPrice - couponPrice;
		payType		= rs.getString("PAY_TYPE");
		orderState	= rs.getString("ORDER_STATE");

		if (buyBagYn.equals("Y")) {
			bagPrice	+= defaultBagPrice * orderCnt;
		}


	}

	orderPrice		= dayPrice + tagPrice + bagPrice;
	goodsTprice		= dayPrice + tagPrice;

	totalPrice		= orderPrice + devlPrice - couponTprice;

	if (totalPrice < 0) totalPrice = 0;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body class="expansioncss">
<div class="shop_title">
	<button type="button" class="loc_back" onclick="pSlideFn.onAddCont({direction:'prev'});"><img src="/mobile/common/images/ico/ico_loc_back.png" alt=""></button>
	<p>주문 상세정보</p>
</div>
<div class="content" id="orderDetail">
	<div class="table_style_1 box">
		<table>
			<tbody>
				<tr>
					<th>주문일</th>
					<td><%=orderDate%></td>
				</tr>
				<tr>
					<th>주문번호</th>
					<td><%=orderNum %></td>
				</tr>
				<tr>
					<th>주문상품</th>
					<td><strong><%=groupName %></strong></td>
				</tr>
			</tbody>
		</table>
		<% if(devlType.equals("0001")){ //-- 일배 상품만 %>
			<button type="button" class="openCalendar" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_calendar.jsp?ordno=<%=orderNum %>&goodsId=<%=goodsId%>&groupCode=<%=groupCode%>&devlDates=<%=devlDates %>&devlDay=<%=devlDay %>'});">배송캘린더</button>
		<% } %>
	</div>
	<div class="table_style_1">
		<table>
			<thead>
				<tr>
					<th colspan="2">결제정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>결제방법</th>
					<td><%=ut.getPayType(payType)%></td>
				</tr>
				<tr>
					<th>카드정보</th>
					<td><span><%=pgFinanceName%></span> <%=pgCardNum%></td>
				</tr>
				<tr>
					<th>결제일시</th>
					<td>
						<%if (Integer.parseInt(orderState) > 0) {%>
							<%=payDate%>
						<%}%>
					</td>
				</tr>
					<tr>
						<th>상품금액</th>
						<td><%=nf.format(goodsTprice)%> 원</td>
					</tr>
					<tr>
						<th>상품할인</th>
						<td><%=nf.format(couponPrice)%> 원</td>
					</tr>
					<tr>
						<th>배송비</th>
						<td><%=nf.format(devlPrice)%> 원</td>
					</tr>
					<tr>
						<th>총 결제금액</th>
						<td><strong><%=nf.format(totalPrice)%> 원</strong></td>
					</tr>
			</tbody>
		</table>
	</div>
	<div class="table_style_1">
		<table>
			<thead>
				<tr>
					<th colspan="2">배송정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>수령인</th>
					<td><%=tagName %></td>
				</tr>
				<tr>
					<th>핸드폰</th>
					<td><%=tagHp %></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><%=tagTel %></td>
				</tr>
				<tr>
					<th>배송주소</th>
					<td><p><span>(<%=tagZipcode %>)</span> <%=tagAddr1 %> <%=tagAddr2 %></p></td>
				</tr>
				<tr>
					<th>배송유의사항</th>
					<td><%=tagRequest %></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

</body>
</html>