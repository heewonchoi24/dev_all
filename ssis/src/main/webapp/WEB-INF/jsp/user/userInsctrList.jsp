<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style type="text/css">
    #insctrSetting .agencyAll { padding: 10px; background-color: #eee; border: 1px solid #dbdbdb; font-weight: bold; }
    #insctrSetting .agencyList { height: 200px; padding: 10px; border: 1px solid #dbdbdb; overflow-y: auto; }
    #insctrSetting .agencyList li + li { margin-top: 5px; }
    .modal > #layer2, #insctrSetting .agencyList li [type='checkbox'] { position : static; }
    .datepicker .ipt { min-width: auto; }
    #insctrSetting .agencyList li { margin-left:-20px; }
</style>

<script>
var pUrl, pParam, selectUserArr, html;

$(document).ready(function(){
    
	$("#chkAll").change(function(){
		$chkAll = $(this);
		$("input[name=instt_cd]:checkbox").each(function(){
			$(this).prop("checked", $chkAll.prop("checked"));
			if($chkAll.prop("checked")) {
				$(this).parent().addClass("on");
			} else {
				$(this).parent().removeClass("on");
			}
		});
	});
});

function insctrSetting(userNm, userId){
	
	modalFn.show($('#insctrSetting'));
	
	$("#user_id").val(userId);
	
	html = '';
	var chkboxCnt = 0; 
	$("#selectInsctrNm").text(userNm);

	$.post("/admin/user/insctrInsttList.do", {user_id:userId}, function(data){
		$.each(data.insctrInsttList, function(i,v){
			if(v.ASIGN == 'Y'){
				html += '<li>';
				html += '<input type="checkbox" class="custom" name="instt_cd" id="instt_' + i + '" value="' + v.INSTT_CD + '" onchange="changeClass(this); return false;" checked>';
				chkboxCnt++;
			}else{
				html += '<li>';
				html += '<input type="checkbox" class="custom" name="instt_cd" id="instt_' + i + '" value="' + v.INSTT_CD + '" onchange="changeClass(this); return false;">';
			}
				html += '<label for="instt_' + i + '">' + v.INSTT_NM + '</label>';
				html += '</li>';
      	});
		
   		$("#insctrInsttList").html($(html));
   		
   		if(chkboxCnt == data.insctrInsttList.length) {
   			$("#chkAll").prop("checked", true);
   		} else {
   			$("#chkAll").prop("checked", false);
   		} 
	});

	html = '';
}

function listThread(pageNo) {
	$("#pageIndex").val(pageNo);
	$("#form").attr({
		method : "post"
	}).submit();
}

function goSearch(){
	
	$("#pageIndex").val("1");
	
	$("#form").attr({
		method : "post",
		action : "/admin/user/userInsctrList.do"
	}).submit();
}

function modify(user_id, user_nm, mngLevelNm, insctrBgnde, insctrEndde, permIp ){
	
	$("#layerTitle").text("점검원 수정");
	
	$("#user_id").val(user_id);
	$("#updateMode").hide();
	$("#fromdate").val(insctrBgnde);
	$("#todate").val(insctrEndde);
	$("#isModify").val("Y");
	var ip = permIp.split('.');
	$("#mngLevelCd").val(mngLevelNm);
	$("#insctrNm").val(user_nm);
	$("#permIp1").val(ip[0]);
	$("#permIp2").val(ip[1]);
	$("#permIp3").val(ip[2]);
	$("#permIp4").val(ip[3]);

	modalFn.show($('#inspectorWrite'));
	$("#addBtnTh").css("display", "none");
	$("#addBtn").css("display", "none");
}

function changeClass(el){
	if($(el).prop("checked")){
		$(el).parent().addClass("on");
	}else{
		$(el).parent().removeClass("on");
	}
	
}

function setInsctrInstt(){
	var insttArr = [];
	
	$("input:checkbox").each(function(){
		if($(this).prop("checked")){
			insttArr.push($(this).val());	
		}
	});
	
	if('' == insttArr) {
		alert('기관을 선택해 주세요');
		return false;
	}
	
	if(confirm("저장하시겠습니까?")){
		pParam = {};
		pParam.user_id = $("#user_id").val();
		pParam.instt_cds = insttArr.join(",");
		$.post("/admin/user/setInsctrInstt.do", pParam, function(data){
	    	alert(data.message);
	        modalFn.hide($('#insctrSetting'));
	        
	        document.form.action = "/admin/user/userInsctrList.do";
		    document.form.submit();
	    });
	}
}

