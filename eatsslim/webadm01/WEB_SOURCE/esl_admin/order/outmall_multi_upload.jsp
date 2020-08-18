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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 주문관리 &gt; <strong>외부몰 업로드</strong></p>
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
							<th scope="row" colspan="2"><span>** 업로드 방법 **</span></th>
						</tr>
						<tr>
							<th scope="row" colspan="2"><span>* 엑셀샘플을 다운로드 하세요.</span></th>
						</tr>
						<tr>
							<th scope="row" colspan="2"><span>* 다운받은 엑셀에 주문정보를 입력하세요.</span></th>
						</tr>
						<tr>
							<th scope="row" colspan="2"><span>* 작성한 내용만 복사(Ctrl+C)해서 업로드영역에 붙여넣고(Ctrl+V) 등록버튼을 클릭하세요.</span></th>
						</tr>
						<tr>
							<td colspan="2">
								<a href="sample_excel.xls" class="function_btn"><span>샘플다운로드</span></a>
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
					"&nbsp;풀무원회원고유번호&nbsp;", 
					"&nbsp;잇슬림아이디&nbsp;",
					"&nbsp;주문자명&nbsp;",
					"&nbsp;수령자명&nbsp;", 
					"&nbsp;수령자기본주소&nbsp;",
					"&nbsp;수령자우편번호&nbsp;",
					"&nbsp;수령자상세주소&nbsp;",
					"&nbsp;수령자핸드폰번호&nbsp;",
					"&nbsp;수령자전화번호&nbsp;",
					"&nbsp;배송요청사항&nbsp;",
					"&nbsp;상품총액&nbsp;",
					"&nbsp;배송비&nbsp;",
					"&nbsp;할인총액&nbsp;",
					"&nbsp;결제총액&nbsp;",
					"&nbsp;결제구분&nbsp;",
					"&nbsp;주문일자&nbsp;",
					"&nbsp;상품코드&nbsp;",
					"&nbsp;배송타입&nbsp;",
					"&nbsp;주문수량&nbsp;",
					"&nbsp;첫배송일&nbsp;",
					"&nbsp;배송기간(일)&nbsp;",
					"&nbsp;배송기간(주)&nbsp;",
					"&nbsp;보냉가방구매여부&nbsp;",
					"&nbsp;시크릿수프타입&nbsp;",
					"&nbsp;외부몰주문번호&nbsp;",
					"&nbsp;외부몰코드&nbsp;"
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
					<a href="javascript:;" onclick="fAjax_upload();return false;" id="upload_btn" class="function_btn"><span>등록</span></a>
					<span id="upload_wait" class="hidden">처리중입니다...</span>
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
					alert('등록결과는 아래와 같습니다.\r\n\r\n등록된 주문수: '+r.success+'\r\n등록실패 주문수: '+r.fail);
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
			alert('서버와의 통신에 실패하였습니다.');
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