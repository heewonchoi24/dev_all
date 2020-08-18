<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
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
int payPrice		= 0;
int totalPrice		= 0;
int dayPrice		= 0;
int tagPrice		= 0;
int tagPrice1		= 0;
int tagPrice2		= 0;
int tagPrice3		= 0;
int goodsPrice		= 0;
int devlPrice		= 0;
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

SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
String orderNum		= "ESS" + dt.format(new Date()) + "001";
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
String[] tmp			= new String[]{};
NumberFormat nf = NumberFormat.getNumberInstance();
String productName		= "";

query		= "SELECT MEM_NAME, EMAIL, ZIPCODE, ADDRESS, ADDRESS_DETAIL, HP, TEL FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"'";
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
}
rs.close();

String rcvName		= "";
String rcvZipcode	= "";
String rcvAddr1		= "";
String rcvAddr2		= "";
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

query		= "SELECT RCV_NAME, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_HP, RCV_TEL,";
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

query		= "SELECT COUNT(ID) FROM ESL_CART WHERE MEMBER_ID = '"+ eslMemberId +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //총 레코드 수
}
rs.close();

query		= "SELECT C.GROUP_ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK, DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN, G.GUBUN1, G.GUBUN2, G.GROUP_CODE, G.GROUP_NAME, G.CART_IMG";
query		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
query		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = '"+ eslMemberId +"' AND C.CART_TYPE = '"+ mode +"'";
if (oyn.equals("Y")) {
	query		+= " AND ORDER_YN = 'Y'";
}
query		+= " ORDER BY C.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>
	<script type="text/javascript" src="/common/js/common.js"></script>
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
	<div id="content">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">주문결제</span></span></h1>
		<h2 class="ui-title">주문리스트 확인</h2>
		<%
		if (tcnt > 0) {
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
					if (gubun2.equals("26")) {
						devlPeriod	= "3일";
					} else {
						devlPeriod	= devlWeek +"주("+ devlDay +"일)";
					}
					price		= rs.getInt("PRICE");
					goodsPrice	= price * buyQty;
					dayPrice	+= goodsPrice;
					
					date			= cdt2.parse(devlDate);
					Calendar cal	= Calendar.getInstance();
					cal.setTime(date);

					if ( groupId == 89 ) {
						cal.add(Calendar.DATE, -2);
						pgCloseDtTmp	= dt2.format(cal.getTime());
					} else if ( groupId == 32 || groupId == 40 || groupId == 69 || groupId == 92 ) {
						cal.add(Calendar.DATE, -3);
						pgCloseDtTmp	= dt3.format(cal.getTime());
					} else {
						cal.add(Calendar.DATE, -5);
						pgCloseDtTmp	= dt3.format(cal.getTime());
					}
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
					goodsPrice	= price * buyQty;
					tagPrice	+= goodsPrice;
					if (groupId == 15) {
						tagPrice1	+= goodsPrice;
						if (tagPrice1 > 40000) {
							devlPrice		= 0;
						} else {
							devlPrice		= defaultDevlPrice;
						}
					} else if (groupId == 52 || groupId == 53) {
						devlPrice1		= defaultDevlPrice;
					} else if (groupId == 75 || groupId == 76 || groupId == 77 || groupId == 81 || groupId == 79 || groupId == 80) {
						tagPrice2	+= goodsPrice;
						if (tagPrice2 > 40000) {
							devlPrice2		= 0;
						} else {
							devlPrice2		= defaultDevlPrice;
						}
					} else if (groupId == 93 || groupId == 94 || groupId == 95 || groupId == 96 || groupId == 97) {
						tagPrice3	+= goodsPrice;
						if (tagPrice3 > 40000) {
							devlPrice3		= 0;
						} else {
							devlPrice3		= defaultDevlPrice;
						}
					}
				}
				cartImg		= rs.getString("CART_IMG");
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
					couponCnt		= rs1.getInt("COUPON_CNT");
				}

				rs1.close();
		%>
		<dl class="itemlist">
			<dt style="width:70%;"><%=groupName%>/<%=buyQty%>개<p class="font-gray">배송기간:<%=devlPeriod%> / 첫배송일 : <%=devlDate%></p></dt>
			<dd style="width:30%;"><%=nf.format(price)%>원</dd>
		</dl>
		<input type="hidden" name="group_code" value="<%=groupCode%>" />
		<input type="hidden" name="coupon_price" id="coupon_fprice_<%=groupCode%>" class="fprice" value="0" />
		<input type="hidden" name="coupon_num" id="coupon_fnum_<%=groupCode%>" class="fnum" />
		<%
				if (buyBagYn.equals("Y")) {
					bagPrice	+= defaultBagPrice * buyQty;
		%>
		<dl class="itemlist">
			<dt style="width:70%;">보냉가방/<%=buyQty%>개<p class="font-gray">첫배송일 : <%=devlDate%></p></dt>
			<dd style="width:30%;"><%=nf.format(defaultBagPrice)%>원</dd>
		</dl>
		<%
				}
				i++;
			}

			rs.close();

			if (dayPrice > 0) {
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

			orderPrice		= dayPrice + tagPrice + bagPrice;
			goodsTprice		= dayPrice + tagPrice;
			devlPrice		= devlPrice + devlPrice1 + devlPrice2 + devlPrice3;

			
			if (tagPrice > 0) {
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
			
			totalPrice		= orderPrice + devlPrice;
		}

		rs.close();
		%>
		<h2 class="ui-title">할인혜택</h2>
		<table class="form-line" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="60"><label>쿠폰등록</label></td>
				<td style="padding-right:20px;">
				<input type="text" name="off_coupon_num" id="off_coupon_num" maxlength="20" style="width:100%;" /></td>
				<td width="40"><a href="javascript:;" onclick="setCoupon();" class="ui-btn ui-mini ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">등록</span></span></a></td>
			</tr>
		</table>
		<p class="guide">오프라인 쿠폰을 발급받으신 분은 이곳에서 쿠폰을 등록한 다음 사용하세요.</p>
		<table class="form-line" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="60"><label>쿠폰할인</label></td>
				<td style="padding-right:20px;"><input type="text" name="coupon_price_txt" id="coupon_price_txt" style="width:75%;">원</td>
				<td width="60">
					<%if (couponCnt > 0) {%>
					<a href="/mobile/shop/popup/couponCheck.jsp?mode=<%=mode%>&oyn=<%=oyn%>" onclick="showCoupons();" class="ui-btn ui-mini ui-btn-inline ui-btn-up-b iframe"><span class="ui-btn-inner"><span class="ui-btn-text">조회 및 적용</span></span></a>
					<%} else {%>
					<a href="javascript:;" onclick="alert('적용가능한 쿠폰이 없습니다.');" class="ui-btn ui-mini ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">조회 및 적용</span></span></a>
					<%}%>
				</td>
			</tr>
		</table>
		<p class="guide">사용가능 쿠폰 <strong class="font-blue"><%=couponCnt%></strong>장</p>
		<div class="divider"></div>
		<h2 class="ui-title">주문리스트 확인</h2> 
		<input type="hidden" id="goodsPrice" value="<%=goodsTprice%>" />
		<input type="hidden" id="devlPrice" value="<%=devlPrice%>" />
		<input type="hidden" id="bagPrice" value="<%=bagPrice%>" />
		<dl class="itemlist">
			<dt>총 상품금액</dt>
			<dd><%=nf.format(goodsTprice)%>원</dd>
			<dt>배송료(택배상품)</dt>
			<dd class="acc">(+) <%=nf.format(devlPrice)%>원</dd>
			<dt>보냉가방</dt>
			<dd class="acc">(+) <%=nf.format(bagPrice)%>원</dd> 
			<dt>할인혜택</dt>
			<dd class="minus">(-) 0원</dd>
		</dl>
		<div class="clear"></div>
		<dl class="itemlist redline">
			<dt class="f16">총 결제금액</dt>
			<dd class="f16 font-orange" id="tprice"><%=nf.format(totalPrice)%>원</dd>
		</dl>
		<div class="divider"></div> 
		<h2 class="ui-title">배송지 정보</h2> 
		<%if (dayPrice > 0 && tagPrice > 0) {%>
		<h3 class="marb10 font-blue">일일배달 배송지 정보</h3>
		<input name="devl_type" id="devl_type1" type="radio" value="M" checked="checked" onclick="myAddr();" />
		<label for="devl_type1"><span></span>고객 정보동일</label>
		<input name="devl_type" id="devl_type2" type="radio" value="O" onclick="<%=(rcvName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
		<label for="devl_type2"><span></span>최근배송지</label> 
		<input name="devl_type" id="devl_type3" type="radio" value="N" onclick="newAddr('R');" />
		<label for="devl_type3"><span></span>새 배송지</label> 
		<div class="divider"></div>   
		<ul class="form-regist">
			<li><label>수령인</label><input name="rcv_name" type="text" class="ftfd" required label="받으시는분" value="<%=memName%>" maxlength="20" /></li>
			<li>
				<label>휴대폰</label>
				<div class="select-box">
					<select name="rcv_hp1" id="rcv_hp1" required label="휴대폰 번호">
						<option value="">선택</option>
						<option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
						<option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
						<option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
						<option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
						<option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
						<option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
					</select>
				</div>
				<input name="rcv_hp2" type="number" style="width:60px" value="<%=memHp2%>" required label="휴대폰 번호" maxlength="4">
				<input name="rcv_hp3" type="number" style="width:60px" value="<%=memHp3%>" required label="휴대폰 번호" maxlength="4">
			</li>
			<li>
				<label>전화번호</label>
				<div class="select-box">
					<select name="rcv_tel1" id="rcv_tel1">
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
				</div>
				<input name="rcv_tel2" type="number" style="width:60px" value="<%=memTel2%>" maxlength="4">
				<input name="rcv_tel3" type="number" style="width:60px" value="<%=memTel3%>" maxlength="4">
			</li>
			<li>
				<label>주소</label>
					<input name="rcv_zipcode" id="rcv_zipcode" type="number" style="width:100px;" value="<%=memZipcode%>" required label="우편번호" readonly maxlength="6" />
					<a href="javascript:;" onclick="fnAddressPop('0001');" class="ui-btn ui-mini ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">우편번호</span></span></a>
					<br />
					<input name="rcv_addr1" id="rcv_addr1" type="text" style="width:100%;" value="<%=memAddr1%>" required label="기본주소" readonly maxlength="50"/>
					<br />
					<input name="rcv_addr2" type="text" style="width:100%" value="<%=memAddr2%>" required label="상세주소" maxlength="50">
			</li>
			<li>
				<label>수령방법</label>
				<input name="rcv_type" id="rcv_type1" type="radio" value="01" checked="checked">
				<label for="rcv_type1"><span></span>현관앞 비치</label>
				<input name="rcv_type" id="rcv_type1" type="radio" value="02">
				<label for="rcv_type2"><span></span>경비실 위탁수령</label> 
			</li>
			<li>
				<label>출입시 비밀번호</label>
				<input name="rcv_pass_yn" id="rcv_pass_yn1" type="radio" value="Y">
				<label for="rcv_pass_yn1"><span></span>있음</label>
				<input name="rcv_pass" id="rcv_pass" type="text" style="width:50px;">
				<input name="rcv_pass_yn" id="rcv_pass_yn2" type="radio" value="N" checked="checked">
				<label for="rcv_pass_yn2"><span></span>없음</label> 
			</li>
			<li>
				<label>요청사항</label>
				<input name="rcv_request" type="text" maxlength="60">
			</li>
		</ul>
		<h3 class="marb10 font-blue">택배배달 배송지 정보</h3>
		<input name="addr_copy" id="addr_copy1" type="radio" value="Y" onclick="copyAddr();">
		<label for="addr_copy1"><span></span>일배 상품과 동일</label>
		<input name="addr_copy" id="addr_copy2" type="radio" value="N" onclick="newAddr('T');" checked="checked">
		<label for="addr_copy2"><span></span>새 배송지</label> 
		<div class="divider"></div>   
		<ul class="form-regist">
			<li>
				<label>수령인</label>
				<input name="tag_name" class="ftfd" type="text" required label="받으시는분" maxlength="20" />
			</li>
			<li>
				<label>휴대폰</label>
				<div class="select-box">
					<select name="tag_hp1" id="tag_hp1" style="width:60px;" required label="휴대폰 번호">
						<option value="">선택</option>
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>									
				</div>
				<input name="tag_hp2" type="number" style="width:60px;" required label="휴대폰 번호" maxlength="4">
				<input name="tag_hp3" type="number" style="width:60px;" required label="휴대폰 번호" maxlength="4">
			</li>
			<li>
				<label>전화번호</label>
				<div class="select-box">
					<select name="tag_tel1" id="tag_tel1" style="width:60px;">
						<option value="">선택</option>
						<option value="02">02</option>
						<option value="031">031</option>
						<option value="032">032</option>
						<option value="033">033</option>
						<option value="041">041</option>
						<option value="042">042</option>
						<option value="043">043</option>
						<option value="051">051</option>
						<option value="052">052</option>
						<option value="053">053</option>
						<option value="054">054</option>
						<option value="055">055</option>
						<option value="061">061</option>
						<option value="063">063</option>
						<option value="064">064</option>
						<option value="070">070</option>
					</select>									
				</div>
				<input name="tag_tel2" type="number" style="width:60px;" maxlength="4">
				<input name="tag_tel3" type="number" style="width:60px;" maxlength="4">
			</li>
			<li>
				<label>주소</label>
					<input name="tag_zipcode" id="tag_zipcode" type="number" style="width:100px;" required label="우편번호" readonly maxlength="6" />
					<a href="javascript:;" onclick="fnAddressPop('0002');" class="ui-btn ui-mini ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">우편번호</span></span></a>
					<br />
					<input name="tag_addr1" id="tag_addr1" type="text" style="width:100%;" required label="기본주소" readonly maxlength="50" />
					<br />
					<input name="tag_addr2" type="text" style="width:100%" required label="상세주소" maxlength="50">
			</li>
			<li>
				<label>요청사항</label>
				<input name="tag_required" type="text" maxlength="60">
			</li>
		</ul>
		<%} else if (dayPrice > 0) {%>
		<h3 class="marb10 font-blue">일일배달 배송지 정보</h3>
		<input name="devl_type" id="devl_type1" type="radio" value="M" checked="checked" onclick="myAddr();" />
		<label for="devl_type1"><span></span>고객 정보동일</label>
		<input name="devl_type" id="devl_type2" type="radio" value="O" onclick="<%=(rcvName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
		<label for="devl_type2"><span></span>최근배송지</label> 
		<input name="devl_type" id="devl_type3" type="radio" value="N" onclick="newAddr('R');" />
		<label for="devl_type3"><span></span>새 배송지</label> 
		<div class="divider"></div>   
		<ul class="form-regist">
			<li><label>수령인</label><input name="rcv_name" type="text" class="ftfd" required label="받으시는분" value="<%=memName%>" maxlength="20" /></li>
			<li>
				<label>휴대폰</label>
				<div class="select-box">
					<select name="rcv_hp1" id="rcv_hp1" required label="휴대폰 번호">
						<option value="">선택</option>
						<option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
						<option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
						<option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
						<option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
						<option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
						<option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
					</select>
				</div>
				<input name="rcv_hp2" type="number" style="width:60px" value="<%=memHp2%>" required label="휴대폰 번호" maxlength="4">
				<input name="rcv_hp3" type="number" style="width:60px" value="<%=memHp3%>" required label="휴대폰 번호" maxlength="4">
			</li>
			<li>
				<label>전화번호</label>
				<div class="select-box">
					<select name="rcv_tel1" id="rcv_tel1">
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
				</div>
				<input name="rcv_tel2" type="number" style="width:60px" value="<%=memTel2%>" maxlength="4">
				<input name="rcv_tel3" type="number" style="width:60px" value="<%=memTel3%>" maxlength="4">
			</li>
			<li>
				<label>주소</label>
					<input name="rcv_zipcode" id="rcv_zipcode" type="number" style="width:100px;" value="<%=memZipcode%>" required label="우편번호" readonly maxlength="6" />
					<a href="javascript:;" onclick="fnAddressPop('0001');" class="ui-btn ui-mini ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">우편번호</span></span></a>
					<br />
					<input name="rcv_addr1" id="rcv_addr1" type="text" style="width:100%;" value="<%=memAddr1%>" required label="기본주소" readonly maxlength="50"/>
					<br />
					<input name="rcv_addr2" type="text" style="width:100%" value="<%=memAddr2%>" required label="상세주소" maxlength="50">
			</li>
			<li>
				<label>수령방법</label>
				<input name="rcv_type" id="rcv_type1" type="radio" value="01" checked="checked">
				<label for="rcv_type1"><span></span>현관앞 비치</label>
				<input name="rcv_type" id="rcv_type2" type="radio" value="02">
				<label for="rcv_type2"><span></span>경비실 위탁수령</label> 
			</li>
			<li>
				<label>출입시 비밀번호</label>
				<input name="rcv_pass_yn" id="rcv_pass_yn1" type="radio" value="Y">
				<label for="rcv_pass_yn1"><span></span>있음</label>
				<input name="rcv_pass" id="rcv_pass" type="text" style="width:50px;">
				<input name="rcv_pass_yn" id="rcv_pass_yn2" type="radio" value="N" checked="checked">
				<label for="rcv_pass_yn2"><span></span>없음</label> 
			</li>
			<li>
				<label>요청사항</label>
				<input name="rcv_request" type="text" maxlength="60">
			</li>
		</ul>
		<%} else {%>
		<h3 class="marb10 font-blue">택배배달 배송지 정보</h3>
		<input name="devl_type" id="devl_type1" type="radio" value="M" checked="checked" onclick="myAddr();" />
		<label for="devl_type1"><span></span>고객 정보동일</label>
		<input name="devl_type" id="devl_type2" type="radio" value="O" onclick="<%=(tagName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
		<label for="devl_type2"><span></span>최근배송지</label> 
		<input name="devl_type" id="devl_type3" type="radio" value="N" onclick="newAddr('T');" />
		<label for="devl_type3"><span></span>새 배송지</label> 
		<div class="divider"></div>   
		<ul class="form-regist">
			<li>
				<label>수령인</label>
				<input name="tag_name" class="ftfd" type="text" required label="받으시는분" value="<%=memName%>" maxlength="20" />
			</li>
			<li>
				<label>휴대폰</label>
				<div class="select-box">
					<select name="tag_hp1" id="tag_hp1" style="width:60px;" required label="휴대폰 번호">
						<option value="">선택</option>
						<option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
						<option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
						<option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
						<option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
						<option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
						<option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
					</select>
				</div>
				<input name="tag_hp2" type="number" style="width:60px;" value="<%=memHp2%>" required label="휴대폰 번호" maxlength="4">
				<input name="tag_hp3" type="number" style="width:60px;" value="<%=memHp2%>" required label="휴대폰 번호" maxlength="4">
			</li>
			<li>
				<label>전화번호</label>
				<div class="select-box">
					<select name="tag_tel1" id="tag_tel1" style="width:60px;">
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
				</div>
				<input name="tag_tel2" type="number" style="width:60px;" value="<%=memTel2%>" maxlength="4">
				<input name="tag_tel3" type="number" style="width:60px;" value="<%=memTel2%>" maxlength="4">
			</li>
			<li>
				<label>주소</label>
					<input name="tag_zipcode" id="tag_zipcode" type="number" style="width:100px;" value="<%=memZipcode%>" required label="우편번호" readonly maxlength="6" />
					<a href="javascript:;" onclick="fnAddressPop('0002');" class="ui-btn ui-mini ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">우편번호</span></span></a>
					<br />
					<input name="tag_addr1" id="tag_addr1" type="text" style="width:100%;" value="<%=memAddr1%>" required label="기본주소" readonly maxlength="50" />
					<br />
					<input name="tag_addr2" type="text" style="width:100%" value="<%=memAddr2%>" required label="상세주소" maxlength="50">
			</li>
			<li>
				<label>요청사항</label>
				<input name="tag_required" type="text" maxlength="60" />
			</li>
		</ul>
		<%}%>
		<div class="divider"></div> 
		<div id="payBtn">
			<h2 class="ui-title">결제수단</h2> 
			<input type="radio" id="10" name="pay_type" required label="결제수단선택" value="10" onclick="viewDiv('pay_type10');" />
			<label for="10"><span></span>신용카드</label>
			<input type="radio" id="20" name="pay_type" required label="결제수단선택" value="20" onclick="viewDiv('pay_type20');" />
			<label for="20"><span></span>실시간 계좌이체</label>   
			<input type="radio" id="30" name="pay_type" required label="결제수단선택" value="30" onclick="viewDiv('pay_type30');" />
			<label for="30"><span></span>가상계좌</label>
		</div>
		<div id="pay_type10" style="display: none;" class="paymethod">
		</div>
		<div id="pay_type20" style="display: none;" class="paymethod">
		</div>
		<div id="pay_type30" style="display: none;" class="paymethod">
			<p class="guide">
				- 일배상품의 경우 선택하신 첫 배송일 D-6일까지 입금이 안될 시 주문이 자동취소됩니다.<br />
				- 택배상품은 결제완료 후 2-5일 이내에 받아보실 수 있습니다.
			</p>
		</div>
		<div style="text-align:center;color:red;font-size:16px;font-weight:bold;display:none" id="pay_ing">
			결제 처리중입니다. 잠시만 기다려주십시오...
		</div>
		<div class="divider"></div> 
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="javascript:;" onclick="history.back();" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">이전페이지</span></span></a></td>
					<td><a href="javascript:;" onclick="ckForm('mobile')" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">결제하기</span></span></a></td>
				</tr>
			</table>
		</div>
		<div class="divider"></div>   
	</div>
	<!-- End Content -->
	<div class="ui-footer">
	<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
<input type="hidden" name="mode" value="<%=mode%>" />
<input type="hidden" name="oyn" value="<%=oyn%>" />
<input type="hidden" name="order_num" value="<%=orderNum%>" />
<input type="hidden" name="goods_price" value="<%=orderPrice%>" />
<input type="hidden" name="pay_price" id="pay_price" value="<%=totalPrice%>"/>
<input type="hidden" name="coupon_ftprice" id="coupon_ftprice" />
<input type="hidden" name="email" value="<%=memEmail%>" />
<input type="hidden" name="devl_price" value="<%=devlPrice%>"/>

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
		alert("고객님의 일배 배송지는 배송이 불가능한 지역입니다.\n새로운 배송지를 입력해주세요.");
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

function showCoupons() {
	$(".fprice").each(function() {
		gcdArr			= $(this).attr("id").split("_");
		gcd				= gcdArr[2];
		$("#coupon_fprice_"+ gcd).val(0);
		$("#coupon_fnum_"+ gcd).val("");
	});
	$("#coupon_price_txt").val("");
	$("#coupon_ftprice").val(0);
	$(".minus").text("0원");
	var tprice		= parseInt($("#goodsPrice").val()) + parseInt($("#devlPrice").val()) + parseInt($("#bagPrice").val());
	if (tprice < 1) tprice = 0;
	$("#tprice").text(commaSplit(tprice)+"원");
	$("#pay_price").val(tprice);
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