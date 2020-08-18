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
		$('#lnb').menuModel2({hightLight:{level_1:4,level_2:2,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상품관리&gt; 세트그룹관리 &gt; <strong>타입별 다이어트</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="goods_group_pg_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="ins" />
					<input type="hidden" name="gubun1" value="02" />
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
										<option value="21">감량프로그램</option>
										<option value="22">유지프로그램</option>
										<option value="23">FULL-STEP 프로그램</option>
									</select>
								</td>
								<th scope="row"><span>주차</span></th>
								<td>
									<select name="gubun3" id="gubun3">
										<option value="2">2주차</option>
										<option value="4">4주차</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>세트그룹명</span></th>
								<td><input type="text" name="group_name" style="width:200px;" maxlength="50" class="input1" required label="세트그룹명" /></td>
								<th scope="row"><span>가격</span></th>
								<td><input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price" id="group_price" value="" required label="가격" dir="rtl" /> 원</td>
							</tr>
						</tbody>
					</table>
					<br />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="220px" />
							<col width="*" />
							<col width="140px" />
							<col width="26%" />
							<col width="60px" />
							<col width="12%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>1주차</span></th>
								<td>
									<select name="item_code" id="item_code1" required label="1주차(월~목) 세트그룹코드" onchange="getGroup(1);">
										<option value="">코드선택</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_CODE IN ('0300606', '0300607', '0300611', '0300669', '0300671', '0300673', '0300676', '0300678') ORDER BY GOODS_CODE";
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											goodsCode	= rs.getString("GOODS_CODE");
											goodsName	= rs.getString("GOODS_NAME");
										%>
										<option value="<%=goodsCode%>"><%=goodsCode+"("+goodsName+")"%></option>
										<%
										}

										rs.close();
										pstmt.close();
										%>
									</select>
								</td>
								<th scope="row"><span>아이템명</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="item_name" id="item_name1" value="" required label="1주차(월~목) 아이템명" readonly="readonly" />
								</td>
								<th scope="row"><span>가격</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="item_price" id="item_price1" value="" required label="1주차(월~목) 가격" dir="rtl" /> 원
								</td>
							</tr>
							<tr>
								<th scope="row"><span>2주차</span></th>
								<td>
									<select name="item_code" id="item_code3" required label="2주차(월~목) 세트그룹코드" onchange="getGroup(3);">
										<option value="">코드선택</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_CODE IN ('0300606', '0300607', '0300611', '0300669', '0300671', '0300673', '0300676', '0300678') ORDER BY GOODS_CODE";
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											goodsCode	= rs.getString("GOODS_CODE");
											goodsName	= rs.getString("GOODS_NAME");
										%>
										<option value="<%=goodsCode%>"><%=goodsCode+"("+goodsName+")"%></option>
										<%
										}

										rs.close();
										pstmt.close();
										%>
									</select>
								</td>
								<th scope="row"><span>아이템명</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="item_name" id="item_name3" value="" required label="2주차(월~목) 아이템명" readonly="readonly" />
								</td>
								<th scope="row"><span>가격</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="item_price" id="item_price3" value="" required label="2주차(월~목) 가격" dir="rtl" /> 원
								</td>
							</tr>
							<tr>
								<th scope="row"><span>3주차</span></th>
								<td>
									<select name="item_code" id="item_code5" onchange="getGroup(5);">
										<option value="">코드선택</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_CODE IN ('0300606', '0300607', '0300611', '0300669', '0300671', '0300673', '0300676', '0300678') ORDER BY GOODS_CODE";
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											goodsCode	= rs.getString("GOODS_CODE");
											goodsName	= rs.getString("GOODS_NAME");
										%>
										<option value="<%=goodsCode%>"><%=goodsCode+"("+goodsName+")"%></option>
										<%
										}

										rs.close();
										pstmt.close();
										%>
									</select>
								</td>
								<th scope="row"><span>아이템명</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="item_name" id="item_name5" value="" readonly="readonly" />
								</td>
								<th scope="row"><span>가격</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="item_price" id="item_price5" value="" dir="rtl" /> 원
								</td>
							</tr>
							<tr>
								<th scope="row"><span>4주차</span></th>
								<td>
									<select name="item_code" id="item_code7" onchange="getGroup(7);">
										<option value="">코드선택</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_CODE IN ('0300606', '0300607', '0300611', '0300669', '0300671', '0300673', '0300676', '0300678') ORDER BY GOODS_CODE";
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											goodsCode	= rs.getString("GOODS_CODE");
											goodsName	= rs.getString("GOODS_NAME");
										%>
										<option value="<%=goodsCode%>"><%=goodsCode+"("+goodsName+")"%></option>
										<%
										}

										rs.close();
										pstmt.close();
										%>
									</select>
								</td>
								<th scope="row"><span>아이템명</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="item_name" id="item_name7" value="" readonly="readonly" />
								</td>
								<th scope="row"><span>가격</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="item_price" id="item_price7" value="" dir="rtl" /> 원
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
	$("#gubun2").change(cngWeek);
});

function cngWeek() {
	var gubun2			= $("#gubun2").val();

	if (gubun2 == "21" || gubun2 == "22") {
		newOptions	= {
			'2' : '2주차',
			'4' : '4주차'
		}		
	} else if (gubun2 == "23") {
		newOptions	= {
			'4' : '4주차'
		}
	}
	selectedOption	= '';

	makeOption(newOptions, $("#gubun3"), selectedOption);
}

function getGroup(num) {
	$.post("goods_group_ajax.jsp", {
		mode: "getGroup",
		group_code: $("#item_code"+ num).val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				$(data).find("goodsName").each(function() {
					$("#item_name"+ num).val($(this).text());
				});
				$(data).find("goodsPrice").each(function() {
					$("#item_price"+ num).val($(this).text());
				});
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
					$("#item_name"+ num).val("");
					$("#item_price"+ num).val("");
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