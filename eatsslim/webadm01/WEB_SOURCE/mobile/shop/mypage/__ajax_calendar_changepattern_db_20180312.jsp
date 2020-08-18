<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_ORDER_DEVL_DATE";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
boolean error		= false;
String code			= "";
String data			= "";
int ordSeq			= 0;
int i				= 0;
String where		= "";
String minDevlDate	= "";
String maxDevlDate	= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat dt2	= new SimpleDateFormat("yyyy-MM-dd");
String instDate		= dt.format(new Date());
Calendar cal		= Calendar.getInstance();
String mode			= ut.inject(request.getParameter("mode"));
String userIp		= request.getRemoteAddr();
String orderNum		= ut.inject(request.getParameter("order_num"));
String subNum		= ut.inject(request.getParameter("sub_num"));
String gubunCode	= ut.inject(request.getParameter("gubun_code"));
String groupCode	= ut.inject(request.getParameter("group_code"));
int devlId			= 0;
String devlDate		= ut.inject(request.getParameter("devl_date"));
int orderCnt		= 0;
if (request.getParameter("order_cnt") != null && request.getParameter("order_cnt").length()>0)
	orderCnt			= Integer.parseInt(request.getParameter("order_cnt"));
int chkCnt			= 0;
String devlDay		= "";
int week			= 0;
String rcvPartner	= "";
int price			= 0;
String devlDatePattern		= ut.inject(request.getParameter("devl_date_pattern"));
String startDatePattern		= ut.inject(request.getParameter("start_date_pattern"));
String patternDays[]		= request.getParameterValues("pattern_days");
Date date			= null;

int rowCount		= 0;
// PHI 시퀀스 조회
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

