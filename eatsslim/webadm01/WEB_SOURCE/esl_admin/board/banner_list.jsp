<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
String table		= "ESL_BANNER";
String query		= "";
String schOpen		= ut.inject(request.getParameter("sch_open"));
String schStdate	= ut.inject(request.getParameter("sch_stdate"));
String schLtdate	= ut.inject(request.getParameter("sch_ltdate"));
String schEndStdate	= ut.inject(request.getParameter("sch_end_stdate"));
String schEndLtdate	= ut.inject(request.getParameter("sch_end_ltdate"));
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
int bannerId		= 0;
String openYn		= "";
String title		= "";
String stdate		= "";
String ltdate		= "";
String link			= "";
String instDate		= "";
String btype		= "";
String bannerType	= ut.inject(request.getParameter("banner_type"));

///////////////////////////
int pgsize		= 10; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int iPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;

where			= " WHERE 1=1";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

if (schOpen != null && schOpen.length() > 0) {
	param			+= "&amp;sch_open="+ schOpen;
	where			+= " AND OPEN_YN = '"+ schOpen +"'";
}

if (schStdate != null && schStdate.length() > 0) {
	param			+= "&amp;sch_stdate="+ schStdate;
	where			+= " AND STDATE >= '"+ schStdate +"'";
}

if (schLtdate != null && schLtdate.length() > 0) {
	param			+= "&amp;sch_ltdate="+ schLtdate;
	where			+= " AND STDATE <= '"+ schLtdate +"'";
}

if (schEndStdate != null && schEndStdate.length() > 0) {
	param			+= "&amp;sch_end_stdate="+ schEndStdate;
	where			+= " AND LTDATE >= '"+ schEndStdate +"'";
}

if (schEndLtdate != null && schEndLtdate.length() > 0) {
	param			+= "&amp;sch_end_ltdate="+ schEndLtdate;
	where			+= " AND LTDATE <= '"+ schEndLtdate +"'";
}

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

if (bannerType != null && bannerType.length() > 0) {
	param			+= "&amp;banner_type="+ bannerType;
	where			+= " AND GUBUN = '"+ bannerType +"'";
}

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // 총 페이지 수
endpage		= startpage + pagelist - 1;
if (endpage > totalPage) {
	endpage = totalPage;
}
curNum		= intTotalCnt-pgsize*(iPage-1);
param		+= "&amp;pgsize=" + pgsize;

