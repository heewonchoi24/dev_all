<%
/**
 * @file : dbconn_phi.jsp
 * @date : 2013-09-03
 * @author : Kim Hyungseok
 */
%>
<%@ page import="java.sql.*"%>
<%
    Connection conn_phi			= null;
	Statement stmt_phi			= null; 
	ResultSet rs_phi			= null; 
	PreparedStatement pstmt_phi	= null;
	
	String driverName_phi		= "oracle.jdbc.driver.OracleDriver";
    String url_phi				= "jdbc:oracle:thin:@192.1.5.163:1540:GWD";
    String id_phi				= "ESSMALL";
    String pwd_phi				= "ESSMALL1234";
    
    try {
        Class.forName(driverName_phi);      
    } catch(ClassNotFoundException e) {
        out.println("DB 연결 에러");
        e.printStackTrace();
        return;
    }
      
    conn_phi = DriverManager.getConnection(url_phi,id_phi,pwd_phi);
	stmt_phi = conn_phi.createStatement();
%>