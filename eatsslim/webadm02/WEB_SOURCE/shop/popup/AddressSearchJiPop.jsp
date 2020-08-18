<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ page import="java.sql.*"%>
<%@ include file="/lib/dbconn_bm.jsp" %>

<%
request.setCharacterEncoding("euc-kr");

String mode			= ut.inject(request.getParameter("ztype"));
if (!ut.isNaN(mode)) {
	mode = "0001";
}
String query		= "";
String sido			= "";
String sidoOption	= "";


query		= "	SELECT SIDO_NM FROM CM_ZIP_SIDOGUNGU WHERE SIDO_NM != '제주특별자치도' GROUP BY SIDO_NM ORDER BY SIDO_NM ";
try {
	pstmt_bm	= conn_bm.prepareStatement(query);
	rs_bm	= stmt_bm.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs_bm.next()) {
	sido		= rs_bm.getString("SIDO_NM");
	//selected	= (sido.equals(schSido))? " selected=\"selected\"" : "";

	sidoOption	+= "<option value=\""+ sido +"\""+ sido +">"+ sido +"</option>\n";
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta name="robots" content="noindex,nofollow,noarchive">

	<title>바른 다이어트 잇슬림</title>

	<link rel="stylesheet" type="text/css" media="all" href="/common/css/layout.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/skeleton.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/color-theme.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.selectBox.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.lightbox.css" />
    <link rel="stylesheet" type="text/css" media="print" href="/common/css/print.css" />

	<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
	<style>
	.keylock {
		height: 100%;
		filter: alpha(opacity=50);
		opacity: 0.5;
		-moz-opacity: 0.5;
	}
	.keylock input:disabled {

	}
	.typehead {
		background: #58B7DD;
		border: 1px solid #4490AF;
		color: #FFFFFF;
		padding: 10px 30px;
		text-align: center;
	}
	</style>
		<style>
	#loading {
		height: 100%;
		left: 0px;
		position: fixed;
		_position:absolute;
		top: 0px;
		width: 100%;
		filter:alpha(opacity=50);
		-moz-opacity:0.5;
		opacity : 0.5;
	}

	.loading {
		background-color: white;
		z-index: 199;
	}

	#loading_img{
		width:150px;
		position:absolute;
		top:50%;
		left:50%;
		height:150px;
		margin-top:-75px;
		margin-left:-75px;
		z-index: 200;
	}
	</style>

</head>
<body>
<input type="hidden" name="t" id="t" value="li" />
<input type="hidden" name="dtype" id="dtype" value="<%=mode%>" />
<input type="hidden" name="gT" id="gT" value="" />
<div class="pop-wrap">
	<div class="headpop">
	<% if (mode.equals("0001") || mode.equals("0002")) { %>
	<h2>배달지 주소검색</h2>
	<% } else { %>
	<h2>배달가능지역</h2>
	<% } %>
