<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
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
String devlType		= "";
String devlDay		= "";
String devlWeek		= "";
String devlDate		= "";
String devlPeriod	= "";
int price			= 0;
String buyBagYn		= "";
String gubun1		= "";
String groupName	= "";
String groupCode	= "";
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
int zipCnt			= 0;
String devlCheck	= "";
int couponCnt		= 0;

SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
String orderNum		= "ESS" + dt.format(new Date()) + "001";
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
String memZipcode1		= "";
String memZipcode2		= "";
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
	if (memZipcode.length() == 6) {
		memZipcode1	= memZipcode.substring(0,3);
		memZipcode2	= memZipcode.substring(3,6);
	}
	memAddr1	= rs.getString("ADDRESS");
	memAddr2	= rs.getString("ADDRESS_DETAIL");	
}
rs.close();

String rcvName		= "";
String rcvZipcode	= "";
String rcvZipcode1	= "";
String rcvZipcode2	= "";
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
String tagZipcode1	= "";
String tagZipcode2	= "";
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
		tmp			= memHp.split("-");
		rcvHp1		= tmp[0];
		rcvHp2		= tmp[1];
		rcvHp3		= tmp[2];
	}
	rcvZipcode	= rs.getString("RCV_ZIPCODE");
	if (rcvZipcode.length() == 6) {
		rcvZipcode1	= rcvZipcode.substring(0,3);
		rcvZipcode2	= rcvZipcode.substring(3,6);
	}
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
		tmp			= memHp.split("-");
		tagHp1		= tmp[0];
		tagHp2		= tmp[1];
		tagHp3		= tmp[2];
	}
	tagZipcode	= rs.getString("RCV_ZIPCODE");
	if (tagZipcode.length() == 6) {
		tagZipcode1	= tagZipcode.substring(0,3);
		tagZipcode2	= tagZipcode.substring(3,6);
	}
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

