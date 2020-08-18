<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query				= "";
String query1				= "";
ResultSet rs1				= null; 
PreparedStatement pstmt1	= null;
String goodsCode			= "";
String goodsName			= "";
int curNum					= 1;
int cateId					= 0;
String cateName				= "";
String cateCode				= "";
String openYn				= "";
String scheduleYn			= "";
int goodsSetCnt				= 0;

query		= "SELECT ID, CATE_NAME, CATE_CODE, OPEN_YN, SCHEDULE_YN, GOODS_SET_CNT FROM ESL_GOODS_CATEGORY ORDER BY ID DESC";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>

	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:2,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ��ǰ���� &gt; <strong>ī�װ�����</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post">
					<input type="hidden" name="mode" value="ins" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="6%" />
							<col width="*" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="8%" />
							<col width="14%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>��ȣ</span></th>
								<th scope="col"><span>ī�װ���</span></th>
								<th scope="col"><span>ī�װ��ڵ�</span></th>
								<th scope="col"><span>���⿩��</span></th>
								<th scope="col"><span>�Ĵܽ�����</span></th>
								<th scope="col"><span>��ǰ��</span></th>
								<th scope="col"><span>ó��</span></th>
							</tr>
							<%
							while (rs.next()) {
								cateId		= rs.getInt("ID");
								cateName	= rs.getString("CATE_NAME");
								cateCode	= rs.getString("CATE_CODE");
								openYn		= rs.getString("OPEN_YN");
								scheduleYn	= rs.getString("SCHEDULE_YN");
								goodsSetCnt	= rs.getInt("GOODS_SET_CNT");
							%>
							<tr>
								<td><%=curNum%></td>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="cate_name_<%=cateId%>" id="cate_name_<%=cateId%>" required label="ī�װ���" value="<%=cateName%>" readonly="readonly" />
								</td>
								<td>
									<input type="text" class="input1" style="width:60px;" maxlength="50" name="cate_code_<%=cateId%>" id="cate_code_<%=cateId%>" required label="ī�װ��ڵ�" value="<%=cateCode%>" readonly="readonly" />
								</td>
								<td>
									<input type="radio" name="open_yn_<%=cateId%>" id="open_y_<%=cateId%>" value="Y"<%if (openYn.equals("Y")) out.println(" checked=\"checked\"");%> />
									<label for="open_y_<%=cateId%>">����</label>
									<input type="radio" name="open_yn_<%=cateId%>" id="open_n_<%=cateId%>" value="N"<%if (openYn.equals("N")) out.println(" checked=\"checked\"");%> />
									<label for="open_n_<%=cateId%>">�̳���</label>
								</td>
								<td>
									<input type="radio" name="schedule_yn_<%=cateId%>" id="schedule_y_<%=cateId%>" value="Y"<%if (scheduleYn.equals("Y")) out.println(" checked=\"checked\"");%> />
									<label for="schedule_y_<%=cateId%>">�ʿ�</label>
									<input type="radio" name="schedule_yn_<%=cateId%>" id="schedule_n_<%=cateId%>" value="N"<%if (scheduleYn.equals("N")) out.println(" checked=\"checked\"");%> />
									<label for="schedule_n_<%=cateId%>">���ʿ�</label>
								</td>
								<td>
									<%=goodsSetCnt%>
									<%if (goodsSetCnt > 0) {%> 
									<a href="goods_set_list.jsp?sch_cate=<%=cateId%>">����</a>
									<%}%>
								</td>
								<td>
									<a href="javascript:;" onclick="chkEdit(<%=cateId%>);" class="function_btn"><span>����</span></a>
									<a href="javascript:;" onclick="chkDel(<%=cateId%>);" class="function_btn"><span>����</span></a>
								</td>
							</tr>
							<%
								curNum++;
							}

							query1		= "SELECT GOODS_CODE, GOODS_NAME FROM ESL_GOODS_SETTING WHERE GOODS_TYPE = 'C' AND GOODS_CODE NOT IN (SELECT CATE_CODE FROM ESL_GOODS_CATEGORY)";
							pstmt1		= conn.prepareStatement(query1);
							rs1			= pstmt1.executeQuery();

							while (rs1.next()) {
								goodsCode	= rs1.getString("GOODS_CODE");
								goodsName	= rs1.getString("GOODS_NAME");
							%>
							<tr>
								<td>-</td>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="cate_name_<%=goodsCode%>" id="cate_name_<%=goodsCode%>" required label="ī�װ���" readonly="readonly" value="<%=goodsName%>" />
								</td>
								<td>
									<select name="cate_code_<%=goodsCode%>" id="cate_code_<%=goodsCode%>" onchange="getCate();">
										<option value="<%=goodsCode%>"><%=goodsCode+"("+goodsName+")"%></option>
									</select>
								</td>
								<td>
									<input type="radio" name="open_yn_<%=goodsCode%>" id="open_y_<%=goodsCode%>" value="Y" checked="checked" />
									<label for="open_y">����</label>
									<input type="radio" name="open_yn_<%=goodsCode%>" id="open_n_<%=goodsCode%>" value="N" />
									<label for="open_n">�̳���</label>
								</td>
								<td>
									<input type="radio" name="schedule_yn_<%=goodsCode%>" id="schedule_y_<%=goodsCode%>" value="Y" checked="checked" />
									<label for="schedule_y">�ʿ�</label>
									<input type="radio" name="schedule_yn_<%=goodsCode%>" id="schedule_n_<%=goodsCode%>" value="N" />
									<label for="schedule_n">���ʿ�</label>
								</td>
								<td>-</td>
								<td>
									<a href="javascript:;" onclick="chkWrite('<%=goodsCode%>');" class="function_btn"><span>�߰�</span></a>
								</td>
								<%
								}

								rs1.close();
								pstmt1.close();
								%>
							</tr>
						</tbody>
					</table>
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
function getCate() {
	$.post("category_ajax.jsp", {
		mode: "getCate",
		cate_code: $("#cate_code").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				$(data).find("goodsName").each(function() {
					$("#cate_name").val($(this).text());
				});
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
					$("#cate_name").val("");
				});
			}
		});
	}, "xml");
	return false;
}

