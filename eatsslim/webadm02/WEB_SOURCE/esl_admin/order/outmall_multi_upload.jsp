<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String goodsCode	= "";
String goodsName	= "";
int cateId			= 0;
String cateName		= "";
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:5,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
	<script src="../js/grid/dist/jquery.handsontable.full.js"></script>
	<link rel="stylesheet" media="screen" href="../js/grid/dist/jquery.handsontable.full.css">
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-order.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; �ֹ����� &gt; <strong>�ܺθ� ���ε�</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<table class="tableView" border="1" cellspacing="0">
					<colgroup>
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" colspan="2"><span>** ���ε� ��� **</span></th>
						</tr>
						<tr>
							<th scope="row" colspan="2"><span>* ���������� �ٿ�ε� �ϼ���.</span></th>
						</tr>
						<tr>
							<th scope="row" colspan="2"><span>* �ٿ���� ������ �ֹ������� �Է��ϼ���.</span></th>
						</tr>
						<tr>
							<th scope="row" colspan="2"><span>* �ۼ��� ���븸 ����(Ctrl+C)�ؼ� ���ε念���� �ٿ��ְ�(Ctrl+V) ��Ϲ�ư�� Ŭ���ϼ���.</span></th>
						</tr>
						<tr>
							<td colspan="2">
								<a href="sample_excel.xls" class="function_btn"><span>���ôٿ�ε�</span></a>
							</td>
						</tr>
					</tbody>
				</table>
				<div id="dataTable"></div>
				<script>
				var data = [
					['','','','','','','','','','','','','','','','','','','','','','','','','',''],
				];
				$("#dataTable").handsontable({  data: data, 
					minSpareRows: 1, 
					colHeaders: [
					"&nbsp;Ǯ����ȸ��������ȣ&nbsp;", 
					"&nbsp;�ս������̵�&nbsp;",
					"&nbsp;�ֹ��ڸ�&nbsp;",
					"&nbsp;�����ڸ�&nbsp;", 
					"&nbsp;�����ڱ⺻�ּ�&nbsp;",
					"&nbsp;�����ڿ����ȣ&nbsp;",
					"&nbsp;�����ڻ��ּ�&nbsp;",
					"&nbsp;�������ڵ�����ȣ&nbsp;",
					"&nbsp;��������ȭ��ȣ&nbsp;",
					"&nbsp;��ۿ�û����&nbsp;",
					"&nbsp;��ǰ�Ѿ�&nbsp;",
					"&nbsp;��ۺ�&nbsp;",
					"&nbsp;�����Ѿ�&nbsp;",
					"&nbsp;�����Ѿ�&nbsp;",
					"&nbsp;��������&nbsp;",
					"&nbsp;�ֹ�����&nbsp;",
					"&nbsp;��ǰ�ڵ�&nbsp;",
					"&nbsp;���Ÿ��&nbsp;",
					"&nbsp;�ֹ�����&nbsp;",
					"&nbsp;ù�����&nbsp;",
					"&nbsp;��۱Ⱓ(��)&nbsp;",
					"&nbsp;��۱Ⱓ(��)&nbsp;",
					"&nbsp;���ð��汸�ſ���&nbsp;",
					"&nbsp;��ũ������Ÿ��&nbsp;",
					"&nbsp;�ܺθ��ֹ���ȣ&nbsp;",
					"&nbsp;�ܺθ��ڵ�&nbsp;"
					]
				});
				</script>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<div class="btn_center">
					<a href="javascript:;" onclick="fAjax_upload();return false;" id="upload_btn" class="function_btn"><span>���</span></a>
					<span id="upload_wait" class="hidden">ó�����Դϴ�...</span>
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
function fAjax_upload() {
	if(document.stat_upload) return;
	document.stat_upload = true;
	$("#upload_btn").addClass("hidden");
	$("#upload_wait").removeClass("hidden");

	$.ajax({
		url: 'outmall_multi_upload_ajax.jsp',
		data: {"data": $('#dataTable').handsontable('getData')}, 
		dataType: 'json',
		type : 'post',
		success: function(r) {
			document.stat_upload = false;
			$("#upload_wait").addClass("hidden");
			$("#upload_btn").removeClass("hidden");
			switch (r.rst) {
				case 'true':
					if (r.msg) alert(r.msg);
					alert('��ϰ���� �Ʒ��� �����ϴ�.\r\n\r\n��ϵ� �ֹ���: '+r.success+'\r\n��Ͻ��� �ֹ���: '+r.fail);
					for (i=r.success; i>0; i--) {
						$('#dataTable').handsontable('alter', 'remove_row', r.success_arr[i-1]);
					}
				break;
				case 'false':
					alert(r.msg);
					if (r.ctrl) {
						try{eval('document.form_xls_r.'+r.ctrl).select();}catch(e){;}
						try{eval('document.form_xls_r.'+r.ctrl).focus();}catch(e){;}
					}
				break;
			}
		},
		error: function(r, textStatus, err){
			document.stat_upload = false;
			$("#upload_wait").addClass("hidden");
			$("#upload_btn").removeClass("hidden");
			alert('�������� ��ſ� �����Ͽ����ϴ�.');
		},
		complete: function() {
			document.stat_upload = false;
			$("#upload_wait").addClass("hidden");
			$("#upload_btn").removeClass("hidden");
		}
	});

}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>