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

int reply_count = 0;
int reply_id = 0;
int reply_idx = 0;

String m_id = "";
String m_name = "";
String reply_content = "";
String reply_content2 = "";
String reply_date = "";
String reply_date2 = "";
String reply_mode = "write";


if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	pressId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT TITLE, CONTENT, LIST_IMG, PRESS_URL";
	query		+= " FROM ESL_EVENT_HOUSEWIFE";
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
		$('#lnb').menuModel2({hightLight:{level_1:10,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 이벤트 &gt; <strong>주부 다이어트 대결</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="event_housewife_db.jsp" enctype="multipart/form-data">
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

							<!--tr>
								<th scope="row"><span>구분</span></th>
								<td>
									<select name="press_url" id="press_url">
										<option value="1">워킹맘</option>
										<option value="2">가사맘</option>
									</select>
									<script>$("#press_url").val('<%=pressUrl%>');</script>								
								</td>
							</tr-->
							<input type="hidden" name="press_url" value="1" />
							<tr>
								<th scope="row"><span>내용</span></th>
								<td>
									<textarea id="content" name="content" style="height:500px;width:100%;" type=editor><%=content%></textarea>
									<!-- 웹에디터 활성화 스크립트 -->
									<script src="/editor/editor_board.js"></script>
									<script>
										mini_editor('/editor/');							
									</script>

									<!--
									<FCK:editor id="content" basePath="/FCKeditor/"
									width="600"
									height="400"
									toolbarSet="Eatsslim"
									customConfigurationsPath="/FCKeditor/fckconfig.js">	
									<%=content%>
									</FCK:editor>
									-->
								</td>
							</tr>
							<tr>
								<th scope="row"><span>리스트용 이미지</span></th>
								<td colspan="3">
									<input type="file" name="list_img" value="<%=listImg%>" />
									(최적화 사이즈: 220 x *)
									<%if (!listImg.equals("")) {%>
										<br /><input type="checkbox" name="del_list_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"promotion/"+ listImg%>" width="160" height="108" />
									<%}%>
								</td>
							</tr>

						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_edit)" class="function_btn"><span>수정</span></a>
						<a href="event_housewife.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
					</div>
				</form>

				<!-- 댓글 시작 -->

				<script>
					function reply_del(idx){
						var f = eval("document.reply_write"+ idx);
						if(confirm("삭제하시겠습니까?")){
							f.mode.value = "del";
							f.reply_idx.value = idx;
							f.action="event_housewife_edit_reply_db.jsp";
							f.submit();
						}
					}


					function reply_del2(idx){
						var f = eval("document.reply_write"+ idx);
						if(confirm("삭제하시겠습니까?")){
							f.mode.value = "del2";
							f.reply_idx.value = idx;
							f.action="event_housewife_edit_reply_db.jsp";
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
						
						f.action="event_housewife_edit_reply_db.jsp";
						f.submit();
					}


					
					
				</script>

				<%
					//댓글수
					query		= "SELECT COUNT(ID) FROM ESL_EVENT_HOUSEWIFE_REPLY where ID="+pressId+"";

					pstmt		= conn.prepareStatement(query);
					rs			= pstmt.executeQuery();
					if (rs.next()) {
						reply_count = rs.getInt(1); //총 레코드 수		
					}
					if (rs != null) try { rs.close(); } catch (Exception e) {}
					if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				%>

				<div>
					<p>댓글수(<%=reply_count%>)</p>

							<ul style="padding-top:10px">
							    <li class="comment depth-1" >

									<%
									query		= "SELECT * ";
									query		+= " FROM ESL_EVENT_HOUSEWIFE_REPLY where ID="+pressId+"";
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
									   <p><%=ut.nl2br(reply_content)%></p>
										
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
<script type="text/javascript">
$(document).ready(function() {
	$("#title").focus();
});
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>