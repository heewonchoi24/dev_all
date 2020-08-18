<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderNum		= ut.inject(request.getParameter("ono"));
String orderDate	= ut.inject(request.getParameter("odate"));

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
NumberFormat nf = NumberFormat.getNumberInstance();

String payType			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String rcvHp			= "";
String pgTid			= "";
String payYn			= ""; 
query		= "SELECT COUNT(ID) FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //총 레코드 수		
}
rs.close();

query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.ORDER_STATE, O.DEVL_PRICE, OG.COUPON_PRICE ";
query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID AND O.ORDER_NUM = OG.ORDER_NUM AND OG.ORDER_NUM = '"+ orderNum +"'";
query		+= " ORDER BY OG.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>주문취소</title>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>주문취소</h2>
		<p>주문을 취소하시겠습니까? 주문내역을 확인하시고 취소신청을 해주십시오.</p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4> 주문내역<span class="font-blue f14 padl50"><%=orderNum%></span> ㅣ <span class="f14"><%=orderDate%></span> </h4>
					</div>
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th class="none">택배구분</th>
							<th>상품명</th>
							<th>첫배송일</th>
							<th>수량</th>
							<th>상품금액</th>
							<th>배송비</th>
							<th>할인금액</th>
							<th class="last">주문상태</th>
						</tr>
						<%
						if (tcnt > 0) {
							while (rs.next()) {
								orderCnt	= rs.getInt("ORDER_CNT");
								devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
								price		= rs.getInt("PRICE");
								gubun1		= rs.getString("GUBUN1");
								groupName	= rs.getString("GROUP_NAME");
								couponPrice	= rs.getInt("COUPON_PRICE");
																
								if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
									devlDate	= rs.getString("WDATE");
									buyBagYn	= rs.getString("BUY_BAG_YN");
									devlDay		= rs.getString("DEVL_DAY");
									devlWeek	= rs.getString("DEVL_WEEK");
									devlPeriod	= devlWeek +"주("+ devlDay +"일)";
									price		= rs.getInt("PRICE");
									goodsPrice	= price * orderCnt;
									dayPrice += goodsPrice;
								} else {
									devlDate	= "-";
									buyBagYn	= "N";
									devlPeriod	= "-";
									devlPrice	= rs.getInt("DEVL_PRICE");
									price		= rs.getInt("PRICE");
									goodsPrice	= price * orderCnt;
									tagPrice	+= goodsPrice;
								}
						%>
						<tr>
							<td><%=devlType%></td>
							<td>
								<div class="orderName">
									<h5><%=groupName%></h5>
								</div>
							</td>
							<td><%=devlDate%></td>
							<td><%=orderCnt%></td>
							<td><%=nf.format(price)%>원</td>
							<td><%=nf.format(devlPrice)%>원</td>
							<td><%=nf.format(couponPrice)%>원</td>
							<td>
								<div class="font-blue">
									<%=ut.getOrderState(rs.getString("ORDER_STATE"))%>
								</div>
							</td>
						</tr>
						<%
								if (buyBagYn.equals("Y")) {
									bagPrice	+= defaultBagPrice * orderCnt;
						%>
						<tr>
							<td>일배</td>
							<td>
								<div class="orderName">
									<h5>보냉가방</h5>
								</div>
							</td>
							<td>-</td>
							<td>1</td>
							<td><%=nf.format(bagPrice)%>원</td>
							<td>0원</td>
							<td>0원</td>
							<td>
								<div class="font-blue">
									<%=ut.getOrderState(rs.getString("ORDER_STATE"))%>
								</div>
							</td>
						</tr>
						<%
								}

								if (gubun1.equals("01") && Integer.parseInt(orderDate.replace(".", "")) < 20131031) {
						%>
						<tr>
							<td>증정</td>
							<td>
								<div class="orderName">
									<h5>쉐이크믹스(2포)</h5>
								</div>
							</td>
							<td>-</td>
							<td>1</td>
							<td>0원</td>
							<td>0원</td>
							<td>0원</td>
							<td>
								<div class="font-blue">
									<%=ut.getOrderState(rs.getString("ORDER_STATE"))%>
								</div>
							</td>
						</tr>
						<%
								}
							}

							rs.close();
						}
						%>
					</table>
					<!-- End orderList -->
				</div>
			</div>
			<!-- End row -->
			<form method="post" name="frm" action="/proc/order_edit_proc.jsp">
				<%
				query		= "SELECT ";
				query		+= "	PAY_PRICE, PAY_TYPE, RCV_HP, PG_CARDNUM, PG_FINANCENAME, PG_ACCOUNTNUM, PG_TID, PAY_YN ";
				query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
				try {
					rs			= stmt.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs.next()) {
					payPrice		= rs.getInt("PAY_PRICE");
					payType			= rs.getString("PAY_TYPE");
					pgCardNum		= rs.getString("PG_CARDNUM");
					pgFinanceName	= rs.getString("PG_FINANCENAME");
					pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
					rcvHp			= rs.getString("RCV_HP");
					pgTid			= rs.getString("PG_TID");
					payYn			= rs.getString("PAY_YN");
				}
				%>
				<input type="hidden" name="mode" value="">
				<input type="hidden" name="order_num" value="<%=orderNum%>">
				<input type="hidden" name="code" value="">
				<input type="hidden" name="pay_type" id="pay_type" value="<%=payType%>">
				<input type="hidden" name="LGD_RFPHONE" value="<%=rcvHp%>">
				<input type="hidden" name="payYn" value="<%=payYn%>">
				<div class="row">
					<div class="one last col">
						<div class="sectionHeader">
							<h4>취소사유</h4>
						</div>
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>취소사유선택</th>
								<td>
									<select name="reason_type" id="reason_type" style="width:200px;" required label="취소사유선택">
										<option value="">취소사유를 선택</option>
										<option value="1">구매의사취소</option>
										<option value="2">상품 잘못 주문</option>
										<option value="3">상품정보 상이</option>
										<option value="4">서비스 및 상품 불만족</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>
									취소사유 및<br />
									기타 요청사항
								</th>
								<td>
									<input type="text" name="reason" id="reason" style="width:500px;" maxlength="60" />
									<p class="font-gray">입력글자는 최대 한글60자, 영문/숫자 120자까지 가능합니다.</p>
								</td>
							</tr>
							<%if (payType.equals("30")) {%>
							<tr>
								<th>환불계좌은행</th>
								<td>
									<select name="bankName" id="bankName" style="width:172px;">
										<!--<option value="경남은행">경남은행</option>
										<option value="광주은행">광주은행</option>
										<option value="국민은행">국민은행</option>
										<option value="기업은행">기업은행</option>
										<option value="농협">농협</option>
										<option value="대구은행">대구은행</option>
										<option value="도이치뱅크">도이치뱅크</option>
										<option value="부산은행">부산은행</option>
										<option value="산업은행">산업은행</option>
										<option value="상호저축은행">상호저축은행</option>
										<option value="새마을금고">새마을금고</option>
										<option value="수협중앙회">수협중앙회</option>
										<option value="신용협동조합">신용협동조합</option>
										<option value="신한은행">신한은행</option>
										<option value="외환은행">외환은행</option>
										<option value="우리은행">우리은행</option>
										<option value="우체국">우체국</option>
										<option value="전북은행">전북은행</option>
										<option value="제주은행">제주은행</option>
										<option value="하나은행">하나은행</option>
										<option value="한국시티은행">한국시티은행</option>
										<option value="HSBC">HSBC</option>
										<option value="SC제일은행">SC제일은행</option>-->
										<option value="경남">경남</option>
										<option value="국민">국민</option>
										<option value="기업">기업</option>
										<option value="농협">농협</option>
										<option value="대구">대구</option>
										<option value="부산">부산</option>
										<option value="수협">수협</option>
										<option value="신한">신한</option>
										<option value="외환">외환</option>
										<option value="우리">우리</option>
										<option value="우체국">우체국</option>
										<option value="하나">하나</option>
										<option value="새마을금고">새마을금고</option>
										<option value="카카오뱅크">카카오뱅크</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>환불계좌 예금주</th>
								<td><input type="text" class="input1" style="width:94px;" maxlength="30" name="bankUser" id="bankUser" /></td>
							</tr>
							<tr>
								<th>환불계좌번호</th>
								<td><input type="text" class="input1" style="width:144px;" maxlength="100" onBlur="this.value=this.value.replace(/[^0-9-]/g,'');" name="bankAccount" id="bankAccount" /></td>
							</tr>
							<%}%>
						</table>
						<!-- End inputfield -->
					</div>
				</div>
				<!-- End row -->
				<div class="row">
					<div class="one last col">
						<div class="sectionHeader">
							<h4>결제정보</h4>
						</div>
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>결제방법</th>
								<td><%=ut.getPayType(payType)%></td>
							</tr>
							<tr>
								<th>결제정보</th>
								<td><%=ut.isnull(pgFinanceName)%></td>
							</tr>
						</table>
						<!-- End inputfield -->
					</div>
				</div>
				<!-- End row -->
				<div class="row">
					<div class="one last col">
						<div class="sectionHeader">
							<h4>환불금액</h4>
						</div>
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<!--tr>
								<th>결제방법</th>
								<td>상품금액:<%=nf.format(totalPrice)%>원 - 할인금액:0원 = <%=nf.format(totalPrice)%>원</td>
							</tr>
							<tr>
								<th>결제정보</th>
								<td>50,000원(총20일 중 5일 취소)</td>
							</tr-->
							<tr>
								<th>결제정보</th>
								<td><span class="font-maple"><%=nf.format(payPrice)%>원</span></td>
							</tr>
						</table>
						<!-- End inputfield -->
						<p>- 주문 취소를 하시게 되면, 주문 시 적용하셨던 쿠폰은 소멸되며, 재발행 되지 않습니다.</p>
						<p>- 예금주명은 주문자명과 같게 자동적으로 설정 됩니다.</p>
						<p>- 카드사별로 실제 취소일은 상이할 수 있습니다.</p>
					</div>
				</div>
				<input type="hidden" name="item_cnt" value="<%=orderCnt%>">
				<input type="hidden" name="rprice" value="<%=payPrice%>">
				<input type="hidden" name="rfee" value="0">
				<input type="hidden" name="pgTID" value="<%=pgTid%>">
			</form>
			<!-- End row -->
			<div class="row">
				<div class="one last col center">
					<div class="button large dark">
						<a href="javascript:;" onclick="orderCancel();">취소신청</a>
					</div>
				</div>
			</div>
			<!-- End row -->
		</div>
		<!-- End popup columns offset-by-one -->
	</div>
	<!-- End contentpop -->
</div>
<script type="text/javascript">
$('html').bind('keypress', function(e){
   if(e.keyCode == 13)   {
      return false;
   }
});

function orderCancel(){
	var f	= document.frm;
	if (!$.trim($("#reason_type").val())) {
		alert("취소사유를 선택하세요.");
		$("#reason_type").focus();
		return;
	} else if ($("#pay_type").val() == "30") {
		if (!$.trim($("#bankName").val())) {
			alert("환불계좌은행을 선택하세요.");
			$("#bankName").focus();
			return;
		} else if (!$.trim($("#bankUser").val())) {
			alert("환불계좌 예금주를 입력하세요.");
			$("#bankUser").focus();
			return;
		} else if (!$.trim($("#bankAccount").val())) {
			alert("환불계좌번호를 입력하세요.");
			$("#bankAccount").focus();
			return;
		}
	}
	if(confirm('정말 취소하시겠습니까?') ){
		f.mode.value="cancel";
		f.code.value="CD1";
		f.submit();	
	}
}
</script>
</body>
</html>