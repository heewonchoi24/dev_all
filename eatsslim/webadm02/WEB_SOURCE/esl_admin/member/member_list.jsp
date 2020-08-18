<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_MEMBER";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String pCnt			= ut.inject(request.getParameter("p_cnt"));
String inStdate		= ut.inject(request.getParameter("in_stdate"));
String inLtdate		= ut.inject(request.getParameter("in_ltdate"));
String payStdate	= ut.inject(request.getParameter("pay_stdate"));
String payLtdate	= ut.inject(request.getParameter("pay_ltdate"));
String where		= "";
String param		= "";
String memberName	= "";
String memberId		= "";
String email		= "";
String hp			= "";
String purchaseDate	= "";
int purchasePrice	= 0;
int purchaseCnt		= 0;
String instDate		= "";
int couponCnt		= 0;
int todayCnt		= 0;
int loginCnt		= 0;
NumberFormat nf		= NumberFormat.getNumberInstance();

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

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

if (pCnt != null && pCnt.length() > 0) {
	param		+= "&amp;p_cnt="+ pCnt;
	if (pCnt.equals("1")) {
		where		+= " AND PURCHASE_CNT > 0";
	} else {
		where		+= " AND PURCHASE_CNT = 0";
	}
}

if (inStdate != null && inStdate.length() > 0) {
	param			+= "&amp;in_stdate="+ inStdate;
	where			+= " AND (DATE_FORMAT(INST_DATE, '%Y-%m-%d') >= '"+ inStdate +"')";
}

if (inLtdate != null && inLtdate.length() > 0) {
	param			+= "&amp;in_ltdate="+ inLtdate;
	where			+= " AND (DATE_FORMAT(INST_DATE, '%Y-%m-%d') <= '"+ inLtdate +"')";
}

if (payStdate != null && payStdate.length() > 0) {
	param			+= "&amp;pay_stdate="+ payStdate;
	where			+= " AND (DATE_FORMAT(PURCHASE_DATE, '%Y-%m-%d') >= '"+ payStdate +"')";
}

if (payLtdate != null && payLtdate.length() > 0) {
	param			+= "&amp;pay_ltdate="+ payLtdate;
	where			+= " AND (DATE_FORMAT(PURCHASE_DATE, '%Y-%m-%d') <= '"+ payLtdate +"')";
}

query		= "SELECT COUNT(ID) FROM "+ table;
query		+= " WHERE DATE_FORMAT(INST_DATE, '%Y-%m-%d') = '"+ cDate +"'";
try {
	rs = stmt1.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	todayCnt		= rs.getInt(1);
}
rs.close();

query		= "SELECT COUNT(ID) FROM "+ table;
query		+= " WHERE DATE_FORMAT(LAST_LOGIN_DATE, '%Y-%m-%d') = '"+ cDate +"'";
try {
	rs = stmt1.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	loginCnt		= rs.getInt(1);
}
rs.close();

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

