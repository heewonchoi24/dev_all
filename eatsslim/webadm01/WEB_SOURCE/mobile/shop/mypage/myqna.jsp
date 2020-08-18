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
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">1:1 문의</span></span></h1>

		<div id="myqna">
			<div class="topBox">
				<img src="/mobile/common/images/ico/ico_qna.png" />
				<p>1:1 문의 버튼을 클릭하시어 문의해 주시면 <br/>빠른 시간내에 답변 드리도록 하겠습니다.</p>
				<button class="btn btn_dgray square" onclick="location.href='/mobile/customer/indiqna.jsp'">1:1 문의하기</button>
			</div>
			<div class="listArea">
				<div class="title">총 <span><%=intTotalCnt%></span> 건의 문의내역이 있습니다.</div>
				<ul class="qnaList accordion">
					<!-- <li>
						<a href="#" class="acc_head">
							제품을 중간에 변경할 수 있나요?
							<p><span>답변완료</span> 2017.06.14</p>
						</a>
						<div class="acc_content">
							<div class="inner">
								<div class="q">
									<p class="txt">개인적인 사정으로 인하여 주문한 제품을 바꾸고 싶을때 제품 변경을  할 수 있을까요? 가능여부가 궁금합니다.</p>
									<p class="btns">
										<button>수정</button>
										<button>삭제</button>
									</p>
								</div>
								<div class="a">
									<p class="date">A. 답변작성일: 2017.06.14</p>
									<p class="txt">
										(3일 후 제품부터 취소 가능하십니다.) <br/>
										주문생산 방식으로 인해 접수일 기준 3일 후부터 취소가 가능하십니다. 그 외 접수일 기준 1~2일 후 제품은 이미 주문 생산 방식으로 인해 주문 및 생산 작업이 진행되고 있어, 별도 취소/환불 등이 불가한 점 양해부탁드립니다. 재주문 시 재주문 제품의 첫 배송일은 신규 주문건과 동일하게 적용되어 선택 가능합니다. (헬씨퀴진 : 주문일로부터 2일 후, 알라까르떼 헬씨/슬림 : 주문일로부터 6일 후, 퀴진 : 주문일로부터 4일 후) <br/>
										잇슬림 홈페이지 ''마이잇슬림'' 1:1 게시판을 통해 문의하세요.
									</p>
								</div>
							</div>
						</div>
					</li>
					<li>
						<a href="#" class="acc_head">
							제품을 중간에 변경할 수 있나요? 제품을 중간에 변경할 수 있나요?
							<p><span>미답변</span> 2017.06.14</p>
						</a>
						<div class="acc_content">
							<div class="inner">
								<div class="q">
									<p class="txt">개인적인 사정으로 인하여 주문한 제품을 바꾸고 싶을때 제품 변경을  할 수 있을까요? 가능여부가 궁금합니다.</p>
									<p class="btns">
										<button>수정</button>
										<button>삭제</button>
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
			answerYnTxt		= "답변완료";
			answer			= ut.nl2br(rs.getString("ANSWER"));
			answerDate		= rs.getString("ANSWER_DATE");
			btnMod = "";
		} else {
			answerYnTxt		= "미답변";
			answer			= "";
			answerDate		= "";
			btnMod = "<p class='btns'><button onclick='window.href='/mobile/customer/indiqna.jsp?counselID="+counselID+"'>수정</button><button onclick=\"confDel('"+counselID+"');\">삭제</button></p>";
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
									<p class="date">A. 답변작성일: <%=answerDate%></p>
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
						 등록된 1:1 문의가 없습니다.
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
				var msg = "정말로 삭제하시겠습니까? 삭제 후 복구할 수 없습니다."
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