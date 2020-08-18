<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_mssql.jsp" %>
<%

String query		= "";
String sqlquery		= "";
String sql			= "";
String deregDate	= "";
String memid		= "";

SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
Calendar cal	= Calendar.getInstance();
cal.setTime(new Date());
cal.add(Calendar.DATE, -1);
deregDate		= dt.format(cal.getTime());

/*
sqlquery="	SELECT M.mem_id, M.customer_num";
sqlquery+="		FROM MEMBER_INFO M ";
sqlquery+="		, SITE_USED_YN S ";
sqlquery+="		, DEREG_MEMBER_INFO D";
sqlquery+=" 	WHERE  M.CUSTOMER_NUM = S.CUSTOMER_NUM";
sqlquery+="			AND D.CUSTOMER_NUM = S.CUSTOMER_NUM";
sqlquery+="			AND S.SITE_NO     = '0002400000'";
sqlquery+="			AND D.DEREG_DONE_DATE >= '"+deregDate+"'";
*/

sqlquery="	SELECT customer_num";
sqlquery+="		FROM TRIGGER_SITE_USED_YN_LOG M ";
sqlquery+=" 	WHERE LOG_IDX in (";
sqlquery+="			SELECT MAX(LOG_IDX)";
sqlquery+="			FROM TRIGGER_SITE_USED_YN_LOG";
sqlquery+="			WHERE SITE_NO = '0002400000'";
sqlquery+="			AND REG_DATE >= '"+deregDate+"'";
sqlquery+="			GROUP BY CUSTOMER_NUM)  ";
sqlquery+="		AND SITE_USE = 'N'";

try{rs_mssql = stmt_mssql.executeQuery(sqlquery);}catch(Exception e){out.println(e+"=>"+sqlquery);if(true)return;}
while(rs_mssql.next()){
	query="select mem_id,customer_num,mem_name from ESL_MEMBER where customer_num = '"+rs_mssql.getString("customer_num")+"'";
	
	try{rs = stmt.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
	if (rs.next()){
		
		memid = rs.getString("mem_id");
	
		sql="insert into ESL_MEMBER_LEAVE (mem_id,customer_num,mem_name,actor,reason,ip,inst_date,memo)values(";
		//sql+="null";
		sql+="'"+memid+"'";
		sql+=",'"+rs.getString("customer_num")+"'";
		sql+=",'"+rs.getString("mem_name")+"'";
		sql+=",'ÀÚµ¿'";
		sql+=",'ÅëÇÕÈ¸¿øÅ»Åð'";
		sql+=",''";
		sql+=",now()";
		sql+=",''";
		sql+=")";
		try{stmt.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}

		//sql="update ESL_MEMBER set dereg_yn = 'Y' where mem_id='"+memid+"'";
		sql="delete from ESL_MEMBER where mem_id='"+memid+"'";
		try{stmt.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}
	}

}


%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_mssql.jsp" %>