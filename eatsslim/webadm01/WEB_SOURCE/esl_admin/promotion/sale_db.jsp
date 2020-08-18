<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_SALE";
String query			= "";
String query1			= "";
Statement stmt1			= null;
stmt1					= conn.createStatement();
String sid				= ut.inject(request.getParameter("sid"));
String mode				= ut.inject(request.getParameter("mode"));
int saleId				= 0;
String title			= ut.inject(request.getParameter("title"));
String stdate			= ut.inject(request.getParameter("stdate"));
String ltdate			= ut.inject(request.getParameter("ltdate"));
String saleType			= ut.inject(request.getParameter("sale_type"));
int salePrice1			= 0;
int salePrice2			= 0;
int salePrice			= 0;
String useGoods			= ut.inject(request.getParameter("use_goods"));
String[] groupArr;
String groupCodes[]		= request.getParameterValues("group_code");
String groupCode		= "";
String groupNames[]		= request.getParameterValues("group_name");
String groupName		= "";
String param			= ut.inject(request.getParameter("param"));
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();
if (request.getParameter("sale_price1") != null && request.getParameter("sale_price1").length()>0)
	salePrice1		= Integer.parseInt(request.getParameter("sale_price1"));
if (request.getParameter("sale_price2") != null && request.getParameter("sale_price2").length()>0)
	salePrice2		= Integer.parseInt(request.getParameter("sale_price2"));
salePrice		= (saleType.equals("P"))? salePrice1 : salePrice2;

if (mode != null) {
	if (mode.equals("ins")) {
		query		= "INSERT INTO "+ table;
		query		+= "	(TITLE, STDATE, LTDATE, SALE_TYPE, SALE_PRICE, USE_GOODS, INST_ID, INST_IP, INST_DATE)";
		query		+= " VALUES";
		query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, NOW())";
		pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		pstmt.setString(1, title);
		pstmt.setString(2, stdate);
		pstmt.setString(3, ltdate);
		pstmt.setString(4, saleType);
		pstmt.setInt(5, salePrice);
		pstmt.setString(6, useGoods);
		pstmt.setString(7, instId);
		pstmt.setString(8, userIp);
		pstmt.executeUpdate();		
		try {
			rs			= pstmt.getGeneratedKeys();
			if (rs.next()) {
				saleId		= rs.getInt(1);
			}
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}
		rs.close();

		if (useGoods.equals("02")) {
			for (i = 0; i < groupCodes.length; i++) {
				groupArr	= groupCodes[i].trim().split(",");
				groupCode	= groupArr[0];
				groupName	= groupArr[1];

				query		= "INSERT INTO "+ table +"_GOODS ";
				query		+= "	(SALE_ID, GROUP_CODE, GROUP_NAME)";
				query		+= " VALUES";
				query		+= "	("+ saleId +", '"+ groupCode +"', '"+ groupName +"')";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e+"=>"+query);
					if (true) return;
				}
			}
		}	

		ut.jsRedirect(out, "sale_list.jsp");
	} else if (mode.equals("mod")) {
		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	TITLE			= ?,";
			query		+= "	STDATE			= ?,";
			query		+= "	LTDATE			= ?,";
			query		+= "	SALE_TYPE			= ?,";
			query		+= "	SALE_PRICE			= ?,";
			query		+= "	USE_GOODS		= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, title);
			pstmt.setString(2, stdate);
			pstmt.setString(3, ltdate);
			pstmt.setString(4, saleType);
			pstmt.setInt(5, salePrice);
			pstmt.setString(6, useGoods);
			pstmt.setString(7, instId);
			pstmt.setString(8, userIp);
			pstmt.setInt(9, Integer.parseInt(sid));
			pstmt.executeUpdate();
			
			query		= "DELETE FROM "+ table +"_GOODS " +" WHERE SALE_ID = "+ sid;
			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();
			
			if (useGoods.equals("02")) {
				
				for (i = 0; i < groupCodes.length; i++) {
					groupArr	= groupCodes[i].trim().split(",");
					groupCode	= groupArr[0];
					groupName	= groupArr[1];

					query		= "INSERT INTO "+ table +"_GOODS ";
					query		+= "	(SALE_ID, GROUP_CODE, GROUP_NAME)";
					query		+= " VALUES";
					query		+= "	("+ sid +", '"+ groupCode +"', '"+ groupName +"')";
					try {
						stmt.executeUpdate(query);
					} catch (Exception e) {
						out.println(e+"=>"+query);
						if (true) return;
					}
				}
			}	

		} catch (Exception e) {
			out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "sale_list.jsp?"+ param);
	} else if (mode.equals("del")) {
		//delIds		= ut.inject(request.getParameter("del_ids"));

		try {
			query		= "DELETE FROM "+ table +" WHERE ID = "+ sid +"";
			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();
			
			query		= "DELETE FROM "+ table +"_GOODS "+" WHERE ID = "+ sid +"";
			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();

			ut.jsRedirect(out, "sale_list.jsp");
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
		}
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>