<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
String table		= "ESL_EVENT_VERSUS";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
String memberId		= "";
String versus		= "";
String instDate		= "";
String updtDate		= "";
int versus1			= 0;
int versus2			= 0;

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

query		= "SELECT ";
query		+= " (SELECT COUNT(ID) FROM ESL_EVENT_VERSUS WHERE VERSUS = '1') AS VERSUS1";
query		+= " ,(SELECT COUNT(ID) FROM ESL_EVENT_VERSUS WHERE VERSUS = '2') AS VERSUS2";
query		+= " FROM DUAL";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if (true) return;
}

if (rs.next()) {
	versus1		= rs.getInt("VERSUS1");
	versus2		= rs.getInt("VERSUS2");
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

query		= "SELECT ID, MEMBER_ID, VERSUS, CNT, DATE_FORMAT(INST_DATE, '%Y.%m.%d') INST_DATE, DATE_FORMAT(UPDT_DATE, '%Y.%m.%d') UPDT_DATE";
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
		$('#lnb').menuModel2({hightLight:{level_1:4,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 프로모션관리 &gt; <strong>최과장VS이대리</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="105px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>
										<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
											<option value="MEMBER_ID"<%if(field.equals("MEMBER_ID")){out.print(" selected=\"selected\"");}%>>회원아이디</option>
											<option value="VERSUS"<%if(field.equals("VERSUS")){out.print(" selected=\"selected\"");}%>>투표한 사람</option>
										</select>
									</span>
								</th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()"/>
									투표한 사람 검색 (1: 최과장, 2: 이대리)
								</td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="검색" /></p>			
					<div class="member_box">
						<p class="search_result">총 <strong><%=intTotalCnt%></strong>개 / 최과장(<%=versus1%> : 이대리 : <%=versus2%>)</p>
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
				<form name="frm_list" id="frm_list" method="post" action="event_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="del" />
					<input type="hidden" name="del_ids" id="del_ids" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="6%" />
							<col width="*" />
							<col width="15%" />
							<col width="15%" />
							<col width="15%" />
							<col width="15%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>아이디</span></th>
								<th scope="col"><span>투표한 사람</span></th>
								<th scope="col"><span>투표횟수</span></th>
								<th scope="col"><span>1차등록일</span></th>
								<th scope="col"><span>2차등록일</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									memberId	= rs.getString("MEMBER_ID");
									versus		= (rs.getString("VERSUS").equals("1"))? "최과장" : "이대리";
									cnt			= rs.getInt("CNT");
									instDate	= rs.getString("INST_DATE");
									updtDate	= ut.isnull(rs.getString("UPDT_DATE"));
									updtDate	= (updtDate.equals(""))? "&nbsp;" : updtDate;
							%>
							<tr>
								<td><%=curNum%></td>
								<td><%=memberId%></td>
								<td><%=versus%></td>
								<td><%=cnt%></td>
								<td><%=instDate%></td>
								<td><%=updtDate%></td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="11">등록된 투표자가 없습니다.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<div class="btn_style1">
					<p class="right_btn">
						<a href="javascript:;" onclick="excelDown();" class="function_btn"><span>엑셀다운로드</span></a>
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
function excelDown(){
	var f	= document.frm_list;
	f.target	= "ifrmHidden";
	f.action	= "event_versus_excel.jsp";
	//f.encoding="application/x-www-form-urlencoded";
	f.submit();	
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>