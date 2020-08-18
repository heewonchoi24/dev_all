<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
String table		= "ESL_SALE";
String query		= "";
String keyword		= ut.inject(request.getParameter("keyword"));
String schStdate	= ut.inject(request.getParameter("sch_stdate"));
String schLtdate	= ut.inject(request.getParameter("sch_ltdate"));
int saleId			= 0;
String title		= "";
String stdate		= "";
String ltdate		= "";
String saleType		= "";
int salePrice		= 0;
String saleTxt		= "";
String instDate		= "";
NumberFormat nf		= NumberFormat.getNumberInstance();
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
Date date1			= dt.parse(cDate);
Date date2			= null;
int compare			= 0;
long diff			= 0;
long diffDays		= 0;
String endType		= "";
String where		= "";
String param		= "";

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

if (keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;keyword="+ keyword;
	where		+= " AND TITLE LIKE '%"+ keyword +"%'";
}

if (schStdate != null && schStdate.length() > 0) {
	param			+= "&amp;sch_stdate="+ schStdate;
	where			+= " AND DATE_FORMAT(INST_DATE, '%Y-%m-%d') >= '"+ schStdate +"'";
}

if (schLtdate != null && schLtdate.length() > 0) {
	param			+= "&amp;sch_ltdate="+ schLtdate;
	where			+= " AND DATE_FORMAT(INST_DATE, '%Y-%m-%d') <= '"+ schLtdate +"'";
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

query		= "SELECT ID, TITLE, STDATE, LTDATE, SALE_TYPE, SALE_PRICE, DATE_FORMAT(INST_DATE, '%Y-%m-%d') WDATE";
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
		$('#lnb').menuModel2({hightLight:{level_1:9,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>할인명</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()"/></td>
							</tr>
							<tr>
								<th scope="row">
									<span>발행일</span>
								</th>
								<td>
									<input type="text" name="sch_stdate" id="sch_stdate" class="input1" maxlength="10" readonly="readonly" value="<%=schStdate%>" />
									~
									<input type="text" name="sch_ltdate" id="sch_ltdate" class="input1" maxlength="10" readonly="readonly" value="<%=schLtdate%>" />
									<a href="javascript:setDate('sch_stdate','sch_ltdate','<%=cDate%>','<%=cDate%>')" style="margin-left:15px;" class="function_btn"><span>오늘</span></a>
									<a href="javascript:setDate('sch_stdate','sch_ltdate','<%=preDate3%>','<%=cDate%>')" class="function_btn"><span>3일간</span></a>
									<a href="javascript:setDate('sch_stdate','sch_ltdate','<%=preDate7%>','<%=cDate%>')" class="function_btn"><span>일주일</span></a>
									<a href="javascript:setDate('sch_stdate','sch_ltdate','<%=preMonth1%>','<%=cDate%>')" class="function_btn"><span>1개월</span></a>
									<a href="javascript:setDate('sch_stdate','sch_ltdate','<%=preMonth3%>','<%=cDate%>')" class="function_btn"><span>3개월</span></a>
									<a href="javascript:setDate('sch_stdate','sch_ltdate','<%=preYear1%>','<%=cDate%>')" class="function_btn"><span>12개월</span></a>
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
				<form name="frm_list" id="frm_list" method="post">
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="6%" />
							<col width="*" />
							<col width="10%" />
							<col width="6%" />
							<col width="20%" />
							<col width="10%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>할인명</span></th>
								<th scope="col"><span>할인금액</span></th>
								<th scope="col"><span>종료여부</span></th>
								<th scope="col"><span>사용기간</span></th>
								<th scope="col"><span>발행일</span></th>
								<th scope="col"><span>수정</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									saleId		= rs.getInt("ID");
									title		= rs.getString("TITLE");
									stdate		= rs.getString("STDATE");
									ltdate		= rs.getString("LTDATE");
									saleType	= rs.getString("SALE_TYPE");
									salePrice	= rs.getInt("SALE_PRICE");
									saleTxt		= (saleType.equals("P"))? "%할인" : "원";
									instDate	= rs.getString("WDATE");
									date2		= dt.parse(ltdate);
								 
									diff		= date2.getTime() - date1.getTime();
									diffDays	= diff / (24 * 60 * 60 * 1000);
									endType		= (diffDays >= 0)? "N" : "Y";
							%>
							<tr>
								<td><%=curNum%></td>
								<td><%=title%></td>
								<td><%=nf.format(salePrice)+saleTxt%></td>
								<td><%=endType%></td>
								<td><%=stdate+"~"+ltdate%></td>
								<td><%=instDate%></td>
								<td>
									<a href="sale_edit.jsp?id=<%=saleId + param%>" class="function_btn"><span>수정</span></a>
								</td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="6">등록된 정율할인이 없습니다.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<div class="btn_style1">
					<p class="right_btn">
						<a href="sale_write.jsp" class="function_btn"><span>등록</span></a>
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
	$('#sch_stdate,#sch_ltdate').datepick({ 
		onSelect: setPeriod,
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
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>