function addInsctr(flag){

	var html = '<tr>';
	html += ' 	<td class="center"><input type="text" name="insctrNm" class="ipt" style="width: 120px;" maxLength="10"></td>\n';
	html += '		<td class="center">';
	html += '			<input type="text" name="permIp1" class="ipt" id="" maxLength="3" value="*" style="width: 50px; text-align: center;"> ';
	html += '			<input type="text" name="permIp2" class="ipt" id="" maxLength="3" value="*" style="width: 50px; text-align: center;"> ';
	html += '			<input type="text" name="permIp3" class="ipt" id="" maxLength="3" value="*" style="width: 50px; text-align: center;"> ';
	html += '			<input type="text" name="permIp4" class="ipt" id="" maxLength="3" value="*" style="width: 50px; text-align: center;">\n';
	html += '		</td>';
    html += '    <td class="center">';
	if('I' == flag) {
		html += '<a href="#" class="btn red" onclick="remove_user(this)">삭제</a>\n';
	} else if('D' == flag) {
		html += '<a href="#" class="btn blue" onclick="addInsctr('+"'I'"+'); return false;">추가</a>\n';
	}
	html += '</td>';
	html += '</tr>';
	if('I' == flag) {
		$(".next").after($(html));
	} else {
		return html;
	}
	$(window).resize();
}

function remove_user(t) {
	$(t).closest('tr').remove();
    $(window).resize();
}

function createInsctr(){
	
	if('Y' == $("#isModify").val()) {
		updateInsctr();
		return true;
	}
	
	var insctrNm = [];
	var ip1 = [];
	var ip2 = [];
	var ip3 = [];
	var ip4 = [];
	var cnt = 0;
	
	var fromdate = $("#fromdate").val();
	var todate = $("#todate").val();
	var mngLevelCd = $("#mngLevelCd").val();
	
	if('' == fromdate) {
		alert("시작일을 선택해 주세요");
		return false;
	}
	if('' == todate) {
		alert("종료일을 선택해 주세요");
		return false;
	}
	if('' == mngLevelCd) {
		alert("관리수준을 선택해 주세요");
		return false;
	}
	$("input[name=insctrNm]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			insctrNm.push($(this).val());
		}
	});
	if(0 != cnt) {
		alert("이름은 필수입력입니다.");
		return false;
	}
	$("input[name=permIp1]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			ip1.push($(this).val());
		}
	});
	$("input[name=permIp2]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			ip2.push($(this).val());
		}
	});
	$("input[name=permIp3]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			ip3.push($(this).val());
		}
	});
	$("input[name=permIp4]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			ip4.push($(this).val());
		}
	});
	if(0 != cnt) {
		alert("허용 IP는 필수입력입니다.");
		return false;
	}
	
	if(confirm("저장 하시겠습니까?")){
	
		pParam = {};
		pParam.fromDate = fromdate.replace(/\./gi, ""); 
		pParam.toDate = todate.replace(/\./gi, "");
		pParam.mngLevelCd = mngLevelCd;
		pParam.insctrNms = insctrNm.join(",");
		pParam.permIp1 = ip1.join(",");
		pParam.permIp2 = ip2.join(",");
		pParam.permIp3 = ip3.join(",");
		pParam.permIp4 = ip4.join(",");
		$.post("/admin/user/createInsctr.do", pParam, function(data){
	    	alert(data.message);
	        $("#form").submit();
	    });
	}
}

