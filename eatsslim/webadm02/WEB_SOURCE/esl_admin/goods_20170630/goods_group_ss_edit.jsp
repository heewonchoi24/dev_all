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
String gubun3		= "";
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
String pgGroupCode	= "";
String pgGroupName	= "";
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

	query		= "SELECT GUBUN2, GUBUN3, GROUP_CODE, GROUP_NAME, GROUP_INFO, OFFER_NOTICE, CART_IMG, GROUP_PRICE";
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
		gubun3			= rs.getString("GUBUN3");
		groupCode		= rs.getString("GROUP_CODE");
		groupName		= rs.getString("GROUP_NAME");
		groupInfo		= rs.getString("GROUP_INFO");
		offerNotice		= rs.getString("OFFER_NOTICE");
		cartImg			= rs.getString("CART_IMG");
		groupPrice		= rs.getInt("GROUP_PRICE");
	}

	rs.close();
}
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:4,level_2:3,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<form name="frm_write" id="frm_write" method="post" action="goods_group_ss_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="ins" />
					<input type="hidden" name="gubun1" value="03" />
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
										<option value="31">시크릿수프</option>
									</select>
								</td>
								<th scope="row"><span>세트그룹코드</span></th>
								<td>
									<select name="group_code" id="group_code" required label="세트그룹코드" onchange="getGroup();">
										<option value="<%=groupCode%>"><%=groupCode+"("+groupName+")"%></option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>세트그룹명</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="group_name" id="group_name" value="<%=groupName%>" required label="세트그룹명" readonly="readonly" />
								</td>
								<th scope="row"><span>가격</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price" id="group_price" value="<%=groupPrice%>" required label="가격" dir="rtl" /> 원
								</td>
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
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>월</span></th>
								<td>
									<select name="item_code" id="item_code1" required label="1주차(월~목) 세트그룹코드" onchange="getGroup(1);">
										<option value="">코드선택</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_CODE IN ('0300695', '0300696', '0300697') ORDER BY GOODS_CODE";
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
							</tr>
							<tr>
								<th scope="row"><span>화</span></th>
								<td>
									<select name="item_code" id="item_code3" required label="2주차(월~목) 세트그룹코드" onchange="getGroup(3);">
										<option value="">코드선택</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_CODE IN ('0300695', '0300696', '0300697') ORDER BY GOODS_CODE";
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
							</tr>
							<tr>
								<th scope="row"><span>수</span></th>
								<td>
									<select name="item_code" id="item_code5" onchange="getGroup(5);">
										<option value="">코드선택</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_CODE IN ('0300695', '0300696', '0300697') ORDER BY GOODS_CODE";
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
							</tr>
							<tr>
								<th scope="row"><span>목</span></th>
								<td>
									<select name="item_code" id="item_code7" onchange="getGroup(7);">
										<option value="">코드선택</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_CODE IN ('0300695', '0300696', '0300697') ORDER BY GOODS_CODE";
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
							</tr>
							<tr>
								<th scope="row"><span>금</span></th>
								<td>
									<select name="item_code" id="item_code7" onchange="getGroup(7);">
										<option value="">코드선택</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_CODE IN ('0300695', '0300696', '0300697') ORDER BY GOODS_CODE";
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
							</tr>
							<tr>
								<th scope="row"><span>토</span></th>
								<td>
									<select name="item_code" id="item_code7" onchange="getGroup(7);">
										<option value="">코드선택</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_CODE IN ('0300695', '0300696', '0300697') ORDER BY GOODS_CODE";
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
						<a href="javascript:;" onclick="chkForm(document.frm_write)"  class="function_btn"><span>저장</span></a>
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