query		= "SELECT ID, TITLE, OPEN_YN, LINK, STDATE, LTDATE, GUBUN, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ID DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>
	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:6,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
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
		<%@ include file="../include/inc-sidebar-board.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 게시판관리 &gt; <strong>배너관리</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>
										<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
											<option value="TITLE"<%if(field.equals("TITLE")){out.print(" selected=\"selected\"");}%>>제목</option>
											<option value="CONTENT"<%if(field.equals("CONTENT")){out.print(" selected=\"selected\"");}%>>내용</option>
										</select>
									</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()"/></td>
								<th scope="row">
									<span>적용여부</span>
								</th>
								<td>
									<input type="radio" name="sch_open" value=""<%if (schOpen.equals("") || schOpen == null) out.println(" checked=\"checked\"");%> />
									전체
									<input type="radio" name="sch_open" value="Y"<%if (schOpen.equals("Y")) out.println(" checked=\"checked\"");%> />
									적용
									<input type="radio" name="sch_open" value="N"<%if (schOpen.equals("N")) out.println(" checked=\"checked\"");%> />
									미적용
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>시작일</span>
								</th>
								<td>
									<input type="text" name="sch_stdate" id="sch_stdate" class="input1" maxlength="10" readonly="readonly" value="<%=schStdate%>" />
									~
									<input type="text" name="sch_ltdate" id="sch_ltdate" class="input1" maxlength="10" readonly="readonly" value="<%=schLtdate%>" />
								</td>
								<th scope="row">
									<span>종료일</span>
								</th>
								<td>
									<input type="text" name="sch_end_stdate" id="sch_end_stdate" class="input1" maxlength="10" readonly="readonly" value="<%=schEndStdate%>" />
									~
									<input type="text" name="sch_end_ltdate" id="sch_end_ltdate" class="input1" maxlength="10" readonly="readonly" value="<%=schEndLtdate%>" />
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>구분</span>
								</th>
								<td>
									<span>
										<select style="width:80px;" name="banner_type" onchange="this.form.keyword.focus()">
											<option value="">전체</option>
											<option value="1"<%if(bannerType.equals("1")){out.print(" selected=\"selected\"");}%>>메인배너</option>
											<option value="2"<%if(bannerType.equals("2")){out.print(" selected=\"selected\"");}%>>고정배너1</option>
											<option value="3"<%if(bannerType.equals("3")){out.print(" selected=\"selected\"");}%>>고정배너2</option>
											<option value="4"<%if(bannerType.equals("4")){out.print(" selected=\"selected\"");}%>>고정배너3</option>
											<option value="5"<%if(bannerType.equals("5")){out.print(" selected=\"selected\"");}%>>모바일메인</option>
										</select>
									</span>								
								</td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="검색" /></p>			
					<div class="member_box">
						<p class="search_result">총 <strong><%=intTotalCnt%></strong>개</p>
						<p class="right_box">
							<select name="pgsize" onchange="this.form.submit()">
								<option value="10"<%if(pgsize==10)out.print(" selected");%>>10개씩보기</option>
								<option value="20"<%if(pgsize==20)out.print(" selected");%>>20개씩보기</option>
								<option value="30"<%if(pgsize==30)out.print(" selected");%>>30개씩보기</option>
								<option value="100"<%if(pgsize==100)out.print(" selected");%>>100개씩보기</option>
							</select>
						</p>
					</div>
				</form>
				<form name="frm_list" id="frm_list" method="post" action="banner_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="del" />
					<input type="hidden" name="del_ids" id="del_ids" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="4%" />
							<col width="6%" />
							<col width="10%" />
							<col width="*%" />
							<col width="20%" />
							<col width="10%" />
							<col width="10%" />
							<col width="6%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span><input type="checkbox" id="selectall" /></span></td>
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>구분</span></th>
								<th scope="col"><span>제목</span></th>
								<th scope="col"><span>적용기간</span></th>
								<th scope="col"><span>작성일</span></th>
								<th scope="col"><span>적용여부</span></th>
								<th scope="col"><span>수정</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									bannerId		= rs.getInt("ID");
									openYn		= (rs.getString("OPEN_YN").equals("Y"))? "적용" : "미적용";
									title		= rs.getString("TITLE");
									btype		= ut.getBannerType(rs.getString("GUBUN"));
									stdate		= rs.getString("STDATE");
									ltdate		= rs.getString("LTDATE");
									link		= (rs.getString("LINK").equals(""))? "&nbsp;" : rs.getString("LINK");
									instDate	= rs.getString("WDATE");
							%>
							<tr>
								<td><input type="checkbox" class="selectable" value="<%=bannerId%>" /></td>
								<td><%=curNum%></td>
								<td><%=btype%></td>
								<td><%=ut.cutString(120, title, "..")%></td>
								<td><%=stdate%>~<%=ltdate%></td>
								<td><%=instDate%></td>
								<td><%=openYn%></td>
								<td>
									<a href="banner_edit.jsp?id=<%=bannerId + param%>" class="function_btn"><span>수정</span></a>
								</td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="8">등록된 배너가 없습니다.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<div class="btn_style1">
					<p class="left_btn">
						<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>삭제</span></a>						
					</p>
					<p class="right_btn">
						<a href="banner_write.jsp" class="function_btn"><span>등록</span></a>
					</p>
				</div>
				<%@ include file="../include/inc-paging.jsp"%>
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
	$("#selectall").click(selectAll);
	$('#sch_stdate,#sch_ltdate').datepick({ 
		onSelect: setPeriod,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$('#sch_end_stdate,#sch_end_ltdate').datepick({ 
		onSelect: setPeriod1,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
});

function setPeriod(dates) {
	var stdate		= $("#sch_stdate").val();
	var ltdate		= $("#sch_ltdate").val();

	if (this.id == 'sch_stdate') {
		$('#sch_ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#sch_stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}

function setPeriod1(dates) {
	var stdate		= $("#sch_end_stdate").val();
	var ltdate		= $("#sch_end_ltdate").val();

	if (this.id == 'sch_end_stdate') {
		$('#sch_end_ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#sch_end_stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}

function selectAll() {
    var checked = $("#selectall").attr("checked");

    $(".selectable").each(function(){
       var subChecked = $(this).attr("checked");
       if (subChecked != checked)
          $(this).click();
    });
}

function chkDel() {
	var chk_del = $(".selectable:checked");

	if(chk_del.length < 1) {
		alert("삭제할 게시물을 선택하세요!");
	} else {
		if (confirm("정말로 삭제하시겠습니까?")) {
			var del_arr = new Array();
			var i = 0;
			$(".selectable:checked").each(function() {
				del_arr[i] = $(this).val();
				i++;
			});
			var del_ids_val = del_arr.join();
			
			$("#del_ids").val(del_ids_val);
			document.frm_list.submit();
		}
	}
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>