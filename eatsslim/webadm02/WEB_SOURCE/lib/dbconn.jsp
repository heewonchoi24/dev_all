<%
/**
 * @file : dbconn.jsp
 * @date : 2013-08-20
 * @author : Kim Hyungseok
 */
%>
<%@ page import="java.sql.*"%>
<%
    Connection conn			= null;
	Statement stmt			= null; 
	ResultSet rs			= null; 
	PreparedStatement pstmt	= null;

	
	String driverName		= "com.mysql.jdbc.Driver";
    String url				= "jdbc:mysql://localhost:3306/pulmuone_esl";
    String id				= "eatsslim";
    String pwd				="dlttmffla!@#";
    
    try {
        Class.forName(driverName);      
    } catch(ClassNotFoundException e) {
        out.println("DB 연결 에러");
        e.printStackTrace();
        return;
    }
      
    conn = DriverManager.getConnection(url,id,pwd);
	stmt = conn.createStatement();
%>