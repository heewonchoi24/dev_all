<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_tbr.jsp"%>
<%
request.setCharacterEncoding("EUC-KR");

String dvLevel=ut.inject(request.getParameter("dvLevel"));
String code=ut.inject(request.getParameter("code"));
String pcode=ut.inject(request.getParameter("pcode"));
String query			= "";
String data = "";

//out.println(dong);if(true)return;

if(dvLevel.equals("1")){ //2Â÷
	query="select code, codename from V_CLAIM_GB where CODE_LEVEL = 2 and parentcode='"+code+"' and USE_YN = 'Y' order by code asc";
}else if(dvLevel.equals("2")){ //3Â÷
	query="select code, codename from V_CLAIM_GB where CODE_LEVEL = 3 and parentcode='"+pcode+"' and PARENTCODE2 = '"+code+"' and USE_YN = 'Y' order by code asc";
}


data = "<group>";

if(!query.equals("")){
	try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
	while(rs_tbr.next()){
		//out.println(rs_tbr.getString("code")+"|"+rs_tbr.getString("codename")+"@");
		data		+= "<![CDATA["+rs_tbr.getString("code")+"]]>|<![CDATA["+rs_tbr.getString("codename")+"]]>@";
	}
	rs_tbr.close();
}

data += "</group>";
code= "success";
out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose_tbr.jsp" %>
<%@ include file="/lib/dbclose.jsp" %>