query		= "SELECT C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK, DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN, G.GUBUN1, G.GROUP_CODE, G.GROUP_NAME, G.CART_IMG";
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
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">주문결제</span></span></h1>
		<h2 class="ui-title">주문리스트 확인<span class="ui-icon-right"></span></h2>
		<%
		if (tcnt > 0) {
			int i = 0;
			while (rs.next()) {
				buyQty		= rs.getInt("BUY_QTY");
				devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
				gubun1		= rs.getString("GUBUN1");
				groupName	= rs.getString("GROUP_NAME");
				groupCode	= rs.getString("GROUP_CODE");
				if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
					devlDate	= rs.getString("WDATE");
					buyBagYn	= rs.getString("BUY_BAG_YN");
					devlDay		= rs.getString("DEVL_DAY");
					devlWeek	= rs.getString("DEVL_WEEK");
					devlPeriod	= devlWeek +"주("+ devlDay +"일)";
					price		= rs.getInt("PRICE");
					goodsPrice	= price * buyQty;
					dayPrice	+= goodsPrice;
				} else {
					devlDate	= "-";
					buyBagYn	= "N";
					devlPeriod	= "-";
					price		= rs.getInt("PRICE");
					goodsPrice	= price * buyQty;
					tagPrice	+= goodsPrice;
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
					couponCnt		= rs1.getInt("COUPON_CNT");
				}

				rs1.close();
		%>
		<dl class="itemlist">
			<dt style="width:70%;">퀴진한식 3식/1개<p class="font-gray">식사기간:2주(5일) / 첫배송일 : 2013.10.24</p></dt>
			<dd style="width:30%;">104,400원</dd>
		</dl>
		<%
				}

				i++;
			}

			rs.close();

			if (dayPrice > 0) {
				// 배송 가능 지역 확인
				
				query		= "SELECT COUNT(SEQNO) FROM PHIBABY.V_ZIPCODE WHERE ZIPCODE = '"+ memZipcode +"'";
				rs_phi		= stmt_phi.executeQuery(query);

				if (rs_phi.next()) {
					zipCnt		= rs_phi.getInt(1);
				}

				rs_phi.close();

				if (zipCnt < 1) {
					devlCheck		= "N";
				} else {
					devlCheck		= "Y";
				}
			}

			orderPrice		= dayPrice + tagPrice + bagPrice;
			goodsTprice		= dayPrice + tagPrice;
			if (tagPrice > 0 && tagPrice < 40000) {
				devlPrice		= defaultDevlPrice;
			} else {
				devlPrice		= 0;
			}

			totalPrice		= orderPrice + devlPrice;
		}

		rs.close();
		%>
		<h2 class="ui-title">할인혜택<span class="ui-icon-right"></span></h2>
		<table class="form-line" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="60"><label>쿠폰등록</label></td>
				<td style="padding-right:20px;">
				<input type="text" name="textfield" id="textfield" style="width:100%;"></td>
				<td width="40"><a href="/mobile/shop/popup/holdCoupon.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-up-b iframe"><span class="ui-btn-inner"><span class="ui-btn-text">등록</span></span></a></td>
			</tr>
		</table>
		<p class="guide">오프라인 쿠폰을 발급받으신 분은 이곳에서 쿠폰을 등록한 다음 사용하세요.</p>
		<table class="form-line" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="60"><label>쿠폰할인</label></td>
				<td style="padding-right:20px;"><input type="text" name="textfield" id="textfield" style="width:75%;">원</td>
				<td width="60"><a href="/mobile/shop/popup/couponCheck.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-up-b iframe"><span class="ui-btn-inner"><span class="ui-btn-text">조회 및 적용</span></span></a></td>
			</tr>
		</table>
		<p class="guide">사용가능 쿠폰 <strong class="font-blue">0</strong>장</p>
		<div class="divider"></div>
		<h2 class="ui-title">주문리스트 확인<span class="ui-icon-right"></span></h2> 
		<dl class="itemlist">
			<dt>총 상품금액</dt>
			<dd>109,400원</dd>
			<dt>배송료(택배상품)</dt>
			<dd>(+) 0원</dd>
			<dt>보냉가방</dt>
			<dd>(+) 0원</dd> 
			<dt>할인혜택</dt>
			<dd>(-) 0원</dd>
		</dl>
		<div class="clear"></div>
		<dl class="itemlist redline">
			<dt class="f16">총 결제금액</dt>
			<dd class="f16 font-orange">109,400원</dd>
		</dl>
		<div class="divider"></div> 
		<h2 class="ui-title">배송지 정보<span class="ui-icon-right"></span></h2>  
		<h3 class="marb10 font-blue">일일배달 배송지 정보</h3>
		<input type="radio" id="c1" name="cc" />
		<label for="c1"><span></span>고객 정보동일</label>
		<input type="radio" id="c2" name="cc" />
		<label for="c2"><span></span>최근배송지</label> 
		<input type="radio" id="c3" name="cc" />
		<label for="c3"><span></span>새 배송지</label> 
		<div class="divider"></div>   
		<ul class="form-regist">
			<li><label>수령인</label><input name="" type="text"></li>
			<li>
			<label>휴대폰</label>
			<div class="select-box">
				<select>
					<option value="1">010</option>
					<option value="2">011</option>
				</select>
			</div>
			<input name="" type="number" style="width:60px"> <input name="" type="number" style="width:60px" />
		</li>
		<li>
			<label>전화번호</label>
			<div class="select-box">
				<select>
					<option value="1">02</option>
					<option value="2">031</option>
				</select>
			</div>
			<input name="" type="number" style="width:60px"> <input name="" type="number" style="width:60px" />
		</li>
		<li>
			<label>주소</label>
			<span style="display:inline-block; width:76%;">
			<input name="" type="number" style="width:50px" />
			<input name="" type="number" style="width:60px" />
			<a href="/mobile/shop/popup/zipcode.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-up-b iframe"><span class="ui-btn-inner"><span class="ui-btn-text">우편번호</span></span></a>
			<br />
			<input name="" type="text" style="width:100%" />
			<br />
			<input name="" type="text" style="width:100%" />
			</span>
		</li>
		<li>
			<label>수령방법</label>
			<input type="radio" id="cn1" name="cc" />
			<label for="cn1"><span></span>현관앞 비치</label>
			<input type="radio" id="cn2" name="cc" />
			<label for="cn2"><span></span>경비실 위탁수령</label> 
		</li>
		<li>
			<label>출입시 비밀번호</label>
			<input type="radio" id="cn1" name="cc" />
			<label for="cn1"><span></span>있음</label><input name="" type="number" style="width:50px">
			<input type="radio" id="cn2" name="cc" />
			<label for="cn2"><span></span>없음</label> 
		</li>
			<li><label>요청사항</label><input name="" type="text"></li>
	</ul>
	<h3 class="marb10 font-blue">택배배달 배송지 정보</h3>
	<input type="radio" id="ct3" name="ccd" />
	<label for="ct3"><span></span>고객 정보동일</label>
	<input type="radio" id="ct4" name="ccd" />
	<label for="ct4"><span></span>최근배송지</label>
	<input type="radio" id="ct5" name="ccd" />
	<label for="ct5"><span></span>새 배송지</label> 
	<div class="divider"></div>   
	<ul class="form-regist">
		<li><label>수령인</label><input name="" type="text"></li>
		<li>
			<label>휴대폰</label>
			<div class="select-box">
				<select>
					<option value="1">010</option>
					<option value="2">011</option>
				</select>
			</div>
			<input name="" type="number" style="width:60px"> <input name="" type="number" style="width:60px">
		</li>
		<li>
			<label>전화번호</label>
			<div class="select-box">
				<select>
					<option value="1">02</option>
					<option value="2">031</option>
				</select>
			</div>
			<input name="" type="number" style="width:60px"> <input name="" type="number" style="width:60px">
		</li>
		<li>
			<label>주소</label>
			<span style="display:inline-block; width:76%;">
			<input name="" type="number" style="width:50px"> <input name="" type="number" style="width:60px"><a href="/mobile/shop/popup/zipcode.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-up-b iframe"><span class="ui-btn-inner"><span class="ui-btn-text">우편번호</span></span></a>
			<br />
			<input name="" type="text" style="width:100%">
			<br />
			<input name="" type="text" style="width:100%">
			</span>
		</li>
		<li><label>요청사항</label><input name="" type="text"></li>
	</ul>
	<div class="divider"></div> 
	<h2 class="ui-title">결제수단<span class="ui-icon-right"></span></h2> 
	<input type="radio" id="c5" name="ccv" />
	<label for="c5"><span></span>신용카드</label>
	<input type="radio" id="c6" name="ccv" />
	<label for="c6"><span></span>실시간 계좌이체</label>   
	<input type="radio" id="c7" name="ccv" />
	<label for="c7"><span></span>가상계좌</label> 
	<div class="divider"></div> 
	<div class="grid-navi">
		<table class="navi" border="0" cellspacing="10" cellpadding="0">
			<tr>
				<td><a href="#" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">이전페이지</span></span></a></td>
				<td><a href="/mobile/shop/payment.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">결제하기</span></span></a></td>
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
</body>
</html>