/*
if (eslMemberId == null || eslMemberId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[로그인을 해주세요.]]></error>";
} else
*/
if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
}  else if (mode.equals("updPtAll")) {
	int intTotalCnt = 0;
	int intCurCnt = 0;
	
	// 기존 가격 정보 저장
	query		= "SELECT GROUP_CODE, PRICE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
	query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE not in ( '0300668', '0301340' )";
	query		+= " AND PRICE > 0 ";
	query		+= " GROUP BY GROUP_CODE, PRICE ";
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	
	List<String[]> price_goods = new ArrayList<String[]>();
	while (rs.next()) {
		price_goods.add(new String[]{rs.getString("GROUP_CODE"),  Integer.toString(rs.getInt("PRICE"))});
	}

	// 기존 배송수량 저장
	query		= "SELECT SUM(ORDER_CNT) FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
	query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE not in ( '0300668', '0301340' )";
	query		+= " AND DEVL_DATE >= '" + devlDatePattern + "'";
	//query		+= " GROUP BY GROUP_CODE, PRICE ";
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		intTotalCnt = rs.getInt(1); //총 레코드 수		
	}

	// 주문내역 삭제
	/*
	query		= "DELETE FROM ESL_ORDER_DEVL_DATE ";
	query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
	try {
		stmt.executeUpdate(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	*/
	//rs.close();
	
	
	query		= "SELECT ID, STATE, GROUP_CODE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
	query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE not in ( '0300668', '0301340' )";
	query		+= " AND DEVL_DATE >= '" + devlDatePattern + "'";
	query		+= " ORDER BY DEVL_DATE ";
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}		
	
	date			= dt2.parse(startDatePattern);
	//data		= "<price>"+ devlDatePattern +"</price>";
	cal.setTime(date);
	

	int j = 0;
	int m = 0;
	String devlDatePhi = "";

	String[] arrDate;
	//arrDate	= patternDays.split(",");
	boolean bDays;
	boolean bDel;
	//data		= "<price>"+ patternDays[1] +"</price>";
	while (rs.next()) {
		rowCount++;
		bDays = false;
		bDel = true;
		for (j=0;j<30;j++) {
			
			chkCnt	= 0;
			devlDatePhi		= dt.format(cal.getTime());

			query1		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"' AND HOLIDAY_TYPE = '02'";
			try {
				rs1 = stmt1.executeQuery(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

			if (rs1.next()) {
				chkCnt		= rs1.getInt(1);
			}
			rs1.close();
			
			if (chkCnt == 0) {
				for (m=0;m<patternDays.length;m++) {
					if (Integer.parseInt(patternDays[m]) == cal.get(cal.DAY_OF_WEEK)) {
						bDays = true;
						break;
					}
				}
			}
			//cal.add(Calendar.DATE, 1);
			if (bDays) {
				break;
			} else {
				cal.add(Calendar.DATE, 1);
			}
		}
		
		if ( bDays ) {
			devlId		= rs.getInt("ID");
			groupCode		= rs.getString("GROUP_CODE");
			intCurCnt = intCurCnt + orderCnt;
			
			query1		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
			
			
			// 날짜 간격 구하기							
			//date = dt2.parse(orderDate);
			Calendar cal2	= Calendar.getInstance();
			cal2.setTime(new Date());

			int differenceDay = (int)( (cal.getTimeInMillis() - cal2.getTimeInMillis()) / ( 24*60*60*1000) ); 
			if (differenceDay  < 5 ) {
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
			
			query1		+= "	DEVL_DATE		= '"+ dt.format(cal.getTime()) +"', ";
			if ( (intTotalCnt - intCurCnt) > 0 ) {
				query1		+= "	ORDER_CNT		= '"+ orderCnt +"' ";
			} else {
				
				if ((intTotalCnt - intCurCnt + orderCnt ) < 0 ) {
					query1		+= "	ORDER_CNT		= '0' ";
				} else {
					query1		+= "	ORDER_CNT		= '"+ (intTotalCnt - intCurCnt + orderCnt) +"' ";
				}
				//bDel = false;
			}				
			query1		+= " WHERE ID = "+ devlId;
			
			try {
				stmt1.executeUpdate(query1);
				

			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

		}
		
		if ((intTotalCnt - intCurCnt + orderCnt) <= 0) {
			devlId		= rs.getInt("ID");
			
			query1		= "DELETE FROM ESL_ORDER_DEVL_DATE ";
			query1		+= " WHERE ID = "+ devlId;
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				//if(true)return;
			}
			
		}
		
		cal.add(Calendar.DATE, 1);
	}
	rs.close();
		
		
		
		
	//남은 수량
	if (intTotalCnt > intCurCnt ) {
		rowCount++;

		for (int n=1;n<intTotalCnt-intCurCnt+1;n++) {
			String stdate		= "";	

			bDays = false;
			for (j=0;j<30;j++) {
				stdate		= dt.format(cal.getTime());	
				
				query		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ stdate +"' AND HOLIDAY_TYPE = '02'";
				try {
					rs			= stmt.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs.next()) {
					chkCnt		= rs.getInt(1);
				}
				rs.close();
				
				
				if (chkCnt == 0) {
					for (m=0;m<patternDays.length;m++) {
						if (Integer.parseInt(patternDays[m]) == cal.get(cal.DAY_OF_WEEK)) {
							bDays = true;
							break;
						}
					}
				}
				
				if (bDays) {
					break;
				} else {
					cal.add(Calendar.DATE, 1);
				}

			}

			stdate		= dt.format(cal.getTime());
			query		= "SELECT DEVL_DAY, DAYOFWEEK('"+ stdate +"') WEEK FROM ESL_ORDER_GOODS ";
			query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND ID = "+ subNum;
			query		+= " AND GROUP_ID = (SELECT ID FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ gubunCode +"')";
			try {
				rs			= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			if (rs.next()) {
				devlDay		= rs.getString("DEVL_DAY");
				week		= rs.getInt("WEEK");
			}
			rs.close();

			query		= "SELECT * FROM ESL_ORDER_DEVL_DATE";
			query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ subNum;
			if (gubunCode.length() < 7) {
				query		+= " AND GUBUN_CODE = '"+ gubunCode +"'";
			} else {
				query		+= " AND GROUP_CODE not in ( '0300668', '0301340' )";
			}
			query		+= " ORDER BY ID DESC LIMIT 1";
			try {
				rs			= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
			
			if (rs.next()) {
					
				String insGubunCode		= "";
				int insPrice			= 0;
				int insPayPrice			= 0;

				if (gubunCode.equals("0300668")) {
					groupCode		= "0300668";
					insGubunCode	= "0300668";
					insPrice		= defaultBagPrice;
					insPayPrice		= defaultBagPrice;
				} else {
					groupCode		= rs.getString("GROUP_CODE");
					insGubunCode	= rs.getString("GUBUN_CODE");
					insPrice		= rs.getInt("PRICE");
					insPayPrice		= rs.getInt("PAY_PRICE");
				}

				if (insGubunCode.equals("0331") && !insGubunCode.equals("0300668")) {
					query1		= "SELECT GROUP_CODE FROM ESL_PG_DELIVERY_SCHEDULE ";
					query1		+= " WHERE GUBUN2 = '31' AND DAY_OF_WEEK = '"+ week +"'";
					try {
						rs1	= stmt1.executeQuery(query1);
					} catch(Exception e) {
						out.println(e+"=>"+query1);
						if (true) return;
					}

					if (rs1.next()) {
						groupCode		= rs1.getString("GROUP_CODE");
					}
					rs1.close();
				}
				
				
									
				// 날짜 간격 구하기							
				//date = dt2.parse(orderDate);
				Calendar cal2	= Calendar.getInstance();
				cal2.setTime(new Date());

				int differenceDay = (int)( (cal.getTimeInMillis() - cal2.getTimeInMillis()) / ( 24*60*60*1000) ); 
				
				
				query1		= "INSERT INTO ESL_ORDER_DEVL_DATE SET ";
				query1		+= "	ORDER_DATE			= '"+ rs.getString("ORDER_DATE") +"',";
				query1		+= "	ORDER_NUM			= '"+ rs.getString("ORDER_NUM") +"',";
				query1		+= "	CUSTOMER_NUM		= '"+ rs.getString("CUSTOMER_NUM") +"',";
				query1		+= "	ORDER_NAME			= '"+ rs.getString("ORDER_NAME") +"',";
				query1		+= "	RCV_NAME			= '"+ rs.getString("RCV_NAME") +"',";
				query1		+= "	RCV_ZIPCODE			= '"+ rs.getString("RCV_ZIPCODE") +"',";
				query1		+= "	RCV_ADDR1			= '"+ rs.getString("RCV_ADDR1") +"',";
				query1		+= "	RCV_ADDR2			= '"+ rs.getString("RCV_ADDR2") +"',";
				query1		+= "	RCV_TEL				= '"+ rs.getString("RCV_TEL") +"',";
				query1		+= "	RCV_HP				= '"+ rs.getString("RCV_HP") +"',";
				query1		+= "	RCV_EMAIL			= '"+ rs.getString("RCV_EMAIL") +"',";
				query1		+= "	TOT_SELL_PRICE		= '"+ rs.getInt("TOT_SELL_PRICE") +"',";
				query1		+= "	TOT_PAY_PRICE		= '"+ rs.getInt("TOT_PAY_PRICE") +"',";
				query1		+= "	TOT_DEVL_PRICE		= '"+ rs.getInt("TOT_DEVL_PRICE") +"',";
				query1		+= "	TOT_DC_PRICE		= '"+ rs.getInt("TOT_DC_PRICE") +"',";
				query1		+= "	PAY_TYPE			= '"+ rs.getString("PAY_TYPE") +"',";
				query1		+= "	DEVL_TYPE			= '"+ rs.getString("DEVL_TYPE") +"',";
				query1		+= "	AGENCYID			= '"+ rs.getString("AGENCYID") +"',";
				query1		+= "	RCV_REQUEST			= '"+ rs.getString("RCV_REQUEST") +"',";

				if (differenceDay  < 5 ) {
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
				//query1		+= "	GROUP_CODE			= '"+ gubunCode +"',";
				query1		+= "	DEVL_DATE			= '"+ stdate +"',";
				
				if ( (intTotalCnt - intCurCnt + n*orderCnt) > 0 ) {
					query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
				} else {
					query1		+= "	ORDER_CNT			= '"+ (intTotalCnt - intCurCnt + orderCnt) +"',";
				}
				
				query1		+= "	PRICE				= '"+ insPrice +"',";
				query1		+= "	PAY_PRICE			= '"+ insPayPrice +"',";
				query1		+= "	STATE				= '01',";
				query1		+= "	GOODS_ID			= '"+ rs.getInt("GOODS_ID") +"',";
				query1		+= "	SHOP_CD				= '"+ rs.getString("SHOP_CD") +"',";
				query1		+= "	GUBUN_CODE			= '"+ insGubunCode +"',";
				query1		+= "	SHOP_ORDER_NUM		= '"+ rs.getString("SHOP_ORDER_NUM") +"'";

				try {
					stmt1.executeUpdate(query1);
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}				

			}
			cal.add(Calendar.DATE, 1);			
					
		}
		
						
		if (gubunCode.substring(0, 2).equals("02")) {
			
			query		= "SELECT ID, STATE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE not in ( '0300668', '0301340' )";
			query		+= " AND DEVL_DATE >= '" + startDatePattern + "'";
			query		+= " ORDER BY DEVL_DATE ";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}			
			
			String strState = "";
			i		= 1;
			week	= 1;
			while (rs.next()) {
				devlId		= rs.getInt("ID");

				query1		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE";
				query1		+= " WHERE GUBUN2 = '"+ gubunCode.substring(2, 4) +"'";
				query1		+= " AND GUBUN3 = '"+ week +"'";
				try {
					rs1 = stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}

				if (rs1.next()) {
					groupCode		= rs1.getString("GROUP_CODE");
					price			= rs1.getInt("PRICE");
				}
				rs1.close();
				
				if (rs.getString("STATE").equals("02"))  {
					price = 0;
				} else {
					for (j=0;j<price_goods.size();j++) {
						if (price_goods.get(j)[0].equals(groupCode)) {
							price = Integer.parseInt(price_goods.get(j)[1]);
						}
					}
				}
				
				query1		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
				query1		+= "				GROUP_CODE	= '"+ groupCode +"'";
				query1		+= "				, PRICE		= '"+ price +"'";
				query1		+= "				, PAY_PRICE	= '"+ price +"'";
				query1		+= " WHERE ID = "+ devlId;
				try {
					stmt1.executeUpdate(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}

				if (i % 5 == 0) week++;
				i++;
				if (gubunCode.substring(2, 4).equals("25")) {
					if (week % 3 == 0) week = 1;
				} else {
					if (week % 5 == 0) week = 1;
				}					
				
			}
			rs.close();
								
		}
	}
	if(rowCount > 0){

%>
<%@ include file="/esl_admin/order/order_phi_copy.jsp" %>
<%

		query		= "UPDATE ESL_ORDER SET ";
		query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n고객배송패턴변경 ', NOW())";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt1.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
	
		code		= "success";
	}
	else{
		code		= "error";
		data		= "<error><![CDATA[변경할 내용이 없습니다.]]></error>";		
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose.jsp"%>
<%@ include file="/lib/dbclose_phi.jsp"%>