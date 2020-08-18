<%
/**
 * @file : dbconn_header.jsp
 * @date : 2018-11-14
 * @author : Choi Heewon
 */
%>
<%@ page import="java.sql.*"%>
<%
    Connection conn2_header		     = null;
	Statement stmt2_header			 = null; 
	ResultSet rs2_header			 = null; 
	PreparedStatement pstmt2_header  = null;
	
	String driverName2_header		 = "com.mysql.jdbc.Driver";
    String url2_header				 = "jdbc:mysql://localhost:3306/pulmuone_esl";
    String id2_header				 = "eatsslim";
    String pwd2_header				 = "dlttmffla!@#";
    
    try {
        Class.forName(driverName2_header);      
    } catch(ClassNotFoundException e) {
        out.println("DB 연결 에러");
        e.printStackTrace();
        return;
    }
      
    conn2_header = DriverManager.getConnection(url2_header,id2_header,pwd2_header);
	stmt2_header = conn2_header.createStatement();
%>