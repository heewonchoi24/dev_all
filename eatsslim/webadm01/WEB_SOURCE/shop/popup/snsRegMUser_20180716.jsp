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
	response.setCharacterEncoding("euc-kr");        //한글 깨짐 방지
	
		String name = request.getParameter("Name");
		String userId = request.getParameter("Id");
		String Key = request.getParameter("Key");
		String email = request.getParameter("Email");
		String customerNum = "";
		SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today		= dt.format(new Date());
		String userIp = request.getRemoteAddr();
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date()); //오늘
		String stdate			= (new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
		int result = 0;
		String query		 	= "";
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
			query       = "SELECT IF(";
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
				response.sendRedirect("http://www.eatsslim.co.kr/index_es.jsp");
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
				
				// 회원가입 시 쿠폰 지급을 위한 소스
				query		= "SELECT ID FROM ESL_COUPON  ";
				query		+= "	WHERE STDATE <= '"+ stdate +"' AND LTDATE >= '"+ stdate +"' ";
				query		+= "		AND VENDOR = '06'  ";

				try {
					rs		= stmt.executeQuery(query);
					
					SimpleDateFormat dt2	= new SimpleDateFormat("yyMMddHHmmss");
					String couponNum		= "ET" + dt2.format(new Date());
					int	cnIdx = 1;
					String couponNumStr = ""; 

					while (rs.next()) {

						if (cnIdx < 10) {
							couponNumStr		= "00" + Integer.toString(cnIdx);
						} else if (cnIdx < 100) {
							couponNumStr		= "0" + Integer.toString(cnIdx);
						} else {
							couponNumStr		= Integer.toString(cnIdx);
						}
						query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
						//query		+= " VALUES ("+ rs.getInt("ID") +",'"+ couponNum + couponNumStr +"','"+ userId +"','N',NOW())";
						query		+= " VALUES (?,?,?,'N',NOW())";
						try {
							//stmt.executeUpdate(query);
							
							pstmt	= conn.prepareStatement(query);
							pstmt.setInt(1, rs.getInt("ID") );
							pstmt.setString(2, couponNum+couponNumStr);
							pstmt.setString(3, userId);
							pstmt.executeUpdate();
						} catch (Exception e) {
							out.println(e);
							if(true)return;
						}
						
						cnIdx++;
					}
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}
				rs.close();			
			}
		}
		
		
		// 로그인 시 쿠폰 지급을 위한 소스
		int	cnIdx = 1;
		query		= "";
		query		= "SELECT ID, DATE_FORMAT(ltdate, '%Y-%m-%d') as endDate FROM ESL_COUPON  ";
		query		+= "	WHERE STDATE <= '"+ stdate +"' AND LTDATE >= '"+ stdate +"' ";
		query		+= "		AND VENDOR = '07'  ";
		
		ResultSet rs1		= null;
		Statement stmt1		= null;
		stmt1				= conn.createStatement();

		try {
			rs		= stmt.executeQuery(query);
			
			SimpleDateFormat dt2	= new SimpleDateFormat("yyMMddHHmmss");
			String couponNum		= "ET" + dt2.format(new Date());
			
			String couponNumStr 	= "";
			int couponCnt			= 0;

			while (rs.next()) {

				if (cnIdx < 10) {
					couponNumStr		= "00" + Integer.toString(cnIdx);
				} else if (cnIdx < 100) {
					couponNumStr		= "0" + Integer.toString(cnIdx);
				} else {
					couponNumStr		= Integer.toString(cnIdx);
				}

				query		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
				query		+= " WHERE MEMBER_ID = '"+ userId +"' AND COUPON_ID = " + rs.getInt("ID");
				try {
					rs1		= stmt1.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs1.next()) {
					couponCnt	= rs1.getInt(1);
				}
				rs1.close();

				if (couponCnt > 0) {
				} else {			

					query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
					//query		+= " VALUES ("+ rs.getInt("ID") +",'"+ couponNum + couponNumStr +"','"+ userId +"','N',NOW())";
					query		+= " VALUES (?,?,?,'N',NOW())";
					try {
						//stmt.executeUpdate(query);
						
						pstmt	= conn.prepareStatement(query);
						pstmt.setInt(1, rs.getInt("ID") );
						pstmt.setString(2, couponNum+couponNumStr);
						pstmt.setString(3, userId);
						pstmt.executeUpdate();
					} catch (Exception e) {
						out.println(e);
						if(true)return;
					}
				}
				
				cnIdx++;
			}

		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		rs.close();
		
				
		query		= "UPDATE ESL_MEMBER SET LAST_LOGIN_DATE = NOW(),";
		query		+= "				LAST_LOGIN_IP = '"+ userIp +"'";
		query		+= "	WHERE MEM_ID = '"+ userId +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		
		//-- 장바구니 비움
		query = "DELETE FROM ESL_CART WHERE MEMBER_ID='" + userId + "'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		
		session.setAttribute("esl_member_id", userId);    
		session.setAttribute("esl_member_name", name);  
		session.setAttribute("esl_customer_num", customerNum);
		session.setAttribute("esl_member_code", ""); //통합회원 구분
		
		String returnUrl = (String)session.getAttribute("RETURN_URL");
		session.removeAttribute("RETURN_URL");
		if(returnUrl == null || "".equals(returnUrl)) returnUrl = "/mobile";
		response.sendRedirect(returnUrl);

		
	%>

