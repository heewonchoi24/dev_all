<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String table		= "ESL_NOTICE";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
int noticeId		= 0;
String topYn		= "";
String title		= "";
String content		= "";
String listImg		= "";
String imgUrl		= "";
int maxLength		= 0;
String instDate		= "";

///////////////////////////
int pgsize		= 3; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int iPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;

where			= " WHERE 1=1";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //총 레코드 수
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // 총 페이지 수


endpage		= startpage + pagelist - 1;
if (endpage > totalPage) {
	endpage = totalPage;
}
curNum		= intTotalCnt-pgsize*(iPage-1);
param		+= "&amp;pgsize=" + pgsize;

query		= "SELECT ID, TOP_YN, TITLE, CONTENT, LIST_IMG, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE";
query		+= " FROM "+ table + where;
query		+= " ORDER BY TOP_YN DESC, ID DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>

<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/jquery-ui.css" />
<script src="/mobile/common/js/jquery-ui.js"></script>

</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content" class="oldClass">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">고객센터</span></span></h1>
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/customer/notice.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">공지사항</span></span><span class="active"></span></a></td>
					<td><a href="/mobile/customer/indiqna.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">1:1문의하기</span></span></a></td>
				</tr>
			</table>
		</div>
		<div id="accordion" class="row">
			<%
			if (intTotalCnt > 0) {
				while (rs.next()) {
					noticeId	= rs.getInt("ID");
					topYn		= (rs.getString("TOP_YN").equals("Y"))? " class=\"headline\"" : "";
					title		= rs.getString("TITLE");
					content		= rs.getString("CONTENT");
					listImg		= rs.getString("LIST_IMG");
					if (!listImg.equals("")) {
						imgUrl		= "<img class=\"thumbleft\" src=\""+ webUploadDir +"board/"+ listImg +"\" width=\"160\" height=\"108\" title=\""+ title +"\" />";
						maxLength	= 50;
					} else {
						imgUrl		= "";
						maxLength	= 70;
					}
					instDate	= rs.getString("WDATE");
			%>
			<h3><%=title%><!-- <div class="meta">09.25</div> --></h3>
			<div>
				<p><%=content%>
				<div class="meta">
					<%=instDate%>
				</div>
				</p>
			</div>
			<%
					curNum--;
				}
			} else {
			%>
			<%
			}
			%>
		</div>
		<div class="grid-navi">
			<% if(totalPage > 1){ %>
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td>
						<%if (iPage == 1) {%>
						<a href="javascript:;" onClick="alert('이전글이 없습니다.');" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">< 이전글</span></span></a>
						<%} else {%>
						<a href="<%=request.getRequestURI()%>?page=<%=iPage-1%>" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text"><< 이전페이지</span></span></a>
						<%}%>
					</td>
					<td>
						<%if (iPage >= totalPage) {%>
						<a href="javascript:;" onClick="alert('다음글이 없습니다.');" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">다음글 ></span></span></a>
						<%} else {%>
						<a href="<%=request.getRequestURI()%>?page=<%=iPage+1%>" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">다음페이지 >></span></span></a>
						<%}%>
					</td>
				</tr>
			</table>
			<% } %>
		</div>
	</div>
	<!-- End Content -->
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
<script>
$(function() {
	$( "#accordion" ).accordion({
		heightStyle: "content",
		collapsible: true
	});
});
</script>
</body>
</html>