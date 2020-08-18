<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_bm.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String cpColumns	= " C.STDATE, C.LTDATE, CM.MEMBER_ID, CM.USE_YN, CM.COUPON_NUM, C.COUPON_NAME";
String cpTable		= " ESL_COUPON C, ESL_COUPON_MEMBER CM";
String cpWhere		= "";
String mode			= ut.inject(request.getParameter("mode"));
System.out.println("mode : "+mode);
String oyn			= ut.inject(request.getParameter("oyn"));
int tcnt			= 0;
int buyQty			= 0;
int groupId			= 0;
String devlType		= "";
String devlDay		= "";
String devlWeek		= "";
String devlDate		= "";
String devlPeriod	= "";
int price			= 0;
String buyBagYn		= "";
String gubun1		= "";
String gubun2		= "";
String groupName	= "";
String groupCode	= "";
String cartImg		= "";
int goodsTprice		= 0;
int orderPrice		= 0;
/* int payPrice		= 0; */
int totalPrice		= 0;
int dayPrice		= 0;
int tagPrice		= 0;
int tagPrice1		= 0;
int tagPrice2		= 0;
int tagPrice3		= 0;
int goodsPrice		= 0;
//int devlPrice		= 0;
int devlPrice1		= 0;
int devlPrice2		= 0;
int devlPrice3		= 0;
int bagPrice		= 0;
int zipCnt			= 0;
String devlCheck	= "";
String recentDevlCheck	= "";
int couponCnt		= 0;
String pgCloseDate	= "20991231240000";
String pgCloseDtTmp	= "20991231240000";
int devlFirstDay		= 0;

SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
//String orderNum		= "ESS" + dt.format(new Date()) + "001";
String orderNum		= "ESS" + dt.format(new Date()) + ut.randomNumber(3);
SimpleDateFormat cdt	= new SimpleDateFormat("yyyyMMdd");
Date date			= null;

SimpleDateFormat dt2	= new SimpleDateFormat("yyyyMMdd150000");
SimpleDateFormat dt3	= new SimpleDateFormat("yyyyMMdd120000");
SimpleDateFormat cdt2	= new SimpleDateFormat("yyyy.MM.dd");
/*
// 시간이 겹칠경우 넘버 증가 값 처리 필요 2013-09-30
try {
	query		= "SELECT COUNT(ID) TCNT FROM ESL_ORDER WHERE SUBSTR(ORDER_NUM, 1, 17) = '"+ orderNum +"'";
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
*/

String memName			= "";
String memEmail			= "";
String memTel			= "";
String memTel1			= "";
String memTel2			= "";
String memTel3			= "";
String memHp			= "";
String memHp1			= "";
String memHp2			= "";
String memHp3			= "";
String memZipcode		= "";
String memAddr1			= "";
String memAddr2			= "";
String memAddrBCode		= "";
String[] tmp			= new String[]{};
NumberFormat nf = NumberFormat.getNumberInstance();
String productName		= "";

query		= "SELECT MEM_NAME, EMAIL, ZIPCODE, ADDRESS, ADDRESS_DETAIL, ADDRESS_BUILDINGCODE, HP, TEL FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"'";
try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	memName		= rs.getString("MEM_NAME");
	memEmail	= rs.getString("EMAIL");
	memTel		= rs.getString("TEL");
	if (memTel != null && memTel.length()>10) {
		tmp			= memTel.split("-");
		memTel1		= tmp[0];
		memTel2		= tmp[1];
		memTel3		= tmp[2];
	}
	memHp		= rs.getString("HP");
	if (memHp != null && memHp.length()>10) {
		tmp			= memHp.split("-");
		memHp1		= tmp[0];
		memHp2		= tmp[1];
		memHp3		= tmp[2];
	}
	memZipcode	= rs.getString("ZIPCODE");
	memAddr1	= ut.isnull(rs.getString("ADDRESS"));
	memAddr2	= ut.isnull(rs.getString("ADDRESS_DETAIL"));
	memAddrBCode= ut.isnull(rs.getString("ADDRESS_BUILDINGCODE"));
}
rs.close();

String rcvName		= "";
String rcvZipcode	= "";
String rcvAddr1		= "";
String rcvAddr2		= "";
String rcvBuildingNo	= "";
String rcvHp		= "";
String rcvHp1		= "";
String rcvHp2		= "";
String rcvHp3		= "";
String rcvTel		= "";
String rcvTel1		= "";
String rcvTel2		= "";
String rcvTel3		= "";
String tagName		= "";
String tagZipcode	= "";
String tagAddr1		= "";
String tagAddr2		= "";
String tagHp		= "";
String tagHp1		= "";
String tagHp2		= "";
String tagHp3		= "";
String tagTel		= "";
String tagTel1		= "";
String tagTel2		= "";
String tagTel3		= "";
String imgUrl		= "";
String rcvPartner			= "";

query		= "SELECT RCV_NAME, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_HP, RCV_TEL, ifnull(RCV_BUILDINGNO, '') AS RCV_BUILDINGNO,";
query		+= "	TAG_NAME, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_HP, TAG_TEL";
query		+= " FROM ESL_ORDER WHERE MEMBER_ID = '"+ eslMemberId +"' ORDER BY ID DESC LIMIT 1";
try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	rcvName		= rs.getString("RCV_NAME");
	rcvTel		= rs.getString("RCV_TEL");
	if (rcvTel != null && rcvTel.length()>10) {
		tmp			= rcvTel.split("-");
		rcvTel1		= tmp[0];
		rcvTel2		= tmp[1];
		rcvTel3		= tmp[2];
	}
	rcvHp		= rs.getString("RCV_HP");
	if (rcvHp != null && rcvHp.length()>10) {
		tmp			= rcvHp.split("-");
		rcvHp1		= tmp[0];
		rcvHp2		= tmp[1];
		rcvHp3		= tmp[2];
	}
	rcvZipcode	= rs.getString("RCV_ZIPCODE");
	rcvAddr1	= rs.getString("RCV_ADDR1");
	rcvAddr2	= rs.getString("RCV_ADDR2");
	rcvBuildingNo	= rs.getString("RCV_BUILDINGNO");
	tagName		= rs.getString("RCV_NAME");
	tagTel		= rs.getString("RCV_TEL");
	if (tagTel != null && tagTel.length()>10) {
		tmp			= tagTel.split("-");
		tagTel1		= tmp[0];
		tagTel2		= tmp[1];
		tagTel3		= tmp[2];
	}
	tagHp		= rs.getString("RCV_HP");
	if (tagHp != null && tagHp.length()>10) {
		tmp			= tagHp.split("-");
		tagHp1		= tmp[0];
		tagHp2		= tmp[1];
		tagHp3		= tmp[2];
	}
	tagZipcode	= rs.getString("RCV_ZIPCODE");
	tagAddr1	= rs.getString("RCV_ADDR1");
	tagAddr2	= rs.getString("RCV_ADDR2");
}
rs.close();

int cartCt						= 0; //-- 장바구니 전체수
int cartType1TotalPrice			= 0; //-- 일일배송 상품합계
int cartType2TotalPrice			= 0; //-- 택배배송 상품합계
int cartType1Ct					= 0; //-- 일일배송 상품수
int cartType2Ct					= 0; //-- 택배배송 상품수
int cartTotalPrice				= 0; //-- 전체상품합계
int devlPrice					= 0; //-- 배송비
int cartTotalAmount				= 0; //-- 결제예정금액

