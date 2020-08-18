<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_POPUP";
String query		= "";
int popupId			= 0;
String title		= ut.inject(request.getParameter("title"));
String attr			= ut.inject(request.getParameter("attr"));
String openYn		= ut.inject(request.getParameter("open_yn"));
String stdate		= ut.inject(request.getParameter("stdate"));
String ltdate		= ut.inject(request.getParameter("ltdate"));
String content		= ut.inject(request.getParameter("content"));
String link			= ut.inject(request.getParameter("link"));
String param		= "";
String keyword		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String schOpen		= ut.inject(request.getParameter("sch_open"));
String schStdate	= ut.inject(request.getParameter("sch_stdate"));
String schLtdate	= ut.inject(request.getParameter("sch_ltdate"));
String schEndStdate	= ut.inject(request.getParameter("sch_end_stdate"));
String schEndLtdate	= ut.inject(request.getParameter("sch_end_ltdate"));
String field		= ut.inject(request.getParameter("field"));
if (request.getParameter("keyword") != null) {
	keyword		= ut.inject(request.getParameter("keyword"));
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param	= "page="+ iPage +"&pgsize="+ pgsize +"&sch_open="+ schOpen +"&sch_stdate="+ schStdate +"&sch_ltdate="+ schLtdate +"&sch_end_stdate="+ schEndStdate +"&sch_end_ltdate="+ schEndLtdate +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	popupId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT TITLE, ATTR, OPEN_YN, STDATE, LTDATE, CONTENT, LINK ";
	query		+= " FROM "+ table;
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, popupId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		attr			= rs.getString("ATTR");
		openYn			= rs.getString("OPEN_YN");
		stdate			= rs.getString("STDATE");
		ltdate			= rs.getString("LTDATE");
		content			= rs.getString("CONTENT");
		link			= rs.getString("LINK");
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
		$('#lnb').menuModel2({hightLight:{level_1:5,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 게시판관리 &gt; <strong>팝업관리</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="popup_db.jsp">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=popupId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
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
								<th scope="row"><span>속성</span></th>
								<td>
									<input type="text" name="attr" id="attr" required label="속성" class="input1" style="width:400px;" maxlength="100" value="<%=attr%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>적용여부</span></th>
								<td>
									<input type="radio" name="open_yn" value="Y"<%if(openYn.equals("Y")) out.print(" checked=\"checked\"");%> />
									적용
									<input type="radio" name="open_yn" value="N"<%if(openYn.equals("N")) out.print(" checked=\"checked\"");%> />
									미적용
								</td>
							</tr>
							<tr>
								<th scope="row"><span>팝업기간</span></th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="8" readonly="readonly" required label="시작일자" value="<%=stdate%>" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="8" readonly="readonly" required label="마감일자" value="<%=ltdate%>" />
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
								<th scope="row"><span>LINK</span></th>
								<td>
									<input type="text" name="link" id="link" class="input1" style="width:400px;" maxlength="100" value="<%=link%>" />
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_edit)" class="function_btn"><span>수정</span></a>
						<a href="popup_list.jsp" class="function_btn"><span>목록</span></a>
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
	$('#stdate,#ltdate').datepick({ 
		onSelect: setPeriod,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
});

function setPeriod(dates) {
	var stdate		= $("#stdate").val();
	var ltdate		= $("#ltdate").val();

	if (this.id == 'stdate') {
		$('#ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>