<!-- 		<a class="close" href="javascript:;" onclick="self.close();">Close</a> -->
		<p>* 배달구역 확대를 위한 노선 확장 초기단계로 일부 지역(지방,경기권 일부)은 일일배달이 어려울 수 있습니다.<br>
	</div>
	<div class="contentpop newaddress">
		<div class="full_column">
			<div class="row">
				<ul class="smalltabNavi">
					<li><a href="javascript:void(0);" class="defaulttab" rel="tabs1">지번주소 검색</a></li>
					<li><a href="javascript:void(0);" rel="tabs2">도로명주소 검색</a></li>
				</ul>
				<div class="clearfix"></div>
			</div>

			<div class="tab-content">
				<div class="seperater" style="margin-top: 5px; margin-bottom: 5px; background-color: transparent; height: 1px;"></div>
					<h4 id="jiTitle" style="display:none" class="titleblue">지번명 검색 및 입력</h4>
					<h4 id="doTitle" style="display:none" class="titleblue">도로명 검색 및 입력</h4>
						<form name="searchFrm" id="searchFrm">
						<input type="hidden" name="currentPage" id="currentPage" value="" />
						<input type="hidden" name="schPageSize" id="schPageSize" value="10" />
							<div id= "div_ji">
								<p>찾으시는 시/도 선택 후 동/지번 주소 + 건물명을 입력하시거나 둘 중 하나만 입력하셔도 검색 가능합니다.<br>
								&nbsp;<font color="blue">예) 서울특별시(시/도), 수서동 724 (동명+지번), 로즈데일(건물명)</font></p>
								<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
								<colgroup>
									<col width="10%" />
									<col width="35%" />
									<col width="10%" />
									<col width="30%" />
									<col width="15%" />
								</colgroup>
								<tbody>
									<tr>
										<th><span class="highlight">*&nbsp;</span>시/도</th>
										<td colspan=3>
											<select name="schSidoNm" id="schSidoNm" style="width: 130px;">
												<option value="">:: 선택 ::</option>
												<%=sidoOption%>
											</select>
										</td>
										<!-- <th><span class="highlight">*&nbsp;</span>시/군/구</th>
										<td>
											<select name="schSigunguNm" id="schSigunguNm" style="width: 150px;" onchange="$('#schDoroNm').val('');$('#schDoroNm').focus();">
												<option value="">:: 선택 ::</option>
											</select>
										</td>  -->
										<th rowspan='2'>
											<div class="button large light iconBtn">
												<a href="javascript:;" onclick="pgSearch(1);">검색</a>
											</div>
										</th>
									</tr>
									<tr>
										<th>동/읍/면 + 지번</th>
										<td><input type="text" class="inputfield" name="schDong" onKeyDown="fnSearch(event);" id="schDong" style="width: 50px;ime-mode:active;" maxlength="20" />동/읍/면
										&nbsp;<input numberonly="true" type="text" class="inputfield" name="schGbBonNo" onKeyDown="fnSearch(event);" id="schGbBonNo" style="width: 30px;" maxlength="5" />
										&nbsp;-&nbsp;<input numberonly="true" type="text" class="inputfield" name="schGbBuNo" onKeyDown="fnSearch(event);" id="schGbBuNo" style="width: 30px;" maxlength="5" />번지
										</td>
										<th>건물명</th>
										<td><input name="schGmNmJi" id="schGmNmJi" type="text" onKeyDown="fnSearch(event);" class="ftfd" style="width: 120px;ime-mode:active;" /></td>
									</tr>
								</tbody>
								</table>
							</div>
							<div id= "div_do">
							<p>
								찾으시는 시/도 선택 후 도로명 주소 + 건물명을 입력하시거나 둘 중 하나만 입력하셔도 검색 가능합니다.<br>
								&nbsp;<font color="blue">예) 서울특별시(시/도), 광평로 280(도로명주소), 로즈데일(건물명)</font>
							</p>
								<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
								<colgroup>
									<col width="10%" />
									<col width="35%" />
									<col width="10%" />
									<col width="30%" />
									<col width="15%" />

								</colgroup>
									<tr>
										<th><span class="highlight">*&nbsp;</span>시/도</th>
										<td colspan=3>
											<select name="dschSidoNm" id="dschSidoNm" style="width: 130px;">
												<option value="">:: 선택 ::</option>
												<%=sidoOption%>
											</select>
										</td>
										<!-- <th><span class="highlight">*&nbsp;</span>시/군/구</th>
										<td>
											<select name="dschSigunguNm" id="dschSigunguNm" style="width: 150px;" onchange="$('#schDoroNm').val('');$('#schDoroNm').focus();">
												<option value="">:: 선택 ::</option>
											</select>
										</td> -->
										<th rowspan='2'>
											<div style="width:75px" class="button large light iconBtn" >
												<a href="javascript:;" onclick="pgSearch(1);">검색</a>
											</div>
										</th>
									</tr>
									<tr>
										<th>도로명</th>
										<td><input name="schDoroNm" id="schDoroNm" type="text" onKeyDown="fnSearch(event);" class="ftfd" style="width: 100px;ime-mode:active;" />
										&nbsp;
										<input numberonly="true" type="text" class="inputfield" onKeyDown="fnSearch(event);" name="schGmBonNo" id="schGmBonNo" style="width: 40px;" maxlength="5" />
										&nbsp;-&nbsp;
										<input numberonly="true" type="text" class="inputfield" onKeyDown="fnSearch(event);" name="schGmBuNo" id="schGmBuNo" style="width: 30px;" maxlength="5" />
										</td>
										<th>건물명</th>
										<td><input name="schGmNm" id="schGmNm" type="text" onKeyDown="fnSearch(event);" class="ftfd" style="width: 120px;ime-mode:active;" /></td>
									</tr>
								</table>
								<div class="clearfix"></div>
								<div class="center">

								</div>
						</div>

						<h5>* 해당하는 주소지를 선택해 주세요.</h5>
						<div class="scroll" style="height: 250px;">
							<table class="addressList" width="100%" border="0" cellspacing="0" cellpadding="0">
								<colgroup>
									<col width="10%" />
									<col width="auto" />
									<col width="7%" />
									<col width="7%" />
									<col width="15%" />
									<col width="15%" />
								</colgroup>
								<tr>
									<th class="browntxt">우편번호</th>
									<th class="browntxt">현재주소</th>
									<th class="browntxt last">일배상품</th>
									<th class="browntxt last">택배상품</th>
									<th class="browntxt last">배송점</th>
									<th class="browntxt last">연락처</th>
								</tr>
								<tbody id="resultList">
								</tbody>
							</table>
						</div>
						<div class="seperater" style="margin-top: 5px; margin-bottom: 5px; background-color: transparent; height: 1px;"></div>

						<input type="hidden" name="zip" 			id="zip" />
						<input type="hidden" name="addrJi"			id="addrJi" />
						<input type="hidden" name="delvPtTxt"		id="delvPtTxt" />
						<input type="hidden" name="delvType" 		id="delvType" />
						<input type="hidden" name="gmNm" 			id="gmNm" />
						<input type="hidden" name="bonCheck" 		id="bonCheck" />
						<input type="hidden" name="jisaCd" 			id="jisaCd" />

						<div class="center">
						<!-- paging area STD -->
						<div id ="div_paging">
						</div>
						<!-- paging area END -->

						</div>
					</form>

				<!-- End two_column -->
			</div>
			<!-- End tab-content #tabs1 -->
			<div class="seperater" style="margin-top: 10px; margin-bottom: 10px; background-color: transparent; height: 1px;"></div>
		</div>
	</div>
