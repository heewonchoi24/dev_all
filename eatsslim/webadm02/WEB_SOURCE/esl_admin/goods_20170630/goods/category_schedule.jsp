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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상품관리 &gt; <strong>식단관리</strong></p>
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
											<option value="TITLE">식단명</option>
											<option value="CONTENT">카테고리명</option>
										</select>
									</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="" onfocus="this.select()"/></td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="검색" /></p>			
					<div class="member_box">
						<p class="search_result">총 <strong>3</strong>개</p>
						<p class="right_box">
							<select name="pgsize" onchange="this.form.submit()">
								<option value="10">10개씩보기</option>
								<option value="20">20개씩보기</option>
								<option value="30">30개씩보기</option>
								<option value="100">100개씩보기</option>
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
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>카테고리명</span></th>
								<th scope="col"><span>식단명</span></th>
								<th scope="col"><span>유효기간</span></th>
								<th scope="col"><span>순환주차</span></th>
								<th scope="col"><span>식단</span></th>
							</tr>
							<tr>
								<td>3</td>
								<td>퀴진한식</td>
								<td>2014년 봄 식단</td>
								<td>2014.03.01~계속</td>
								<td>3주순환</td>
								<td><a href="category_schedule_edit.jsp" class="function_btn"><span>수정</span></a></td>
							</tr>
							<tr>
								<td>2</td>
								<td>퀴진양식</td>
								<td>2014년 봄 식단</td>
								<td>2014.03.01~계속</td>
								<td>3주순환</td>
								<td><a href="category_schedule_edit.jsp" class="function_btn"><span>수정</span></a></td>
							</tr>
							<tr>
								<td>1</td>
								<td>알라까르떼</td>
								<td>2014년 봄 식단</td>
								<td>2014.03.01~계속</td>
								<td>2주순환</td>
								<td><a href="category_schedule_edit.jsp" class="function_btn"><span>수정</span></a></td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="btn_style1">
					<p class="right_btn">
						<a href="category_schedule_write.jsp" class="function_btn"><span>등록</span></a>
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