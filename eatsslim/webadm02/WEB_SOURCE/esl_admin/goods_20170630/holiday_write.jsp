<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../include/inc-top.jsp"%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:6,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="权" /> &gt; 惑前包府 &gt; <strong>绒公老包府</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="holiday_db.jsp">
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
								<th scope="row"><span>绒公老</span></th>
								<td>
									<input type="text" class="input1" maxlength="10" name="holiday" id="holiday" value="" required label="绒公老" readonly="readonly" />
								</td>
								<th scope="row"><span>绒公疙</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="25" name="holiday_name" id="holiday_name" value="" required label="绒公疙" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>绒公汲疙</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="100" name="comment" id="comment" value="" />
								</td>
								<th scope="row"><span>绒公备盒</span></th>
								<td>
									<select name="holiday_type">
										<option value="01">琶硅绒公</option>
										<option value="02">流硅绒公</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_write)"  class="function_btn"><span>历厘</span></a>
						<a href="holiday_list.jsp" class="function_btn"><span>格废</span></a>
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
	$('#holiday').datepick({
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	}); 
});
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>