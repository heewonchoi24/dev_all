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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ��ǰ����&gt; ��Ʈ�׷���� &gt; <strong>Ÿ�Ժ� ���̾�Ʈ</strong></p>
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
								<th scope="row"><span>����2</span></th>
								<td class="td_edit">
									<select name="gubun2" id="gubun2">
										<option value="21">�������α׷�</option>
										<option value="22">�������α׷�</option>
										<option value="23">FULL-STEP ���α׷�</option>
									</select>
								</td>
								<th scope="row"><span>����</span></th>
								<td>
									<select name="gubun3" id="gubun3">
										<option value="2">2����</option>
										<option value="4">4����</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��Ʈ�׷��</span></th>
								<td><input type="text" name="group_name" style="width:200px;" maxlength="50" class="input1" required label="��Ʈ�׷��" /></td>
								<th scope="row"><span>����</span></th>
								<td><input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price" id="group_price" value="" required label="����" dir="rtl" /> ��</td>
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
								<th scope="row"><span>1����</span></th>
								<td>
									<select name="item_code" id="item_code1" required label="1����(��~��) ��Ʈ�׷��ڵ�" onchange="getGroup(1);">
										<option value="">�ڵ弱��</option>
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
								<th scope="row"><span>�����۸�</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="item_name" id="item_name1" value="" required label="1����(��~��) �����۸�" readonly="readonly" />
								</td>
								<th scope="row"><span>����</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="item_price" id="item_price1" value="" required label="1����(��~��) ����" dir="rtl" /> ��
								</td>
							</tr>
							<tr>
								<th scope="row"><span>2����</span></th>
								<td>
									<select name="item_code" id="item_code3" required label="2����(��~��) ��Ʈ�׷��ڵ�" onchange="getGroup(3);">
										<option value="">�ڵ弱��</option>
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
								<th scope="row"><span>�����۸�</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="item_name" id="item_name3" value="" required label="2����(��~��) �����۸�" readonly="readonly" />
								</td>
								<th scope="row"><span>����</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="item_price" id="item_price3" value="" required label="2����(��~��) ����" dir="rtl" /> ��
								</td>
							</tr>
							<tr>
								<th scope="row"><span>3����</span></th>
								<td>
									<select name="item_code" id="item_code5" onchange="getGroup(5);">
										<option value="">�ڵ弱��</option>
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
								<th scope="row"><span>�����۸�</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="item_name" id="item_name5" value="" readonly="readonly" />
								</td>
								<th scope="row"><span>����</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="item_price" id="item_price5" value="" dir="rtl" /> ��
								</td>
							</tr>
							<tr>
								<th scope="row"><span>4����</span></th>
								<td>
									<select name="item_code" id="item_code7" onchange="getGroup(7);">
										<option value="">�ڵ弱��</option>
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
								<th scope="row"><span>�����۸�</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="item_name" id="item_name7" value="" readonly="readonly" />
								</td>
								<th scope="row"><span>����</span></th>
								<td colspan="3">
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="item_price" id="item_price7" value="" dir="rtl" /> ��
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
								<th scope="row"><span>��ǰ����</span></th>
								<td class="td_edit">
									<textarea id="group_info" name="group_info" style="width:90%;height:100px;" type=editor></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��ǰ����<br />�������</span></th>
								<td class="td_edit">
									<textarea id="offer_notice" name="offer_notice" style="width:90%;height:100px;" type=editor></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�̹���(��ٱ���)</span></th>
								<td colspan="3">
									<input type="file" name="cart_img" value="" />
									(����ȭ ������: 90 x 70)
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_write)"  class="function_btn"><span>����</span></a>
						<a href="goods_group_list.jsp" class="function_btn"><span>���</span></a>
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
			'2' : '2����',
			'4' : '4����'
		}		
	} else if (gubun2 == "23") {
		newOptions	= {
			'4' : '4����'
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
<!-- �������� Ȱ��ȭ ��ũ��Ʈ -->
<script src="/editor/editor_board.js"></script>
<script>
	mini_editor('/editor/');							
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>