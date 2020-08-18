<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int groupId			= 0;
String gubun2		= "";
String groupCode	= "";
String groupName	= "";
String groupInfo	= "";
String offerNotice	= "";
String cartImg		= "";
int groupPrice		= 0;
int groupPrice1		= 0;
int groupPrice2		= 0;
int groupPrice3		= 0;
int groupPrice4		= 0;
String goodsCode	= "";
String goodsName	= "";
int cid				= 0;
int amount			= 0;
int cateId			= 0;
String cateName		= "";
String keyword		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String schGubun1	= ut.inject(request.getParameter("sch_gubun1"));
String schGubun2	= ut.inject(request.getParameter("sch_gubun2"));
String field		= ut.inject(request.getParameter("field"));
if (request.getParameter("keyword") != null) {
	keyword				= ut.inject(request.getParameter("keyword"));
	keyword				= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
String param		= "page="+ iPage +"&pgsize="+ pgsize +"&sch_gubun1="+ schGubun1 +"&sch_gubun2="+ schGubun2 +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	groupId		= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT GUBUN2, GROUP_CODE, GROUP_NAME, GROUP_INFO, OFFER_NOTICE, CART_IMG, GROUP_PRICE, GROUP_PRICE1,";
	query		+= "	GROUP_PRICE1, GROUP_PRICE2, GROUP_PRICE3, GROUP_PRICE4";
	query		+= " FROM ESL_GOODS_GROUP ";
	query		+= " WHERE ID = "+ groupId;
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		gubun2			= rs.getString("GUBUN2");
		groupCode		= rs.getString("GROUP_CODE");
		groupName		= rs.getString("GROUP_NAME");
		groupInfo		= rs.getString("GROUP_INFO");
		offerNotice		= rs.getString("OFFER_NOTICE");
		cartImg			= rs.getString("CART_IMG");
		groupPrice		= rs.getInt("GROUP_PRICE");
		groupPrice1		= rs.getInt("GROUP_PRICE1");
		groupPrice2		= rs.getInt("GROUP_PRICE2");
		groupPrice3		= rs.getInt("GROUP_PRICE3");
		groupPrice4		= rs.getInt("GROUP_PRICE4");
	}

	rs.close();
}
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
				<form name="frm_edit" id="frm_edit" method="post" action="goods_group_meal_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=groupId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="gubun1" value="01" />
					<input type="hidden" name="org_cart_img" value="<%=cartImg%>" />
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
										<%if (gubun2.equals("11")) {%>
										<option value="11">1식</option>
										<%} else if (gubun2.equals("12")) {%>
										<option value="12">2식</option>
										<%} else if (gubun2.equals("13")) {%>
										<option value="13">3식</option>
										<%} else if (gubun2.equals("14")) {%>
										<option value="14">2식+간식</option>
										<%} else if (gubun2.equals("15")) {%>
										<option value="15">3식+간식</option>
										<%}%>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>세트그룹명</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="group_name" id="group_name" value="<%=groupName%>" required label="세트그룹명" readonly="readonly" />
								</td>
								<th scope="row"><span>세트그룹코드</span></th>
								<td>
									<select name="group_code" id="group_code" required label="세트그룹코드" onchange="getGroup();">
										<option value="<%=groupCode%>"><%=groupCode+"("+groupName+")"%></option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>가격</span></th>
								<td colspan="3">
									기본가&nbsp;
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price" id="group_price" value="<%=groupPrice%>" required label="기본가" dir="rtl" /> 원<br />
									2주 5일
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price1" id="group_price1" value="<%=groupPrice1%>" required label="2주 5일 가격" dir="rtl" /> 원
									| 2주 7일
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price2" id="group_price2" value="<%=groupPrice2%>" required label="2주 7일 가격" dir="rtl" /> 원<br />
									4주 5일
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price3" id="group_price3" value="<%=groupPrice3%>" required label="4주 5일 가격" dir="rtl" /> 원
									| 4주 7일
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price4" id="group_price4" value="<%=groupPrice4%>" required label="4주 7일 가격" dir="rtl" /> 원
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
							<%
							query		= "SELECT CATEGORY_ID, AMOUNT FROM ESL_GOODS_GROUP_EXTEND";
							query		+= " WHERE GROUP_ID = "+ groupId +" ORDER BY ID";
							try {
								rs	= stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}
							
							i		= 1;
							while (rs.next()) {
								cid		= rs.getInt("CATEGORY_ID");
								amount	= rs.getInt("AMOUNT");
							%>
							<tr class="cate_item<%=i%>">
								<td><%=i%></td>
								<td>
									<select name="cate_code">
										<option value="">선택</option>
										<%
										query1		= "SELECT ID, CATE_NAME FROM ESL_GOODS_CATEGORY WHERE OPEN_YN = 'Y'";
										rs1			= stmt1.executeQuery(query1);

										while (rs1.next()) {
											cateId		= rs1.getInt("ID");
											cateName	= rs1.getString("CATE_NAME");
										%>
										<option value="<%=cateId%>|<%=cateName%>"<%if (cateId == cid) out.println(" selected=\"selected\"");%>><%=cateName%></option>
										<%
										}
										%>
									</select>
								</td>
								<td>
									<input type="text" class="input1" style="width:60px;" name="amount" value="<%=amount%>" />
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
								<th scope="row"><span>상품설명</span></th>
								<td class="td_edit">
									<textarea id="group_info" name="group_info" style="width:90%;height:100px;" type=editor><%=groupInfo%></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>상품정보<br />제공고시</span></th>
								<td class="td_edit">
									<textarea id="offer_notice" name="offer_notice" style="width:90%;height:100px;" type=editor><%=offerNotice%></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이미지(장바구니)</span></th>
								<td colspan="3">
									<input type="file" name="cart_img" value="" />
									(최적화 사이즈: 90 x 70)
									<%if (!cartImg.equals("")) {%>
										<br /><input type="checkbox" name="del_cart_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"goods/"+ cartImg%>" width="90" height="70" />
									<%}%>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_edit)"  class="function_btn"><span>저장</span></a>
						<a href="goods_group_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
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
				$("#group_price").val("");
				$("#group_price1").val("");
				$("#group_price2").val("");
				$("#group_price3").val("");
				$("#group_price4").val("");
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
					$("#group_code").html('<option value="">코드선택</option>');
					$("#group_name").val("");
					$("#group_price").val("");
					$("#group_price1").val("");
					$("#group_price2").val("");
					$("#group_price3").val("");
					$("#group_price4").val("");
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
					$("#group_price").val("");
					$("#group_price1").val("");
					$("#group_price2").val("");
					$("#group_price3").val("");
					$("#group_price4").val("");
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