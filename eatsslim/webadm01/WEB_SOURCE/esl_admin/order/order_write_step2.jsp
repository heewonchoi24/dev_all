<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
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
String pgCloseDate	= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
String orderNum		= "ESS" + dt.format(new Date()) + "001";
SimpleDateFormat cdt	= new SimpleDateFormat("yyyyMMdd");
Date date			= null;
Calendar cal		= Calendar.getInstance();
String cDate		= dt.format(cal.getTime());
Date date1			= dt.parse(cDate);
Date date2			= null;
int compare			= 0;
long diff			= 0;
long diffDays		= 0;
String imgUrl		= "";
NumberFormat nf = NumberFormat.getNumberInstance();
String productName		= "";
String eslMemberId	= "0";

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

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:4,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
	</script><link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-order.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 주문관리 &gt; <strong>관리자 주문등록</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<h3 class="tit_style1 mt_25">주문내역</h3>
				<table class="table02 mt_5" border="1" cellspacing="0">
					<colgroup>
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="10%" />
						<col width="6%" />
						<col width="10%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><span>배송구분</span></th>
							<th scope="col"><span>상품명/옵션제품명</span></th>
							<th scope="col"><span>배송기간</span></th>
							<th scope="col"><span>첫배송일</span></th>
							<th scope="col"><span>수량</span></th>
							<th scope="col"><span>판매가격</span></th>
							<th scope="col"><span>합계</span></th>
						</tr>
					</thead>
					<tbody>
					<%
					if (tcnt > 0) {
						i = 0;
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
							if (i > 0) {
								productName	= groupName+" 외 "+ i +"건";
							} else {
								productName	= groupName;
							}
					%>
						<tr>
							<td><%=devlType%></td>
							<td>
								<div class="orderName">
									<img class="thumbleft" src="<%=imgUrl%>" />
									<p class="catetag">
										<%=ut.getGubun1Name(gubun1)%>
									</p>
									<h4>
										<%=groupName%>
									</h4>
								</div>
							</td>
							<td><%=devlPeriod%></td>
							<td><%=devlDate%></td>
							<td><%=buyQty%></td>
							<td><%=nf.format(price)%>원</td>
							<td>
								<div class="itemprice"><%=nf.format(goodsPrice)%>원</div>
							</td>
						</tr>
					<%
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
					%>
					</tbody>
				</table>
				<div class="price_infor">
					<ul class="price">
						<li class="first">상품금액<br /><%=nf.format(goodsTprice)%>원</li>
						<li>
							<div class="ico_box"><img src="../images/common/ico/ico_plus.gif" alt="" /></div>
							<p class="txt">배송비<br /><%=nf.format(devlPrice)%>원</p>
						</li>
						<li>
							<div class="ico_box"><img src="../images/common/ico/ico_plus.gif" alt="" /></div>
							<p class="txt">보냉가방<br /><%=nf.format(bagPrice)%>원</p>
						</li>
						<li>
							<div class="ico_box"><img src="../images/common/ico/ico_minus.gif" alt="" /></div>
							<p class="txt">상품쿠폰<br />0원</p>
						</li>
					</ul>
					<div class="result" style="width:200px;">
						<div class="ico_box"><img src="../images/common/ico/ico_result.gif" alt="" /></div>
						<p>최종결제금액<br /><%=nf.format(totalPrice)%>원</p>
					</div>
				</div>
				<form name="frm_write" id="frm_write" method="post" action="order_write_db.jsp">
					<input type="hidden" name="mode" value="<%=mode%>" />
					<input type="hidden" name="oyn" value="<%=oyn%>" />
					<input type="hidden" name="order_num" value="<%=orderNum%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>받으시는분</span></th>
								<td>
									<input name="rcv_name" type="text" class="input1" required label="받으시는분" value="" maxlength="20" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>전화번호</span></th>
								<td>
									<select name="rcv_tel1" id="rcv_tel1" style="width:60px;">
										<option value="">선택</option>
									 	<option value="02">02</option>
									 	<option value="031">031</option>
									 	<option value="032">032</option>
									 	<option value="033">033</option>
									 	<option value="041">041</option>
									 	<option value="043">043</option>
									 	<option value="051">051</option>
									 	<option value="052">052</option>
									 	<option value="053">053</option>
									 	<option value="054">054</option>
									 	<option value="055">055</option>
									 	<option value="061">061</option>
									 	<option value="064">064</option>
									 	<option value="070">070</option>
									</select>
									-
									<input name="rcv_tel2" type="text" class="input1" style="width:70px;" value="" maxlength="4">
									-
									<input name="rcv_tel3" type="text" class="input1" style="width:70px;" value="" maxlength="4">
								</td>
							</tr>
							<tr>
								<th scope="row"><span>휴대폰 번호</span></th>
								<td>
									<select name="rcv_hp1" id="rcv_hp1" style="width:60px;" required label="휴대폰 번호">
										<option>선택</option>
										<option value="010">010</option>
									 	<option value="011">011</option>
									 	<option value="016">016</option>
									 	<option value="017">017</option>
									 	<option value="018">018</option>
									 	<option value="019">019</option>
									</select>
									-
									<input name="rcv_hp2" type="text" class="input1" style="width:70px;" value="" required label="휴대폰 번호" maxlength="4">
									-
									<input name="rcv_hp3" type="text" class="input1" style="width:70px;" value="" required label="휴대폰 번호" maxlength="4">
								</td>
							</tr>
							<tr>
								<th scope="row"><span>배송지 주소</span></th>
								<td>
									<input name="rcv_zipcode1" id="rcv_zipcode1" type="text" class="input1" style="width:50px;" value="" required label="우편번호" readonly maxlength="3" />
									-
                                    <input name="rcv_zipcode2" id="rcv_zipcode2" type="text" class="input1" style="width:50px;" value="" required label="우편번호" readonly maxlength="3" />
									<a href="javascript:;" onclick="window.open('../include/inc-popup-zipcode1.jsp','popup','width=450,height=370,resizable=no,scrollbars=yes');" class="function_btn"><span>우편번호 검색</span></a>
									<br />
									<input name="rcv_addr1" id="rcv_addr1" type="text" class="input1" style="width:340px; margin-top:5px;" value="" required label="기본주소" readonly maxlength="50" /><br />
									<input name="rcv_addr2" type="text" class="input1" style="width:340px; margin-top:5px;" value="" required label="상세주소" maxlength="50" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>수령방법</span></th>
								<td>
									<input name="rcv_type" type="radio" value="01" checked="checked">
									현관 앞 비치
									<input name="rcv_type" type="radio" value="02">
									경비실 위탁 수령
								</td>
							</tr>
							<tr>
								<th scope="row"><span>배송요청사항</span></th>
								<td><input type="text" name="rcv_request" class="input1" maxlength="60" style="width:400px;" /></td>
							</tr>
							<tr>
								<th scope="row"><span>금액</span></th>
								<td><input type="text" name="pay_price" id="pay_price" class="input1" value="<%=totalPrice%>" maxlength="7" /></td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_write)" class="function_btn"><span>주문하기</span></a>
					</div>
				</form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
</body>
</html>