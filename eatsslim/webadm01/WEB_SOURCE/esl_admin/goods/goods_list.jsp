<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../lib/dbconn_phi.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "PHIBABY.V_PRODUCT";
String query1		= "";
String query2		= "";
String query3		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
String prdtId		= "";
String prdtName		= "";
int stdPrice		= 0;
String setYn		= "";
String useYn		= "";
int goodsId			= 0;
String goodsType	= "";
int goodsPrice		= 0;
String gubun1		= "";
String gubun2		= "";
String gubun3		= "";

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
//where			= " WHERE SETYN = 'Y'";
//where			= " WHERE 1=1";
//where			= " WHERE USEYN = 'Y'";
where			= " where classlcd = 'H41' ";

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

query1		= "SELECT COUNT(PRDTID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt_phi	= conn_phi.prepareStatement(query1);
rs_phi		= pstmt_phi.executeQuery();
if (rs_phi.next()) {
	intTotalCnt = rs_phi.getInt(1); //총 레코드 수		
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

query2		= "SELECT * FROM (SELECT a.*, ROWNUM rnum FROM (SELECT PRDTID, PRDTNAME, STDPRICE, SETYN, USEYN FROM "+ table + where +" ORDER BY PRDTID DESC) a) WHERE rnum > ? * (? - 1) AND ROWNUM <= ?"; //out.print(query2); if(true)return;
pstmt_phi	= conn_phi.prepareStatement(query2);
pstmt_phi.setInt(1, pgsize);
pstmt_phi.setInt(2, iPage);
pstmt_phi.setInt(3, pgsize);
rs_phi		= pstmt_phi.executeQuery();
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상품관리 &gt; <strong>상품구성관리</strong></p>
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
											<option value="PRDTNAME"<%if(field.equals("PRDTNAME")){out.print(" selected=\"selected\"");}%>>상품명</option>
											<option value="PRDTID"<%if(field.equals("PRDTID")){out.print(" selected=\"selected\"");}%>>상품코드</option>
										</select>
									</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()"/></td>
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
								<option value="40"<%if(pgsize==40)out.print(" selected");%>>40개씩보기</option>
								<option value="100"<%if(pgsize==100)out.print(" selected");%>>100개씩보기</option>
							</select>
						</p>
					</div>
				</form>
				<form name="frm_list" id="frm_list" method="post">
					<input type="hidden" name="mode" value="updAll" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="3%" />
							<col width="4%" />
							<col width="*" />
							<col width="6%" />
							<col width="6%" />
							<col width="22%" />
							<col width="14%" />
							<col width="8%" />
							<col width="8%" />
							<col width="6%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>상품코드</span></th>
								<th scope="col"><span>상품명</span></th>
								<th scope="col"><span>소비자가|파이</span></th>
								<th scope="col"><span>소비자가|몰</span></th>
								<th scope="col"><span>상품타입</span></th>
								<th scope="col"><span>구분1</span></th>
								<th scope="col"><span>구분2</span></th>
								<th scope="col"><span>구분3</span></th>
								<th scope="col"><span>처리</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs_phi.next()) {
									prdtId		= rs_phi.getString("PRDTID");
									prdtName	= rs_phi.getString("PRDTNAME");
									stdPrice	= rs_phi.getInt("STDPRICE");
									setYn		= rs_phi.getString("SETYN");
									useYn		= rs_phi.getString("USEYN");

									query3		= "SELECT ID, GOODS_TYPE, GOODS_PRICE, GUBUN1, GUBUN2, GUBUN3 FROM ESL_GOODS_SETTING WHERE GOODS_CODE = ?";
									pstmt		= conn.prepareStatement(query3);
									pstmt.setString(1, prdtId);
									rs			= pstmt.executeQuery();

									if (rs.next()) {
										goodsId		= rs.getInt("ID");
										goodsType	= rs.getString("GOODS_TYPE");
										goodsPrice	= rs.getInt("GOODS_PRICE");
										gubun1		= rs.getString("GUBUN1");
										gubun2		= rs.getString("GUBUN2");
										gubun3		= rs.getString("GUBUN3");
									} else {
										goodsId		= 0;
										goodsPrice	= 0;
										goodsType	= "";
										gubun1		= "";
										gubun2		= "";
										gubun3		= "";
									}
							%>
							<input type="hidden" name="goodsId" id="goodsId_<%=prdtId%>" value="<%=goodsId%>" />
							<input type="hidden" name="gubun1_val_<%=prdtId%>" name="gubun1_val_<%=prdtId%>" value="<%=gubun1%>" />
							<input type="hidden" name="gubun2_val_<%=prdtId%>" name="gubun2_val_<%=prdtId%>" value="<%=gubun2%>" />
							<input type="hidden" name="gubun3_val_<%=prdtId%>" name="gubun3_val_<%=prdtId%>" value="<%=gubun3%>" />
							<tr>
								<td><%=curNum%></td>
								<td><input type="text" name="goods_code" id="goods_code_<%=prdtId%>" value="<%=prdtId%>" readonly="readonly" style="width:50px;" /></td>
								<td><input type="text" name="goods_name_<%=prdtId%>" id="goods_name_<%=prdtId%>" value="<%=prdtName%>" readonly="readonly" style="width:170px;" /></td>
								<td><input type="text" name="goods_price_<%=prdtId%>" id="goods_price_<%=prdtId%>" value="<%=stdPrice%>" style="width:60px;" dir="rtl" maxlength="7" /></td>
								<td><%=goodsPrice%></td>
								<td>
									<label><input type="radio" name="goods_type_<%=prdtId%>" value="C" onclick="getGubun1('<%=prdtId%>');"<%if (goodsType.equals("C")) { out.println(" checked=\"checked\"");}%> /> 카테고리</label>
									<label><input type="radio" name="goods_type_<%=prdtId%>" value="S" onclick="getGubun1('<%=prdtId%>');"<%if (goodsType.equals("S")) { out.println(" checked=\"checked\"");}%> /> 메뉴</label>
									<label><input type="radio" name="goods_type_<%=prdtId%>" value="G" onclick="getGubun1('<%=prdtId%>');"<%if (goodsType.equals("G")) { out.println(" checked=\"checked\"");}%> /> 세트그룹</label>
								</td>
								<td>
									<select name="gubun1_<%=prdtId%>" id="gubun1_<%=prdtId%>" onchange="getGubun2('<%=prdtId%>')">
										<option value="">선택</option>
										<%if (goodsType.equals("G") && gubun1.length() > 0) {%>
										<option value="01"<%if (gubun1.equals("01")) { out.println(" selected=\"selected\"");}%>>식사다이어트</option>
										<option value="02"<%if (gubun1.equals("02")) { out.println(" selected=\"selected\"");}%>>프로그램다이어트</option>
										<option value="03"<%if (gubun1.equals("03")) { out.println(" selected=\"selected\"");}%>>타입별다이어트</option>
										<option value="04"<%if (gubun1.equals("04")) { out.println(" selected=\"selected\"");}%>>증정</option>
										<option value="50"<%if (gubun1.equals("50")) { out.println(" selected=\"selected\"");}%>>풀비타건기식</option>
										<option value="09"<%if (gubun1.equals("09")) { out.println(" selected=\"selected\"");}%>>기타</option>
										<%}%>
									</select>
								</td>
								<td>
									<select name="gubun2_<%=prdtId%>" id="gubun2_<%=prdtId%>">
										<option value="">선택</option>
										<%
										if (goodsType.equals("G") && gubun2.length() > 0) {
											if (gubun1.equals("01")) {
										%>
										<option value="11"<%if (gubun2.equals("11")) { out.println(" selected=\"selected\"");}%>>1식</option>
										<option value="12"<%if (gubun2.equals("12")) { out.println(" selected=\"selected\"");}%>>2식</option>
										<option value="13"<%if (gubun2.equals("13")) { out.println(" selected=\"selected\"");}%>>3식</option>
										<option value="14"<%if (gubun2.equals("14")) { out.println(" selected=\"selected\"");}%>>2식+간식</option>
										<option value="15"<%if (gubun2.equals("15")) { out.println(" selected=\"selected\"");}%>>3식+간식</option>
										<%
											} else if (gubun1.equals("02")) {
										%>
										<option value="21"<%if (gubun2.equals("21")) { out.println(" selected=\"selected\"");}%>>감량</option>
										<option value="22"<%if (gubun2.equals("22")) { out.println(" selected=\"selected\"");}%>>유지</option>
										<option value="23"<%if (gubun2.equals("23")) { out.println(" selected=\"selected\"");}%>>FULL-STEP</option>
										<%
											} else if (gubun1.equals("03")) {
										%>
										<option value="31"<%if (gubun2.equals("31")) { out.println(" selected=\"selected\"");}%>>시크릿수프</option>
										<option value="32"<%if (gubun2.equals("32")) { out.println(" selected=\"selected\"");}%>>밸런스쉐이크</option>
										<%
											} else if (gubun1.equals("50")) {
										%>
										<option value="01"<%if (gubun2.equals("01")) { out.println(" selected=\"selected\"");}%>>유산균</option>
										<option value="02"<%if (gubun2.equals("02")) { out.println(" selected=\"selected\"");}%>>비타민</option>
										<option value="03"<%if (gubun2.equals("03")) { out.println(" selected=\"selected\"");}%>>식사대용</option>
										<option value="04"<%if (gubun2.equals("04")) { out.println(" selected=\"selected\"");}%>>기타</option>
										<%
											}
										}
										%>
									</select>
								</td>
								<td>
									<select name="gubun3_<%=prdtId%>" id="gubun3_<%=prdtId%>">
										<option value="">선택</option>
										<%
										if (goodsType.equals("G") && gubun1.equals("02") && gubun3.length() > 0) {
											for (i = 1; i < 5; i++) {
										%>
										<option value="<%=i%>"<%if (gubun3.equals(i)) { out.println(" selected=\"selected\"");}%>><%=i%>주차</option>
										<%
											}
										}
										%>
									</select>
								</td>
								<td>
									<%if (goodsId > 0) {%>
									<a href="javascript:;" onclick="chkEdit('<%=prdtId%>');" class="function_btn"><span>수정</span></a>
									<%} else {%>
									<a href="javascript:;" onclick="chkEdit('<%=prdtId%>');" class="function_btn"><span>등록</span></a>
									<%}%>
								</td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="9">파이에 등록된 상품이 없습니다.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<%if (intTotalCnt > 0) {%>
				<div class="btn_style1">
					<p class="right_btn">
						<a href="javascript:;" onclick="chkWrite();" class="function_btn"><span>일괄등록</span></a>
					</p>
				</div>
				<%@ include file="../include/inc-paging.jsp"%>
				<%}%>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
<script type="text/javascript">
var newOptions		= "";
var selectedOption	= "";

function clearAll(obj) {
	newOptions	= {'' : '선택'};
	selectedOption	= '';

	for (var i=1; i<4; i++) {
		makeOption(newOptions, $("#gubun"+ i +"_"+ obj), selectedOption);
	}
}

function getGubun1(obj) {
	var goodsType	= $("input[name=goods_type_"+ obj +"]:checked").val();
	
	if (goodsType == "G") {
		newOptions	= {
			''	 : '선택',
			'01' : '식사다이어트',
			'02' : '프로그램다이어트',
			'03' : '타입별다이어트',
			'04' : '증정',
			'50' : '풀비타건기식',
			'09' : '기타'
		}

		if ($("#goodsId_"+ obj).val() == 0) {
			selectedOption	= '';
		} else {
			selectedOption	= $("#gubun1_val"+ obj).val();
		}

		makeOption(newOptions, $("#gubun1_"+ obj), selectedOption);
	} else {
		clearAll(obj)
	}
}

function getGubun2(obj) {
	var gubun1Val		= $("#gubun1_"+ obj).val();
	var newOptions1		= {'' : '선택'};
	var selectedOption1	= '';

	if (gubun1Val == "01") {
		newOptions	= {
			''	 : '선택',
			'11' : '1식',
			'12' : '2식',
			'13' : '3식',
			'14' : '2식+간식',
			'15' : '3식+간식'
		}

		if ($("#goodsId_"+ obj).val() == 0) {
			selectedOption	= '';
		} else {
			selectedOption	= $("#gubun2_val"+ obj).val();
		}
	} else if (gubun1Val == "03") {
		newOptions	= {
			''	 : '선택',
			'31' : '시크릿수프(SS)',
			'32' : '밸런스쉐이크'
		}

		if ($("#goodsId_"+ obj).val() == 0) {
			selectedOption	= '';
		} else {
			selectedOption	= $("#gubun2_val"+ obj).val();
		}
	} else if (gubun1Val == "50") {
		newOptions	= {
			''	 : '선택',
			'01' : '유산균',
			'02' : '비타민',
			'03' : '식사대용',
			'04' : '기타'
		}

		if ($("#goodsId_"+ obj).val() == 0) {
			selectedOption	= '';
		} else {
			selectedOption	= $("#gubun2_val"+ obj).val();
		}
	} else {
		newOptions	= {'' : '선택'};
		selectedOption	= '';
	}

	makeOption(newOptions, $("#gubun2_"+ obj), selectedOption);
	makeOption(newOptions1, $("#gubun3_"+ obj), selectedOption1);
}

function chkWrite() {
	$.post("goods_ajax.jsp", $("#frm_list").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("정상적으로 처리되었습니다.");
				document.location.reload();
			} else {
				var error_txt;
				$(data).find("error").each(function() {
					error_txt = $(this).text().split(":");
					alert(error_txt[1]);
					if (error_txt[0] != "no_txt")
						$("#" + error_txt[0]).focus();
				});
			}
		});
	}, "xml");
	return false;
}

function chkEdit(obj) {
	$.post("goods_ajax.jsp", {
		mode: "ins",
		goods_code: $("#goods_code_"+ obj).val(),
		goods_name: $("#goods_name_"+ obj).val(),
		goods_price: $("#goods_price_"+ obj).val(),
		goods_type: $("input[name=goods_type_"+ obj +"]:checked").val(),
		gubun1: $("#gubun1_"+ obj).val(),
		gubun2: $("#gubun2_"+ obj).val(),
		gubun3: $("#gubun3_"+ obj).val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("정상적으로 처리되었습니다.");
				document.location.reload();
			} else {
				var error_txt;
				$(data).find("error").each(function() {
					error_txt = $(this).text().split(":");
					alert(error_txt[1]);
					if (error_txt[0] != "no_txt")
						$("#" + error_txt[0]).focus();
				});
			}
		});
	}, "xml");
	return false;
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="../lib/dbclose_phi.jsp" %>