<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%@ page import="java.io.File"%>
<%
request.setCharacterEncoding("utf-8");

String query		= "";
boolean error		= false;
String code			= "";
String data			= "";

String inconvenient_detail = ut.inject(request.getParameter("inconvenient_detail"));
String comment_detail 	   = ut.inject(request.getParameter("comment_detail"));

System.out.println(inconvenient_detail);
System.out.println(comment_detail);

//	ESL_MEMBER_LEAVE 테이블에 소셜 탈퇴 회원 정보  INSERT & SELECT
try {
    query   = " INSERT INTO ESL_MEMBER_LEAVE(CUSTOMER_NUM,  MEM_NAME, MEM_ID, INST_DATE, ACTOR, IP, MEMO, REASON, INCONVENIENT_DETAILS, COMMENT_DETAILS, SNS_ACCESS_KEY) ";
    query  += " SELECT CUSTOMER_NUM, MEM_NAME, MEM_ID, NOW(), '', '', '', '', ?, ?, SNS_ACCESS_KEY ";
    query  += " FROM ESL_MEMBER ";
    query  += " WHERE MEM_ID = '"+ eslMemberId +"' AND CUSTOMER_NUM = '"+ eslCustomerNum +"'";

	System.out.println(query);

    pstmt   = conn.prepareStatement(query);
    pstmt.setString(1, inconvenient_detail);
    pstmt.setString(2, comment_detail);
    pstmt.executeUpdate();
    code		= "success";
    
 	// ESL_MEMBER 데이블에서 회원 정보 삭제
    try{
    	query		= " DELETE FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"' AND CUSTOMER_NUM = '"+ eslCustomerNum +"' ";
    	pstmt		= conn.prepareStatement(query);
    	pstmt.executeUpdate();
    } catch (Exception e) {
    	ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
    	ut.jsBack(out);
    	return;
    } finally {
    	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    } 
} catch (Exception e) {
	code		= "error";
    data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
} finally {
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
}
out.println("<response>");
out.println("<result>"+code+"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose.jsp"%>