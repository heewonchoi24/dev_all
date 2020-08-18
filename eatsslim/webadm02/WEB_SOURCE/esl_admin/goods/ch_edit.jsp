<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
int chId		= 0;
String chCode		= ut.inject(request.getParameter("ch_code"));
String chName		= ut.inject(request.getParameter("ch_name"));
String comment		= ut.inject(request.getParameter("comment"));
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String schYear		= ut.inject(request.getParameter("sch_year"));
String schGubun2	= ut.inject(request.getParameter("sch_gubun2"));

String param		= "page="+ iPage +"&pgsize="+ pgsize +"&sch_year="+ schYear;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	chId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT CH_CODE, CH_NAME, COMMENT";
	query		+= " FROM ESL_CHANNEL ";
	query		+= " WHERE ID = "+ chId;
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		chCode			= rs.getString("CH_CODE");
		chName			= rs.getString("CH_NAME");
		comment			= rs.getString("COMMENT");
	}

	rs.close();
}
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:7,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상품관리 &gt; <strong>채널관리</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="ch_db.jsp">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=chId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>채널명</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="25" name="ch_name" id="ch_name" value="<%=chName%>" required label="채널명" />
								</td>
								<th scope="row"><span>채널코드</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="25" name="ch_code" id="ch_code" value="<%=chCode%>" required label="채널코드" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>채널설명</span></th>
								<td>
									<input type="text" class="input1" style="width:300px;" maxlength="50" name="comment" id="comment" value="<%=comment%>" required label="채널설명" />
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_edit)"  class="function_btn"><span>저장</span></a>
						<a href="ch_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
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