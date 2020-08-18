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
String postType			= ut.inject(request.getParameter("post_type"));
String schCate			= ut.inject(request.getParameter("sch_cate"));
String field			= ut.inject(request.getParameter("field"));

int reply_count			= 0;
int reply_id			= 0;
int reply_idx			= 0;

String m_id				= "";
String m_name			= "";
String reply_content	= "";
String reply_content2	= "";
String reply_date		= "";
String reply_date2		= "";
String reply_mode		= "write";
String best_set			= "";

DecimalFormat df = new DecimalFormat("00");
Calendar calendar = Calendar.getInstance();

String year				= Integer.toString(calendar.get(Calendar.YEAR)); //년도를 구한다
String month			= df.format(calendar.get(Calendar.MONTH) + 1); //달을 구한다


if (request.getParameter("keyword") != null) {
	keyword		= ut.inject(request.getParameter("keyword"));
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param		= "page="+ iPage +"&pgsize="+ pgsize +"&post_type="+ postType +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	pressId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT TITLE, CONTENT, LIST_IMG, PRESS_URL,best_set";
	query		+= " FROM ESL_PO";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, pressId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
		listImg			= rs.getString("LIST_IMG");
		best_set			= rs.getString("best_set");
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
		<%@ include file="../include/inc-sidebar-board.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 게시판관리 &gt; <strong>GO다이어트컬럼</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="po_db.jsp" enctype="multipart/form-data">
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
								<th scope="row"><span>구분</span></th>
								<td>
									<select name="press_url" id="press_url">
										<option value="4">이벤트후기</option>
										<option value="1">식사다이어트</option>
										<option value="2">프로그램다이어트</option>
										<option value="3">타입별다이어트</option>
									</select>					
									<script>$("#press_url").val('<%=pressUrl%>');</script>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>베스트설정</span></th>
								<td>
									<select name="best_set" id="best_set">
										<option value="">설정안함</option>
										<option value="<%=year%>-<%=month%>"><%=year%>년 <%=month%>월</option>
									</select>					
									<script>$("#best_set").val('<%=best_set%>');</script>
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
							<tr>
								<th scope="row"><span>리스트용 이미지</span></th>
								<td colspan="3">
									<input type="file" name="list_img" value="<%=listImg%>" />									
									<%if (!listImg.equals("")) {%>
										<br /><input type="checkbox" name="del_list_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"board/"+ listImg%>" width="160" height="108" />
									<%}%>
								</td>
							</tr>

						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="submitContents()" class="function_btn"><span>수정</span></a>
						<a href="po_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
					</div>
				</form>
				<!-- 댓글 시작 -->
				<script>
					function reply_del(idx){
						var f = eval("document.reply_write"+ idx);
						if(confirm("삭제하시겠습니까?")){
							f.mode.value = "del";
							f.reply_idx.value = idx;
							f.action="po_edit_reply_db.jsp";
							f.submit();
						}
					}

					function reply_del2(idx){
						var f = eval("document.reply_write"+ idx);
						if(confirm("삭제하시겠습니까?")){
							f.mode.value = "del2";
							f.reply_idx.value = idx;
							f.action="po_edit_reply_db.jsp";
							f.submit();
						}
					}

					function reply_write_view(idx){
						
						$("#reply_form_re"+idx+"").show();

					}

					function reply_write(idx){
						var f = eval("document.reply_write"+ idx); 

						if(f.content.value==""){
							alert('내용을 입력하세요');
							f.content.focus();
							return;
						}
						
						f.action="po_edit_reply_db.jsp";
						f.submit();
					}

					function chk_comment(){
						var f = document.frm_comment; 

						if(f.comment.value==""){
							alert('내용을 입력하세요');
							f.comment.focus();
							return;
						}
						
						f.action="po_edit_reply_db.jsp";
						f.submit();
					}
				</script>

				<%
					//댓글수
					query		= "SELECT COUNT(ID) FROM ESL_PO_REPLY where ID="+pressId+"";

					pstmt		= conn.prepareStatement(query);
					rs			= pstmt.executeQuery();
					if (rs.next()) {
						reply_count = rs.getInt(1); //총 레코드 수		
					}
					if (rs != null) try { rs.close(); } catch (Exception e) {}
					if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				%>

				<div>
					<form name="frm_comment" method="post" action="" enctype="multipart/form-data">
						<input type="hidden" name="mode" value="comment" />
						<input type="hidden" name="id" value="<%=pressId%>" />
						<input type="hidden" name="iPage" value="<%=iPage%>" />
						<input type="hidden" name="pgsize" value="<%=pgsize%>" />
						<input type="hidden" name="keyword" value="<%=keyword%>" />
						<input type="hidden" name="field" value="<%=field%>" />
						<textarea id="comment" name="comment" class="auto-hint" title="" wrap="virtual" style="width:550px;height:100px"></textarea>
					</form>
					<a href="javascript:;" onclick="chk_comment();" class="function_btn"><span>댓글등록</span></a>
					<br />
					<br />
					<br />
					<p>댓글수(<%=reply_count%>)</p>

							<ul style="padding-top:10px">
							    <li class="comment depth-1" >

									<%
									query		= "SELECT * ";
									query		+= " FROM ESL_PO_REPLY where ID="+pressId+"";
									query		+= " ORDER BY IDX ASC";
									
									pstmt		= conn.prepareStatement(query);
									rs			= pstmt.executeQuery();
									%>



									<%
									if (reply_count > 0) {
										i		= 0;
										while (rs.next()) {
											reply_id		= rs.getInt("ID");
											reply_idx		= rs.getInt("IDX");
											m_id		= rs.getString("M_ID");
											m_name		= rs.getString("M_NAME");
											reply_content		= rs.getString("CONTENT");
											reply_content2		= (rs.getString("CONTENT2") == null)? "" : rs.getString("CONTENT2");
											reply_date		= rs.getString("INST_DATE");
											reply_date2		= rs.getString("RE_UPDT_DATE");

									%>
									
									<% if(i > 0){ %>
									<div class="lineSeparator" style="margin-bottom:10px"></div>
									<% } %>
								   <div class="commentheader">
								       <h5  style="float:left"><%=m_id%></h5>
									   <div class="metastamp" style="float:left;padding-left:30px"><%=reply_date.substring(0,16)%></div>
									   <div class="myadmin"  style="float:left;padding-left:30px">
									  
									   <a href="javascript:reply_del('<%=reply_idx%>');">삭제</a> | <a href="javascript:reply_write_view('<%=reply_idx%>');">댓글</a> 
									 
									   </div>
									   <p style="clear:both"><%=ut.nl2br(reply_content)%></p>
										
										<% if(reply_content2 != null && reply_content2 !="" ){ %>
										<div style="padding-left:10px;padding-top:10px">
									    <p>관리자 
											<% if(reply_date2 == null){ %>

											<% }else{ %>
											<%=reply_date2.substring(0,16)%>
											<% } %>

											&nbsp;<a href="javascript:reply_del2('<%=reply_idx%>');">삭제</a> | <a href="javascript:reply_write_view('<%=reply_idx%>');">수정</a>
										</p>
									    <p><%=ut.nl2br(reply_content2)%></p>
									    </div>

										<% } %>
								   </div>
								   
								   

								

								   <p id="reply_form_re<%=reply_idx%>" style="display:none">

									  <form name="reply_write<%=reply_idx%>" method="post" action="" enctype="multipart/form-data">
									  <input type="hidden" name="m_id" value="<%=m_id%>">
									  <input type="hidden" name="m_name" value="<%=m_name%>">
									  <input type="hidden" name="id" value="<%=pressId%>">
									  <input type="hidden" name="mode" value="<%=reply_mode%>">
									  <input type="hidden" name="reply_idx" value="<%=reply_idx%>">
									  <input type="hidden" name="iPage" value="<%=iPage%>">
									  <input type="hidden" name="pgsize" value="<%=pgsize%>">
									  <input type="hidden" name="keyword" value="<%=keyword%>">
									  <input type="hidden" name="field" value="<%=field%>">
									 

										<textarea id="content" name="content" class="auto-hint" title="" wrap="virtual" style="width:550px;height:100px"><%=reply_content2%></textarea>
									  </form>

									  <br />
									  <a href="javascript:reply_write('<%=reply_idx%>');"  class="function_btn"><span>댓글등록</span></a>

								   </p>

									<%

											i++;
										}
									}
									%>

								</li>
							</ul>
				</div>
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