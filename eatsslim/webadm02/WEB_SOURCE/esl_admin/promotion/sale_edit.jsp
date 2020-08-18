<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_SALE";
String query		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();

int postId				= 0;
String title			= "";
String stdate			= "";
String ltdate			= "";
String sType		= "";
String sPrice		= "";
String useGoods		= "";
//String[] sales_goods = new String[] {};
List<Object> sales_goods = new ArrayList<Object>();

String groupCode	= "";
String groupName	= "";
String param			= "";
String keyword			= "";
String sid			= ut.inject(request.getParameter("id"));
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String schCate			= ut.inject(request.getParameter("sch_cate"));
String field			= ut.inject(request.getParameter("field"));


if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	postId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT ID, TITLE, STDATE, LTDATE, SALE_TYPE, SALE_PRICE, USE_GOODS, DATE_FORMAT(INST_DATE, '%Y-%m-%d') WDATE";
	query		+= " FROM " + table;
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, postId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		stdate			= rs.getString("STDATE");
		ltdate			= rs.getString("LTDATE");
		sType		= rs.getString("SALE_TYPE");
		sPrice			= rs.getString("SALE_PRICE");
		useGoods			= rs.getString("USE_GOODS");
	}

		
	if (useGoods.equals("02")) {
		
			query		= "SELECT SALE_ID, GROUP_CODE, GROUP_NAME FROM "+ table +"_GOODS ";
			query		+= "	WHERE SALE_ID = '"+ postId +"'";
			try {
				rs1		= stmt1.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			while (rs1.next()) {
				sales_goods.add( rs1.getString("GROUP_CODE") );
				//out.println(sales_goods[i]);
				i++;
			}
			
			rs1.close();
	}
			
	
} else {
	ut.jsBack(out);
	if (true) return;
}
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:9,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 프로모션관리 &gt; <strong>정율할인</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="sale_db.jsp">
					<input type="hidden" name="sid" value="<%=sid%>" />
					<input type="hidden" name="mode" value="mod" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>할인명</span></th>
								<td colspan="3">
									<input type="text" name="title" id="title" class="input1" style="width:300px;" maxlength="100" value="<%=title%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>사용기간</span></th>
								<td colspan="3">
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="10" readonly="readonly" value="<%=stdate%>" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="10" readonly="readonly" value="<%=ltdate%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>할인금액</span></th>
								<td colspan="3">
									<input type="radio" name="sale_type" value="P"<%if (sType.equals("P")) out.println(" checked=\"checked\"");%> />
									상품판매가격의
									<input type="text" name="sale_price1" id="sale_price1" value="<%if (sType.equals("P")) {out.println(sPrice);} else { out.println("0"); }%>" class="input1" style="width:60px;" maxlength="3" dir="rtl" onblur="this.value=this.value.replace(/[^0-9]/g,'');" />
									% 할인<br>
									<input type="radio" name="sale_type" value="W"<%if (sType.equals("W")) out.println(" checked=\"checked\"");%>/>
									상품판매가격의
									<input type="text" name="sale_price2" id="sale_price2" value="<%if (sType.equals("W")) {out.println(sPrice);} else { out.println("0"); }%>" class="input1" style="width:60px;" maxlength="7" dir="rtl" onkeyup="onlyNum(this);" />
									원 할인
								</td>
							</tr>
							<tr>
								<th scope="row"><span>적용 상품설정</span></th>
								<td colspan="3">
									<span class="mr_10">
										<input type="radio" name="use_goods" value="01" <%if (useGoods.equals("01")) out.println(" checked=\"checked\"");%> />
										전체상품에 적용
									</span>
									<span class="mr_10">
										<input type="radio" name="use_goods" value="02" <%if (useGoods.equals("02")) out.println(" checked=\"checked\"");%>/>
										특정 상품에만 적용
									</span>
									<div id="selGoods" class="cag01 <%if (useGoods.equals("01")) { out.println("hidden"); } %>">
										<p class="mt_5">
											<div style="overflow:auto;height:200px;">
												<table cellspacing="0" class="table01" style="width:500px;">
													<%
													query		= "SELECT GROUP_CODE, GROUP_NAME";
													query		+= " FROM ESL_GOODS_GROUP";
													query		+= " WHERE USE_YN = 'Y'";
													query		+= " ORDER BY GUBUN1, GUBUN2, GROUP_CODE";
													try {
														rs		= stmt.executeQuery(query);
													} catch(Exception e) {
														out.println(e+"=>"+query);
														if (true) return;
													}

													int bCheck;
													while (rs.next()) {
														bCheck = 0;
														for(i=0;i<sales_goods.size();i++) {
															if ( rs.getString("GROUP_CODE").equals(sales_goods.get(i) ) ) {
																bCheck = 1;
															}
														}
													%>
													<tr>
														<td><input type="checkbox" name="group_code" value="<%=rs.getString("GROUP_CODE")+","+rs.getString("GROUP_NAME")%>" <% if (bCheck == 1) out.println(" checked=\"checked\""); %>/></td>
														<td><%=rs.getString("GROUP_CODE")%></td>
														<td><%=rs.getString("GROUP_NAME")%></td>
													</tr>
													<%
													}
													rs.close();
													%>
												</table>
											</div>
										</p>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkWrite();" class="function_btn"><span>저장</span></a>
						<a href="sale_list.jsp" class="function_btn"><span>목록</span></a>
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

	$("input[name=use_goods]").click(function() {
		var useGoods	= $("input[name=use_goods]:checked").val();
		if (useGoods == '02') {
			$("#selGoods").removeClass("hidden");
		} else {
			$("#selGoods").addClass("hidden");
		}
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

function chkWrite() {
	var saleType	= $("input[name=sale_type]:checked").val();

	if (!$.trim($("#title").val())) {
		alert("할인명을 입력해주세요.");
		$("#title").focus();
		return;
	}
	if (!$.trim($("#stdate").val())) {
		alert("사용기간을 입력해주세요.");
		$("#stdate").focus();
		return;
	}
	if (!$.trim($("#ltdate").val())) {
		alert("사용기간을 입력해주세요.");
		$("#ltdate").focus();
		return;
	}
	if (saleType == "P" && (!$("#sale_price1").val() || parseInt($("#sale_price1").val()) < 1)) {
		alert("할인금액을 입력하세요.");
		$("#sale_price1").select();
		return;
	}
	if (saleType == "W" && (!$("#sale_price2").val() || parseInt($("#sale_price2").val()) < 1)) {
		alert("할인금액을 입력하세요.");
		$("#sale_price2").select();
		return;
	}
	if ($("input[name=use_goods]:checked").val() == "02" && !$("input[name=group_code]:checked").val() && !$("input[name=group_name]:checked").val()) {
		alert("상품을 등록하세요.");
		return;
	}

	document.frm_write.submit();
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>