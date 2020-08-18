<%
/**
 * @file : dbconn_phi.jsp
 * @date : 2013-09-03
 * @author : Kim Hyungseok
 */
%>
<%@ page import="java.sql.*"%>
<%
    Connection conn_phi2			= null;
	Statement stmt_phi2				= null; 
	ResultSet rs_phi2				= null; 
	PreparedStatement pstmt_phi2	= null;
	
	String driverName_phi2		= "oracle.jdbc.driver.OracleDriver";
    String url_phi2					= "jdbc:oracle:thin:@172.17.1.130:1521:PHLO";
    String id_phi2					= "babymeal";
    String pwd_phi2				= "babymeal1234";
    
    try {
        Class.forName(driverName_phi2);      
    } catch(ClassNotFoundException e) {
        out.println("DB 연결 에러");
        e.printStackTrace();
        return;
    }
      
    conn_phi2 = DriverManager.getConnection(url_phi2,id_phi2,pwd_phi2);
	stmt_phi2 = conn_phi2.createStatement();
%>