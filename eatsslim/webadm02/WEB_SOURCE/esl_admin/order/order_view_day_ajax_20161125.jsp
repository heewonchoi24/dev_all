<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../lib/config.jsp" %>
<%@ include file="/lib/dbconn_bm.jsp"%>
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
String instId		= (String)session.getAttribute("esl_admin_id");
String userIp		= request.getRemoteAddr();
String orderNum		= ut.inject(request.getParameter("order_num"));
String subNum		= ut.inject(request.getParameter("sub_num"));
String gubunCode	= ut.inject(request.getParameter("gubun_code"));
String groupCode	= ut.inject(request.getParameter("group_code"));
String giftType		= ut.inject(request.getParameter("giftType"));
String[] devlIds	= request.getParameterValues("devl_ids");
int devlId			= 0;
if (request.getParameter("devl_id") != null && request.getParameter("devl_id").length()>0)
	devlId				= Integer.parseInt(request.getParameter("devl_id"));
String orgDevlDate		= ut.inject(request.getParameter("org_devl_date"));
int orgOrderCnt		= 0;
if (request.getParameter("org_order_cnt") != null && request.getParameter("org_order_cnt").length()>0)
	orgOrderCnt			= Integer.parseInt(request.getParameter("org_order_cnt"));
String orgOrderGood	= ut.inject(request.getParameter("org_order_good"));
String devlDate		= ut.inject(request.getParameter("devl_date"));
int orderCnt		= 0;
if (request.getParameter("order_cnt") != null && request.getParameter("order_cnt").length()>0)
	orderCnt			= Integer.parseInt(request.getParameter("order_cnt"));
int chkCnt			= 0;
String devlDay		= "";
int week			= 0;
int schIdx			= 0;
String rcvPartner	= "";
int price			= 0;
String devlDatePattern		= ut.inject(request.getParameter("devl_date_pattern"));
String startDatePattern		= ut.inject(request.getParameter("start_date_pattern"));
String patternDays[]		= request.getParameterValues("pattern_days");
Date date			= null;

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


