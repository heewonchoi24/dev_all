<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_EVENT_DIARY";
int diaryId			= 0;
String query		= "";
String versus		= "";
String title		= "";
String content		= "";
String upImg		= "";
int day				= 0;
String weekday		= "";
String imgUrl		= "";
int replyCnt		= 0;
String replyTxt		= "";
int replyId			= 0;
String replyContent	= "";
String mode			= "ins";
String memberId		= "";
String memberName	= "";
String replyAnswer	= "";
String replyDate	= "";
String answerDate	= "";

if (request.getParameter("reply_id") != null && request.getParameter("reply_id").length() > 0) {
	replyId		= Integer.parseInt(request.getParameter("reply_id"));
}

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	diaryId		= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT VERSUS, TITLE, CONTENT, UP_IMG, DAY, WEEKDAY";
	query		+= " FROM "+ table;
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, diaryId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		versus			= rs.getString("VERSUS");
		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
		upImg			= rs.getString("UP_IMG");
		if (!upImg.equals("") && upImg != null) {
			imgUrl		= "<img src=\""+ webUploadDir +"promotion/"+ upImg +"\" />";
		} else {
			imgUrl		= "&nbsp;";
		}
		day				= rs.getInt("DAY");
		weekday			= rs.getString("WEEKDAY");
	}
	rs.close();

	query		= "SELECT COUNT(ID) FROM "+ table +"_REPLY WHERE DIARY_ID = "+ diaryId;
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		replyCnt	= rs.getInt(1);
	}
	rs.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta name="robots" content="noindex,nofollow,noarchive">
	<title>바른 다이어트 잇슬림</title>
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/layout.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/skeleton.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/color-theme.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.selectBox.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.lightbox.css" />
	<link rel="stylesheet" type="text/css" media="print" href="/common/css/print.css" />
	<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/common/js/jquery.lightbox.js"></script>
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/event_view.css" />
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>최과장의 다이어트 일기</h2>
		<p></p>
	</div>
	<div class="contentpop">
		<div class="columns offset-by-one">
			<div class="row">
				<div class="one last col center">
					<div class="archive-title">
						<h3><%=title+" ("+day+"일차, "+weekday+")"%></h3>
						<div class="archive-pagenavi">
							<%
							query		= "SELECT ID, TITLE FROM "+ table +" WHERE ID < ? AND VERSUS = '1' ORDER BY ID DESC LIMIT 0, 1";
							pstmt		= conn.prepareStatement(query);
							pstmt.setInt(1, diaryId);
							rs			= pstmt.executeQuery();
							
							if (rs.next()) {
							%>
							<a class="prev" href="choi_diary.jsp?id=<%=rs.getInt("ID")%>">&lt;&lt;</a>
							<%} else {%>
							<a class="prev" href="javascript:;" onclick="alert('이전글이 없습니다.');">&lt;&lt;</a>
							<%
							}

							if (rs != null) try { rs.close(); } catch (Exception e) {}
							if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
							
							query		= "SELECT ID, TITLE FROM "+ table +" WHERE ID > ? AND VERSUS = '1' ORDER BY ID ASC LIMIT 0, 1";
							pstmt		= conn.prepareStatement(query);
							pstmt.setInt(1, diaryId);
							rs			= pstmt.executeQuery();
							
							if (rs.next()) {
							%>
							<a class="next" href="choi_diary.jsp?id=<%=rs.getInt("ID")%>">&gt;&gt;</a>
							<%} else {%>
							<a class="next" href="javascript:;" onclick="alert('다음글이 없습니다.');">&gt;&gt;</a>
							<%
							}
							%>
						</div>
					</div>
					<div class="dayfood">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="105" align="center" bgcolor="#58B7DD" style="color:#FFF;">제공된<br />잇슬림제품</td>
								<td bgcolor="#F4F4F4">
									<ul class="dailylist">
										<li><%=imgUrl%></li>
										<div class="clear"></div>
									</ul>
								</td>
							</tr>
						</table>
					</div>
					<div class="archive-view">
						<p><%=content%></p>
					</div>
					<div class="clear"></div>
					<div class="comment-wrap">
						<div class="sectionHeader">
							<h4>댓글(<%=replyCnt%>)</h4>
							<div class="floatright button dark small">
								<a href="javascript:reply_write();">댓글등록</a>
							</div>
							<div class="clear"></div>
						</div>
						<%
						if(eslMemberId.equals("")){
							replyTxt	 = "로그인 후 댓글을 입력해 주세요. ";
						}

						//댓글 수정 처리
						if (replyId > 0) {
							query		= "SELECT ID, CONTENT ";
							query		+= " FROM "+ table +"_REPLY";
							query		+= " WHERE DIARY_ID = "+ diaryId +" AND ID = "+ replyId;
							query		+= " AND MEMBER_ID = '"+ eslMemberId +"'";
							try {
								rs	= stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}

							replyId		= 0;

							if (rs.next()) {
								replyId			= rs.getInt("ID");
								replyContent	= rs.getString("CONTENT");
							}
							rs.close();

							if(replyId > 0){
								mode		= "upd";
							}
						}
						%>
						<form name="reply_write" method="post" action="diary_db.jsp">
							<input type="hidden" name="mode" value="<%=mode%>" />
							<input type="hidden" name="member_id" value="<%=eslMemberId%>" />
							<input type="hidden" name="member_name" value="<%=eslMemberName%>" />
							<input type="hidden" name="id" value="<%=diaryId%>" />
							<input type="hidden" name="reply_id" value="<%=replyId%>">
							<input type="hidden" name="return_url" value="choi_diary">
							<textarea id="content" name="content" class="auto-hint" title="<%=replyTxt%>게시판과 무관한 욕설, 비방, 광고댓글은 임의로 삭제될 수 있습니다." wrap="virtual" <%if(eslMemberId.equals("")){%>disabled="true"<%}%>><%=replyContent%></textarea>
						</form>
						<ul>
							<li class="comment depth-1" >
							<%
							query		= "SELECT ID, MEMBER_ID, MEMBER_NAME, CONTENT, ANSWER, INST_DATE, ANSWER_DATE";
							query		+= " FROM "+ table +"_REPLY WHERE DIARY_ID = "+ diaryId;
							query		+= " ORDER BY ID DESC";
							try {
								rs	= stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}

							if (replyCnt > 0) {
								int i		= 0;
								while (rs.next()) {
									replyId			= rs.getInt("ID");
									memberId		= rs.getString("MEMBER_ID");
									memberName		= rs.getString("MEMBER_NAME");
									replyContent	= rs.getString("CONTENT");
									replyAnswer		= (rs.getString("ANSWER") == null)? "" : rs.getString("ANSWER");
									replyDate		= rs.getString("INST_DATE");
									answerDate		= rs.getString("ANSWER_DATE");
									
									if (i > 0) {
							%>
								<div class="lineSeparator" style="margin-bottom:10px"></div>
							<%
									}

									String m_id_open	= "";
									String m_id_hide	= "";
									int m_id_len		= 0;
									m_id_open		= memberId.substring(0,3);
									m_id_len		= memberId.length();

									for (i=0; i<m_id_len; i++) {
										m_id_hide += "*";
									}
							%>
								<div class="commentheader">
									<h5><%=m_id_open + m_id_hide%></h5>
									<div class="metastamp"><%=replyDate.substring(0,16)%></div>
									<div class="myadmin">
										<% if(memberId.equals(eslMemberId)){ %>
										<a href="choi_diary.jsp?id=<%=diaryId%>&reply_id=<%=replyId%>">수정</a>
										|
										<a href="javascript:reply_del('<%=replyId%>');">삭제</a>
										<% } %>
									</div>
								</div>
								<p><%=ut.nl2br(replyContent)%></p>
							<%
									if (!replyAnswer.equals("")) {
							%>
								<div class="lineSeparator"></div>
									<ul>
										<li class="comment depth-2" >
											<div class="commentheader">
												<h5>관리자</h5>
												<div class="metastamp"><%=answerDate.substring(0,16)%></div>
											</div>
											<p><%=ut.nl2br(replyAnswer)%></p>
											<div class="lineSeparator"></div>
										</li>
									</ul>
							<%
									}
									i++;
								}
							}
							%>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- End row -->
		</div>
		<!-- End popup columns offset-by-one -->
	</div>
	<!-- End contentpop -->
</div>
<script type="text/javascript">
function reply_write() {
	var f = document.reply_write;

	if(f.member_id.value==""){
		$.lightbox("/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350");
		return;
	}
	if(f.member_name.value==""){
		$.lightbox("/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350");
		return;
	}
	if(f.content.value=="" || f.content.value=="게시판과 무관한 욕설, 비방, 광고댓글은 임의로 삭제될 수 있습니다."){
		alert('내용을 입력하세요');
		f.content.focus();
		return;
	}
	
	f.submit();
}

function reply_del(did){
	var f = document.reply_write;
	if(confirm("삭제하시겠습니까?")){
		f.mode.value = "del";
		f.reply_id.value = did;
		f.submit();
	}
}
</script>
</body>
</html>
<%}%>
<%@ include file="/lib/dbclose.jsp" %>