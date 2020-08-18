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
				<form name="frm_write" id="frm_write" method="post" action="outmall_upload_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="ins" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row" colspan="2"><span>**���ǻ���**</span></th>
							</tr>
							<tr>
								<th scope="row" colspan="2"><span>* ����(xlsȮ����)���ϸ� ���ε� �����մϴ�.</span></th>
							</tr>
							<tr>
								<th scope="row" colspan="2"><span>* ù��° ��Ʈ�� �����Ͱ� �־�� �մϴ�.(��Ʈ��:Sheet1)</span></th>
							</tr>
							<tr>
								<th scope="row" colspan="2"><span>* �����ۼ� �� �߰��� �� ���� ����� �մϴ�.</span></th>
							</tr>
							<tr>
								<td colspan="2">
									<a href="sample_excel.xls" class="function_btn"><span>���ôٿ�ε�</span></a>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td>
									<input type="file" name="upfile" value="" />
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="xlsInsert();" class="function_btn"><span>���</span></a>
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
function xlsInsert() {
	var f	= document.frm_write;

	if (f.upfile.value == "") {
		alert("������ �������ּ���.");
		return;
	}

	var fileNameLen		= f.upfile.value.length;

	if (f.upfile.value.substring(fileNameLen-3, fileNameLen) != "xls") {
		alert("Ȯ���ڰ� xls�� ���������� �������ּ���.");
		return;
	}

	f.submit();
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>