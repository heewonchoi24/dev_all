<%
/**
 * @date : 2019-01-17
 * @author : Heewon Choi
 * 체험단 주문 로직 파일(주문/결제 후 한번 더 수량 체크)
 */
%><%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.*"%>

<%
JSONObject obj = new JSONObject();

String data 	= "";
String code		= "";

String query1   = "";
int result	    = 0;

String groupCode	= ut.inject(request.getParameter("groupCode"));
String promotion	= ut.inject(request.getParameter("promotion"));	

if(promotion.equals("exp")){// 주문/결제 페이지에서 주문하기 누르면 한 번더 수량 체크

	// 5가지 제품 실주문 10개 미만 수량 체크
	try {
		query1       = " SELECT COUNT(EO.ORDER_NUM) RESULT ";
		query1      += " FROM ESL_GOODS_GROUP EGG, ESL_ORDER EO, ESL_ORDER_GOODS EOG ";
		query1      += " WHERE EGG.ID = EOG.GROUP_ID ";
		query1      += " AND EO.ORDER_NUM = EOG.ORDER_NUM  ";
		query1      += " AND EGG.GROUP_CODE = '"+groupCode+"' ";
		query1      += " AND DATE_FORMAT(EO.ORDER_DATE, '%Y%m%d') = DATE_FORMAT(NOW(), '%Y%m%d') ";
		query1      += " AND EOG.EXP_PROMOTION = '01' ";
		pstmt       = conn.prepareStatement(query1);
		rs          = pstmt.executeQuery();

		if (rs.next()) {
			result = rs.getInt("RESULT");
		}

		rs.close();
		pstmt.close();

	} catch(Exception e) {
		code		= "error";
		data		= "정보가 정확하지 않습니다.";
		obj.put("code",code);
		obj.put("data",data);
		out.clear();
		out.println(obj);
		out.flush();
		if(true)return;
	}

	System.out.println("result2:  " + result);

	if(result > 9){
		code		= "error";
		data		= "해당 상품 주문 신청이 종료되었습니다.";
		obj.put("code",code);
		obj.put("data",data);
		out.clear();
		out.println(obj);
		out.flush();
		if(true)return;
	}else{	
		code		= "success";
	}
}

obj.put("code",code);
obj.put("data",data);
out.clear();
out.println(obj);
out.flush();
%>
<%@ include file="../lib/dbclose.jsp"%>