function updateInsctr() {
	
	var fromdate = $("#fromdate").val();
	var todate = $("#todate").val();
	
	if('' == fromdate) {
		alert("시작일을 선택해 주세요");
		return false;
	}
	if('' == fromdate) {
		alert("종료일을 선택해 주세요");
		return false;
	}
	if('' == $("input[name=permIp1]").val() || '' == $("input[name=permIp2]").val() || '' == $("input[name=permIp3]").val() || '' == $("input[name=permIp4]").val()) {
		alert("허용 IP를 입력해 주세요");
		return false;
	}
	
	pParam = {};
	pParam.fromDate = fromdate.replace(/\./gi, ""); 
	pParam.toDate = todate.replace(/\./gi, "");
	pParam.user_id = $("#user_id").val();
	pParam.user_nm = $("#insctrNm").val();
	pParam.mngLevelCd = $("#mngLevelCd").val();
	
	pParam.permIp1 = $("input[name=permIp1]").val();
	pParam.permIp2 = $("input[name=permIp2]").val();
	pParam.permIp3 = $("input[name=permIp3]").val();
	pParam.permIp4 = $("input[name=permIp4]").val();
	
	if(confirm("수정 하시겠습니까?")){
		$.post("/admin/user/updateInsctr.do", pParam, function(data){
	    	alert(data.message);
	        $("#form").submit();
	    });
	}
}
/*
function deleteInsctr() {
	
	$(".user_chk").each(function(){
		if($(this).prop("checked")){
   			$("#user_id").val($(this).val().split(",")[0]);
		}
	});
	
	if('' == $("#user_id").val()) {
   		alert('점검원을 선택해 주세요');
   		return;
	}
	
	if(confirm("삭제 하시겠습니까?")){
		pParam = {};
		pParam.user_id = $("#user_id").val();
		
		$.post("/user/deleteInsctr.do", pParam, function(data){
	    	alert(data.message);
	        $("#form").submit();
	    });
	}
}
*/
function deleteInsctr(userid) {
	if(confirm("삭제 하시겠습니까?")){
		pParam = {};
		pParam.user_id = userid;
		$.post("/admin/user/deleteInsctr.do", pParam, function(data){
	    	alert(data.message);
	        $("#form").submit();
	    });
	}
}
function searchClear(){
	$("#searchBgnde").val("");
	$("#searchEndde").val("");
	$("#searchMngLevelCd").val("");
	$("#searchInstt").val("");
	$("#searchUserNm").val("");
}

function fn_excel_download() {
	$("#form").attr({
        action : "/admin/user/insctrExcelDownload.do",
        method : "post"
    }).submit();
}

function rePasswd(userId) {
	
	if(confirm("비밀번호를 초기화 하시겠습니까?")){
		
		var pParam = {};
		pParam.userId = userId;
		$.post("/admin/user/insctrRePasswd.do", pParam, function(data){
	    	alert(data.message);
	    });
	}
}
</script>

<form action="/admin/user/userInsctrList.do" method="post" id="form" name="form">
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }"/>
	<input type="hidden" name="isModify" id="isModify"/>
	<input type="hidden" name="user_id" id="user_id"/>
	
	<!-- 점검원 등록 레이어 팝업 -->
