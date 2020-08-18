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


String gubun1	= "";
String orgStartDate		= ut.inject(request.getParameter("org_start_date"));
String orgEndDate		= ut.inject(request.getParameter("org_end_date"));
String tarStartDate		= ut.inject(request.getParameter("tar_start_date"));
String tarEndDate		= ut.inject(request.getParameter("tar_end_date"));
String patternDays[]		= request.getParameterValues("pattern_days");


String strPutStartDate = "";
String strPutEndDate = "";


Date date			= null;
int rowCount		= 0;

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


if (eslMemberId == null || eslMemberId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[로그인을 해주세요.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
}  else if (mode.equals("updPtAll")) {
	int intTotalCnt = 0;
	int intCurCnt = 0;
	
	//===========================================================================================
	//-- START : 프로그램 상품일 경우 배송상품코드,가격 순서를 저장하고 설정후 재 배정한다.
	query		= "SELECT GUBUN1 FROM ESL_GOODS_GROUP WHERE GROUP_CODE='" + gubunCode + "'";
	try {
		rs		= stmt.executeQuery(query);
		if(rs.next()){
			gubun1 = ut.isnull(rs.getString("GUBUN1") );
		}
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	rs.close();

	List<String[]> groupCodeList = new ArrayList<String[]>();
	if("02".equals(gubun1) ){
		query		= "SELECT GROUP_CODE, PRICE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
		query		+= " AND GOODS_ID = "+ subNum +"";
		query		+= " ORDER BY ORDER_DATE ASC";
		try {
			rs		= stmt.executeQuery(query);
			while(rs.next()){
				groupCodeList.add(new String[]{rs.getString("GROUP_CODE"),  Integer.toString(rs.getInt("PRICE"))});
			}
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		rs.close();
		
	}
	//-- END : 프로그램 상품일 경우 배송상품코드,가격 순서를 저장하고 설정후 재 배정한다.
	//===========================================================================================
	
	
	/* 사용안함
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
	rs.close();
	
	List<String[]> price_goods = new ArrayList<String[]>();
	while (rs.next()) {
		price_goods.add(new String[]{rs.getString("GROUP_CODE"),  Integer.toString(rs.getInt("PRICE"))});
	}
	rs.close();
	*/
	
	query		= "SELECT ID, STATE, GROUP_CODE, ORDER_CNT FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
	query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE not in ( '0300668', '0301340' )";
	query		+= " AND DEVL_DATE BETWEEN '" + orgStartDate + "' AND '" + orgEndDate + "'";
	query		+= " ORDER BY DEVL_DATE ";
	System.out.println(query);
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	
	//-- 있을경우에만 적용
	
	
	date			= dt2.parse(tarStartDate);
	cal.setTime(date);
	

	int j = 0;
	int m = 0;
	String devlDatePhi = "";

	boolean bDays;	
	while (rs.next()) {
		rowCount++;
		bDays = false;
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
			groupCode	= rs.getString("GROUP_CODE");
			
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
			
			//query1		+= "	ORDER_CNT		= '"+ orderCnt +"', ";
			strPutEndDate = dt2.format(cal.getTime());
			if("".equals(strPutStartDate)) strPutStartDate = strPutEndDate;
			query1		+= "	DEVL_DATE		= '"+ dt.format(cal.getTime()) +"' ";
			query1		+= " WHERE ID = "+ devlId;
			
			try {
				stmt1.executeUpdate(query1);
				

			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

		}
		
		cal.add(Calendar.DATE, 1);
	}
	rs.close();
	
	//===========================================================================================
	//-- START : 프로그램 상품일 경우 배송상품코드,가격 순서를 저장하고 설정후 재 배정한다.
	if("02".equals(gubun1) ){
		query		= "SELECT ID FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
		query		+= " AND GOODS_ID = "+ subNum +"";
		query		+= " ORDER BY ORDER_DATE ASC";
		try {
			rs		= stmt.executeQuery(query);
			int codeCt = 0;
			while(rs.next()){
				try{
					query = "UPDATE ESL_ORDER_DEVL_DATE SET GROUP_CODE='" + groupCodeList.get(codeCt)[0] + "', PRICE='"+ groupCodeList.get(codeCt)[1] +"', PAY_PRICE='"+ groupCodeList.get(codeCt)[1] +"'  WHERE ID='" + rs.getInt("ID") + "'";
					stmt1.executeUpdate(query);					
				}
				catch(Exception ee){					
				}
				codeCt++;
			}
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		rs.close();
		
	}
	//-- END : 프로그램 상품일 경우 배송상품코드,가격 순서를 저장하고 설정후 재 배정한다.
	//===========================================================================================


	if(rowCount > 0){
%>
<%@ include file="/esl_admin/order/order_phi_copy.jsp" %>
<%

		query		= "UPDATE ESL_ORDER SET ";
		query		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n배송일정변경 ', NOW())";
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
out.println("<sdate>"+ strPutStartDate +"</sdate>");
out.println("<edate>"+ strPutEndDate +"</edate>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose.jsp"%>
<%@ include file="/lib/dbclose_phi.jsp"%>