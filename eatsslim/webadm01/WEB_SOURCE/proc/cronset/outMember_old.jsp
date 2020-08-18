<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_mssql.jsp" %>
<%
int cnt=0;
String query		= "";
String sqlquery		= "";
String sql			= "";
Statement stmt2		= null;
stmt2				= conn.createStatement();

query="select mem_id,customer_num,mem_name from ESL_MEMBER";

try{rs = stmt.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
while(rs.next()){
	
	
	//sqlquery="SELECT TOP 1";
	//sqlquery+=" DEREG_APP_YN";
	//sqlquery+=" FROM pulmuone.dbo.ITF_MEMBER_INFO_FNC('0002400000', '146030') A where A.MEM_ID='"+rs.getString("mem_id")+"'";
	
	sqlquery="SELECT TOP 1";
	sqlquery+=" DEREG_APP_YN";
	sqlquery+=" FROM member_info A WITH(NOLOCK), site_used_yn B WITH(NOLOCK) ";
	sqlquery+=" WHERE A.customer_num = B.customer_num ";
	sqlquery+=" AND B.site_no = '0002400000' and A.MEM_ID='"+rs.getString("mem_id")+"'";
	
	try{rs_mssql = stmt_mssql.executeQuery(sqlquery);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
	if(rs_mssql.next()){
		if(rs_mssql.getString("DEREG_APP_YN").equals("Y")){ //탈퇴회원이라면
			cnt++;
			sql="insert into ESL_MEMBER_LEAVE (id,mem_id,customer_num,mem_name,actor,reason,ip,inst_date,memo)values(";
			sql+="null";
			sql+=",'"+rs.getString("mem_id")+"'";
			sql+=",'"+rs.getString("customer_num")+"'";
			sql+=",'"+rs.getString("mem_name")+"'";
			sql+=",'자동'";
			sql+=",'통합회원탈퇴'";
			sql+=",''";
			sql+=",now()";
			sql+=",''";
			sql+=")";
			try{stmt2.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}

			sql="update ESL_MEMBER set dereg_yn = 'Y' where mem_id='"+rs.getString("mem_id")+"'";
			//out.println(String.valueOf(cnt)+": "+sql+"<br><br>");
			try{stmt2.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}
		}
	}else{
		out.println("회원없음 "+sqlquery+"<br><br>");
	}
	rs_mssql.close();	
}

if(stmt2 != null) try { stmt2.close(); } catch(Exception ignore) {}	

rs.close();


%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_mssql.jsp" %>