</div>
<!-- custom javascript area -->
<script type="text/javascript">
var gubun ="";
$(document).ready(function() {
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	gubun = ("<%=request.getParameter("t") %>");

	$('.smalltabNavi a').click(function(){
		switch_tabs($(this));
	});
	switch_tabs($('.defaulttab'));
	/*
	if(gubun =="do" || gubun =="cdo") {
		$("#th_do").show();
		$("#doTitle").show();
		$("#div_do").show();
		$("#th_ji").hide();
		jiTitle.style.display="none";
		$("#div_ji").hide();
		$("#searchFrm").submit(fnSearchDo);
		$("#schDoroNm").focus();
	} else if(gubun =="" || gubun =="null" || gubun =="li" || gubun =="cli" || gubun == "" || gubun =="c"){
		$("#th_ji").show();
		jiTitle.style.display="block";
		$("#div_ji").show();
		$("#th_do").hide();
		$("#doTitle").hide();
		$("#div_do").hide();
		$("#searchFrm").submit(fnSearchJi);
		$("#schDong").focus();
	}*/
});

function fnSearch(e){
	if(e.keyCode == 13){
    	pgSearch("1");
    }
}

function switch_tabs(obj) {
	var id = obj.attr("rel");
	$("#currentPage").val("1");
	$('.smalltabNavi a').removeClass("current");
	//if(id =="li_li" || id =="li_cli"){
	$("#resultList").html("");
	//$("#zip1").val("");
	//$("#addr1").val("");
	//$("#addr2").val("");
	//$("#doZip1").val("");
	//$("#doAddr1").val("");
	//$("#doAddr2").val("");
	$("#schSidoNm").val("");
	$("#schSigunguNm").val("");
	$("#dschSidoNm").val("");
	$("#dschSigunguNm").val("");
	$("#schDong").val("");
	$("#schGbBonNo").val("");
	$("#schGbBuNo").val("");
	$("#schDoroNm").val("");
	$("#schGmNm").val("");
	$("#schGmBuNo").val("");
	$("#schGmBonNo").val("");
	$("#schGmNmJi").val("");

	if(id=="tabs1"){
		$("#t").val("li");
		$("#th_ji").show();
		jiTitle.style.display="block";
		$("#div_ji").show();
		$("#th_do").hide();
		$("#doTitle").hide();
		$("#div_do").hide();
		//$("#searchFrm").submit(fnSearchJi);
		$("#schDong").focus();
	} else {
	//else if(id =="li_do" || id =="li_cdo"){
		$("#t").val("do");
		$("#schSidoNm").val("");
		$("#th_do").show();
		$("#doTitle").show();
		$("#div_do").show();
		$("#th_ji").hide();
		jiTitle.style.display="none";
		$("#div_ji").hide();
		//$("#searchFrm").submit(fnSearchDo);
		$("#schDoroNm").focus();
	}
	$('#'+id).show();
	obj.addClass("current");
}

