<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

int diaryId			= 0;
String query		= "";
String versus		= "";
String title		= "";
String content		= "";
String upImg		= "";
int day				= 0;
String weekday		= "";
String param		= "";
String keyword		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String field		= ut.inject(request.getParameter("field"));
if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	diaryId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT VERSUS, TITLE, CONTENT, UP_IMG, DAY, WEEKDAY";
	query		+= " FROM ESL_EVENT_DIARY";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, diaryId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		versus			= rs.getString("VERSUS");
		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
		upImg			= rs.getString("UP_IMG");
		day				= rs.getInt("DAY");
		weekday			= rs.getString("WEEKDAY");
	}
} else {
	ut.jsBack(out);
	if (true) return;
}
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:5,level_2:4,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 프로모션관리 &gt; <strong>다이어트 일기</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="diary_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=diaryId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="org_up_img" value="<%=upImg%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>등록자</span></th>
								<td>
									<select name="versus" id="versus">
										<option value="1"<%if (versus.equals("1")) out.println(" selected=\"selected\"");%>>최과장</option>
										<option value="2"<%if (versus.equals("2")) out.println(" selected=\"selected\"");%>>이대리</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>차수</span></th>
								<td>
									<select name="day" id="day">
										<%for (i = 1; i < 101; i++) {%>
										<option value="<%=i%>"<%if (day == 2) out.println(" selected=\"selected\"");%>><%=i%>일차</option>
										<%}%>
									</select>
									<select name="weekday" id="weekday">
										<option value="월"<%if (weekday.equals("월")) out.println(" selected=\"selected\"");%>>월</option>
										<option value="화"<%if (weekday.equals("화")) out.println(" selected=\"selected\"");%>>화</option>
										<option value="수"<%if (weekday.equals("수")) out.println(" selected=\"selected\"");%>>수</option>
										<option value="목"<%if (weekday.equals("목")) out.println(" selected=\"selected\"");%>>목</option>
										<option value="금"<%if (weekday.equals("금")) out.println(" selected=\"selected\"");%>>금</option>
										<option value="토"<%if (weekday.equals("토")) out.println(" selected=\"selected\"");%>>토</option>
										<option value="일"<%if (weekday.equals("일")) out.println(" selected=\"selected\"");%>>일</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>제목</span></th>
								<td>
									<input type="text" name="title" id="title" required label="제목" class="input1" style="width:400px;" maxlength="100" value="<%=title%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>내용</span></th>
								<td>
									<textarea id="content" name="content" style="height:500px;width:100%;" type=editor><%=content%></textarea>
									<!-- 웹에디터 활성화 스크립트 -->
									<script src="/editor/editor_board.js"></script>
									<script>
										mini_editor('/editor/');							
									</script>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>리스트용 이미지</span></th>
								<td colspan="3">
									<input type="file" name="up_img" value="<%=upImg%>" />
									<%if (!upImg.equals("")) {%>
										<br /><input type="checkbox" name="del_up_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"promotion/"+ upImg%>" />
									<%}%>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_edit)" class="function_btn"><span>수정</span></a>
						<a href="diary_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
					</div>
				</form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
<script type="text/javascript">
$(document).ready(function() {
	$("#title").focus();
});
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>