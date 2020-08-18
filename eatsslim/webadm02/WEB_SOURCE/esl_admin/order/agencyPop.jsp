<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
String addSql			="where 1=1 ";
String keyWord			= "";
String Search			= "";
if (request.getParameter("Search") != null){Search = ut.inject(request.getParameter("Search"));}

i				=1;

if (request.getParameter("keyWord") != null && request.getParameter("keyWord").length()>0){
	keyWord = ut.inject(request.getParameter("keyWord"));	
	addSql += " and (agency_name like '%"+keyWord+"%' OR agency_id like '%"+keyWord+"%') ";
}

query		= "SELECT AGENCY_NAME, AGENCY_ID";
query		+= " FROM ESL_ORDER_DEVL_AGENCY " + addSql;
//query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";

try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>관리자시스템</title>
<style type="text/css">
html, body { height:auto; background:#fff;}

.btn_center { position:relative; margin-top:15px; text-align:center;}
.td_center { padding-left:0; padding-right:0; text-align:center;}
</style>
<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>

<script type="text/javascript">

function selection(trNum) {

	$("#agcycode", opener.document).val(trNum);		
	
	self.close();

}

</script>

</head>
<body onload="document.search_call.keyWord.focus();">
	<!-- popup_wrap -->
		<form method="post" name="search_call" action="<%=request.getRequestURI()%>">
		<input type="hidden" name="mode" value="search">
		<input type="hidden" name="m_no">
		<h2>가맹점검색</h2>
		<table border="1" cellspacing="0">
			<colgroup>
			<col width="40%" />
			<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">
						<span>
							<select name="Search" style="width:80px;" onchange="this.form.keyWord.focus()">
								<option value="name" <%if(Search.equals("name")){out.print("selected");}%>>이름</option>
								<option value="m_id" <%if(Search.equals("m_id")){out.print("selected");}%>>코드</option>				
							</select>
						</span>
					</th>
					<td>
						<input type="text" class="input1" style="width:188px;" maxlength="30" onfocus="this.select()" name="keyWord" value="<%=keyWord%>" />
					</td>

				</tr>
			
				</tbody>
		</table>
		<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="검색" /></p>

		<table width="100%" border="1" cellspacing="0">
			<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th class="td_center">No</th>
					<th class="td_center">배달점명</th>
					<th class="td_center">코드값</th>
				</tr>
			</thead>
			<tbody>
<%
	while (rs.next()) 
	{

%>
				<tr>
					<td class="td_center"><%=i%></td>
					<td class="td_center"><%=rs.getString("AGENCY_NAME")%></td>
					<td class="td_center"><a href="javascript:selection('<%=rs.getString("AGENCY_ID")%>')"><%=rs.getString("AGENCY_ID")%></a></td>
				</tr>
<%
		i++;
	}
		
	if (i == 1) {
		out.println("<tr><td height='30'  colspan='3' class='td_center'>검색 내용이 없습니다.</td></tr>");
	}
%> 
			</tbody>
		</table>
		</form>


</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>