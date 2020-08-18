<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String query		= "";
String query1		= "";
String code			= "";
String data			= "";
boolean error		= false;
String mode			= ut.inject(request.getParameter("mode"));
String type			= ut.inject(request.getParameter("type"));
String orderNum		= ut.inject(request.getParameter("order_num"));
// 일배 배송 정보
String rcvName		= ut.inject(request.getParameter("rcv_name"));
String rcvHp1		= ut.inject(request.getParameter("rcv_hp1"));
String rcvHp2		= ut.inject(request.getParameter("rcv_hp2"));
String rcvHp3		= ut.inject(request.getParameter("rcv_hp3"));
String rcvHp		= "";
if (rcvHp1 != null && rcvHp1.length() > 0) {
	rcvHp				= rcvHp1 +"-"+ rcvHp2 +"-"+ rcvHp3;
}
if (rcvHp.equals("")) {
	rcvHp				= "--";
}
String rcvTel		= "";
String rcvTel1		= ut.inject(request.getParameter("rcv_tel1"));
String rcvTel2		= ut.inject(request.getParameter("rcv_tel2"));
String rcvTel3		= ut.inject(request.getParameter("rcv_tel3"));
if (rcvTel1 != null && rcvTel1.length() > 0) {
	rcvTel				= rcvTel1 +"-"+ rcvTel2 +"-"+ rcvTel3;
}
if (rcvTel.equals("")) {
	rcvTel				= "--";
}
String rcvZipcode	= ut.inject(request.getParameter("rcv_zipcode"));
String rcvAddr1		= ut.inject(request.getParameter("rcv_addr1"));
String rcvAddr2		= ut.inject(request.getParameter("rcv_addr2"));
String rcvType		= ut.inject(request.getParameter("rcv_type"));
String rcvPassYn	= ut.inject(request.getParameter("rcv_pass_yn"));
String rcvPass		= ut.inject(request.getParameter("rcv_pass"));
String rcvRequest	= ut.inject(request.getParameter("rcv_request"));

// 택배 배송 정보
String tagName		= ut.inject(request.getParameter("tag_name"));
String tagHp1		= ut.inject(request.getParameter("tag_hp1"));
String tagHp2		= ut.inject(request.getParameter("tag_hp2"));
String tagHp3		= ut.inject(request.getParameter("tag_hp3"));
String tagHp		= "";
if (tagHp1 != null && tagHp1.length() > 0) {
	tagHp				= tagHp1 +"-"+ tagHp2 +"-"+ tagHp3;
}
if (tagHp.equals("")) {
	tagHp				= "--";
}
String tagTel		= "";
String tagTel1		= ut.inject(request.getParameter("tag_tel1"));
String tagTel2		= ut.inject(request.getParameter("tag_tel2"));
String tagTel3		= ut.inject(request.getParameter("tag_tel3"));
if (tagTel1 != null && tagTel1.length() > 0) {
	tagTel				= tagTel1 +"-"+ tagTel2 +"-"+ tagTel3;
}
if (tagTel.equals("")) {
	tagTel				= "--";
}
String tagZipcode	= ut.inject(request.getParameter("tag_zipcode"));
String tagAddr1		= ut.inject(request.getParameter("tag_addr1"));
String tagAddr2		= ut.inject(request.getParameter("tag_addr2"));
String tagType		= ut.inject(request.getParameter("tag_type"));
String tagRequest	= ut.inject(request.getParameter("tag_request"));

String rcvPartner	= "";
String tagPartner	= "";

int ordSeq			= 0;
int i				= 0;
SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
String instDate		= dt.format(new Date());

