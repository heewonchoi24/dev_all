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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ���θ�ǰ��� &gt; <strong>���̾�Ʈ �ϱ�</strong></p>
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
								<th scope="row"><span>�����</span></th>
								<td>
									<select name="versus" id="versus">
										<option value="1"<%if (versus.equals("1")) out.println(" selected=\"selected\"");%>>�ְ���</option>
										<option value="2"<%if (versus.equals("2")) out.println(" selected=\"selected\"");%>>�̴븮</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td>
									<select name="day" id="day">
										<%for (i = 1; i < 101; i++) {%>
										<option value="<%=i%>"<%if (day == i) out.println(" selected=\"selected\"");%>><%=i%>����</option>
										<%}%>
									</select>
									<select name="weekday" id="weekday">
										<option value="��"<%if (weekday.equals("��")) out.println(" selected=\"selected\"");%>>��</option>
										<option value="ȭ"<%if (weekday.equals("ȭ")) out.println(" selected=\"selected\"");%>>ȭ</option>
										<option value="��"<%if (weekday.equals("��")) out.println(" selected=\"selected\"");%>>��</option>
										<option value="��"<%if (weekday.equals("��")) out.println(" selected=\"selected\"");%>>��</option>
										<option value="��"<%if (weekday.equals("��")) out.println(" selected=\"selected\"");%>>��</option>
										<option value="��"<%if (weekday.equals("��")) out.println(" selected=\"selected\"");%>>��</option>
										<option value="��"<%if (weekday.equals("��")) out.println(" selected=\"selected\"");%>>��</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td>
									<input type="text" name="title" id="title" required label="����" class="input1" style="width:400px;" maxlength="100" value="<%=title%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td>
                                   <form id="f_content" name="f_content" method="post">
                                        <textarea name="content" id="content" style="height:500px;width:100%;"><%=content%></textarea>
                                    </form>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����Ʈ�� �̹���</span></th>
								<td colspan="3">
									<input type="file" name="up_img" value="<%=upImg%>" />
									<%if (!upImg.equals("")) {%>
										<br /><input type="checkbox" name="del_up_img" value="y" />����<br />
										<img src="<%=webUploadDir +"promotion/"+ upImg%>" />
									<%}%>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="submitContents()" class="function_btn"><span>����</span></a>
						<a href="diary_list.jsp?<%=param%>" class="function_btn"><span>���</span></a>
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

<!-- smart editor 2.0 -->
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "content",
    sSkinURI: "/smarteditor/SmartEditor2Skin.html",
    fCreator: "createSEditor2",
    // ���� ��� ���� (true:���/ false:������� ����)
    bUseToolbar : true,           
    // �Է�â ũ�� ������ ��� ���� (true:���/ false:������� ����)
    bUseVerticalResizer : true,   
    // ��� ��(Editor | HTML | TEXT) ��� ���� (true:���/ false:������� ����)
    bUseModeChanger : true
});
// �����塯 ��ư�� ������ �� ������ ���� �׼��� ���� �� submitContents�� ȣ��ȴٰ� �����Ѵ�.
function submitContents() {
    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
    if($("#title").val() == ""){
        alert("[����] �ʼ� �Է� �����Դϴ�");
        $("#title").focus();
        return false;
    }
    if(confirm('���� �Ͻðڽ��ϱ�?') ){
		document.frm_edit.submit();
		var forms = document.f_content;
		forms.submit();       
    }
}
// 2013.06.27 ������������ SmartEditor2 (program/common/se2) ����÷�α��
function pasteHTML(filepath){
    var sHTML = '<span style="color:#FF0000;"><img src="'+filepath+'"></span>';
    oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}
</script>

</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>