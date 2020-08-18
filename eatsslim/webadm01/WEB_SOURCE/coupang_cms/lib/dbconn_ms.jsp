<%@ page import = "java.sql.* ,javax.naming.* , javax.sql.*, java.util.Properties" %>
<%
	Connection con_mssql=null;
	Statement stmt_mssql=null; 
	ResultSet rs_mssql=null; 

	
	String db_url_mssql ="";
	String db_id_mssql = "";
	String db_pass_mssql = "";				
	

	try {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");		
	} catch (ClassNotFoundException e) {
		out.println("DB connection error 1 : "+e.getMessage());if(true)return;
	}
	try {
		con_mssql =  DriverManager.getConnection(db_url_mssql,db_id_mssql,db_pass_mssql);
		stmt_mssql = con_mssql.createStatement();
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println("DB connection error 2 : "+e.getMessage());if(true)return;
	}

%>