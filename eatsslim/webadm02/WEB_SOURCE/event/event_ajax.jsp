<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_COUPON";
String query		= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String eventId		= ut.inject(request.getParameter("eventId"));
String couponNum	= "";
int couponCnt		= 0;
int repleCnt		= 0;
int couponId		= 0;
String useYn		= "";
String m_id = eslMemberId;

if (eslMemberId == null || eslMemberId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[해당 쿠폰은 로그인 진행 후 발급 가능합니다.]]></error>";
}else if (mode.equals("setCoupon")) {
	//query		= "SELECT COUNT(*) COUPON_CNT FROM "+ table +" WHERE ID = '"+ couponNum +"'";
	query		= "SELECT COUNT(CM.ID) COUPON_CNT FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
	if (eventId.equals("278")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3329)";
	} else if (eventId.equals("282")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3353, 3354, 3355)";
	} else if (eventId.equals("289")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3398)";
	} else if (eventId.equals("330")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3727, 3728)";
	} else if (eventId.equals("338")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3786)";
	} else if (eventId.equals("348")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3802)";
	} else if (eventId.equals("351")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3808)";
	} else if (eventId.equals("355")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3835)";
	} else if (eventId.equals("358")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3844)";
	} else if (eventId.equals("359")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3854)";
	} else if (eventId.equals("367")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3885)";
	} else if (eventId.equals("373")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3913)";
	} else if (eventId.equals("379")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3967)";
	} else if (eventId.equals("381")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (3977)";
	} else if (eventId.equals("403")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (4132)";
	} else if (eventId.equals("407")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (4178)";
	} else if (eventId.equals("408")) {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (4179)";
	} else {
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (1000)";
	}
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		//out.println(e+"=>"+query);
		//if(true)return;
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	}

	if (rs.next()) {
		couponCnt		= rs.getInt("COUPON_CNT");
	}

	rs.close();

	if (couponCnt > 0) {
		code		= "error";
		data		= "<error><![CDATA[이미 참여하셨습니다.]]></error>";
	} else {
		
		SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
		couponNum		= "ET" + dt.format(new Date());

		try {
			
			if (eventId.equals("278")) {

				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3329,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("289")) {

				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3398,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("330")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3727,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3728,'"+ couponNum + "002" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("338")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3786,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("348")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3802,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("351")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3808,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("355")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3835,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("358")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3844,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("359")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3854,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("367")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3885,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("373")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3913,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("379")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3967,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("381")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3977,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("403")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (4132,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("407")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (4178,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else if (eventId.equals("408")) {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (4179,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
			} else {
				
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3353,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3354,'"+ couponNum + "002" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
			
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3355,'"+ couponNum + "003" +"','"+ m_id +"','N',NOW())";
				stmt.executeUpdate(query);
				
			}
			code		= "success";
			
		} catch (Exception e) {
			//out.println(e);
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
			//if(true)return;
		}
		
	}
}else if(mode.equals("setCouponNew")){
	String dw_yn = ut.inject(request.getParameter("dw_yn"));
	String coupon_num_p1 = ut.inject(request.getParameter("coupon_num_p1"));

	
	if(dw_yn.equals("DW")){// 무조건 쿠폰 다운 가능 경우
	
		System.out.println("coupon_num_p1: " + coupon_num_p1);

		if(!coupon_num_p1.equals("")){
			query		= "SELECT COUNT(CM.ID) COUPON_CNT FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
			query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in ('" + coupon_num_p1 + "')";
			try {
				rs	= stmt.executeQuery(query);
			} catch(Exception e) {
				//out.println(e+"=>"+query);
				//if(true)return;
				code		= "error";
				data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
			}

			if (rs.next()) {
				couponCnt		= rs.getInt("COUPON_CNT");
			}
			rs.close();
		}
		
		if (couponCnt > 0) {
			code		= "error";
			data		= "<error><![CDATA[이미 참여하셨습니다.]]></error>";
		} else {

				SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
				couponNum		= "ET" + dt.format(new Date());

				if(!coupon_num_p1.equals("")){
					try {
						query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
						query		+= " VALUES ('" + coupon_num_p1 + "', '"+ couponNum + "001" +"', '" + m_id + "', 'N', NOW())";
						stmt.executeUpdate(query);

					} catch (Exception e) {
						//out.println(e);
						code		= "error";
						data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
						//if(true)return;
					}
				}
				code		= "success";
		}
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>