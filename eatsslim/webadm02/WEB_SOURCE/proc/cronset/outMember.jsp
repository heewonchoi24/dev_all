<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_mssql.jsp" %>
<%

String query		= "";
String sqlquery		= "";
String sql			= "";
String deregDate	= "";

SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
Calendar cal	= Calendar.getInstance();
cal.setTime(new Date());
cal.add(Calendar.DATE, -1);
deregDate		= dt.format(cal.getTime());


sqlquery="	SELECT M.mem_id, M.customer_num";
sqlquery+="		FROM MEMBER_INFO M ";
sqlquery+="		, SITE_USED_YN S ";
sqlquery+="		, DEREG_MEMBER_INFO D";
sqlquery+=" 	WHERE  M.CUSTOMER_NUM = S.CUSTOMER_NUM";
sqlquery+="			AND D.CUSTOMER_NUM = S.CUSTOMER_NUM";
sqlquery+="			AND S.SITE_NO     = '0002400000'";
sqlquery+="			AND D.DEREG_DONE_DATE >= '"+deregDate+"'";

try{rs_mssql = stmt_mssql.executeQuery(sqlquery);}catch(Exception e){out.println(e+"=>"+sqlquery);if(true)return;}
while(rs_mssql.next()){
	
	query="select mem_id,customer_num,mem_name from ESL_MEMBER where mem_id = '"+rs_mssql.getString("mem_id")+"'";
	
	try{rs = stmt.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
	if (rs.next()){
	
		sql="insert into ESL_MEMBER_LEAVE (id,mem_id,customer_num,mem_name,actor,reason,ip,inst_date,memo)values(";
		sql+="null";
		sql+=",'"+rs.getString("mem_id")+"'";
		sql+=",'"+rs.getString("customer_num")+"'";
		sql+=",'"+rs.getString("mem_name")+"'";
		sql+=",'ÀÚµ¿'";
		sql+=",'ÅëÇÕÈ¸¿øÅ»Åð'";
		sql+=",''";
		sql+=",now()";
		sql+=",''";
		sql+=")";
		try{stmt.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}

		//sql="update ESL_MEMBER set dereg_yn = 'Y' where mem_id='"+rs_mssql.getString("mem_id")+"'";
		sql="delete from ESL_MEMBER where mem_id='"+rs.getString("mem_id")+"'";
		try{stmt.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}
	}
	rs.close();

}


%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_mssql.jsp" %>