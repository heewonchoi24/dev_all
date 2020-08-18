<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

response.setHeader("Content-Disposition", "attachment; filename=coupon_list.xls"); 
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setHeader("Content-Type", "application/vnd.ms-excel; name='excel', text/html; charset=euc-kr");
response.setContentType("text/plain;charset=euc-kr");

String table		= "";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String ctype		= ut.inject(request.getParameter("ctype"));
String schCtype		= ut.inject(request.getParameter("sch_ctype"));
String schStdate	= ut.inject(request.getParameter("sch_stdate"));
String schLtdate	= ut.inject(request.getParameter("sch_ltdate"));
String schVendor	= ut.inject(request.getParameter("sch_vendor"));
int couponId		= 0;
String couponNum	= "";
String memmberId	= "";
String memberName	= "";
String hp			= "";
String groupName	= "";
int payPrice		= 0;
int salePrice		= 0;
String useYn		= "";
String where		= "";
String vparam		= "";
String column		= "";
String couponName	= "";
String couponType	= "";
String stdate		= "";
String ltdate		= "";
String vendor		= "";
String saleType		= "";
String saleTxt		= "";
String useLimitTxt	= "";
String useGoodsTxt	= "";
int couponCnt		= 0;
int useCnt			= 0;
int useLimitCnt		= 0;
int useLimitPrice	= 0;
String useGoods		= "";
String memberId		= "";
String useDate		= "";
String param		= "";
String useYnTxt		= "";
String useOrderNum	= "";
String orderState	= "";
NumberFormat nf		= NumberFormat.getNumberInstance();

if (request.getParameter("id") != null && request.getParameter("id").length() > 0)
	couponId	= Integer.parseInt(request.getParameter("id"));

query		= "SELECT COUPON_NAME, SALE_TYPE, SALE_PRICE, USE_LIMIT_CNT, USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT,";
query		+= "	DATE_FORMAT(STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(LTDATE, '%Y.%m.%d') LTDATE";
query		+= " FROM ESL_COUPON";
query		+= " WHERE ID = "+ couponId;
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if (true) return;
}

