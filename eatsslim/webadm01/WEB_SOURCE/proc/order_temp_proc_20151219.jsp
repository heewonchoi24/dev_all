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
String mode			= ut.inject(request.getParameter("mode"));
String oyn			= ut.inject(request.getParameter("oyn"));
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
String rcvZipcode	= ut.inject(request.getParameter("rcv_zipcode"));
String rcvAddr1		= ut.inject(request.getParameter("rcv_addr1"));
String rcvAddr2		= ut.inject(request.getParameter("rcv_addr2"));
String rcvType		= ut.inject(request.getParameter("rcv_type"));
String rcvPassYn	= ut.inject(request.getParameter("rcv_pass_yn"));
String rcvPass		= ut.inject(request.getParameter("rcv_pass"));
String rcvRequest	= ut.inject(request.getParameter("rcv_request"));
int rcvCnt			= 0;

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
String tagZipcode	= ut.inject(request.getParameter("tag_zipcode"));
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
boolean success_order	= false;

if( orderNum.equals("")) {
	out.println("주문번호 누락");
	if(true)return;
}

String returnURL	= "";
orderDate			= "null";
orderState			= "00";
payYn				= "N";
if(orderEnv.equals("M")){ //모바일주문일 경우
	if (payPrice < 1) {
		returnURL = "opener.pay('"+payMode+"');self.close();";
	} else {
		returnURL="opener.paySubmit('"+payMode+"');";
	}
}else{
	if (payPrice < 1) {
		returnURL = "parent.pay('"+payMode+"');";
	} else {
		returnURL="parent.paySubmit('"+payMode+"');";
	}
}

query		= "SELECT COUNT(ID) FROM ESL_ORDER WHERE ORDER_NUM='"+ orderNum +"'";
try {
	rs = stmt.executeQuery(query);
}catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
if(rs.next()) {
	if (rs.getInt(1) > 0) {
		out.println("<script>alert('이미 주문된 동일한 주문번호가 존재합니다.');</script>");if(true)return;
	}
}
rs.close();

String customerNum	= "";
query		= "SELECT CUSTOMER_NUM FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"'";
try {
	rs = stmt.executeQuery(query);
}catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	customerNum		= rs.getString("CUSTOMER_NUM");
}
rs.close();

// 일배 배송지 체크
if (!rcvZipcode.equals("") && rcvZipcode != null) {
	query		= "SELECT COUNT(SEQNO) FROM PHIBABY.V_ZIPCODE_OLD_5 WHERE ZIPCODE = '"+ rcvZipcode +"' AND DLVPTNCD = '01' AND DLVYN = 'Y' AND DLVTYPE = '0001'";
	rs_phi		= stmt_phi.executeQuery(query);

	if (rs_phi.next()) {
		rcvCnt		= rs_phi.getInt(1);
	}

	rs_phi.close();

	if (rcvCnt < 1) {
		if (orderEnv.equals("M")) {
			out.println("<script>alert('고객님의 일배 배송지는 배송이 불가능한 지역입니다.');if(opener.document.getElementById('payBtn'))opener.document.getElementById('payBtn').style.display='';if(opener.document.getElementById('pay_ing'))opener.document.getElementById('pay_ing').style.display='none';self.close();</script>");if(true)return;
		} else {
			out.println("<script>alert('고객님의 일배 배송지는 배송이 불가능한 지역입니다.');if(parent.document.getElementById('payBtn'))parent.document.getElementById('payBtn').style.display='';if(parent.document.getElementById('pay_ing'))parent.document.getElementById('pay_ing').style.display='none';</script>");if(true)return;
		}
	}
}

if (couponTprice.equals("") || couponTprice == null) couponTprice = "0";

