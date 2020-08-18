<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

if (eslMemberId == null || eslMemberId.equals("")) {
%>
<script type="text/javascript">
alert("로그인을 해주세요.");
parent.document.location.href = "/index.jsp";
</script>
<%
	if (true) return;
}

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String query2		= "";
Statement stmt2		= null;
ResultSet rs2		= null;
stmt2				= conn.createStatement();
Statement stmt2_phi	= null;
ResultSet rs2_phi	= null;
stmt2_phi			= conn_phi.createStatement();
String orderNum		= ut.inject(request.getParameter("order_num"));
String orderName	= eslMemberName;
String email		= ut.inject(request.getParameter("email"));
// 일배 배송 정보
String rcvName		= ut.inject(request.getParameter("rcv_name"));
String rcvHp1		= ut.inject(request.getParameter("rcv_hp1"));
String rcvHp2		= ut.inject(request.getParameter("rcv_hp2"));
String rcvHp3		= ut.inject(request.getParameter("rcv_hp3"));
String rcvHp		= "";
if (rcvHp1 != null && rcvHp1.length() > 0) {
	rcvHp				= rcvHp1 +"-"+ rcvHp2 +"-"+ rcvHp3;
}
String rcvTel		= "";
String rcvTel1		= ut.inject(request.getParameter("rcv_tel1"));
String rcvTel2		= ut.inject(request.getParameter("rcv_tel2"));
String rcvTel3		= ut.inject(request.getParameter("rcv_tel3"));
if (rcvTel1 != null && rcvTel1.length() > 0) {
	rcvTel				= rcvTel1 +"-"+ rcvTel2 +"-"+ rcvTel3;
}
String rcvZipcode	= "";
String rcvZipcode1	= ut.inject(request.getParameter("rcv_zipcode1"));
String rcvZipcode2	= ut.inject(request.getParameter("rcv_zipcode2"));
if (rcvZipcode1 != null && rcvZipcode1.length() > 0) {
	rcvZipcode			= rcvZipcode1+rcvZipcode2;
}
String rcvAddr1		= ut.inject(request.getParameter("rcv_addr1"));
String rcvAddr2		= ut.inject(request.getParameter("rcv_addr2"));
String rcvType		= ut.inject(request.getParameter("rcv_type"));
String rcvPassYn	= ut.inject(request.getParameter("rcv_pass_yn"));
String rcvPass		= ut.inject(request.getParameter("rcv_pass"));
String rcvRequest	= ut.inject(request.getParameter("rcv_request"));

// 택배 배송 정보
String tagName		= ut.inject(request.getParameter("tag_name"));
String tagHp1		= ut.inject(request.getParameter("tag_hp1"));
String tagHp2		= ut.inject(request.getParameter("tag_hp2"));
String tagHp3		= ut.inject(request.getParameter("tag_hp3"));
String tagHp		= "";
if (tagHp1 != null && tagHp1.length() > 0) {
	tagHp				= tagHp1 +"-"+ tagHp2 +"-"+ tagHp3;
}
String tagTel		= "";
String tagTel1		= ut.inject(request.getParameter("tag_tel1"));
String tagTel2		= ut.inject(request.getParameter("tag_tel2"));
String tagTel3		= ut.inject(request.getParameter("tag_tel3"));
if (tagTel1 != null && tagTel1.length() > 0) {
	tagTel				= tagTel1 +"-"+ tagTel2 +"-"+ tagTel3;
}
String tagZipcode	= "";
String tagZipcode1	= ut.inject(request.getParameter("tag_zipcode1"));
String tagZipcode2	= ut.inject(request.getParameter("tag_zipcode2"));
if (tagZipcode1 != null && tagZipcode1.length() > 0) {
	tagZipcode			= tagZipcode1+tagZipcode2;
}
String tagAddr1		= ut.inject(request.getParameter("tag_addr1"));
String tagAddr2		= ut.inject(request.getParameter("tag_addr2"));
String tagType		= ut.inject(request.getParameter("tag_type"));
String tagRequest	= ut.inject(request.getParameter("tag_request"));
String payType		= ut.inject(request.getParameter("pay_type")); //결제수단
int payPrice		= 0; //결제금액
int goodsPrice		= 0; //총주문금액
int devlPrice		= 0; //배송비
if (request.getParameter("pay_price") != null && request.getParameter("pay_price").length()>0)
	payPrice		= Integer.parseInt(request.getParameter("pay_price"));
if (request.getParameter("goods_price") != null && request.getParameter("goods_price").length()>0)
	goodsPrice		= Integer.parseInt(request.getParameter("goods_price"));
if (request.getParameter("devl_price") != null && request.getParameter("devl_price").length()>0)
	devlPrice		= Integer.parseInt(request.getParameter("devl_price"));

