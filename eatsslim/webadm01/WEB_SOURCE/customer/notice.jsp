<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String table		= "ESL_NOTICE";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject2(request.getParameter("keyword"));
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

//where			= " WHERE 1=1 AND top_yn = 'Y'";
where			= " WHERE 1=1 ";

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
	//where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
	where		+= " AND "+ field +" LIKE ?";
}

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	pstmt.setString(1, "%"+ keyword +"%");
}
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
if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	pstmt.setString(1, "%"+ keyword +"%");
}
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
			<div class="pageDepth">
				<span>HOME</span><span>고객센터</span><strong>공지사항</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="twelve columns offset-by-one">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li class="active"><a href="notice.jsp">공지사항</a></li>
						<li><a href="faq.jsp">FAQ</a></li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">1:1문의</a></li>
						<%} else {%>
						<li><a href="indiqna.jsp">1:1문의</a></li>
						<%}%>
						<li><a href="service_member.jsp">이용안내</a></li>
						<li><a href="presscenter.jsp">언론보도</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<form name="frm_search" method="get" action="<%=request.getRequestURI()%>">
						<div class="searchBar floatleft">
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
						<div class="result floatright">
							<select name="pgsize" onchange="this.form.submit()">
								<option value="10"<%if(pgsize==10)out.print(" selected");%>>10개씩보기</option>
								<option value="20"<%if(pgsize==20)out.print(" selected");%>>20개씩보기</option>
								<option value="30"<%if(pgsize==30)out.print(" selected");%>>30개씩보기</option>
								<option value="100"<%if(pgsize==100)out.print(" selected");%>>100개씩보기</option>
							</select>
						</div>
					</form>
				</div>
			</div>
			<!-- End row -->
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<div class="noticeBbs">
						<ul>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									noticeId	= rs.getInt("ID");
									topYn		= (rs.getString("TOP_YN").equals("Y"))? " class=\"headline\"" : "";
									title		= rs.getString("TITLE");
									content		= ut.delHtmlTag(rs.getString("CONTENT"));
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
							<li<%=topYn%>>
								<a href="noticeView.jsp?id=<%=noticeId + param%>" title="<%=title%>">
									<%=imgUrl%>
									<span class="meta"><strong>NO.</strong> <%=curNum%></span>
									<span class="meta"><strong>DATE</strong> <%=instDate%></span>
									<span class="post-title">
										<h2><%=ut.cutString(maxLength, title, "")%></h2>
										<p><%=ut.cutString(maxLength * 3, content, "..")%></p>
									</span>
								</a>
							</li>
							<%
									curNum--;
								}
							} else {
							%>
							<li>등록된 공지사항이 없습니다.</li>
							<%
							}
							%>
						</ul>
					</div>
					<!-- End noticeList -->
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
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>