//============주문서 저장 (ESL_ORDER)
query		= "INSERT INTO ESL_ORDER SET ";
query		+= "	ORDER_NUM		= '"+ orderNum +"'";
query		+= "	,CUSTOMER_NUM	= '"+ customerNum +"'";
query		+= "	,MEMBER_ID		= '"+ eslMemberId +"'";
query		+= "	,ORDER_NAME		= '"+ orderName +"'";
query		+= "	,RCV_NAME		= '"+ rcvName +"'";
query		+= "	,RCV_ZIPCODE	= '"+ rcvZipcode +"'";
query		+= "	,RCV_ADDR1		= '"+ rcvAddr1 +"'";
query		+= "	,RCV_ADDR2		= '"+ rcvAddr2 +"'";
query		+= "	,RCV_HP			= '"+ rcvHp +"'";
query		+= "	,RCV_TEL		= '"+ rcvTel +"'";
query		+= "	,RCV_TYPE		= '"+ rcvType +"'";
query		+= "	,RCV_PASS_YN	= '"+ rcvPassYn +"'";
query		+= "	,RCV_PASS		= '"+ rcvPass +"'";
query		+= "	,RCV_REQUEST	= '"+ rcvRequest +"'";
query		+= "	,TAG_NAME		= '"+ tagName +"'";
query		+= "	,TAG_ZIPCODE	= '"+ tagZipcode +"'";
query		+= "	,TAG_ADDR1		= '"+ tagAddr1 +"'";
query		+= "	,TAG_ADDR2		= '"+ tagAddr2 +"'";
query		+= "	,TAG_HP			= '"+ tagHp +"'";
query		+= "	,TAG_TEL		= '"+ tagTel +"'";
query		+= "	,TAG_TYPE		= '"+ tagType +"'";
query		+= "	,TAG_REQUEST	= '"+ tagRequest +"'";
query		+= "	,GOODS_PRICE	= '"+ goodsPrice +"'";
query		+= "	,DEVL_PRICE		= '"+ devlPrice +"'";
query		+= "	,COUPON_PRICE	= '"+ couponTprice +"'";
query		+= "	,PAY_PRICE		= '"+ payPrice +"'";
query		+= "	,PAY_TYPE		= '"+ payType +"'";
query		+= "	,PAY_YN			= '"+ payYn +"'";
query		+= "	,PAY_DATE		= "+ orderDate;
query		+= "	,ORDER_DATE		= NOW()";
query		+= "	,ORDER_STATE	= '"+ orderState +"'";
query		+= "	,ORDER_ENV		= '"+ orderEnv +"'";
query		+= "	,ORDER_IP		= '"+ userIp +"'";
query		+= "	,ORDER_LOG		= ''";
try {
	stmt.executeUpdate(query);
	success_order	= true;
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

Statement stmt2		= null;
ResultSet rs2		= null;
stmt2 = conn.createStatement();
String chkGroupCode	= "";
int cnt				= 0;
int chkCnt			= 0;

query		= "SELECT COUNT(ID) FROM ESL_CART";
query		+= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND CART_TYPE = '"+ mode +"'";
if (oyn.equals("Y")) {
	query		+= " AND ORDER_YN = 'Y'";
}
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	chkCnt		= rs.getInt(1);
}
rs.close();

if (chkCnt > 0 && success_order == true) {
	//============주문상품 저장 (ESL_ORDER_GOODS)
	query		= "SELECT ID, GROUP_ID, BUY_QTY, DEVL_TYPE, DEVL_DAY, DEVL_WEEK, DEVL_DATE, PRICE, BUY_BAG_YN, SS_TYPE FROM ESL_CART";
	query		+= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND CART_TYPE = '"+ mode +"'";
	if (oyn.equals("Y")) {
		query		+= " AND ORDER_YN = 'Y'";
	}
	try {
		rs = stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	while (rs.next()) {
		query1		= "SELECT GROUP_CODE FROM ESL_GOODS_GROUP WHERE ID = "+ rs.getInt("GROUP_ID");
		try {
			rs2 = stmt2.executeQuery(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}

		if (rs2.next()) {
			chkGroupCode		= rs2.getString("GROUP_CODE");
		}
		
		couponNum		= "";
		couponPrice		= 0;
		for(int i = 0; i < groupCodes.length; i++ ){
			if (chkGroupCode.equals(groupCodes[i])) {
				couponNum	= couponNums[i];
				couponPrice	= (couponPrices[i].equals("") || couponPrices[i] == null)? 0 : Integer.parseInt(couponPrices[i]);
			}
		}
		query1		= "INSERT INTO ESL_ORDER_GOODS SET ";
		query1		+= "	ORDER_NUM		= '"+ orderNum +"'";
		query1		+= "	,GROUP_ID		= '"+ rs.getInt("GROUP_ID") +"'";
		query1		+= "	,DEVL_TYPE		= '"+ rs.getString("DEVL_TYPE") +"'";
		query1		+= "	,ORDER_CNT		= '"+ rs.getInt("BUY_QTY") +"'";
		query1		+= "	,DEVL_DATE		= '"+ rs.getString("DEVL_DATE") +"'";
		query1		+= "	,DEVL_DAY		= '"+ rs.getString("DEVL_DAY") +"'";
		query1		+= "	,DEVL_WEEK		= '"+ rs.getString("DEVL_WEEK") +"'";
		query1		+= "	,PRICE			= '"+ rs.getInt("PRICE") +"'";
		query1		+= "	,BUY_BAG_YN		= '"+ rs.getString("BUY_BAG_YN") +"'";
		query1		+= "	,COUPON_NUM		= '"+ couponNum +"'";
		query1		+= "	,ORDER_STATE	= '"+ orderState +"'";
		query1		+= "	,COUPON_PRICE	= '"+ couponPrice +"'";
		query1		+= "	,SS_TYPE		= '"+ ut.isnull(rs.getString("SS_TYPE")) +"'";

		try {
			stmt2.executeUpdate(query1);
			cnt++;
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}


		query1		= "UPDATE ESL_CART_DELIVERY SET ";
		query1		+= "	ORDER_NUM		= '"+ orderNum +"'";
		query1		+= " WHERE CART_ID = "+ rs.getInt("ID");
		try {
			stmt2.executeUpdate(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}
	}
	rs.close();
	//================================================================================

	if (chkCnt == cnt) {
		out.println("<script type='text/javascript'>"+returnURL+"</script>");
	} else {
		out.println("<script>alert('상품저장에 실패하였습니다..');</script>");if(true)return;
	}
} else {
	out.println("<script>alert('상품저장에 실패하였습니다..');</script>");if(true)return;
}
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>