<section id="inspectorWrite" class="modal" style="max-width: 600px;">
	<div id="layer1" class="inner">
		<div class="modal_header">
            <h2>점검원 등록/수정</h2>
            <button class="btn square trans modal_close"><i class="ico close_w" onclick="modalFn.hide($('#inspectorWrite'))"></i></button>
        </div>
		<div class="modal_content">
			<div class="inner">
				<table class="board_list_write" summary="기간설정, 관리수준 구분, 점검원으로 구성된 점검원 일괄등록입니다.">
					<tbody>
						<tr>
							<th scope="row">기간설정</th>
							<td>
								<div class="dataSearch">
									<div class="ipt_group datepicker">
										<input type="text" id="fromdate" name="fromdate" class="ipt w100p" placeholder="시작일" >
										 <label for="fromdate" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
									</div>
									<div class="div">~</div>
									<div class="ipt_group datepicker">
										<input type="text" id="todate" name="todate" class="ipt w100p" placeholder="종료일" >
										<label for="todate" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
									</div>
								</div>
								<script type="text/javascript">
                                    $(function () {
                                        $('#fromdate').datetimepicker({
                                            format: 'YYYY.MM.DD'
                                        });
                                        $('#todate').datetimepicker({
                                            format: 'YYYY.MM.DD',
                                            useCurrent: false
                                        });
                                        $("#fromdate").on("dp.change", function (e) {
                                            $('#todate').data("DateTimePicker").minDate(e.date);
                                        });
                                        $("#todate").on("dp.change", function (e) {
                                            $('#fromdate').data("DateTimePicker").maxDate(e.date);
                                        });
                                    });
                                </script>
							</td>
						</tr>
						<tr>
							<th scope="row">관리수준구분</th>
							<td>
								<select id="mngLevelCd" name="mngLevelCd" title="관리수준선택" class="ipt" style="width: 200px;">
									<option value="">선택</option>
									<option value="ML01">관리수준 진단</option>
									<option value="ML02">관리수준 현황조사</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
					
				<div class="board_list_title" style="margin-top: 20px;">점검원</div>
				 <table class="board_list_normal">
				 	<thead>
				 		<tr>
				 			<th>이름</th>
                            <th>허용IP</th>
                            <th id="addBtnTh">추가/삭제</th>
				 		</tr>
				 	</thead>
				 	<tbody>
						<tr class="next">
							<td class="center">
								<input type="text" id="insctrNm" name="insctrNm" class="ipt" style="width: 120px;" maxLength="10">
							</td>
							<td class="center">
								<input type="text" id="permIp1" name="permIp1" class="ipt" maxLength="3" value="*" style="width: 50px; text-align: center;"> 
								<input type="text" id="permIp2"	 name="permIp2" class="ipt" maxLength="3" value="*" style="width: 50px; text-align: center;"> 
								<input type="text" id="permIp3" name="permIp3" class="ipt" maxLength="3" value="*" style="width: 50px; text-align: center;"> 
								<input type="text" id="permIp4" name="permIp4" class="ipt" maxLength="3" value="*" style="width: 50px; text-align: center;">
							</td>
							<td class="center" id="addBtn">
								<a href="#" class="btn blue" onclick="addInsctr('I'); return false;">추가</a>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="board_list_btn center">
					<a href="#" class="btn blue" onclick="createInsctr(); return false;">저장</a>
					<a href="#" class="btn black" onclick="modalFn.hide($('#inspectorWrite'))">취소</a>
				</div>
			</div>
		</div>
	</div>
</section>
	<!-- /점검원 등록 레이어 팝업 -->
	
	<!-- 점검원 기관배정 레이어 팝업 -->
<section id="insctrSetting" class="modal" style="max-width: 600px;">
	<div id="layer2" class="inner">
		<div class="modal_header">
			<h2>점검원 기관배정</h2>
            <button class="btn square trans modal_close"><i class="ico close_w" onclick="modalFn.hide($('#insctrSetting'))"></i></button>
		</div>
		<div class="modal_content">
			<div class="inner">
				<table class="board_list_write" summary="점검원, 기관선택으로 구성된 점검원 기관배정입니다.">
					<colgroup>
						<col style="width:100px;">
						<col style="width:*">
					</colgroup>				
					<tbody>
						<tr>
							<th scope="row">점검원</th>
							<td id="selectInsctrNm"></td>
						</tr>						
						<tr>
							<th scope="row">기관선택</th>
							<td>
								<div class="agencyAll">
                                     <input type="checkbox" id="chkAll" class="custom">
                                     <label for="chkAll" class="hidden">기관명</label>
								</div>	                                         
								<ul id="insctrInsttList" class="agencyList">
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="board_list_btn center">
					<a href="#" class="btn blue" onclick="setInsctrInstt(); return false;">저장</a>
					<a href="#" class="btn black" onclick="modalFn.hide($('#insctrSetting'))">취소</a>
				</div>
			</div>
		</div>
	</div>
</section>
	<!-- /점검원 기관배정 레이어 팝업 -->	
	<!-- /레이어 팝업 -->  
