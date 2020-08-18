<%
/**
 * @file : dbconn_tbr.jsp
 * @date : 2014-05-09
 * @author : Kim Hyungseok
 */
%>
<%@ page import="java.sql.*"%>
<%
    Connection conn_tbr			= null;
	Statement stmt_tbr			= null; 
	ResultSet rs_tbr			= null; 
	PreparedStatement pstmt_tbr	= null;

	
	String driverName_tbr		= "com.tmax.tibero.jdbc.TbDriver";
    String url_tbr				= "jdbc:tibero:thin:@192.1.5.205:8629:ECSDB";
    String id_tbr				= "ECS_IF_USER";
    String pwd_tbr				= "ECS_IF_USER";
    
    try {
        Class.forName(driverName_tbr);      
    } catch(ClassNotFoundException e) {
        out.println("DB 연결 에러");
        e.printStackTrace();
        return;
    }
      
    conn_tbr = DriverManager.getConnection(url_tbr,id_tbr,pwd_tbr);
	stmt_tbr = conn_tbr.createStatement();
%>