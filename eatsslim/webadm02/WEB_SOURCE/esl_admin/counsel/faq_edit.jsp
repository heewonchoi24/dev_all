<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
<script type="text/javascript" src="/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/smarteditor/quick_photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"> </script>
<%
request.setCharacterEncoding("euc-kr");

int faqId			= 0;
String query			= "";
String faqType			= "";
String title			= "";
String content			= "";
String param			= "";
String keyword			= "";
String schType			= ut.inject(request.getParameter("sch_type"));
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String schCate			= ut.inject(request.getParameter("sch_cate"));
String field			= ut.inject(request.getParameter("field"));
if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&sch_type="+ schType +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	faqId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT FAQ_TYPE, TITLE, CONTENT";
	query		+= " FROM ESL_FAQ";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, faqId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		faqType			= rs.getString("FAQ_TYPE");
		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
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
		$('#lnb').menuModel2({hightLight:{level_1:2,level_2:4,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상담/문의관리 &gt; <strong>공지사항</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="faq_db.jsp">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=faqId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>구분</span></th>
								<td>
									<select name="faq_type" id="faq_type" required label="구분">
										<option value="">선택</option>
										<option value="01"<%if (faqType.equals("01")) out.println(" selected=\"selected\"");%>>교환/환불</option>
										<option value="02"<%if (faqType.equals("02")) out.println(" selected=\"selected\"");%>>회원관련</option>
										<option value="03"<%if (faqType.equals("03")) out.println(" selected=\"selected\"");%>>주문/결제</option>
										<option value="04"<%if (faqType.equals("04")) out.println(" selected=\"selected\"");%>>배송관련</option>
										<option value="09"<%if (faqType.equals("09")) out.println(" selected=\"selected\"");%>>기타</option>
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
                                   <form id="f_content" name="f_content" method="post">
                                        <textarea name="content" id="content" style="height:500px;width:100%;"><%=content%></textarea>
                                    </form>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="submitContents()" class="function_btn"><span>수정</span></a>
						<a href="faq_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
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
    if($("#faq_type").val() == ""){
        alert("[구분] 필수 입력 사항입니다");
        $("#title").focus();
        return false;
    }
	if($("#title").val() == ""){
        alert("[제목] 필수 입력 사항입니다");
        $("#title").focus();
        return false;
    }
    var ir1 = $("#content").val();
    if( ir1 == ""  || ir1 == null || ir1 == '&nbsp;' || ir1 == '<p>&nbsp;</p>' || ir1 == '<br>')  {
         alert("내용을 입력하세요.");
         oEditors.getById["content"].exec("FOCUS"); //포커싱
         return false;
    }
    if(confirm('수정 하시겠습니까?') ){
        document.frm_edit.submit();
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