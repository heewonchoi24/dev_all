<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
String query2		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
Statement stmt2		= null;
ResultSet rs2		= null;
stmt2				= conn.createStatement();
Statement stmt2_phi	= null;
ResultSet rs2_phi	= null;
stmt2_phi			= conn_phi.createStatement();
String orderNum		= ut.inject(request.getParameter("order_num"));
String orderName	= "";
String email		= "";
// 일배 배송 정보
String rcvName		= "";
String rcvHp		= "";
String rcvTel		= "";
String rcvZipcode	= "";
String rcvAddr1		= "";
String rcvAddr2		= "";
String rcvType		= "";
String rcvPassYn	= "";
String rcvPass		= "";
String rcvRequest	= "";
// 택배 배송 정보
String tagName		= "";
String tagHp		= "";
String tagTel		= "";
String tagZipcode	= "";
String tagAddr1		= "";
String tagAddr2		= "";
String tagRequest	= "";
String payType		= "";
int payPrice		= 0; //결제금액
int goodsPrice		= 0; //총주문금액
int devlPrice		= 0; //배송비
int couponTprice	= 0; //상품할인 쿠폰 총금액
int couponPrice		= 0;
String orderDate	= ""; //주문일
String ssType		= "";
if( orderNum.equals("")) {
	out.println("주문번호 누락");
	if(true)return;
}

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
int chkCnt			= 0;

query		= "SELECT CUSTOMER_NUM, ORDER_NAME, RCV_NAME, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_HP, RCV_TEL, RCV_PASS_YN,";
query		+= "		RCV_PASS, RCV_REQUEST, TAG_NAME, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_HP, TAG_TEL, TAG_REQUEST,";
query		+= "		DATE_FORMAT(ORDER_DATE, '%Y%m%d') ORDER_DATE, GOODS_PRICE, DEVL_PRICE, COUPON_PRICE, PAY_PRICE,";
query		+= "		PAY_TYPE";
query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	customerNum			= rs.getString("CUSTOMER_NUM");
	orderName			= rs.getString("ORDER_NAME");
	rcvName				= rs.getString("RCV_NAME");
	rcvZipcode			= rs.getString("RCV_ZIPCODE");
	rcvAddr1			= rs.getString("RCV_ADDR1");
	rcvAddr2			= rs.getString("RCV_ADDR2");
	rcvHp				= rs.getString("RCV_HP");
	rcvTel				= rs.getString("RCV_TEL");
	if (rcvTel.equals("") || rcvTel == null) {
		rcvTel				= "--";
	}
	rcvPassYn			= rs.getString("RCV_PASS_YN");
	rcvPass				= rs.getString("RCV_PASS");
	rcvRequest			= rs.getString("RCV_REQUEST");
	tagName				= rs.getString("TAG_NAME");
	tagZipcode			= rs.getString("TAG_ZIPCODE");
	tagAddr1			= rs.getString("TAG_ADDR1");
	tagAddr2			= rs.getString("TAG_ADDR2");
	tagHp				= rs.getString("TAG_HP");
	tagTel				= rs.getString("TAG_TEL");
	if (tagTel.equals("") || tagTel == null) {
		tagTel				= "--";
	}
	tagRequest			= rs.getString("TAG_REQUEST");
	orderDate			= rs.getString("ORDER_DATE");
	goodsPrice			= rs.getInt("GOODS_PRICE");
	devlPrice			= rs.getInt("DEVL_PRICE");
	payPrice			= rs.getInt("PAY_PRICE");
	couponPrice			= rs.getInt("COUPON_PRICE");
	payType				= rs.getString("PAY_TYPE");
}


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

query		= "UPDATE PHIBABY.P_ORDER_MALL_PHI_ITF SET INTERFACE_FLAG_YN = 'Y' WHERE ORD_NO = '"+ orderNum +"'";
try {
	stmt_phi.executeUpdate(query);
} catch(Exception e) {
	out.println(e);
	if(true)return;
}

query		= "SELECT ";
query		+= "	GROUP_CODE, GROUP_ID, ORDER_CNT, DEVL_TYPE, DEVL_DAY, DEVL_WEEK, GUBUN1, GUBUN2,";
query		+= "	DATE_FORMAT(DEVL_DATE, '%Y%m%d') DEVL_DATE, PRICE, BUY_BAG_YN, SS_TYPE";
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
	gubun1		= rs.getString("GUBUN1");
	gubun2		= rs.getString("GUBUN2");
	ssType		= rs.getString("SS_TYPE");
	price		= (gubun1.equals("01"))? rs.getInt("PRICE") / (Integer.parseInt(devlDay) * Integer.parseInt(devlWeek)) : rs.getInt("PRICE");

	query1		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
	query1		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM, SHOP_CD)";
	query1		+= "	VALUES";
	query1		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, '52')";
	pstmt_phi					= conn_phi.prepareStatement(query1);
	if (gubun2.equals("31")) {
		k			= 0;
		maxK		= (Integer.parseInt(devlDay) * Integer.parseInt(devlWeek)) - 1;

		for (int j = 0; j < 100; j++) {
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

		for (int j = 0; j < 100; j++) {
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

query		= "SELECT COUNT(ID) FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	chkCnt		= rs.getInt(1);
}

if (chkCnt < 1) {
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
}
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>