function pgSearch(val){
	$("#currentPage").val(val);

	if($("#t").val() == "")
		$("#t").val("li");
	if($("#t").val() =="li"){
		fnSearchJi();
	} else {
		fnSearchDo();
	}
}
var delvPtTxt ='';
function fnSearchJi() {
	//$("#zip1").val("");
	//$("#addr1").val("");
	//$("#addr2").val("");

	if($("#currentPage").val() == "")
		$("#currentPage").val('1');

	if($("#schSidoNm").val() == ""){
		alert('시/도를 선택해주세요.');
		$("#schSidoNm").focus();
		return false;
	}

	if ($.trim($("#schDong").val()) || $.trim($("#schGmNmJi").val())) {
		$("#resultList").html("");
		$("#div_paging").html("");
		//var data = "schSidoNm=" + $("#schSidoNm").val();
		//data	+= "&schSigunguNm=" + $("#schSigunguNm").val();
		//data	+= "&schGbBonNo=" + $("#schGbBonNo").val();
		//data	+= "&schGbBuNo=" + $("#schGbBuNo").val();
		//data	+= "&schDong=" + $("#schDong").val();
		//data	+= "&currentPage=" + $("#currentPage").val();
		//data	+= "&schPageSize=" + $("#schPageSize").val();


		$.post("/shop/popup/searchJi_ajax_new.jsp", {
			mode: 'post',
			schSidoNm: $("#schSidoNm").val(),
			schDong: $("#schDong").val(),
			schGbBonNo: $("#schGbBonNo").val(),
			schGbBuNo: $("#schGbBuNo").val(),
			schGmNm: $("#schGmNmJi").val().replace(' ', ''),
			currentPage: $("#currentPage").val(),
			schPageSize: $("#schPageSize").val()
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					$("#resultList").html("");

					var text 		= "";
					var addr1		= "";
					var addr2		= "";
					var trNum		= 0;
					var zipCd 	 	= "";
					var zipCdWithDash = "";
					var idxCnt		= 0;
					var startIdx	= 0;
					var endIdx		= 0;
					//$(".tbmulti").html('<tr><th>우편번호</th><th>주소</th><th>일배</th><th>택배</th></tr>');
					var zipcodeArr;
					$(data).find("address").each(function() {
						zipcodeArr = $(this).text().split("|");
						if (zipcodeArr[0] == "nodata") {
							text = '<tr><td colspan="3">검색된 배송가능지역이 없습니다.</td></tr>';
						} else {
							if (trNum == 0) {
								startIdx 			= zipcodeArr[0];
							}
							addr1			= zipcodeArr[1];
							addr1           += (zipcodeArr[2] != null && zipcodeArr[2] != "null")? " " + zipcodeArr[2] : "";
							addr1           += (zipcodeArr[10] != null && zipcodeArr[10] != "null")? " " + zipcodeArr[10] : "";
							addr1			+= " "+ zipcodeArr[9];
						    addr1			+= (zipcodeArr[4] != 0)? " "+ zipcodeArr[3] +"-"+ zipcodeArr[4] : " "+ zipcodeArr[3];
						    addr1			+= (zipcodeArr[8] != null && zipcodeArr[8] != "null")? " " + zipcodeArr[8] : "";

							//addr2			= zipcodeArr[1];
							//addr2			+=  (zipcodeArr[2] != null)? " " + zipcodeArr[2] : "";
							//addr2			+=  (zipcodeArr[10] != null && zipcodeArr[10] != "null")? "&nbsp;" + zipcodeArr[10] : "";
							//addr2			+=  (zipcodeArr[11] != null && zipcodeArr[11] != "null")? "&nbsp;" + zipcodeArr[11] : "";
							//addr2			+=  (zipcodeArr[7] != null && zipcodeArr[7] != "null")? "&nbsp;" + zipcodeArr[7] : "";
							//addr2			+=  "&nbsp;" + zipcodeArr[8];

							text += '<tr id="zipTr'+trNum+'" style="cursor:pointer" onclick="fnSetAddrJi('+trNum+', \''+zipcodeArr[0]+'\', \''+addr1+'\', \'' + zipcodeArr[12] + '\', \'' + zipcodeArr[13] + '\', \'' + zipcodeArr[14] + '\', \'' + zipcodeArr[15] + '\')">';
							text += '	<td rowspan="2">'+zipcodeArr[0]+'</td>';
							text += '	<td><font color="blue">(지번)&nbsp;' + zipcodeArr[12] + '</font></td>';
							
							if ( zipcodeArr[13] == "O" ) {
								text += '	<td rowspan="2">가능</td>';
							} else {
								text += '	<td rowspan="2">불가능</td>';
							}
							if ( zipcodeArr[14] == "O" ) {
								text += '	<td rowspan="2">가능</td>';
							} else {
								text += '	<td rowspan="2">불가능</td>';
							}
							text += '	<td rowspan="2">' + zipcodeArr[16] + '</td>';
							text += '	<td rowspan="2">' + zipcodeArr[17] + '\r' + zipcodeArr[18] +'</td>';
							text += '</tr>';
							text += '<tr>';
							text += '	<td>(도로명)&nbsp;'+addr1+'</td>';
							text += '</tr>';

						//$(".resultList").append('<tr><td>'+ zipcodeArr[0] +'</td><td>'+ zipcodeArr[1] +'</td><td>'+ zipcodeArr[4] +'</td><td>'+ zipcodeArr[5] +'</td></tr>');
						}

						trNum++;
					});

					$("#resultList").html(text);

					var pagingArr;
					$(data).find("paging").each(function() {
						pagingArr = $(this).text().split("|");
						var divText = '<ul class="paging">';
						divText += '<li class="li_btn"><a href="javascript:;" onclick="pgSearch(1);"><img src="/images/popup/ico_first.gif" alt="처음" /></a>';
						var sIdx = pagingArr[1] - 1;

						if(sIdx == '1')	{
							divText += '<a href="javascript:;" onclick="pgSearch(1);"><img src="/images/popup/ico_prev.gif" alt="이전" /></a>';
						} else{
							divText += '<a href="javascript:;" onclick="pgSearch('+ sIdx +');"><img src="/images/popup/ico_prev.gif" alt="이전" /></a>';
						}

						for(var i = pagingArr[1] ; i<=pagingArr[2]; i++){
							if($("#currentPage").val() == i)
								divText += '<strong><a href="javascript:;" onclick="pgSearch(' + i +');">' + i + '</a></strong>&nbsp;';
							else
								divText += '<a href="javascript:;" onclick="pgSearch(' + i + ');">' + i +'</a>&nbsp;';
						}
						<!-- Next 10 -->
						var eIdx = parseInt(pagingArr[2]) + 1;
						if(pagingArr[0] == pagingArr[2]){
							divText += '<a href="javascript:;" onclick="pgSearch('+ pagingArr[0] +');"><img src="/images/popup/ico_next.gif" alt="다음" /></a>';
						} else{
							divText += '<a href="javascript:;" onclick="pgSearch('+ eIdx + ');"><img src="/images/popup/ico_next.gif" alt="다음" /></a>';
						}
						divText += '<a href="javascript:;" onclick="pgSearch(' +  pagingArr[0] +');"><img src="/images/popup/ico_last.gif" alt="마지막" /></a>';
						divText += '</li>';
						divText += '</ul>';
						$("#div_paging").html(divText);
					});



				} else {
					$(data).find("error").each(function() {
						$(data).find("error").each(function() {

							text += '<tr>';
							text += '	<td colspan="3">';
							text += '		<p>검색된 주소가 없습니다.<br/>도로명 주소가 검색되지 않는 경우는 <a href="http://www.juso.go.kr" target="_blank"><font color="blue">http://www.juso.go.kr</font></a> 에서<br/>';
							text += '	 정확한 주소를 확인하시기 바랍니다.</p>';
							//text += '		<p>';
							//text += '			검색이 안되시면 "여기"를 클릭하세요. -->> //<a class="button small gray">여기</a>';
							//text += '		</p>';
							text += '	</td>';
							text += '</tr>';

						});
					});
				}
			});
		}, "xml");

		return false;
	} else {
		alert('현재 주소의 "동(읍/면)"을 입력해 주세요.');
		$("#schDong").focus();
		return false;
	}
}

