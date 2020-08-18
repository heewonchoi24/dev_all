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

if (payType.equals("10") || payType.equals("20")) {

	//================PHI 연동
	int i				= 1;
	int k				= 0;
	int maxK			= 0;
	int ordSeq			= 0;
	String rcvPartner	= "";
	String tagPartner	= "";
	SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
	String instDate		= dt.format(new Date());
	Date date			= null;
	String groupCode	= "";
	int orderCnt		= 0;
	int orderCnt1		= 0;
	String devlType		= "";
	String devlDay		= "";
	String devlWeek		= "";
	String devlDate		= "";
	String devlDatePhi	= "";
	int price			= 0;
	String buyBagYn		= "";
	String customerNum	= "";
	String gubun1		= "";
	String gubun2		= "";
	String gubun3		= "";
	int week			= 1;

	// 일배 위탁점 조회
	query		= "SELECT PARTNERID FROM PHIBABY.V_ZIPCODE WHERE ZIPCODE = '"+ rcvZipcode +"'";
	try {
		rs_phi		= stmt_phi.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs_phi.next()) {
		rcvPartner		= rs_phi.getString("PARTNERID");
	}
	rs_phi.close();


	// 택배 위탁점 조회
	query		= "SELECT PARTNERID FROM PHIBABY.V_ZIPCODE WHERE ZIPCODE = '"+ tagZipcode +"'";
	try {
		rs_phi		= stmt_phi.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs_phi.next()) {
		tagPartner		= rs_phi.getString("PARTNERID");
	}
	rs_phi.close();

	// 풀무원 고유키 조회
	query		= "SELECT CUSTOMER_NUM FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"'";
	try {
		rs = stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		customerNum		= rs.getString("CUSTOMER_NUM");
	}
	rs.close();

	query		= "SELECT ";
	query		+= "	GROUP_CODE, GROUP_ID, ORDER_CNT, DEVL_TYPE, DEVL_DAY, DEVL_WEEK, GUBUN1, GUBUN2,";
	query		+= "	DATE_FORMAT(DEVL_DATE, '%Y%m%d') DEVL_DATE, PRICE, BUY_BAG_YN, COUPON_PRICE, SS_TYPE";
	query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G";
	query		+= " WHERE OG.GROUP_ID = G.ID AND OG.ORDER_NUM = '"+ orderNum +"'";
	try {
		rs = stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	while (rs.next()) {
		// 시퀀스 조회
		query		= "SELECT MAX(ORD_SEQ) FROM PHIBABY.P_ORDER_MALL_PHI_ITF";
		try {
			rs_phi		= stmt_phi.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs_phi.next()) {
			ordSeq		= rs_phi.getInt(1) + 1;
		}
		rs_phi.close();

		i			= 1;
		groupCode	= rs.getString("GROUP_CODE");
		orderCnt	= rs.getInt("ORDER_CNT");
		devlType	= rs.getString("DEVL_TYPE");
		devlDay		= rs.getString("DEVL_DAY");
		devlWeek	= rs.getString("DEVL_WEEK");
		devlDate	= rs.getString("DEVL_DATE");
		buyBagYn	= rs.getString("BUY_BAG_YN");
		couponPrice	= rs.getInt("COUPON_PRICE");
		gubun1		= rs.getString("GUBUN1");
		gubun2		= rs.getString("GUBUN2");
		ssType		= rs.getString("SS_TYPE");
		price		= (gubun1.equals("01"))? rs.getInt("PRICE") / (Integer.parseInt(devlDay) * Integer.parseInt(devlWeek)) : rs.getInt("PRICE");
/*
		if (gubun2.equals("31")) {
			out.println("<script type='text/javascript'>"+returnURL+"</script>");
			if (true) return;
		}
*/	
		query1		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
		query1		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM)";
		query1		+= "	VALUES";
		query1		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
		pstmt_phi					= conn_phi.prepareStatement(query1);
		if (gubun2.equals("31")) {
			k			= 0;
			maxK		= (Integer.parseInt(devlDay) * Integer.parseInt(devlWeek)) - 1;

			for (int j = 0; j < 50; j++) {
				date			= dt.parse(devlDate);
				Calendar cal	= Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.DATE, j);
				if (ssType.equals("1")) {					
					if (cal.get(cal.DAY_OF_WEEK) == 1 || cal.get(cal.DAY_OF_WEEK) == 3 || cal.get(cal.DAY_OF_WEEK) == 5 || cal.get(cal.DAY_OF_WEEK) == 7) { //일요일, 화목토는 배송을 하지 않는다
					} else {
						query2		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE WHERE GUBUN2 = '"+ gubun2 +"'";
						query2		+= " AND DAY_OF_WEEK = '"+ cal.get(cal.DAY_OF_WEEK) +"'";
						try {
							rs2 = stmt2.executeQuery(query2);
						} catch(Exception e) {
							out.println(e+"=>"+query2);
							if(true)return;
						}

						if (rs2.next()) {
							groupCode		= rs2.getString("GROUP_CODE");
							price			= rs2.getInt("PRICE");
						}
						devlDatePhi		= dt.format(cal.getTime());
						pstmt_phi.setInt(1, ordSeq);
						pstmt_phi.setString(2, instDate);
						pstmt_phi.setString(3, orderNum);
						pstmt_phi.setString(4, customerNum);
						pstmt_phi.setString(5, "I");
						pstmt_phi.setString(6, orderName);
						pstmt_phi.setString(7, rcvName);
						pstmt_phi.setString(8, rcvZipcode);
						pstmt_phi.setString(9, rcvAddr1);
						pstmt_phi.setString(10, rcvAddr2);
						pstmt_phi.setString(11, rcvTel);
						pstmt_phi.setString(12, rcvHp);
						pstmt_phi.setString(13, email);
						pstmt_phi.setInt(14, goodsPrice);
						pstmt_phi.setInt(15, payPrice);
						pstmt_phi.setInt(16, devlPrice);
						pstmt_phi.setInt(17, couponPrice);
						pstmt_phi.setString(18, payType);
						pstmt_phi.setString(19, "0001");
						pstmt_phi.setString(20, rcvPartner);
						pstmt_phi.setString(21, rcvRequest);
						pstmt_phi.setInt(22, i);
						pstmt_phi.setString(23, devlDatePhi);
						pstmt_phi.setString(24, groupCode);
						pstmt_phi.setInt(25, orderCnt);
						pstmt_phi.setInt(26, price);
						pstmt_phi.setInt(27, price);
						try {
							pstmt_phi.executeUpdate();
						} catch (Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}
						k++;
					}
				} else if (ssType.equals("2")) {
					if (cal.get(cal.DAY_OF_WEEK) == 1 || cal.get(cal.DAY_OF_WEEK) == 2 || cal.get(cal.DAY_OF_WEEK) == 4 || cal.get(cal.DAY_OF_WEEK) == 6) { //일요일, 월수금은 배송을 하지 않는다
					} else {
						query2		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE WHERE GUBUN2 = '"+ gubun2 +"'";
						query2		+= " AND DAY_OF_WEEK = '"+ cal.get(cal.DAY_OF_WEEK) +"'";
						try {
							rs2 = stmt2.executeQuery(query2);
						} catch(Exception e) {
							out.println(e+"=>"+query2);
							if(true)return;
						}

						if (rs2.next()) {
							groupCode		= rs2.getString("GROUP_CODE");
							price			= rs2.getInt("PRICE");
						}
						devlDatePhi		= dt.format(cal.getTime());
						pstmt_phi.setInt(1, ordSeq);
						pstmt_phi.setString(2, instDate);
						pstmt_phi.setString(3, orderNum);
						pstmt_phi.setString(4, customerNum);
						pstmt_phi.setString(5, "I");
						pstmt_phi.setString(6, orderName);
						pstmt_phi.setString(7, rcvName);
						pstmt_phi.setString(8, rcvZipcode);
						pstmt_phi.setString(9, rcvAddr1);
						pstmt_phi.setString(10, rcvAddr2);
						pstmt_phi.setString(11, rcvTel);
						pstmt_phi.setString(12, rcvHp);
						pstmt_phi.setString(13, email);
						pstmt_phi.setInt(14, goodsPrice);
						pstmt_phi.setInt(15, payPrice);
						pstmt_phi.setInt(16, devlPrice);
						pstmt_phi.setInt(17, couponPrice);
						pstmt_phi.setString(18, payType);
						pstmt_phi.setString(19, "0001");
						pstmt_phi.setString(20, rcvPartner);
						pstmt_phi.setString(21, rcvRequest);
						pstmt_phi.setInt(22, i);
						pstmt_phi.setString(23, devlDatePhi);
						pstmt_phi.setString(24, groupCode);
						pstmt_phi.setInt(25, orderCnt);
						pstmt_phi.setInt(26, price);
						pstmt_phi.setInt(27, price);
						try {
							pstmt_phi.executeUpdate();
						} catch (Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}
						k++;
					}
				} else {
					if (cal.get(cal.DAY_OF_WEEK) == 1) { //일요일은 배송을 하지 않는다
					} else {
						query2		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE WHERE GUBUN2 = '"+ gubun2 +"'";
						query2		+= " AND DAY_OF_WEEK = '"+ cal.get(cal.DAY_OF_WEEK) +"'";
						try {
							rs2 = stmt2.executeQuery(query2);
						} catch(Exception e) {
							out.println(e+"=>"+query2);
							if(true)return;
						}

						if (rs2.next()) {
							groupCode		= rs2.getString("GROUP_CODE");
							price			= rs2.getInt("PRICE");
						}

						rs2.close();

						devlDatePhi		= dt.format(cal.getTime());
						pstmt_phi.setInt(1, ordSeq);
						pstmt_phi.setString(2, instDate);
						pstmt_phi.setString(3, orderNum);
						pstmt_phi.setString(4, customerNum);
						pstmt_phi.setString(5, "I");
						pstmt_phi.setString(6, orderName);
						pstmt_phi.setString(7, rcvName);
						pstmt_phi.setString(8, rcvZipcode);
						pstmt_phi.setString(9, rcvAddr1);
						pstmt_phi.setString(10, rcvAddr2);
						pstmt_phi.setString(11, rcvTel);
						pstmt_phi.setString(12, rcvHp);
						pstmt_phi.setString(13, email);
						pstmt_phi.setInt(14, goodsPrice);
						pstmt_phi.setInt(15, payPrice);
						pstmt_phi.setInt(16, devlPrice);
						pstmt_phi.setInt(17, couponPrice);
						pstmt_phi.setString(18, payType);
						pstmt_phi.setString(19, "0001");
						pstmt_phi.setString(20, rcvPartner);
						pstmt_phi.setString(21, rcvRequest);
						pstmt_phi.setInt(22, i);
						pstmt_phi.setString(23, devlDatePhi);
						pstmt_phi.setString(24, groupCode);
						pstmt_phi.setInt(25, orderCnt);
						pstmt_phi.setInt(26, price);
						pstmt_phi.setInt(27, price);
						try {
							pstmt_phi.executeUpdate();
						} catch (Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}
						k++;
					}
				}

				i++;
				ordSeq++;
				if (k > maxK) break;
			}

			if (buyBagYn.equals("Y")) {
				pstmt_phi.setInt(1, ordSeq);
				pstmt_phi.setString(2, instDate);
				pstmt_phi.setString(3, orderNum);
				pstmt_phi.setString(4, customerNum);
				pstmt_phi.setString(5, "I");
				pstmt_phi.setString(6, orderName);
				pstmt_phi.setString(7, rcvName);
				pstmt_phi.setString(8, rcvZipcode);
				pstmt_phi.setString(9, rcvAddr1);
				pstmt_phi.setString(10, rcvAddr2);
				pstmt_phi.setString(11, rcvTel);
				pstmt_phi.setString(12, rcvHp);
				pstmt_phi.setString(13, email);
				pstmt_phi.setInt(14, goodsPrice);
				pstmt_phi.setInt(15, payPrice);
				pstmt_phi.setInt(16, devlPrice);
				pstmt_phi.setInt(17, couponPrice);
				pstmt_phi.setString(18, payType);
				pstmt_phi.setString(19, "0001");
				pstmt_phi.setString(20, rcvPartner);
				pstmt_phi.setString(21, rcvRequest);
				pstmt_phi.setInt(22, i);
				pstmt_phi.setString(23, devlDate);
				pstmt_phi.setString(24, "0300668");
				pstmt_phi.setInt(25, orderCnt);
				pstmt_phi.setInt(26, defaultBagPrice);
				pstmt_phi.setInt(27, defaultBagPrice);
				try {
					pstmt_phi.executeUpdate();
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}
			}
			
		} else if (devlType.equals("0001")) {
			k			= 0;
			maxK		= (Integer.parseInt(devlDay) * Integer.parseInt(devlWeek)) - 1;

			for (int j = 0; j < 50; j++) {
				date			= dt.parse(devlDate);
				Calendar cal	= Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.DATE, j);
				if (devlDay.equals("6")) {
					if (cal.get(cal.DAY_OF_WEEK) == 1) { //일요일은 배송을 하지 않는다
					} else {
						devlDatePhi		= dt.format(cal.getTime());
						pstmt_phi.setInt(1, ordSeq);
						pstmt_phi.setString(2, instDate);
						pstmt_phi.setString(3, orderNum);
						pstmt_phi.setString(4, customerNum);
						pstmt_phi.setString(5, "I");
						pstmt_phi.setString(6, orderName);
						pstmt_phi.setString(7, rcvName);
						pstmt_phi.setString(8, rcvZipcode);
						pstmt_phi.setString(9, rcvAddr1);
						pstmt_phi.setString(10, rcvAddr2);
						pstmt_phi.setString(11, rcvTel);
						pstmt_phi.setString(12, rcvHp);
						pstmt_phi.setString(13, email);
						pstmt_phi.setInt(14, goodsPrice);
						pstmt_phi.setInt(15, payPrice);
						pstmt_phi.setInt(16, devlPrice);
						pstmt_phi.setInt(17, couponPrice);
						pstmt_phi.setString(18, payType);
						pstmt_phi.setString(19, "0001");
						pstmt_phi.setString(20, rcvPartner);
						pstmt_phi.setString(21, rcvRequest);
						pstmt_phi.setInt(22, i);
						pstmt_phi.setString(23, devlDatePhi);
						pstmt_phi.setString(24, groupCode);
						pstmt_phi.setInt(25, orderCnt);
						pstmt_phi.setInt(26, price);
						pstmt_phi.setInt(27, price);
						try {
							pstmt_phi.executeUpdate();
						} catch (Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}
						k++;
					}
				} else {
					if (cal.get(cal.DAY_OF_WEEK) == 7 || cal.get(cal.DAY_OF_WEEK) == 1) { // 토, 일요일은 배송을 하지 않는다	
					} else {
						if (gubun1.equals("02")) {
							query2		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE WHERE GUBUN2 = '"+ gubun2 +"'";
							query2		+= " AND DAY_OF_WEEK = '"+ cal.get(cal.DAY_OF_WEEK) +"' AND GUBUN3 = '"+ week +"'";
							try {
								rs2 = stmt2.executeQuery(query2);
							} catch(Exception e) {
								out.println(e+"=>"+query2);
								if(true)return;
							}

							if (rs2.next()) {
								groupCode		= rs2.getString("GROUP_CODE");
								price			= rs2.getInt("PRICE");
							}
						}
						devlDatePhi		= dt.format(cal.getTime());
						pstmt_phi.setInt(1, ordSeq);
						pstmt_phi.setString(2, instDate);
						pstmt_phi.setString(3, orderNum);
						pstmt_phi.setString(4, customerNum);
						pstmt_phi.setString(5, "I");
						pstmt_phi.setString(6, orderName);
						pstmt_phi.setString(7, rcvName);
						pstmt_phi.setString(8, rcvZipcode);
						pstmt_phi.setString(9, rcvAddr1);
						pstmt_phi.setString(10, rcvAddr2);
						pstmt_phi.setString(11, rcvTel);
						pstmt_phi.setString(12, rcvHp);
						pstmt_phi.setString(13, email);
						pstmt_phi.setInt(14, goodsPrice);
						pstmt_phi.setInt(15, payPrice);
						pstmt_phi.setInt(16, devlPrice);
						pstmt_phi.setInt(17, couponPrice);
						pstmt_phi.setString(18, payType);
						pstmt_phi.setString(19, "0001");
						pstmt_phi.setString(20, rcvPartner);
						pstmt_phi.setString(21, rcvRequest);
						pstmt_phi.setInt(22, i);
						pstmt_phi.setString(23, devlDatePhi);
						pstmt_phi.setString(24, groupCode);
						pstmt_phi.setInt(25, orderCnt);
						pstmt_phi.setInt(26, price);
						pstmt_phi.setInt(27, price);
						try {
							pstmt_phi.executeUpdate();
						} catch (Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}
						k++;
						if (gubun1.equals("02")) {
							if (k % 5 == 0) week++;
						}
					}
				}

				i++;
				ordSeq++;
				if (k > maxK) break;
			}

			if (buyBagYn.equals("Y")) {
				pstmt_phi.setInt(1, ordSeq);
				pstmt_phi.setString(2, instDate);
				pstmt_phi.setString(3, orderNum);
				pstmt_phi.setString(4, customerNum);
				pstmt_phi.setString(5, "I");
				pstmt_phi.setString(6, orderName);
				pstmt_phi.setString(7, rcvName);
				pstmt_phi.setString(8, rcvZipcode);
				pstmt_phi.setString(9, rcvAddr1);
				pstmt_phi.setString(10, rcvAddr2);
				pstmt_phi.setString(11, rcvTel);
				pstmt_phi.setString(12, rcvHp);
				pstmt_phi.setString(13, email);
				pstmt_phi.setInt(14, goodsPrice);
				pstmt_phi.setInt(15, payPrice);
				pstmt_phi.setInt(16, devlPrice);
				pstmt_phi.setInt(17, couponPrice);
				pstmt_phi.setString(18, payType);
				pstmt_phi.setString(19, "0001");
				pstmt_phi.setString(20, rcvPartner);
				pstmt_phi.setString(21, rcvRequest);
				pstmt_phi.setInt(22, i);
				pstmt_phi.setString(23, devlDate);
				pstmt_phi.setString(24, "0300668");
				pstmt_phi.setInt(25, orderCnt);
				pstmt_phi.setInt(26, defaultBagPrice);
				pstmt_phi.setInt(27, defaultBagPrice);
				try {
					pstmt_phi.executeUpdate();
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}
			}

			ordSeq++;
		} else {
			Date date1	= null;
			date1		= dt.parse(devlDate);

			Calendar cal	= Calendar.getInstance();
			cal.setTime(date1);
			cal.add(Calendar.DATE, 3);
			devlDatePhi		= dt.format(cal.getTime());

			pstmt_phi.setInt(1, ordSeq);
			pstmt_phi.setString(2, instDate);
			pstmt_phi.setString(3, orderNum);
			pstmt_phi.setString(4, customerNum);
			pstmt_phi.setString(5, "I");
			pstmt_phi.setString(6, orderName);
			pstmt_phi.setString(7, tagName);
			pstmt_phi.setString(8, tagZipcode);
			pstmt_phi.setString(9, tagAddr1);
			pstmt_phi.setString(10, tagAddr2);
			pstmt_phi.setString(11, tagTel);
			pstmt_phi.setString(12, tagHp);
			pstmt_phi.setString(13, email);
			pstmt_phi.setInt(14, goodsPrice);
			pstmt_phi.setInt(15, payPrice);
			pstmt_phi.setInt(16, devlPrice);
			pstmt_phi.setInt(17, couponPrice);
			pstmt_phi.setString(18, payType);
			pstmt_phi.setString(19, "0002");
			pstmt_phi.setString(20, tagPartner);
			pstmt_phi.setString(21, tagRequest);
			pstmt_phi.setInt(22, i);
			pstmt_phi.setString(23, devlDatePhi);
			pstmt_phi.setString(24, groupCode);
			pstmt_phi.setInt(25, orderCnt);
			pstmt_phi.setInt(26, price);
			pstmt_phi.setInt(27, price);
			try {
				pstmt_phi.executeUpdate();
			} catch (Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}
		}
	}


	// 파이에서 데이터를 받아서 몰에 주문 처리 한다
	query		= "SELECT * FROM PHIBABY.P_ORDER_MALL_PHI_ITF WHERE ORD_NO = '"+ orderNum +"'";
	try {
		rs_phi		= stmt_phi.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	while (rs_phi.next()) {
		query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
		query1		+= "		ORDER_DATE			= '"+ rs_phi.getString("ORD_DATE") +"'";
		query1		+= "		, ORDER_NUM			= '"+ orderNum +"'";
		query1		+= "		, CUSTOMER_NUM		= '"+ rs_phi.getString("PARTNERID") +"'";
		query1		+= "		, ORDER_NAME		= '"+ rs_phi.getString("ORD_NM") +"'";
		query1		+= "		, RCV_NAME			= '"+ rs_phi.getString("RCVR_NM") +"'";
		query1		+= "		, RCV_ZIPCODE		= '"+ rs_phi.getString("RCVR_ZIPCD") +"'";
		query1		+= "		, RCV_ADDR1			= '"+ rs_phi.getString("RCVR_ADDR1") +"'";
		query1		+= "		, RCV_ADDR2			= '"+ rs_phi.getString("RCVR_ADDR2") +"'";
		query1		+= "		, RCV_TEL			= '"+ rs_phi.getString("RCVR_TELNO") +"'";
		query1		+= "		, RCV_HP			= '"+ rs_phi.getString("RCVR_MOBILENO") +"'";
		query1		+= "		, RCV_EMAIL			= '"+ rs_phi.getString("RCVR_EMAIL") +"'";
		query1		+= "		, TOT_SELL_PRICE	= '"+ rs_phi.getInt("TOT_SELL_PRICE") +"'";
		query1		+= "		, TOT_PAY_PRICE		= '"+ rs_phi.getInt("TOT_REC_PRICE") +"'";
		query1		+= "		, TOT_DEVL_PRICE	= '"+ rs_phi.getInt("TOT_DELV_PRICE") +"'";
		query1		+= "		, TOT_DC_PRICE		= '"+ rs_phi.getInt("TOT_DC_PRICE") +"'";
		query1		+= "		, PAY_TYPE			= '"+ rs_phi.getString("REC_TYPE") +"'";
		query1		+= "		, DEVL_TYPE			= '"+ rs_phi.getString("DELV_TYPE") +"'";
		query1		+= "		, AGENCYID			= '"+ rs_phi.getString("AGENCYID") +"'";
		query1		+= "		, RCV_REQUEST		= '"+ rs_phi.getString("ORD_MEMO") +"'";
		query1		+= "		, GROUP_CODE		= '"+ rs_phi.getString("GOODS_NO") +"'";
		query1		+= "		, DEVL_DATE			= '"+ rs_phi.getString("DELV_DATE") +"'";
		query1		+= "		, ORDER_CNT			= '"+ rs_phi.getInt("ORD_CNT") +"'";
		query1		+= "		, PRICE				= '"+ rs_phi.getInt("SELL_PRICE") +"'";
		query1		+= "		, PAY_PRICE			= '"+ rs_phi.getInt("REC_PRICE") +"'";
		query1		+= "		, STATE				= '01'";
		try {
			stmt.executeUpdate(query1);
		} catch (Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}
	}

	query		= "UPDATE ESL_MEMBER SET PURCHASE_CNT = PURCHASE_CNT + 1, PURCHASE_DATE = NOW() WHERE MEM_ID = '"+ eslMemberId +"'";
	try {
		stmt.executeUpdate(query);
	} catch (Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
}

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