function chkWrite(gcode) {
	$.post("category_ajax.jsp", {
		mode: "ins",
		cate_name: $("#cate_name_"+ gcode).val(),
		cate_code: $("#cate_code_"+ gcode).val(),
		open_yn: $("input[name=open_yn_"+ gcode +"]:checked").val(),
		schedule_yn: $("input[name=schedule_yn_"+ gcode +"]:checked").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("��ϵǾ����ϴ�.");
				document.location.reload();
			} else {
				var error_txt;
				$(data).find("error").each(function() {
					error_txt = $(this).text().split(":");
					alert(error_txt[1]);
					if (error_txt[0] != "no_txt")
						$("#" + error_txt[0]).focus();
				});
			}
		});
	}, "xml");
	return false;
}

function chkEdit(obj) {
	var open_yn		= $("input[name=open_yn_"+ obj +"]:checked").val();
	var schedule_yn	= $("input[name=schedule_yn_"+ obj +"]:checked").val();

	$.post("category_ajax.jsp", {
		mode: "upd",
		cate_id: obj,
		open_yn: open_yn,
		schedule_yn: schedule_yn
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("�����Ǿ����ϴ�.");
				document.location.reload();
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function chkDel(obj) {
	var open_yn		= $("input[name=open_yn_"+ obj +"]:checked").val();
	var schedule_yn	= $("input[name=schedule_yn_"+ obj +"]:checked").val();

	if (confirm("������ �����Ͻðڽ��ϱ�?")) {
		$.post("category_ajax.jsp", {
			mode: "del",
			cate_id: obj,
			open_yn: open_yn,
			schedule_yn: schedule_yn
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					alert("�����Ǿ����ϴ�.");
					document.location.reload();
				} else {
					$(data).find("error").each(function() {
						alert($(this).text());
					});
				}
			});
		}, "xml");
		return false;
	}
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>