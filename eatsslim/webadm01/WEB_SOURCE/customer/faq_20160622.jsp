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
int pgsize		= 10; //�������� �Խù� ��
int pagelist	= 10; //ȭ��� ������ ��
int iPage;			  // ���������� ��ȣ
int startpage;		  // ���� ������ ��ȣ
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
	intTotalCnt = rs.getInt(1); //�� ���ڵ� ��		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // �� ������ ��
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
				HOME &gt; �������� &gt; <strong>FAQ</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li><a href="notice.jsp">��������</a></li>
						<li class="active"><a href="faq.jsp">FAQ</a></li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">1:1����</a></li>
						<%} else {%>
						<li><a href="indiqna.jsp">1:1����</a></li>
						<%}%>
						<li><a href="service_member.jsp">�̿�ȳ�</a></li>
						<li><a href="presscenter.jsp">��к���</a></li>
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
								<span class="current">��ȯ/ȯ��</span>
								<%} else {%>
								<a href="faq.jsp?sch_type=01">��ȯ/ȯ��</a>
								<%}%>
							</li>
							<li>
								<%if (schType.equals("02")) {%>
								<span class="current">ȸ������</span>
								<%} else {%>
								<a href="faq.jsp?sch_type=02">ȸ������</a>
								<%}%>
							</li>
							<li>
								<%if (schType.equals("03")) {%>
								<span class="current">�ֹ�/����</span>
								<%} else {%>
								<a href="faq.jsp?sch_type=03">�ֹ�/����</a>
								<%}%>
							</li>
							<li>
								<%if (schType.equals("04")) {%>
								<span class="current">��۰���</span>
								<%} else {%>
								<a href="faq.jsp?sch_type=04">��۰���</a>
								<%}%>
							</li>
							<li>
								<%if (schType.equals("09")) {%>
								<span class="current">��Ÿ</span>
								<%} else {%>
								<a href="faq.jsp?sch_type=09">��Ÿ</a>
								<%}%>
							</li>
						</ul>
						<div class="searchBar floatright">
							<label>
								<select name="field" id="field" style="width:70px;" onchange="this.form.keyword.focus()">
									<option value="TITLE"<%if(field.equals("TITLE")){out.print(" selected=\"selected\"");}%>>����</option>
									<option value="CONTENT"<%if(field.equals("CONTENT")){out.print(" selected=\"selected\"");}%>>����</option>
								</select>
							</label>
							<label>
								<input type="text" name="keyword" maxlength="30" value="<%=keyword%>" onfocus="this.select()" />
							</label>
							<label>
								<input type="submit" class="button dark small" name="button" value="�˻�">
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
								<a href="javascript:;" onclick="showContent(<%=faqId%>)">
									<span class="post-subject">
										<span class="qa">Q.</span>
										<%=title%>
									</span>
								</a>
								<div class="post-view hidden" id="fview_<%=faqId%>">
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
							<li>��ϵ� FAQ�� �����ϴ�.</li>
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
function showContent(cid) {
	if ($("#fview_"+ cid).hasClass("hidden")) {
		$(".post-view").addClass("hidden");
		$("#fview_"+ cid).removeClass("hidden");
	} else {
		$("#fview_"+ cid).addClass("hidden");
	}
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>