if (mode.equals("cngPost")) {
	if (type.equals("01")) {
		if (rcvName.equals("") || rcvName == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_name:받으시는분을 입력하세요.]]></error>";
		} else if (rcvHp1.equals("") || rcvHp1 == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_hp1:핸드폰번호를 선택하세요.]]></error>";
		} else if (rcvHp2.equals("") || rcvHp2 == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_hp2:핸드폰번호를 입력하세요.]]></error>";
		} else if (rcvHp3.equals("") || rcvHp3 == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_hp3:핸드폰번호를 입력하세요.]]></error>";
		} else if (rcvZipcode.equals("") || rcvZipcode == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_zipcode:우편번호를 입력하세요.]]></error>";
		} else if (rcvAddr1.equals("") || rcvAddr1 == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_addr1:기본주소를 입력하세요.]]></error>";
		} else if (rcvPassYn.equals("Y") && (rcvPass.equals("") || rcvPass == null)) {
			error		= true;
			data		= "<error><![CDATA[rcv_pass:출입시 비밀번호를 입력하세요.]]></error>";
		} else if (tagName.equals("") || tagName == null) {
			error		= true;
			data		= "<error><![CDATA[tag_name:받으시는분을 입력하세요.]]></error>";
		} else if (tagHp1.equals("") || tagHp1 == null) {
			error		= true;
			data		= "<error><![CDATA[tag_hp1:핸드폰번호를 선택하세요.]]></error>";
		} else if (tagHp2.equals("") || tagHp2 == null) {
			error		= true;
			data		= "<error><![CDATA[tag_hp2:핸드폰번호를 입력하세요.]]></error>";
		} else if (tagHp3.equals("") || tagHp3 == null) {
			error		= true;
			data		= "<error><![CDATA[tag_hp3:핸드폰번호를 입력하세요.]]></error>";
		} else if (tagZipcode.equals("") || tagZipcode == null) {
			error		= true;
			data		= "<error><![CDATA[tag_zipcode:우편번호를 입력하세요.]]></error>";
		} else if (tagAddr1.equals("") || tagAddr1 == null) {
			error		= true;
			data		= "<error><![CDATA[tag_addr1:기본주소를 입력하세요.]]></error>";
		}
	} else if (type.equals("02")) {
		if (rcvName.equals("") || rcvName == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_name:받으시는분을 입력하세요.]]></error>";
		} else if (rcvHp1.equals("") || rcvHp1 == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_hp1:핸드폰번호를 선택하세요.]]></error>";
		} else if (rcvHp2.equals("") || rcvHp2 == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_hp2:핸드폰번호를 입력하세요.]]></error>";
		} else if (rcvHp3.equals("") || rcvHp3 == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_hp3:핸드폰번호를 입력하세요.]]></error>";
		} else if (rcvZipcode.equals("") || rcvZipcode == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_zipcode:우편번호를 입력하세요.]]></error>";
		} else if (rcvAddr1.equals("") || rcvAddr1 == null) {
			error		= true;
			data		= "<error><![CDATA[rcv_addr1:기본주소를 입력하세요.]]></error>";
		} else if (rcvPassYn.equals("Y") && (rcvPass.equals("") || rcvPass == null)) {
			error		= true;
			data		= "<error><![CDATA[rcv_pass:출입시 비밀번호를 입력하세요.]]></error>";
		}
	} else if (type.equals("03")) {
		if (tagName.equals("") || tagName == null) {
			error		= true;
			data		= "<error><![CDATA[tag_name:받으시는분을 입력하세요.]]></error>";
		} else if (tagHp1.equals("") || tagHp1 == null) {
			error		= true;
			data		= "<error><![CDATA[tag_hp1:핸드폰번호를 선택하세요.]]></error>";
		} else if (tagHp2.equals("") || tagHp2 == null) {
			error		= true;
			data		= "<error><![CDATA[tag_hp2:핸드폰번호를 입력하세요.]]></error>";
		} else if (tagHp3.equals("") || tagHp3 == null) {
			error		= true;
			data		= "<error><![CDATA[tag_hp3:핸드폰번호를 입력하세요.]]></error>";
		} else if (tagZipcode.equals("") || tagZipcode == null) {
			error		= true;
			data		= "<error><![CDATA[tag_zipcode:우편번호를 입력하세요.]]></error>";
		} else if (tagAddr1.equals("") || tagAddr1 == null) {
			error		= true;
			data		= "<error><![CDATA[tag_addr1:기본주소를 입력하세요.]]></error>";
		}
	}

	if (error) {
		code		= "error";
	} else {
		query		= "UPDATE ESL_ORDER SET ";
		query		+= "	RCV_NAME		= '"+ rcvName +"'";
		query		+= "	,RCV_ZIPCODE	= '"+ rcvZipcode +"'";
		query		+= "	,RCV_ADDR1		= '"+ rcvAddr1 +"'";
		query		+= "	,RCV_ADDR2		= '"+ rcvAddr2 +"'";
		query		+= "	,RCV_HP			= '"+ rcvHp +"'";
		query		+= "	,RCV_TEL		= '"+ rcvTel +"'";
		query		+= "	,RCV_TYPE		= '"+ rcvType +"'";
		query		+= "	,RCV_PASS_YN	= '"+ rcvPassYn +"'";
		query		+= "	,RCV_PASS		= '"+ rcvPass +"'";
		query		+= "	,RCV_REQUEST	= '"+ rcvRequest +"'";
		query		+= "	,TAG_NAME		= '"+ tagName +"'";
		query		+= "	,TAG_ZIPCODE	= '"+ tagZipcode +"'";
		query		+= "	,TAG_ADDR1		= '"+ tagAddr1 +"'";
		query		+= "	,TAG_ADDR2		= '"+ tagAddr2 +"'";
		query		+= "	,TAG_HP			= '"+ tagHp +"'";
		query		+= "	,TAG_TEL		= '"+ tagTel +"'";
		query		+= "	,TAG_TYPE		= '"+ tagType +"'";
		query		+= "	,TAG_REQUEST	= '"+ tagRequest +"'";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
				
		try {
			stmt.executeUpdate(query);					
		} catch (Exception e) {
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}

		// 일배 위탁점 조회
		query		= "SELECT PARTNERID FROM PHIBABY.V_ZIPCODE WHERE ZIPCODE = '"+ rcvZipcode +"'";
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


		// 택배 위탁점 조회
		query		= "SELECT PARTNERID FROM PHIBABY.V_ZIPCODE WHERE ZIPCODE = '"+ tagZipcode +"'";
		try {
			rs_phi		= stmt_phi.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs_phi.next()) {
			tagPartner		= rs_phi.getString("PARTNERID");
		}
		rs_phi.close();

		if (type.equals("01")) {
			query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
			query		+= "	AGENCYID		= '"+ rcvPartner +"'";
			query		+= "	,RCV_NAME		= '"+ rcvName +"'";
			query		+= "	,RCV_ZIPCODE	= '"+ rcvZipcode +"'";
			query		+= "	,RCV_ADDR1		= '"+ rcvAddr1 +"'";
			query		+= "	,RCV_ADDR2		= '"+ rcvAddr2 +"'";
			query		+= "	,RCV_HP			= '"+ rcvHp +"'";
			query		+= "	,RCV_TEL		= '"+ rcvTel +"'";
			query		+= "	,RCV_REQUEST	= '"+ rcvRequest +"'";
			query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND DEVL_TYPE = '0001'";
			try {
				stmt.executeUpdate(query);					
			} catch (Exception e) {
				code		= "error";
				data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
			}

			query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
			query		+= "	AGENCYID		= '"+ tagPartner +"'";
			query		+= "	,RCV_NAME		= '"+ tagName +"'";
			query		+= "	,RCV_ZIPCODE	= '"+ tagZipcode +"'";
			query		+= "	,RCV_ADDR1		= '"+ tagAddr1 +"'";
			query		+= "	,RCV_ADDR2		= '"+ tagAddr2 +"'";
			query		+= "	,RCV_HP			= '"+ tagHp +"'";
			query		+= "	,RCV_TEL		= '"+ tagTel +"'";
			query		+= "	,RCV_REQUEST	= '"+ tagRequest +"'";
			query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND DEVL_TYPE = '0002'";
			try {
				stmt.executeUpdate(query);					
			} catch (Exception e) {
				code		= "error";
				data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
			}
		} else if (type.equals("02")) {
			query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
			query		+= "	AGENCYID		= '"+ rcvPartner +"'";
			query		+= "	,RCV_NAME		= '"+ rcvName +"'";
			query		+= "	,RCV_ZIPCODE	= '"+ rcvZipcode +"'";
			query		+= "	,RCV_ADDR1		= '"+ rcvAddr1 +"'";
			query		+= "	,RCV_ADDR2		= '"+ rcvAddr2 +"'";
			query		+= "	,RCV_HP			= '"+ rcvHp +"'";
			query		+= "	,RCV_TEL		= '"+ rcvTel +"'";
			query		+= "	,RCV_REQUEST	= '"+ rcvRequest +"'";
			query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND DEVL_TYPE = '0001'";
			try {
				stmt.executeUpdate(query);					
			} catch (Exception e) {
				code		= "error";
				data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
			}
		} else if (type.equals("03")) {
			query		= "UPDATE ESL_ORDER_DEVL_DATE SET ";
			query		+= "	AGENCYID		= '"+ tagPartner +"'";
			query		+= "	,RCV_NAME		= '"+ tagName +"'";
			query		+= "	,RCV_ZIPCODE	= '"+ tagZipcode +"'";
			query		+= "	,RCV_ADDR1		= '"+ tagAddr1 +"'";
			query		+= "	,RCV_ADDR2		= '"+ tagAddr2 +"'";
			query		+= "	,RCV_HP			= '"+ tagHp +"'";
			query		+= "	,RCV_TEL		= '"+ tagTel +"'";
			query		+= "	,RCV_REQUEST	= '"+ tagRequest +"'";
			query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND DEVL_TYPE = '0002'";
			try {
				stmt.executeUpdate(query);					
			} catch (Exception e) {
				code		= "error";
				data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
			}
		}

		query		= "UPDATE PHIBABY.P_ORDER_MALL_PHI_ITF SET INTERFACE_FLAG_YN = 'Y' WHERE ORD_NO = '"+ orderNum +"'";
		try {
			stmt_phi.executeUpdate(query);
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}
		query		= "SELECT * FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			rs			= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		i = 1;
		while (rs.next()) {
			// 시퀀스 조회
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

			query1		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
			query1		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM)";
			query1		+= "	VALUES";
			query1		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			pstmt_phi	= conn_phi.prepareStatement(query1);

			pstmt_phi.setInt(1, ordSeq);
			pstmt_phi.setString(2, rs.getString("ORDER_DATE"));
			pstmt_phi.setString(3, orderNum);
			pstmt_phi.setString(4, rs.getString("CUSTOMER_NUM"));
			pstmt_phi.setString(5, "I");
			pstmt_phi.setString(6, rs.getString("ORDER_NAME"));
			pstmt_phi.setString(7, rs.getString("RCV_NAME"));
			pstmt_phi.setString(8, rs.getString("RCV_ZIPCODE"));
			pstmt_phi.setString(9, rs.getString("RCV_ADDR1"));
			pstmt_phi.setString(10, rs.getString("RCV_ADDR2"));
			pstmt_phi.setString(11, rs.getString("RCV_TEL"));
			pstmt_phi.setString(12, rs.getString("RCV_HP"));
			pstmt_phi.setString(13, rs.getString("RCV_EMAIL"));
			pstmt_phi.setInt(14, rs.getInt("TOT_SELL_PRICE"));
			pstmt_phi.setInt(15, rs.getInt("TOT_PAY_PRICE"));
			pstmt_phi.setInt(16, rs.getInt("TOT_DEVL_PRICE"));
			pstmt_phi.setInt(17, rs.getInt("TOT_DC_PRICE"));
			pstmt_phi.setString(18, rs.getString("PAY_TYPE"));
			pstmt_phi.setString(19, rs.getString("DEVL_TYPE"));
			pstmt_phi.setString(20, rs.getString("AGENCYID"));
			pstmt_phi.setString(21, rs.getString("RCV_REQUEST"));
			pstmt_phi.setInt(22, i);
			pstmt_phi.setString(23, rs.getString("DEVL_DATE").replace("-",""));
			pstmt_phi.setString(24, rs.getString("GROUP_CODE"));
			pstmt_phi.setInt(25, rs.getInt("ORDER_CNT"));
			pstmt_phi.setInt(26, rs.getInt("PRICE"));
			pstmt_phi.setInt(27, rs.getInt("PAY_PRICE"));
			try {
				pstmt_phi.executeUpdate();
			} catch (Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

			i++;
		}

		code		= "success";

	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>
<%@ include file="../lib/dbclose_phi.jsp"%>