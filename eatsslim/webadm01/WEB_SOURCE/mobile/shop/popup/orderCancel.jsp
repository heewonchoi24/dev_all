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
//int payPrice			= 0;
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
rs.close();
%>
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
<div class="pop-wrap">
  <div class="headpop">
    <h2>주문 취소</h2>
    <button id="cboxClose" type="button">close</button>
    <div class="clear"></div>
  </div>
  <div class="contentpop">
    <!--  
    <h2 class="ui-title">주문취소 상품</h2>
    <dl class="itemlist">
      <dt style="width:70%;">다이어트 식사 3식/1개
        <p class="font-gray">(퀴진A+퀴진B+알라까르떼COOL)</p>
      </dt>
      <dd style="width:30%;">104,400원</dd>
    </dl>
    <dl class="itemlist">
      <dt style="width:70%;">뷰티워터티/1BOX
        <p class="font-gray">(퀴진A+퀴진B+알라까르떼COOL)</p>
      </dt>
      <dd style="width:30%;">24,000원</dd>
    </dl>
    -->
    <h2 class="ui-title">결제정보 확인</h2>
    <dl class="itemlist">
      <dt style="width:70%;">결제방법</dt>
      <dd style="width:30%;"><%=ut.getPayType(payType)%></dd>
      <dt style="width:70%;">상품합계금액</dt>
      <dd style="width:30%;"><%=nf.format(goodsPrice)%>원</dd>
      <dt style="width:70%;">상품할인</dt>
      <dd style="width:30%;">(-) <%=nf.format(couponPrice)%>원</dd>
      <dt style="width:70%;">전체 배송비</dt>
      <dd style="width:30%;">(+) <%=nf.format(devlPrice)%>원</dd>
    </dl>
    <div class="divider"></div>
    <dl class="itemlist redline" style="margin:0 10px;">
      <dt class="f16">총 결제금액</dt>
      <dd class="f16 font-orange"><%=nf.format(payPrice)%>원</dd>
    </dl>
    <%if (payType.equals("30")) {%>
    <div class="divider"></div>
    <h2 class="ui-title">취소사유</h2>
    <dl class="itemlist">
      <dt style="width:30%;">취소사유</dt>
      <dd style="width:70%;">
          <ul class="form-line" style="margin:0;">
             <li>
             <div class="select-box">
            <select name="reason_type" id="reason_type" required label="취소사유선택">
				<option value="">취소사유를 선택</option>
				<option value="1">구매의사취소</option>
				<option value="2">상품 잘못 주문</option>
				<option value="3">상품정보 상이</option>
				<option value="4">서비스 및 상품 불만족</option>
            </select>
             </div>
            </li>
           </ul>  
      </dd>
      <div class="divider"></div>
      <dt style="width:30%;">환불계좌은행</dt>
      <dd style="width:70%;">
         <ul class="form-line" style="margin:0;">
             <li>
             <div class="select-box">
            <select name="bankName" id="bankName"><option value="경남">경남</option>
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
				</select>
             </div>
            </li>
           </ul>  
      </dd>
      <div class="divider"></div>
      <dt style="width:30%;">환불계좌 예금주</dt>
      <dd style="width:70%;">
         <ul class="form-line" style="margin:0;">
             <li><input type="text" class="input1" maxlength="30" name="bankUser" id="bankUser" /></li>
           </ul>
      </dd>
      <div class="divider"></div>
      <dt style="width:30%;">환불계좌번호</dt>
      <dd style="width:70%;">
         <ul class="form-line" style="margin:0;">
             <li><input type="text" class="input1" maxlength="100" onBlur="this.value=this.value.replace(/[^0-9-]/g,'');" name="bankAccount" id="bankAccount" /></li>
           </ul>
      </dd>
      <!-- <dt style="width:30%;">요청사항</dt>
      <dd style="width:70%;">
         <ul class="form-line" style="margin:0;">
             <li>
            <input name="" type="text" style="width:90%;">
        </li>
           </ul>
      </dd> -->
    </dl>
    <%}%>
    <div class="divider"></div>
    <div class="grid-navi" style="margin:0 10px;">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="javascript:;" class="ui-btn ui-btn-inline ui-btn-up-b" onclick="orderCancel('<%=orderNum%>');"><span class="ui-btn-inner"><span class="ui-btn-text">취소신청</span></span></a></td>
               </tr>
            </table>
        </div>
  </div>
  <!-- End contentpop -->
</div>
</form>
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
</body>
</html>