if (instId == null || instId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[로그인을 해주세요.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (mode.equals("editDevl")) {
	query		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDate +"' AND HOLIDAY_TYPE = '02'";
	try {
		rs			= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		chkCnt		= rs.getInt(1);
	}

	query		= "SELECT DEVL_DAY, DAYOFWEEK('"+ devlDate +"') WEEK FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'";
	query		+= " AND GROUP_ID = (SELECT ID FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ groupCode +"')";
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

	if (chkCnt > 0) {
		code		= "error";
		data		= "<error><![CDATA[관리자 휴무일에는 배송이 불가능합니다.]]></error>";
	} else if (devlDay.equals("5") && (week == 1 || week == 7)) {
		code		= "error";
		data		= "<error><![CDATA[토,일 배송이 불가능한 상품입니다.]]></error>";
	} else if ((devlDay.equals("6") || devlDay.equals("7")) && (week == 1)) {
		code		= "error";
		data		= "<error><![CDATA[일 배송이 불가능한 상품입니다.]]></error>";
	} else {
		if (orderCnt > 0) {
			
			query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
			
			// 날짜 간격 구하기							
			cal.setTime(new Date());
			Calendar cal2	= Calendar.getInstance();
			date = dt2.parse(devlDate);
			cal2.setTime(date);
			
			
			
			int differenceDay = (int)( (cal2.getTimeInMillis() - cal.getTimeInMillis()) / ( 24*60*60*1000) ); 
			//System.out.println("gg: "+differenceDay);
			if (differenceDay  < 5 ) {
				//System.out.println("gg1: "+orgOrderGood);
				if (orgOrderGood.equals("0300717")) {
					query		+= "	GROUP_CODE			= '0301293',";
				} else if (orgOrderGood.equals("0300944")) {
					query		+= "	GROUP_CODE			= '0301294',";
				} else if (orgOrderGood.equals("0301079")) {
					query		+= "	GROUP_CODE			= '0301295',";
				} 
			} else {
				//System.out.println("gg2: "+orgOrderGood);
				if (orgOrderGood.equals("0301293")) {
					query		+= "	GROUP_CODE			= '0300717',";
				} else if (orgOrderGood.equals("0301294")) {
					query		+= "	GROUP_CODE			= '0300944',";
				} else if (orgOrderGood.equals("0301295")) {
					query		+= "	GROUP_CODE			= '0301079',";
				} 
			}

			query		+= "		DEVL_DATE = '"+ devlDate +"',";
			query		+= "		ORDER_CNT = "+ orderCnt;
		} else {
			query		= "DELETE FROM ESL_ORDER_DEVL_DATE ";
		}
		query		+= " WHERE ID = "+ devlId;
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (gubunCode.substring(0, 2).equals("02")) {
			
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
			rs.close();
			

			query		= "SELECT ID, STATE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE not in ( '0300668', '0301340' )";
			query		+= " ORDER BY DEVL_DATE ";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}			
			
			int j = 0;
			String strState = "";
			i		= 1;
			week	= 1;
			schIdx	= 2;
			while (rs.next()) {
				devlId		= rs.getInt("ID");

				query1		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE";
				query1		+= " WHERE GUBUN2 = '"+ gubunCode.substring(2, 4) +"'";
				query1		+= " AND GUBUN3 = '"+ week +"'";
				query1		+= " AND DAY_OF_WEEK = '"+ schIdx +"'";
				
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
				
				if (i % 5 == 0) {
					week++;schIdx=2;
				} else {
					schIdx++;
				}
				i++;

				if (gubunCode.substring(2, 4).equals("25")) {
					if (week % 3 == 0) week = 1;
				} else {
					if (week % 5 == 0) week = 1;
				}					
				
			}
			rs.close();
		}					


		if (!orgDevlDate.equals(devlDate)) {
			query		= "UPDATE ESL_ORDER SET ";
			query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n배송일 변경 ("+ orgDevlDate +" => "+ devlDate +") ', NOW())";
			query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
			try {
				stmt.executeUpdate(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
		}
		
%>
<%@ include file="order_phi_copy.jsp" %>
<%

		if (orgOrderCnt != orderCnt) {
			query		= "UPDATE ESL_ORDER SET ";
			query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n수량 변경 ("+ devlDate +" : "+ orgOrderCnt +" => "+ orderCnt +") ', NOW())";
			query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
			try {
				stmt.executeUpdate(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
		}

		code		= "success";
	}
} else if (mode.equals("updAll")) {
	for (i = 0; i < devlIds.length; i++) {
		devlId			= Integer.parseInt(devlIds[i]);
		devlDate		= ut.inject(request.getParameter("devl_date_"+ devlId));
		orderCnt		= Integer.parseInt(request.getParameter("order_cnt_"+ devlId));
		orgOrderGood	= request.getParameter("org_order_good_"+ devlId);

		if (orderCnt > 0) {
			query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
			
			
			// 날짜 간격 구하기							
			cal.setTime(new Date());
			Calendar cal2	= Calendar.getInstance();
			date = dt2.parse(devlDate);
			cal2.setTime(date);			
			
			
			int differenceDay = (int)( (cal2.getTimeInMillis() - cal.getTimeInMillis()) / ( 24*60*60*1000) ); 
			//System.out.println("gg: "+differenceDay);
			if (differenceDay  < 5 ) {
				//System.out.println("gg1: "+orgOrderGood);
				if (orgOrderGood.equals("0300717")) {
					query		+= "	GROUP_CODE			= '0301293',";
				} else if (orgOrderGood.equals("0300944")) {
					query		+= "	GROUP_CODE			= '0301294',";
				} else if (orgOrderGood.equals("0301079")) {
					query		+= "	GROUP_CODE			= '0301295',";
				} 
			} else {
				//System.out.println("gg2: "+orgOrderGood);
				if (orgOrderGood.equals("0301293")) {
					query		+= "	GROUP_CODE			= '0300717',";
				} else if (orgOrderGood.equals("0301294")) {
					query		+= "	GROUP_CODE			= '0300944',";
				} else if (orgOrderGood.equals("0301295")) {
					query		+= "	GROUP_CODE			= '0301079',";
				} 
			}			
			
			
			query		+= "				DEVL_DATE		= '"+ devlDate +"',";
			query		+= "				ORDER_CNT		= "+ orderCnt;
		} else {
			query		= "DELETE FROM ESL_ORDER_DEVL_DATE ";
		}
		query		+= " WHERE ID = "+ devlId;
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
	}

	if (gubunCode.substring(0, 2).equals("02")) {
		
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
		rs.close();
		

		query		= "SELECT ID, STATE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
		query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE not in ( '0300668', '0301340' )";
		query		+= " ORDER BY DEVL_DATE ";
		try {
			rs		= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}			
		
		int j = 0;
		String strState = "";
		i		= 1;
		week	= 1;
		schIdx	= 2;
		while (rs.next()) {
			devlId		= rs.getInt("ID");

			query1		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE";
			query1		+= " WHERE GUBUN2 = '"+ gubunCode.substring(2, 4) +"'";
			query1		+= " AND GUBUN3 = '"+ week +"'";
			query1		+= " AND DAY_OF_WEEK = '"+ schIdx +"'";
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

			if (i % 5 == 0) {
				week++;schIdx=2;
			} else {
				schIdx++;
			}			
			i++;
			if (gubunCode.substring(2, 4).equals("25")) {
				if (week % 3 == 0) week = 1;
			} else {
				if (week % 5 == 0) week = 1;
			}					
			
		}
		rs.close();
	}					

%>
<%@ include file="order_phi_copy.jsp" %>
<%

	query		= "UPDATE ESL_ORDER SET ";
	query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n일괄변경 ', NOW())";
	query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
	try {
		stmt1.executeUpdate(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	code		= "success";
} else if (mode.equals("setGift")) {
	String stdate		= ut.inject(request.getParameter("stdate"));

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

	if (chkCnt > 0) {
		code		= "error";
		data		= "<error><![CDATA[관리자 휴무일에는 배송이 불가능합니다.]]></error>";
	} else if (devlDay.equals("5") && (week == 1 || week == 7)) {
		code		= "error";
		data		= "<error><![CDATA[토,일 배송이 불가능한 상품입니다.]]></error>";
	} else if (devlDay.equals("6") && (week == 1)) {
		code		= "error";
		data		= "<error><![CDATA[일 배송이 불가능한 상품입니다.]]></error>";
	} else {
		query		= "SELECT * FROM ESL_ORDER_DEVL_DATE";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ subNum;
		query		+= " AND GROUP_CODE not in ( '0300668', '0301340' )";
		query		+= " ORDER BY ID DESC LIMIT 1";
		try {
			rs			= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>1"+query);
			if(true)return;
		}

		if (rs.next()) {
			
			if (gubunCode.length() < 7) {
				groupCode		= rs.getString("GROUP_CODE");
			} else {
				groupCode		= gubunCode;
			}
			
			if (gubunCode.equals("0331")) {
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
			query1		+= "	RCV_REQUEST			= '"+ ut.inject(rs.getString("RCV_REQUEST")) +"',";
			query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
			query1		+= "	DEVL_DATE			= '"+ stdate +"',";
			query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
			query1		+= "	PRICE				= 0,";
			query1		+= "	PAY_PRICE			= 0,";
			query1		+= "	STATE				= '02',";
			query1		+= "	STATE_DETAIL		= '"+ giftType +"',";
			query1		+= "	GOODS_ID			= '"+ rs.getInt("GOODS_ID") +"',";
			query1		+= "	SHOP_CD				= '"+ rs.getString("SHOP_CD") +"',";
			query1		+= "	GUBUN_CODE			= '"+ rs.getString("GUBUN_CODE") +"',";
			query1		+= "	SHOP_ORDER_NUM		= '"+ rs.getString("SHOP_ORDER_NUM") +"'";
			try {
				stmt1.executeUpdate(query1);
			} catch (Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}
%>
<%@ include file="order_phi_copy.jsp" %>
<%
			query1		= "UPDATE ESL_ORDER SET ";
			query1		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n증정 반영("+ stdate +") ', NOW())";
			query1		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

			code		= "success";
		} else {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
	}
} else if (mode.equals("addDevlDate")) {
	String stdate		= ut.inject(request.getParameter("stdate"));	

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

	if (chkCnt > 0) {
		code		= "error";
		data		= "<error><![CDATA[관리자 휴무일에는 배송이 불가능합니다.]]></error>";
	} else if (devlDay.equals("5") && (week == 1 || week == 7)) {
		code		= "error";
		data		= "<error><![CDATA[토,일 배송이 불가능한 상품입니다.]]></error>";
	} else if (devlDay.equals("6") && (week == 1)) {
		code		= "error";
		data		= "<error><![CDATA[일 배송이 불가능한 상품입니다.]]></error>";
	} else {
		query		= "SELECT * FROM ESL_ORDER_DEVL_DATE";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ subNum;
		if (groupCode.length() < 7) {
			query		+= " AND GUBUN_CODE = '"+ groupCode +"'";
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

			if (groupCode.equals("0300668")) {
				groupCode		= "0300668";
				insGubunCode	= "0300668";
				insPrice		= defaultBagPrice;
				insPayPrice		= defaultBagPrice;
			} else if (groupCode.equals("03006681")) {
				groupCode		= "0300668";
				insGubunCode	= "0300668";
				insPrice		= 3600;
				insPayPrice		= 3600;
			} else if (groupCode.equals("03006682")) {
				groupCode		= "0300668";
				insGubunCode	= "0300668";
				insPrice		= 0;
				insPayPrice		= 0;
			} else {
				groupCode		= rs.getString("GROUP_CODE");
				insGubunCode	= rs.getString("GUBUN_CODE");
				insPrice		= rs.getInt("PRICE");
				insPayPrice		= rs.getInt("PAY_PRICE");
			}

			if (gubunCode.equals("0331") && !groupCode.equals("0300668")) {
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
			
			if (groupCode.equals("0300668")) {
				query1		= "UPDATE ESL_ORDER_GOODS SET ";
				query1		+= "				buy_bag_yn = 'Y'";
				query1		+= " WHERE ID = "+ subNum;
				try {
					stmt1.executeUpdate(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}	

				query1		= "UPDATE ESL_ORDER SET ";
				query1		+= "				goods_price  = goods_price + " + insPrice;
				query1		+= "				, pay_price  = pay_price + " + insPrice;
				query1		+= " WHERE order_num = '"+ rs.getString("ORDER_NUM") + "' ";
				try {
					stmt1.executeUpdate(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}
				
				query1		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
				query1		+= "				tot_sell_price    = tot_sell_price + " + insPrice;
				query1		+= "				, tot_pay_price   = tot_pay_price + " + insPrice;
				query1		+= " WHERE order_num = '"+ rs.getString("ORDER_NUM") + "' ";
				try {
					stmt1.executeUpdate(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}					
			}
			
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
			if (groupCode.equals("0300668")) {
				query1		+= "	TOT_SELL_PRICE		= "+ rs.getInt("TOT_SELL_PRICE") + "+" + insPrice + ",";
				query1		+= "	TOT_PAY_PRICE		= "+ rs.getInt("TOT_PAY_PRICE") + "+" + insPrice + ",";
			} else {
				query1		+= "	TOT_SELL_PRICE		= "+ rs.getInt("TOT_SELL_PRICE") + ",";
				query1		+= "	TOT_PAY_PRICE		= "+ rs.getInt("TOT_PAY_PRICE") + ",";
			}
			query1		+= "	TOT_DEVL_PRICE		= '"+ rs.getInt("TOT_DEVL_PRICE") +"',";
			query1		+= "	TOT_DC_PRICE		= '"+ rs.getInt("TOT_DC_PRICE") +"',";
			query1		+= "	PAY_TYPE			= '"+ rs.getString("PAY_TYPE") +"',";
			query1		+= "	DEVL_TYPE			= '"+ rs.getString("DEVL_TYPE") +"',";
			query1		+= "	AGENCYID			= '"+ rs.getString("AGENCYID") +"',";
			query1		+= "	RCV_REQUEST			= '"+ rs.getString("RCV_REQUEST") +"',";
			query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
			query1		+= "	DEVL_DATE			= '"+ stdate +"',";
			query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
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

			
			
			if ((gubunCode.substring(0, 2)).equals("02")) {
				
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
				rs.close();
				
	
				query		= "SELECT ID, STATE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
				query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE not in ( '0300668', '0301340' )";
				query		+= " ORDER BY DEVL_DATE ";
				try {
					rs		= stmt.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}			
				
				int j = 0;
				String strState = "";
				i		= 1;
				week	= 1;
				schIdx	= 2;
				while (rs.next()) {
					devlId		= rs.getInt("ID");

					query1		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE";
					query1		+= " WHERE GUBUN2 = '"+ gubunCode.substring(2, 4) +"'";
					query1		+= " AND GUBUN3 = '"+ week +"'";
					query1		+= " AND DAY_OF_WEEK = '"+ schIdx +"'";
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

					if (i % 5 == 0) {
						week++;schIdx=2;
					} else {
						schIdx++;
					}					
					i++;
					if (gubunCode.substring(2, 4).equals("25")) {
						if (week % 3 == 0) week = 1;
					} else {
						if (week % 5 == 0) week = 1;
					}					
					
				}
				rs.close();
			}				
					
			
%>
<%@ include file="order_phi_copy.jsp" %>
<%
			query1		= "UPDATE ESL_ORDER SET ";
			query1		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n배송, 수량 추가("+ stdate +", "+ orderCnt +") ', NOW())";
			query1		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
			try {
				stmt1.executeUpdate(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

			code		= "success";
		} else {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
	}
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
			schIdx	= 2;
			while (rs.next()) {
				devlId		= rs.getInt("ID");

				query1		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE";
				query1		+= " WHERE GUBUN2 = '"+ gubunCode.substring(2, 4) +"'";
				query1		+= " AND GUBUN3 = '"+ week +"'";
				query1		+= " AND DAY_OF_WEEK = '"+ schIdx +"'";
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

				if (i % 5 == 0) {
					week++;schIdx=2;
				} else {
					schIdx++;
				}				
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

%>
<%@ include file="order_phi_copy.jsp" %>
<%

	query		= "UPDATE ESL_ORDER SET ";
	query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n요일패턴 일괄변경 ', NOW())";
	query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
	try {
		stmt1.executeUpdate(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	code		= "success";
} else if (mode.equals("phiCopy")) {
%>
<%@ include file="order_phi_copy.jsp" %>
<%
	code		= "success";
} else if (mode.equals("editAddress")) {
	String zipcode		= ut.inject(request.getParameter("rcv_zipcode"));
	String addr1		= ut.inject(request.getParameter("rcv_addr1"));
	String addr2		= ut.inject(request.getParameter("addr2"));
	String rcvRequest	= ut.inject(request.getParameter("rcv_request"));
	String stdateAddr	= ut.inject(request.getParameter("stdate_addr"));
	String ltdateAddr	= ut.inject(request.getParameter("ltdate_addr"));

	if ((!zipcode.equals("") && zipcode != null) || (!rcvRequest.equals("") && rcvRequest != null)) {
		if (!zipcode.equals("") && zipcode != null) {
			// 일배 위탁점 조회
			//query		= "SELECT PARTNERID FROM PHIBABY.V_ZIPCODE_OLD WHERE ZIPCODE = '"+ zipcode +"'";
			query		= "SELECT JISA_CD FROM CM_ZIP_NEW_M WHERE (ZIP= '"+ zipcode +"' OR POST = '"+ zipcode +"') AND JISA_CD IS NOT NULL AND ROWNUM = 1 ";
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
		}

		query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
		if ((!zipcode.equals("") && zipcode != null) && (!rcvRequest.equals("") && rcvRequest != null)) {
			query		+= "	AGENCYID		= '"+ rcvPartner +"'";
			query		+= "	,RCV_ZIPCODE	= '"+ zipcode +"'";
			query		+= "	,RCV_ADDR1		= '"+ addr1 +"'";
			query		+= "	,RCV_ADDR2		= '"+ addr2 +"'";
			query		+= "	,RCV_REQUEST	= '"+ rcvRequest +"'";
		} else if (!zipcode.equals("") && zipcode != null) {
			query		+= "	AGENCYID		= '"+ rcvPartner +"'";
			query		+= "	,RCV_ZIPCODE	= '"+ zipcode +"'";
			query		+= "	,RCV_ADDR1		= '"+ addr1 +"'";
			query		+= "	,RCV_ADDR2		= '"+ addr2 +"'";
		} else if (!rcvRequest.equals("") && rcvRequest != null) {
			query		+= "	RCV_REQUEST		= '"+ rcvRequest +"'";
		}
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ subNum;
		if (!stdateAddr.equals("") && stdateAddr != null) {
			query		+= " AND DEVL_DATE >= '"+ stdateAddr +"'";
		}
		if (!ltdateAddr.equals("") && ltdateAddr != null) {
			query		+= " AND DEVL_DATE <= '"+ ltdateAddr +"'";
		}
		try {
			stmt.executeUpdate(query);					
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}

%>
<%@ include file="order_phi_copy.jsp" %>
<%

		query		= "UPDATE ESL_ORDER SET ";
		query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n배송정보변경("+ stdateAddr +" ~ "+ ltdateAddr +") ', NOW())";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		code	= "success";
	} else {
		code		= "error";
		data		= "<error><![CDATA[배송지 또는 배송메모를 올바르게 입력하세요.]]></error>";
	}
} else if (mode.equals("editAgency")) {
	String agcyCode		= ut.inject(request.getParameter("agcycode"));
	String stdateAgcy	= ut.inject(request.getParameter("stdate_agcy"));
	String ltdateAgcy	= ut.inject(request.getParameter("ltdate_agcy"));

	if (!agcyCode.equals("") && agcyCode != null) {

		query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
		query		+= "	AGENCYID		= '"+ agcyCode +"'";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"' ";
		if (!stdateAgcy.equals("") && stdateAgcy != null) {
			query		+= " AND DEVL_DATE >= '"+ stdateAgcy +"'";
		}
		if (!ltdateAgcy.equals("") && ltdateAgcy != null) {
			query		+= " AND DEVL_DATE <= '"+ ltdateAgcy +"'";
		}
		try {
			stmt.executeUpdate(query);					
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}

%>
<%@ include file="order_phi_copy.jsp" %>
<%

		query		= "UPDATE ESL_ORDER SET ";
		query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n배송점정보변경("+ stdateAgcy +" ~ "+ ltdateAgcy +") ', NOW())";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		code	= "success";
	} else {
		code		= "error";
		data		= "<error><![CDATA[배송지 또는 배송메모를 올바르게 입력하세요.]]></error>";
	}
} else if (mode.equals("setRefund")) {
	String stdate		= ut.inject(request.getParameter("stdate"));
	String ltdate		= ut.inject(request.getParameter("ltdate"));
	String shopType		= "";
	float payPrice		= 0;
	float dcPrice		= 0;
	int totalCnt		= 0;
	int refundPrice		= 0;
	int bagCnt			= 0;
	int refdPriceTmp	= 0;

	query		= "SELECT SHOP_TYPE FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if (true) return;
	}

	if (rs.next()) {
		shopType	= rs.getString("SHOP_TYPE");
	}
	rs.close();

	if (Integer.parseInt(shopType) > 52) {
		query1		= "SELECT IF (OG.DEVL_TYPE = '0001', O.COUPON_PRICE / (OG.DEVL_DAY * OG.DEVL_WEEK * OG.ORDER_CNT), O.COUPON_PRICE / OG.ORDER_CNT) AS DC_PRICE";
		query1		+= " FROM ESL_ORDER O, ESL_ORDER_GOODS OG";
		query1		+= " WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.ORDER_NUM = '"+ orderNum +"'";					
	} else {
		query1		= "SELECT IF (DEVL_TYPE = '0001', (COUPON_PRICE) / (DEVL_DAY * DEVL_WEEK * ORDER_CNT), (COUPON_PRICE) / ORDER_CNT) AS DC_PRICE";
		query1		+= " FROM ESL_ORDER_GOODS";
		query1		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND ID = '"+ subNum +"'";
	}
	try {
		rs1	= stmt1.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if (true) return;
	}

	if (rs1.next()) {
		dcPrice		= rs1.getFloat("DC_PRICE");
	}
	rs1.close();
	
	query1		= "SELECT IFNULL(SUM(PAY_PRICE*ORDER_CNT),0) AS refdPriceTmp, SUM(ORDER_CNT) AS T_ORDER_CNT";
	query1		+= " FROM ESL_ORDER_DEVL_DATE";
	query1		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = '"+ subNum +"'";
	query1		+= " AND STATE = '01' AND GROUP_CODE not in ( '0300668', '0301340' )";
	query1		+= " AND DEVL_DATE BETWEEN '"+ stdate +"' AND '"+ ltdate +"'";
	try {
		rs1	= stmt1.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if (true) return;
	}

	if (rs1.next()) {
		totalCnt		= rs1.getInt("T_ORDER_CNT");
		refdPriceTmp = rs1.getInt("refdPriceTmp");
	}
	rs1.close();

	if (totalCnt > 0) {
		//refundPrice		= (int)Math.ceil(((double)payPrice * (double)totalCnt) / 10) * 10;
		
		refundPrice		= (int)refdPriceTmp - (int)Math.ceil((double)dcPrice * (double)totalCnt);

		code		= "success";
		data		= "<price>"+ refundPrice +"</price>";
	} else {
		code		= "error";
		data		= "<error><![CDATA[기간내에 환불 가능한 상품이 없습니다.]]></error>";
	}
} else if (mode.equals("updInfo")) {
	String rcvName		= ut.inject(request.getParameter("rcvName"));
	String rcvHp	= ut.inject(request.getParameter("rcvHp"));

	if (!rcvName.equals("") && rcvName != null && !rcvHp.equals("") && rcvHp != null) {
		code	= "success";
		
		query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
		query		+= "	RCV_NAME	= '"+ rcvName +"'";
		query		+= "	,RCV_HP		= '"+ rcvHp +"'";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"' ";

		
		try {
			stmt.executeUpdate(query);					
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}

%>
<%@ include file="order_phi_copy.jsp" %>
<%

		query		= "UPDATE ESL_ORDER SET ";
		query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n수령자정보변경() ', NOW())";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		
	} else {
		code		= "error";
		data		= "<error><![CDATA[수령자 또는 연락처를 올바르게 입력하세요.]]></error>";
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>
<%@ include file="../lib/dbclose_bm.jsp"%>
<%@ include file="../lib/dbclose_phi.jsp"%>