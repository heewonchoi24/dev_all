<%
/**
 * @date : 2019-01-17
 * @author : Heewon Choi
 * ü��� �ֹ� ���� ����(�ֹ�/���� �� �ѹ� �� ���� üũ)
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

if(promotion.equals("exp")){// �ֹ�/���� ���������� �ֹ��ϱ� ������ �� ���� ���� üũ

	// 5���� ��ǰ ���ֹ� 10�� �̸� ���� üũ
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
		data		= "������ ��Ȯ���� �ʽ��ϴ�.";
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
		data		= "�ش� ��ǰ �ֹ� ��û�� ����Ǿ����ϴ�.";
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