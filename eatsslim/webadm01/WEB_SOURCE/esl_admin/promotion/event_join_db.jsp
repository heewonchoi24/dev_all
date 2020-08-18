<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_EVENT_REPLY";
String table1			= "ESL_COUPON";
String query			= "";
String query1			= "";
Statement stmt1			= null;
stmt1					= conn.createStatement();
String mode				= ut.inject(request.getParameter("mode"));
int eventId				= 0;
int couponId			= 0;
String memberIds[]		= request.getParameterValues("member_id");
String memberId			= "";
String couponName		= ut.inject(request.getParameter("coupon_name"));
String couponType		= ut.inject(request.getParameter("coupon_type"));
String stdate			= ut.inject(request.getParameter("stdate"));
String ltdate			= ut.inject(request.getParameter("ltdate"));
String vendor			= ut.inject(request.getParameter("vendor"));
String saleType			= ut.inject(request.getParameter("sale_type"));
int salePrice1			= 0;
int salePrice2			= 0;
int salePrice			= 0;
String saleUseYn		= ut.inject(request.getParameter("sale_use_yn"));
int useLimitCnt			= 0;
int useLimitPrice		= 0;
String useGoods			= ut.inject(request.getParameter("use_goods"));
String[] groupArr;
String groupCodes[]		= request.getParameterValues("group_code");
String groupCode		= "";
String groupNames[]		= request.getParameterValues("group_name");
String groupName		= "";
int maxCoponCnt			= 0;
String imsinum			= "";
int chkCnt				= 0;
SimpleDateFormat dt		= new SimpleDateFormat("yyMMddHHmmss");
String num				= "";
String couponNum		= "";
String tmpNum			= "";
String param			= ut.inject(request.getParameter("param"));
int delId				= 0;
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();
if (request.getParameter("sale_price1") != null && request.getParameter("sale_price1").length()>0)
	salePrice1		= Integer.parseInt(request.getParameter("sale_price1"));
if (request.getParameter("sale_price2") != null && request.getParameter("sale_price2").length()>0)
	salePrice2		= Integer.parseInt(request.getParameter("sale_price2"));
salePrice		= (saleType.equals("P"))? salePrice1 : salePrice2;
if (request.getParameter("use_limit_cnt") != null && request.getParameter("use_limit_cnt").length()>0)
	useLimitCnt		= Integer.parseInt(request.getParameter("use_limit_cnt"));
if (request.getParameter("use_limit_price") != null && request.getParameter("use_limit_price").length()>0)
	useLimitPrice	= Integer.parseInt(request.getParameter("use_limit_price"));
if (request.getParameter("max_coupon_cnt") != null && request.getParameter("max_coupon_cnt").length()>0)
	maxCoponCnt		= Integer.parseInt(request.getParameter("max_coupon_cnt"));
if (request.getParameter("id") != null && request.getParameter("id").length()>0)
	eventId			= Integer.parseInt(request.getParameter("id"));
String keyword		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String field		= ut.inject(request.getParameter("field"));

