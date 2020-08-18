<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
    <script type="text/javascript" src="/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
    <script type="text/javascript" src="/smarteditor/quick_photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"> </script>
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
		<%@ include file="../include/inc-sidebar-board.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 게시판관리 &gt; <strong>공지사항</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="notice_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="ins" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>상단공지</span></th>
								<td>
									<label>
										<input type="radio" name="top_yn" value="N" checked="checked" />
										공지안함
									</label>
									<label>
										<input type="radio" name="top_yn" value="Y" />
										공지함
									</label>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>제목</span></th>
								<td>
									<input type="text" name="title" id="title" required label="제목" class="input1" style="width:400px;" maxlength="100" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>내용</span></th>
								<td>
                                   <form id="f_content" name="f_content" method="post">
                                        <textarea name="content" id="content" style="height:500px;width:100%;"></textarea>
                                    </form>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>리스트용 이미지</span></th>
								<td colspan="3">
									<input type="file" name="list_img" value="" />
									(최적화 사이즈: 160 x 108)
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="submitContents()" class="function_btn"><span>저장</span></a>
						<a href="notice_list.jsp" class="function_btn"><span>목록</span></a>
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

<!-- smart editor 2.0 -->
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "content",
    sSkinURI: "/smarteditor/SmartEditor2Skin.html",
    fCreator: "createSEditor2",
    // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
    bUseToolbar : true,           
    // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
    bUseVerticalResizer : true,   
    // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
    bUseModeChanger : true
});
// ‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
function submitContents() {
    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
    if($("#title").val() == ""){
        alert("[제목] 필수 입력 사항입니다");
        $("#title").focus();
        return false;
    }
    if(confirm('저장 하시겠습니까?') ){
        document.frm_write.submit();
        var forms = document.f_content;
        forms.submit();   
    }
}
// 2013.06.27 위지윅편집기 SmartEditor2 (program/common/se2) 사진첨부기능
function pasteHTML(filepath){
    var sHTML = '<span style="color:#FF0000;"><img src="'+filepath+'"></span>';
    oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}
</script>

</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>