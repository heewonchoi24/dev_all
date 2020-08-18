<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("utf-8");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String orderNum		= ut.inject(request.getParameter("order_num"));
String subNum		= ut.inject(request.getParameter("subnum"));
String groupCode	= ut.inject(request.getParameter("group_code"));
String devlDate1	= ut.inject(request.getParameter("devl_date1"));
String devlDate2	= ut.inject(request.getParameter("devl_date2"));
int chkMyDate		= 0;
int chkHoliday		= 0;
String devlDay		= "";
int week			= 0;
String minDevlDate	= "";
int i				= 0;
int ordSeq			= 0;

if (mode.equals("editDevl")) {
	query		= "SELECT COUNT(ID) FROM ESL_ORDER_DEVL_DATE";
	query		+= " WHERE ORDER_NUM ='"+ orderNum +"'";
	query		+= " AND GOODS_ID = "+ subNum;
	query		+= " AND GROUP_CODE not in ( '0300668', '0301340' )";
	query		+= " AND DEVL_DATE = '"+ devlDate1 +"'";
	try {
		rs			= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		chkMyDate		= rs.getInt(1);
	}

	rs.close();

	query		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDate2 +"' AND HOLIDAY_TYPE = '02'";
	try {
		rs			= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		chkHoliday		= rs.getInt(1);
	}

	query		= "SELECT DEVL_DAY, DAYOFWEEK('"+ devlDate2 +"') WEEK FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'";
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

	rs.close();

	if (devlDate1.equals("") || devlDate1 == null) {
		code		= "error";
		data		= "<error><![CDATA[변경 가능한 배송일을 선택해주세요.]]></error>";
	} else if (devlDate2.equals("") || devlDate2 == null) {
		code		= "error";
		data		= "<error><![CDATA[변경될 배송일을 선택해주세요.]]></error>";
	} else if (chkMyDate < 1) {
		code		= "error";
		data		= "<error><![CDATA[변경 가능한 배송일이 아닙니다.]]></error>";
	} else if (chkHoliday > 0) {
		code		= "error";
		data		= "<error><![CDATA[관리자 휴무일에는 배송이 불가능합니다.]]></error>";
	} else if (week == 1 || week == 7) {
		code		= "error";
		data		= "<error><![CDATA[토,일 배송이 불가능한 상품입니다.]]></error>";
	} else if (devlDay.equals("5") && (week == 1 || week == 7)) {
		code		= "error";
		data		= "<error><![CDATA[토,일 배송이 불가능한 상품입니다.]]></error>";
	} else if ((devlDay.equals("6") || devlDay.equals("7")) && (week == 1)) {
		code		= "error";
		data		= "<error><![CDATA[일 배송이 불가능한 상품입니다.]]></error>";
	} else {
		query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
		query		+= "		DEVL_DATE = '"+ devlDate2 +"'";
		query		+= " WHERE ORDER_NUM ='"+ orderNum +"'";
		query		+= " AND GOODS_ID = "+ subNum;
		query		+= " AND GROUP_CODE not in ( '0300668', '0301340' )";
		query		+= " AND DEVL_DATE = '"+ devlDate1 +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		
		if (groupCode.substring(2, 4).equals("27") || groupCode.substring(2, 4).equals("28") || groupCode.substring(2, 4).equals("29")) {
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
			
			query		= "SELECT ID, STATE, GROUP_CODE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE not in ( '0300668', '0301340' ) ";
			query		+= " AND PRICE > 0 ";
			query		+= " ORDER BY DEVL_DATE ";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}			
			
			int j = 0;
			int schCnt	= 1;
			int schWeek	= 1;
			int schIdx	= 2;
			int price			= 0;
			int devlId			= 0;
			String group_Code	= "";
			while (rs.next()) {
				devlId		= rs.getInt("ID");

				query1		= "SELECT GROUP_CODE, PRICE FROM ESL_PG_DELIVERY_SCHEDULE";
				query1		+= " WHERE GUBUN2 = '"+ groupCode.substring(2, 4) +"'";
				query1		+= " AND GUBUN3 = '"+ schWeek +"'";
				if (groupCode.substring(2, 4).equals("27") || groupCode.substring(2, 4).equals("28") || groupCode.substring(2, 4).equals("29")) {
					query1		+= " AND DAY_OF_WEEK = '"+ schIdx +"'";
				}
				
				try {
					rs1 = stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}

				if (rs1.next()) {
					group_Code		= rs1.getString("GROUP_CODE");
					price			= rs1.getInt("PRICE");
				}
				rs1.close();
				
				if (rs.getString("STATE").equals("02"))  {
					price = 0;
				} else {
					for (j=0;j<price_goods.size();j++) {
						if (price_goods.get(j)[0].equals(group_Code)) {
							price = Integer.parseInt(price_goods.get(j)[1]);
						}
					}
				}
				
				query1		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
				query1		+= "				GROUP_CODE	= '"+ group_Code +"'";
				query1		+= "				, PRICE		= '"+ price +"'";
				query1		+= "				, PAY_PRICE	= '"+ price +"'";
				query1		+= " WHERE ID = "+ devlId;
				try {
					stmt1.executeUpdate(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}

				if (schCnt % 5 == 0) {
					schWeek++;
					schIdx = 2;
				} else {
					schIdx++;					
				}
				schCnt++;

				
				if (groupCode.substring(2, 4).equals("25")) {
					if (schWeek % 3 == 0) schWeek = 1;
				} else {
					if (schWeek % 5 == 0) schWeek = 1;
				}					
				
			}
			rs.close();
		}

		query		= "UPDATE ESL_ORDER SET ";
		query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n사용자 배송일 변경 ("+ devlDate1 +" => "+ devlDate2 +") ', NOW())";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
%>
<%@ include file="/esl_admin/order/order_phi_copy.jsp" %>
<%
		code		= "success";
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose.jsp"%>
<%@ include file="/lib/dbclose_phi.jsp"%>