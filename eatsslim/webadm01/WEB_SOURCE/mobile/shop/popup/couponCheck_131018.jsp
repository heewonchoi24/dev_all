<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int tcnt			= 0;
int tcnt1			= 0;
int buyQty			= 0;
String mode			= ut.inject(request.getParameter("mode"));
String oyn			= ut.inject(request.getParameter("oyn"));
String devlType		= "";
String devlDay		= "";
String devlWeek		= "";
String devlDate		= "";
String devlPeriod	= "";
int price			= 0;
String buyBagYn		= "";
String gubun1		= "";
String gubun2		= "";
String groupCode	= "";
String groupName	= "";
String cartImg		= "";
int payPrice		= 0;
int totalPrice		= 0;
int totalPrice1		= 0;
int totalPrice2		= 0;
int totalPrice3		= 0;
int devlPrice		= 0;
int bagPrice		= 0;
int zipCnt			= 0;
String devlCheck	= "";
String cpColumns	= " C.STDATE, C.LTDATE, CM.MEMBER_ID, CM.USE_YN, CM.COUPON_NUM, C.COUPON_NAME, C.SALE_TYPE, C.SALE_PRICE";
String cpTable		= " ESL_COUPON C, ESL_COUPON_MEMBER CM";
String cpWhere		= "";
String saleType		= "";
int salePrice		= 0;
int couponPrice		= 0;
int couponId		= 0;
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT COUNT(ID) FROM ESL_CART WHERE MEMBER_ID = '"+ eslMemberId +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //총 레코드 수		
}
rs.close();

