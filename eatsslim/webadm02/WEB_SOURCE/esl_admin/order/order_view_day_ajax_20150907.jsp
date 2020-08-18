<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../lib/config.jsp" %>
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
String instDate		= dt.format(new Date());
Calendar cal		= Calendar.getInstance();
String mode			= ut.inject(request.getParameter("mode"));
String instId		= (String)session.getAttribute("esl_admin_id");
String userIp		= request.getRemoteAddr();
String orderNum		= ut.inject(request.getParameter("order_num"));
String subNum		= ut.inject(request.getParameter("sub_num"));
String gubunCode	= ut.inject(request.getParameter("gubun_code"));
String groupCode	= ut.inject(request.getParameter("group_code"));
String[] devlIds	= request.getParameterValues("devl_ids");
int devlId			= 0;
if (request.getParameter("devl_id") != null && request.getParameter("devl_id").length()>0)
	devlId				= Integer.parseInt(request.getParameter("devl_id"));
String orgDevlDate		= ut.inject(request.getParameter("org_devl_date"));
int orgOrderCnt		= 0;
if (request.getParameter("org_order_cnt") != null && request.getParameter("org_order_cnt").length()>0)
	orgOrderCnt			= Integer.parseInt(request.getParameter("org_order_cnt"));
String devlDate		= ut.inject(request.getParameter("devl_date"));
int orderCnt		= 0;
if (request.getParameter("order_cnt") != null && request.getParameter("order_cnt").length()>0)
	orderCnt			= Integer.parseInt(request.getParameter("order_cnt"));
int chkCnt			= 0;
String devlDay		= "";
int week			= 0;
String rcvPartner	= "";
int price			= 0;

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
/*
		if (gubunCode.substring(0, 2).equals("02")) {
			query		= "SELECT ID FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE != '0300668'";
			query		+= " ORDER BY DEVL_DATE";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

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
			}
		}
*/
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
		devlId		= Integer.parseInt(devlIds[i]);
		devlDate	= ut.inject(request.getParameter("devl_date_"+ devlId));
		orderCnt	= Integer.parseInt(request.getParameter("order_cnt_"+ devlId));

		if (orderCnt > 0) {
			query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
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
/*
	if (gubunCode.substring(0, 2).equals("02")) {
		query		= "SELECT ID FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
		query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE != '0300668'";
		query		+= " ORDER BY DEVL_DATE";
		try {
			rs		= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

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
		}
	}
*/
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
		query		+= " AND GUBUN_CODE != '0300668'";
		query		+= " ORDER BY ID DESC LIMIT 1";
		try {
			rs			= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>1"+query);
			if(true)return;
		}

		if (rs.next()) {
			groupCode		= rs.getString("GROUP_CODE");

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
			query1		+= "	RCV_REQUEST			= '"+ rs.getString("RCV_REQUEST") +"',";
			query1		+= "	GROUP_CODE			= '"+ groupCode +"',";
			query1		+= "	DEVL_DATE			= '"+ stdate +"',";
			query1		+= "	ORDER_CNT			= '"+ orderCnt +"',";
			query1		+= "	PRICE				= 0,";
			query1		+= "	PAY_PRICE			= 0,";
			query1		+= "	STATE				= '02',";
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
			query		+= " AND GUBUN_CODE != '0300668'";
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
} else if (mode.equals("phiCopy")) {
%>
<%@ include file="order_phi_copy.jsp" %>
<%
	code		= "success";
} else if (mode.equals("editAddress")) {
	String zipcode		= ut.inject(request.getParameter("zipcode"));
	String addr1		= ut.inject(request.getParameter("addr1"));
	String addr2		= ut.inject(request.getParameter("addr2"));
	String rcvRequest	= ut.inject(request.getParameter("rcv_request"));
	String stdateAddr	= ut.inject(request.getParameter("stdate_addr"));
	String ltdateAddr	= ut.inject(request.getParameter("ltdate_addr"));

	if ((!zipcode.equals("") && zipcode != null) || (!rcvRequest.equals("") && rcvRequest != null)) {
		if (!zipcode.equals("") && zipcode != null) {
			// 일배 위탁점 조회
			query		= "SELECT PARTNERID FROM PHIBABY.V_ZIPCODE_OLD WHERE ZIPCODE = '"+ zipcode +"'";
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
} else if (mode.equals("setRefund")) {
	String stdate		= ut.inject(request.getParameter("stdate"));
	String ltdate		= ut.inject(request.getParameter("ltdate"));
	String shopType		= "";
	float payPrice		= 0;
	int totalCnt		= 0;
	int refundPrice		= 0;
	int bagCnt			= 0;

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
		query1		= "SELECT IF (OG.DEVL_TYPE = '0001', ((OG.PRICE * OG.ORDER_CNT) - O.COUPON_PRICE) / (OG.DEVL_DAY * OG.DEVL_WEEK * OG.ORDER_CNT), ((OG.PRICE * OG.ORDER_CNT) - O.COUPON_PRICE) / OG.ORDER_CNT) AS PAY_PRICE";
		query1		+= " FROM ESL_ORDER O, ESL_ORDER_GOODS OG";
		query1		+= " WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.ORDER_NUM = '"+ orderNum +"'";					
	} else {
		query1		= "SELECT IF (DEVL_TYPE = '0001', ((PRICE * ORDER_CNT) - COUPON_PRICE) / (DEVL_DAY * DEVL_WEEK * ORDER_CNT), ((PRICE * ORDER_CNT) - COUPON_PRICE) / ORDER_CNT) AS PAY_PRICE";
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
		payPrice		= rs1.getFloat("PAY_PRICE");
	}
	rs1.close();
	
	query1		= "SELECT SUM(ORDER_CNT) AS T_ORDER_CNT";
	query1		+= " FROM ESL_ORDER_DEVL_DATE";
	query1		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = '"+ subNum +"'";
	query1		+= " AND STATE = '01' AND GROUP_CODE != '0300668'";
	query1		+= " AND DEVL_DATE BETWEEN '"+ stdate +"' AND '"+ ltdate +"'";
	try {
		rs1	= stmt1.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if (true) return;
	}

	if (rs1.next()) {
		totalCnt		= rs1.getInt("T_ORDER_CNT");
	}
	rs1.close();

	if (totalCnt > 0) {
		refundPrice		= (int)Math.ceil(((double)payPrice * (double)totalCnt) / 10) * 10;

		code		= "success";
		data		= "<price>"+ refundPrice +"</price>";
	} else {
		code		= "error";
		data		= "<error><![CDATA[기간내에 환불 가능한 상품이 없습니다.]]></error>";
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>
<%@ include file="../lib/dbclose_phi.jsp"%>