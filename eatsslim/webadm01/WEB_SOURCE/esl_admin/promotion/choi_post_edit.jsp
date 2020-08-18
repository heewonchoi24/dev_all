<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_CHOI_POSTSCRIPT";
int postId				= 0;
String query			= "";
String title			= "";
String content			= "";
String listImg			= "";
String category			= "";
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

String year				= Integer.toString(calendar.get(Calendar.YEAR)); //�⵵�� ���Ѵ�
String month			= df.format(calendar.get(Calendar.MONTH) + 1); //���� ���Ѵ�


if (request.getParameter("keyword") != null) {
	keyword		= ut.inject(request.getParameter("keyword"));
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param		= "page="+ iPage +"&pgsize="+ pgsize +"&post_type="+ postType +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	postId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT TITLE, CONTENT, LIST_IMG, CATEGORY, BEST_SET";
	query		+= " FROM "+ table;
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, postId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
		listImg			= rs.getString("LIST_IMG");
		best_set		= rs.getString("BEST_SET");
		category		= (rs.getString("CATEGORY") == null)? "" : rs.getString("CATEGORY");
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
		$('#lnb').menuModel2({hightLight:{level_1:9,level_2:4,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ���θ�ǰ��� &gt; <strong>�ְ����� ��� �ս��� ü���ı�</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="choi_post_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=postId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="org_list_img" value="<%=listImg%>" />
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
								<th scope="row"><span>����</span></th>
								<td>
									<select name="category" id="category">
										<option value="1">�Ļ���̾�Ʈ</option>
										<option value="2">���α׷����̾�Ʈ</option>
										<option value="3">Ÿ�Ժ����̾�Ʈ</option>
									</select>					
									<script>$("#category").val('<%=category%>');</script>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����Ʈ����</span></th>
								<td>
									<select name="best_set" id="best_set">
										<option value="">��������</option>
										<option value="<%=year%>-<%=month%>"><%=year%>�� <%=month%>��</option>
									</select>					
									<script>$("#best_set").val('<%=best_set%>');</script>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td>
									<textarea id="content" name="content" style="height:500px;width:100%;" type=editor><%=content%></textarea>
									<!-- �������� Ȱ��ȭ ��ũ��Ʈ -->
									<script src="/editor/editor_board.js"></script>
									<script>
										mini_editor('/editor/');							
									</script>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����Ʈ�� �̹���</span></th>
								<td colspan="3">
									<input type="file" name="list_img" value="<%=listImg%>" />									
									<%if (!listImg.equals("")) {%>
										<br /><input type="checkbox" name="del_list_img" value="y" />����<br />
										<img src="<%=webUploadDir +"board/"+ listImg%>" width="160" height="108" />
									<%}%>
								</td>
							</tr>

						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_edit)" class="function_btn"><span>����</span></a>
						<a href="choi_post_list.jsp?<%=param%>" class="function_btn"><span>���</span></a>
					</div>
				</form>
				<!-- ��� ���� -->
				<script>
					function reply_del(idx){
						var f = eval("document.reply_write"+ idx);
						if(confirm("�����Ͻðڽ��ϱ�?")){
							f.mode.value = "del";
							f.reply_idx.value = idx;
							f.action="choi_post_edit_reply_db.jsp";
							f.submit();
						}
					}

					function reply_del2(idx){
						var f = eval("document.reply_write"+ idx);
						if(confirm("�����Ͻðڽ��ϱ�?")){
							f.mode.value = "del2";
							f.reply_idx.value = idx;
							f.action="choi_post_edit_reply_db.jsp";
							f.submit();
						}
					}

					function reply_write_view(idx){						
						$("#reply_form_re"+idx+"").show();
					}

					function reply_write(idx){
						var f = eval("document.reply_write"+ idx); 

						if(f.content.value==""){
							alert('������ �Է��ϼ���');
							f.content.focus();
							return;
						}
						
						f.action="choi_post_edit_reply_db.jsp";
						f.submit();
					}
					
					function chk_comment(){
						var f = document.frm_comment; 

						if(f.comment.value==""){
							alert('������ �Է��ϼ���');
							f.comment.focus();
							return;
						}
						
						f.action="choi_post_edit_reply_db.jsp";
						f.submit();
					}
				</script>

				<%
					//��ۼ�
					query		= "SELECT COUNT(ID) FROM "+ table +"_COMMENT WHERE CP_ID="+postId+"";
					pstmt		= conn.prepareStatement(query);
					rs			= pstmt.executeQuery();
					if (rs.next()) {
						reply_count = rs.getInt(1); //�� ���ڵ� ��		
					}
					if (rs != null) try { rs.close(); } catch (Exception e) {}
					if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				%>

				<div>
					<form name="frm_comment" method="post" action="" enctype="multipart/form-data">
						<input type="hidden" name="mode" value="comment" />
						<input type="hidden" name="id" value="<%=postId%>" />
						<input type="hidden" name="iPage" value="<%=iPage%>" />
						<input type="hidden" name="pgsize" value="<%=pgsize%>" />
						<input type="hidden" name="keyword" value="<%=keyword%>" />
						<input type="hidden" name="field" value="<%=field%>" />
						<textarea id="comment" name="comment" class="auto-hint" title="" wrap="virtual" style="width:550px;height:100px"></textarea>
					</form>
					<a href="javascript:;" onclick="chk_comment();" class="function_btn"><span>��۵��</span></a>
					<br />
					<br />
					<br />
					<p>��ۼ�(<%=reply_count%>)</p>
					<ul style="padding-top:10px">
						<li class="comment depth-1" >
							<%
							query		= "SELECT * ";
							query		+= " FROM "+ table +"_COMMENT WHERE CP_ID="+postId+"";
							query		+= " ORDER BY ID DESC";									
							pstmt		= conn.prepareStatement(query);
							rs			= pstmt.executeQuery();

							if (reply_count > 0) {
								i		= 0;
								while (rs.next()) {
									reply_id		= rs.getInt("CP_ID");
									reply_idx		= rs.getInt("ID");
									m_id			= rs.getString("MEMBER_ID");
									m_name			= rs.getString("MEMBER_NAME");
									reply_content	= rs.getString("CONTENT");
									reply_content2	= (rs.getString("ANSWER") == null)? "" : rs.getString("ANSWER");
									reply_date		= rs.getString("INST_DATE");
									reply_date2		= rs.getString("ANSWER_DATE");
							%>							
							<% if(i > 0){ %>
							<div class="lineSeparator" style="margin-bottom:10px"></div>
							<% } %>
							<div class="commentheader">
								<h5  style="float:left"><%=m_id%></h5>
								<div class="metastamp" style="float:left;padding-left:30px"><%=reply_date.substring(0,16)%></div>
								<div class="myadmin"  style="float:left;padding-left:30px">
									<a href="javascript:reply_del('<%=reply_idx%>');">����</a> | <a href="javascript:reply_write_view('<%=reply_idx%>');">���</a> 
								</div>
								<p style="clear:both"><%=ut.nl2br(reply_content)%></p>
								<% if(reply_content2 != null && reply_content2 !="" ){ %>
								<div style="padding-left:10px;padding-top:10px">
									<p>������ 
									<% if(reply_date2 == null){ %>
									<% }else{ %>
									<%=reply_date2.substring(0,16)%>
									<% } %>
									&nbsp;<a href="javascript:reply_del2('<%=reply_idx%>');">����</a> | <a href="javascript:reply_write_view('<%=reply_idx%>');">����</a>
									</p>
									<p><%=ut.nl2br(reply_content2)%></p>
								</div>
								<% } %>
							</div>
							<p id="reply_form_re<%=reply_idx%>" style="display:none">
								<form name="reply_write<%=reply_idx%>" method="post" action="" enctype="multipart/form-data">
									<input type="hidden" name="m_id" value="<%=m_id%>">
									<input type="hidden" name="m_name" value="<%=m_name%>">
									<input type="hidden" name="id" value="<%=postId%>">
									<input type="hidden" name="mode" value="<%=reply_mode%>">
									<input type="hidden" name="reply_idx" value="<%=reply_idx%>">
									<input type="hidden" name="iPage" value="<%=iPage%>">
									<input type="hidden" name="pgsize" value="<%=pgsize%>">
									<input type="hidden" name="keyword" value="<%=keyword%>">
									<input type="hidden" name="field" value="<%=field%>">
									<textarea id="content" name="content" class="auto-hint" title="" wrap="virtual" style="width:550px;height:100px"><%=reply_content2%></textarea>
								</form>
								<br />
								<a href="javascript:reply_write('<%=reply_idx%>');"  class="function_btn"><span>��۵��</span></a>
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