<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

response.setHeader("Content-Disposition", "attachment; filename=order_list.xls"); 
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setHeader("Content-Type", "application/vnd.ms-excel; name='excel', text/html; charset=euc-kr");
response.setContentType("text/plain;charset=euc-kr");


String table		= "ESL_ORDER_DEVL_DATE";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String stdate		= ut.inject(request.getParameter("stdate").replace("-", ""));
String ltdate		= ut.inject(request.getParameter("ltdate").replace("-", ""));
String sort			= ut.inject(request.getParameter("sort"));
String payType		= ut.inject(request.getParameter("pay_type"));
String shopType		= ut.inject(request.getParameter("shop_type"));
String etype		= ut.inject(request.getParameter("etype"));
String category		= ut.inject(request.getParameter("category"));
int totalCnt		= 0;
String orderNum		= "";
String orderSub		= "";
String gubun1		= "";
String gubun2		= "";
String gubunCode	= "";
String gubun3		= "";
String groupCode	= "";
String groupName	= "";
String orderDate	= "";
String devlDate		= "";
int orderCnt		= 0;
String state		= "";
int tSellPrice		= 0;
int tCouponPrice	= 0;
int tPayPrice		= 0;
float couponPrice	= 0;
int tOrderCnt		= 0;
float payPrice		= 0;
float price			= 0;
int bagPrice		= 0;
int chkCnt			= 0;
String agencyid		= "";
String orderName	= "";
String hp			= "";
String zipcode		= "";
String addr1		= "";
String addr2		= "";
String newGubun		= "";
String memberId		= "";
String devlWeek		= "";
String devlDay		= "";
String couponNum	= "";
String couponName	= "";
String shopCd		= "";
String shopOrderNum	= "";
String where		= "";

if (etype.equals("3") || etype.equals("4")) {
	where		= " WHERE STATE = '91'";
} else {
	where		= " WHERE STATE < 90";
}
if (stdate != null && stdate.length() > 0) {
	if (etype.equals("1") || etype.equals("3")) {
		where		+= " AND ORDER_DATE >= '"+ stdate +"'";
	} else {
		where		+= " AND DATE_FORMAT(DEVL_DATE, '%Y%m%d') >= '"+ stdate +"'";
	}
}

if (ltdate != null && ltdate.length() > 0) {
	if (etype.equals("1") || etype.equals("3")) {
		where		+= " AND ORDER_DATE <= '"+ ltdate +"'";
	} else {
		where		+= " AND DATE_FORMAT(DEVL_DATE, '%Y%m%d') <= '"+ ltdate +"'";
	}
}

if (payType != null && payType.length() > 0) {
	if (payType.equals("1")) {
		where		+= " AND (STATE != '02' AND TOT_PAY_PRICE > 0)";
	} else {
		where		+= " AND (STATE = '02' OR TOT_PAY_PRICE = 0)";
	}
}

if (shopType != null && shopType.length() > 0) {
	where		+= " AND SHOP_CD = '"+ shopType +"'";
}

if (category != null && category.length() > 0) {
	where		+= " AND GUBUN_CODE LIKE '"+ category +"%'";
}
query		= "SELECT COUNT(ID) FROM "+ table;
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	totalCnt	= rs.getInt(1);
}
rs.close();

