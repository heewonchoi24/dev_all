<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String table		= "ESL_FAQ";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
int faqId			= 0;
int fviewId			= 0;
String schType		= ut.inject(request.getParameter("sch_type"));
String title		= "";
String content		= "";

///////////////////////////
int pgsize		= 10; //페이지당 게시물 수
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

if (request.getParameter("id") != null && request.getParameter("id").length()>0)
	fviewId		= Integer.parseInt(request.getParameter("id"));

if (schType != null && schType.length()>0) {
	param		+= "&amp;sch_type="+ schType;
	where		+= " AND FAQ_TYPE = '"+ schType +"'";
}

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

query		= "SELECT ID, TITLE, CONTENT";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ID DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>FAQ</h1>
			<div class="pageDepth">
				HOME &gt; 고객센터 &gt; <strong>FAQ</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li><a href="notice.jsp">공지사항</a></li>
						<li class="active"><a href="faq.jsp">FAQ</a></li>
						<li><a href="indiqna.jsp">1:1문의</a></li>
						<li><a href="service_member.jsp">이용안내</a></li>
						<li><a href="presscenter.jsp">언론보도</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<form name="frm_search" method="get" action="<%=request.getRequestURI()%>">
						<ul class="listSort">
							<li>
								<%if (schType.equals("01")) {%>
								<span class="current">교환/환불</span>
								<%} else {%>
								<a href="faq.jsp?sch_type=01">교환/환불</a>
								<%}%>
							</li>
							<li>
								<%if (schType.equals("02")) {%>
								<span class="current">회원관련</span>
								<%} else {%>
								<a href="faq.jsp?sch_type=02">회원관련</a>
								<%}%>
							</li>
							<li>
								<%if (schType.equals("03")) {%>
								<span class="current">주문/결제</span>
								<%} else {%>
								<a href="faq.jsp?sch_type=03">주문/결제</a>
								<%}%>
							</li>
							<li>
								<%if (schType.equals("04")) {%>
								<span class="current">배송관련</span>
								<%} else {%>
								<a href="faq.jsp?sch_type=04">배송관련</a>
								<%}%>
							</li>
							<li>
								<%if (schType.equals("09")) {%>
								<span class="current">기타</span>
								<%} else {%>
								<a href="faq.jsp?sch_type=09">기타</a>
								<%}%>
							</li>
						</ul>
						<div class="searchBar floatright">
							<label>
								<select name="field" id="field" style="width:70px;" onchange="this.form.keyword.focus()">
									<option value="TITLE"<%if(field.equals("TITLE")){out.print(" selected=\"selected\"");}%>>제목</option>
									<option value="CONTENT"<%if(field.equals("CONTENT")){out.print(" selected=\"selected\"");}%>>내용</option>
								</select>
							</label>
							<label>
								<input type="text" name="keyword" maxlength="30" value="<%=keyword%>" onfocus="this.select()" />
							</label>
							<label>
								<input type="submit" class="button dark small" name="button" value="검색">
							</label>
						</div>
					</form>
				</div>
			</div>
			<!-- End row -->
			<input type="hidden" id="fview_id" value="fview_<%=fviewId%>" />
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<div class="postList customer">
						<ul class="boardStyle">
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									faqId		= rs.getInt("ID");
									title		= rs.getString("TITLE");
									content		= rs.getString("CONTENT");
							%>
							<li>
								<a href="javascript:;">
									<span class="post-subject">
										<span class="qa">Q.</span>
										<%=title%>
									</span>
								</a>
								<div class="post-view" id="fview_<%=faqId%>">
									<div class="post-view-comment">
										<div class="re-title"><%=title%></div>
										<p><%=content%></p>
									</div>
								</div>
							</li>
							<%
									curNum--;
								}
							} else {
							%>
							<li>등록된 FAQ가 없습니다.</li>
							<%
							}
							%>
						</ul>
					</div>
					<!-- End postList -->
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="threefourth last col">
					<%@ include file="../common/include/inc-paging.jsp"%>
				</div>
			</div>
		</div>
		<!-- End twelve columns offset-by-one -->
		<div class="sidebar four columns">
			<%@ include file="/common/include/inc-sidecustomer.jsp"%>
		</div>
		<!-- End sidebar four columns -->
		<div class="clear"></div>
	</div>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$(".boardStyle div.post-view").hide();
	if ($("#fview_id").val()) {
		var fviewId		= $("#fview_id").val();
		$(".boardStyle div.post-view").slideUp(200);
		$("#" + fviewId).slideToggle(200);
	}
	$(".boardStyle a").click(function(){
		var faq_id	= $(this).next("div").attr("id");
		$.post("faq_ajax.jsp", {
			mode: "upd",
			id: faq_id.replace("fview_", "")
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					$(".boardStyle div.post-view").slideUp(200);
					$("#" + faq_id).slideToggle(200);
				} else {
					$(data).find("error").each(function() {
						alert($(this).text());
					});
				}
			});
		}, "xml");
		return false;
	})	
})
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>