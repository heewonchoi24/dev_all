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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ���θ�ǰ��� &gt; <strong>�̺�Ʈ</strong></p>
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
								<th scope="row"><span>��/����� ����</span></th>
								<td>
									<input type="radio" name="gubun" value="0" checked="checked" />
									���
									<input type="radio" name="gubun" value="1" />
									��
									<input type="radio" name="gubun" value="2" />
									�����
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�̺�Ʈ ����</span></th>
								<td>
									<input type="radio" name="event_type" value="01" checked="checked" />
									EVENT
									<input type="radio" name="event_type" value="02" />
									SALE
									<input type="radio" name="event_type" value="03" />
									�귣����ũ
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td>
									<input type="text" name="title" id="title" required label="����" class="input1" style="width:400px;" maxlength="100" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��������</span></th>
								<td>
									<input type="radio" name="open_yn" value="Y" checked="checked" />
									����
									<input type="radio" name="open_yn" value="N" />
									�̰���
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�̺�Ʈ �Ⱓ</span></th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="8" readonly="readonly" required label="��������" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="8" readonly="readonly" required label="��������" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�̺�Ʈ ���</span></th>
								<td>
									<input type="text" name="event_target" id="event_target" class="input1" style="width:200px;" maxlength="50" value="�ս��� ��ȸ��" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��÷�ڹ�ǥ��</span></th>
								<td>
									<input type="text" name="anc_date" id="anc_date" class="input1" maxlength="8" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td>
									<textarea id="content" name="content" style="height:500px;width:100%;" type=editor></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����ϳ���</span></th>
								<td>
									<textarea id="mcontent" name="mcontent" style="height:500px;width:100%;" type=editor></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����Ʈ�� �̹���</span></th>
								<td colspan="3">
									<input type="file" name="list_img" value="" />
									(����ȭ ������: 608 x 203)
								</td>
							</tr>

							<tr>
								<th scope="row"><span>��� �̹���</span></th>
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
									<span>ü��� ��ǰ���(�ɼ�)</span>
									<a href="javascript:;" id="addGoodsBtn" class="function_btn"><span style="padding: 7px 8px 0 5px;">�߰�</span></a>
								</th>
							</tr>
							<tr class="goods_item0 hidden">
								<th scope="row"><span>��ǰ��</span></th>
								<td>
									<input type="text" name="goods_name" class="input1" style="width:400px;" maxlength="50" />
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>����</span></a>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_write)" class="function_btn"><span>����</span></a>
						<a href="event_list.jsp" class="function_btn"><span>���</span></a>
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
<!-- �������� Ȱ��ȭ ��ũ��Ʈ -->
<script src="/editor/editor_board.js"></script>
<script>
	mini_editor('/editor/');							
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>