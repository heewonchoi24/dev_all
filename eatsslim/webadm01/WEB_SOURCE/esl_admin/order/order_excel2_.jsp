<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

//response.setHeader("Content-Disposition", "attachment; filename=order_list.xls"); 
//response.setHeader("Content-Description", "JSP Generated Data"); 
//response.setHeader("Content-Type", "application/vnd.ms-excel; name='excel', text/html; charset=euc-kr");
//response.setContentType("text/plain;charset=euc-kr");

String table		= "ESL_ORDER_DEVL_DATE OD";
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
String agencyid		= "";
String orderName	= "";
String hp			= "";
String zipcode		= "";
String addr1		= "";
String addr2		= "";
String where		= "";
String couponNum	= "";
String couponName	= "";
String shopCd		= "";
String shopOrderNum	= "";
String stateTxt		= "";

if (etype.equals("3")) {
	where		= " WHERE STATE = '91'";
} else {
	where		= " WHERE STATE < 90";
}
if (stdate != null && stdate.length() > 0) {
	if (etype.equals("1") || etype.equals("3")) {
		where		+= " AND ORDER_DATE >= '"+ stdate +"'";
	} else {
		where		+= " AND DATE_FORMAT(OD.DEVL_DATE, '%Y%m%d') >= '"+ stdate +"'";
	}
}

if (ltdate != null && ltdate.length() > 0) {
	if (etype.equals("1") || etype.equals("3")) {
		where		+= " AND ORDER_DATE <= '"+ ltdate +"'";
	} else {
		where		+= " AND DATE_FORMAT(OD.DEVL_DATE, '%Y%m%d') <= '"+ ltdate +"'";
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
query		= "SELECT COUNT(OD.ID) FROM "+ table + where;
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

query		= "SELECT OD.*, (SELECT DISTINCT COUPON_NUM FROM ESL_ORDER_GOODS OG WHERE OG.ORDER_NUM = OD.ORDER_NUM AND OG.ID = OD.GOODS_ID) AS COUPON_NUM FROM "+ table + where + " ORDER BY GOODS_ID, DEVL_DATE";
out.println(query);
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
			<th scope="col"><span>구분</span></th>
			<th scope="col"><span>코드</span></th>
			<th scope="col"><span>주문상품</span></th>
			<th scope="col"><span>주문일</span></th>
			<th scope="col"><span>고객수령일</span></th>
			<th scope="col"><span>배송수량</span></th>
			<th scope="col"><span>매출/증정구분</span></th>
			<th scope="col"><span>상품금액</span></th>
			<th scope="col"><span>쿠폰금액</span></th>
			<th scope="col"><span>결제금액</span></th>
			<th scope="col"><span>보냉가방금액</span></th>
			<th scope="col"><span>위탁점코드</span></th>
			<th scope="col"><span>고객명</span></th>
			<th scope="col"><span>핸드폰</span></th>
			<th scope="col"><span>우편번호</span></th>
			<th scope="col"><span>기본주소</span></th>
			<th scope="col"><span>상세주소</span></th>
			<th scope="col"><span>쿠폰명</span></th>
			<th scope="col"><span>유입경로</span></th>
			<th scope="col"><span>외부몰주문번호</span></th>
		</tr>
		<%
		if (totalCnt > 0) {
			while (rs.next()) {
				orderNum		= rs.getString("ORDER_NUM");
				orderSub		= rs.getString("GOODS_ID");
				gubunCode		= rs.getString("GUBUN_CODE");
				groupCode		= rs.getString("GROUP_CODE");
				shopOrderNum	= rs.getString("SHOP_ORDER_NUM");
				gubun1			= gubunCode.substring(0, 2);
				gubun2			= gubunCode.substring(2, 4);
				gubun3			= "";
				if (gubun1.equals("02")) {
					gubun3			= gubunCode.substring(5, 5);
					gubun3			= gubun3 + "주";
				}
				groupName		= "";
				if (groupCode.equals("0300668")) {
					gubun1		= "보냉가방";
					gubun2		= "";
					groupName	= "보냉가방";
				} else {
					query1			= "SELECT GROUP_NAME FROM ESL_GOODS_GROUP ";
					if (gubun1.equals("02") || (gubun1.equals("03") && gubun2.equals("31"))) {
						query1			+= " WHERE GROUP_CODE = '"+ gubunCode +"'";
					} else {
						query1			+= " WHERE GROUP_CODE = '"+ groupCode +"'";
					}
					try {
						rs1	= stmt1.executeQuery(query1);
					} catch(Exception e) {
						out.println(e+"=>"+query1);
						if(true)return;
					}

					if (rs1.next()) {
						groupName		= rs1.getString("GROUP_NAME");
					}

					gubun1			= ut.getGubun1Name(gubun1);
					gubun2			= ut.getGubun2Name(gubun2);
				}
				orderDate		= rs.getString("ORDER_DATE");
				devlDate		= rs.getString("DEVL_DATE");
				orderCnt		= rs.getInt("ORDER_CNT");
				price			= rs.getFloat("PRICE");
				payPrice		= 0;
				couponPrice		= 0;
				tOrderCnt		= 0;
				bagPrice		= 0;
				tSellPrice		= 0;
				tCouponPrice	= 0;
				tPayPrice		= 0;
				state			= rs.getString("STATE");
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

				if (groupCode.equals("0300668")) {
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
				}

				tSellPrice		= (int)price * orderCnt;
				tCouponPrice	= (groupCode.equals("0300668") || state.equals("02") || tSellPrice == 0)? 0 : (int)couponPrice * orderCnt;
				tPayPrice		= (groupCode.equals("0300668"))? defaultBagPrice * orderCnt : (state.equals("02") || tSellPrice == 0)? 0 : (int)payPrice * orderCnt;
				if (tPayPrice == 2147483647) {
					tPayPrice		= 0;
				}
				if (etype.equals("1") || etype.equals("2")) {
					stateTxt		= (state.equals("02") || tSellPrice == 0)? "증정" : "매출";
				} else {
					stateTxt		= (state.equals("02") || tSellPrice == 0)? "증정취소" : "매출취소";
				}
				agencyid		= rs.getString("AGENCYID");
				orderName		= rs.getString("ORDER_NAME");
				hp				= rs.getString("RCV_HP");
				zipcode			= rs.getString("RCV_ZIPCODE");
				addr1			= rs.getString("RCV_ADDR1");
				addr2			= rs.getString("RCV_ADDR2");

				couponNum		= rs.getString("COUPON_NUM");
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
			<td><%=gubun1+gubun2+gubun3%></td>
			<td><%=groupCode%></td>
			<td><%=groupName%></td>
			<td><%=orderDate%></td>
			<td><%=devlDate%></td>
			<td><%=orderCnt%></td>
			<td><%=stateTxt%></td>
			<td><%=tSellPrice%></td>
			<td><%=tCouponPrice%></td>
			<td><%=tPayPrice%></td>
			<td><%=bagPrice%></td>
			<td><%=agencyid%></td>
			<td><%=orderName%></td>
			<td><%=hp%></td>
			<td><%=zipcode%></td>
			<td><%=addr1%></td>
			<td><%=addr2%></td>
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