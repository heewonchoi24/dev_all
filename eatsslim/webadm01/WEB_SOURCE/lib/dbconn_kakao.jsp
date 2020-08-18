<%
/**
 * @file : dbconn_kakao.jsp
 * @date : 2013-09-03
 * @author : Kim Hyungseok
 */
%>
<%@ page import="java.sql.*"%>
<%
    Connection conn_kakao				= null;
	Statement stmt_kakao				= null; 
	ResultSet rs_kakao					= null; 
	PreparedStatement pstmt_kakao	= null;
	
	String driverName_kakao		= "oracle.jdbc.driver.OracleDriver";
    String url_kakao				= "jdbc:oracle:thin:@172.17.1.77:1521:CRM";
    String id_kakao				= "kakao_es";
    String pwd_kakao				= "kakao_es_2016";
    
    try {
        Class.forName(driverName_kakao);      
    } catch(ClassNotFoundException e) {
        out.println("DB 연결 에러");
        e.printStackTrace();
        return;
    }
      
    conn_kakao = DriverManager.getConnection(url_kakao,id_kakao,pwd_kakao);
	stmt_kakao = conn_kakao.createStatement();
%>