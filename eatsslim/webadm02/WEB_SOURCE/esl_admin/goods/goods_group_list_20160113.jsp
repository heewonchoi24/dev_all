<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table				= "ESL_GOODS_GROUP";
String query1				= "";
String query2				= "";
String query3				= "";
ResultSet rs1				= null; 
PreparedStatement pstmt1	= null;
String schGubun1			= ut.inject(request.getParameter("sch_gubun1"));
String schGubun2			= ut.inject(request.getParameter("sch_gubun2"));
String field				= ut.inject(request.getParameter("field"));
String keyword				= ut.inject(request.getParameter("keyword"));
String where				= "";
String param				= "";
int groupId					= 0;
String gubun1				= "";
String gubun2				= "";
String gubun1Txt			= "";
String gubun2Txt			= "";
String groupName			= "";
String groupCode			= "";
String instDate				= "";
String editUrl				= "";

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
int curNum			= 0;
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

if (schGubun1 != null && schGubun1.length() > 0) {
	param		+= "&amp;sch_gubun1="+ schGubun1;
	where		+= " AND GUBUN1 = '"+ schGubun1 +"'";
}
if (schGubun2 != null && schGubun2.length() > 0) {
	param		+= "&amp;sch_gubun2="+ schGubun2;
	where		+= " AND GUBUN2 = '"+ schGubun2 +"'";
}
if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

query1		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query1);
rs		= pstmt.executeQuery();
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

query2		= "SELECT ID, GUBUN1, GUBUN2, GROUP_NAME, GROUP_CODE, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE";
query2		+= " FROM "+ table + where;
query2		+= " ORDER BY ID DESC";
query2		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query2); if(true)return;
pstmt		= conn.prepareStatement(query2);
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
		<%@ include file="../include/inc-sidebar-product.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상품관리 &gt; <strong>세트그룹관리</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="130px" />
							<col width="40%" />
							<col width="130px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>구분</span>
								</th>
								<td>
									<select name="sch_gubun1" id="sch_gubun1" onchange="getGubun2()">
										<option value="">구분1</option>
										<option value="01"<%if (schGubun1.equals("01")) { out.println(" selected=\"selected\"");}%>>식사다이어트</option>
										<option value="02"<%if (schGubun1.equals("02")) { out.println(" selected=\"selected\"");}%>>프로그램다이어트</option>
										<option value="03"<%if (schGubun1.equals("03")) { out.println(" selected=\"selected\"");}%>>타입별다이어트</option>
									</select>
									<select name="sch_gubun2" id="sch_gubun2">
										<%
										if (!schGubun1.equals("") && schGubun1 != null) {
										%>
										<option value="">선택</option>
										<%
											if (schGubun1.equals("01")) {
										%>
										<option value="11"<%if (schGubun2.equals("11")) { out.println(" selected=\"selected\"");}%>>1식</option>
										<option value="12"<%if (schGubun2.equals("12")) { out.println(" selected=\"selected\"");}%>>2식</option>
										<option value="13"<%if (schGubun2.equals("13")) { out.println(" selected=\"selected\"");}%>>3식</option>
										<option value="14"<%if (schGubun2.equals("14")) { out.println(" selected=\"selected\"");}%>>2식+간식</option>
										<option value="15"<%if (schGubun2.equals("15")) { out.println(" selected=\"selected\"");}%>>3식+간식</option>
										<%
											} else if (schGubun1.equals("02")) {
										%>
										<option value="21"<%if (schGubun2.equals("21")) { out.println(" selected=\"selected\"");}%>>감량</option>
										<option value="22"<%if (schGubun2.equals("22")) { out.println(" selected=\"selected\"");}%>>유지</option>
										<option value="23"<%if (schGubun2.equals("23")) { out.println(" selected=\"selected\"");}%>>FULL-STEP</option>
										<%
											} else if (schGubun1.equals("03")) {
										%>
										<option value="31"<%if (schGubun2.equals("31")) { out.println(" selected=\"selected\"");}%>>시크릿수프(SS)</option>
										<option value="32"<%if (schGubun2.equals("32")) { out.println(" selected=\"selected\"");}%>>밸런스쉐이크</option>
										<%
											}
										} else {
										%>
										<option value="">구분2</option>
										<%
										}
										%>
									</select>
								</td>
								<th scope="row">
									<span>세트검색</span>
								</th>
								<td>
									<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
										<option value="GROUP_NAME"<%if(field.equals("GROUP_NAME")){out.print(" selected=\"selected\"");}%>>세트그룹명</option>
										<option value="GROUP_CODE"<%if(field.equals("GROUP_CODE")){out.print(" selected=\"selected\"");}%>>세트그룹코드</option>
									</select>
									<input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()"/>
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
							<col width="6%" />
							<col width="10%" />
							<col width="22%" />
							<col width="*" />
							<col width="14%" />
							<col width="14%" />
							<col width="6%" />
						</colgroup>
						<tbody>
							<tr>
								<!--th scope="col"><span><input type="checkbox" id="selectall" /></span></td-->
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>구분1</span></th>
								<th scope="col"><span>구분2</span></th>
								<th scope="col"><span>세트그룹명</span></th>
								<th scope="col"><span>세트그룹코드</span></th>
								<th scope="col"><span>등록일</span></th>
								<th scope="col"><span>수정</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									groupId		= rs.getInt("ID");
									gubun1		= rs.getString("GUBUN1");
									gubun1Txt	= ut.getGubun1Name(gubun1);
									gubun2		= rs.getString("GUBUN2");
									gubun2Txt	= ut.getGubun2Name(gubun2);
									groupName	= rs.getString("GROUP_NAME");
									groupCode	= rs.getString("GROUP_CODE");
									instDate	= rs.getString("WDATE");
									if (gubun1.equals("01")) {
										editUrl		= "goods_group_meal_edit.jsp";
									} else if (gubun1.equals("02")) {
										editUrl		= "goods_group_pg_edit.jsp";
									} else if (gubun1.equals("03")) {
										if (gubun2.equals("31")) {
											editUrl		= "goods_group_ss_edit.jsp";
										} else {
											editUrl		= "goods_group_type_edit.jsp";
										}
									}
							%>
							<tr>
								<!--td><input type="checkbox" class="selectable" value="<%=groupId%>" /></td-->
								<td><%=curNum%></td>
								<td><%=gubun1Txt%></td>
								<td><%=gubun2Txt%></td>
								<td><%=groupName%></td>
								<td><%=groupCode%></td>
								<td><%=instDate%></td>
								<td><a href="<%=editUrl +"?id="+ groupId + param%>" class="function_btn"><span>수정</span></a></td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="9">등록된 세트가 없습니다.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<div class="btn_style1">
					<!--p class="left_btn">
						<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>삭제</span></a>						
					</p-->
					<p class="right_btn">
						<select name="sel_group" id="sel_group">
							<option value="meal"<%if (schGubun1.equals("01")) { out.println(" selected=\"selected\"");}%>>식사다이어트</option>
							<option value="pg"<%if (schGubun1.equals("02")) { out.println(" selected=\"selected\"");}%>>프로그램다이어트</option>
							<option value="ss"<%if (schGubun1.equals("03")) { out.println(" selected=\"selected\"");}%>>시크릿수프</option>
							<option value="type">밸런스쉐이크</option>
						</select>
						<a href="javascript:;" onclick="selWrite();" class="function_btn"><span>등록</span></a>
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
});

