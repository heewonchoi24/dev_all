<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
String table		= "ESL_COUPON";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String keyword		= ut.inject(request.getParameter("keyword"));
String schCtype		= ut.inject(request.getParameter("sch_ctype"));
String schStdate	= ut.inject(request.getParameter("sch_stdate"));
String schLtdate	= ut.inject(request.getParameter("sch_ltdate"));
String schVendor	= ut.inject(request.getParameter("sch_vendor"));
int couponId		= 0;
String couponName	= "";
String couponType	= "";
String stdate		= "";
String ltdate		= "";
String vendor		= "";
String saleType		= "";
int salePrice		= 0;
String saleTxt		= "";
String instDate		= "";
int couponCnt		= 0;
int useCnt			= 0;
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
	where		+= " AND COUPON_NAME LIKE '%"+ keyword +"%'";
}

if (schCtype != null && schCtype.length() > 0) {
	param			+= "&amp;sch_ctype="+ schCtype;
	where			+= " AND COUPON_TYPE = '"+ schCtype +"'";
}

if (schStdate != null && schStdate.length() > 0) {
	param			+= "&amp;sch_stdate="+ schStdate;
	where			+= " AND DATE_FORMAT(INST_DATE, '%Y-%m-%d') >= '"+ schStdate +"'";
}

if (schLtdate != null && schLtdate.length() > 0) {
	param			+= "&amp;sch_ltdate="+ schLtdate;
	where			+= " AND DATE_FORMAT(INST_DATE, '%Y-%m-%d') <= '"+ schLtdate +"'";
}

if (schVendor != null && schVendor.length() > 0) {
	param			+= "&amp;sch_vendor="+ schVendor;
	where			+= " AND VENDOR = '"+ schVendor +"'";
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

query		= "SELECT ID, COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, DATE_FORMAT(INST_DATE, '%Y-%m-%d') WDATE,";
query		+= "	MAX_COUPON_CNT";
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
		$('#lnb').menuModel2({hightLight:{level_1:1,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 프로모션관리 &gt; <strong>쿠폰관리</strong></p>
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
									<span>쿠폰명</span>
								</th>
								<td colspan="3"><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()"/></td>
							</tr>
							<tr>
								<th scope="row">
									<span>구분</span>
								</th>
								<td>
									<input type="radio" name="sch_ctype" value=""<%if (schCtype.equals("") || schCtype == null) out.println(" checked=\"checked\"");%> />
									전체
									<input type="radio" name="sch_ctype" value="01"<%if (schCtype.equals("01")) out.println(" checked=\"checked\"");%> />
									온라인
									<input type="radio" name="sch_ctype" value="02"<%if (schCtype.equals("02")) out.println(" checked=\"checked\"");%> />
									오프라인
								</td>
								<th scope="row">
									<span>발행그룹</span>
								</th>
								<td>
									<select style="width:80px;" name="sch_vendor">
										<option value=""<%if (schVendor.equals("") || schVendor == null) out.println(" selected=\"selected\"");%>>전체</option>
										<option value="01"<%if (schVendor.equals("01")) out.println(" selected=\"selected\"");%>>이벤트</option>
										<option value="02"<%if (schVendor.equals("02")) out.println(" selected=\"selected\"");%>>CRM</option>
										<option value="03"<%if (schVendor.equals("03")) out.println(" selected=\"selected\"");%>>제휴처</option>
										<option value="04"<%if (schVendor.equals("04")) out.println(" selected=\"selected\"");%>>CS</option>
										<option value="05"<%if (schVendor.equals("05")) out.println(" selected=\"selected\"");%>>기타</option>
										<option value="06"<%if (schVendor.equals("06")) out.println(" selected=\"selected\"");%>>신규회원</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>발행일</span>
								</th>
								<td colspan="3">
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
					<input type="hidden" name="mode" value="updAll" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<!--col width="4%" /-->
							<col width="4%" />
							<col width="6%" />
							<col width="6%" />
							<col width="*" />
							<col width="10%" />
							<col width="6%" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
							<col width="6%" />
						</colgroup>
						<tbody>
							<tr>
								<!--th scope="col"><span><input type="checkbox" id="selectall" /></span></td-->
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>구분</span></th>
								<th scope="col"><span>발행구분</span></th>
								<th scope="col"><span>쿠폰명</span></th>
								<th scope="col"><span>쿠폰금액</span></th>
								<th scope="col"><span>종료여부</span></th>
								<th scope="col"><span>사용기간</span></th>
								<th scope="col"><span>발행일</span></th>
								<th scope="col"><span>발급/사용</span></th>
								<th scope="col"><span>수정</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									couponId	= rs.getInt("ID");
									couponName	= rs.getString("COUPON_NAME");
									couponType	= rs.getString("COUPON_TYPE");
									stdate		= rs.getString("STDATE");
									ltdate		= rs.getString("LTDATE");
									vendor		= rs.getString("VENDOR");
									saleType	= rs.getString("SALE_TYPE");
									salePrice	= rs.getInt("SALE_PRICE");
									saleTxt		= (saleType.equals("P"))? "%할인" : "원";
									instDate	= rs.getString("WDATE");
									date2		= dt.parse(ltdate);
								 
									diff		= date2.getTime() - date1.getTime();
									diffDays	= diff / (24 * 60 * 60 * 1000);
									endType		= (diffDays >= 0)? "N" : "Y";

									if (couponType.equals("01")) {
										query1		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER WHERE COUPON_ID = "+ couponId;
										try {
											rs1			= stmt1.executeQuery(query1);
										} catch(Exception e) {
											out.println(e+"=>"+query1);
											if(true)return;
										}

										if (rs1.next()) {
											couponCnt	= rs1.getInt(1);
										}
										rs1.close();
									} else {
										couponCnt	= rs.getInt("MAX_COUPON_CNT");
									}

									query1		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
									query1		+= " WHERE COUPON_ID = "+ couponId +" AND USE_YN = 'Y'";
									try {
										rs1			= stmt1.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}

									if (rs1.next()) {
										useCnt		= rs1.getInt(1);
									}
									rs1.close();
							%>
							<tr>
								<!--td><input type="checkbox" class="selectable" value="<%=couponId%>" /></td-->
								<td><%=curNum%></td>
								<td><%=ut.getCouponType(couponType)%></td>
								<td><%=ut.getVendor(vendor)%></td>
								<td><%=couponName%></td>
								<td><%=nf.format(salePrice)+saleTxt%></td>
								<td><%=endType%></td>
								<td><%=stdate+"~<br />"+ltdate%></td>
								<td><%=instDate%></td>
								<td><a href="coupon_view.jsp?id=<%=couponId + param%>&ctype=<%=couponType%>"><%=couponCnt%>건/<br /><%=useCnt%>건</a></td>
								<td><a href="coupon_edit.jsp?id=<%=couponId + param%>" class="function_btn"><span>수정</span></a></td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="10">등록된 쿠폰이 없습니다.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<div class="btn_style1">
					<p class="left_btn">
						<!--a href="javascript:;" class="function_btn"><span>삭제</span></a-->
					</p>
					<p class="right_btn">
						<a href="coupon_write.jsp" class="function_btn"><span>쿠폰 만들기</span></a>
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