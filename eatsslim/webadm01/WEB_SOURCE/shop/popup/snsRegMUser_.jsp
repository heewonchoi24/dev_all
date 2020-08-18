<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="javax.servlet.http.HttpUtils"%>
<%@ include file="/lib/config.jsp"%>
<%
    request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");        //ÇÑ±Û ±úÁü ¹æÁö
	
		String name = request.getParameter("Name");
		String userId = request.getParameter("Id");
		String Key = request.getParameter("Key");
		String email = request.getParameter("Email");
		String customerNum = "";
		SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String today		= dt.format(new Date());
		int result = 0;

		String query1     = "";
			query1       += "SELECT EXISTS (SELECT * FROM ESL_MEMBER WHERE SNS_ACCESS_KEY ='"+Key+"')RESULT";
			pstmt       = conn.prepareStatement(query1);
		try {
		  rs                = pstmt.executeQuery();
		} catch(Exception e) {
		  out.println(e+"=>"+query1);
		  if(true)return;
		}
		
		if (rs.next()) {
			result             = rs.getInt("RESULT");
		}
		
		if(result >= 1){

			String query2     = "";
				query2       += "SELECT CUSTOMER_NUM FROM ESL_MEMBER WHERE SNS_ACCESS_KEY ='"+Key+"'";
				pstmt       = conn.prepareStatement(query2);
			try {
			  rs                = pstmt.executeQuery();
			} catch(Exception e) {
			  out.println(e+"=>"+query2);
			  if(true)return;
			}
		
			if (rs.next()) {
				customerNum             = rs.getString("CUSTOMER_NUM");
			}
			
		}else{
			String query     = "";
					query       += "SELECT IF(";
					query       += "        (SELECT MAX(CUSTOMER_NUM) FROM ESL_MEMBER) >= 100000000,";
					query       += "        (SELECT MAX(CUSTOMER_NUM)+1 FROM ESL_MEMBER), ";
					query       += "        100000000";
					query       += ")CUSTOMER_NUM";
					pstmt       = conn.prepareStatement(query);
			try {
			  rs                = pstmt.executeQuery();
			} catch(Exception e) {
			  out.println(e+"=>"+query);
			  if(true)return;
			}
			
			if (rs.next()) {
				customerNum             = rs.getString("CUSTOMER_NUM");
			}
			
			if(  (name == null || name.equals("")) &&  (userId == null || userId.equals(""))
					&&  (email == null || email.equals(""))   ){
				response.sendRedirect("http://dev.eatsslim.co.kr/index_es.jsp");
			}else{
				try {
					String 	query2            = "";
							query2            += "INSERT INTO ESL_MEMBER  (CUSTOMER_NUM, MEM_NAME, MEM_ID, SEX, BIRTH_DATE, EMAIL, SNS_ACCESS_KEY, INST_DATE)";        
							query2            += "VALUES (?, ?, ?, 'F', '19000101',?, ?, ?)";
							pstmt       = conn.prepareStatement(query2);
							pstmt.setString(1, customerNum);
							pstmt.setString(2, name);
							pstmt.setString(3, userId);
							pstmt.setString(4, email);
							pstmt.setString(5, Key);
							pstmt.setString(6, today);
							pstmt.executeUpdate();
				} catch (Exception e) {
				      out.println(e);
				      return;
				}
			}
		}
		
		session.setAttribute("esl_member_id", email);    
		session.setAttribute("esl_member_name", name);  
		session.setAttribute("esl_customer_num", customerNum); 
		response.sendRedirect("http://dev.eatsslim.co.kr/mobile");
		
	%>

