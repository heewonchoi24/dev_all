<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_EVENT_WEEK_COMMENT";
int weekId			= 0;
String query		= "";
String stdate		= "";
String ltdate		= "";
String title		= "";
String content		= "";

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	weekId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT STDATE, LTDATE, TITLE, CONTENT";
	query		+= " FROM "+ table;
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, weekId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		stdate			= rs.getString("STDATE");
		ltdate			= rs.getString("LTDATE");
		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Cache-Control" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta name="robots" content="noindex,nofollow,noarchive">
<title>바른 다이어트 잇슬림</title>
<link rel="stylesheet" type="text/css" media="all" href="/common/css/layout.css" />
<link rel="stylesheet" type="text/css" media="all" href="/common/css/skeleton.css" />
<link rel="stylesheet" type="text/css" media="all" href="/common/css/color-theme.css" />
<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.selectBox.css" />
<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.lightbox.css" />
<link rel="stylesheet" type="text/css" media="print" href="/common/css/print.css" />
<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
<style>
.archive-title {
	position: relative;
	border-bottom: 1px solid #DEDEDE;
	padding: 10px;
}
.archive-pagenavi {
	position: absolute;
	width: 100%;
	left: 0;
	top: 13px;
}
.archive-pagenavi .prev {
	position: absolute;
	left: 10px;
	width: 25px;
	height: 25px;
}
.archive-pagenavi .next {
	position: absolute;
	right: 10px;
	width: 25px;
	height: 25px;
}
.archive-view {
	margin: 25px;
	text-align: left;
}
.dailylist {
	margin: 15px;
}
.dailylist li {
	float: left;
	margin-right: 15px;
}
.dailylist li a {
	text-align: center;
}
.dailylist li img {
	margin-bottom: 5px;
}
.dailylist li p {
	margin-bottom: 0;
}
</style>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>전문가 주간 코멘트</h2>
		<p></p>
	</div>
	<div class="contentpop">
		<div class="columns offset-by-one">
			<div class="row">
				<div class="one last col center">
					<div class="archive-title">
						<h3><%=stdate%> ~ <%=ltdate%> <%=title%></h3>
						<div class="archive-pagenavi">
							<%
							query		= "SELECT ID, TITLE FROM "+ table +" WHERE ID < ? ORDER BY ID DESC LIMIT 0, 1";
							pstmt		= conn.prepareStatement(query);
							pstmt.setInt(1, weekId);
							rs			= pstmt.executeQuery();
							
							if (rs.next()) {
							%>
							<a class="prev" href="week_comment.jsp?id=<%=rs.getInt("ID")%>">&lt;&lt;</a>
							<%} else {%>
							<a class="prev" href="javascript:;" onclick="alert('이전글이 없습니다.');">&lt;&lt;</a>
							<%
							}

							if (rs != null) try { rs.close(); } catch (Exception e) {}
							if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
							
							query		= "SELECT ID, TITLE FROM "+ table +" WHERE ID > ? ORDER BY ID ASC LIMIT 0, 1";
							pstmt		= conn.prepareStatement(query);
							pstmt.setInt(1, weekId);
							rs			= pstmt.executeQuery();
							
							if (rs.next()) {
							%>
							<a class="next" href="week_comment.jsp?id=<%=rs.getInt("ID")%>">&gt;&gt;</a>
							<%} else {%>
							<a class="next" href="javascript:;" onclick="alert('다음글이 없습니다.');">&gt;&gt;</a>
							<%
							}
							%>
						</div>
					</div>
					<div class="archive-view">
						<p><%=content%></p>
					</div>
				</div>
			</div>
			<!-- End row -->
		</div>
		<!-- End popup columns offset-by-one -->
	</div>
	<!-- End contentpop -->
</div>
</body>
</html>
<%}%>
<%@ include file="/lib/dbclose.jsp" %>