<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript"	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"	charset="utf-8"></script>
<script type="text/javascript"	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<%
    String clientId 		= "R3bOi32f0cKYCX8LuXDq";//애플리케이션 클라이언트 아이디값";
    String clientSecret 	= "UNngp05vfV";//애플리케이션 클라이언트 시크릿값";
    String code 			= request.getParameter("code");  //네이버 아이디로 로그인 인증에 성공하면 반환받는 인증 코드, 접근 토큰(access token) 발급에 사용
    String state 			= request.getParameter("state");
    String redirectURI 		= URLEncoder.encode("http://www.eatsslim.co.kr/shop/popup/loginCheck.jsp", "UTF-8");
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String refresh_token = "";
    SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String today		= dt.format(new Date());
	Calendar cal = Calendar.getInstance();
	cal.setTime(new Date()); //오늘
	String stdate			= (new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
    
    try {
       URL Nurl = new URL(apiURL);
       HttpURLConnection con = (HttpURLConnection)Nurl.openConnection();
       con.setRequestMethod("GET");
       int responseCode = con.getResponseCode();
       BufferedReader br;
       if(responseCode==200) { // 정상 호출
         br = new BufferedReader(new InputStreamReader(con.getInputStream()));
       } else {  // 에러 발생
         br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
       }
       String inputLine;
       String res1;
       StringBuffer res = new StringBuffer();
       int temp = 0;
       while ((inputLine = br.readLine()) != null) {
         res.append(inputLine);
         if(temp == 1){
	         access_token = inputLine;
         }
       	 temp++;
       }
       br.close();
       if(responseCode==200) {
         /* out.println(res.toString()); */

       }
     } catch (Exception e) {
       System.out.println(e);
     }
    
    String str = access_token.replace("access_token", "");
    access_token = str.replace(":", "");
    str = access_token.replace("\"", "");
    access_token = str.replace(",", "");

	String token = access_token;// 네이버 로그인 접근 토큰;
    String header = "Bearer " + token; // Bearer 다음에 공백 추가
    try {
        apiURL = "https://openapi.naver.com/v1/nid/me";
        URL Nurl = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection)Nurl.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", header);
        int responseCode = con.getResponseCode();
        BufferedReader br;
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        String resStr = "";
        while ((inputLine = br.readLine()) != null) {
            resStr += inputLine;
        }

        br.close();
        String temp = resStr;
        JSONParser parser = new JSONParser();
        Object obj = parser.parse( temp );
        JSONObject jsonObj = (JSONObject) obj;
        JSONObject jsonRe = (JSONObject)jsonObj.get("response");
        
        String nid                  = "na_"+(String)jsonRe.get("id");
        String name                 = (String)jsonRe.get("name");
        String email                = (String)jsonRe.get("email");
        String enc_id                = (String)jsonRe.get("enc_id");
        String customerNum = "";
		int result = 0;

        request.setCharacterEncoding("euc-kr");
		String query1     = "";
			query1       += "SELECT EXISTS (SELECT * FROM ESL_MEMBER WHERE SNS_ACCESS_KEY ='"+enc_id+"')RESULT";
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
				query2       += "SELECT CUSTOMER_NUM FROM ESL_MEMBER WHERE SNS_ACCESS_KEY ='"+enc_id+"'";
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

	        String query		= "";
	        query		+= "SELECT IF("; 
	    	query		+= "		(SELECT MAX(CUSTOMER_NUM) FROM ESL_MEMBER) >= 100000000,"; 
	  		query		+= "		(SELECT MAX(CUSTOMER_NUM)+1 FROM ESL_MEMBER), ";
			query		+= "		100000000";
			query		+= ")CUSTOMER_NUM";
			pstmt		= conn.prepareStatement(query);
	        try {
	        	rs			= pstmt.executeQuery();
	        } catch(Exception e) {
	        	out.println(e+"=>"+query);
	        	if(true)return;
	        }
	        
	        if (rs.next()) {
	    		customerNum			= rs.getString("CUSTOMER_NUM");
	    	}
	        
	        try {
		    	String query2;
		    	query2		= "";
		    	query2     += "INSERT INTO ESL_MEMBER  (CUSTOMER_NUM, EMAIL ,MEM_NAME, MEM_ID, SEX, BIRTH_DATE, INST_DATE, SNS_ACCESS_KEY)";        
				query2     += "VALUES (?, ?, ?, ?, 'F', '19000101',?, ?)";
		    	pstmt		= conn.prepareStatement(query2);
		    	pstmt.setString(1, customerNum);
		    	pstmt.setString(2, email);
		    	pstmt.setString(3, name);
				pstmt.setString(4, nid);
				pstmt.setString(5, today);
				pstmt.setString(6, enc_id);
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
						pstmt.setString(3, nid);
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
		

		String userIp = request.getRemoteAddr();
		String query		= "UPDATE ESL_MEMBER SET LAST_LOGIN_DATE = NOW(),";
		query		+= "				LAST_LOGIN_IP = '"+ userIp +"'";
		query		+= "	WHERE MEM_ID = '"+ nid +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		
		//-- 장바구니 비움
		query = "DELETE FROM ESL_CART WHERE MEMBER_ID='" + nid + "'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		session.setAttribute("esl_member_id", nid);    
		session.setAttribute("esl_member_name", name);  
		session.setAttribute("esl_customer_num", customerNum);
		session.setAttribute("esl_member_code", ""); //통합회원 구분
		
		String returnUrl = (String)session.getAttribute("RETURN_URL");
		session.removeAttribute("RETURN_URL");
		if(returnUrl == null || "".equals(returnUrl)) returnUrl = "/";
		response.sendRedirect(returnUrl);


    } catch (Exception e) {
        System.out.println(e);
    }
  %>

</body>
</html>
