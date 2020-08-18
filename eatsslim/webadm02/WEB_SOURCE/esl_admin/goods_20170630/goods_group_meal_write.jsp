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
String schGubun1			= ut.inject(request.getParameter("sch_gubun1"));
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:4,level_2:1,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상품관리&gt; 세트그룹관리 &gt; <strong>식사 다이어트</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="goods_group_meal_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="ins" />
					<input type="hidden" name="gubun1" value="01" />
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
								<td colspan="3" class="td_edit">
									<select name="gubun2" id="gubun2">
										<option value="">선택</option>
										<option value="11">1식</option>
										<option value="12">2식</option>
										<option value="13">3식</option>
										<option value="14">2식+간식</option>
										<option value="15">3식+간식</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>세트그룹명</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="group_name" id="group_name" value="" required label="세트그룹명" readonly="readonly" />
								</td>
								<th scope="row"><span>세트그룹코드</span></th>
								<td>
									<select name="group_code" id="group_code" required label="세트그룹코드" onchange="getGroup();">
										<option value="">코드선택</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>가격</span></th>
								<td colspan="3">
									기본가&nbsp;
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price" id="group_price" value="0" required label="기본가" dir="rtl" /> 원<br />
									2주 5일
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price1" id="group_price1" value="0" required label="2주 5일 가격" dir="rtl" /> 원
									| 2주 6일
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price2" id="group_price2" value="0" required label="2주 6일 가격" dir="rtl" /> 원<br />
									4주 5일
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price3" id="group_price3" value="0" required label="4주 5일 가격" dir="rtl" /> 원
									| 4주 6일
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price4" id="group_price4" value="0" required label="4주 6일 가격" dir="rtl" /> 원
								</td>
							</tr>
						</tbody>
					</table>
					<br />
					<table id="cateTable" class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="80px" />
							<col width="*" />
							<col width="80px" />
							<col width="80px" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col" colspan="4" style="text-align:center">
									<span>세트그룹구성</span>
									<a href="javascript:;" id="addCateBtn" class="function_btn"><span style="padding: 7px 8px 0 5px;">추가</span></a>
								</th>
							</tr>
							<tr>
								<th scope="col" style="text-align:center"><span>번호</span></th>
								<th scope="col" style="text-align:center"><span>카테고리</span></th>
								<th scope="col" style="text-align:center"><span>수량</span></th>
								<th scope="col" style="text-align:center"><span>삭제</span></th>
							</tr>
							<tr class="cate_item0 hidden">
								<td>-</td>
								<td>
									<select name="cate_code">
										<option value="">선택</option>
										<%
										query		= "SELECT ID, CATE_NAME FROM ESL_GOODS_CATEGORY WHERE OPEN_YN = 'Y'";
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											cateId		= rs.getInt("ID");
											cateName	= rs.getString("CATE_NAME");
										%>
										<option value="<%=cateId%>|<%=cateName%>"><%=cateName%></option>
										<%
										}
										%>
									</select>
								</td>
								<td>
									<input type="text" class="input1" style="width:60px;" name="amount" />
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>삭제</span></a>
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
								<th scope="row"><span>상품정보<br />제공고시</span></th>
								<td class="td_edit">
									<textarea id="offer_notice" name="offer_notice" style="width:90%;height:100px;" type=editor></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이미지(장바구니)</span></th>
								<td colspan="3">
									<input type="file" name="cart_img" value="" />
									(최적화 사이즈: 90 x 70)
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_write)"  class="function_btn"><span>저장</span></a>
						<a href="goods_group_list.jsp?sch_gubun1=<%=schGubun1%>" class="function_btn"><span>목록</span></a>
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
	$("#group_price").focusout(cngPrice);
	$("#addCateBtn").click(function(){
		var lastItemNo = $("#cateTable tr:last").attr("class").replace("cate_item", "");

		var newitem = $("#cateTable tr:eq(2)").clone();
		newitem.removeClass();
		newitem.find("td:eq(0)").attr("rowspan", "1");
		newitem.find("td:eq(0)").text(parseInt(lastItemNo)+1);
		newitem.addClass("cate_item"+(parseInt(lastItemNo)+1));
		newitem.removeClass("hidden");

		$("#cateTable").append(newitem);
	});
});

function getGroupCode() {
	$.post("goods_group_ajax.jsp", {
		mode: "getCode",
		gubun1: '01',
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
				$("#group_price").val(0);
				$("#group_price1").val(0);
				$("#group_price2").val(0);
				$("#group_price3").val(0);
				$("#group_price4").val(0);
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
					$("#group_code").html('<option value="">코드선택</option>');
					$("#group_name").val("");
					$("#group_price").val(0);
					$("#group_price1").val(0);
					$("#group_price2").val(0);
					$("#group_price3").val(0);
					$("#group_price4").val(0);
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
				var gprice1	= 10;
				var gprice2	= 12;
				var gprice3	= 20;
				var gprice4	= 24;
				$(data).find("goodsName").each(function() {
					$("#group_name").val($(this).text());
				});
				$(data).find("goodsPrice").each(function() {
					$("#group_price").val($(this).text());
					$("#group_price1").val(parseInt($(this).text()) * gprice1);
					$("#group_price2").val(parseInt($(this).text()) * gprice2);
					$("#group_price3").val(parseInt($(this).text()) * gprice3);
					$("#group_price4").val(parseInt($(this).text()) * gprice4);
				});
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
					$("#group_name").val("");
					$("#group_price").val(0);
					$("#group_price1").val(0);
					$("#group_price2").val(0);
					$("#group_price3").val(0);
					$("#group_price4").val(0);
				});
			}
		});
	}, "xml");
	return false;
}

function cngPrice() {
	var goodsPrice	= parseInt($("#group_price").val());
	var gprice1	= 10;
	var gprice2	= 12;
	var gprice3	= 20;
	var gprice4	= 24;

	$("#group_price1").val(goodsPrice * gprice1);
	$("#group_price2").val(goodsPrice * gprice2);
	$("#group_price3").val(goodsPrice * gprice3);
	$("#group_price4").val(goodsPrice * gprice4);
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