<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

int counselId				= 0;
String query			= "";
String member_id		= "";
String counsel_type		= "";
String name				= "";
String hp				= "";
String email			= "";
String title			= "";
String content			= "";
String listImg			= "";
String inst_ip			= "";
String wdate			= "";
String answer_yn		= "";
String answer			= "";
String answer_id		= "";
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
	counselId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT MEMBER_ID, COUNSEL_TYPE, NAME, HP, EMAIL, TITLE, CONTENT, UP_FILE, INST_IP,";
	query		+= "	DATE_FORMAT(INST_DATE, '%Y.%m.%d %H:%i') WDATE, ANSWER_YN, ANSWER, ANSWER_ID ";
	query		+= " FROM ESL_COUNSEL";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, counselId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		member_id		= rs.getString("MEMBER_ID");
		counsel_type	= rs.getString("COUNSEL_TYPE");
		name			= rs.getString("NAME");
		hp				= rs.getString("HP");
		email			= rs.getString("EMAIL");
		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
		listImg			= ut.isnull(rs.getString("UP_FILE"));
		inst_ip			= rs.getString("INST_IP");
		wdate			= rs.getString("WDATE");
		answer_yn		= rs.getString("ANSWER_YN");
		answer			= (rs.getString("ANSWER") == null)? "" : rs.getString("ANSWER");
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
		$('#lnb').menuModel2({hightLight:{level_1:1,level_2:4,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-counsel.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상담/문의관리 &gt; <strong>1:1 문의</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="counsel_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=counselId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="org_list_img" value="<%=listImg%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>상담유형</span></th>
								<td>
									<select name="counsel_type" style="width:230px;" required label="상담유형">
										<option value="01"<%if(counsel_type.equals("01")) out.println(" selected");%>>기업</option>
										<option value="02"<%if(counsel_type.equals("02")) out.println(" selected");%>>배송</option>
										<option value="03"<%if(counsel_type.equals("03")) out.println(" selected");%>>제품이용</option>
										<option value="04"<%if(counsel_type.equals("04")) out.println(" selected");%>>주문결제</option>
										<option value="05"<%if(counsel_type.equals("05")) out.println(" selected");%>>서비스관리</option>
										<option value="09"<%if(counsel_type.equals("09")) out.println(" selected");%>>기타</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>작성자아이디</span></th>
								<td>
									<%=member_id%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>작성자</span></th>
								<td>
									<input type="text" name="name" id="name" required label="작성자" class="input1" style="width:100px;" maxlength="10" value="<%=name%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>연락처</span></th>
								<td>
									<input type="text" name="hp" id="name" required label="연락처" class="input1" style="width:100px;" maxlength="10" value="<%=hp%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이메일</span></th>
								<td>
									<input type="text" name="email" id="name" required label="이메일" class="input1" style="width:400px;" maxlength="10" value="<%=email%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>제목</span></th>
								<td>
									<input type="text" name="title" id="title" required label="제목" class="input1" style="width:400px;" maxlength="100" value="<%=title%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>내용</span></th>
								<td><textarea name="content" rows="6" style="width:600px;" required label="내용" readonly><%=content%></textarea></td>
							</tr>
							<tr>
								<th scope="row"><span>첨부파일</span></th>
								<td colspan="3">
									<%if (!listImg.equals("") || listImg != null) {%>
										<a href="<%=webUploadDir +"board/"+ listImg%>" target="_blank"><%=listImg%></a>
										<!-- <img src="<%=webUploadDir +"board/"+ listImg%>" width="160" height="108" /> -->
									<%}%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>작성자IP</span></th>
								<td>
									<%=inst_ip%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>작성일</span></th>
								<td>
									<%=wdate%>
								</td>
							</tr>
							<tr>
								<td colspan="2" height="1" bgcolor="#dfdfdf"></td>
							</tr>
							<tr>
								<th scope="row"><span>답변</span></th>
								<td>
									<textarea id="answer" name="answer" style="height:500px;width:100%;" type=editor><%=answer%></textarea>
									<!-- 웹에디터 활성화 스크립트 -->
									<script src="/editor/editor_board.js"></script>
									<script>
										mini_editor('/editor/');							
									</script>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_edit)" class="function_btn"><span>수정</span></a>
						<a href="counsel_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
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