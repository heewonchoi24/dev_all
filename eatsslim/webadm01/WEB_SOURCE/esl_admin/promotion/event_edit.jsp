<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

int eventId				= 0;
String query			= "";
String gubun			= "";
String eventType		= "";
String title			= "";
String openYn			= "";
String stdate			= "";
String ltdate			= "";
String eventTarget		= "";
String ancDate			= "";
String content			= "";
String mcontent			= "";
String listImg			= "";
String viewImg			= "";
String eventUrl			= "";
String goodsName		= "";
String param			= "";
String keyword			= "";
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String schCate			= ut.inject(request.getParameter("sch_cate"));
String field			= ut.inject(request.getParameter("field"));

int pressId = 0;
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
String reply_goodsName	= "";

if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	eventId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT GUBUN, EVENT_TYPE, TITLE, OPEN_YN, STDATE, LTDATE, EVENT_TARGET, ANC_DATE, CONTENT, CONTENT_MOBILE, LIST_IMG, VIEW_IMG, EVENT_URL";
	query		+= " FROM ESL_EVENT";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, eventId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		gubun			= rs.getString("GUBUN");
		eventType		= rs.getString("EVENT_TYPE");
		title			= rs.getString("TITLE");
		openYn			= rs.getString("OPEN_YN");
		stdate			= rs.getString("STDATE");
		ltdate			= rs.getString("LTDATE");
		eventTarget		= rs.getString("EVENT_TARGET");
		ancDate			= rs.getString("ANC_DATE");
		content			= rs.getString("CONTENT");
		mcontent		= rs.getString("CONTENT_MOBILE");
		listImg			= rs.getString("LIST_IMG");
		viewImg			= (rs.getString("VIEW_IMG") == null)? "" : rs.getString("VIEW_IMG");
		eventUrl		= (rs.getString("EVENT_URL") == null)? "" : rs.getString("EVENT_URL");
	}
} else {
	ut.jsBack(out);
	if (true) return;
}
%>

	<%@ include file="../include/inc-cal-script.jsp" %>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:2,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 프로모션관리 &gt; <strong>이벤트</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="event_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=eventId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="org_list_img" value="<%=listImg%>" />
					<input type="hidden" name="org_view_img" value="<%=viewImg%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>웹/모바일 구분</span></th>
								<td>
									<input type="radio" name="gubun" value="0"<%if (gubun.equals("0")) out.println(" checked=\"checked\"");%> />
									모두
									<input type="radio" name="gubun" value="1"<%if (gubun.equals("1")) out.println(" checked=\"checked\"");%> />
									웹
									<input type="radio" name="gubun" value="2"<%if (gubun.equals("2")) out.println(" checked=\"checked\"");%> />
									모바일
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 구분</span></th>
								<td>
									<input type="radio" name="event_type" value="01"<%if (eventType.equals("01")) out.println(" checked=\"checked\"");%> />
									EVENT
									<input type="radio" name="event_type" value="02"<%if (eventType.equals("02")) out.println(" checked=\"checked\"");%> />
									SALE
									<input type="radio" name="event_type" value="03"<%if (eventType.equals("03")) out.println(" checked=\"checked\"");%> />
									브랜드위크
								</td>
							</tr>
							<tr>
								<th scope="row"><span>제목</span></th>
								<td>
									<input type="text" name="title" id="title" required label="제목" class="input1" style="width:400px;" maxlength="100" value="<%=title%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>공개여부</span></th>
								<td>
									<input type="radio" name="open_yn" value="Y"<%if (openYn.equals("Y")) out.println(" checked=\"checked\"");%> />
									공개
									<input type="radio" name="open_yn" value="N"<%if (openYn.equals("N")) out.println(" checked=\"checked\"");%> />
									미공개
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 기간</span></th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="8" readonly="readonly" required label="시작일자" value="<%=stdate%>" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="8" readonly="readonly" required label="마감일자" value="<%=ltdate%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 대상</span></th>
								<td>
									<input type="text" name="event_target" id="event_target" class="input1" style="width:200px;" maxlength="50" value="<%=eventTarget%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>당첨자발표일</span></th>
								<td>
									<input type="text" name="anc_date" id="anc_date" class="input1" maxlength="8" readonly="readonly" value="<%=ancDate%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>내용</span></th>
								<td>
									<textarea id="content" name="content" style="height:500px;width:100%;" type=editor><%=content%></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>모바일내용</span></th>
								<td>
									<textarea id="mcontent" name="mcontent" style="height:500px;width:100%;" type=editor><%=mcontent%></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>리스트용 이미지</span></th>
								<td colspan="3">
									<input type="file" name="list_img" value="<%=listImg%>" />
									(최적화 사이즈: 158 x 106)
									<%if (!listImg.equals("")) {%>
										<br /><input type="checkbox" name="del_list_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"promotion/"+ listImg%>" width="160" height="108" />
									<%}%>
								</td>
							</tr>

							<tr>
								<th scope="row"><span>뷰용 이미지</span></th>
								<td colspan="3">
									<input type="file" name="view_img" value="<%=viewImg%>" />
									(최적화 사이즈: 158 x 106)
									<%if (!viewImg.equals("")) {%>
										<br /><input type="checkbox" name="del_view_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"promotion/"+ viewImg%>" width="160" height="108" />
									<%}%>
								</td>
							</tr>

							<tr>
								<th scope="row"><span>URL</span></th>
								<td>
									<input type="text" name="event_url" id="event_url" class="input1" style="width:400px;" maxlength="100" value="<%=eventUrl%>" />
								</td>
							</tr>
						</tbody>
					</table>
					<br />
					<table id="goodsTable" class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
							<col width="80px" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col" colspan="5" style="text-align:center">
									<span>체험단 제품등록(옵션)</span>
									<a href="javascript:;" id="addGoodsBtn" class="function_btn"><span style="padding: 7px 8px 0 5px;">추가</span></a>
								</th>
							</tr>
							<tr class="goods_item0 hidden">
								<th scope="row"><span>제품명</span></th>
								<td>
									<input type="text" name="goods_name" class="input1" style="width:400px;" maxlength="100" />
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>삭제</span></a>
								</td>
							</tr>
							<%
							query		= "SELECT GOODS_NAME FROM ESL_EVENT_GOODS WHERE EVENT_ID = ? ORDER BY ID";
							pstmt		= conn.prepareStatement(query);
							pstmt.setInt(1, eventId);
							rs			= pstmt.executeQuery();

							i = 1;
							while (rs.next()) {
								goodsName		= rs.getString("GOODS_NAME");
							%>
							<tr class="goods_item<%=i%>">
								<th scope="row"><span>제품명</span></th>
								<td>
									<input type="text" name="goods_name" class="input1" style="width:400px;" maxlength="50" value="<%=goodsName%>" />
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>삭제</span></a>
								</td>
							</tr>
							<%
								i++;
							}

							if (rs != null) try { rs.close(); } catch (Exception e) {}
							if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
							%>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_edit)" class="function_btn"><span>수정</span></a>
						<a href="event_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
					</div>
				</form>
				<!-- 댓글 시작 -->
				<%
				//댓글수
				pressId = eventId;
				query		= "SELECT COUNT(ID) FROM ESL_EVENT_REPLY where ID="+pressId+"";

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
						query		+= " FROM ESL_EVENT_REPLY where ID="+pressId+"";
						query		+= " ORDER BY IDX DESC";

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
								reply_goodsName	= ut.isnull(rs.getString("GOODS_NAME"));
						%>							
						<%		if(i > 0){ %>
						<div class="lineSeparator" style="margin-bottom:10px"></div>
						<%		} %>
						<div class="commentheader">
							<h5  style="float:left"><%=m_id%></h5>
							<div class="metastamp" style="float:left;padding-left:30px"><%=reply_date.substring(0,16)%></div>
							<div class="myadmin"  style="float:left;padding-left:30px">							  
								<a href="javascript:reply_del('<%=reply_idx%>');">삭제</a> | <a href="javascript:reply_write_view('<%=reply_idx%>');">댓글</a>							 
							</div>
							<p style="clear:both">
								<%if (!reply_goodsName.equals("")) {%>
								[<%=reply_goodsName%>]
								<%}%>
								<%=ut.nl2br(reply_content)%>
							</p>
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
	$('#stdate,#ltdate').datepick({ 
		onSelect: setPeriod,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$("#anc_date").datepick({
	    dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$("#addGoodsBtn").click(function(){
		var lastItemNo = $("#goodsTable tr:last").attr("class").replace("goods_item", "");

		var newitem = $("#goodsTable tr:eq(1)").clone();
		newitem.removeClass();
		newitem.find("td:eq(0)").attr("rowspan", "1");
		newitem.addClass("goods_item"+(parseInt(lastItemNo)+1));
		newitem.removeClass("hidden");

		$("#goodsTable").append(newitem);
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

function delTr(obj) {
	$(obj).parent().parent().remove();
}

function reply_del(idx){
	var f = eval("document.reply_write"+ idx);
	if(confirm("삭제하시겠습니까?")){
		f.mode.value = "del";
		f.reply_idx.value = idx;
		f.action="event_edit_reply_db.jsp";
		f.submit();
	}
}

function reply_del2(idx){
	var f = eval("document.reply_write"+ idx);
	if(confirm("삭제하시겠습니까?")){
		f.mode.value = "del2";
		f.reply_idx.value = idx;
		f.action="event_edit_reply_db.jsp";
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
	
	f.action="event_edit_reply_db.jsp";
	f.submit();
}
</script>
<!-- 웹에디터 활성화 스크립트 -->
<script src="/editor/editor_board.js"></script>
<script>
mini_editor('/editor/');							
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>