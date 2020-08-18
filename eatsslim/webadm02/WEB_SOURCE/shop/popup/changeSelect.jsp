<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderNum		= ut.inject(request.getParameter("ono"));

String table		= "ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
String query		= "";
int tcnt			= 0;
int orderCnt		= 0;
String devlType		= "";
String devlDay		= "";
String devlWeek		= "";
String devlDate		= "";
String devlPeriod	= "";
int price			= 0;
String buyBagYn		= "";
String gubun1		= "";
String groupName	= "";
String cartImg		= "";
int goodsTprice		= 0;
int orderPrice		= 0;
int payPrice		= 0;
int totalPrice		= 0;
int dayPrice		= 0;
int tagPrice		= 0;
int goodsPrice		= 0;
int devlPrice		= 0;
int bagPrice		= 0;
int couponPrice		= 0;
int zipCnt			= 0;
String devlCheck	= "";
String where		= " WHERE OG.GROUP_ID = G.ID AND O.ORDER_NUM = OG.ORDER_NUM AND OG.ORDER_NUM = '"+ orderNum +"'";
where		+= " AND DEVL_TYPE = '0002'";
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT COUNT(*) FROM "+ table +" "+ where; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //총 레코드 수		
}
rs.close();

query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.ORDER_STATE, O.DEVL_PRICE, OG.COUPON_PRICE";
query		+= " FROM "+ table +" "+ where;
query		+= " ORDER BY OG.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>교환상품 선택</title>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>교환상품 선택</h2>
		<p></p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4><span class="f18 font-blue">고객님이 선택하신 제품</span></h4>
					</div>
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th class="none">선택</th>
							<th class="none">배송구분</th>
							<th>상품명</th>
							<th>수량</th>
							<th>상품금액</th>
							<th class="last">주문상태</th>
						</tr>
						<tr>
							<td><input name="" type="checkbox" value=""></td>
							<td>택배</td>
							<td>
								<div class="orderName">
									<img class="thumbleft" src="/images/order_sample.jpg" />
									<p class="catetag">다이어트 프로그램</p>
									<h4>3식(퀴진A+퀴진B+알리까르떼 COOL)</h4>
								</div>
							</td>
							<td>1</td>
							<td>104,400원</td>
							<td><div class="font-blue">배송완료</div></td>
						</tr>
					</table>
					<p class="font-gray">*교환은 동일한 상품으로 교환이 가능합니다.</p>
					<!-- End orderList -->
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col center">
					<div class="button large dark" style="margin:0 10px;"><a class="lightbox" href="/shop/popup/changeRequest.jsp?lightbox[width]=700&lightbox[height]=550">선택상품 교환</a></div>
					<div class="button large light" style="margin:0 10px;"><a class="lightbox" href="/shop/popup/changeRequest.jsp?lightbox[width]=700&lightbox[height]=550">전체교환</a></div>
				</div>
			</div>
			<!-- End row --> 
		</div>
		<!-- End popup columns offset-by-one --> 
	</div>
	<!-- End contentpop --> 
</div>
</body>
</html>