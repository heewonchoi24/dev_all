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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ��ǰ���� &gt; <strong>�޴�����</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="goods_set_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="ins" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>�޴���</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="set_name" id="set_name" value="" required label="�޴���" readonly="readonly" />
								</td>
								<th scope="row"><span>�޴��ڵ�</span></th>
								<td>
									<select name="set_code" id="set_code" required label="�޴��ڵ�" onchange="getSet();">
										<option value="">�ڵ弱��</option>
										<%
										query		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_TYPE = 'S' AND GOODS_CODE NOT IN (SELECT SET_CODE FROM ESL_GOODS_SET) ORDER BY GOODS_CODE";
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
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td>
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="set_price" id="set_price" value="" required label="����" dir="rtl" /> ��
								</td>
								<th scope="row"><span>ī�װ�</span></th>
								<td>
									<select name="cate_code" required label="ī�װ�">
										<option value="">����</option>
										<%
										query		= "SELECT ID, CATE_NAME, CATE_CODE FROM ESL_GOODS_CATEGORY WHERE OPEN_YN = 'Y' ORDER BY CATE_CODE DESC";
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											cateId		= rs.getInt("ID");
											cateName	= rs.getString("CATE_NAME");
										%>
										<option value="<%=cateId%>"><%=cateName+"("+rs.getString("CATE_CODE")+")"%></option>
										<%
										}
										%>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��뿩��</span></th>
								<td colspan="3" class="td_edit">
									<input type="radio" name="use_yn" id="use_yn1" value="Y" />
									<label for="use_yn1">���</label>
									<input type="radio" name="use_yn" id="use_yn2" value="N" checked="checked" />
									<label for="use_yn2">�̻��</label>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��ǰ����</span></th>
								<td colspan="3" class="td_edit">
									<textarea name="set_info" style="width:90%;height:100px"></textarea>
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
								<th scope="row"><span>������</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="portion_size" value="" />
									g
								</td>
								<th scope="row"><span>�����Է�</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="calorie" value="" />
									kcal
								</td>
							</tr>
							<tr>
								<th scope="row"><span>ź��ȭ�� �Է�</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="carbohydrate_g" value="" />
									g
								</td>
								<th scope="row"><span>ź��ȭ�� ����ġ</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="carbohydrate_p" value="" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��� �Է�</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="sugar_g" value="" />
									g
								</td>
								<th scope="row"><span>��� ����ġ</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="sugar_p" value="" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�ܹ��� �Է�</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="protein_g" value="" />
									g
								</td>
								<th scope="row"><span>�ܹ��� ����ġ</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="protein_p" value="" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>���� �Է�</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="fat_g" value="" />
									g
								</td>
								<th scope="row"><span>���� ����ġ</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="fat_p" value="" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��ȭ���� �Է�</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="saturated_fat_g" value="" />
									g
								</td>
								<th scope="row"><span>��ȭ���� ����ġ</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="saturated_fat_p" value="" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>Ʈ�������� �Է�</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="trans_fat_g" value="" />
									g
								</td>
								<th scope="row"><span>Ʈ�������� ����ġ</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="trans_fat_p" value="" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�ݷ����׷� �Է�</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="cholesterol_g" value="" />
									mg
								</td>
								<th scope="row"><span>�ݷ����׷� ����ġ</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="cholesterol_p" value="" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��Ʈ�� �Է�</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="natrium_g" value="" />
									mg
								</td>
								<th scope="row"><span>��Ʈ�� ����ġ</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="4" name="natrium_p" value="" />
									%
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��������</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:500px;" name="make_date" value="" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>������̹���</span></th>
								<td colspan="3">
									<input type="file" name="thumb_img" value="" />
									(����ȭ ������: 115 x 65)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>ū�̹���</span></th>
								<td colspan="3">
									<input type="file" name="big_img" value="" />
									(����ȭ ������: 710 x 265)
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
									<span>�׹��� ������</span>
									<a href="javascript:;" id="addEtcBtn" class="function_btn"><span style="padding: 7px 8px 0 5px;">�߰�</span></a>
								</th>
							</tr>
							<tr class="etc_item0 hidden">
								<th scope="row"><span>�̸�</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="etc_name" value="" />
								</td>
								<th scope="row"><span>�Է�</span></th>
								<td>
									<input type="text" class="input1" style="width:150px;" maxlength="10" name="etc_content" value="" />
								</td>
								<th scope="row"><span>����ġ</span></th>
								<td>
									<input type="text" class="input1" style="width:150px;" maxlength="10" name="etc_percent" value="" />
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>����</span></a>
								</td>
							</tr>
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
									<span>������ �߰�</span>
									<a href="javascript:;" id="addOriginBtn" class="function_btn"><span style="padding: 7px 8px 0 5px;">�߰�</span></a>
								</th>
							</tr>
							<tr>
								<th scope="col" style="text-align:center"><span>��ǰ��</span></th>
								<th scope="col" style="text-align:center"><span>��ǰ������</span></th>
								<th scope="col" style="text-align:center"><span>������ �� ������</span></th>
								<th scope="col" style="text-align:center"><span>������ �� �Է�</span></th>
								<th scope="col" style="text-align:center"><span>����</span></th>
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
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>����</span></a>
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
								<th scope="row"><span>���</span></th>
								<td class="td_edit">
									<textarea name="bigo" style="width:90%;height:100px"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_write)"  class="function_btn"><span>����</span></a>
						<a href="goods_set_list.jsp" class="function_btn"><span>���</span></a>
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