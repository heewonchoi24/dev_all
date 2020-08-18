<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>

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
				<form name="frm_write" id="frm_write" method="post" action="event_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="ins" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>웹/모바일 구분</span></th>
								<td>
									<input type="radio" name="gubun" value="0" checked="checked" />
									모두
									<input type="radio" name="gubun" value="1" />
									웹
									<input type="radio" name="gubun" value="2" />
									모바일
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 구분</span></th>
								<td>
									<input type="radio" name="event_type" value="01" checked="checked" />
									EVENT
									<input type="radio" name="event_type" value="02" />
									SALE
									<input type="radio" name="event_type" value="03" />
									브랜드위크
								</td>
							</tr>
							<tr>
								<th scope="row"><span>제목</span></th>
								<td>
									<input type="text" name="title" id="title" required label="제목" class="input1" style="width:400px;" maxlength="100" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>공개여부</span></th>
								<td>
									<input type="radio" name="open_yn" value="Y" checked="checked" />
									공개
									<input type="radio" name="open_yn" value="N" />
									미공개
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 기간</span></th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="8" readonly="readonly" required label="시작일자" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="8" readonly="readonly" required label="마감일자" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 대상</span></th>
								<td>
									<input type="text" name="event_target" id="event_target" class="input1" style="width:200px;" maxlength="50" value="잇슬림 전회원" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>당첨자발표일</span></th>
								<td>
									<input type="text" name="anc_date" id="anc_date" class="input1" maxlength="8" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>내용</span></th>
								<td>
									<textarea id="content" name="content" style="height:500px;width:100%;" type=editor></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>모바일내용</span></th>
								<td>
									<textarea id="mcontent" name="mcontent" style="height:500px;width:100%;" type=editor></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>리스트용 이미지</span></th>
								<td colspan="3">
									<input type="file" name="list_img" value="" />
									(최적화 사이즈: 608 x 203)
								</td>
							</tr>

							<tr>
								<th scope="row"><span>뷰용 이미지</span></th>
								<td colspan="3">
									<input type="file" name="view_img" value="" />
								</td>
							</tr>

							<tr>
								<th scope="row"><span>URL</span></th>
								<td>
									<input type="text" name="event_url" id="event_url" class="input1" style="width:400px;" maxlength="100" />
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
									<input type="text" name="goods_name" class="input1" style="width:400px;" maxlength="50" />
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>삭제</span></a>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_write)" class="function_btn"><span>저장</span></a>
						<a href="event_list.jsp" class="function_btn"><span>목록</span></a>
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
</script>
<!-- 웹에디터 활성화 스크립트 -->
<script src="/editor/editor_board.js"></script>
<script>
	mini_editor('/editor/');							
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>