query		= "SELECT C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK, DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN, G.GUBUN1, G.GUBUN2, G.GROUP_CODE, G.GROUP_NAME, C.ID, G.CART_IMG";
query		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
query		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = '"+ eslMemberId +"' AND C.CART_TYPE = '"+ mode +"'";
if (oyn.equals("Y")) {
	query		+= " AND ORDER_YN = 'Y'";
}
query		+= " ORDER BY C.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>사용가능 쿠폰</h2>
		<div class="clear"></div>
	</div>
	<div class="contentpop">
		<h2 class="ui-title">상품별 할인쿠폰<span class="ui-icon-right"></span></h2>
		<div class="row">
			<%
			if (tcnt > 0) {
				while (rs.next()) {
					couponId	= rs.getInt("ID");
					buyQty		= rs.getInt("BUY_QTY");
					devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
					gubun1		= rs.getString("GUBUN1");
					gubun2		= rs.getString("GUBUN2");
					groupCode	= rs.getString("GROUP_CODE");
					groupName	= rs.getString("GROUP_NAME");
					if (gubun1.equals("01")) {
						devlDate	= rs.getString("WDATE");
						buyBagYn	= rs.getString("BUY_BAG_YN");
						devlDay		= rs.getString("DEVL_DAY");
						devlWeek	= rs.getString("DEVL_WEEK");
						devlPeriod	= devlWeek +"주("+ devlDay +"일)";
						price		= rs.getInt("PRICE");
						payPrice	= price * buyQty;
						totalPrice1 += payPrice;
					} else {
						devlDate	= "-";
						buyBagYn	= "N";
						devlPeriod	= "-";
						price		= rs.getInt("PRICE");
						payPrice	= price * buyQty;
						totalPrice2 += payPrice;
					}

					// 쿠폰 조건
					cpWhere				= "  WHERE C.ID = CM.COUPON_ID";
					cpWhere				+= " AND IF (";
					cpWhere				+= "		(C.USE_LIMIT_CNT > 0 AND C.USE_LIMIT_PRICE > 0),";
					cpWhere				+= "		(C.USE_LIMIT_CNT <= "+ buyQty +" AND C.USE_LIMIT_PRICE <= "+ payPrice +"),";
					cpWhere				+= "		(";
					cpWhere				+= "			IF (";
					cpWhere				+= "				C.USE_LIMIT_CNT > 0,";
					cpWhere				+= "				C.USE_LIMIT_CNT <= "+ buyQty +",";
					cpWhere				+= "				(";
					cpWhere				+= "					IF (";
					cpWhere				+= "						C.USE_LIMIT_PRICE > 0,";
					cpWhere				+= "						C.USE_LIMIT_PRICE <= "+ payPrice +",";
					cpWhere				+= "						1 = 1";
					cpWhere				+= "					)";
					cpWhere				+= "				)";
					cpWhere				+= "			)";
					cpWhere				+= "		)";
					cpWhere				+= "	)";

					// 쿠폰 개수
					query1		= "SELECT COUNT(COUPON_NUM) COUPON_CNT FROM (";
					query1		+= "	SELECT "+ cpColumns;
					query1		+= "		FROM "+ cpTable;
					query1		+=			cpWhere;
					query1		+= "		AND USE_GOODS = '01'";
					query1		+= "	UNION";
					query1		+= "	SELECT "+ cpColumns;
					query1		+= "		FROM "+ cpTable;
					query1		+=			cpWhere;
					query1		+= "		AND USE_GOODS != '01'";
					query1		+= "		AND CM.COUPON_ID IN (SELECT COUPON_ID FROM ESL_COUPON_GOODS WHERE GROUP_CODE = '"+ groupCode +"')";
					query1		+= "		) X ";
					query1		+= " WHERE DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
					query1		+= " AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
					//query1		+= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
					try {
						rs1 = stmt1.executeQuery(query1);
					} catch(Exception e) {
						out.println(e+"=>"+query1);
						if(true)return;
					}

					if (rs1.next()) {
						tcnt1		= rs1.getInt(1); //총 레코드 수		
					}
					rs1.close();

					// 쿠폰 개수
					query1		= "SELECT * FROM (";
					query1		+= "	SELECT "+ cpColumns;
					query1		+= "		FROM "+ cpTable;
					query1		+=			cpWhere;
					query1		+= "		AND USE_GOODS = '01'";
					query1		+= "	UNION";
					query1		+= "	SELECT "+ cpColumns;
					query1		+= "		FROM "+ cpTable;
					query1		+=			cpWhere;
					query1		+= "		AND USE_GOODS != '01'";
					query1		+= "		AND CM.COUPON_ID IN (SELECT COUPON_ID FROM ESL_COUPON_GOODS WHERE GROUP_CODE = '"+ groupCode +"')";
					query1		+= "		) X ";
					query1		+= " WHERE DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
					query1		+= " AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
					//query1		+= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
					try {
						rs1 = stmt1.executeQuery(query1);
					} catch(Exception e) {
						out.println(e+"=>"+query1);
						if(true)return;
					}

					if (tcnt1 > 0) {
			%>
			<input type="hidden" id="coupon_price_<%=groupCode%>" class="coupon_price" value="0" />
			<h4><%=ut.getGubun1Name(gubun1)%> <%=groupName%></h4>
			<ul>
				<li><input type="radio" id="c1" name="cc" /><label for="c1"><span></span>적용안함</label></li>
				<%
				while (rs1.next()) {
					saleType	= rs1.getString("SALE_TYPE");
					salePrice	= rs1.getInt("SALE_PRICE");

					if (saleType.equals("W")) {
						couponPrice		= salePrice;
					} else {
						couponPrice		= Integer.parseInt(String.valueOf(Math.round((double)payPrice * (double)salePrice / 100)));
					}
				%>
				<li><input type="radio" id="coupon_code_<%=groupCode%>" name="coupon_code_<%=groupCode%>" value="<%=rs1.getString("COUPON_NUM")+"|"+couponPrice+"|"+couponId%>" /><label for="c2"><span></span><%=nf.format(couponPrice)%>원 할인쿠폰</label> </li>
				<%
				}
				%>
			</ul>
			<%
					}
				}

				rs.close();

				totalPrice3		= totalPrice1 + totalPrice2;
				if (totalPrice2 > 0 && totalPrice2 < 40000) {
					devlPrice		= defaultDevlPrice;
				} else {
					devlPrice		= 0;
				}

				totalPrice		= totalPrice3 + devlPrice + bagPrice;
			}

			rs.close();
			%>
		</div>  
		<!--div class="divider"></div>
		<h2 class="ui-title">증정 무료쿠폰<span class="ui-icon-right"></span></h2>
		<div class="row">   
			<ul>
				<li><input type="radio" id="c5" name="cb" /><label for="c5"><span></span>적용안함</label></li>
				<li><input type="radio" id="c6" name="cb" /><label for="c6"><span></span>밸런스워터티 증정쿠폰</label> </li>
			</ul>
		</div-->
		<div class="row">
			<div class="grid-navi">
			<table border="0" cellpadding="0" cellspacing="10" class="navi">
			<tr>
			<td><a href="#" class="ui-btn  ui-mini ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">쿠폰적용</span></span></a></td>
			<td><a href="#" class="ui-btn  ui-mini ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">취소하기</span></span></a></td>
			</tr>
			</table>
			</div>  
		</div>
</div>
<!-- End contentpop -->
</div>
</body>
</html>