<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

int pressId				= 0;
String query			= "";
String title			= "";
String content			= "";
String listImg			= "";
String pressUrl			= "";
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
	pressId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT TITLE, CONTENT, LIST_IMG, PRESS_URL";
	query		+= " FROM ESL_PRESS";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, pressId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
		listImg			= rs.getString("LIST_IMG");
		pressUrl		= (rs.getString("PRESS_URL") == null)? "" : rs.getString("PRESS_URL");
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
		$('#lnb').menuModel2({hightLight:{level_1:3,level_2:4,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-board.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 게시판관리 &gt; <strong>언론보도</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="press_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=pressId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="org_list_img" value="<%=listImg%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
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
									<input type="file" name="list_img" value="<%=listImg%>" />
									(최적화 사이즈: 158 x 106)
									<%if (!listImg.equals("")) {%>
										<br /><input type="checkbox" name="del_list_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"board/"+ listImg%>" width="160" height="108" />
									<%}%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>URL</span></th>
								<td>
									<input type="text" name="press_url" id="press_url" class="input1" style="width:400px;" maxlength="100" value="<%=pressUrl%>" />
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_edit)" class="function_btn"><span>수정</span></a>
						<a href="press_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
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