//-- 일일배송
query		= "SELECT COUNT(ID) AS CT,IFNULL(SUM(PRICE),0) AS TOTAL_PRICE FROM ESL_CART WHERE DEVL_TYPE = '0001' AND CART_TYPE = '" + mode + "' AND MEMBER_ID = ? ";
if (oyn.equals("Y")) {
	query		+= " AND ORDER_YN = 'Y'";
}
pstmt		= conn.prepareStatement(query);
pstmt.setString(1, eslMemberId);
rs		= pstmt.executeQuery();
if(rs.next()){
	cartType1Ct				 = rs.getInt("CT");
	cartType1TotalPrice		 = rs.getInt("TOTAL_PRICE");
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

//-- 택배배송
query		= "SELECT COUNT(ID) AS CT,IFNULL(SUM(PRICE),0) AS TOTAL_PRICE FROM ESL_CART WHERE DEVL_TYPE = '0002' AND CART_TYPE = '" + mode + "' AND MEMBER_ID = ? ";
if (oyn.equals("Y")) {
	query		+= " AND ORDER_YN = 'Y'";
}
pstmt		= conn.prepareStatement(query);
pstmt.setString(1, eslMemberId);
rs		= pstmt.executeQuery();
if(rs.next()){
	cartType2Ct				 = rs.getInt("CT");
	cartType2TotalPrice		 = rs.getInt("TOTAL_PRICE");
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

//-- 전체 장바구니수
cartCt = cartType1Ct + cartType2Ct;

//-- 상품합계금액
cartTotalPrice = cartType1TotalPrice + cartType2TotalPrice;

//-- 배송비
/* 전체 무료 배송 설정
if(cartCt > 0 && cartTotalPrice < 40000){
	devlPrice = defaultDevlPrice;
}
*/

//-- 총 결제금액
cartTotalAmount = cartTotalPrice + devlPrice;

query		= "SELECT C.GROUP_ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK, DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN, G.GUBUN1, G.GUBUN2, G.GROUP_CODE, G.GROUP_NAME, G.CART_IMG, G.GROUP_IMGM, G.DEVL_FIRST_DAY";
query		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
query		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = '"+ eslMemberId +"' AND C.CART_TYPE = '"+ mode +"'";
System.out.println("mode");
if (oyn.equals("Y")) {
	query		+= " AND ORDER_YN = 'Y'";
}
query		+= " ORDER BY C.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>
	<!-- <script type="text/javascript" src="/common/js/common.js"></script> -->
	<script type="text/javascript" src="/common/js/util.js"></script>
	<script type="text/javascript" src="/common/js/order.js"></script>

<script type="text/javascript">
_TRK_PI="ODF";
</script>
</head>
<body>
<form name="frmOrder" method="post">
<input type="hidden" name="name" value="<%=memName%>" />
<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content" class="oldClass">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">주문결제</span></span></h1>
		<div class="row" id="shopOrder">
			<div class="orderBox">
				<h1 class="tit">주문리스트 확인</h1>
				<ul class="cartList">
<%
if (cartCt > 0) {
	int i = 0;
	while (rs.next()) {
		groupId		= rs.getInt("GROUP_ID");
		buyQty		= rs.getInt("BUY_QTY");
		devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
		gubun1		= rs.getString("GUBUN1");
		gubun2		= rs.getString("GUBUN2");
		groupName	= rs.getString("GROUP_NAME");
		groupCode	= rs.getString("GROUP_CODE");
		if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
			devlDate	= rs.getString("WDATE");
			buyBagYn	= rs.getString("BUY_BAG_YN");
			devlDay		= rs.getString("DEVL_DAY");
			devlWeek	= rs.getString("DEVL_WEEK");
			devlFirstDay	= rs.getInt("DEVL_FIRST_DAY");
			
			if (gubun2.equals("26")) {
				devlPeriod	= "3일";
			} else {
				devlPeriod	= devlWeek +"주("+ devlDay +"일)";
			}
			price		= rs.getInt("PRICE");
			if (buyBagYn.equals("Y")) {
				price -= defaultBagPrice;
			}
//						goodsPrice	= price * buyQty;
			goodsPrice	= price;
			price = (price / buyQty);

			date			= cdt2.parse(devlDate);
			Calendar cal	= Calendar.getInstance();
			cal.setTime(date);
			/*
			if ( groupId == 89 ) {
				cal.add(Calendar.DATE, -2);
				pgCloseDtTmp	= dt2.format(cal.getTime());
			} else if ( groupId == 32 || groupId == 40 || groupId == 69 || groupId == 92 || groupId == 110 ) {
				cal.add(Calendar.DATE, -3);
				pgCloseDtTmp	= dt3.format(cal.getTime());
			} else {
				cal.add(Calendar.DATE, -5);
				pgCloseDtTmp	= dt3.format(cal.getTime());
			}
			*/
			
			cal.add(Calendar.DATE, -devlFirstDay);
			pgCloseDtTmp	= dt2.format(cal.getTime());			

			//System.out.println("pgCloseDtTmp : "+pgCloseDtTmp);
			//System.out.println("pgCloseDate : "+pgCloseDate);
			if ( Integer.parseInt(pgCloseDtTmp.substring(0, 10)) < Integer.parseInt(pgCloseDate.substring(0, 10)) ) {
				pgCloseDate = pgCloseDtTmp;
			}
		} else {
			devlDate	= "-";
			buyBagYn	= "N";
			devlPeriod	= "-";
			price		= rs.getInt("PRICE");
			goodsPrice	= price;
			price = (price / buyQty);
		}
		cartImg		= rs.getString("GROUP_IMGM");
		if (cartImg.equals("") || cartImg == null) {
			imgUrl		= "/images/order_sample.jpg";
		} else {
			imgUrl		= webUploadDir +"goods/"+ cartImg;
		}
		if (i == 0) productName		= groupName;
		if (i > 0) {
			productName		+= groupName +" 외 "+ String.valueOf(i) +"건";
		}

		// 쿠폰 조건
		cpWhere				= "  WHERE C.ID = CM.COUPON_ID";
		cpWhere				+= " AND IF (";
		cpWhere				+= "		(C.USE_LIMIT_CNT > 0 AND C.USE_LIMIT_PRICE > 0),";
		cpWhere				+= "		(C.USE_LIMIT_CNT <= "+ buyQty +" AND C.USE_LIMIT_PRICE <= "+ goodsPrice +"),";
		cpWhere				+= "		(";
		cpWhere				+= "			IF (";
		cpWhere				+= "				C.USE_LIMIT_CNT > 0,";
		cpWhere				+= "				C.USE_LIMIT_CNT <= "+ buyQty +",";
		cpWhere				+= "				(";
		cpWhere				+= "					IF (";
		cpWhere				+= "						C.USE_LIMIT_PRICE > 0,";
		cpWhere				+= "						C.USE_LIMIT_PRICE <= "+ goodsPrice +",";
		cpWhere				+= "						1 = 1";
		cpWhere				+= "					)";
		cpWhere				+= "				)";
		cpWhere				+= "			)";
		cpWhere				+= "		)";
		cpWhere				+= "	)";
		cpWhere				+= " AND DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN C.STDATE AND C.LTDATE";
		cpWhere				+= " AND CM.MEMBER_ID = '"+ eslMemberId +"' AND CM.USE_YN = 'N'";

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
		query1		+= "		AND CM.COUPON_ID IN (SELECT COUPON_ID FROM ESL_COUPON_GOODS WHERE GROUP_CODE IN ("+ groupCode +"))";
		query1		+= "		) X ";
		//query1		+= " WHERE DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
		//query1		+= " AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
		try {
			rs1 = stmt1.executeQuery(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}

		if (rs1.next()) {
			couponCnt		+= rs1.getInt("COUPON_CNT");
		}

		rs1.close();
%>
					<li>
						<div class="inner">
							<div class="cartTop">
								<input type="hidden" name="group_code" value="<%=groupCode%>" />
								<input type="hidden" name="coupon_price" id="coupon_fprice_<%=groupCode%>" class="fprice" value="0" />
								<input type="hidden" name="coupon_num" id="coupon_fnum_<%=groupCode%>" class="fnum" />
								<p class="cate"><%=ut.getGubun1Name(gubun1)%></p>
								<p class="name"><%=groupName%></p>
							</div>
							<div class="cartBody">
								<div class="photo"><img src="<%=imgUrl%>"></div>
								<div class="info">
<% if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) { %>
									<p>식사기간 : <span><%=devlPeriod%></span></p>
									<p>첫 배송일 : <span><%=devlDate%></span></p>
<% } %>
									<p>수량 : <span><%=buyQty%></span></p>
								</div>
							</div>
							<div class="cartbottom">
								<div class="price"><!-- <span>80,000원</span>  --><%=nf.format(goodsPrice)%>원</div>
							</div>
						</div>
<%
		if (buyBagYn.equals("Y")) {
			bagPrice	+= defaultBagPrice;
%>
						<div class="buyBag">
							<div class="bagTit">보냉가방<span>(수량:<strong>1</strong>)</span></div>
							<div class="bagPrice"><%=nf.format(defaultBagPrice)%>원</div>
						</div>
<%
		}
%>
					</li>
<%
	i++;
}

rs.close();

if (cartType1TotalPrice > 0) {

	if (!rcvBuildingNo.equals("") && rcvBuildingNo != null) {
		query		= "SELECT JISA_CD FROM CM_ZIP_NEW_M WHERE GM_NO= '"+ rcvBuildingNo +"' AND ROWNUM = 1 ";
		try {
			rs_bm		= stmt_bm.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs_bm.next()) {
			rcvPartner		= rs_bm.getString("JISA_CD");
		}
		rs_bm.close();

		if (rcvPartner == null || rcvPartner.equals("") ) {
			devlCheck		= "N";
		} else {
			devlCheck		= "Y";
		}

	} else {

		query		= "SELECT JISA_CD FROM CM_ZIP_NEW_M WHERE (ZIP= '"+ memZipcode +"' OR POST = '"+ memZipcode +"')  AND JISA_CD IS NOT NULL AND ROWNUM = 1 ";
		try {
			rs_bm		= stmt_bm.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs_bm.next()) {
			rcvPartner		= rs_bm.getString("JISA_CD");
		}
		rs_bm.close();

		if (rcvPartner == null || rcvPartner.equals("") ) {
			devlCheck		= "N";
		} else {
			devlCheck		= "Y";
		}

	}



	/*
	// 배송 가능 지역 확인
	//query		= "SELECT COUNT(SEQNO) FROM PHIBABY.V_ZIPCODE_OLD_5 WHERE ZIPCODE = '"+ memZipcode +"' AND DLVPTNCD = '01' AND DLVYN = 'Y' AND DLVTYPE = '0001'";
	query		= "SELECT COUNT(*) FROM CM_ZIP_NEW_M WHERE (ZIP = '"+ memZipcode +"' OR POST = '"+ memZipcode +"') AND DELIVERY_YN = 'Y' AND SATURDAY_YN = 'Y' ";

	rs_bm		= stmt_bm.executeQuery(query);

	if (rs_bm.next()) {
		zipCnt		= rs_bm.getInt(1);
	}

	rs_bm.close();

	if (zipCnt < 1) {
		devlCheck		= "N";
	} else {
		devlCheck		= "Y";
	}
	*/

	// 최근 배송지 체크
	query		= "SELECT COUNT(*) FROM CM_ZIP_NEW_M WHERE (ZIP = '"+ rcvZipcode +"' OR POST = '"+ rcvZipcode +"') AND DELIVERY_YN = 'Y' AND SATURDAY_YN = 'Y' ";
	rs_bm		= stmt_bm.executeQuery(query);

	if (rs_bm.next()) {
		zipCnt		= rs_bm.getInt(1);
	}

	rs_bm.close();

	if (zipCnt < 1) {
		recentDevlCheck		= "N";
	} else {
		recentDevlCheck		= "Y";
	}
}

//orderPrice		= cartType1TotalPrice + cartType2TotalPrice + cartType1TotalBagPrice;
//goodsTprice		= cartType1TotalPrice + cartType2TotalPrice;
//devlPrice		= devlPrice + devlPrice1 + devlPrice2 + devlPrice3;


if (cartType2TotalPrice > 0) {
	Calendar cal		= Calendar.getInstance();
	cal.setTime(new Date()); //오늘
	cal.add(Calendar.DATE, 1);
	pgCloseDtTmp		= cdt.format(cal.getTime()) + "120000";

	if ( Integer.parseInt(pgCloseDtTmp.substring(0, 10)) < Integer.parseInt(pgCloseDate.substring(0, 10)) ) {
		pgCloseDate = pgCloseDtTmp;
	}
} /*else {
	query	= "SELECT MIN(DATE_FORMAT(DEVL_DATE, '%Y%m%d')) DEVL_DATE FROM ESL_CART ";
	query	+= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND CART_TYPE = '"+ mode +"'";
	try {
		rs = stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		devlDate		= rs.getString("DEVL_DATE");
		date			= cdt.parse(devlDate);
		Calendar cal	= Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, -3);
		pgCloseDate		= cdt.format(cal.getTime()) + "120000";
	}
} */
}

rs.close();
%>
					</ul>
				</ul>
			</div>

			<div class="orderBox">
				<h1 class="tit">할인혜택</h1>
				<div class="boxTable">
					<table>
						<tbody>
							<tr>
								<th>쿠폰등록</th>
								<td>
									<div class="ipt_group">
								    	<input type="text" class="ipt" name="off_coupon_num" id="off_coupon_num" maxlength="20" />
								    	<span class="ipt_right"><button type="button" class="btn btn_gray square" onclick="setCoupon();">등록</button></span>
								    </div>
								    <p class="em">오프라인 쿠폰을 발급받으신 분은 이곳에서 쿠폰을 등록한 다음 사용하세요.<p>
								</td>
							</tr>
							<tr>
								<th>쿠폰할인</th>
								<td>
									<div class="ipt_group">
								    	<input type="text" class="ipt" name="coupon_price_txt" id="coupon_price_txt" readonly="">
								    	<span class="ipt_right">
								    		<%if (couponCnt > 0) {%>
											<!-- <button type="button" class="btn btn_gray square" onclick="showCoupons();">조회 및 적용</button> -->
											<a href="/mobile/shop/popup/couponCheck.jsp?&mode=<%=mode%>&oyn=<%=oyn%>" type="button" class="btn btn_gray square iframe cboxElement">조회 및 적용</a>
											<%} else {%>
											<button type="button" class="btn btn_gray square" onclick="alert('적용가능한 쿠폰이 없습니다.');">조회 및 적용</button>
											<%}%>
								    	</span>
								    </div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									사용가능쿠폰 <span><%=couponCnt%></span>장
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			<div class="orderBox totalPriceArea">
				<h1 class="tit">주문리스트 확인</h1>
				<input type="hidden" id="goodsPrice" value="<%=(cartTotalPrice - bagPrice)%>" />
				<input type="hidden" id="devlPrice" value="<%=devlPrice%>" />
				<input type="hidden" id="bagPrice" value="<%=bagPrice%>" />
				<div class="totalPriceTable">
					<table>
						<colgroup>
							<col>
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th>총 상품금액</th>
								<td><span><%=nf.format(cartTotalPrice - bagPrice)%></span> 원</td>
							</tr>
							<!--tr>
								<th>보냉가방</th>
								<td>(+) <span><%=nf.format(bagPrice)%></span> 원</td>
							</tr-->
							<tr>
								<th>할인혜택</th>
								<td>(-) <span id="coupon_fprice_txt">0</span> 원</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="totalPrice">
					총 주문금액 <span id="tprice"><%=nf.format(cartTotalAmount)%></span> 원
				</div>
			</div>

			<div class="orderBox">
				<h1 class="tit">배송지 정보</h1>
<% if (cartType1TotalPrice > 0 && cartType2TotalPrice > 0) { %>
				<div class="topArea">
					<div class="topAreaTit">일일배달 배송지 정보</div>
					<ul>
						<li>
							<input name="devl_type" id="devl_type1" type="radio" value="M" checked="checked" onclick="myAddr();" />
							<label for="devl_type1"><span></span>고객 정보동일</label>
						</li>
						<li>
							<input name="devl_type" id="devl_type2" type="radio" value="O" onclick="<%=(rcvName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
							<label for="devl_type2"><span></span>최근배송지</label>
						</li>
						<li>
							<input name="devl_type" id="devl_type3" type="radio" value="N" onclick="newAddr('R');" />
							<label for="devl_type3"><span></span>새 배송지</label>
						</li>
					</ul>
				</div>
				<div class="boxTable st2">
					<table>
						<tbody>
							<tr>
								<th>수령인</th>
								<td>
									<div class="ipt_group">
								    	<input name="rcv_name" type="text" class="ftfd ipt" required label="받으시는분" value="<%=memName%>" maxlength="20" />
								    </div>
								</td>
							</tr>
							<tr>
								<th>휴대폰</th>
								<td>
									<div class="ipt_group phoneNum">
										<span class="ipt_left">
											<select name="rcv_hp1" id="rcv_hp1" class="inp_st" required label="휴대폰 번호">
		                                       	<option value="">선택</option>
												<option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
												<option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
												<option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
												<option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
												<option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
												<option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
		                                   	</select>
										</span>
										<input name="rcv_hp2" type="tel" class="ipt number_maxlength" value="<%=memHp2%>" required label="휴대폰 번호" maxlength="4">
								    	<span class="ipt_right"><input name="rcv_hp3" type="tel" class="ipt number_maxlength" value="<%=memHp3%>" required label="휴대폰 번호" maxlength="4"></span>
								    </div>
								    <div class="ipt_group phoneNum">
								    	<span class="ipt_left">
								    		<select name="rcv_tel1" id="rcv_tel1" class="inp_st">
												<option value="">선택</option>
												<option value="02"<%if(memTel1.equals("02")){out.print(" selected");}%>>02</option>
												<option value="031"<%if(memTel1.equals("031")){out.print(" selected");}%>>031</option>
												<option value="032"<%if(memTel1.equals("032")){out.print(" selected");}%>>032</option>
												<option value="033"<%if(memTel1.equals("033")){out.print(" selected");}%>>033</option>
												<option value="041"<%if(memTel1.equals("041")){out.print(" selected");}%>>041</option>
												<option value="042"<%if(memTel1.equals("042")){out.print(" selected");}%>>042</option>
												<option value="043"<%if(memTel1.equals("043")){out.print(" selected");}%>>043</option>
												<option value="051"<%if(memTel1.equals("051")){out.print(" selected");}%>>051</option>
												<option value="052"<%if(memTel1.equals("052")){out.print(" selected");}%>>052</option>
												<option value="053"<%if(memTel1.equals("053")){out.print(" selected");}%>>053</option>
												<option value="054"<%if(memTel1.equals("054")){out.print(" selected");}%>>054</option>
												<option value="055"<%if(memTel1.equals("055")){out.print(" selected");}%>>055</option>
												<option value="061"<%if(memTel1.equals("061")){out.print(" selected");}%>>061</option>
												<option value="063"<%if(memTel1.equals("063")){out.print(" selected");}%>>063</option>
												<option value="064"<%if(memTel1.equals("064")){out.print(" selected");}%>>064</option>
												<option value="070"<%if(memTel1.equals("070")){out.print(" selected");}%>>070</option>
		                                   	</select>
								    	</span>
								    	<input name="rcv_tel2" type="tel" class="ipt number_maxlength" value="<%=memTel2%>" maxlength="4">
								    	<span class="ipt_right"><input name="rcv_tel3" type="tel" class="ipt number_maxlength" value="<%=memTel3%>" maxlength="4"></span>
								    </div>
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<div class="ipt_group">
								    	<input name="rcv_zipcode" id="rcv_zipcode" type="number" class="ipt" value="<%=memZipcode%>" required label="우편번호" readonly maxlength="6" />
								    	<span class="ipt_right"><button type="button" class="btn btn_gray square" onclick="fnAddressPop('0001');">우편번호</button></span>
								    	<!-- <span class="ipt_right"><button type="button" class="btn btn_gray square" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/popup/AddressSearchJiPop.jsp?ztype=0001'});return false;">우편번호</button></span> -->
								    </div>
								    <div class="ipt_group">
								    	<input name="rcv_addr1" id="rcv_addr1" type="text" class="ipt" value="<%=memAddr1%>" required label="기본주소" readonly maxlength="50"/>
								    </div>
								    <div class="ipt_group">
								    	<input name="rcv_addr2" type="text" class="ipt" value="<%=memAddr2%>" required label="상세주소" maxlength="50">
										<input type="hidden" id="rcv_addr_bcode" name="rcv_addr_bcode" value="<%=memAddrBCode%>" />
								    </div>
								</td>
							</tr>
							<tr>
								<th>수령방법</th>
								<td>
									<input name="rcv_type" id="rcv_type1" type="radio" value="01" checked="checked">
									<label for="rcv_type1"><span></span>현관앞 비치</label>
									<input name="rcv_type" id="rcv_type2" type="radio" value="02">
									<label for="rcv_type2"><span></span>경비실 위탁수령</label>
								</td>
							</tr>
							<tr>
								<th>출입시 비밀번호</th>
								<td>
									<input name="rcv_pass_yn" id="rcv_pass_yn1" type="radio" value="Y">
									<label for="rcv_pass_yn1"><span></span>있음</label>
									<input name="rcv_pass" id="rcv_pass" type="text" style="width:50px;">
									<input name="rcv_pass_yn" id="rcv_pass_yn2" type="radio" value="N" checked="checked">
									<label for="rcv_pass_yn2"><span></span>없음</label>
								</td>
							</tr>
							<tr>
								<th>요청사항</th>
								<td>
									<div class="ipt_group">
								    	<input name="rcv_request" type="text" class="ipt" maxlength="60">
								    </div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="topArea">
					<div class="topAreaTit">택배배달 배송지 정보</div>
					<ul>
						<li>
							<input name="addr_copy" id="addr_copy1" type="radio" value="Y" onclick="copyAddr();">
							<label for="addr_copy1"><span></span>일배 상품과 동일</label>
						</li>
						<li>
							<input name="addr_copy" id="addr_copy2" type="radio" value="N" onclick="newAddr('T');" checked="checked">
							<label for="addr_copy2"><span></span>새 배송지</label>
						</li>
					</ul>
				</div>
				<div class="boxTable st2">
					<table>
						<tbody>
							<tr>
								<th>수령인</th>
								<td>
									<div class="ipt_group">
								    	<input name="tag_name" class="ftfd ipt" type="text" required label="받으시는분" value="<%=memName%>" maxlength="20" />
								    </div>
								</td>
							</tr>
							<tr>
								<th>휴대폰</th>
								<td>
									<div class="ipt_group phoneNum">
										<span class="ipt_left">
											<select name="tag_hp1" id="tag_hp1" class="inp_st" required label="휴대폰 번호">
		                                       	<option value="">선택</option>
												<option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
												<option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
												<option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
												<option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
												<option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
												<option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
		                                   	</select>
										</span>
										<input name="tag_hp2" type="tel" class="ipt number_maxlength" value="<%=memHp2%>" required label="휴대폰 번호" maxlength="4">
								    	<span class="ipt_right"><input name="tag_hp3" type="tel" class="ipt number_maxlength" value="<%=memHp3%>" required label="휴대폰 번호" maxlength="4"></span>
								    </div>
								    <div class="ipt_group phoneNum">
								    	<span class="ipt_left">
								    		<select name="tag_tel1" id="tag_tel1" class="inp_st">
												<option value="">선택</option>
												<option value="02"<%if(memTel1.equals("02")){out.print(" selected");}%>>02</option>
												<option value="031"<%if(memTel1.equals("031")){out.print(" selected");}%>>031</option>
												<option value="032"<%if(memTel1.equals("032")){out.print(" selected");}%>>032</option>
												<option value="033"<%if(memTel1.equals("033")){out.print(" selected");}%>>033</option>
												<option value="041"<%if(memTel1.equals("041")){out.print(" selected");}%>>041</option>
												<option value="042"<%if(memTel1.equals("042")){out.print(" selected");}%>>042</option>
												<option value="043"<%if(memTel1.equals("043")){out.print(" selected");}%>>043</option>
												<option value="051"<%if(memTel1.equals("051")){out.print(" selected");}%>>051</option>
												<option value="052"<%if(memTel1.equals("052")){out.print(" selected");}%>>052</option>
												<option value="053"<%if(memTel1.equals("053")){out.print(" selected");}%>>053</option>
												<option value="054"<%if(memTel1.equals("054")){out.print(" selected");}%>>054</option>
												<option value="055"<%if(memTel1.equals("055")){out.print(" selected");}%>>055</option>
												<option value="061"<%if(memTel1.equals("061")){out.print(" selected");}%>>061</option>
												<option value="063"<%if(memTel1.equals("063")){out.print(" selected");}%>>063</option>
												<option value="064"<%if(memTel1.equals("064")){out.print(" selected");}%>>064</option>
												<option value="070"<%if(memTel1.equals("070")){out.print(" selected");}%>>070</option>
		                                   	</select>
								    	</span>
								    	<input name="tag_tel2" type="tel" class="ipt number_maxlength" value="<%=memTel2%>" maxlength="4">
								    	<span class="ipt_right"><input name="tag_tel3" type="tel" class="ipt number_maxlength" value="<%=memTel3%>" maxlength="4"></span>
								    </div>
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<div class="ipt_group">
								    	<input name="tag_zipcode" id="tag_zipcode" type="number" class="ipt" value="<%=memZipcode%>" required label="우편번호" readonly maxlength="6" />
								    	<span class="ipt_right"><button type="button" class="btn btn_gray square" onclick="fnAddressPop('0002');">우편번호</button></span>
								    	<!-- <span class="ipt_right"><button type="button" class="btn btn_gray square" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/popup/AddressSearchJiPop.jsp?ztype=0002'});return false;">우편번호</button></span> -->
								    </div>
								    <div class="ipt_group">
								    	<input name="tag_addr1" id="tag_addr1" type="text" class="ipt" value="<%=memAddr1%>" required label="기본주소" readonly maxlength="50"/>
								    </div>
								    <div class="ipt_group">
								    	<input name="tag_addr2" type="text" class="ipt" value="<%=memAddr2%>" required label="상세주소" maxlength="50">
								    </div>
								</td>
							</tr>
							<tr>
								<th>요청사항</th>
								<td>
									<div class="ipt_group">
								    	<input name="tag_required" type="text" class="ipt" maxlength="60">
								    </div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--
				<script type="text/javascript">
					$(document).ready(function() {
						newAddr('T');
					});
				</script>
				-->
<% } else if (cartType1TotalPrice > 0) { %>
				<div class="topArea">
					<div class="topAreaTit">일일배달 배송지 정보</div>
					<ul>
						<li>
							<input name="devl_type" id="devl_type1" type="radio" value="M" checked="checked" onclick="myAddr();" />
							<label for="devl_type1"><span></span>고객 정보동일</label>
						</li>
						<li>
							<input name="devl_type" id="devl_type2" type="radio" value="O" onclick="<%=(rcvName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
							<label for="devl_type2"><span></span>최근배송지</label>
						</li>
						<li>
							<input name="devl_type" id="devl_type3" type="radio" value="N" onclick="newAddr('R');" />
							<label for="devl_type3"><span></span>새 배송지</label>
						</li>
					</ul>
				</div>
				<div class="boxTable st2">
					<table>
						<tbody>
							<tr>
								<th>수령인</th>
								<td>
									<div class="ipt_group">
								    	<input name="rcv_name" type="text" class="ftfd ipt" required label="받으시는분" value="<%=memName%>" maxlength="20" />
								    </div>
								</td>
							</tr>
							<tr>
								<th>휴대폰</th>
								<td>
									<div class="ipt_group phoneNum">
										<span class="ipt_left">
											<select name="rcv_hp1" id="rcv_hp1" class="inp_st" required label="휴대폰 번호">
		                                       	<option value="">선택</option>
												<option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
												<option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
												<option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
												<option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
												<option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
												<option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
		                                   	</select>
										</span>
										<input name="rcv_hp2" type="tel" class="ipt number_maxlength" value="<%=memHp2%>" required label="휴대폰 번호" maxlength="4">
								    	<span class="ipt_right"><input name="rcv_hp3" type="tel" class="ipt number_maxlength" value="<%=memHp3%>" required label="휴대폰 번호" maxlength="4"></span>
								    </div>
								    <div class="ipt_group phoneNum">
								    	<span class="ipt_left">
								    		<select name="rcv_tel1" id="rcv_tel1" class="inp_st">
												<option value="">선택</option>
												<option value="02"<%if(memTel1.equals("02")){out.print(" selected");}%>>02</option>
												<option value="031"<%if(memTel1.equals("031")){out.print(" selected");}%>>031</option>
												<option value="032"<%if(memTel1.equals("032")){out.print(" selected");}%>>032</option>
												<option value="033"<%if(memTel1.equals("033")){out.print(" selected");}%>>033</option>
												<option value="041"<%if(memTel1.equals("041")){out.print(" selected");}%>>041</option>
												<option value="042"<%if(memTel1.equals("042")){out.print(" selected");}%>>042</option>
												<option value="043"<%if(memTel1.equals("043")){out.print(" selected");}%>>043</option>
												<option value="051"<%if(memTel1.equals("051")){out.print(" selected");}%>>051</option>
												<option value="052"<%if(memTel1.equals("052")){out.print(" selected");}%>>052</option>
												<option value="053"<%if(memTel1.equals("053")){out.print(" selected");}%>>053</option>
												<option value="054"<%if(memTel1.equals("054")){out.print(" selected");}%>>054</option>
												<option value="055"<%if(memTel1.equals("055")){out.print(" selected");}%>>055</option>
												<option value="061"<%if(memTel1.equals("061")){out.print(" selected");}%>>061</option>
												<option value="063"<%if(memTel1.equals("063")){out.print(" selected");}%>>063</option>
												<option value="064"<%if(memTel1.equals("064")){out.print(" selected");}%>>064</option>
												<option value="070"<%if(memTel1.equals("070")){out.print(" selected");}%>>070</option>
		                                   	</select>
								    	</span>
								    	<input name="rcv_tel2" type="tel" class="ipt number_maxlength" value="<%=memTel2%>" maxlength="4">
								    	<span class="ipt_right"><input name="rcv_tel3" type="tel" class="ipt number_maxlength" value="<%=memTel3%>" maxlength="4"></span>
								    </div>
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<div class="ipt_group">
								    	<input name="rcv_zipcode" id="rcv_zipcode" type="number" class="ipt" value="<%=memZipcode%>" required label="우편번호" readonly maxlength="6" />
								    	<span class="ipt_right"><button type="button" class="btn btn_gray square" onclick="fnAddressPop('0001');">우편번호</button></span>
								    	<!-- <span class="ipt_right"><button type="button" class="btn btn_gray square" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/popup/AddressSearchJiPop.jsp?ztype=0001'});return false;">우편번호</button></span> -->
								    </div>
								    <div class="ipt_group">
								    	<input name="rcv_addr1" id="rcv_addr1" type="text" class="ipt" value="<%=memAddr1%>" required label="기본주소" readonly maxlength="50"/>
								    </div>
								    <div class="ipt_group">
								    	<input name="rcv_addr2" type="text" class="ipt" value="<%=memAddr2%>" required label="상세주소" maxlength="50">
										<input type="hidden" id="rcv_addr_bcode" name="rcv_addr_bcode" value="<%=memAddrBCode%>" />
								    </div>
								</td>
							</tr>
							<tr>
								<th>수령방법</th>
								<td>
									<input name="rcv_type" id="rcv_type1" type="radio" value="01" checked="checked">
									<label for="rcv_type1"><span></span>현관앞 비치</label>
									<input name="rcv_type" id="rcv_type2" type="radio" value="02">
									<label for="rcv_type2"><span></span>경비실 위탁수령</label>
								</td>
							</tr>
							<tr>
								<th>출입시 비밀번호</th>
								<td>
									<input name="rcv_pass_yn" id="rcv_pass_yn1" type="radio" value="Y">
									<label for="rcv_pass_yn1"><span></span>있음</label>
									<input name="rcv_pass" id="rcv_pass" type="text" style="width:50px;">
									<input name="rcv_pass_yn" id="rcv_pass_yn2" type="radio" value="N" checked="checked">
									<label for="rcv_pass_yn2"><span></span>없음</label>
								</td>
							</tr>
							<tr>
								<th>요청사항</th>
								<td>
									<div class="ipt_group">
								    	<input name="rcv_request" type="text" class="ipt" maxlength="60">
								    </div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
<% } else if (cartType2TotalPrice > 0) { %>
				<div class="topArea">
					<div class="topAreaTit">택배배달 배송지 정보</div>
					<ul>
						<li>
							<input name="devl_type" id="devl_type1" type="radio" value="M" checked="checked" onclick="myAddr();" />
							<label for="devl_type1"><span></span>고객 정보동일</label>
						</li>
						<li>
							<input name="devl_type" id="devl_type2" type="radio" value="O" onclick="<%=(tagName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
							<label for="devl_type2"><span></span>최근배송지</label>
						</li>
						<li>
							<input name="devl_type" id="devl_type3" type="radio" value="N" onclick="newAddr('T');" />
							<label for="devl_type3"><span></span>새 배송지</label>
						</li>
					</ul>
				</div>
				<div class="boxTable st2">
					<table>
						<tbody>
							<tr>
								<th>수령인</th>
								<td>
									<div class="ipt_group">
								    	<input name="tag_name" class="ftfd ipt" type="text" required label="받으시는분" value="<%=memName%>" maxlength="20" />
								    </div>
								</td>
							</tr>
							<tr>
								<th>휴대폰</th>
								<td>
									<div class="ipt_group phoneNum">
										<span class="ipt_left">
											<select name="tag_hp1" id="tag_hp1" class="inp_st" required label="휴대폰 번호">
		                                       	<option value="">선택</option>
												<option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
												<option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
												<option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
												<option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
												<option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
												<option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
		                                   	</select>
										</span>
										<input name="tag_hp2" type="tel" class="ipt number_maxlength" value="<%=memHp2%>" required label="휴대폰 번호" maxlength="4">
								    	<span class="ipt_right"><input name="tag_hp3" type="tel" class="ipt number_maxlength" value="<%=memHp3%>" required label="휴대폰 번호" maxlength="4"></span>
								    </div>
								    <div class="ipt_group phoneNum">
								    	<span class="ipt_left">
								    		<select name="tag_tel1" id="tag_tel1" class="inp_st">
												<option value="">선택</option>
												<option value="02"<%if(memTel1.equals("02")){out.print(" selected");}%>>02</option>
												<option value="031"<%if(memTel1.equals("031")){out.print(" selected");}%>>031</option>
												<option value="032"<%if(memTel1.equals("032")){out.print(" selected");}%>>032</option>
												<option value="033"<%if(memTel1.equals("033")){out.print(" selected");}%>>033</option>
												<option value="041"<%if(memTel1.equals("041")){out.print(" selected");}%>>041</option>
												<option value="042"<%if(memTel1.equals("042")){out.print(" selected");}%>>042</option>
												<option value="043"<%if(memTel1.equals("043")){out.print(" selected");}%>>043</option>
												<option value="051"<%if(memTel1.equals("051")){out.print(" selected");}%>>051</option>
												<option value="052"<%if(memTel1.equals("052")){out.print(" selected");}%>>052</option>
												<option value="053"<%if(memTel1.equals("053")){out.print(" selected");}%>>053</option>
												<option value="054"<%if(memTel1.equals("054")){out.print(" selected");}%>>054</option>
												<option value="055"<%if(memTel1.equals("055")){out.print(" selected");}%>>055</option>
												<option value="061"<%if(memTel1.equals("061")){out.print(" selected");}%>>061</option>
												<option value="063"<%if(memTel1.equals("063")){out.print(" selected");}%>>063</option>
												<option value="064"<%if(memTel1.equals("064")){out.print(" selected");}%>>064</option>
												<option value="070"<%if(memTel1.equals("070")){out.print(" selected");}%>>070</option>
		                                   	</select>
								    	</span>
								    	<input name="tag_tel2" type="tel" class="ipt number_maxlength" value="<%=memTel2%>" maxlength="4">
								    	<span class="ipt_right"><input name="tag_tel3" type="tel" class="ipt number_maxlength" value="<%=memTel3%>" maxlength="4"></span>
								    </div>
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<div class="ipt_group">
								    	<input name="tag_zipcode" id="tag_zipcode" type="number" class="ipt" value="<%=memZipcode%>" required label="우편번호" readonly maxlength="6" />
								    	<span class="ipt_right"><button type="button" class="btn btn_gray square" onclick="fnAddressPop('0002');">우편번호</button></span>
								    	<!-- <span class="ipt_right"><button type="button" class="btn btn_gray square" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/popup/AddressSearchJiPop.jsp?ztype=0002'});return false;">우편번호</button></span> -->
								    </div>
								    <div class="ipt_group">
								    	<input name="tag_addr1" id="tag_addr1" type="text" class="ipt" value="<%=memAddr1%>" required label="기본주소" readonly maxlength="50"/>
								    </div>
								    <div class="ipt_group">
								    	<input name="tag_addr2" type="text" class="ipt" value="<%=memAddr2%>" required label="상세주소" maxlength="50">
								    </div>
								</td>
							</tr>
							<tr>
								<th>요청사항</th>
								<td>
									<div class="ipt_group">
								    	<input name="tag_required" type="text" class="ipt" maxlength="60">
								    </div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
<% } %>
			</div>

			<div class="orderBox">
				<h1 class="tit">결제수단</h1>
				<div class="topArea">
					<ul>
						<li>
							<input type="radio" id="10" name="pay_type" required label="결제수단선택" value="10" onclick="viewDiv('pay_type10');" checked="" />
							<label for="10"><span></span>신용카드</label>
						</li>
						<li>
							<input type="radio" id="20" name="pay_type" required label="결제수단선택" value="20" onclick="viewDiv('pay_type20');" />
							<label for="20"><span></span>실시간 계좌이체</label>
						</li>
						<li>
							<input type="radio" id="30" name="pay_type" required label="결제수단선택" value="30" onclick="viewDiv('pay_type30');" />
							<label for="30"><span></span>가상계좌</label>
						</li>
					</ul>
				</div>
				<div id="pay_type10" style="display: none;" class="paymethod"></div>
				<div id="pay_type20" style="display: none;" class="paymethod"></div>
				<div id="pay_type30" style="display: none;" class="paymethod">
					<p class="guide">
						- 일배상품의 경우 선택하신 첫 배송일 D-3일 15시이전까지 입금이 안될 시 주문이 자동취소됩니다.<br />
						- 택배상품은 결제완료 후 2-5일 이내에 받아보실 수 있습니다.
					</p>
				</div>
				<div style="text-align:center;color:red;font-size:1.5rem;font-weight:bold;padding: 5%;display: none;" id="pay_ing">
					결제 처리중입니다. 잠시만 기다려주십시오...
				</div>
				<div class="orderBtns">
					<button type="button" class="btn btn_white square" onclick="history.back();">이전페이지</button>
					<button type="button" class="btn btn_dgray square" onclick="ckForm('mobile')">결제하기</button>
				</div>
			</div>
	</div>
<input type="hidden" name="mode" value="<%=mode%>" />
<input type="hidden" name="oyn" value="<%=oyn%>" />
<input type="hidden" name="order_num" value="<%=orderNum%>" />
<input type="hidden" name="goods_price" id="goods_price" value="<%=cartTotalPrice%>" />
<input type="hidden" name="pay_price" id="pay_price" value="<%=cartTotalAmount%>"/>
<input type="hidden" name="coupon_ftprice" id="coupon_ftprice" />
<input type="hidden" name="email" value="<%=memEmail%>" />
<input type="hidden" name="devl_price" value="<%=devlPrice%>"/>
	<!-- End Content -->
	<div class="ui-footer">
	<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>

<input type="hidden" name="LGD_TID" value="" />
<input type="hidden" name="LGD_CARDNUM" value="" />
<input type="hidden" name="LGD_FINANCECODE" value="" />
<input type="hidden" name="LGD_FINANCENAME" value="" />
<input type="hidden" name="LGD_ACCOUNTNUM" value="" />
<input type="hidden" name="LGD_FINANCEAUTHNUM" value="" />
<input type="hidden" name="LGD_CLOSEDATE" value="<%=pgCloseDate%>" />

<input type="hidden" name="test" value="" />
<input type="hidden" name="orderEnv" value="M">
</form>
<%@ include file="../xpayMobile/config.jsp" %>
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="/mobile/xpayMobile/order.payreq.jsp">
<input type="hidden" name="LGD_OID" value="<%=orderNum%>"/>
<input type="hidden" name="LGD_PRODUCTINFO" value="<%=productName%>"/>
<input type="hidden" name="LGD_TIMESTAMP" value="<%=LGD_TIMESTAMP%>"/>
<input type="hidden" name="LGD_BUYER" value=""/>
<input type="hidden" name="LGD_AMOUNT" value=""/>
<input type="hidden" name="LGD_BUYEREMAIL" value=""/>
<input type="hidden" name="LGD_CUSTOM_FIRSTPAY" value=""/>
<input type="hidden" name="LGD_CUSTOM_USABLEPAY" id = 'LGD_CUSTOM_USABLEPAY' value="SC0010-SC0030-SC0040"/>
<input type="hidden" name="LGD_CLOSEDATE" value="<%=pgCloseDate%>" />
</form>

<form method="post" name="frmMobileComplete" id="frmMobileComplete" action="/proc/order_proc_mobile.jsp">
<input type="hidden" name="mode" value="<%=mode%>" />
<input type="hidden" name="oyn" value="<%=oyn%>" />
<input type="hidden" name="orderEnv" value="M" />
<input type="hidden" name="order_num" value="<%=orderNum%>"/>
<input type="hidden" name="pay_type" value="" />
<input type="hidden" name="LGD_OID" value="<%=orderNum%>"/>
<input type="hidden" name="LGD_TID" value="" />
<input type="hidden" name="LGD_CARDNUM" value="" />
<input type="hidden" name="LGD_FINANCECODE" value="" />
<input type="hidden" name="LGD_FINANCENAME" value="" />
<input type="hidden" name="LGD_ACCOUNTNUM" value="" />
<input type="hidden" name="LGD_FINANCEAUTHNUM" value="" />
</form>

<input type="hidden" id="devl_check" value="<%=devlCheck%>" />
<input type="hidden" id="recent_devl_check" value="<%=recentDevlCheck%>" />

<iframe id="ifrmHidden" name="ifrmHidden" src="about:blank" style="width:100%;height:200px;display:none"></iframe>

<script type="text/javascript">
$(document).ready(function() {
	if ($("#devl_check").val() == "N") {
		//alert("고객님의 일배 배송지는 배송이 불가능한 지역입니다.\n새로운 배송지를 입력해주세요.");
		$("input[name=devl_type]")[2].click();
	}
	$("input[name=rcv_pass_yn]").click(function() {
		var passVal		= $("input[name=rcv_pass_yn]:checked").val();
		if (passVal == "Y") {
			$("#rcv_pass").attr("label","출입시 비밀번호");
			$("#rcv_pass").attr("required","");
		} else {
			$("#rcv_pass").removeAttr("label","출입시 비밀번호");
			$("#rcv_pass").removeAttr("required","");
		}
	});
	//-- 길이체크
	$(".number_maxlength").on("input",function(){
		var $this = $(this);
		if($this.val().length > this.maxLength){
			$this.val($this.val().substring(0,this.maxLength));
		}
	});
});
function myAddr() {
	var f	= document.frmOrder;

	if ($("#devl_check").val() == "N") {
		alert("고객님의 일배 배송지는 배송이 불가능한 지역입니다.\n새로운 배송지를 입력해주세요.");
		$("input[name=devl_type]")[2].click();
	} else {
		if (f.rcv_name) {
			f.rcv_name.value		= "<%=memName%>";
			f.rcv_hp1.value			= "<%=memHp1%>";
			f.rcv_hp2.value			= "<%=memHp2%>";
			f.rcv_hp3.value			= "<%=memHp3%>";
			f.rcv_tel1.value		= "<%=memTel1%>";
			f.rcv_tel2.value		= "<%=memTel2%>";
			f.rcv_tel3.value		= "<%=memTel3%>";
			f.rcv_zipcode.value		= "<%=memZipcode%>";
			f.rcv_addr1.value		= "<%=memAddr1%>";
			f.rcv_addr2.value		= "<%=memAddr2%>";
			f.rcv_addr_bcode.value		= "<%=memAddrBCode%>";
		} else if (f.tag_name) {
			f.tag_name.value		= "<%=memName%>";
			f.tag_hp1.value			= "<%=memHp1%>";
			f.tag_hp2.value			= "<%=memHp2%>";
			f.tag_hp3.value			= "<%=memHp3%>";
			f.tag_tel1.value		= "<%=memTel1%>";
			f.tag_tel2.value		= "<%=memTel2%>";
			f.tag_tel3.value		= "<%=memTel3%>";
			f.tag_zipcode.value		= "<%=memZipcode%>";
			f.tag_addr1.value		= "<%=memAddr1%>";
			f.tag_addr2.value		= "<%=memAddr2%>";
		}
	}
}

function recentAddr(str) {
	if (str == 'n') {
		alert("최근배송지 정보가 없습니다.");
		$("input[name=devl_type]")[0].click();
	} else if ($("#recent_devl_check").val() == "N") {
		alert("고객님의 최근 배송지는 일일배송이 불가능한 지역입니다.\n새로운 배송지를 입력해주세요.");
		$("input[name=devl_type]")[2].click();
	} else {
		var f	= document.frmOrder;

		if (f.rcv_name) {
			f.rcv_name.value		= "<%=rcvName%>";
			f.rcv_hp1.value			= "<%=rcvHp1%>";
			f.rcv_hp2.value			= "<%=rcvHp2%>";
			f.rcv_hp3.value			= "<%=rcvHp3%>";
			f.rcv_tel1.value		= "<%=rcvTel1%>";
			f.rcv_tel2.value		= "<%=rcvTel2%>";
			f.rcv_tel3.value		= "<%=rcvTel3%>";
			f.rcv_zipcode.value		= "<%=rcvZipcode%>";
			f.rcv_addr1.value		= "<%=rcvAddr1%>";
			f.rcv_addr2.value		= "<%=rcvAddr2%>";
			f.rcv_addr_bcode.value		= "<%=rcvBuildingNo%>";
		} else if (f.tag_name) {
			f.tag_name.value		= "<%=tagName%>";
			f.tag_hp1.value			= "<%=tagHp1%>";
			f.tag_hp2.value			= "<%=tagHp2%>";
			f.tag_hp3.value			= "<%=tagHp3%>";
			f.tag_tel1.value		= "<%=tagTel1%>";
			f.tag_tel2.value		= "<%=tagTel2%>";
			f.tag_tel3.value		= "<%=tagTel3%>";
			f.tag_zipcode.value		= "<%=tagZipcode%>";
			f.tag_addr1.value		= "<%=tagAddr1%>";
			f.tag_addr2.value		= "<%=tagAddr2%>";
		}
	}
}

function copyAddr() {
	var f	= document.frmOrder;

	f.tag_name.value		= f.rcv_name.value;
	f.tag_hp1.value			= f.rcv_hp1.value;
	f.tag_hp2.value			= f.rcv_hp2.value;
	f.tag_hp3.value			= f.rcv_hp3.value;
	f.tag_tel1.value		= f.rcv_tel1.value;
	f.tag_tel2.value		= f.rcv_tel2.value;
	f.tag_tel3.value		= f.rcv_tel3.value;
	f.tag_zipcode.value		= f.rcv_zipcode.value;
	f.tag_addr1.value		= f.rcv_addr1.value;
	f.tag_addr2.value		= f.rcv_addr2.value;
}

function newAddr(str) {
	var f	= document.frmOrder;

	if (str == "T") {
		f.tag_name.value		= "";
		f.tag_hp1.value			= "";
		f.tag_hp2.value			= "";
		f.tag_hp3.value			= "";
		f.tag_tel1.value		= "";
		f.tag_tel2.value		= "";
		f.tag_tel3.value		= "";
		f.tag_zipcode.value		= "";
		f.tag_addr1.value		= "";
		f.tag_addr2.value		= "";
	} else {
		f.rcv_name.value		= "";
		f.rcv_hp1.value			= "";
		f.rcv_hp2.value			= "";
		f.rcv_hp3.value			= "";
		f.rcv_tel1.value		= "";
		f.rcv_tel2.value		= "";
		f.rcv_tel3.value		= "";
		f.rcv_zipcode.value		= "";
		f.rcv_addr1.value		= "";
		f.rcv_addr2.value		= "";
		f.rcv_addr_bcode.value = "";
	}
}

function viewDiv(idx){
	var x	= document.getElementsByTagName('div');
	for (i=0; i<x.length; i++) {
		if (x[i].className=='paymethod') {
			x[i].style.display	= 'none';
		}
	}
	document.getElementById(idx).style.display='block';
}

function clearCoupons() {
	$(".fprice").each(function() {
		gcdArr			= $(this).attr("id").split("_");
		gcd				= gcdArr[2];
		$("#coupon_fprice_"+ gcd).val(0);
		$("#coupon_fnum_"+ gcd).val("");
	});
	$("#coupon_price_txt").val("");
	$("#coupon_ftprice").val(0);
	$("#coupon_fprice_txt").text(commaSplit(0));
	var tprice		= parseInt($("#goodsPrice").val()) + parseInt($("#bagPrice").val() - parseInt($("#coupon_ftprice").val()));
	if (tprice < 1) tprice = 0;
	$("#tprice").text(commaSplit(tprice));
	$("#pay_price").val(tprice);
}

function showCoupons() {
	clearCoupons();

	window.open('/mobile/shop/popup/couponCheck.jsp?&mode=<%=mode%>&oyn=<%=oyn%>','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=780,height=520');
}

function setCoupon() {
	$.post("/shop/order_ajax.jsp", {
		mode: "setCoupon",
		couponNum: $("#off_coupon_num").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("등록되었습니다.");
				document.location.reload();
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function fnAddressPop(val){
	var features = 'scrollbars=yes,resizable=yes,width=100%,height=auto';

	window.open("/mobile/shop/popup/AddressSearchJiPop.jsp?ztype=" + val, 'AddressPop', features);
}

</script>
<script>
	$(document).ready(function(){
	$(".iframe").colorbox({iframe:true, width:"96%", height:"405px"});
	});
</script>
