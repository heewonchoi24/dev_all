<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
String goodsCode		= "";
String goodsName		= "";
int cateId				= 0;
String cateName			= "";
int categoryId			= 0;
String setName			= "";
String setCode			= "";
int setPrice			= 0;
String setInfo			= "";
int setId				= 0;
String portionSize		= "";
String calorie			= "";
String carbohydrateG	= "";
String carbohydrateP	= "";
String sugarG			= "";
String sugarP			= "";
String proteinG			= "";
String proteinP			= "";
String fatG				= "";
String fatP				= "";
String saturatedFatG	= "";
String saturatedFatP	= "";
String transFatG		= "";
String transFatP		= "";
String cholesterolG		= "";
String cholesterolP		= "";
String natriumG			= "";
String natriumP			= "";
String makeDate			= "";
String thumbImg			= "";
String bigImg			= "";
String etcName			= "";
String etcContent		= "";
String etcPercent		= "";
String prdtName			= "";
String prdtType			= "";
String producer			= "";
String rawMaterials		= "";
String bigo				= "";
String keyword			= "";
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String schCate			= ut.inject(request.getParameter("sch_cate"));
String field			= ut.inject(request.getParameter("field"));
if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
String param			= "page="+ iPage +"&pgsize="+ pgsize +"&sch_cate="+ schCate +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	setId		= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT a.CATEGORY_ID, a.SET_CODE, a.SET_NAME, a.SET_PRICE, a.SET_INFO, a.MAKE_DATE, a.THUMB_IMG, a.BIG_IMG,";
	query		+= "	a.BIGO, b.PORTION_SIZE, b.CALORIE, b.CARBOHYDRATE_G, b.CARBOHYDRATE_P, b.SUGAR_G, b.SUGAR_P,";
	query		+= "	b.PROTEIN_G, b.PROTEIN_P, b.FAT_G, b.FAT_P, b.SATURATED_FAT_G, b.SATURATED_FAT_P, b.TRANS_FAT_G,";
	query		+= "	b.TRANS_FAT_P, b.CHOLESTEROL_G, b.CHOLESTEROL_P, b.NATRIUM_G, b.NATRIUM_P";
	query		+= " FROM ESL_GOODS_SET a, ESL_GOODS_SET_CONTENT b";
	query		+= " WHERE a.ID = b.SET_ID AND a.ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, setId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		categoryId		= rs.getInt("CATEGORY_ID");
		setCode			= rs.getString("SET_CODE");
		setName			= rs.getString("SET_NAME");
		setPrice		= rs.getInt("SET_PRICE");
		setInfo			= rs.getString("SET_INFO");
		makeDate		= rs.getString("MAKE_DATE");
		thumbImg		= rs.getString("THUMB_IMG");
		bigImg			= rs.getString("BIG_IMG");
		bigo			= rs.getString("BIGO");
		portionSize		= rs.getString("PORTION_SIZE");
		calorie			= rs.getString("CALORIE");
		carbohydrateG	= rs.getString("CARBOHYDRATE_G");
		carbohydrateP	= rs.getString("CARBOHYDRATE_P");
		sugarG			= rs.getString("SUGAR_G");
		sugarP			= rs.getString("SUGAR_P");
		proteinG		= rs.getString("PROTEIN_G");
		proteinP		= rs.getString("PROTEIN_P");
		fatG			= rs.getString("FAT_G");
		fatP			= rs.getString("FAT_P");
		saturatedFatG	= rs.getString("SATURATED_FAT_G");
		saturatedFatP	= rs.getString("SATURATED_FAT_P");
		transFatG		= rs.getString("TRANS_FAT_G");
		transFatP		= rs.getString("TRANS_FAT_P");
		cholesterolG	= rs.getString("CHOLESTEROL_G");
		cholesterolP	= rs.getString("CHOLESTEROL_P");
		natriumG		= rs.getString("NATRIUM_G");
		natriumP		= rs.getString("NATRIUM_P");
	}

	if (rs != null) try { rs.close(); } catch (Exception e) {}
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
} else {
	ut.jsBack(out);
	if (true) return;
}
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:3,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상품관리 &gt; <strong>세트관리</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="goods_set_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=setId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="org_thumb_img" value="<%=thumbImg%>" />
					<input type="hidden" name="org_big_img" value="<%=bigImg%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>세트명</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="set_name" id="set_name" value="<%=setName%>" required label="세트명" readonly="readonly" />
								</td>
								<th scope="row"><span>세트코드</span></th>
								<td>
									<select name="set_code" id="set_code" required label="세트코드" onchange="getSet();">
										<option value="">코드선택</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_TYPE = 'S' AND GOODS_CODE NOT IN (SELECT SET_CODE FROM ESL_GOODS_SET WHERE ID != ?) ORDER BY GOODS_CODE";
										pstmt		= conn.prepareStatement(query);
										pstmt.setInt(1, setId);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											goodsCode	= rs.getString("GOODS_CODE");
											goodsName	= rs.getString("GOODS_NAME");
										%>
										<option value="<%=goodsCode%>"<%if (goodsCode.equals(setCode)) out.println(" selected=\"selected\"");%>><%=goodsCode+"("+goodsName+")"%></option>
										<%
										}

										rs.close();
										pstmt.close();
										%>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>가격</span></th>
								<td>
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="set_price" id="set_price" value="<%=setPrice%>" required label="가격" dir="rtl" /> 원
								</td>
								<th scope="row"><span>카테고리</span></th>
								<td>
									<select name="cate_code" required label="카테고리">
										<option value="">선택</option>
										<%
										query		= "SELECT ID, CATE_NAME FROM ESL_GOODS_CATEGORY WHERE OPEN_YN = 'Y' ORDER BY CATE_CODE";
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											cateId		= rs.getInt("ID");
											cateName	= rs.getString("CATE_NAME");
										%>
										<option value="<%=cateId%>"<%if (cateId == categoryId) out.println(" selected=\"selected\"");%>><%=cateName%></option>
										<%
										}
										%>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>제품설명</span></th>
								<td colspan="3" class="td_edit">
									<textarea name="set_info" style="width:90%;height:100px"><%=setInfo%></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<br />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>제공량</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="portion_size" value="<%=portionSize%>" />
									g
								</td>
								<th scope="row"><span>열량함량</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="calorie" value="<%=calorie%>" />
									kcal
								</td>
							</tr>
							<tr>
								<th scope="row"><span>탄수화물 함량</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="carbohydrate_g" value="<%=carbohydrateG%>" />
									g
								</td>
								<th scope="row"><span>탄수화물 기준치</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="carbohydrate_p" value="<%=carbohydrateP%>" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>당류 함량</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="sugar_g" value="<%=sugarG%>" />
									g
								</td>
								<th scope="row"><span>당류 기준치</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="sugar_p" value="<%=sugarP%>" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>단백질 함량</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="protein_g" value="<%=proteinG%>" />
									g
								</td>
								<th scope="row"><span>단백질 기준치</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="protein_p" value="<%=proteinP%>" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>지방 함량</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="fat_g" value="<%=fatG%>" />
									g
								</td>
								<th scope="row"><span>지방 기준치</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="fat_p" value="<%=fatP%>" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>포화지방 함량</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="saturated_fat_g" value="<%=saturatedFatG%>" />
									g
								</td>
								<th scope="row"><span>포화지방 기준치</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="saturated_fat_p" value="<%=saturatedFatP%>" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>트렌스지방 함량</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="trans_fat_g" value="<%=transFatG%>" />
									g
								</td>
								<th scope="row"><span>트렌스지방 기준치</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="trans_fat_p" value="<%=transFatP%>" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>콜레스테롤 함량</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="cholesterol_g" value="<%=cholesterolG%>" />
									mg
								</td>
								<th scope="row"><span>콜레스테롤 기준치</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="cholesterol_p" value="<%=cholesterolP%>" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>나트륨 함량</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="natrium_g" value="<%=natriumG%>" />
									mg
								</td>
								<th scope="row"><span>나트륨 기준치</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="natrium_p" value="<%=natriumP%>" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>제조일자</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:500px;" name="make_date" value="<%=makeDate%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>썸네일이미지</span></th>
								<td colspan="3">
									<input type="file" name="thumb_img" value="<%=thumbImg%>" />
									<%if (!thumbImg.equals("")) {%>
										<br /><input type="checkbox" name="del_thumb_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"goods/"+ thumbImg%>" width="115" height="65" />
									<%}%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>큰이미지</span></th>
								<td colspan="3">
									<input type="file" name="big_img" value="<%=bigImg%>" />
									<%if (!bigImg.equals("")) {%>
										<br /><input type="checkbox" name="del_big_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"goods/"+ bigImg%>" width="710" height="265" />
									<%}%>
								</td>
							</tr>
						</tbody>
					</table>
					<br />
					<table id="etcTable" class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="100px" />
							<col width="25%" />
							<col width="100px" />
							<col width="23%" />
							<col width="100px" />
							<col width="23%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col" colspan="7" style="text-align:center">
									<span>그밖의 함유량</span>
									<a href="javascript:;" id="addEtcBtn" class="function_btn"><span style="padding: 7px 8px 0 5px;">추가</span></a>
								</th>
							</tr>
							<tr class="etc_item0 hidden">
								<th scope="row"><span>이름</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="etc_name" value="" />
								</td>
								<th scope="row"><span>함량</span></th>
								<td>
									<input type="text" class="input1" style="width:150px;" maxlength="10" name="etc_content" value="" />
								</td>
								<th scope="row"><span>기준치</span></th>
								<td>
									<input type="text" class="input1" style="width:150px;" maxlength="10" name="etc_percent" value="" />
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>삭제</span></a>
								</td>
							</tr>
							<%
							query		= "SELECT ETC_NAME, ETC_CONTENT, ETC_PERCENT FROM ESL_GOODS_SET_CONTENT_EXTEND WHERE SET_ID = ? ORDER BY ID";
							pstmt		= conn.prepareStatement(query);
							pstmt.setInt(1, setId);
							rs			= pstmt.executeQuery();

							i = 1;
							while (rs.next()) {
								etcName		= rs.getString("ETC_NAME");
								etcContent	= rs.getString("ETC_CONTENT");
								etcPercent	= rs.getString("ETC_PERCENT");
							%>
							<tr class="etc_item<%=i%>">
								<th scope="row"><span>이름</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="etc_name" value="<%=etcName%>" />
								</td>
								<th scope="row"><span>함량</span></th>
								<td>
									<input type="text" class="input1" style="width:150px;" maxlength="10" name="etc_content" value="<%=etcContent%>" />
								</td>
								<th scope="row"><span>기준치</span></th>
								<td>
									<input type="text" class="input1" style="width:150px;" maxlength="10" name="etc_percent" value="<%=etcPercent%>" />
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
					<br />
					<table id="originTable" class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="15%" />
							<col width="20%" />
							<col width="23%" />
							<col width="*" />
							<col width="80px" />							
						</colgroup>
						<tbody>
							<tr>
								<th scope="col" colspan="5" style="text-align:center">
									<span>원산지 추가</span>
									<a href="javascript:;" id="addOriginBtn" class="function_btn"><span style="padding: 7px 8px 0 5px;">추가</span></a>
								</th>
							</tr>
							<tr>
								<th scope="col" style="text-align:center"><span>제품명</span></th>
								<th scope="col" style="text-align:center"><span>식품의유형</span></th>
								<th scope="col" style="text-align:center"><span>생산자 및 소재지</span></th>
								<th scope="col" style="text-align:center"><span>원재료명 및 함량</span></th>
								<th scope="col" style="text-align:center"><span>삭제</span></th>
							</tr>
							<tr class="origin_item0 hidden">
								<td>
									<textarea name="prdt_name" style="width:98%;height:50px"></textarea>
								</td>
								<td>
									<textarea name="prdt_type" style="width:98%;height:50px"></textarea>
								</td>
								<td>
									<textarea name="producer" style="width:98%;height:50px"></textarea>
								</td>
								<td>
									<textarea name="raw_materials" style="width:98%;height:50px"></textarea>
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>삭제</span></a>
								</td>
							</tr>
							<%
							query		= "SELECT PRDT_NAME, PRDT_TYPE, PRODUCER, RAW_MATERIALS FROM ESL_GOODS_SET_ORIGIN WHERE SET_ID = ? ORDER BY ID";
							pstmt		= conn.prepareStatement(query);
							pstmt.setInt(1, setId);
							rs			= pstmt.executeQuery();

							i = 1;
							while (rs.next()) {
								prdtName		= rs.getString("PRDT_NAME");
								prdtType		= rs.getString("PRDT_TYPE");
								producer		= rs.getString("PRODUCER");
								rawMaterials	= rs.getString("RAW_MATERIALS");
							%>
							<tr class="origin_item<%=i%>">
								<td>
									<textarea name="prdt_name" style="width:98%;height:50px"><%=prdtName%></textarea>
								</td>
								<td>
									<textarea name="prdt_type" style="width:98%;height:50px"><%=prdtType%></textarea>
								</td>
								<td>
									<textarea name="producer" style="width:98%;height:50px"><%=producer%></textarea>
								</td>
								<td>
									<textarea name="raw_materials" style="width:98%;height:50px"><%=rawMaterials%></textarea>
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>삭제</span></a>
								</td>
							</tr>
							<%
								i++;
							}
							%>
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
								<th scope="row"><span>비고</span></th>
								<td class="td_edit">
									<textarea name="bigo" style="width:90%;height:100px"><%=bigo%></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_edit)"  class="function_btn"><span>수정</span></a>
						<a href="goods_set_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
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
	$("#addEtcBtn").click(function(){
		var lastItemNo = $("#etcTable tr:last").attr("class").replace("etc_item", "");

		var newitem = $("#etcTable tr:eq(1)").clone();
		newitem.removeClass();
		newitem.find("td:eq(0)").attr("rowspan", "1");
		newitem.addClass("etc_item"+(parseInt(lastItemNo)+1));
		newitem.removeClass("hidden");

		$("#etcTable").append(newitem);
	});

	$("#addOriginBtn").click(function(){
		var lastItemNo = $("#originTable tr:last").attr("class").replace("origin_item", "");

		var newitem = $("#originTable tr:eq(2)").clone();
		newitem.removeClass();
		newitem.find("td:eq(0)").attr("rowspan", "1");
		newitem.addClass("origin_item"+(parseInt(lastItemNo)+1));
		newitem.removeClass("hidden");

		$("#originTable").append(newitem);
	});
});

function getSet() {
	$.post("goods_set_ajax.jsp", {
		mode: "getSet",
		set_code: $("#set_code").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				$(data).find("goodsName").each(function() {
					$("#set_name").val($(this).text());
				});
				$(data).find("goodsPrice").each(function() {
					$("#set_price").val($(this).text());
				});
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
					$("#set_name").val("");
					$("#set_price").val("");
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
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>