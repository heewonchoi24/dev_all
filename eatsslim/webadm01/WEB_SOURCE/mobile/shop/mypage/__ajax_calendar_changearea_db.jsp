<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/lib/config.jsp" %>
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
String rcvPartner	= "";
int price			= 0;
String devlDatePattern		= ut.inject(request.getParameter("devl_date_pattern"));
String startDatePattern		= ut.inject(request.getParameter("start_date_pattern"));
//String patternDays[]		= request.getParameterValues("pattern_days");
Date date			= null;

//PHI 시퀀스 조회
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
} else if (mode.equals("editAddress")) {
	String zipcode		= ut.inject(request.getParameter("rcv_zipcode"));
	String addr1		= ut.inject(request.getParameter("rcv_addr1"));
	String addr2		= ut.inject(request.getParameter("addr2"));
	String stdateAddr	= ut.inject(request.getParameter("stdate_addr"));
	String ltdateAddr	= ut.inject(request.getParameter("ltdate_addr"));

	String rcvType	= ut.inject(request.getParameter("rcv_type"));
	String rcvPass	= ut.inject(request.getParameter("rcv_pass"));
	String rcvRequest = "";
	if(!"".equals(rcvPass)) rcvRequest = "출입비밀번호(" + rcvPass + ")";
	//System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
	//System.out.println("rcvRequest" + rcvRequest);
	

	if ((!zipcode.equals("") && zipcode != null) || (!rcvRequest.equals("") && rcvRequest != null)) {
		if (!zipcode.equals("") && zipcode != null) {
			// 일배 위탁점 조회
			//query		= "SELECT PARTNERID FROM PHIBABY.V_ZIPCODE_OLD WHERE ZIPCODE = '"+ zipcode +"'";
			query		= "SELECT JISA_CD FROM CM_ZIP_NEW_M WHERE ZIP= '"+ zipcode +"' OR POST = '"+ zipcode +"' AND ROWNUM = 1 ";
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
		if (stdateAddr != null && !stdateAddr.equals("")) {
			query		+= " AND DEVL_DATE >= '"+ stdateAddr +"'";
		}
		if (ltdateAddr != null && !ltdateAddr.equals("")) {
			query		+= " AND DEVL_DATE <= '"+ ltdateAddr +"'";
		}
		//System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
		//System.out.println(query);
		try {
			stmt.executeUpdate(query);					
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
		
		/*
		query		= "UPDATE ESL_ORDER SET ";
		query		+= "	RCV_TYPE		= '"+ rcvType +"'";
		if("".equals(rcvPass)){
			query		+= "	,RCV_PASS_YN	= 'N'";
			query		+= "	,RCV_PASS		= ''";
		}
		else{
			query		+= "	,RCV_PASS_YN	= 'Y'";
			query		+= "	,RCV_PASS		= '"+ rcvPass +"'";
		}
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt.executeUpdate(query);					
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
		*/
		

%>
<%@ include file="/esl_admin/order/order_phi_copy.jsp" %>
<%

		query		= "UPDATE ESL_ORDER SET ";
		query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n고객배송정보변경("+ stdateAddr +" ~ "+ ltdateAddr +") ', NOW())";
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
<%@ include file="/lib/dbclose.jsp"%>
<%@ include file="/lib/dbclose_bm.jsp"%>
<%@ include file="/lib/dbclose_phi.jsp"%>