function fnSearchDo() {
	//$("#zip1").val("");
	//$("#addr1").val("");
	//$("#addr2").val("");

	if($("#currentPage").val() == "")
		$("#currentPage").val('1');

	if (!$.trim($("#dschSidoNm").val())) {
		alert("시/도를 선택해주세요.");
		$("#dschSidoNm").focus();
		return false;
	} /*else if (!$.trim($("#schSigunguNm").val()) && $("#dschSidoNm").val != "세종특별자치시") {
		alert("시/군/구를 선택하세요.");
		$("#schSigunguNm").focus();
		return false;
	} */else if (!$.trim($("#schDoroNm").val()) && !$.trim($("#schGmNm").val())) {
		if(!$.trim($("#schDoroNm").val())){
			alert("도로명을 입력하세요.");
			$("#schDoroNm").focus();
		} else {
			alert("건물명을 입력하세요.");
			$("#schGmNm").focus();
		}
		 return false;
	} else {
		$("#resultList").html("");
		$("#div_paging").html("");

		$.post("/shop/popup/searchDo_ajax_new.jsp", {
			mode: 'post',
			schSidoNm: $("#dschSidoNm").val(),
			schDoroNm: $("#schDoroNm").val().replace(' ', ''),
			schGmNm: $("#schGmNm").val().replace(' ', ''),
			schGmBonNo: $("#schGmBonNo").val().replace(' ', ''),
			schGmBuNo: $("#schGmBuNo").val().replace(' ', ''),
			currentPage: $("#currentPage").val(),
			schPageSize: $("#schPageSize").val()
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					$("#resultList").html("");

					var text 		= "";
					var addr1		= "";
					var addr2		= "";
					var trNum		= 0;
					var zipCd 	 	= "";
					var zipCdWithDash = "";
					var idxCnt		= 0;
					var startIdx	= 0;
					var endIdx		= 0;
					//$(".tbmulti").html('<tr><th>우편번호</th><th>주소</th><th>일배</th><th>택배</th></tr>');
					var zipcodeArr;
					$(data).find("address").each(function() {
						zipcodeArr = $(this).text().split("|");
						if (zipcodeArr[0] == "nodata") {
							text = '<tr><td colspan="3">검색된 배송가능지역이 없습니다.</td></tr>';
						} else {
							if (trNum == 0) {
								startIdx 			= zipcodeArr[0];
							}
							addr1			= zipcodeArr[1];
							addr1           += (zipcodeArr[2] != null && zipcodeArr[2] != "null")? " " + zipcodeArr[2] : "";
							addr1           += (zipcodeArr[10] != null && zipcodeArr[10] != "null")? " " + zipcodeArr[10] : "";
							addr1			+= " "+ zipcodeArr[9];
						    addr1			+= (zipcodeArr[4] != 0)? " "+ zipcodeArr[3] +"-"+ zipcodeArr[4] : " "+ zipcodeArr[3];
						    addr1			+= (zipcodeArr[8] != null && zipcodeArr[8] != "null")? " " + zipcodeArr[8] : "";

							//addr2			= zipcodeArr[1];
							//addr2			+=  (zipcodeArr[2] != null)? " " + zipcodeArr[2] : "";
							//addr2			+=  (zipcodeArr[10] != null && zipcodeArr[10] != "null")? "&nbsp;" + zipcodeArr[10] : "";
							//addr2			+=  (zipcodeArr[11] != null && zipcodeArr[11] != "null")? "&nbsp;" + zipcodeArr[11] : "";
							//addr2			+=  (zipcodeArr[7] != null && zipcodeArr[7] != "null")? "&nbsp;" + zipcodeArr[7] : "";
							//addr2			+=  "&nbsp;" + zipcodeArr[8];

							text += '<tr id="zipTr'+trNum+'" style="cursor:pointer" onclick="fnSetAddrDo('+trNum+', \''+zipcodeArr[0]+'\', \''+addr1+'\', \'' + zipcodeArr[12] + '\', \'' + zipcodeArr[13] + '\', \'' + zipcodeArr[14] + '\', \'' + zipcodeArr[15] + '\')">';
							text += '	<td rowspan="2">'+zipcodeArr[0]+'</td>';
							text += '	<td><font color="blue">(도로명)&nbsp;' + addr1 + '</font></td>';
							
							if ( zipcodeArr[13] == "O" ) {
								text += '	<td rowspan="2">가능</td>';
							} else {
								text += '	<td rowspan="2">불가능</td>';
							}
							if ( zipcodeArr[14] == "O" ) {
								text += '	<td rowspan="2">가능</td>';
							} else {
								text += '	<td rowspan="2">불가능</td>';
							}
							text += '	<td rowspan="2">' + zipcodeArr[16] + '</td>';
							text += '	<td rowspan="2">' + zipcodeArr[17] + '\r' + zipcodeArr[18] +'</td>';							
							
							text += '</tr>';
							text += '<tr>';
							text += '	<td>(지번)&nbsp;'+ zipcodeArr[12] +'</td>';
							text += '</tr>';

						//$(".resultList").append('<tr><td>'+ zipcodeArr[0] +'</td><td>'+ zipcodeArr[1] +'</td><td>'+ zipcodeArr[4] +'</td><td>'+ zipcodeArr[5] +'</td></tr>');
						}

						trNum++;
					});

					$("#resultList").html(text);

					var pagingArr;
					$(data).find("paging").each(function() {
						pagingArr = $(this).text().split("|");
						var divText = '<ul class="paging">';
						divText += '<li class="li_btn"><a href="javascript:;" onclick="pgSearch(1);"><img src="/images/popup/ico_first.gif" alt="처음" /></a>';
						var sIdx = pagingArr[1] - 1;

						if(sIdx == '1')	{
							divText += '<a href="javascript:;" onclick="pgSearch(1);"><img src="/images/popup/ico_prev.gif" alt="이전" /></a>';
						} else{
							divText += '<a href="javascript:;" onclick="pgSearch('+ sIdx +');"><img src="/images/popup/ico_prev.gif" alt="이전" /></a>';
						}

						for(var i = pagingArr[1] ; i<=pagingArr[2]; i++){
							if($("#currentPage").val() == i)
								divText += '<strong><a href="javascript:;" onclick="pgSearch(' + i +');">' + i + '</a></strong>&nbsp;';
							else
								divText += '<a href="javascript:;" onclick="pgSearch(' + i + ');">' + i +'</a>&nbsp;';
						}
						<!-- Next 10 -->
						var eIdx = parseInt(pagingArr[2]) + 1;
						if(pagingArr[0] == pagingArr[2]){
							divText += '<a href="javascript:;" onclick="pgSearch('+ pagingArr[0] +');"><img src="/images/popup/ico_next.gif" alt="다음" /></a>';
						} else{
							divText += '<a href="javascript:;" onclick="pgSearch('+ eIdx + ');"><img src="/images/popup/ico_next.gif" alt="다음" /></a>';
						}
						divText += '<a href="javascript:;" onclick="pgSearch(' +  pagingArr[0] +');"><img src="/images/popup/ico_last.gif" alt="마지막" /></a>';
						divText += '</li>';
						divText += '</ul>';
						$("#div_paging").html(divText);
					});



				} else {
					$(data).find("error").each(function() {
						$(data).find("error").each(function() {

							text += '<tr>';
							text += '	<td colspan="3">';
							text += '		<p>검색된 주소가 없습니다.<br/>도로명 주소가 검색되지 않는 경우는 <a href="http://www.juso.go.kr" target="_blank"><font color="blue">http://www.juso.go.kr</font></a> 에서<br/>';
							text += '	 정확한 주소를 확인하시기 바랍니다.</p>';
							//text += '		<p>';
							//text += '			검색이 안되시면 "여기"를 클릭하세요. -->> //<a class="button small gray">여기</a>';
							//text += '		</p>';
							text += '	</td>';
							text += '</tr>';

						});
					});
				}
			});
		}, "xml");

		return false;
	}
}

