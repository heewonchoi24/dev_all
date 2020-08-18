<%
/**
 * @file : dbconn_mssql.jsp
 * @date : 2013-09-03
 * @author : Kim Hyungseok
 */
%>
<%@ page import="java.sql.*"%>
<%
    Connection conn_mssql			= null;
	Statement stmt_mssql			= null; 
	ResultSet rs_mssql				= null; 
	PreparedStatement pstmt_mssql	= null;
	
	String driverName_mssql			= "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    String url_mssql				= "jdbc:sqlserver://192.1.5.39:1433;databaseName=PULMUONE";
	String id_mssql					= "ecmdfd";
	String pwd_mssql				= "ecmdfd1234";
/*
	String id_mssql					= "eatsslim";
	String pwd_mssql				= "eatsslim2013";
*/
    
    try {
        Class.forName(driverName_mssql);      
    } catch(ClassNotFoundException e) {
        out.println("DB 연결 에러");
        e.printStackTrace();
        return;
    }
      
    conn_mssql = DriverManager.getConnection(url_mssql,id_mssql,pwd_mssql);
	stmt_mssql = conn_mssql.createStatement();
%>