String couponTprice	= ut.inject(request.getParameter("coupon_ftprice")); //상품할인 쿠폰 총금액
int couponPrice		= 0; //상품쿠폰별 금액
String couponNum	= ""; //상품쿠폰별 쿠폰번호
String groupCodes[]	= request.getParameterValues("group_code"); //상품할인 쿠폰 상품번호
String couponNums[]	= request.getParameterValues("coupon_num"); //상품할인 쿠폰 코드
String couponPrices[]= request.getParameterValues("coupon_price"); //상품별 할인 쿠폰 금액

String orderDate	= ""; //결제일
String orderState	= ""; //주문상태
String payYn		= ""; //결제성공여부

String pgTID		= ut.inject(request.getParameter("LGD_TID")); //PG 거래번호
String pgCardNo		= ut.inject(request.getParameter("LGD_CARDNUM")); //PG 신용카드번호
String pgCardFno	= ut.inject(request.getParameter("LGD_FINANCECODE")); //PG 카드코드
String pgCardName	= ut.inject(request.getParameter("LGD_FINANCENAME")); //PG 카드명
String pgVAccNo		= ut.inject(request.getParameter("LGD_ACCOUNTNUM")); //입금할 계좌 (가상계좌)
String pgAppNo		= ut.inject(request.getParameter("LGD_FINANCEAUTHNUM")); //PG 승인번호

String orderEnv		= ut.inject(request.getParameter("orderEnv")); //주문자PC환경
if (orderEnv == null || orderEnv.length()==0) orderEnv = "P";
String payMode		= ut.inject(request.getParameter("payMode")); //결제방식(test,mobile,...)
String userIp		= request.getRemoteAddr();
String mode			= ut.inject(request.getParameter("mode"));
String oyn			= ut.inject(request.getParameter("oyn"));
String ssType		= "";
String sendHp		= "";

if( orderNum.equals("")) {
	out.println("주문번호 누락");
	if(true)return;
}

String returnURL	= "";
orderDate			= "NOW()";
orderState			= "01";
payYn				= "Y";
if(orderEnv.equals("M")){ //모바일주문일 경우
	returnURL="location.href='/mobile/shop/payment.jsp?ono="+orderNum+"'";
}else{
	returnURL="parent.location.href='/shop/payment.jsp?ono="+orderNum+"'";
}


if (payType.equals("30")) { //가상계좌는 주문접수로
	orderState			= "00";
	payYn				= "N";
	orderDate			= "null";
} else {
	sendHp		= (!rcvName.equals("") && rcvName != null)? rcvHp : tagHp;
	query		= "INSERT INTO uds_msg (";
	query		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, MSG_BODY";
	query		+= " ) VALUES (";
	query		+= "	0, now()+0, now(), now(), '"+ sendHp +"', '080-022-0085', '[잇슬림]주문("+ orderNum +"이 완료되었습니다. 고객기쁨센터 080-022-0085')";
	try {
		stmt.executeUpdate(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
}

//============주문서 저장 (ESL_ORDER)
query		= "UPDATE ESL_ORDER SET ";
query		+= "	PG_TID				= '"+ pgTID +"'";
query		+= "	,PG_CARDNUM			= '"+ pgCardNo +"'";
query		+= "	,PG_FINANCECODE		= '"+ pgCardFno +"'";
query		+= "	,PG_FINANCEAUTHNUM	= '"+ pgAppNo +"'";
query		+= "	,PG_FINANCENAME		= '"+ pgCardName +"'";
query		+= "	,PG_ACCOUNTNUM		= '"+ pgVAccNo +"'";
query		+= "	,PAY_YN				= '"+ payYn +"'";
query		+= "	,PAY_DATE			= "+ orderDate;
query		+= "	,ORDER_STATE		= '"+ orderState +"'";
query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
try {
	stmt.executeUpdate(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

query		= "UPDATE ESL_ORDER_GOODS SET ORDER_STATE='"+ orderState +"' WHERE ORDER_NUM = '"+ orderNum +"'";	
try {
	stmt.executeUpdate(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

//===================================상품할인 쿠폰 사용
query		= "SELECT COUPON_NUM, GROUP_ID, COUPON_PRICE FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'";
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs.next()) {
	query1		= "UPDATE ESL_COUPON_MEMBER SET USE_YN='Y', USE_ORDER_NUM = '"+ orderNum +"', USE_DATE=NOW() ";
	query1		+= " WHERE COUPON_NUM='"+rs.getString("COUPON_NUM")+"' AND MEMBER_ID='"+eslMemberId+"' AND USE_YN='N'";
	try {
		stmt1.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}
}
rs.close();

query		= "DELETE FROM ESL_CART WHERE MEMBER_ID='"+ eslMemberId +"' AND CART_TYPE = '"+ mode +"'"; //장바구니 삭제
if (oyn.equals("Y")) {
	query		+= " AND ORDER_YN = 'Y'";
}
try {
	stmt.executeUpdate(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

//================================================================================
out.println("<script type='text/javascript'>"+returnURL+"</script>");
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>