function fnSetAddrJi(trNum, zip, addr, addr2, delvType1, delvType2, gmno) {
	if (delvType1 == 'X' && delvType2 == 'X') {
		alert("해당지역은 배달 받을 수 없습니다.\n다른 주소를 선택해주세요.");
		return false;
	} else if (delvType1 == 'X' && $("#dtype").val() == '0001') {
		alert("일일배달 상품은 택배지역으로 배달 받을 수 없습니다.\n다른 주소를 선택해주세요.");
		return false;
	} else if (delvType2 == 'X' && $("#dtype").val() == '0002') {
		alert("택배 상품은 일일배달지역으로 배달 받을 수 없습니다.\n다른 주소를 선택해주세요.");
		return false;
	} else {
		var gbNo	= '';
		/*if ($.trim(gmNm) != "") {
			var data = "schZip="+ zip +"&schGmNm="+ gmNm;
			$.ajax({
				type :'POST',
				url: "<c:url value='/front/shop/getDoJibun.do'/>",
				data :  data,
				dataType:"json",
				success:function(responseData){
					if(responseData.result != null && responseData.result.length > 0){
						for(var idx = 0; idx < responseData.result.length; idx++) {
							gbBonNo		= responseData.result[idx].gbBonNo;
							gbBuNo		= responseData.result[idx].gbBuNo;
						}

						gbNo	=  (gbBuNo == 0)? gbBuNo : gbBonNo + gbBuNo;
					}
				},
				error:function(xhr, textStatus, errorThrown) {
					alert("관리자에게 문의 하세요.");
				}
			});
		}*/
		//$("#addrJi").val(addr + gbNo);
		//$("#zip").val(zip);
		//$("#delvPtTxt").val(delvPtTxt);
		//$("#delvType").val(delvType);
		//$("#bonCheck").val(bonCheck);
		//$("#gmNm").val(gmNm);
		//$("#zip1").val(zip);
		//$("#doZip1").val(zip);
		//$("#addr1").val(addr);
		//$("#doAddr1").val(addr2);
		//$("#jisaCd").val(jisaCd);
		//$("#resultList tr").css("background-color", "");
		//$("#resultList tr").css("font-weight", "normal");
		//$("#zipTr"+ trNum).css("background-color", "yellow");
		//$("#zipTr"+ trNum).css("font-weight", "bold");

		if ($("#dtype").val() == '0001') {
			$("#rcv_zipcode", opener.document).val(zip);
			$("#rcv_addr1", opener.document).val(addr2);
			$("#rcv_addr_bcode", opener.document).val(gmno);
			//$("#ahAddr2Ji", opener.document).val(" " + addr2Ji);
		} else {
			$("#tag_zipcode", opener.document).val(zip);
			$("#tag_addr1", opener.document).val(addr2);
			//$("#tag_addr_bcode", opener.document).val(gmno);
			//$("#ahAddr2Do", opener.document).val(" " + addr2Do);
			//$("#ahAddr2Do", opener.document).val(addr2Do);
			//$("#ahJisaCd", opener.document).val(jisaCd);
		}

		self.close();
	}
}