if (rs.next()) {
	couponName			= rs.getString("COUPON_NAME");
	saleType			= (rs.getString("SALE_TYPE").equals("P"))? "%" : "원";
	salePrice			= rs.getInt("SALE_PRICE");
	useLimitCnt			= rs.getInt("USE_LIMIT_CNT");
	useLimitPrice		= rs.getInt("USE_LIMIT_PRICE");
	if (useLimitCnt > 0 && useLimitPrice > 0) {
		useLimitTxt			+= "<p>"+ nf.format(useLimitCnt) + "개 이상 구매 시 사용</p>\n";
		useLimitTxt			+= "<p>"+ nf.format(useLimitPrice) + "원 이상 구매 시 사용</p>\n";
	} else if (useLimitCnt > 0) {
		useLimitTxt			+= "<p>"+ nf.format(useLimitCnt) + "개 이상 구매 시 사용</p>\n";
	} else  if (useLimitPrice > 0) {
		useLimitTxt			+= "<p>"+ nf.format(useLimitPrice) + "원 이상 구매 시 사용</p>\n";
	} else {
		useLimitTxt			= "";
	}
	useGoods			= rs.getString("USE_GOODS");
	if (useGoods.equals("01")) {
		useGoodsTxt			= "<p>전체 상품에 사용 가능</p>\n";
	} else if (useGoods.equals("03")) {
		useGoodsTxt			= "<p>일배상품 주문시 사용 가능</p>\n";
	} else if (useGoods.equals("03")) {
		useGoodsTxt			= "<p>택배상품 주문시 사용 가능</p>\n";
	} else {
		query1		= "SELECT GROUP_NAME FROM ESL_COUPON_GOODS WHERE COUPON_ID = "+ couponId;
		try {
			rs1 = stmt1.executeQuery(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}

		while (rs1.next()) {
			useGoodsTxt		+= "<p>"+ rs1.getString("GROUP_NAME") + " 주문시 사용 가능</p>\n";
		}
	}
	stdate				= rs.getString("STDATE");
	ltdate				= rs.getString("LTDATE");
	if (ctype.equals("01")) {
		query1		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER WHERE COUPON_ID = "+ couponId;
		try {
			rs1			= stmt1.executeQuery(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}

		if (rs1.next()) {
			couponCnt	= rs1.getInt(1);
		}
		rs1.close();
	} else {
		couponCnt	= rs.getInt("MAX_COUPON_CNT");
	}

	query1		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
	query1		+= " WHERE COUPON_ID = "+ couponId +" AND USE_YN = 'Y'";
	try {
		rs1			= stmt1.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	if (rs1.next()) {
		useCnt		= rs1.getInt(1);
	}
	rs1.close();
}	

where			= " WHERE CR.COUPON_ID = "+ couponId;
where			+= " AND C.ID = CR.COUPON_ID";
if (ctype.equals("01")) {
	table			= "ESL_COUPON C, ESL_COUPON_MEMBER CR";
	column			= "CR.ID, CR.COUPON_NUM, CR.MEMBER_ID, CR.USE_YN, CR.USE_ORDER_NUM, DATE_FORMAT(CR.USE_DATE, '%Y.%m.%d') USE_DATE";
} else {
	table			= "ESL_COUPON C, ESL_COUPON_RANDNUM CR";
	column			= "CR.ID, CR.RAND_NUM AS COUPON_NUM, CR.USE_YN";
}

query		= "SELECT "+ column;
query		+= " FROM "+ table + where;
query		+= " ORDER BY ID DESC"; //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
</head>
<body>
<table border="1" cellspacing="0">
	<tbody>
		<tr>
			<th scope="row">
				<span>쿠폰명</span>
			</th>
			<td colspan="8"><%=couponName%></td>
		</tr>
		<tr>
			<th scope="row">
				<span>구분</span>
			</th>
			<td colspan="4"><%=ut.getCouponType(ctype)%></td>
			<th scope="row">
				<span>사용기간</span>
			</th>
			<td colspan="3"><%=stdate+"~"+ltdate%></td>
		</tr>
		<tr>
			<th scope="row">
				<span>쿠폰할인금액</span>
			</th>
			<td colspan="4">상품판매가격의 <%=nf.format(salePrice)%><%=saleType%> 할인</td>
			<th scope="row">
				<span>사용제한</span>
			</th>
			<td colspan="3"><%=useLimitTxt%></td>
		</tr>
		<tr>
			<th scope="row">
				<span>사용가능상품설정</span>
			</th>
			<td colspan="4"><%=useGoodsTxt%></td>
			<th scope="row">
				<span>발급/사용</span>
			</th>
			<td colspan="3"><%=couponCnt+"건/"+useCnt+"건"%></td>
		</tr>
	</tbody>
</table>
<table border="0" cellspacing="0">
	<tr>
		<th scope="row">&nbsp;</th>
		<td colspan="7">&nbsp;</td>
	</tr>
</table>
<table border="1" cellspacing="0">
	<tbody>
		<tr>
			<th scope="col"><span>쿠폰번호</span></th>
			<th scope="col"><span>발급받은회원</span></th>
			<th scope="col"><span>연락처</span></th>
			<th scope="col"><span>구매상품</span></th>
			<th scope="col"><span>주문상태</span></th>
			<th scope="col"><span>상품구매금액</span></th>
			<th scope="col"><span>할인금액</span></th>
			<th scope="col"><span>사용여부</span></th>
			<th scope="col"><span>사용일</span></th>
		</tr>
		<%
		while (rs.next()) {
			couponNum	= rs.getString("COUPON_NUM");
			useYn		= rs.getString("USE_YN");
			if (ctype.equals("01")) {
				memberId	= rs.getString("MEMBER_ID");
				useDate		= ut.isnull(rs.getString("USE_DATE"));
				useOrderNum	= rs.getString("USE_ORDER_NUM");
				query1		= "SELECT MEM_NAME, HP FROM ESL_MEMBER WHERE MEM_ID = '"+ memberId +"'";
				try {
					rs1		= stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs1.next()) {
					memberName	= rs1.getString("MEM_NAME");
					hp			= rs1.getString("HP");
				} else {
					memberId	= "";
					memberName	= "";
					hp			= "";
				}
			} else {
				query1		= "SELECT MEMBER_ID, USE_ORDER_NUM, DATE_FORMAT(USE_DATE, '%Y-%m-%d %H:%m') USE_DATE, USE_YN";
				query1		+= " FROM ESL_COUPON_MEMBER";
				query1		+= " WHERE COUPON_NUM = '"+ couponNum +"'";
				try {
					rs1		= stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs1.next()) {
					memberId	= rs1.getString("MEMBER_ID");
					useDate		= ut.isnull(rs1.getString("USE_DATE"));
					useOrderNum	= rs1.getString("USE_ORDER_NUM");
					useYn		= rs1.getString("USE_YN");
				} else {
					memberId	= "";
				}
				rs1.close();

				if (!memberId.equals("")) {
					query1		= "SELECT MEM_NAME FROM ESL_MEMBER WHERE MEM_ID = '"+ memberId +"'";
					try {
						rs1		= stmt1.executeQuery(query1);
					} catch(Exception e) {
						out.println(e+"=>"+query);
						if(true)return;
					}

					if (rs1.next()) {
						memberName	= rs1.getString("MEM_NAME");
					} else {
						memberName	= "";
					}
				} else {
					memberName	= "";
				}
			}

			if (useYn.equals("Y")) {
				useYnTxt	= "사용";
			} else if (useYn.equals("C")) {
				useYnTxt	= "사용중지";
			} else if (useYn.equals("N")) {
				useYnTxt	= "미사용";
			}

			if (useYn.equals("Y")) {
				query1		= "SELECT G.GROUP_NAME, O.PAY_PRICE, O.COUPON_PRICE, O.ORDER_STATE";
				query1		+= " FROM ESL_ORDER O, ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G";
				query1		+= " WHERE O.ORDER_NUM = OG.ORDER_NUM AND OG.GROUP_ID = G.ID";
				query1		+= " AND OG.ORDER_NUM = '"+ useOrderNum +"'";
				query1		+= " AND O.MEMBER_ID = '"+ memberId +"'";
				
				try {
					rs1		= stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				i		= 0;
				while (rs1.next()) {
					if (i > 0) {
						groupName	= rs1.getString("GROUP_NAME")+" 외 "+ i +"건";
					} else {
						groupName	= rs1.getString("GROUP_NAME");
					}
					payPrice		= rs1.getInt("PAY_PRICE");
					salePrice		= rs1.getInt("COUPON_PRICE");
					orderState		= rs1.getString("ORDER_STATE");
					orderState		= ut.getOrderState(orderState);
					i++;
				}
			} else {
				groupName	= "";
				payPrice	= 0;
				salePrice	= 0;
				useDate		= "";
				orderState	= "";
			}
		%>
		<tr>
			<td><%=couponNum%></td>
			<td><%=memberName+"("+memberId+")"%></td>
			<td><%=hp%></td>
			<td><%=groupName%></td>
			<td><%=orderState%></td>
			<td><%=nf.format(payPrice)%></td>
			<td><%=nf.format(salePrice)%></td>
			<td><%=useYnTxt%></td>
			<td><%=useDate%></td>
		</tr>
		<%
		}
		%>
	</tbody>
</table>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>