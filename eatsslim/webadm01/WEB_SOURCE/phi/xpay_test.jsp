<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp" %>
<%
request.setCharacterEncoding("euc-kr");
String LGD_OID		= ut.inject(request.getParameter("order_num"));
String query		= "";   
			query="UPDATE ESL_ORDER SET PAY_DATE=NOW(),ORDER_STATE='01',PAY_YN='Y' WHERE ORDER_NUM='"+LGD_OID+"'";
			try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

%>
<%@ include file="/lib/phi_insert.jsp"%>
<%

			query="UPDATE ESL_ORDER_GOODS SET ORDER_STATE='01' WHERE ORDER_NUM='"+LGD_OID+"'";
			try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>