<div id="main">
    <div class="group">
    <div class="header"><h3>점검원 관리</h3></div>
	<!-- content -->
	<div id="container" class="body">
		<div class="content_wrap">
			
			<div class="board_list_top">
				<div class="board_list_info">
					전체 <span class="totalCount">${totalCnt }</span>개, 현재 페이지 
					<span class="c_red"  id="totalCount">${pageIndex }</span>/${totalPageCnt }
				</div>
				<div class="board_list_filter">
					<select name="searchMngLevelCd" title="관리수준선택" id="searchMngLevelCd" class="ipt" style="width: 200px;">
						<option value="">관리수준 전체</option>
						<option value="ML01" <c:if test="${'ML01' eq searchMngLevelCd }">selected</c:if>>관리수준 진단</option>
						<option value="ML02" <c:if test="${'ML02' eq searchMngLevelCd }">selected</c:if>>관리수준 현황조사</option>
					</select>
					<select name="searchInstt" title="기관배정" id="searchInstt" class="ipt" style="width: 200px;">
						<option value="">배정 전체</option>
						<option value="Y" <c:if test="${'Y' eq searchInstt }">selected</c:if>>배정</option>
						<option value="N" <c:if test="${'N' eq searchInstt }">selected</c:if>>미배정</option>
					</select>
				</div>
				<div class="board_list_search">
					<div class="ipt_group">
						<input type="text" name="searchUserNm" class="ipt" title="이름으로 검색해 주세요" placeholder="검색어를 입력하세요" class="w40" value="${searchUserNm }">
						<span class="ipt_right addon">
						<input type="button" value="검색" class="btn searhBtn"" onclick="goSearch(); return false;">
					</div>
				</div>
			</div>

				<table class="board_list_normal" summary="선택, 아이디, 이름, 관리수준 구분, 점검기간, 허용IP, 배정여부, 비밀번호 초기화, 관리로 구성된 점검원 관리 리스트입니다.">
					<colgroup>
						<col style="width:170px;">
						<col style="width:170px;">
						<col style="width:*">
						<col style="width:250px;">
						<col style="width:250px;">
						<col style="width:100px;">
						<col style="width:160px;">
						<col style="width:150px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">아이디</th>
							<th scope="col">이름</th>
							<th scope="col">관리수준구분</th>
							<th scope="col">점검기간</th>							
							<th scope="col">허용IP</th>
							<th scope="col">배정여부</th>
							<th scope="col">비밀번호 초기화</th>
							<th scope="col">관리</th>
						</tr>
					</thead>
					<tbody>
		                <c:choose>
 		                	<c:when test="${!empty userList}">
								<c:forEach var="i" items="${userList }" varStatus="status">
									<tr>
										<td class="center">${i.userId }</td>
										<td class="center">${i.userNm }</td>
										<td class="center">${i.mngLevelNm }</td>
										<td class="date">${i.insctrBgnde } ~ ${i.insctrEndde }</td>
										<td class="center">${i.permIp }</td>
										<c:choose>
											<c:when test="${'Y' eq i.insttMapYn }">
												<td class="center"><a href="#" class="link" onclick="insctrSetting('${i.userNm }', '${i.userId }'); return false;">배정</a></td>
											</c:when>
											<c:otherwise>
												<td class="center"><a href="#" class="link" onclick="insctrSetting('${i.userNm }', '${i.userId }'); return false;">미배정</a></td>
											</c:otherwise>
										</c:choose>
										<td class="center"><a href="#" class="link" onclick="rePasswd('${i.userId }'); return false;">비밀번호 초기화</a></td>
										<td class="center"><a href="#" class="link" onclick="modify('${i.userId }','${i.userNm }','${i.mngLevelCd }','${i.insctrBgnde }','${i.insctrEndde }','${i.permIp }'); return false;">수정</a>
										 | <a href="#" class="link" onclick="deleteInsctr('${i.userId}');">삭제</a></td>
									</tr>
								</c:forEach>
			                </c:when>
			                <c:otherwise>
			                	<tr>
			                		<td class="none" colspan="9">리스트가 없습니다.</td>
			                	</tr>
			                </c:otherwise>
		                </c:choose>
					</tbody>
				</table>
				<div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="listThread" />
				</div>
				<div class="board_list_btn right">
					<a href="#" class="btn blue" onclick="modalFn.show($('#inspectorWrite'));">사용자 등록</a>
					<a href="#" class="btn green" onclick="javascript:fn_excel_download(); return false;">엑셀다운</a>
				</div>
			</div>
		</div>
	</div>
	<!-- /content -->
</form>