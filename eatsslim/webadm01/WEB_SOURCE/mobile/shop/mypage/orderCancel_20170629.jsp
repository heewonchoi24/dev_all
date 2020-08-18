<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
String orderNum			= ut.inject(request.getParameter("ono"));
int goodsPrice			= 0;
payPrice			= 0;
int couponPrice			= 0;
int devlPrice			= 0;
String payType			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String orderDate		= "";
String rcvHp		= "";
String pgTid		= "";
String orderName = "";
int orderCnt		= 0;
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT DATE_FORMAT(ORDER_DATE, '%Y.%m.%d %H:%i') ORDER_DATE, GOODS_PRICE, PAY_PRICE, ORDER_NAME, ";
query		+= "	COUPON_PRICE, DEVL_PRICE, PAY_TYPE, PG_CARDNUM, PG_FINANCENAME, PG_ACCOUNTNUM, ORDER_STATE, RCV_HP, PG_TID";
query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
try {
rs			= stmt.executeQuery(query);
} catch(Exception e) {
out.println(e+"=>"+query);
if(true)return;
}

if (rs.next()) {
	goodsPrice		= rs.getInt("GOODS_PRICE");
	payPrice		= rs.getInt("PAY_PRICE");
	couponPrice		= rs.getInt("COUPON_PRICE");
	devlPrice		= rs.getInt("DEVL_PRICE");
	payType			= rs.getString("PAY_TYPE");
	pgCardNum		= ut.isnull(rs.getString("PG_CARDNUM"));
	pgFinanceName	= ut.isnull(rs.getString("PG_FINANCENAME"));
	pgAccountNum	= ut.isnull(rs.getString("PG_ACCOUNTNUM"));
	orderDate		= rs.getString("ORDER_DATE");
	rcvHp			= rs.getString("RCV_HP");
	pgTid			= rs.getString("PG_TID");
	orderName		= rs.getString("ORDER_NAME");
}
%>
<script type="text/javascript">
function orderCancel(ono) {
	var msg = "정말로 주문을 취소하시겠습니까?"
	if(confirm(msg)){
		document.frm_cancel.submit();
	}else{
		return;
	}
}
</script>
</head>
<body>
<form name="frm_cancel" method="post" action="/proc/order_edit_proc.jsp">
	<input type="hidden" name="mode" value="cancel">
	<input type="hidden" name="code" value="CD1">
	<input type="hidden" name="order_num" id="order_num" value="<%=orderNum%>">
	<input type="hidden" name="pay_type" id="pay_type" value="<%=payType%>">
	<input type="hidden" name="LGD_RFPHONE" id="LGD_RFPHONE" value="<%=rcvHp%>">
	<input type="hidden" name="item_cnt" id="item_cnt" value="<%=orderCnt%>">
	<input type="hidden" name="rprice" id="rprice" value="<%=payPrice%>">
	<input type="hidden" name="rfee" id="rfee" value="1">
	<input type="hidden" name="pgTID" id="pgTID" value="<%=pgTid%>">
	<input type="hidden" name="cancelFrom" value="mobile" />

	<div id="wrap">
		<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
			<%@ include file="/mobile/common/include/inc-header.jsp"%>
		</div>
		<!-- End ui-header -->
		<!-- Start Content -->
		<div id="content">
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">주문취소</span></span></h1>
			<dl class="itemlist">
				<dt>주문번호</dt>
				<dd><%=orderNum%></dd>
				<dt>주문일자</dt>
				<dd class="f14"><%=orderDate%></dd>
				<dt>주문자명</dt>
				<dd><%=orderName%></dd>						
				<div class="divider-line"></div>
				<dt>결제방법</dt>
				<dd><%=ut.getPayType(payType)%></dd>
				<dt>상품금액</dt>
				<dd><%=nf.format(goodsPrice)%>원</dd>
				<!--dt>상품할인</dt>
				<dd>(-)<%=nf.format(couponPrice)%>원</dd>
				<dt>배송비</dt>
				<dd>(+)<%=nf.format(devlPrice)%>원</dd-->			
			</dl>
			<div class="divider"></div>
			<dl class="itemlist redline">
				<dt class="f16">총 결제금액</dt>
				<dd class="f16 font-orange"><%=nf.format(payPrice)%>원</dd>
			</dl>
			<div class="divider"></div>
			<%if (payType.equals("30")) {%>
			<dl class="itemlist">
				<dt>취소사유선택</dt>
				<dd>
				<select name="reason_type" id="reason_type" required label="취소사유선택">
					<option value="">취소사유를 선택</option>
					<option value="1">구매의사취소</option>
					<option value="2">상품 잘못 주문</option>
					<option value="3">상품정보 상이</option>
					<option value="4">서비스 및 상품 불만족</option>
				</select>
				</dd>
				<div class="divider-line"></div>
				<dt>환불계좌은행</dt>
				<dd><select name="bankName" id="bankName"><option value="경남">경남</option>
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
				</select></dd>
				<div class="divider-line"></div>
				<dt>환불계좌 예금주</dt>
				<dd><input type="text" class="input1" maxlength="30" name="bankUser" id="bankUser" /></dd>
				<dt>환불계좌번호</dt>
				<dd><input type="text" class="input1" maxlength="100" onBlur="this.value=this.value.replace(/[^0-9-]/g,'');" name="bankAccount" id="bankAccount" /></dd>
				<%}%>
			</dl>
			<div class="divider"></div>		
			<a href="javascript:;" onclick="orderCancel('<%=orderNum%>');" class="ui-btn ui-mini ui-btn-up-b floatright"><span class="ui-btn-inner"><span class="ui-btn-text">취소신청</span></span></a>	
			<div class="divider"></div>
		</div>
		<!-- End Content -->
		<div class="ui-footer">
			<%@ include file="/mobile/common/include/inc-footer.jsp"%>
		</div>
	</div>
</form>
</body>
</html>