<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
<%
DecimalFormat df = new DecimalFormat("00");
Calendar calendar = Calendar.getInstance();

String year				= Integer.toString(calendar.get(Calendar.YEAR)); //년도를 구한다
String month			= df.format(calendar.get(Calendar.MONTH) + 1); //달을 구한다
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:4,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 게시판관리 &gt; <strong>다이어트체험후기</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="po_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="ins" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>제목</span></th>
								<td>
									<input type="text" name="title" id="title" required label="제목" class="input1" style="width:400px;" maxlength="100" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>작성자(id)</span></th>
								<td>
									<input type="text" name="instId" id="instId" required label="아이디" class="input1" style="width:100px;" maxlength="100" value="<%=(String)session.getAttribute("esl_admin_id")%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>작성일</span></th>
								<td>
									<input type="text" name="instDate" id="instDate" required label="작성일" class="input1" style="width:100px;" maxlength="100" /> ex: 2013-01-09
								</td>
							</tr>
							<tr>
								<th scope="row"><span>구분</span></th>
								<td>
									<select name="press_url" id="press_url">
										<option value="4">이벤트후기</option>
										<option value="1">식사다이어트</option>
										<option value="2">프로그램다이어트</option>
										<option value="3">타입별다이어트</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>베스트설정</span></th>
								<td>
									<select name="best_set" id="best_set">
										<option value="">설정안함</option>
										<option value="<%=year%>-<%=month%>"><%=year%>년 <%=month%>월</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>내용</span></th>
								<td>
									<textarea id="content" name="content" style="height:500px;width:100%;" type=editor></textarea>
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
									<input type="file" name="list_img" value="" />
									
								</td>
							</tr>

						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_write)" class="function_btn"><span>저장</span></a>
						<a href="po_list.jsp" class="function_btn"><span>목록</span></a>
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