<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_GOODS_SETTING";
String chkQuery		= "";
String query		= "";
boolean error		= false;
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String instId		= (String)session.getAttribute("esl_admin_id");
String userIp		= request.getRemoteAddr();
String[] goodsCodes	= request.getParameterValues("goods_code");
String goodsCode	= "";
String goodsName	= "";
int goodsPrice		= 0;
String goodsType	= "";
String gubun1		= "";
String gubun2		= "";
String gubun3		= "";
int cnt				= 0;
int insData			= 0;

if (instId == null || instId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[no_txt:로그인을 해주세요.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[no_txt:정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[no_txt:정상적으로 접근을 해주십시오.]]></error>";
} else if (mode.equals("updAll")) {
	for (int i = 0; i < goodsCodes.length; i++) {
		goodsCode	= ut.inject(goodsCodes[i]);
		goodsName	= ut.inject(request.getParameter("goods_name_"+ goodsCode));
		goodsPrice	= Integer.parseInt(request.getParameter("goods_price_"+ goodsCode));
		goodsType	= ut.inject(request.getParameter("goods_type_"+ goodsCode));
		gubun1		= ut.inject(request.getParameter("gubun1_"+ goodsCode));
		gubun1		= (gubun1 == null || gubun1.equals(""))? "" : gubun1;
		gubun2		= ut.inject(request.getParameter("gubun2_"+ goodsCode));
		gubun2		= (gubun2 == null || gubun2.equals(""))? "" : gubun2;
		gubun3		= ut.inject(request.getParameter("gubun3_"+ goodsCode));

		if (goodsCode == null || goodsCode.equals("")) {
			error		= true;
			data		= "<error><![CDATA[goods_code_"+ goodsCode +":상품코드를 입력하세요.]]></error>";
		} else if (goodsName == null || goodsName.equals("")) {
			error		= true;
			data		= "<error><![CDATA[goods_name_"+ goodsCode +":상품명을 입력하세요.]]></error>";
		} else if (goodsPrice < 0) {
			error		= true;
			data		= "<error><![CDATA[goods_price_"+ goodsCode +":상품가격을 입력하세요.]]></error>";
		} else if (goodsType == null || goodsType.equals("")) {
			error		= true;
			data		= "<error><![CDATA[goods_type_"+ goodsCode +":["+ goodsCode +"] 상품타입을 선택하세요.]]></error>";
		} else if (goodsType.equals("G") && (gubun1 == null || gubun1.equals(""))) {
			error		= true;
			data		= "<error><![CDATA[gubun1_"+ goodsCode +":["+ goodsCode +"] 구분1을 선택하세요.]]></error>";
		} else if (goodsType.equals("G") && (!gubun1.equals("02") && !gubun1.equals("04") && !gubun1.equals("09")) && (gubun2 == null || gubun2.equals(""))) {
			error		= true;
			data		= "<error><![CDATA[gubun2_"+ goodsCode +":["+ goodsCode +"] 구분2를 선택하세요.]]></error>";
		}

		if (error) {
			code		= "error";
			break;
		} else {
			try {
				chkQuery	= "SELECT COUNT(ID) FROM "+ table +" WHERE GOODS_CODE = ?";
				pstmt		= conn.prepareStatement(chkQuery);
				pstmt.setString(1, goodsCode);
				rs			= pstmt.executeQuery();
				if (rs.next()) {
					cnt		= rs.getInt(1);
				}
				rs.close();
				pstmt.close();

				if (cnt > 0) {
					query		= "UPDATE "+ table +" SET ";
					query		+= "		GOODS_NAME		= ?,";
					query		+= "		GOODS_PRICE		= ?,";
					query		+= "		GOODS_TYPE		= ?,";
					query		+= "		GUBUN1			= ?,";
					query		+= "		GUBUN2			= ?,";
					query		+= "		GUBUN3			= ?,";
					query		+= "		UPDT_ID			= ?,";
					query		+= "		UPDT_IP			= ?,";
					query		+= "		UPDT_DATE		= NOW()";
					query		+= "	WHERE GOODS_CODE = ?";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, goodsPrice);
					pstmt.setString(2, goodsName);
					pstmt.setString(3, goodsType);
					pstmt.setString(4, gubun1);
					pstmt.setString(5, gubun2);
					pstmt.setString(6, gubun3);
					pstmt.setString(7, instId);
					pstmt.setString(8, userIp);
					pstmt.setString(9, goodsCode);
				} else {
					query		= "INSERT INTO "+ table;
					query		+= "	(GOODS_CODE, GOODS_NAME, GOODS_PRICE, GOODS_TYPE, GUBUN1, GUBUN2, GUBUN3, INST_ID, INST_IP, INST_DATE)";
					query		+= " VALUES ";
					query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
					pstmt		= conn.prepareStatement(query);
					pstmt.setString(1, goodsCode);
					pstmt.setString(2, goodsName);
					pstmt.setInt(3, goodsPrice);
					pstmt.setString(4, goodsType);
					pstmt.setString(5, gubun1);
					pstmt.setString(6, gubun2);
					pstmt.setString(7, gubun3);
					pstmt.setString(8, instId);
					pstmt.setString(9, userIp);
				}
				pstmt.executeUpdate();
			} catch (Exception e) {
				code		= "error";
				data		= "<error><![CDATA[no_txt:장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
				break;
			} finally {
				insData++;
				if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
			}
		}
	}

	if (error == false) {
		if (insData == goodsCodes.length) {
			code		= "success";
		} else {
			code		= "error";
			data		= "<error><![CDATA[no_txt:장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
	}
} else if (mode.equals("ins")) {
	goodsCode	= ut.inject(request.getParameter("goods_code"));
	goodsName	= ut.inject(request.getParameter("goods_name"));
	goodsPrice	= Integer.parseInt(request.getParameter("goods_price"));
	goodsType	= ut.inject(request.getParameter("goods_type"));
	gubun1		= ut.inject(request.getParameter("gubun1"));
	gubun1		= (gubun1 == null || gubun1.equals(""))? "" : gubun1;
	gubun2		= ut.inject(request.getParameter("gubun2"));
	gubun2		= (gubun2 == null || gubun2.equals(""))? "" : gubun2;
	gubun3		= ut.inject(request.getParameter("gubun3"));

	if (goodsCode == null || goodsCode.equals("")) {
		error		= true;
		data		= "<error><![CDATA[goods_code_"+ goodsCode +":상품코드를 입력하세요.]]></error>";
	} else if (goodsName == null || goodsName.equals("")) {
		error		= true;
		data		= "<error><![CDATA[goods_name_"+ goodsCode +":상품명을 입력하세요.]]></error>";
	} else if (goodsPrice < 0) {
		error		= true;
		data		= "<error><![CDATA[goods_price_"+ goodsCode +":상품가격을 입력하세요.]]></error>";
	} else if (goodsType == null || goodsType.equals("")) {
		error		= true;
		data		= "<error><![CDATA[goods_type_"+ goodsCode +":["+ goodsCode +"] 상품타입을 선택하세요.]]></error>";
	} else if (goodsType.equals("G") && (gubun1 == null || gubun1.equals(""))) {
		error		= true;
		data		= "<error><![CDATA[gubun1_"+ goodsCode +":["+ goodsCode +"] 구분1을 선택하세요.]]></error>";
	} else if (goodsType.equals("G") && (!gubun1.equals("02") && !gubun1.equals("04") && !gubun1.equals("09")) && (gubun2 == null || gubun2.equals(""))) {
		error		= true;
		data		= "<error><![CDATA[gubun2_"+ goodsCode +":["+ goodsCode +"] 구분2를 선택하세요.]]></error>";
	}		

	if (error) {
		code		= "error";
	} else {
		try {
			chkQuery	= "SELECT COUNT(ID) FROM "+ table +" WHERE GOODS_CODE = ?";
			pstmt		= conn.prepareStatement(chkQuery);
			pstmt.setString(1, goodsCode);
			rs			= pstmt.executeQuery();
			if (rs.next()) {
				cnt		= rs.getInt(1);
			}
			rs.close();
			pstmt.close();

			if (cnt > 0) {
				query		= "UPDATE "+ table +" SET ";
				query		+= "		GOODS_PRICE		= ?,";
				query		+= "		GOODS_TYPE		= ?,";
				query		+= "		GUBUN1			= ?,";
				query		+= "		GUBUN2			= ?,";
				query		+= "		GUBUN3			= ?,";
				query		+= "		UPDT_ID			= ?,";
				query		+= "		UPDT_IP			= ?,";
				query		+= "		UPDT_DATE		= NOW()";
				query		+= "	WHERE GOODS_CODE = ?";
				pstmt		= conn.prepareStatement(query);
				pstmt.setInt(1, goodsPrice);
				pstmt.setString(2, goodsType);
				pstmt.setString(3, gubun1);
				pstmt.setString(4, gubun2);
				pstmt.setString(5, gubun3);
				pstmt.setString(6, instId);
				pstmt.setString(7, userIp);
				pstmt.setString(8, goodsCode);
			} else {
				query		= "INSERT INTO "+ table;
				query		+= "	(GOODS_CODE, GOODS_NAME, GOODS_PRICE, GOODS_TYPE, GUBUN1, GUBUN2, GUBUN3, INST_ID, INST_IP, INST_DATE)";
				query		+= " VALUES ";
				query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
				pstmt		= conn.prepareStatement(query);
				pstmt.setString(1, goodsCode);
				pstmt.setString(2, goodsName);
				pstmt.setInt(3, goodsPrice);
				pstmt.setString(4, goodsType);
				pstmt.setString(5, gubun1);
				pstmt.setString(6, gubun2);
				pstmt.setString(7, gubun3);
				pstmt.setString(8, instId);
				pstmt.setString(9, userIp);
			}
			pstmt.executeUpdate();

			code		= "success";
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[no_txt:장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>