query		= "SELECT ID, MEM_NAME, MEM_ID, EMAIL, HP, DATE_FORMAT(INST_DATE, '%Y-%m-%d') INST_DATE";
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
		<%@ include file="../include/inc-sidebar-member.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 회원관리 &gt; <strong>회원리스트</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="105px" />
							<col width="40%" />
							<col width="97px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>
										<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
											<option value="MEM_NAME"<%if(field.equals("MEM_NAME")){out.print(" selected=\"selected\"");}%>>이름</option>
											<option value="MEM_ID"<%if(field.equals("MEM_ID")){out.print(" selected=\"selected\"");}%>>아이디</option>
											<option value="HP"<%if(field.equals("HP")){out.print(" selected=\"selected\"");}%>>핸드폰</option>
											<option value="EMAIL"<%if(field.equals("EMAIL")){out.print(" selected=\"selected\"");}%>>이메일</option>
										</select>
									</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()"/></td>
								<th scope="row">
									<span>구매여부</span>
								</th>
								<td>
									<label>
										<input type="radio" name="p_cnt" value=""<%if(pCnt.equals(""))out.print(" checked");%> />
										전체
									</label>
									<label>
										<input type="radio" name="p_cnt" value="1"<%if(pCnt.equals("1"))out.print(" checked");%> />
										구매
									</label>
									<label>
										<input type="radio" name="p_cnt" value="2"<%if(pCnt.equals("2"))out.print(" checked");%> />
										미구매
									</label>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>가입일</span>
								</th>
								<td colspan="3">
									<input type="text" name="in_stdate" id="in_stdate" class="input1" maxlength="10" readonly="readonly" value="<%=inStdate%>" />
									~
									<input type="text" name="in_ltdate" id="in_ltdate" class="input1" maxlength="10" readonly="readonly" value="<%=inLtdate%>" />
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=cDate%>','<%=cDate%>')" style="margin-left:15px;" class="function_btn"><span>오늘</span></a>
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=preDate3%>','<%=cDate%>')" class="function_btn"><span>3일간</span></a>
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=preDate7%>','<%=cDate%>')" class="function_btn"><span>일주일</span></a>
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=preMonth1%>','<%=cDate%>')" class="function_btn"><span>1개월</span></a>
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=preMonth3%>','<%=cDate%>')" class="function_btn"><span>3개월</span></a>
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=preYear1%>','<%=cDate%>')" class="function_btn"><span>12개월</span></a>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>최종결제일</span>
								</th>
								<td colspan="3">
									<input type="text" name="pay_stdate" id="pay_stdate" class="input1" maxlength="10" readonly="readonly" value="<%=payStdate%>" />
									~
									<input type="text" name="pay_ltdate" id="pay_ltdate" class="input1" maxlength="10" readonly="readonly" value="<%=payLtdate%>" />
									<a href="javascript:setDate('pay_stdate','pay_ltdate','<%=cDate%>','<%=cDate%>')" style="margin-left:15px;" class="function_btn"><span>오늘</span></a>
									<a href="javascript:setDate('pay_stdate','pay_ltdate','<%=preDate3%>','<%=cDate%>')" class="function_btn"><span>3일간</span></a>
									<a href="javascript:setDate('pay_stdate','pay_ltdate','<%=preDate7%>','<%=cDate%>')" class="function_btn"><span>일주일</span></a>
									<a href="javascript:setDate('pay_stdate','pay_ltdate','<%=preMonth1%>','<%=cDate%>')" class="function_btn"><span>1개월</span></a>
									<a href="javascript:setDate('pay_stdate','pay_ltdate','<%=preMonth3%>','<%=cDate%>')" class="function_btn"><span>3개월</span></a>
									<a href="javascript:setDate('pay_stdate','pay_ltdate','<%=preYear1%>','<%=cDate%>')" class="function_btn"><span>12개월</span></a>
								</td>
							</tr>
						</tbody>
					</table>					
					<div class="btn_style1">
						<p class="btn_center">
							<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="검색" /></p>
						</p>
						<p class="right_btn">
							<a href="javascript:;" onclick="frmReset();" class="function_btn"><span>검색조건 초기화</span></a>
							<a href="javascript:;" onclick="excelDown();" class="function_btn"><span>엑셀다운로드</span></a>
						</p>				
					</div>
					<div class="member_box" style="height:50px;">
						<p class="search_result">
							전체회원 <strong><%=intTotalCnt%></strong>명<br />
							오늘 가입한 회원 <strong><%=todayCnt%></strong>명<br />
							오늘의 로그인 수 <strong><%=loginCnt%></strong>명<br />
						</p>
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
				<table class="table02" border="1" cellspacing="0">
					<colgroup>
						<col width="6%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="6%" />
						<col width="6%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="col"><span>번호</span></th>
							<th scope="col"><span>회원명</span></th>
							<th scope="col"><span>아이디</span></th>
							<!--th scope="col"><span>이메일</span></th>
							<th scope="col"><span>핸드폰</span></th-->
							<th scope="col"><span>최종구매일</span></th>
							<th scope="col"><span>결제금액</span></th>
							<th scope="col"><span>구매횟수</span></th>
							<th scope="col"><span>가입일</span></th>
							<th scope="col"><span>쿠폰내역</span></th>
						</tr>
						<%
						if (intTotalCnt > 0) {
							while (rs.next()) {
								memberName		= rs.getString("MEM_NAME");
								memberId		= rs.getString("MEM_ID");
								email			= rs.getString("EMAIL");
								hp				= rs.getString("HP");
								instDate		= rs.getString("INST_DATE");

								query1		= "SELECT COUNT(ID)";
								query1		+= " FROM ESL_COUPON_MEMBER";
								query1		+= " WHERE MEMBER_ID = '"+ memberId +"'";
								try {
									rs1 = stmt1.executeQuery(query1);
								} catch(Exception e) {
									out.println(e+"=>"+query1);
									if(true)return;
								}

								if (rs1.next()) {
									couponCnt		= rs1.getInt(1);
								}

								rs1.close();

								query1		= "SELECT COUNT(ORDER_NUM) PURCHASE_CNT, SUM(PAY_PRICE) PURCHASE_TPRICE";
								query1		+= " FROM ESL_ORDER WHERE MEMBER_ID = '"+ memberId +"'";
								query1		+= "  AND ((ORDER_STATE > 0 AND ORDER_STATE < 90) OR ORDER_STATE = '911')";
								try {
									rs1 = stmt1.executeQuery(query1);
								} catch(Exception e) {
									out.println(e+"=>"+query1);
									if(true)return;
								}

								if (rs1.next()) {
									purchaseCnt		= rs1.getInt("PURCHASE_CNT");
									purchasePrice	= rs1.getInt("PURCHASE_TPRICE");
								}

								rs1.close();

								if (purchaseCnt > 0) {
									query1		= "SELECT PAY_DATE";
									query1		+= " FROM ESL_ORDER WHERE MEMBER_ID = '"+ memberId +"'";
									query1		+= " AND ((ORDER_STATE > 0 AND ORDER_STATE < 90) OR ORDER_STATE = '911')";
									query1		+= " ORDER BY ORDER_NUM DESC LIMIT 0, 1";
									try {
										rs1 = stmt1.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}

									if (rs1.next()) {
										purchaseDate	= ut.isnull(rs1.getString("PAY_DATE"));
									}

									rs1.close();
								} else {
									purchaseDate	= "";
								}

								query1		= "UPDATE ESL_MEMBER SET ";
								query1		+= "		PURCHASE_CNT		= "+ purchaseCnt;
								query1		+= "		,PURCHASE_TPRICE	= "+ purchasePrice;
								if (purchaseCnt > 0) {
									query1		+= "		,PURCHASE_DATE		= '"+ purchaseDate +"'";
								} else {
									query1		+= "		,PURCHASE_DATE		= null";
								}
								query1		+= " WHERE MEM_ID = '"+ memberId +"'";
								try {
									stmt1.executeUpdate(query1);
								} catch(Exception e) {
									out.println(e+"=>"+query1);
									if(true)return;
								}

								purchaseDate	= (purchaseDate.equals(""))? "&nbsp;" : purchaseDate.substring(0, 10);
						%>
						<tr>
							<td><%=curNum%></td>
							<td><a href="member_view.jsp?id=<%=memberId + param%>"><%=memberName%></a></td>
							<td><%=memberId%></td>
							<!--td><%=email%></td>
							<td><%=hp%></td-->
							<td><%=purchaseDate%></td>
							<td><%=nf.format(purchasePrice)%></td>
							<td><%=purchaseCnt%></td>
							<td><%=instDate%></td>
							<td>
						<%		if (couponCnt > 0) {%>
								<a href="javascript:;" onclick="popup('member_coupon_list.jsp?mid=<%=memberId%>',900,720,'mcoupon_view');">회원쿠폰내역 조회(<%=couponCnt%> 건)</a>
						<%		} else {%>
								쿠폰발급내역이 없습니다.
						<%		}%>
							</td>
						</tr>
						<%
								curNum--;
							}
						} else {
						%>
						<tr>
							<td colspan="10">등록된 회원이 없습니다.</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
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
	$('#in_stdate,#in_ltdate').datepick({ 
		onSelect: customRange1,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$('#pay_stdate,#pay_ltdate').datepick({ 
		onSelect: customRange2,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	}); 
});

function customRange1(dates) {
	if (this.id == 'in_stdate') { 
        $('#in_ltdate').datepick('option', 'minDate', dates[0] || null); 
    } else { 
        $('#in_stdate').datepick('option', 'maxDate', dates[0] || null); 
    }
}

function customRange2(dates) {
	if (this.id == 'pay_stdate') { 
        $('#pay_ltdate').datepick('option', 'minDate', dates[0] || null); 
    } else { 
        $('#pay_stdate').datepick('option', 'maxDate', dates[0] || null); 
    }
}

function excelDown(){
	<%if(intTotalCnt==0){%>alert("검색된 회원이 없습니다.");return;<%}%>
	var f	= document.frm_search;
	f.target	= "ifrmHidden";
	f.action	= "member_list_excel.jsp";
	//f.encoding="application/x-www-form-urlencoded";
	f.submit();	
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>