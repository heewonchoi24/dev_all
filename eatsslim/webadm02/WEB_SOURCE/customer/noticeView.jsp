<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_NOTICE";
int noticeId		= 0;
String query		= "";
String topYn		= "";
String title		= "";
String content		= "";
String instDate		= "";
String listImg		= "";
String param		= "";
String keyword		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String schCate		= ut.inject(request.getParameter("sch_cate"));
String field		= ut.inject(request.getParameter("field"));
if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param		= "&amp;page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	noticeId	= Integer.parseInt(request.getParameter("id"));

	query		= "UPDATE "+ table +" SET HIT_CNT = HIT_CNT + 1 WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, noticeId);
	pstmt.executeUpdate();
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

	query		= "SELECT TOP_YN, TITLE, CONTENT, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE";
	query		+= " FROM "+ table;
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, noticeId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		topYn			= rs.getString("TOP_YN");
		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
		instDate		= rs.getString("WDATE");
	}

	if (rs != null) try { rs.close(); } catch (Exception e) {}
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
} else {
	ut.jsBack(out);
	if (true) return;
}
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
			<h1>공지사항</h1>
			<div class="pageDepth">
				HOME &gt; 고객센터 &gt; <strong>공지사항</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li class="active"><a href="notice.jsp">공지사항</a></li>
						<li><a href="faq.jsp">FAQ</a></li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">1:1문의</a></li>
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
							<div class="share floatright">
								<ul>
									<li>
										<a class="facebook" href="http://www.facebook.com/share.php?u=http://www.eatsslim.com/shop/dietMeal.jsp" target="_blank"></a>
									</li>
									<li>
										<a class="twitter" href="http://twitter.com/share?url=http://www.eatsslim.com/shop/dietMeal.jsp&text=eatsslim diet" target="_blank"></a>
									</li>
									<li>
										<a class="me2day" href="http://me2day.net/posts/new?new_post[body]=http://www.eatsslim.com/shop/dietMeal.jsp" target="_blank"></a>
									</li>
								</ul>
							</div>
							<div class="clear"></div>
				</div>
			</div>
			<!-- End row -->
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<div class="noticeBbs">
						<div class="bbs-view">
							<span class="meta"><strong>DATE</strong> <%=instDate%></span>
							<span class="post-title">
								<h2><%=title%></h2>
							</span>
							<p><%=content%></p>
						</div>
					</div>
					<!-- End noticeBbs -->
					<table class="prenext" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="50">다음글</td>
							<td width="10"><img src="../images/arrow_next_top.png" width="7" height="5" alt="다음글" /></td>
							<td class="title">
								<%								
								query		= "SELECT ID, TITLE FROM "+ table +" WHERE ID > ? ORDER BY ID ASC LIMIT 0, 1";
								pstmt		= conn.prepareStatement(query);
								pstmt.setInt(1, noticeId);
								rs			= pstmt.executeQuery();
								
								if (rs.next()) {
								%>
								<a href="noticeView.jsp?id=<%=rs.getInt("ID") + param%>"><%=ut.cutString(50, rs.getString("TITLE"), "..")%></a>
								<%} else {%>
								다음글이 없습니다.
								<%
								}
								
								if (rs != null) try { rs.close(); } catch (Exception e) {}
								if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
								%>
							</td>
						</tr>
						<tr>
							<td>이전글</td>
							<td><img src="../images/arrow_pre_bottom.png" width="7" height="5" alt="이전글" /></td>
							<td class="title">
								<%
								query		= "SELECT ID, TITLE FROM "+ table +" WHERE ID < ? ORDER BY ID DESC LIMIT 0, 1";
								pstmt		= conn.prepareStatement(query);
								pstmt.setInt(1, noticeId);
								rs			= pstmt.executeQuery();
								
								if (rs.next()) {
								%>
								<a href="noticeView.jsp?id=<%=rs.getInt("ID") + param%>"><%=ut.cutString(70, rs.getString("TITLE"), "..")%></a>
								<%} else {%>
								이전글이 없습니다.
								<%}%>
							</td>
						</tr>
					</table>
				</div>
				<div class="button small dark floatright">
					<a href="notice.jsp?<%=param%>">목록</a>
				</div>
			</div>
			<!-- End row -->
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