function fnSetAddrDo(trNum, zip, addr, addr2, delvType1, delvType2, gmno) {
	if (delvType1 == 'X' && delvType2 == 'X') {
		alert("해당지역은 배달 받을 수 없습니다.\n다른 주소를 선택해주세요.");
		return false;
	} else if (delvType1 == 'X' && $("#dtype").val() == '0001') {
		alert("일일배달 상품은 택배지역으로 배달 받을 수 없습니다.\n다른 주소를 선택해주세요.");
		return false;
	} else if (delvType2 == 'X' && $("#dtype").val() == '0002') {
		alert("택배 상품은 일일배달지역으로 배달 받을 수 없습니다.\n다른 주소를 선택해주세요.");
		return false;
	} else {
		//$("#doZip1").val(zip);
		//$("#doAddr1").val(addr);
		//$("#resultDoList tr").css("background-color", "");
		//$("#resultDoList tr").css("font-weight", "normal");
		//$("#zipTrDo"+ trNum).css("background-color", "yellow");
		//$("#zipTrDo"+ trNum).css("font-weight", "bold");

		if ($("#dtype").val() == '0001') {
			$("#rcv_zipcode", opener.document).val(zip);
			$("#rcv_addr1", opener.document).val(addr);
			$("#rcv_addr_bcode", opener.document).val(gmno);
		} else {
			//$("#ahAddr2Ji", opener.document).val(" " + addr2Ji);
			$("#tag_zipcode", opener.document).val(zip);
			$("#tag_addr1", opener.document).val(addr);
			//$("#tag_addr_bcode", opener.document).val(gmno);
		}

		self.close();
	}
}

</script>

</body>
</html>
<%@ include file="/lib/dbclose_bm.jsp"%>