<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../lib/config.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp"%>

<%
request.setCharacterEncoding("utf-8");

int i				= 0;
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String addParam		= "";
String mode			= ut.inject(request.getParameter("mode"));
String orderNum		= ut.inject(request.getParameter("order_num"));
if(orderNum.equals("")){ out.println("주문번호 누락");if(true)return;}
String[] devlIds	= request.getParameterValues("devl_ids");
String groupCode	= ut.inject(request.getParameter("group_code"));
String subNum		= ut.inject(request.getParameter("sub_num"));
int orderCnt		= 0;
if (request.getParameter("order_cnt") != null && request.getParameter("order_cnt").length()>0)
	orderCnt			= Integer.parseInt(request.getParameter("order_cnt"));
String stdate		= ut.inject(request.getParameter("stdate_cancel"));
String ltdate		= ut.inject(request.getParameter("ltdate_cancel"));
int refundFee		= 0;
if (request.getParameter("refund_fee") != null && request.getParameter("refund_fee").length()>0)
	refundFee			= Integer.parseInt(request.getParameter("refund_fee"));
int refundPrice		= 0;
if (request.getParameter("refund_price") != null && request.getParameter("refund_price").length()>0)
	refundPrice			= Integer.parseInt(request.getParameter("refund_price"));
String devlDate		= ut.inject(request.getParameter("devl_date"));
String orgDevlDate		= ut.inject(request.getParameter("org_devl_date"));
int orgOrderCnt		= 0;
if (request.getParameter("org_order_cnt") != null && request.getParameter("org_order_cnt").length()>0)
	orgOrderCnt			= Integer.parseInt(request.getParameter("org_order_cnt"));
int devlId			= 0;
if (request.getParameter("devl_id") != null && request.getParameter("devl_id").length()>0)
	devlId				= Integer.parseInt(request.getParameter("devl_id"));
String bankName		= ut.inject(request.getParameter("bank_name")); //환불계좌은행 명
String bankUser		= ut.inject(request.getParameter("bank_user")); //환불 계좌 예금주
String bankAccount	= ut.inject(request.getParameter("bank_account")); //환불계좌번호
String payType		= ut.inject(request.getParameter("pay_type"));
String pgTid		= ut.inject(request.getParameter("pg_tid")); //PG사 거래번호
String LGD_RFPHONE	= ut.inject(request.getParameter("LGD_RFPHONE")); //환불요청자 연락처

String msg			= "";
String addAct		= "";
String chgstate		= "";
String chgstate2	= "";
String TitleText	= "";
String tmpName		= "";
String returnURL	= "";
int chkCnt			= 0;
String code			= "";
String data			= "";

String devlDay		= "";
int week			= 0;
int ordSeq			= 0;

String rcvPartner	= "";

Calendar cal2 = Calendar.getInstance();
cal2.setTime(new Date()); //오늘
String cDate2=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(cal2.getTime());


	
if (mode.equals("editDevl")) {
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
} else if (mode.equals("editAddress")) {
	String zipcode		= ut.inject(request.getParameter("rcv_zipcode"));
	String addr1		= ut.inject(request.getParameter("rcv_addr1"));
	String addr2		= ut.inject(request.getParameter("addr2"));
	String rcvRequest	= ut.inject(request.getParameter("rcv_request"));
	String stdateAddr	= ut.inject(request.getParameter("stdate_addr"));
	String ltdateAddr	= ut.inject(request.getParameter("ltdate_addr"));

	if ((!zipcode.equals("") && zipcode != null) || (!rcvRequest.equals("") && rcvRequest != null)) {
		query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
		if ((!zipcode.equals("") && zipcode != null) && (!rcvRequest.equals("") && rcvRequest != null)) {
			query		+= "	RCV_ZIPCODE	= '"+ zipcode +"'";
			query		+= "	,RCV_ADDR1		= '"+ addr1 +"'";
			query		+= "	,RCV_ADDR2		= '"+ addr2 +"'";
			query		+= "	,RCV_REQUEST	= '"+ rcvRequest +"'";
		} else if (!zipcode.equals("") && zipcode != null) {
			query		+= "	RCV_ZIPCODE	= '"+ zipcode +"'";
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
}


out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");

%>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="../lib/dbclose_phi.jsp" %>