if (request.getParameter("keyword") != null) {
	keyword		= ut.inject(request.getParameter("keyword"));
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param		= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (mode != null) {	
	if (mode.equals("ins")) {
		query		= "INSERT INTO "+ table1;
		query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
		query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE)";
		query		+= " VALUES";
		query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
		pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		pstmt.setString(1, couponName);
		pstmt.setString(2, couponType);
		pstmt.setString(3, stdate);
		pstmt.setString(4, ltdate);
		pstmt.setString(5, vendor);
		pstmt.setString(6, saleType);
		pstmt.setInt(7, salePrice);
		pstmt.setString(8, saleUseYn);
		pstmt.setInt(9, useLimitCnt);
		pstmt.setInt(10, useLimitPrice);
		pstmt.setString(11, useGoods);
		pstmt.setInt(12, maxCoponCnt);
		pstmt.setString(13, instId);
		pstmt.setString(14, userIp);
		pstmt.executeUpdate();		
		try {
			rs			= pstmt.getGeneratedKeys();
			if (rs.next()) {
				couponId		= rs.getInt(1);
			}
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}
		rs.close();

		cnt		= 1;
		for (i = 0; i < memberIds.length; i++) {
			if (i < 10) {
				num		= "00" + Integer.toString(cnt);
			} else if (i < 100) {
				num		= "0" + Integer.toString(cnt);
			} else {
				num		= Integer.toString(cnt);
			}
			tmpNum		= dt.format(new Date()) + num;
			couponNum	= "ET" + tmpNum;

			memberId	= memberIds[i];

			query		= "INSERT INTO "+ table1 +"_MEMBER ";
			query		+= "	(COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
			query		+= " VALUES";
			query		+= "	("+ couponId +", '"+ couponNum +"', '"+ memberId +"', 'N', NOW())";
			try {
				stmt.executeUpdate(query);
			} catch (Exception e) {
				out.println(e+"=>"+query);
				if (true) return;
			}
			cnt++;
		}

		if (useGoods.equals("02")) {
			for (i = 0; i < groupCodes.length; i++) {
				groupArr	= groupCodes[i].trim().split(",");
				groupCode	= groupArr[0];
				groupName	= groupArr[1];

				query		= "INSERT INTO "+ table1 +"_GOODS ";
				query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
				query		+= " VALUES";
				query		+= "	("+ couponId +", '"+ groupCode +"', '"+ groupName +"')";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e+"=>"+query);
					if (true) return;
				}
			}
		} else if (useGoods.equals("03")) {
			query		= "SELECT GROUP_CODE, GROUP_NAME FROM ESL_GOODS_GROUP";
			query		+= " WHERE ID NOT IN (15, 16, 17, 18) AND USE_YN = 'Y'";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if (true) return;
			}

			while (rs.next()) {
				groupCode	= rs.getString("GROUP_CODE");
				groupName	= rs.getString("GROUP_NAME");

				query1		= "INSERT INTO "+ table1 +"_GOODS ";
				query1		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
				query1		+= " VALUES";
				query1		+= "	("+ couponId +", '"+ groupCode +"', '"+ groupName +"')";
				try {
					stmt1.executeUpdate(query1);
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if (true) return;
				}
			}
		} else if (useGoods.equals("04")) {
			query		= "INSERT INTO "+ table1 +"_GOODS ";
			query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
			query		+= " VALUES";
			query		+= "	("+ couponId +", '0300578', '밸런스쉐이크')";
			try {
				stmt.executeUpdate(query);
			} catch (Exception e) {
				out.println(e+"=>"+query);
				if (true) return;
			}
		}

		ut.jsAlert(out, "쿠폰지급이 완료되었습니다.");
		ut.jsRedirect(out, "event_join_view.jsp?id="+ eventId +"&"+ param);
	} else if (mode.equals("member")) {
		couponId			= Integer.parseInt(request.getParameter("coupon_id"));

		cnt		= 1;
		for (i = 0; i < memberIds.length; i++) {
			if (i < 10) {
				num		= "00" + Integer.toString(cnt);
			} else if (i < 100) {
				num		= "0" + Integer.toString(cnt);
			} else {
				num		= Integer.toString(cnt);
			}
			tmpNum		= dt.format(new Date()) + num;
			couponNum	= "ET" + tmpNum;

			memberId	= memberIds[i];

			query		= "INSERT INTO "+ table1 +"_MEMBER ";
			query		+= "	(COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
			query		+= " VALUES";
			query		+= "	("+ couponId +", '"+ couponNum +"', '"+ memberId +"', 'N', NOW())";
			try {
				stmt.executeUpdate(query);
			} catch (Exception e) {
				out.println(e+"=>"+query);
				if (true) return;
			}
			cnt++;
		}

		ut.jsAlert(out, "쿠폰지급이 완료되었습니다.");
		ut.jsRedirect(out, "event_join_view.jsp?id="+ eventId +"&"+ param);
	} else if (mode.equals("del")) {
		delId				= Integer.parseInt(request.getParameter("del_id"));

		query		= "DELETE FROM "+ table +" WHERE IDX = "+ delId;
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		ut.jsAlert(out, "삭제되었습니다.");
		ut.jsRedirect(out, "event_join_view.jsp?id="+ eventId +"&"+ param);
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>