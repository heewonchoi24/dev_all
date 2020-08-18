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
		$('#lnb').menuModel2({hightLight:{level_1:4,level_2:5,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-product.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상품관리&gt; 세트그룹관리 &gt; <strong>건강즙</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="goods_group_hz_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="ins" />
					<input type="hidden" name="gubun1" value="60" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>구분2</span></th>
								<td class="td_edit">
									<select name="gubun2" id="gubun2">
										<option value="">선택</option>
									</select>
								</td>
								<th scope="row"><span>세트그룹코드</span></th>
								<td>
									<select name="group_code" id="group_code" required label="세트그룹코드" onchange="getGroup();">
										<option value="">코드선택</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>세트그룹명</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="group_name" id="group_name" value="" required label="세트그룹명" readonly="readonly" />
								</td>
								<th scope="row"><span>가격</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price" id="group_price" value="" required label="가격" dir="rtl" /> 원
								</td>
							</tr>
							<tr>
								<th scope="row"><span>상태</span></th>
								<td colspan="3">
									<label><input type="radio" name="seen" checked="checked"/> 비노출</label>
									<label><input type="radio" name="seen" /> 노출</label>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>태그</span></th>
								<td colspan="3">
									<label><input type="checkbox" name="tag" /> EVENT</label>
									<label><input type="checkbox" name="tag" /> 특가</label>
									<label><input type="checkbox" name="tag" /> SALE</label>
									<label><input type="checkbox" name="tag" /> NEW</label>
									<label><input type="checkbox" name="tag" /> 추천</label>
									<label><input type="checkbox" name="tag" /> 베스트</label>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>상품설명</span></th>
								<td colspan="3">
									<input type="text" name="group_info1" id="group_info1" style="width:100%;" maxlength="50" value=""/>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>평균칼로리</span></th>
								<td colspan="3">
									<input type="text" name="kal_info" id="kal_info" class="input1" maxlength="50" value=""/>	Kcal	(숫자만 기입)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>대표이미지</span></th>
								<td colspan="3">
									<input type="file" name="cart_img" value="" />
									(최적화 사이즈: 90 x 70)
								</td>
							</tr>
						</tbody>
					</table>
					<br />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>상품설명</span></th>
								<td class="td_edit">
									<textarea id="group_info" name="group_info" style="width:90%;height:100px;" type=editor></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>배송안내</span></th>
								<td class="">
									<table class="tableView" border="1" cellspacing="0">
										<colgroup>
											<col width="140px">
											<col>
										</colgroup>
										<tbody>
											<% for(int v = 1; v < 10; v++){ %>
											<tr>
												<th><span><input type="text" class="input4" id="delivery_notice_th_<%=v%>" name="delivery_notice_th_<%=v%>"></span></th>
												<td><input type="text" class="input4" id="delivery_notice_td_<%=v%>" name="delivery_notice_td_<%=v%>"></td>
											</tr>
											<% } %>
										</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>상품정보<br />제공고시</span></th>
								<td class="">
									<table class="tableView" border="1" cellspacing="0">
										<colgroup>
											<col width="140px">
											<col>
										</colgroup>
										<tbody>
											<% for(int v = 1; v < 31; v++){ %>
											<tr>
												<th><span><input type="text" class="input4" id="offer_notice_th_<%=v%>" name="offer_notice_th_<%=v%>"></span></th>
												<td><input type="text" class="input4" id="offer_notice_td_<%=v%>" name="offer_notice_td_<%=v%>"></td>
											</tr>
											<% } %>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_write)"  class="function_btn"><span>저장</span></a>
						<a href="goods_group_list.jsp" class="function_btn"><span>목록</span></a>
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
	$("#gubun2").change(getGroupCode);
});

function getGroupCode() {
	$.post("goods_group_ajax.jsp", {
		mode: "getCode",
		gubun1: '60',
		gubun2: $("#gubun2").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				var groupOptions	= '<option value="">코드선택</option>';
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					groupOptions	+= '<option value="'+ groupArr[0] +'">'+ groupArr[1] +'</option>';
				});
				$("#group_code").html(groupOptions);
				$("#group_name").val("");
				$("#group_price").val("");
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
					$("#group_code").html('<option value="">코드선택</option>');
					$("#group_name").val("");
					$("#group_price").val("");
				});
			}
		});
	}, "xml");
	return false;
}

function getGroup() {
	$.post("goods_group_ajax.jsp", {
		mode: "getGroup",
		group_code: $("#group_code").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				$(data).find("goodsName").each(function() {
					$("#group_name").val($(this).text());
				});
				$(data).find("goodsPrice").each(function() {
					$("#group_price").val($(this).text());
				});
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
					$("#group_name").val("");
					$("#group_price").val("");
				});
			}
		});
	}, "xml");
	return false;
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