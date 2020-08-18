<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
int eventId				= 0;
if (request.getParameter("id") != null && request.getParameter("id").length() > 0)
	eventId	= Integer.parseInt(request.getParameter("id"));
String title		= "";
String ancDate		= "";
String winner		= "";

query		= "SELECT TITLE, DATE_FORMAT(ANC_DATE, '%Y.%m.%d') ANC_DATE, WINNER FROM ESL_EVENT WHERE ID = "+ eventId;
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if (true) return;
}

if (rs.next()) {
	title		= rs.getString("TITLE");
	ancDate		= ut.isnull(rs.getString("ANC_DATE"));
	winner		= ut.isnull(rs.getString("WINNER"));
}

rs.close();
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>당첨자발표</title>
	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/style.css">
</head>
<body>
<div class="pop-wrap winnerPopup">
	<div class="headpop">
		<h2>당첨자 발표</h2>
		<!-- <h5 class="mart5 marb5"><%=title%></h5>
		<p class="meta">당첨자발표 : <%=ancDate%></p> -->
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<%=winner%>
			</div>
			<!-- End row -->
		</div>
		<!-- End popup columns offset-by-one -->
	</div>
	<!-- End contentpop -->
</div>
</body>
</html>