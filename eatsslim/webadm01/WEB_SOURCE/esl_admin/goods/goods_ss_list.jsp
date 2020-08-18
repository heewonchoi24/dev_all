<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table				= "ESL_GOODS_SET";
String query1				= "";
String query2				= "";
String query3				= "";
ResultSet rs1				= null; 
PreparedStatement pstmt1	= null;
int schCate					= 0;
String field				= ut.inject(request.getParameter("field"));
String keyword				= ut.inject(request.getParameter("keyword"));
String where				= "";
String param				= "";
int cateId;
String cateName				= "";
int setId;
String setCode				= "";
String setName				= "";
NumberFormat nf = NumberFormat.getNumberInstance();
int setPrice;
String thumbImg				= "";
String instDate				= "";
String imgUrl				= "";

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

if (request.getParameter("sch_cate") != null && request.getParameter("sch_cate").length()>0) {
	schCate		= Integer.parseInt(request.getParameter("sch_cate"));
	param		+= "&amp;sch_cate="+ schCate;
	where		+= " AND CATEGORY_ID = "+ schCate;
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

query2		= "SELECT a.ID, a.CATEGORY_ID, a.SET_CODE, a.SET_NAME, a.SET_PRICE, a.THUMB_IMG, DATE_FORMAT(a.INST_DATE, '%Y.%m.%d') WDATE, b.CATE_NAME";
query2		+= " FROM "+ table +" a, ESL_GOODS_CATEGORY b"+ where;
query2		+= " AND a.CATEGORY_ID = b.ID";
query2		+= " ORDER BY a.ID DESC";
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
		$('#lnb').menuModel2({hightLight:{level_1:3,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상품관리 &gt; <strong>세트관리</strong></p>
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
									<span>카테고리 구분</span>
								</th>
								<td>
									<select name="sch_cate">
										<option value="">전체</option>
										<%
										query3		= "SELECT ID, CATE_NAME FROM ESL_GOODS_CATEGORY WHERE OPEN_YN = 'Y'";
										pstmt1		= conn.prepareStatement(query3);
										rs1			= pstmt1.executeQuery();

										while (rs1.next()) {
											cateId		= rs1.getInt("ID");
											cateName	= rs1.getString("CATE_NAME");
										%>
										<option value="<%=cateId%>"<%if(schCate == cateId){out.print(" selected=\"selected\"");}%>><%=cateName%></option>
										<%
										}

										rs1.close();
										pstmt1.close();
										%>
									</select>
								</td>
								<th scope="row">
									<span>세트검색</span>
								</th>
								<td>
									<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
										<option value="SET_NAME"<%if(field.equals("SET_NAME")){out.print(" selected=\"selected\"");}%>>세트명</option>
										<option value="SET_CODE"<%if(field.equals("SET_CODE")){out.print(" selected=\"selected\"");}%>>세트코드</option>
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
							<col width="4%" />
							<col width="6%" />
							<col width="10%" />
							<col width="22%" />
							<col width="*" />
							<col width="14%" />
							<col width="14%" />
							<col width="8%" />
							<col width="6%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span><input type="checkbox" id="selectall" /></span></td>
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>이미지</span></th>
								<th scope="col"><span>카테고리구분</span></th>
								<th scope="col"><span>세트명</span></th>
								<th scope="col"><span>세트코드</span></th>
								<th scope="col"><span>가격(소비자가)</span></th>
								<th scope="col"><span>등록일</span></th>
								<th scope="col"><span>수정</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									setId		= rs.getInt("ID");
									cateId		= rs.getInt("CATEGORY_ID");
									setCode		= rs.getString("SET_CODE");
									setName		= rs.getString("SET_NAME");
									setPrice	= rs.getInt("SET_PRICE");
									thumbImg	= rs.getString("THUMB_IMG");
									if (!thumbImg.equals("")) {
										imgUrl		= webUploadDir +"goods/"+ thumbImg;
									} else {
										imgUrl		= "";
									}
									instDate	= rs.getString("WDATE");
									cateName	= rs.getString("CATE_NAME");
							%>
							<tr>
								<td><input type="checkbox" class="selectable" value="<%=setId%>" /></td>
								<td><%=curNum%></td>
								<td><img src="<%=webUploadDir%>goods/<%=thumbImg%>" width="115" height="65" /></td>
								<td><%=cateName%></td>
								<td><%=setName%></td>
								<td><%=setCode%></td>
								<td><%=nf.format(setPrice)%></td>
								<td><%=instDate%></td>
								<td>
									<a href="goods_set_edit.jsp?id=<%=setId + param%>" class="function_btn"><span>수정</span></a>
								</td>
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
					<p class="left_btn">
						<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>삭제</span></a>						
					</p>
					<p class="right_btn">
						<a href="goods_set_write.jsp" class="function_btn"><span>등록</span></a>
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
		alert("삭제할 세트를 선택하세요!");
	} else {
		if (confirm("정말로 삭제하시겠습니까?")) {
			var del_arr = new Array();
			var i = 0;
			$(".selectable:checked").each(function() {
				del_arr[i] = $(this).val();
				i++;
			});
			var del_ids_val = del_arr.join();
			$.post("goods_set_ajax.jsp", {
				mode: 'del', 
				del_ids: del_ids_val
			},
			function(data) {
				$(data).find('result').each(function() {
					if ($(this).text() == 'success') {
						alert('삭제되었습니다.');
						location.href = 'goods_set_list.jsp';
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
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>