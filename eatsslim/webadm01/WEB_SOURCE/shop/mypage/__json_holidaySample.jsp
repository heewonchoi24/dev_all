<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ include file="/lib/config.jsp"%>

<%
System.out.println("kkkkk");
String query	= "";
//Statement stmt7	= conn.createStatement();;
//ResultSet rs2		= null;

Calendar cal		= Calendar.getInstance();
int nowYear			= cal.get(Calendar.YEAR);
int nowMonth		= cal.get(Calendar.MONTH)+1;
int year			= nowYear;
int month			= nowMonth;

String chkMonth		= "";
String holiday      = "";
String holidayName  = "";

List<Map<String,Object>> dataList				 = new ArrayList();
Map<String,Object> dataMap						 = new HashMap();


query		= "SELECT DATE_FORMAT(HOLIDAY, '%Y-%m-%d') HOLIDAY, HOLIDAY_NAME";
query		+= " FROM ESL_SYSTEM_HOLIDAY WHERE DATE_FORMAT(HOLIDAY, '%Y') =  '"+ year  + "' AND DATE_FORMAT(HOLIDAY, '%m') =  '08' AND HOLIDAY_TYPE = '02' ";
query		+= " ORDER BY HOLIDAY DESC, ID DESC";

try {
	System.out.println("query >> " + query);
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if(rs.next()){
	System.out.println("aaaaa");
}else{
	System.out.println("bbbbb");
}

while (rs.next()) {
	System.out.println("jj22222");
	dataMap		 = new HashMap();
	holiday		= rs.getString("HOLIDAY");
	holidayName	= rs.getString("HOLIDAY_NAME");
	dataMap.put("date",holiday);
	dataMap.put("title",holidayName);
	dataList.add(dataMap);
}

rs.close();

JSONObject list = new JSONObject();
list.put("data",dataList);
out.clear();
out.println(list);
out.flush();
%>