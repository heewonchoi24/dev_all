<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
int cateId			= 0;
String setCode		= "";
String setName		= "";

if (request.getParameter("id") != null && request.getParameter("id").length() > 0)
	cateId		= Integer.parseInt(request.getParameter("id"));
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:5,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
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
				<table class="tableView" border="1" cellspacing="0">
					<colgroup>
						<col width="*" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span>일</span></th>
							<th scope="row"><span>월</span></th>
							<th scope="row"><span>화</span></th>
							<th scope="row"><span>수</span></th>
							<th scope="row"><span>목</span></th>
							<th scope="row"><span>금</span></th>
							<th scope="row"><span>토</span></th>
						</tr>
						<tr>
							<td>&nbsp;</td>							
							<td>&nbsp;</td>
							<td>&nbsp;</td>							
							<td>&nbsp;</td>
							<td>&nbsp;</td>							
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>							
							<td>&nbsp;</td>
							<td>&nbsp;</td>							
							<td>&nbsp;</td>
							<td>&nbsp;</td>							
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>							
							<td>&nbsp;</td>
							<td>&nbsp;</td>							
							<td>&nbsp;</td>
							<td>&nbsp;</td>							
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
				</table>
				<br />
				<form name="frm_write" id="frm_write" method="post" action="category_schedule_db.jsp">
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
								<th scope="row"><span>요일</span></th>
								<td>
									<select name="week_day">
										<option value="">선택</option>
										<option value="월">월</option>
										<option value="화">화</option>
										<option value="수">수</option>
										<option value="목">목</option>
										<option value="금">금</option>
										<option value="토">토</option>
										<option value="일">일</option>
									</select>
								</td>
								<th scope="row"><span>주구분</span></th>
								<td>
									<select name="week">
										<option value="">선택</option>
										<option value="1">1주차</option>
										<option value="2">2주차</option>
										<option value="3">3주차</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>식단</span></th>
								<td colspan="3">
									<select name="set_code">
										<option value="">선택</option>
										<%
										query		= "SELECT SET_CODE, SET_NAME";
										query		+= " FROM ESL_GOODS_SET ";
										query		+= " WHERE CATEGORY_ID = 1 AND USE_YN = 'Y'";
										try {
											rs	= stmt.executeQuery(query);
										} catch(Exception e) {
											out.println(e+"=>"+query);
											if(true)return;
										}

										while (rs.next()) {
											setCode			= rs.getString("SET_CODE");
											setName			= rs.getString("SET_NAME");
										%>
										<option value="<%=setCode%>"><%=setName%></option>
										<%
										}
										%>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" class="function_btn"><span>저장</span></a>
						<a href="category_schedule.jsp" class="function_btn"><span>목록</span></a>
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
	$('#stdate,#ltdate').datepick({ 
		onSelect: setPeriod,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
});

function setPeriod(dates) {
	var stdate		= $("#stdate").val();
	var ltdate		= $("#ltdate").val();

	if (this.id == 'stdate') {
		$('#ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>