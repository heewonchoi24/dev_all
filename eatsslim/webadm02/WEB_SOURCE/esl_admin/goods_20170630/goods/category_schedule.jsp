<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>

	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:5,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ��ǰ���� &gt; <strong>�Ĵܰ���</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>
										<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
											<option value="TITLE">�Ĵܸ�</option>
											<option value="CONTENT">ī�װ���</option>
										</select>
									</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="" onfocus="this.select()"/></td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="�˻�" /></p>			
					<div class="member_box">
						<p class="search_result">�� <strong>3</strong>��</p>
						<p class="right_box">
							<select name="pgsize" onchange="this.form.submit()">
								<option value="10">10��������</option>
								<option value="20">20��������</option>
								<option value="30">30��������</option>
								<option value="100">100��������</option>
							</select>
						</p>
					</div>
				</form>
				<form name="frm_write" id="frm_write" method="post">
					<input type="hidden" name="mode" value="ins" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="6%" />
							<col width="*" />
							<col width="14%" />
							<col width="14%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>��ȣ</span></th>
								<th scope="col"><span>ī�װ���</span></th>
								<th scope="col"><span>�Ĵܸ�</span></th>
								<th scope="col"><span>��ȿ�Ⱓ</span></th>
								<th scope="col"><span>��ȯ����</span></th>
								<th scope="col"><span>�Ĵ�</span></th>
							</tr>
							<tr>
								<td>3</td>
								<td>�����ѽ�</td>
								<td>2014�� �� �Ĵ�</td>
								<td>2014.03.01~���</td>
								<td>3�ּ�ȯ</td>
								<td><a href="category_schedule_edit.jsp" class="function_btn"><span>����</span></a></td>
							</tr>
							<tr>
								<td>2</td>
								<td>�������</td>
								<td>2014�� �� �Ĵ�</td>
								<td>2014.03.01~���</td>
								<td>3�ּ�ȯ</td>
								<td><a href="category_schedule_edit.jsp" class="function_btn"><span>����</span></a></td>
							</tr>
							<tr>
								<td>1</td>
								<td>�˶���</td>
								<td>2014�� �� �Ĵ�</td>
								<td>2014.03.01~���</td>
								<td>2�ּ�ȯ</td>
								<td><a href="category_schedule_edit.jsp" class="function_btn"><span>����</span></a></td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="btn_style1">
					<p class="right_btn">
						<a href="category_schedule_write.jsp" class="function_btn"><span>���</span></a>
					</p>
				</div>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>