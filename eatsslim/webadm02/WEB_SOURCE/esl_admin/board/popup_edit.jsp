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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; �Խ��ǰ��� &gt; <strong>�˾�����</strong></p>
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
								<th scope="row"><span>����</span></th>
								<td>
									<input type="text" name="title" id="title" required label="����" class="input1" style="width:400px;" maxlength="100" value="<%=title%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�Ӽ�</span></th>
								<td>
									<input type="text" name="attr" id="attr" required label="�Ӽ�" class="input1" style="width:400px;" maxlength="100" value="<%=attr%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>���뿩��</span></th>
								<td>
									<input type="radio" name="open_yn" value="Y"<%if(openYn.equals("Y")) out.print(" checked=\"checked\"");%> />
									����
									<input type="radio" name="open_yn" value="N"<%if(openYn.equals("N")) out.print(" checked=\"checked\"");%> />
									������
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�˾��Ⱓ</span></th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="8" readonly="readonly" required label="��������" value="<%=stdate%>" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="8" readonly="readonly" required label="��������" value="<%=ltdate%>" />
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
								<th scope="row"><span>LINK</span></th>
								<td>
									<input type="text" name="link" id="link" class="input1" style="width:400px;" maxlength="100" value="<%=link%>" />
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="submitContents()" class="function_btn"><span>����</span></a>
						<a href="popup_list.jsp" class="function_btn"><span>���</span></a>
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
    if($("#stdate").val() == ""){
        alert("[��������] �ʼ� �Է� �����Դϴ�");
        $("#stdate").focus();
        return false;
    }
    if($("#ltdate").val() == ""){
        alert("[��������] �ʼ� �Է� �����Դϴ�");
        $("#ltdate").focus();
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