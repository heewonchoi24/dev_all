<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_PRESS";
int pressId			= 0;
String query		= "";
String title		= "";
String content		= "";
String instDate		= "";
String listImg		= "";
String param		= "";
String keyword		= ut.inject2(request.getParameter("keyword"));
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String schCate		= ut.inject(request.getParameter("sch_cate"));
String field		= ut.inject2(request.getParameter("field"));

if (!ut.isNaN(iPage)) {
	iPage = "1";
}
if (!ut.isNaN(pgsize)) {
	pgsize = "12";
}

if (keyword != null) {
	keyword				= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	pressId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT TITLE, CONTENT, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE";
	query		+= " FROM "+ table;
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, pressId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
		instDate		= rs.getString("WDATE");
	}
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
			<div class="pageDepth">
				<span>Ȩ</span><span>������</span><strong>��к���</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li><a href="notice.jsp">��������</a></li>
						<li><a href="faq.jsp">FAQ</a></li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">1:1����</a></li>
						<%} else {%>
						<li><a href="indiqna.jsp">1:1����</a></li>
						<%}%>
						<li><a href="service_member.jsp">�̿�ȳ�</a></li>
						<li class="active"><a href="presscenter.jsp">��к���</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<div class="share floatright">
						share ��ư �۾� ����
					</div>
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
							<td width="50">������</td>
							<td width="10"><img src="../images/arrow_next_top.png" width="7" height="5" alt="������" /></td>
							<td class="title">
								<%
								query		= "SELECT ID, TITLE FROM "+ table +" WHERE ID > ? ORDER BY ID ASC LIMIT 0, 1";
								pstmt		= conn.prepareStatement(query);
								pstmt.setInt(1, pressId);
								rs			= pstmt.executeQuery();

								if (rs.next()) {
								%>
								<a href="presscenterView.jsp?id=<%=rs.getInt("ID")%>&<%=param%>"><%=ut.cutString(50, rs.getString("TITLE"), "..")%></a>
								<%} else {%>
								�������� �����ϴ�.
								<%
								}

								if (rs != null) try { rs.close(); } catch (Exception e) {}
								if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
								%>
							</td>
						</tr>
						<tr>
							<td>������</td>
							<td><img src="../images/arrow_pre_bottom.png" width="7" height="5" alt="������" /></td>
							<td class="title">
								<%
								query		= "SELECT ID, TITLE FROM "+ table +" WHERE ID < ? ORDER BY ID DESC LIMIT 0, 1";
								pstmt		= conn.prepareStatement(query);
								pstmt.setInt(1, pressId);
								rs			= pstmt.executeQuery();

								if (rs.next()) {
								%>
								<a href="presscenterView.jsp?id=<%=rs.getInt("ID")%>&<%=param%>"><%=ut.cutString(70, rs.getString("TITLE"), "..")%></a>
								<%} else {%>
								�������� �����ϴ�.
								<%}%>
							</td>
						</tr>
					</table>
				</div>
				<div class="button small dark floatright">
					<a href="presscenter.jsp?<%=param%>">���</a>
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