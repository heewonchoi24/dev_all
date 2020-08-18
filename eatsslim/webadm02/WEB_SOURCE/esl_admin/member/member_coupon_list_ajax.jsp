<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_ORDER_DEVL_DATE";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String query2		= "";
Statement stmt2		= null;
ResultSet rs2		= null;
stmt2				= conn.createStatement();
boolean error		= false;
String code			= "";
String data			= "";
String instId		= (String)session.getAttribute("esl_admin_id");
String userIp		= request.getRemoteAddr();
String mode			= ut.inject(request.getParameter("mode"));
int couponId		= 0;
if (request.getParameter("cid") != null && request.getParameter("cid").length()>0)
	couponId		= Integer.parseInt(request.getParameter("cid"));
int cmemberId		= 0;
if (request.getParameter("cmid") != null && request.getParameter("cmid").length()>0)
	cmemberId		= Integer.parseInt(request.getParameter("cmid"));
String stdate		= ut.inject(request.getParameter("stdate"));
String ltdate		= ut.inject(request.getParameter("ltdate"));
String memberId		= ut.inject(request.getParameter("mid"));
int maxCouponNum	= 0;
String preNum		= "";
String couponNum	= "";
int seq				= 0;
int lastCouponId	= 0;
int chkId			= 0;

if (instId == null || instId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[로그인을 해주세요.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (mode.equals("upd")) {
	if (couponId < 1 || cmemberId < 1 || memberId.equals("") || memberId == null || stdate.equals("") || stdate == null || ltdate.equals("") || ltdate == null) {
		code		= "error";
		data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
	} else {
		query		= "SELECT COUPON_NAME, COUPON_TYPE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
		query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, RAND_NUM_TYPE";
		query		+= " FROM ESL_COUPON WHERE ID = "+ couponId;
		try {
			rs		= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs.next()) {
			query1		= "SELECT ID FROM ESL_COUPON ";
			query1		+= " WHERE COUPON_NAME		= '"+ ut.inject(rs.getString("COUPON_NAME")) +"'";
			query1		+= " AND COUPON_TYPE		= '"+ ut.inject(rs.getString("COUPON_TYPE")) +"'";
			query1		+= " AND SALE_TYPE			= '"+ ut.inject(rs.getString("SALE_TYPE")) +"'";
			query1		+= " AND SALE_PRICE			= '"+ rs.getInt("SALE_PRICE") +"'";
			query1		+= " AND SALE_USE_YN		= '"+ ut.inject(rs.getString("SALE_USE_YN")) +"'";
			query1		+= " AND USE_LIMIT_CNT		= '"+ rs.getInt("USE_LIMIT_CNT") +"'";
			query1		+= " AND USE_LIMIT_PRICE	= '"+ rs.getInt("USE_LIMIT_PRICE") +"'";
			query1		+= " AND USE_GOODS			= '"+ ut.inject(rs.getString("USE_GOODS")) +"'";
			query1		+= " AND MAX_COUPON_CNT		= '"+ rs.getInt("MAX_COUPON_CNT") +"'";
			query1		+= " AND RAND_NUM_TYPE		= '"+ ut.inject(rs.getString("RAND_NUM_TYPE")) +"'";
			query1		+= " AND STDATE				= '"+ stdate +"'";
			query1		+= " AND LTDATE				= '"+ ltdate +"'";
			try {
				rs1		= stmt1.executeQuery(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

			if (rs1.next()) {
				chkId		= rs1.getInt(1);
			}
			rs1.close();

			if (chkId > 0) {
				SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
				couponNum		= "ET" + dt.format(new Date()) + "001";

				query1		= "INSERT INTO ESL_COUPON_MEMBER ";
				query1		+= "	(COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, USE_ORDER_NUM, INST_DATE)";
				query1		+= " VALUES ";
				query1		+= "	("+ chkId +", '"+ couponNum +"', '"+ memberId +"', 'N', '', NOW())";
				try {
					stmt1.executeUpdate(query1);
					code		= "success";
				} catch(Exception e) {
					//out.println(e+"=>"+query1);
					code		= "error";
					data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
				}
			} else {
				query1		= "INSERT INTO ESL_COUPON ";
				query1		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
				query1		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, RAND_NUM_TYPE, INST_ID, INST_IP, INST_DATE)";
				query1		+= " VALUES";
				query1		+= "	(?, ?, ?, ?, '04', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
				pstmt		= conn.prepareStatement(query1, Statement.RETURN_GENERATED_KEYS);
				pstmt.setString(1, ut.inject(rs.getString("COUPON_NAME")));
				pstmt.setString(2, ut.inject(rs.getString("COUPON_TYPE")));
				pstmt.setString(3, stdate);
				pstmt.setString(4, ltdate);
				pstmt.setString(5, ut.inject(rs.getString("SALE_TYPE")));
				pstmt.setInt(6, rs.getInt("SALE_PRICE"));
				pstmt.setString(7, ut.inject(rs.getString("SALE_USE_YN")));
				pstmt.setInt(8, rs.getInt("USE_LIMIT_CNT"));
				pstmt.setInt(9, rs.getInt("USE_LIMIT_PRICE"));
				pstmt.setString(10, ut.inject(rs.getString("USE_GOODS")));
				pstmt.setInt(11, rs.getInt("MAX_COUPON_CNT"));
				pstmt.setString(12, ut.inject(rs.getString("RAND_NUM_TYPE")));
				pstmt.setString(13, instId);
				pstmt.setString(14, userIp);
				pstmt.executeUpdate();

				rs1			= pstmt.getGeneratedKeys();
				if (rs1.next()) {
					lastCouponId	= rs1.getInt(1);
				}
				rs1.close();

				if (!rs.getString("USE_GOODS").equals("01")) {
					query2		= "SELECT GROUP_CODE, GROUP_NAME FROM ESL_COUPON_GOODS WHERE COUPON_ID = "+ couponId;
					try {
						rs2			= stmt2.executeQuery(query2);
					} catch(Exception e) {
						//out.println(e+"=>"+query2);
						code		= "error";
						data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
					}

					while (rs2.next()) {
						query1		= "INSERT INTO ESL_COUPON_GOODS (COUPON_ID, GROUP_CODE, GROUP_NAME) VALUES";
						query1		+= "	("+ lastCouponId +", '"+ rs2.getString("GROUP_CODE") +"', '"+ rs2.getString("GROUP_NAME") +"')";
						try {
							stmt1.executeUpdate(query1);
						} catch(Exception e) {
							//out.println(e+"=>"+query1);
							code		= "error";
							data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
						}
					}
				}

				SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
				couponNum		= "ET" + dt.format(new Date()) + "001";

				query1		= "INSERT INTO ESL_COUPON_MEMBER ";
				query1		+= "	(COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, USE_ORDER_NUM, INST_DATE)";
				query1		+= " VALUES ";
				query1		+= "	("+ lastCouponId +", '"+ couponNum +"', '"+ memberId +"', 'N', '', NOW())";
				try {
					stmt1.executeUpdate(query1);
					code		= "success";
				} catch(Exception e) {
					//out.println(e+"=>"+query1);
					code		= "error";
					data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
				}
			}
		}		
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>