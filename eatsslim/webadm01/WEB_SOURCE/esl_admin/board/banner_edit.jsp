<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_BANNER";
String query		= "";
int bannerId		= 0;
String title		= ut.inject(request.getParameter("title"));
String openYn		= ut.inject(request.getParameter("open_yn"));
String stdate		= ut.inject(request.getParameter("stdate"));
String ltdate		= ut.inject(request.getParameter("ltdate"));
String bannerImg	= ut.inject(request.getParameter("banner_img"));
String link			= ut.inject(request.getParameter("link"));
String bannerType	= ut.inject(request.getParameter("banner_type"));
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
	bannerId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT TITLE, OPEN_YN, STDATE, LTDATE, BANNER_IMG, LINK, GUBUN ";
	query		+= " FROM "+ table;
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, bannerId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		openYn			= rs.getString("OPEN_YN");
		stdate			= rs.getString("STDATE");
		ltdate			= rs.getString("LTDATE");
		bannerImg		= rs.getString("BANNER_IMG");
		link			= rs.getString("LINK");
		bannerType		= rs.getString("GUBUN");
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
		$('#lnb').menuModel2({hightLight:{level_1:6,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 게시판관리 &gt; <strong>배너관리</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="banner_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=bannerId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="org_banner_img" value="<%=bannerImg%>" />
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
								<th scope="row"><span>구분</span></th>
								<td>
									<select name="banner_type" id="banner_type" required label="구분">
										<option value="">선택</option>
										<option value="1"<%if (bannerType.equals("1")) out.println(" selected=\"selected\"");%>>메인배너</option>
										<option value="2"<%if (bannerType.equals("2")) out.println(" selected=\"selected\"");%>>고정배너1</option>
										<option value="3"<%if (bannerType.equals("3")) out.println(" selected=\"selected\"");%>>고정배너2</option>
										<option value="4"<%if (bannerType.equals("4")) out.println(" selected=\"selected\"");%>>고정배너3</option>
										<option value="5"<%if (bannerType.equals("5")) out.println(" selected=\"selected\"");%>>모바일배너</option>
									</select>
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
									<input type="file" name="banner_img" id="banner_img" value="" />
									(메인배너 사이즈: 999 X 407)
									(고정배너1,2,3 사이즈: 333 X 295)
									<br />
									<%if (bannerType.equals("1")) { %>
									<img src="<%=webUploadDir +"banner/"+ bannerImg%>" width="800" height="300" />
									<% } else { %>
									<img src="<%=webUploadDir +"banner/"+ bannerImg%>" width="333" height="295" />
									<% } %>
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
						<a href="banner_list.jsp" class="function_btn"><span>목록</span></a>
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