<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
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
String cpColumns	= " C.ID, C.STDATE, C.LTDATE, CM.MEMBER_ID, CM.USE_YN, CM.COUPON_NUM, C.COUPON_NAME, C.SALE_TYPE, C.SALE_PRICE";
String cpTable		= " ESL_COUPON C, ESL_COUPON_MEMBER CM";
String cpWhere		= "";
String saleType		= "";
int salePrice		= 0;
int couponPrice		= 0;
int couponId		= 0;
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT COUNT(ID) FROM ESL_CART WHERE MEMBER_ID = '"+ eslMemberId +"' AND CART_TYPE = '"+ mode +"'"; //out.print(query1); if(true)return;
if (oyn.equals("Y")) {
	query		+= " AND ORDER_YN = 'Y'";
}
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta name="robots" content="noindex,nofollow,noarchive">

	<title>쿠폰 적용</title>

	<link rel="stylesheet" type="text/css" media="all" href="/common/css/layout.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/skeleton.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/color-theme.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.selectBox.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.lightbox.css" />

	<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/common/js/util.js"></script>
    <!--[if gte IE 9]>
	<style type="text/css">
	.gradient {filter: none;}
	</style>
    <![endif]-->
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2 class="floatleft" style="margin-right:25px;">쿠폰적용</h2>
		<p class="floatleft button small light"><a href="javascript:;" onclick="showList();">보유쿠폰보기</a></p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<h4>상품할인쿠폰</h4>
					<form name="frm_coupon">
						<table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>상품명</th>
								<th>쿠폰선택</th>
								<th>판매가격</th>
								<th>할인가격</th>
							</tr>
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
										payPrice	= price;// * buyQty;
										totalPrice1 += payPrice;
									} else {
										devlDate	= "-";
										buyBagYn	= "N";
										devlPeriod	= "-";
										price		= rs.getInt("PRICE");
										payPrice	= price;// * buyQty;
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
									query1		+= "		AND CM.COUPON_ID IN (SELECT COUPON_ID FROM ESL_COUPON_GOODS WHERE GROUP_CODE = '"+ groupCode +"')";
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
									//query1		+= " WHERE DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
									//query1		+= " AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
									try {
										rs1 = stmt1.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}

									if (tcnt1 > 0) {
							%>
							<tr>
								<td>
									<%=ut.getGubun1Name(gubun1)%><br />
									<%=ut.getGubun2Name(gubun2)%>(<%=groupName%>)
								</td>
								<td>
									<select name="coupon_code_<%=groupCode%>" id="coupon_code_<%=groupCode%>" onchange="setCoupon('<%=groupCode%>')" class="coupon_val">
										<option value="">선택</option>
										<%
										while (rs1.next()) {
											saleType	= rs1.getString("SALE_TYPE");
											salePrice	= rs1.getInt("SALE_PRICE");

											if (saleType.equals("W")) {
												couponPrice		= salePrice;
											} else {
												if (rs1.getInt("ID") == 446 || rs1.getInt("ID") == 447) {
													couponPrice		= Integer.parseInt(String.valueOf(Math.round((double)price * (double)salePrice / 100)));
												} else {
													couponPrice		= Integer.parseInt(String.valueOf(Math.round((double)payPrice * (double)salePrice / 100)));
												}
											}
										%>
										<option value="<%=rs1.getString("COUPON_NUM")+"|"+couponPrice+"|"+couponId%>"><%=rs1.getString("COUPON_NAME") +"("+ nf.format(couponPrice) +"원 할인)"%></option>
										<%
										}
										%>
									</select>
									<input type="hidden" id="coupon_price_<%=groupCode%>" class="coupon_price" value="0" />
								</td>
								<td class=""><%=nf.format(payPrice)%>원</td>
								<td class="last" id="coupon_<%=groupCode%>">0원 할인</td>
							</tr>
							<%
									}
								}

								rs.close();

								totalPrice3		= totalPrice1 + totalPrice2;
								/*
								전체상품 무료배송
								if (totalPrice2 > 0 && totalPrice2 < 40000) {
									devlPrice		= defaultDevlPrice;
								} else {
									devlPrice		= 0;
								}
								*/

								totalPrice		= totalPrice3 + devlPrice + bagPrice;
							}

							rs.close();
							%>
							<tr>
								<input type="hidden" name="coupon_tprice" id="coupon_tprice" value="0" />
								<td colspan="4" class="totalprice last">쿠폰 할인 합계 <span class="won padl50" id="coupon_tprice_txt">0원</span></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col">
					<h4>무료증정쿠폰</h4>
					<table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="last">
								적용 가능한 쿠폰이 없습니다.
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col center">
					<div class="button large dark">
						<a href="javascript:;" onclick="setCouponPrice()">쿠폰적용</a>
					</div>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col">
					<h4>사용하실 쿠폰을 선택한 후 적용 버튼을 누르세요.</h4>
					<ul class="check">
						<li>
							사용가능한 쿠폰 내역만 확인하실 수 있습니다. 보유 쿠폰 내역을 확인하시려면 보유쿠폰보기 버튼을 누르세요.<br />
							- 쿠폰조건(상품종류, 상품기간 등)에 맞지 않는 상품을 선택한 경우 쿠폰조회가 되지 않습니다.<br />
							(예, 퀴진 2주 주문가능한 쿠폰이나, 퀴진 4주 주문을 선택한 경우 쿠폰조회가 되지 않습니다.)
						</li>
						<li>한번 사용된 쿠폰은 다시 사용하실 수 없습니다. (교환/반품시 쿠폰 재사용 불가)</li>
						<li>한 개의 상품에 중복 쿠폰 사용은 불가합니다.</li>
					</ul>
				</div>
			</div>
			<!-- End row -->
		</div>
		<!-- End popup columns offset-by-one -->
	</div>
	<!-- End contentpop -->
