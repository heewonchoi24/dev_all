<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String table		= "ESL_COUNSEL";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
String counselType	= "";
String title		= "";
String content		= "";
String instDate		= "";
String answerYn		= "";
String answerYnTxt	= "";
String answer		= "";
String answerDate	= "";
String counselID	= "";
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

query		= "SELECT ID, COUNSEL_TYPE, TITLE, CONTENT, DATE_FORMAT(INST_DATE, '%Y.%m.%d') INST_DATE, UP_FILE, ";
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
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content" class="oldClass">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">1:1 ����</span></span></h1>

		<div id="myqna">
			<div class="topBox">
				<img src="/mobile/common/images/ico/ico_qna.png" />
				<p>1:1 ���� ��ư�� Ŭ���Ͻþ� ������ �ֽø� <br/>���� �ð����� �亯 �帮���� �ϰڽ��ϴ�.</p>
				<button class="btn btn_dgray square" onclick="location.href='/mobile/customer/indiqna.jsp'">1:1 �����ϱ�</button>
			</div>
			<div class="listArea">
				<div class="title">�� <span><%=intTotalCnt%></span> ���� ���ǳ����� �ֽ��ϴ�.</div>
				<ul class="qnaList accordion">
					<!-- <li>
						<a href="#" class="acc_head">
							��ǰ�� �߰��� ������ �� �ֳ���?
							<p><span>�亯�Ϸ�</span> 2017.06.14</p>
						</a>
						<div class="acc_content">
							<div class="inner">
								<div class="q">
									<p class="txt">�������� �������� ���Ͽ� �ֹ��� ��ǰ�� �ٲٰ� ������ ��ǰ ������  �� �� �������? ���ɿ��ΰ� �ñ��մϴ�.</p>
									<p class="btns">
										<button>����</button>
										<button>����</button>
									</p>
								</div>
								<div class="a">
									<p class="date">A. �亯�ۼ���: 2017.06.14</p>
									<p class="txt">
										(3�� �� ��ǰ���� ��� �����Ͻʴϴ�.) <br/>
										�ֹ����� ������� ���� ������ ���� 3�� �ĺ��� ��Ұ� �����Ͻʴϴ�. �� �� ������ ���� 1~2�� �� ��ǰ�� �̹� �ֹ� ���� ������� ���� �ֹ� �� ���� �۾��� ����ǰ� �־�, ���� ���/ȯ�� ���� �Ұ��� �� ���غ�Ź�帳�ϴ�. ���ֹ� �� ���ֹ� ��ǰ�� ù ������� �ű� �ֹ��ǰ� �����ϰ� ����Ǿ� ���� �����մϴ�. (�ﾾ���� : �ֹ��Ϸκ��� 2�� ��, �˶��� �ﾾ/���� : �ֹ��Ϸκ��� 6�� ��, ���� : �ֹ��Ϸκ��� 4�� ��) <br/>
										�ս��� Ȩ������ ''�����ս���'' 1:1 �Խ����� ���� �����ϼ���.
									</p>
								</div>
							</div>
						</div>
					</li>
					<li>
						<a href="#" class="acc_head">
							��ǰ�� �߰��� ������ �� �ֳ���? ��ǰ�� �߰��� ������ �� �ֳ���?
							<p><span>�̴亯</span> 2017.06.14</p>
						</a>
						<div class="acc_content">
							<div class="inner">
								<div class="q">
									<p class="txt">�������� �������� ���Ͽ� �ֹ��� ��ǰ�� �ٲٰ� ������ ��ǰ ������  �� �� �������? ���ɿ��ΰ� �ñ��մϴ�.</p>
									<p class="btns">
										<button>����</button>
										<button>����</button>
									</p>
								</div>
							</div>
						</div>
					</li> -->

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
			imgUrl		= "<p class='img'><img src='"+ webUploadDir +"board/"+ upFile + "' width='100%' /></p>";
		}

		if (answerYn.equals("Y")) {
			answerYnTxt		= "�亯�Ϸ�";
			answer			= ut.nl2br(rs.getString("ANSWER"));
			answerDate		= rs.getString("ANSWER_DATE");
			btnMod = "";
		} else {
			answerYnTxt		= "�̴亯";
			answer			= "";
			answerDate		= "";
			btnMod = "<p class='btns'><button onclick='window.href='/mobile/customer/indiqna.jsp?counselID="+counselID+"'>����</button><button onclick=\"confDel('"+counselID+"');\">����</button></p>";
		}
%>
					<li>
						<a href="#" class="acc_head">
							<%=title%>
							<p><span><%=answerYnTxt%></span> <%=instDate%></p>
						</a>
						<div class="acc_content">
							<div class="inner">
								<div class="q">
									<%=imgUrl%>
									<p class="txt"><%=content%></p>
									<%=btnMod%>
								</div>
<% if (answerYn.equals("Y")) { %>
								<div class="a">
									<p class="date">A. �亯�ۼ���: <%=answerDate%></p>
									<p class="txt">
										<%=answer%>
									</p>
								</div>
<% } %>
							</div>
						</div>
					</li>
<%
	}
} else {
%>
					<li class="none">
						 ��ϵ� 1:1 ���ǰ� �����ϴ�.
					</li>
<%
}
%>
				</ul>
			</div>
		</div>

		<script type="text/javascript">
			$(document).ready(function() {
				// Store variables
				var accordion_head = $('.accordion > li > .acc_head'),
					accordion_body = $('.accordion > li > .acc_content');
				// Open the first tab on load
				//accordion_head.first().addClass('active').next().slideDown('normal');
				// Click function
				accordion_head.on('click', function(e) {
					// Disable header links
					e.preventDefault();
					// Show and hide the tabs on click
					var _this = $(this);
					if (_this.attr('class') != 'active'){
						accordion_body.slideUp('normal');
						_this.next().stop(true,true).slideToggle('normal', function() {
							$("html, body").stop().animate({scrollTop:_this.offset().top}, 500, 'swing');
						});
						accordion_head.removeClass('active');
						_this.addClass('active');
					}else{
						accordion_body.slideUp('normal');
						accordion_head.removeClass('active');
					}
				});
			});
			function confDel(counselID) {
				var msg = "������ �����Ͻðڽ��ϱ�? ���� �� ������ �� �����ϴ�."
				if(confirm(msg)){
					location.href = "/mobile/customer/indiqna_del_db.jsp?counselID="+ counselID +"&mode=del";
				}else{
					return;
				}
			}
		</script>

    </div>
    <!-- End Content -->
    <div class="ui-footer">
        <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>