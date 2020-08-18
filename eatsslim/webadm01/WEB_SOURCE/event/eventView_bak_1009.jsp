<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

int eventId				= 0;
String query			= "";
String eventType		= "";
String title			= "";
String openYn			= "";
String stdate			= "";
String ltdate			= "";
String eventTarget		= "";
String ancDate			= "";
String content			= "";
String param			= "";
String keyword			= "";
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String schCate			= ut.inject(request.getParameter("sch_cate"));
String field			= ut.inject(request.getParameter("field"));
if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	eventId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT TITLE, DATE_FORMAT(STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(LTDATE, '%Y.%m.%d') LTDATE,";
	query		+= "	EVENT_TARGET, DATE_FORMAT(ANC_DATE, '%Y.%m.%d') ANC_DATE, CONTENT";
	query		+= " FROM ESL_EVENT";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, eventId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		stdate			= rs.getString("STDATE");
		ltdate			= rs.getString("LTDATE");
		ancDate			= (rs.getString("ANC_DATE") == null || rs.getString("ANC_DATE").equals(""))? "����" : rs.getString("ANC_DATE");
		content			= rs.getString("CONTENT");
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
			<h1>�������� �̺�Ʈ</h1>
			<div class="pageDepth">
				HOME &gt; EVENT &gt; <strong>�������� �̺�Ʈ</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<div class="post-wrapper">
						<div class="post-read">
							<h2><%=title%></h2>
							<ul class="meta-wrap">
								<li><span class="time"></span><strong>�̺�Ʈ�Ⱓ</strong> <%=stdate%> ~ <%=ltdate%></li>
								<li><span class="who"></span><strong>�̺�Ʈ���</strong> <%=eventTarget%></li>
								<li><span class="win"></span><strong>��÷�ڹ�ǥ</strong> <%=ancDate%></li>
								<li style="float:right;">SNS Share</li>
							</ul>
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
							<div class="clear">
							</div>
							<div class="post-contents">
								<%=content%>
							</div>
							<div class="col center">
								<div class="button small dark">
									<a href="/event/currentEvent.jsp?<%=param%>">���</a>
								</div>
							</div>
							<div class="comment-wrap">
								<div class="sectionHeader">
									<h4> ���(1) </h4>
									<div class="floatright button dark small">
										<a href="#">��۵��</a>
									</div>
									<div class="clear">
									</div>
								</div>
								<textarea id="comment" name="comment"<%if (eslMemberId == null || eslMemberId.equals("")) out.println(" class=\"auto-hint\"");%> title="�α��� �� ����� �Է��� �ּ���. �Խ��ǰ� ������ �弳, ���, �������� ���Ƿ� ������ �� �ֽ��ϴ�."></textarea>
								<ul>
									<li class="comment depth-1" >
										<div class="commentheader">
											<h5>hong8****</h5>
											<div class="metastamp">
												2013.08.07
											</div>
											<div class="myadmin">
												<a href="#">���</a> �� <a href="#">����</a> �� <a href="#">����</a>
											</div>
										</div>
										<p>�ູ���̷����� ��! �ߺ��� ���ϴ�.</p>
										<div class="lineSeparator">
										</div>
										<ul>
											<li class="comment depth-2" >
												<div class="commentheader">
													<h5>������</h5>
													<div class="metastamp">
														2013.08.07
													</div>
												</div>
												<p>�� ���� ȭ�����Դϴ�.</p>
												<div class="lineSeparator">
												</div>
											</li>
										</ul>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- End Row -->
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear">
		</div>
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