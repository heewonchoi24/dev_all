<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String table		= "ESL_COUNSEL";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
String counselID	= "";
String counselType	= "";
String title		= "";
String content		= "";
String instDate		= "";
String answerYn		= "";
String answerYnTxt	= "";
String answer		= "";
String answerDate	= "";
String btnMod		= "";
String btnDel		= "";
String upFile		= "";
String imgUrl		= "";

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

where			= " WHERE MEMBER_ID = '"+ eslMemberId +"'";

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

query		= "SELECT ID, COUNSEL_TYPE, TITLE, CONTENT, DATE_FORMAT(INST_DATE, '%Y-%m-%d') INST_DATE, UP_FILE,";
query		+= "	ANSWER_YN, ANSWER, DATE_FORMAT(ANSWER_DATE, '%Y-%m-%d') ANSWER_DATE";
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
			<h1>�����ս���</h1>
			<div class="pageDepth">
				HOME &gt; �����ս��� &gt; <strong>1:1 ���ǳ���</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last  col">
					<ul class="tabNavi">
						<li><a href="index.jsp">Ȩ</a></li>
						<li><a href="orderList.jsp">�ֹ�/���</a></li>
						<li><a href="couponList.jsp">��������</a></li>
						<li class="active"><a href="myqna.jsp">1:1 ���ǳ���</a></li>
						<div class="button small iconBtn light">
							<a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span class="gear"></span> ȸ����������</a>
						</div>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row" style="margin-bottom:40px;">
				<div class="one last col">
					<div class="sectionHeader">
						<h4> �� <strong class="font-maple"><%=intTotalCnt%></strong>���� ���ǳ����� �ֽ��ϴ�. </h4>
						<div class="floatright button dark small">
							<a href="/customer/indiqna.jsp">1:1 �����ϱ�</a>
						</div>
					</div>
					<div class="postList">
						<ul class="boardStyle">

<%
if (intTotalCnt > 0) {
	while (rs.next()) {
		counselID		= rs.getString("ID");
		counselType		= rs.getString("COUNSEL_TYPE");
		title			= rs.getString("TITLE");
		content			= ut.nl2br(rs.getString("CONTENT"));
		instDate		= rs.getString("INST_DATE");
		answerYn		= rs.getString("ANSWER_YN");
		upFile			= ut.isnull(rs.getString("UP_FILE"));
		if (upFile.equals("") || upFile == null) {
			imgUrl		= "";
		} else {										
			imgUrl		= "<img src='"+ webUploadDir +"board/"+ upFile + "' width='600' />";
		}
		if (answerYn.equals("Y")) {
			answerYnTxt		= "�亯�Ϸ�";
			answer			= ut.nl2br(rs.getString("ANSWER"));
			answerDate		= rs.getString("ANSWER_DATE");
			btnMod = "";
			btnDel = "";
		} else {
			answerYnTxt		= "�̴亯";
			answer			= "";
			answerDate		= "";
			btnMod = "<div class='button dark small'><a href='/customer/indiqna.jsp?counselID="+ counselID +"'>����</a></div>";
			btnDel = "<div class='button dark small'><a href=\"javascript:confDel('"+ counselID +"');\">����</a></div>";
		}
%>
							<li>
								<a href="javascript:;" onclick="showContent(<%=counselID%>)">
									<span class="cate">[<%=ut.getCounselType(counselType)%>]</span>
									<span class="post-subject">
										<span class="qa">Q.</span>
										<%=title%>
									</span>
									<span class="comments font-maple"><%=answerYnTxt%></span>
									<span class="post-date"><%=instDate%></span>
								</a>

								<div id="content_<%=counselID%>" class="post-view hidden">
									<div class="post-article">
										<%=imgUrl%>
										<p><%=content%></p>
									</div>
									<div class="btnGroup">
										<%=btnMod%>
										<%=btnDel%>
									</div>
									<%if (answerYn.equals("Y")) {%>
									<div class="post-view-comment">
										<div class="re-title">
											<span class="comment-date"><%=answerDate%></span>
										</div>
										<p><%=answer%></p>
									</div>
									<%}%>
								</div>
							</li>

<%
	}
} else {
%>

							<li>��ϵ� 1:1 ���ǰ� �����ϴ�.</li>

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
				<div class="one last col">
					<%@ include file="/common/include/inc-paging.jsp"%>
				</div>
			</div>
		</div>
		<!-- End sixteen columns offset-by-one -->
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
	if ($("#content_"+ cid).hasClass("hidden")) {
		$(".post-view").addClass("hidden");
		$("#content_"+ cid).removeClass("hidden");
	} else {
		$("#content_"+ cid).addClass("hidden");
	}
}

function confDel(counselID) {
	var msg = "������ �����Ͻðڽ��ϱ�? ���� �� ������ �� �����ϴ�."
	if(confirm(msg)){
		location.href = "/customer/indiqna_del_db.jsp?counselID="+ counselID +"&mode=del";
	}else{
		return;
	}
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>