function getGubun2() {
	var newOptions		= "";
	var selectedOption	= "";
	var gubun1Val		= $("#sch_gubun1").val();

	if (gubun1Val == "01") {
		newOptions	= {
			''	 : '선택',
			'11' : '1식',
			'12' : '2식',
			'13' : '3식',
			'14' : '2식+간식',
			'15' : '3식+간식'
		}
	} else if (gubun1Val == "02") {
		newOptions	= {
			''	 : '선택',
			'21' : '감량',
			'22' : '유지',
			'23' : 'FULL-STEP'
		}
	} else if (gubun1Val == "03") {
		newOptions	= {
			''	 : '선택',
			'31' : '시크릿수프(SS)',
			'32' : '밸런스쉐이크'
		}
	} else {
		newOptions	= {
			''	 : '구분2'
		}
	}

	makeOption(newOptions, $("#sch_gubun2"), selectedOption);
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
		alert("삭제할 세트그룹을 선택하세요!");
	} else {
		if (confirm("정말로 삭제하시겠습니까?")) {
			var del_arr = new Array();
			var i = 0;
			$(".selectable:checked").each(function() {
				del_arr[i] = $(this).val();
				i++;
			});
			var del_ids_val = del_arr.join();
			$.post("goods_group_ajax.jsp", {
				mode: 'del', 
				del_ids: del_ids_val
			},
			function(data) {
				$(data).find('result').each(function() {
					if ($(this).text() == 'success') {
						alert('삭제되었습니다.');
						location.href = 'goods_group_list.jsp?sch_gubun1=<%=schGubun1%>&sch_gubun2=<%=schGubun2%>';
					} else {
						$(data).find('error').each(function() {
							alert($(this).text());
						});
					}
				});
			}, "xml");
		}
	}
}

function selWrite() {
	var page	= $("#sel_group").val();
	location.href = "goods_group_"+ page +"_write.jsp?sch_gubun1=<%=schGubun1%>";
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>