</div>
<script type="text/javascript">
function setCoupon(gcd) {
	var selectVal		= $("#coupon_code_"+ gcd).val();
	if (!selectVal) {
		$("#coupon_"+ gcd).text("0원 할인");
		$("#coupon_code_"+ gcd).val("");
		$("#coupon_price_"+ gcd).val(0);
		getCouponPrice(gcd);
		return false;
	} else {
		var i			= 0;
		var selectArr	= selectVal.split("|");

		if (selectArr[2] == 99 || selectArr[2] == 100 || selectArr[2] == 101 || selectArr[2] == 102 || selectArr[2] == 103 || selectArr[2] == 108 || selectArr[2] == 109 || selectArr[2] == 111 || selectArr[2] == 115 || selectArr[2] == 117) {
		} else {
			$(".coupon_val").each(function() {
				if (selectVal == $(this).val() && $(this).attr("name") != "coupon_code_"+ gcd) {
					i++;
				}
			});
		}

		if (i > 0) {
			alert("이미 선택하신 쿠폰입니다.");
			$("#coupon_code_"+ gcd).val("");
			$("#coupon_"+ gcd).text("0원 할인");
			$("#coupon_price_"+ gcd).val(0);
			getCouponPrice(gcd);
		} else {			
			var couponPrice		= selectArr[1];
			$("#coupon_"+ gcd).text(commaSplit(couponPrice) + "원 할인");
			$("#coupon_price_"+ gcd).val(couponPrice);			
			getCouponPrice(gcd);
		}
	}
}

function getCouponPrice(gcd) {
	var couponTprice	= 0;	
	$(".coupon_price").each(function() {
		couponTprice = parseInt(couponTprice) + parseInt($(this).val());
	});
	$("#coupon_tprice").val(couponTprice);	
	$("#coupon_tprice_txt").text(commaSplit(couponTprice) + "원");
}

function setCouponPrice() {
	var couponCnt = 0;
	var couponPrice	= 0;
	
	
	$(".coupon_val").each(function() {
		if ($(this).val() != "") {
			couponCnt++;
		}
		
	});
	
	if (couponCnt > 1) {
		alert("한 주문에 하나의 쿠폰만 사용 가능합니다.");
	} else {
		$(".coupon_val").each(function() {
			valArr			= $(this).val().split("|");
			couponPrice		= parseInt(valArr[1]);
			gcdArr			= $(this).attr("id").split("_");
			gcd				= gcdArr[2];
			if ($(this).val()) {
				$("#coupon_fprice_"+ gcd, opener.document).val(couponPrice);
				$("#coupon_fnum_"+ gcd, opener.document).val(valArr[0]);
			} else {
				$("#coupon_fprice_"+ gcd, opener.document).val(0);
				$("#coupon_fnum_"+ gcd, opener.document).val("");
			}
		});	
		var couponTprice	= parseInt($("#coupon_tprice").val());
		$("#coupon_price_txt", opener.document).val(commaSplit(couponTprice));
		$("#coupon_ftprice", opener.document).val(couponTprice);
		$(".minus", opener.document).text(commaSplit(couponTprice)+ "원");
		var tprice		= parseInt($("#goodsPrice", opener.document).val()) + parseInt($("#devlPrice", opener.document).val()) + parseInt($("#bagPrice", opener.document).val()) - parseInt(couponTprice);
		if (tprice < 1) tprice = 0;
		$("#tprice", opener.document).text(commaSplit(tprice)+"원");
		$("#pay_price", opener.document).val(tprice);
		self.close();
	}
}

function showList() {
	opener.location.href = "/shop/mypage/couponList.jsp";
	self.close();
}
</script>
    <div id="floatMenu" style="display:none;">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</body>
</html>