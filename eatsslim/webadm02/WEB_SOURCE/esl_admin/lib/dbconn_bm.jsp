<%
/**
 * @file : dbconn_bm.jsp
 * @date : 2013-09-03
 * @author : Kim Hyungseok
 */
%>
<%@ page import="java.sql.*"%>
<%
    Connection conn_bm			= null;
	Statement stmt_bm			= null; 
	ResultSet rs_bm				= null; 
	PreparedStatement pstmt_bm	= null;
	
	String driverName_bm		= "oracle.jdbc.driver.OracleDriver";
    String url_bm				= "jdbc:oracle:thin:@222.231.17.48:1521:BABYMEAL";
    String id_bm				= "BABYMEAL";
    String pwd_bm				= "BABYMEAL1234";
    
    try {
        Class.forName(driverName_bm);      
    } catch(ClassNotFoundException e) {
        out.println("DB 연결 에러");
        e.printStackTrace();
        return;
    }
      
    conn_bm = DriverManager.getConnection(url_bm,id_bm,pwd_bm);
	stmt_bm = conn_bm.createStatement();
%>