query		= "SELECT DISTINCT ORDER_NUM, GOODS_ID, ORDER_DATE, ORDER_NAME, RCV_HP, SHOP_CD, SHOP_ORDER_NUM";
query		+= " FROM "+ table + where + " ORDER BY GOODS_ID, DEVL_DATE";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
%>
<table border="1" cellspacing="0">
	<tbody>
		<tr>
			<th scope="col"><span>주문번호</span></th>
			<th scope="col"><span>주문번호_sub</span></th>
			<th scope="col"><span>주문일</span></th>
			<th scope="col"><span>고객구분</span></th>
			<th scope="col"><span>아이디</span></th>
			<th scope="col"><span>주문자명</span></th>
			<th scope="col"><span>핸드폰</span></th>
			<th scope="col"><span>구분</span></th>
			<th scope="col"><span>주문상품</span></th>
			<th scope="col"><span>주문기간1</span></th>
			<th scope="col"><span>주문기간2</span></th>
			<th scope="col"><span>매출/증정구분</span></th>
			<th scope="col"><span>상품가(원)</span></th>
			<th scope="col"><span>쿠폰금액(원)</span></th>
			<th scope="col"><span>실결제금액(원)</span></th>
			<th scope="col"><span>보냉가방금액(원)</span></th>
			<th scope="col"><span>쿠폰명</span></th>
			<th scope="col"><span>유입경로</span></th>
			<th scope="col"><span>외부몰주문번호</span></th>
		</tr>
		<%
		if (totalCnt > 0) {
			while (rs.next()) {
				orderNum		= rs.getString("ORDER_NUM");
				orderSub		= rs.getString("GOODS_ID");
				orderDate		= rs.getString("ORDER_DATE");
				shopOrderNum	= rs.getString("SHOP_ORDER_NUM");
				memberId		= "";
				query1		= "SELECT MEMBER_ID FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
				try {
					rs1	= stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if (true) return;
				}

				if (rs1.next()) {
					memberId		= rs1.getString("MEMBER_ID");
				}
				rs1.close();

				orderName		= rs.getString("ORDER_NAME");
				hp				= rs.getString("RCV_HP");
				if (!memberId.equals("0")) {
					//memberId		= orderName + hp.substring(hp.length() - 4, hp.length());
					query1		= "SELECT COUNT(ID) FROM ESL_ORDER";
					query1		+= " WHERE MEMBER_ID = '"+ memberId +"'";
				} else {
					query1		= "SELECT COUNT(ID) FROM ESL_ORDER";
					query1		+= " WHERE ORDER_NAME = '"+ orderName +"'";
					query1		+= " AND (RCV_HP = '"+ hp +"' OR TAG_HP = '"+ hp +"')";
				}
				query1		+= " AND DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') < '"+ stdate +"'";
				query1		+= " AND ((ORDER_STATE > 0 AND ORDER_STATE < 90) OR ORDER_STATE = '911')";
				try {
					rs1	= stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if (true) return;
				}

				if (rs1.next()) {
					chkCnt		= rs1.getInt(1);
				} 
				rs1.close();

				newGubun		= (chkCnt > 1)? "기존" : "신규";
				couponNum		= "";
				query1		= "SELECT GUBUN1, GROUP_NAME, DEVL_WEEK, DEVL_DAY, ORDER_CNT, COUPON_NUM";
				query1		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G";
				query1		+= " WHERE OG.GROUP_ID = G.ID";
				query1		+= " AND ORDER_NUM = '"+ orderNum +"' AND OG.ID = '"+ orderSub +"'";
				try {
					rs1	= stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if (true) return;
				}

				if (rs1.next()) {
					gubun1			= ut.getGubun1Name(rs1.getString("GUBUN1"));
					groupName		= rs1.getString("GROUP_NAME");
					devlWeek		= rs1.getString("DEVL_WEEK");
					devlDay			= rs1.getString("DEVL_DAY");
					orderCnt		= rs1.getInt("ORDER_CNT");
					couponNum		= rs1.getString("COUPON_NUM");
				}
				rs1.close();
				
				price			= 0;
				payPrice		= 0;
				couponPrice		= 0;
				tOrderCnt		= 0;
				bagPrice		= 0;
				tSellPrice		= 0;
				tCouponPrice	= 0;
				tPayPrice		= 0;

				query1		= "SELECT SUM(PRICE * ORDER_CNT) FROM ESL_ORDER_DEVL_DATE";
				query1		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = '"+ orderSub +"'";
				query1		+= " AND STATE < 90";
				if (etype.equals("1") || etype.equals("3")) {
					query1		+= " AND ORDER_DATE >= '"+ stdate +"'";
					query1		+= " AND ORDER_DATE <= '"+ ltdate +"'";
				} else {
					query1		+= " AND DATE_FORMAT(DEVL_DATE, '%Y%m%d') >= '"+ stdate +"'";
					query1		+= " AND DATE_FORMAT(DEVL_DATE, '%Y%m%d') <= '"+ ltdate +"'";
				}
				try {
					rs1	= stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if (true) return;
				}

				if (rs1.next()) {
					tSellPrice		= rs1.getInt(1);
				}
				rs1.close();

				if (Integer.parseInt(rs.getString("SHOP_CD")) > 52 || !shopOrderNum.equals("")) {
					query1		= "SELECT IF (OG.DEVL_TYPE = '0001', ((OG.PRICE * OG.ORDER_CNT) - O.COUPON_PRICE) / (OG.DEVL_DAY * OG.DEVL_WEEK * OG.ORDER_CNT), ((OG.PRICE * OG.ORDER_CNT) - O.COUPON_PRICE) / OG.ORDER_CNT) AS PAY_PRICE,";
					query1		+= "	IF (OG.DEVL_TYPE = '0001', O.COUPON_PRICE / (OG.DEVL_DAY * OG.DEVL_WEEK * OG.ORDER_CNT), O.COUPON_PRICE / OG.ORDER_CNT) AS COUPON_PRICE";
					query1		+= " FROM ESL_ORDER O, ESL_ORDER_GOODS OG";
					query1		+= " WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.ORDER_NUM = '"+ orderNum +"'";					
				} else {
					query1		= "SELECT IF (DEVL_TYPE = '0001', ((PRICE * ORDER_CNT) - COUPON_PRICE) / (DEVL_DAY * DEVL_WEEK * ORDER_CNT), ((PRICE * ORDER_CNT) - COUPON_PRICE) / ORDER_CNT) AS PAY_PRICE,";
					query1		+= "	IF (DEVL_TYPE = '0001', COUPON_PRICE / (DEVL_DAY * DEVL_WEEK * ORDER_CNT), COUPON_PRICE / ORDER_CNT) AS COUPON_PRICE";
					query1		+= " FROM ESL_ORDER_GOODS";
					query1		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND ID = '"+ orderSub +"'";
				}
				try {
					rs1	= stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if (true) return;
				}

				if (rs1.next()) {
					payPrice		= rs1.getFloat("PAY_PRICE");
					couponPrice		= rs1.getFloat("COUPON_PRICE");
				}
				rs1.close();
				
				query1		= "SELECT SUM(ORDER_CNT) AS T_ORDER_CNT";
				query1		+= " FROM ESL_ORDER_DEVL_DATE";
				query1		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = '"+ orderSub +"'";
				query1		+= " AND STATE < 90 AND GROUP_CODE != '0300668'";
				query1		+= " AND PRICE > 0";
				if (etype.equals("1") || etype.equals("3")) {
					query1		+= " AND ORDER_DATE >= '"+ stdate +"'";
					query1		+= " AND ORDER_DATE <= '"+ ltdate +"'";
				} else {
					query1		+= " AND DATE_FORMAT(DEVL_DATE, '%Y%m%d') >= '"+ stdate +"'";
					query1		+= " AND DATE_FORMAT(DEVL_DATE, '%Y%m%d') <= '"+ ltdate +"'";
				}
				try {
					rs1	= stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if (true) return;
				}

				if (rs1.next()) {
					tOrderCnt		= rs1.getInt("T_ORDER_CNT");
				}
				rs1.close();
				
				query1		= "SELECT SUM(PRICE * ORDER_CNT) AS BAG_PRICE FROM ESL_ORDER_DEVL_DATE";
				query1		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = '"+ orderSub +"'";
				query1		+= " AND STATE < 90 AND GROUP_CODE = '0300668'";
				if (etype.equals("1") || etype.equals("3")) {
					query1		+= " AND ORDER_DATE >= '"+ stdate +"'";
					query1		+= " AND ORDER_DATE <= '"+ ltdate +"'";
				} else {
					query1		+= " AND DATE_FORMAT(DEVL_DATE, '%Y%m%d') >= '"+ stdate +"'";
					query1		+= " AND DATE_FORMAT(DEVL_DATE, '%Y%m%d') <= '"+ ltdate +"'";
				}
				try {
					rs1	= stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if (true) return;
				}

				if (rs1.next()) {
					bagPrice		= rs1.getInt("BAG_PRICE");
				}
				rs1.close();
				tCouponPrice	= (int)(couponPrice * tOrderCnt);
				tPayPrice		= (int)(payPrice * tOrderCnt + bagPrice);
				if (tPayPrice == 2147483647) {
					tPayPrice		= 0;
				}
				if (etype.equals("1") || etype.equals("2")) {
					state			= (tSellPrice == 0)? "증정" : "매출";
				} else {
					state			= (tSellPrice == 0)? "증정취소" : "매출취소";
				}
				couponName		= "";
				if ((!couponNum.equals("") || tCouponPrice > 0) && (Integer.parseInt(rs.getString("SHOP_CD")) < 53 && shopOrderNum.equals(""))) {
					query1			= "SELECT DISTINCT C.COUPON_NAME FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
					query1			+= " WHERE C.ID = CM.COUPON_ID AND CM.COUPON_NUM = '"+ couponNum +"'";
					try {
						rs1	= stmt1.executeQuery(query1);
					} catch(Exception e) {
						out.println(e+"=>"+query1);
						if (true) return;
					}

					if (rs1.next()) {
						couponName		= rs1.getString("COUPON_NAME");
					}
					rs1.close();
				}
				shopCd			= ut.getShopType(rs.getString("SHOP_CD"));
		%>
		<tr>
			<td><%=orderNum%></td>
			<td><%=orderSub%></td>
			<td><%=orderDate%></td>
			<td><%=newGubun%></td>
			<td><%=memberId%></td>
			<td><%=orderName%></td>
			<td><%=hp%></td>
			<td><%=gubun1%></td>
			<td><%=groupName%></td>
			<td><%=devlWeek%></td>
			<td><%=devlDay%></td>
			<td><%=state%></td>
			<td><%=tSellPrice%></td>
			<td><%=tCouponPrice%></td>
			<td><%=tPayPrice%></td>
			<td><%=bagPrice%></td>
			<td><%=couponName%></td>
			<td><%=shopCd%></td>
			<td>'<%=shopOrderNum%></td>
		</tr>
		<%
			}
		}
		%>
	</tbody>
</table>
<%@ include file="../lib/dbclose.jsp" %>