<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
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
PreparedStatement pstmt2_phi	= null;
String email		= "";
String minDate	= "";

//================PHI 연동
i					= 1;
int k				= 0;
int maxK			= 0;
int ordSeq			= 0;
int schIdx			= 0;
String rcvPartner	= "";
String tagPartner	= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
//SimpleDateFormat dt2	= new SimpleDateFormat("yyyyMMdd");
Date date			= null;
String devlDatePhi	= "";
String gubun1		= "";
String gubun2		= "";
String gubun3		= "";
int week			= 1;
int chkCnt			= 0;
int couponPrice		= 0;
String gubunCode	= "";
int goodsId			= 0;
int holidayCnt		= 0;

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
	query		= "SELECT CUSTOMER_NUM, ORDER_NAME, RCV_NAME, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_HP, RCV_TEL, RCV_PASS_YN,";
	query		+= "		RCV_PASS, RCV_REQUEST, TAG_NAME, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_HP, TAG_TEL, TAG_REQUEST,";
	query		+= "		DATE_FORMAT(ORDER_DATE, '%Y%m%d') ORDER_DATE, GOODS_PRICE, DEVL_PRICE, COUPON_PRICE, PAY_PRICE,";
	query		+= "		PAY_TYPE, (SELECT EMAIL FROM ESL_MEMBER WHERE MEM_ID = MEMBER_ID) EMAIL, SHOP_TYPE";
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
		rcvAddr2			= ut.inject(rs.getString("RCV_ADDR2"));
		rcvHp				= rs.getString("RCV_HP");
		rcvTel				= rs.getString("RCV_TEL");
		if (rcvTel.equals("") || rcvTel == null) {
			rcvTel				= "--";
		}
		email				= rs.getString("EMAIL");
		rcvPassYn			= rs.getString("RCV_PASS_YN");
		rcvPass				= rs.getString("RCV_PASS");
		rcvRequest			= ut.inject(rs.getString("RCV_REQUEST"));
		if (rcvPassYn.equals("Y")) {
			rcvRequest			= rcvRequest + " 출입비밀번호("+ rcvPass +")";
		}
		tagName				= rs.getString("TAG_NAME");
		tagZipcode			= rs.getString("TAG_ZIPCODE");
		tagAddr1			= rs.getString("TAG_ADDR1");
		tagAddr2			= ut.inject(rs.getString("TAG_ADDR2"));
		tagHp				= rs.getString("TAG_HP");
		tagTel				= rs.getString("TAG_TEL");
		if (tagTel.equals("") || tagTel == null) {
			tagTel				= "--";
		}
		tagRequest			= ut.inject(rs.getString("TAG_REQUEST"));
		orderDate			= rs.getString("ORDER_DATE");
		goodsPrice			= rs.getInt("GOODS_PRICE");
		devlPrice			= rs.getInt("DEVL_PRICE");
		payPrice			= rs.getInt("PAY_PRICE");
		couponPrice			= rs.getInt("COUPON_PRICE");
		payType				= rs.getString("PAY_TYPE");
		shopType			= rs.getString("SHOP_TYPE");
	}
	rs.close();

	// 일배 위탁점 조회
	query		= "SELECT JISA_CD FROM CM_ZIP_NEW_M WHERE ZIP= '"+ rcvZipcode +"' OR POST = '"+ rcvZipcode +"' AND ROWNUM = 1 ";
	try {
		rs_bm		= stmt_bm.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs_bm.next()) {
		rcvPartner		= rs_bm.getString("JISA_CD");
	}
	rs_bm.close();	


	// 택배 위탁점 조회
	query		= "SELECT JISA_CD FROM CM_ZIP_NEW_M WHERE ZIP= '"+ tagZipcode +"' OR POST = '"+ tagZipcode +"' AND ROWNUM = 1 ";
	try {
		rs_bm		= stmt_bm.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs_bm.next()) {
		tagPartner		= rs_bm.getString("JISA_CD");
	}
	rs_bm.close();
	
	
	query		= "SELECT ";
	query		+= "	OG.ID, GUBUN1, GUBUN2, GUBUN3, GROUP_CODE, GROUP_ID, ORDER_CNT, DEVL_TYPE, DEVL_DAY, DEVL_WEEKEND, DEVL_WEEK,";
	query		+= "	DATE_FORMAT(DEVL_DATE, '%Y-%m-%d') DEVL_DATE, PRICE, BUY_BAG_YN, SS_TYPE";
	query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G";
	query		+= " WHERE OG.GROUP_ID = G.ID AND OG.ORDER_NUM = '"+ orderNum +"'";
	try {
		rs = stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	while (rs.next()) {

		i			= 1;
		goodsId		= rs.getInt("ID");
		groupCode	= rs.getString("GROUP_CODE");
		orderCnt	= rs.getInt("ORDER_CNT");
		devlType	= rs.getString("DEVL_TYPE");
		devlDay		= rs.getString("DEVL_DAY");
		devlHoliday= rs.getString("DEVL_WEEKEND");
		devlWeek	= rs.getString("DEVL_WEEK");
		devlDate	= rs.getString("DEVL_DATE");
		buyBagYn	= rs.getString("BUY_BAG_YN");
		gubun1		= rs.getString("GUBUN1");
		gubun2		= rs.getString("GUBUN2");
		gubun3		= ut.isnull(rs.getString("GUBUN3"));
		ssType		= rs.getString("SS_TYPE");
		gubunCode	= gubun1 + gubun2 + gubun3;
		price		= (gubun1.equals("01"))? rs.getInt("PRICE") / ( ( Integer.parseInt(devlDay) + Integer.parseInt(devlHoliday) ) * Integer.parseInt(devlWeek)) : rs.getInt("PRICE");
		price		= (payPrice == 0)? 0: price;
		
		if (devlType.equals("0001")) {
			if (rcvPartner == null || rcvPartner.equals("null")) {
				ordChkCnt++;	
			}
		} 

		if (gubun2.equals("31") && devlType.equals("0001")) {
			k			= 0;
			maxK		= (Integer.parseInt(devlDay) * Integer.parseInt(devlWeek)) - 1;

			for (int j = 0; j < 500; j++) {
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
						rs2.close();

						price			= (payPrice == 0)? 0: price;
						devlDatePhi		= dt.format(cal.getTime());

						query1		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"' AND HOLIDAY_TYPE = '02'";
						try {
							rs1 = stmt1.executeQuery(query1);
						} catch(Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}

						if (rs1.next()) {
							holidayCnt		= rs1.getInt(1);
						}
						rs1.close();

						if (holidayCnt == 0) {
							query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
							query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
							query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
							query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
							query1		+= "	ORDER_NAME			= '"+ orderName +"',";
							query1		+= "	RCV_NAME			= '"+ rcvName +"',";
							query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
							query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
							query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
							query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
							query1		+= "	RCV_HP				= '"+ rcvHp +"',";
							query1		+= "	RCV_EMAIL			= '"+ email +"',";
							query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
							query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
							query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
							query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
							query1		+= "	PAY_TYPE			= '"+ payType +"',";
							query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
							query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
							query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
							query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
							query1		+= "	DEVL_DATE			= '"+ devlDatePhi +"',";
							query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
							query1		+= "	PRICE				= '"+ price +"',";
							query1		+= "	PAY_PRICE			= '"+ price +"',";
							query1		+= "	STATE				= '01',";
							query1		+= "	GOODS_ID			= '"+ goodsId +"',";
							query1		+= "	SHOP_CD				= '"+ shopType +"',";
							query1		+= "	GUBUN_CODE			= '"+ gubunCode +"',";
							query1		+= "	SHOP_ORDER_NUM		= '"+ outOrderNum +"'";
							try {
								stmt1.executeUpdate(query1);
							} catch (Exception e) {
								out.println(e+"=>"+query1);
								if(true)return;
							}
							k++;
						}
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
						rs2.close();

						price			= (payPrice == 0)? 0: price;
						devlDatePhi		= dt.format(cal.getTime());

						query1		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"' AND HOLIDAY_TYPE = '02'";
						try {
							rs1 = stmt1.executeQuery(query1);
						} catch(Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}

						if (rs1.next()) {
							holidayCnt		= rs1.getInt(1);
						}
						rs1.close();

						if (holidayCnt == 0) {
							query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
							query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
							query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
							query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
							query1		+= "	ORDER_NAME			= '"+ orderName +"',";
							query1		+= "	RCV_NAME			= '"+ rcvName +"',";
							query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
							query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
							query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
							query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
							query1		+= "	RCV_HP				= '"+ rcvHp +"',";
							query1		+= "	RCV_EMAIL			= '"+ email +"',";
							query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
							query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
							query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
							query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
							query1		+= "	PAY_TYPE			= '"+ payType +"',";
							query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
							query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
							query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
							query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
							query1		+= "	DEVL_DATE			= '"+ devlDatePhi +"',";
							query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
							query1		+= "	PRICE				= '"+ price +"',";
							query1		+= "	PAY_PRICE			= '"+ price +"',";
							query1		+= "	STATE				= '01',";
							query1		+= "	GOODS_ID			= '"+ goodsId +"',";
							query1		+= "	SHOP_CD				= '"+ shopType +"',";
							query1		+= "	GUBUN_CODE			= '"+ gubunCode +"',";
							query1		+= "	SHOP_ORDER_NUM		= '"+ outOrderNum +"'";
							try {
								stmt1.executeUpdate(query1);
							} catch (Exception e) {
								out.println(e+"=>"+query1);
								if(true)return;
							}
							k++;
						}
					}
				} else {
					if (cal.get(cal.DAY_OF_WEEK) == 1|| cal.get(cal.DAY_OF_WEEK) == 7) { //일요일, 토요일은 배송을 하지 않는다
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

						price			= (payPrice == 0)? 0: price;
						devlDatePhi		= dt.format(cal.getTime());

						query1		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"' AND HOLIDAY_TYPE = '02'";
						try {
							rs1 = stmt1.executeQuery(query1);
						} catch(Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}

						if (rs1.next()) {
							holidayCnt		= rs1.getInt(1);
						}
						rs1.close();

						if (holidayCnt == 0) {
							query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
							query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
							query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
							query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
							query1		+= "	ORDER_NAME			= '"+ orderName +"',";
							query1		+= "	RCV_NAME			= '"+ rcvName +"',";
							query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
							query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
							query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
							query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
							query1		+= "	RCV_HP				= '"+ rcvHp +"',";
							query1		+= "	RCV_EMAIL			= '"+ email +"',";
							query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
							query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
							query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
							query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
							query1		+= "	PAY_TYPE			= '"+ payType +"',";
							query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
							query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
							query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
							query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
							query1		+= "	DEVL_DATE			= '"+ devlDatePhi +"',";
							query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
							query1		+= "	PRICE				= '"+ price +"',";
							query1		+= "	PAY_PRICE			= '"+ price +"',";
							query1		+= "	STATE				= '01',";
							query1		+= "	GOODS_ID			= '"+ goodsId +"',";
							query1		+= "	SHOP_CD				= '"+ shopType +"',";
							query1		+= "	GUBUN_CODE			= '"+ gubunCode +"',";
							query1		+= "	SHOP_ORDER_NUM		= '"+ outOrderNum +"'";
							try {
								stmt1.executeUpdate(query1);
							} catch (Exception e) {
								out.println(e+"=>"+query1);
								if(true)return;
							}
							k++;
						}
					}
				}

				i++;
				ordSeq++;
				if (k > maxK) break;
			}

			if (buyBagYn.equals("Y")) {
				defaultBagPrice	= (payPrice == 0)? 0 : defaultBagPrice;
				query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
				query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
				query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
				query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
				query1		+= "	ORDER_NAME			= '"+ orderName +"',";
				query1		+= "	RCV_NAME			= '"+ rcvName +"',";
				query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
				query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
				query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
				query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
				query1		+= "	RCV_HP				= '"+ rcvHp +"',";
				query1		+= "	RCV_EMAIL			= '"+ email +"',";
				query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
				query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
				query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
				query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
				query1		+= "	PAY_TYPE			= '"+ payType +"',";
				query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
				query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
				query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
				query1		+= "	GROUP_CODE			= '0300668',";
				query1		+= "	DEVL_DATE			= '"+ devlDate +"',";
				query1		+= "	ORDER_CNT			= '1',";
				query1		+= "	PRICE				= '"+ defaultBagPrice +"',";
				query1		+= "	PAY_PRICE			= '"+ defaultBagPrice +"',";
				query1		+= "	STATE				= '01',";
				query1		+= "	GOODS_ID			= '"+ goodsId +"',";
				query1		+= "	SHOP_CD				= '"+ shopType +"',";
				query1		+= "	GUBUN_CODE			= '0300668',";
				query1		+= "	SHOP_ORDER_NUM		= '"+ outOrderNum +"'";
				try {
					stmt1.executeUpdate(query1);
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}
			}
			
		} else if (groupCode.equals("0301590")) { // 미니밀 일배

			k			= 0;
			maxK	= ( (Integer.parseInt(devlDay) + Integer.parseInt(devlHoliday)) * Integer.parseInt(devlWeek) ) - 1;
			
			//SimpleDateFormat dt2	= new SimpleDateFormat("yyyy-MM-dd");
			//String today		= dt2.format(new Date());
			
			String devlFriDate = "";

			for (int j = 0; j < 100; j++) {
				date			= dt.parse(devlDate);
				Calendar cal	= Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.DATE, j);

				if (devlDay.equals("5")) {
					
					if ( devlHoliday.equals("0") && (cal.get(cal.DAY_OF_WEEK) == 7 || cal.get(cal.DAY_OF_WEEK) == 1) ) { // 토, 일요일은 배송을 하지 않는다
					} else {
						if (cal.get(cal.DAY_OF_WEEK) == 7 || cal.get(cal.DAY_OF_WEEK) == 1) { // 토, 일요일은 금요일 배송
						} else {
							devlFriDate = dt.format(cal.getTime());
						}						
						devlDatePhi		= dt.format(cal.getTime());
					
						query2		= "SELECT SET_CODE FROM ESL_GOODS_CATEGORY_SCHEDULE WHERE CATEGORY_ID = 20 AND DEVL_DATE  = '"+ devlDatePhi + "'";
						try {
							rs2 = stmt2.executeQuery(query2);
						} catch(Exception e) {
							out.println(e+"=>"+query2);
							if(true)return;
						}

						if (rs2.next()) {
							groupCode		= rs2.getString("SET_CODE");
							//price			= rs2.getInt("PRICE");
						}
						rs2.close();
								
						query1		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"' AND HOLIDAY_TYPE = '02'";
						try {
							rs1 = stmt1.executeQuery(query1);
						} catch(Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}

						if (rs1.next()) {
							holidayCnt		= rs1.getInt(1);
						}
						rs1.close();

						if (holidayCnt == 0) {
							query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
							query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
							query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
							query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
							query1		+= "	ORDER_NAME			= '"+ orderName +"',";
							query1		+= "	RCV_NAME			= '"+ rcvName +"',";
							query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
							query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
							query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
							query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
							query1		+= "	RCV_HP				= '"+ rcvHp +"',";
							query1		+= "	RCV_EMAIL			= '"+ email +"',";
							query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
							query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
							query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
							query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
							query1		+= "	PAY_TYPE			= '"+ payType +"',";
							query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
							query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
							query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
							query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
							if ( devlFriDate.equals(devlDatePhi) ) {
								query1		+= "	DEVL_DATE			= '"+ devlDatePhi +"',";
							} else {
								query1		+= "	DEVL_DATE			= '"+ devlFriDate +"',";
							}
							query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
							query1		+= "	PRICE				= '"+ price +"',";
							query1		+= "	PAY_PRICE			= '"+ price +"',";
							query1		+= "	STATE				= '01',";
							query1		+= "	GOODS_ID			= '"+ goodsId +"',";
							query1		+= "	SHOP_CD				= '"+ shopType +"',";
							query1		+= "	GUBUN_CODE			= '"+ gubunCode +"',";
							query1		+= "	SHOP_ORDER_NUM		= ''";
							try {
								stmt1.executeUpdate(query1);
							} catch (Exception e) {
								out.println(e+"=>"+query1);
								if(true)return;
							}
							
							if (k == 0) minDate = devlDatePhi;
							k++;
						}

					}
					
				} else {
					
					if (cal.get(cal.DAY_OF_WEEK) == 3 || cal.get(cal.DAY_OF_WEEK) == 5) { // 화, 목요일은 배송을 하지 않는다
					} else if ( devlHoliday.equals("0") && (cal.get(cal.DAY_OF_WEEK) == 7 || cal.get(cal.DAY_OF_WEEK) == 1) ) { // 토, 일요일은 배송안함
					} else {
						if (cal.get(cal.DAY_OF_WEEK) == 7 || cal.get(cal.DAY_OF_WEEK) == 1) { // 토, 일요일은 금요일 날짜로
						} else {
							devlFriDate = dt.format(cal.getTime());							
						}
						devlDatePhi		= dt.format(cal.getTime());
					
						query2		= "SELECT SET_CODE FROM ESL_GOODS_CATEGORY_SCHEDULE WHERE CATEGORY_ID = 20 AND DEVL_DATE  = '"+ devlDatePhi + "'";
						try {
							rs2 = stmt2.executeQuery(query2);
						} catch(Exception e) {
							out.println(e+"=>"+query2);
							if(true)return;
						}

						if (rs2.next()) {
							groupCode		= rs2.getString("SET_CODE");
							//price			= rs2.getInt("PRICE");
						}
						rs2.close();
								
						query1		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"' AND HOLIDAY_TYPE = '02'";
						try {
							rs1 = stmt1.executeQuery(query1);
						} catch(Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}

						if (rs1.next()) {
							holidayCnt		= rs1.getInt(1);
						}
						rs1.close();

						if (holidayCnt == 0) {
							query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
							query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
							query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
							query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
							query1		+= "	ORDER_NAME			= '"+ orderName +"',";
							query1		+= "	RCV_NAME			= '"+ rcvName +"',";
							query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
							query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
							query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
							query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
							query1		+= "	RCV_HP				= '"+ rcvHp +"',";
							query1		+= "	RCV_EMAIL			= '"+ email +"',";
							query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
							query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
							query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
							query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
							query1		+= "	PAY_TYPE			= '"+ payType +"',";
							query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
							query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
							query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
							query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
							if ( devlFriDate.equals(devlDatePhi) ) {
								query1		+= "	DEVL_DATE			= '"+ devlDatePhi +"',";
							} else {
								query1		+= "	DEVL_DATE			= '"+ devlFriDate +"',";
							}
							query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
							query1		+= "	PRICE				= '"+ price +"',";
							query1		+= "	PAY_PRICE			= '"+ price +"',";
							query1		+= "	STATE				= '01',";
							query1		+= "	GOODS_ID			= '"+ goodsId +"',";
							query1		+= "	SHOP_CD				= '"+ shopType +"',";
							query1		+= "	GUBUN_CODE			= '"+ gubunCode +"',";
							query1		+= "	SHOP_ORDER_NUM		= ''";
							try {
								stmt1.executeUpdate(query1);
							} catch (Exception e) {
								out.println(e+"=>"+query1);
								if(true)return;
							}
							
							if (k == 0) minDate = devlDatePhi;
							k++;

						}	
					}
				}
				
				i++;
				ordSeq++;				
				if (k > maxK) break;

			}
			
			if (buyBagYn.equals("Y")) {
				query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
				query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
				query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
				query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
				query1		+= "	ORDER_NAME			= '"+ orderName +"',";
				query1		+= "	RCV_NAME			= '"+ rcvName +"',";
				query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
				query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
				query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
				query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
				query1		+= "	RCV_HP				= '"+ rcvHp +"',";
				query1		+= "	RCV_EMAIL			= '"+ email +"',";
				query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
				query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
				query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
				query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
				query1		+= "	PAY_TYPE			= '"+ payType +"',";
				query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
				query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
				query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
				query1		+= "	GROUP_CODE			= '0300668',";
				query1		+= "	DEVL_DATE			= '"+ minDate +"',";
				query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
				query1		+= "	PRICE				= '"+ defaultBagPrice +"',";
				query1		+= "	PAY_PRICE			= '"+ defaultBagPrice +"',";
				query1		+= "	STATE				= '01',";
				query1		+= "	GOODS_ID			= '"+ goodsId +"',";
				query1		+= "	SHOP_CD				= '"+ shopType +"',";
				query1		+= "	GUBUN_CODE			= '0300668',";
				query1		+= "	SHOP_ORDER_NUM		= ''";
				try {
					stmt1.executeUpdate(query1);
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}
			}

			ordSeq++;		
		
		} else if (gubun2.equals("26")) { // 3일 프로모션

			k			= 2;
			maxK		= 4; 
			week		= 1;

			for (int j = 0; j < 100; j++) {
				date			= dt.parse(devlDate);
				Calendar cal	= Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.DATE, j);

				if (devlDay.equals("3")) {
		
					if (cal.get(cal.DAY_OF_WEEK) == 7 || cal.get(cal.DAY_OF_WEEK) == 1) { // 토, 일요일은 배송을 하지 않는다	
					} else {					
				
						if (gubun1.equals("02")) {
							query2		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE WHERE GUBUN2 = '"+ gubun2 +"'";
							query2		+= " AND DAY_OF_WEEK = '"+ k +"' AND GUBUN3 = '"+ week +"'";
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
							
							SimpleDateFormat dt2	= new SimpleDateFormat("yyyy-MM-dd");
							String today		= dt2.format(new Date());
							query2		= " SELECT SALE_TYPE, SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID ";
							query2		+= " WHERE  ('"+today+"' BETWEEN STDATE AND LTDATE) AND (GROUP_CODE = '02291' or GROUP_CODE is null) ";
							query2		+= " ORDER BY ES.ID DESC LIMIT 0, 1";
							try {
								rs2 = stmt2.executeQuery(query2);
							} catch(Exception e) {
								out.println(e+"=>"+query2);
								if(true)return;
							}

							String saleType = 	"";
							int salePrice = 	0;
							if (rs2.next()) {		
								saleType			= rs2.getString("SALE_TYPE");
								salePrice		= rs2.getInt("SALE_PRICE");
								
								if (saleType.equals("P")) {
									price		= (int)Math.round((double)(price  * (double)(100 - salePrice) / 100)) ;
								} else {
									price		= (int)Math.round((double)( (price - salePrice/3))) ;
								}
								
							}
							rs2.close();							

						}
						devlDatePhi		= dt.format(cal.getTime());

						query1		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"' AND HOLIDAY_TYPE = '02'";
						try {
							rs1 = stmt1.executeQuery(query1);
						} catch(Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}

						if (rs1.next()) {
							holidayCnt		= rs1.getInt(1);
						}
						rs1.close();

						query1		= "SELECT COUNT(ID) FROM ESL_MEMBER_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"'";
						query1		+= " AND MEMBER_ID = '"+ memberId +"'";
						if (gubun1.equals("02")) {
							query1		+= " AND GROUP_CODE = '"+ gubunCode +"'";
						} else {
							query1		+= " AND GROUP_CODE = '"+ groupCode +"'";
						}
						query1		+= " AND DEVL_YN = 'N'";
						query1		+= " ORDER BY ID DESC LIMIT 1";
						try {
							rs1 = stmt1.executeQuery(query1);
						} catch(Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}

						if (rs1.next()) {
							holidayCnt		= holidayCnt + rs1.getInt(1);
						}
						rs1.close();

						if (holidayCnt == 0) {
							query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
							query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
							query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
							query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
							query1		+= "	ORDER_NAME			= '"+ orderName +"',";
							query1		+= "	RCV_NAME			= '"+ rcvName +"',";
							query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
							query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
							query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
							query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
							query1		+= "	RCV_HP				= '"+ rcvHp +"',";
							query1		+= "	RCV_EMAIL			= '"+ email +"',";
							query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
							query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
							query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
							query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
							query1		+= "	PAY_TYPE			= '"+ payType +"',";
							query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
							query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
							query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
							query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
							query1		+= "	DEVL_DATE			= '"+ devlDatePhi +"',";
							query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
							query1		+= "	PRICE				= '"+ price +"',";
							query1		+= "	PAY_PRICE			= '"+ price +"',";
							query1		+= "	STATE				= '01',";
							query1		+= "	GOODS_ID			= '"+ goodsId +"',";
							query1		+= "	SHOP_CD				= '"+ shopType +"',";
							query1		+= "	GUBUN_CODE			= '"+ gubunCode +"',";
							query1		+= "	SHOP_ORDER_NUM		= ''";
							try {
								stmt1.executeUpdate(query1);
							} catch (Exception e) {
								out.println(e+"=>"+query1);
								if(true)return;
							}
							//if (k == 0) minDate = devlDatePhi;
							k++;
							if (gubun1.equals("02")) {
								if (k % 5 == 0) week++;
							}
						}
					}	
				}
				i++;
				ordSeq++;				
				if (k > maxK) break;

			}
			
			if (buyBagYn.equals("Y")) {
				query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
				query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
				query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
				query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
				query1		+= "	ORDER_NAME			= '"+ orderName +"',";
				query1		+= "	RCV_NAME			= '"+ rcvName +"',";
				query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
				query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
				query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
				query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
				query1		+= "	RCV_HP				= '"+ rcvHp +"',";
				query1		+= "	RCV_EMAIL			= '"+ email +"',";
				query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
				query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
				query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
				query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
				query1		+= "	PAY_TYPE			= '"+ payType +"',";
				query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
				query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
				query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
				query1		+= "	GROUP_CODE			= '0300668',";
				query1		+= "	DEVL_DATE			= '"+ devlDate +"',";
				query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
				query1		+= "	PRICE				= '"+ defaultBagPrice +"',";
				query1		+= "	PAY_PRICE			= '"+ defaultBagPrice +"',";
				query1		+= "	STATE				= '01',";
				query1		+= "	GOODS_ID			= '"+ goodsId +"',";
				query1		+= "	SHOP_CD				= '"+ shopType +"',";
				query1		+= "	GUBUN_CODE			= '0300668',";
				query1		+= "	SHOP_ORDER_NUM		= ''";
				try {
					stmt1.executeUpdate(query1);
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}
			}

			ordSeq++;	
			
		} else if (devlType.equals("0001")) {
			k			= 0;
			maxK		= (Integer.parseInt(devlDay) * Integer.parseInt(devlWeek)) - 1;

			schIdx		= 2;
			for (int j = 0; j < 500; j++) {
				date			= dt.parse(devlDate);
				Calendar cal	= Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.DATE, j);
				if (devlDay.equals("6")) {
					if (cal.get(cal.DAY_OF_WEEK) == 1) { //일요일은 배송을 하지 않는다
					} else {
						devlDatePhi		= dt.format(cal.getTime());

						query1		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"' AND HOLIDAY_TYPE = '02'";
						try {
							rs1 = stmt1.executeQuery(query1);
						} catch(Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}

						if (rs1.next()) {
							holidayCnt		= rs1.getInt(1);
						}
						rs1.close();

						if (holidayCnt == 0) {
							query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
							query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
							query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
							query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
							query1		+= "	ORDER_NAME			= '"+ orderName +"',";
							query1		+= "	RCV_NAME			= '"+ rcvName +"',";
							query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
							query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
							query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
							query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
							query1		+= "	RCV_HP				= '"+ rcvHp +"',";
							query1		+= "	RCV_EMAIL			= '"+ email +"',";
							query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
							query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
							query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
							query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
							query1		+= "	PAY_TYPE			= '"+ payType +"',";
							query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
							query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
							query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
							query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
							query1		+= "	DEVL_DATE			= '"+ devlDatePhi +"',";
							query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
							query1		+= "	PRICE				= '"+ price +"',";
							query1		+= "	PAY_PRICE			= '"+ price +"',";
							query1		+= "	STATE				= '01',";
							query1		+= "	GOODS_ID			= '"+ goodsId +"',";
							query1		+= "	SHOP_CD				= '"+ shopType +"',";
							query1		+= "	GUBUN_CODE			= '"+ gubunCode +"',";
							query1		+= "	SHOP_ORDER_NUM		= '"+ outOrderNum +"'";
							try {
								stmt1.executeUpdate(query1);
							} catch (Exception e) {
								out.println(e+"=>"+query1);
								if(true)return;
							}
							k++;
						}
					}
				} else {
					if (cal.get(cal.DAY_OF_WEEK) == 7 || cal.get(cal.DAY_OF_WEEK) == 1) { // 토, 일요일은 배송을 하지 않는다	
					} else {
						if (gubun1.equals("02")) {
							query2		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE WHERE GUBUN2 = '"+ gubun2 +"'";
							//query2		+= " AND DAY_OF_WEEK = '"+ cal.get(cal.DAY_OF_WEEK) +"' AND GUBUN3 = '"+ week +"'";
							query2		+= " AND GUBUN3 = '"+ week +"'";
							query2		+= " AND DAY_OF_WEEK = '"+ schIdx +"'";
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

							price			= (payPrice == 0)? 0: price;
						}
						devlDatePhi		= dt.format(cal.getTime());

						query1		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"' AND HOLIDAY_TYPE = '02'";
						try {
							rs1 = stmt1.executeQuery(query1);
						} catch(Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}

						if (rs1.next()) {
							holidayCnt		= rs1.getInt(1);
						}
						rs1.close();

						if (holidayCnt == 0) {
							
							// 날짜 간격 구하기							
							//Calendar cal2	= Calendar.getInstance();
							//cal2.setTime(new Date());

							//int differenceDay = (int)( (cal.getTimeInMillis() - cal2.getTimeInMillis()) / ( 24*60*60*1000) ); 
							
							query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
							query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
							query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
							query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
							query1		+= "	ORDER_NAME			= '"+ orderName +"',";
							query1		+= "	RCV_NAME			= '"+ rcvName +"',";
							query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
							query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
							query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
							query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
							query1		+= "	RCV_HP				= '"+ rcvHp +"',";
							query1		+= "	RCV_EMAIL			= '"+ email +"',";
							query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
							query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
							query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
							query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
							query1		+= "	PAY_TYPE			= '"+ payType +"',";
							query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
							query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
							query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
							
							/*
							if ( differenceDay < 5 ) {
								if (groupCode.equals("0300717")) {
									query1		+= "	GROUP_CODE			= '0301293',";
								} else if (groupCode.equals("0300944")) {
									query1		+= "	GROUP_CODE			= '0301294',";
								} else if (groupCode.equals("0301079")) {
									query1		+= "	GROUP_CODE			= '0301295',";
								} else {
									query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
								}								
							} else {
								query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
							}
							*/
							
							query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
							query1		+= "	DEVL_DATE			= '"+ devlDatePhi +"',";
							query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
							query1		+= "	PRICE				= '"+ price +"',";
							query1		+= "	PAY_PRICE			= '"+ price +"',";
							query1		+= "	STATE				= '01',";
							query1		+= "	GOODS_ID			= '"+ goodsId +"',";
							query1		+= "	SHOP_CD				= '"+ shopType +"',";
							query1		+= "	GUBUN_CODE			= '"+ gubunCode +"',";
							query1		+= "	SHOP_ORDER_NUM		= '"+ outOrderNum +"'";
							try {
								stmt1.executeUpdate(query1);
							} catch (Exception e) {
								out.println(e+"=>"+query1);
								if(true)return;
							}
							k++;
							schIdx++;
							if (gubun1.equals("02")) {
								if (k % 5 == 0) {
									week++;
									schIdx=2;
								}
							}
						}
					}
				}

				i++;
				ordSeq++;
				if (k > maxK) break;
			}

			if (buyBagYn.equals("Y")) {
				defaultBagPrice	= (payPrice == 0)? 0 : defaultBagPrice;
				query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
				query1		+= "	ORDER_DATE			= '"+ orderDate +"',";
				query1		+= "	ORDER_NUM			= '"+ orderNum +"',";
				query1		+= "	CUSTOMER_NUM		= '"+ customerNum +"',";
				query1		+= "	ORDER_NAME			= '"+ orderName +"',";
				query1		+= "	RCV_NAME			= '"+ rcvName +"',";
				query1		+= "	RCV_ZIPCODE			= '"+ rcvZipcode +"',";
				query1		+= "	RCV_ADDR1			= '"+ rcvAddr1 +"',";
				query1		+= "	RCV_ADDR2			= '"+ rcvAddr2 +"',";
				query1		+= "	RCV_TEL				= '"+ rcvTel +"',";
				query1		+= "	RCV_HP				= '"+ rcvHp +"',";
				query1		+= "	RCV_EMAIL			= '"+ email +"',";
				query1		+= "	TOT_SELL_PRICE		= '"+ goodsPrice +"',";
				query1		+= "	TOT_PAY_PRICE		= '"+ payPrice +"',";
				query1		+= "	TOT_DEVL_PRICE		= '"+ devlPrice +"',";
				query1		+= "	TOT_DC_PRICE		= '"+ couponPrice +"',";
				query1		+= "	PAY_TYPE			= '"+ payType +"',";
				query1		+= "	DEVL_TYPE			= '"+ devlType +"',";
				query1		+= "	AGENCYID			= '"+ rcvPartner +"',";
				query1		+= "	RCV_REQUEST			= '"+ rcvRequest +"',";
				query1		+= "	GROUP_CODE			= '0300668',";
				query1		+= "	DEVL_DATE			= '"+ devlDate +"',";
				query1		+= "	ORDER_CNT			= '1',";
				query1		+= "	PRICE				= '"+ defaultBagPrice +"',";
				query1		+= "	PAY_PRICE			= '"+ defaultBagPrice +"',";
				query1		+= "	STATE				= '01',";
				query1		+= "	GOODS_ID			= '"+ goodsId +"',";
				query1		+= "	SHOP_CD				= '"+ shopType +"',";
				query1		+= "	GUBUN_CODE			= '0300668',";
				query1		+= "	SHOP_ORDER_NUM		= '"+ outOrderNum +"'";
				try {
					stmt1.executeUpdate(query1);
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}
			}

			ordSeq++;
		} else {
			
			date			= dt.parse(devlDate);
			Calendar cal	= Calendar.getInstance();
			cal.setTime(date);
			
			boolean bHolyday = true;
			for (int j = 0; j < 31; j++) {
				
				devlDatePhi		= dt.format(cal.getTime());	

				query1		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"' AND HOLIDAY_TYPE = '01'";
				try {
					rs1 = stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}				

				if (rs1.next()) {
					holidayCnt		= rs1.getInt(1);
				}
				rs1.close();
				
				if (holidayCnt > 0) {
					cal.add(Calendar.DATE, 1);
				} else if (cal.get(cal.DAY_OF_WEEK) == 1 || cal.get(cal.DAY_OF_WEEK) == 2) { // 일, 월요일은 배송을 하지 않는다	
					cal.add(Calendar.DATE, 1);
				} else {					
					bHolyday = false;
				}				
	
				if (!bHolyday) break;
			}

			if (gubun2.equals("31")) {
				for (int j = 0; j < 3; j++) {
					if (j == 0) {
						groupCode	= "0300695";
						price		= (payPrice == 0)? 0 : 10000;
					} else if (j == 1) {
						groupCode	= "0300696";
						price		= (payPrice == 0)? 0 : 10000;
					} else if (j == 2) {
						groupCode	= "0300697";
						price		= (payPrice == 0)? 0 : 10000;
					}

%>
<%@ include file="./outmall_phi_query.jsp"%>
<%
				}
			} else if (groupCode.equals("0300978")) {
				for (int j = 0; j < 4; j++) {
					if (j == 0) {
						groupCode	= "0300695";
						orderCnt	= orderCnt;
						price		= (payPrice == 0)? 0 : 10000;
					} else if (j == 1) {
						groupCode	= "0300578";
						orderCnt	= orderCnt;
						price		= (payPrice == 0)? 0 : 35000;
					} else if (j == 2) {
						groupCode	= "0300697";
						orderCnt	= orderCnt;
						price		= (payPrice == 0)? 0 : 10000;
					} else if (j == 3) {
						groupCode	= "0300696";
						orderCnt	= orderCnt * 2;
						price		= (payPrice == 0)? 0 : 10000;						
					}

%>
<%@ include file="./outmall_phi_query.jsp"%>
<%
				}
			} else if (groupCode.equals("0300979")) {
				for (int j = 0; j < 3; j++) {
					if (j == 0) {
						groupCode	= "0300971";
					} else if (j == 1) {
						groupCode	= "0300972";						
					} else if (j == 2) {
						groupCode	= "0300973";						
					}
					price		= (payPrice == 0)? 0 : 6600;

%>
<%@ include file="./outmall_phi_query.jsp"%>
<%
				}
			} else if (groupCode.equals("0300980")) {
				for (int j = 0; j < 3; j++) {
					if (j == 0) {
						groupCode	= "0300971";
					} else if (j == 1) {
						groupCode	= "0300972";						
					} else if (j == 2) {
						groupCode	= "0300974";						
					}
					price		= (payPrice == 0)? 0 : 6600;

%>
<%@ include file="./outmall_phi_query.jsp"%>
<%
				}
			} else if (groupCode.equals("0300981")) {
				for (int j = 0; j < 4; j++) {
					if (j == 0) {
						groupCode	= "0300971";
					} else if (j == 1) {
						groupCode	= "0300972";						
					} else if (j == 2) {
						groupCode	= "0300973";						
					} else if (j == 3) {
						groupCode	= "0300974";						
					}
					price		= (payPrice == 0)? 0 : 6600;

%>
<%@ include file="./outmall_phi_query.jsp"%>
<%
				}
			} else if (groupCode.equals("0301018")) {
				for (int j = 0; j < 2; j++) {
					if (j == 0) {
						groupCode	= "0301000";
					} else if (j == 1) {
						groupCode	= "0301001";						
					}
					price		= (payPrice == 0)? 0 : 14700;

%>
<%@ include file="./outmall_phi_query.jsp"%>
<%
				}
			} else {
%>
<%@ include file="./outmall_phi_query.jsp"%>
<%
			}
		}
	}

	query		= "UPDATE PHIBABY.P_ORDER_MALL_PHI_ITF SET INTERFACE_FLAG_YN = 'Y' WHERE ORD_NO = '"+ orderNum +"'";
	try {
		stmt_phi.executeUpdate(query);
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}

	query		= "SELECT * FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"' AND STATE < 90";
	try {
		rs			= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	i = 1;
	while (rs.next()) {
		// 시퀀스 조회
		query		= "SELECT MAX(ORD_SEQ) FROM PHIBABY.P_ORDER_MALL_PHI_ITF";
		try {
			rs2_phi		= stmt_phi.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs2_phi.next()) {
			ordSeq		= rs2_phi.getInt(1) + 1;
		}
		rs2_phi.close();

		query1		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
		query1		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM, SHOP_CD, GOODS_LEVEL, SHOP_ORD_NO)";
		query1		+= "	VALUES";
		query1		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?, ?, ?)";
		pstmt2_phi	= conn_phi.prepareStatement(query1);

		pstmt2_phi.setInt(1, ordSeq);
		pstmt2_phi.setString(2, rs.getString("ORDER_DATE"));
		pstmt2_phi.setString(3, orderNum);
		pstmt2_phi.setString(4, rs.getString("CUSTOMER_NUM"));
		pstmt2_phi.setString(5, "I");
		pstmt2_phi.setString(6, rs.getString("ORDER_NAME"));
		pstmt2_phi.setString(7, rs.getString("RCV_NAME"));
		pstmt2_phi.setString(8, rs.getString("RCV_ZIPCODE"));
		pstmt2_phi.setString(9, rs.getString("RCV_ADDR1"));
		pstmt2_phi.setString(10, rs.getString("RCV_ADDR2"));
		pstmt2_phi.setString(11, rs.getString("RCV_TEL"));
		pstmt2_phi.setString(12, rs.getString("RCV_HP"));
		pstmt2_phi.setString(13, rs.getString("RCV_EMAIL"));
		pstmt2_phi.setInt(14, rs.getInt("TOT_SELL_PRICE"));
		pstmt2_phi.setInt(15, rs.getInt("TOT_PAY_PRICE"));
		pstmt2_phi.setInt(16, rs.getInt("TOT_DEVL_PRICE"));
		pstmt2_phi.setInt(17, rs.getInt("TOT_DC_PRICE"));
		pstmt2_phi.setString(18, rs.getString("PAY_TYPE"));
		pstmt2_phi.setString(19, rs.getString("DEVL_TYPE"));
		pstmt2_phi.setString(20, rs.getString("AGENCYID"));
		pstmt2_phi.setString(21, rs.getString("RCV_REQUEST"));
		pstmt2_phi.setInt(22, i);
		pstmt2_phi.setString(23, rs.getString("DEVL_DATE").replace("-",""));
		pstmt2_phi.setString(24, rs.getString("GROUP_CODE"));
		pstmt2_phi.setInt(25, rs.getInt("ORDER_CNT"));
		pstmt2_phi.setInt(26, rs.getInt("PRICE"));
		pstmt2_phi.setInt(27, rs.getInt("PAY_PRICE"));
		pstmt2_phi.setString(28, rs.getString("SHOP_CD"));
		pstmt2_phi.setString(29, rs.getString("GUBUN_CODE"));
		pstmt2_phi.setString(30, rs.getString("SHOP_ORDER_NUM"));
		try {
			pstmt2_phi.executeUpdate();
		} catch (Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		} finally {
			if (pstmt2_phi != null) try {pstmt2_phi.close();}catch(Exception e) {}
		}

		i++;
	}
}
%>