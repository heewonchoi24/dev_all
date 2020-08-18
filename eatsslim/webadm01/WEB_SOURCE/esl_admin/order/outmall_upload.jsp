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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 주문관리 &gt; <strong>외부몰 업로드</strong></p>
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
								<th scope="row" colspan="2"><span>**주의사항**</span></th>
							</tr>
							<tr>
								<th scope="row" colspan="2"><span>* 엑셀(xls확장자)파일만 업로드 가능합니다.</span></th>
							</tr>
							<tr>
								<th scope="row" colspan="2"><span>* 첫번째 시트에 데이터가 있어야 합니다.(시트명:Sheet1)</span></th>
							</tr>
							<tr>
								<th scope="row" colspan="2"><span>* 엑셀작성 시 중간에 빈 줄이 없어야 합니다.</span></th>
							</tr>
							<tr>
								<td colspan="2">
									<a href="sample_excel.xls" class="function_btn"><span>샘플다운로드</span></a>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>파일</span></th>
								<td>
									<input type="file" name="upfile" value="" />
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="xlsInsert();" class="function_btn"><span>등록</span></a>
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
		alert("파일을 선택해주세요.");
		return;
	}

	var fileNameLen		= f.upfile.value.length;

	if (f.upfile.value.substring(fileNameLen-3, fileNameLen) != "xls") {
		alert("확장자가 xls인 엑셀파일을 선택해주세요.");
		return;
	}

	f.submit();
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>