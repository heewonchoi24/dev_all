<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
$(window).ready(function(){
	
	$(".selectMenu>li>a").on('click',function(e){
		e.preventDefault();
		$("#srchOpt").val($(this).attr('value'));
	});	
	
	$(".layer .close").click(function(e){
		
		var insttCd = $("#insttCd").val();
		var status = $("#status").val();
		
		if('' == status || 'SS01' == status) {
			$("#"+insttCd+'A').prop("checked", false);
			$("#"+insttCd+'B').prop("checked", false);
		}else {
			$("#"+insttCd+'A').prop("checked", true);
		}
		
	    e.preventDefault();
	    $(".layer_bg, .layer").hide();
	    $("body").css("overflowY", "visible");
	});
	
});

function companion1Callback(){

};    

function fn_status(insttCd, type, status, statusFlag) {
	
	if('' == status) {
		alert('신청중에는 승인 또는 반려 할 수 없습니다.');
		$(value).prop("checked", false);
		return false;
	}
	
	if('A' == type && 'A' == statusFlag)
		return false
	if('B' == type && 'B' == statusFlag)
		return false
	
	$("#insttCd").val(insttCd);
	$("#status").val(status);
		
	var typeA = $("#"+insttCd+'A').prop("checked");
	var typeB = $("#"+insttCd+'B').prop("checked");
	
	if('A' == type) {
		if (confirm("승인 하시겠습니까?")) {
			
			$("#status").val("SS02");
			
			$("#form").attr("action", "/cjs/modifyCntrlStatus.do");
			
			var options = {
					success : function(data){
						alert(data.message);
						listThread($("#pageIndex").val());
					},
					type : "POST"
			};
			
			$("#form").ajaxSubmit(options);
			
			
		} else {
			if('' == status || 'SS01' == status) {
				$("#"+insttCd+'A').prop("checked", false);
				$("#"+insttCd+'B').prop("checked", false);
			}else {
				$("#"+insttCd+'B').prop("checked", true);
			}
		}
	} else if ('B' == type) {
		//$("#returnResn").val("");
		//e.preventDefault();
       // wrapWindowByMask();  
        //$("body").css("overflowY", "hidden");
        layerPopup3.open('/cjs/companionPopup.do','companion1', companion1Callback);
	}
}

function listThread(pageNo) {

	$("#pageIndex").val(pageNo);
	$("#form").attr({
		method : "post",
		action : "/cjs/cntrlRegistMngList.do"
	}).submit();
}

function fnAttachmentApplyFileDown( chkAttachmentFile ) {
	
	// 삭제 목록에 넣는다 
	var chkAttachmentFileArr = chkAttachmentFile.split("|");
	var chkAttachmentFile = "";
	
	if( chkAttachmentFileArr.length < 1 )
		return;
	
	for( key in chkAttachmentFileArr ) {
		var fileId = chkAttachmentFileArr[ key ];
		if( fileId == "" )
			continue;
		
		var fileInfo = new Object();
		fileInfo.fileId		= fileId;
		fileInfo.fileName	= fileId;
		fileInfo.fileSize	= "0";
		fileInfo.fileUrl	= "";
		
		chkAttachmentFile += JSON.stringify( fileInfo );		
	}	
	chkAttachmentFile = "["+ chkAttachmentFile +"]";    
	
	var CD_DOWNLOAD_FILE_INFO = chkAttachmentFile;
	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
}

function modifyResn() {
	
	if('' == $("#returnResn").val()) {
		alert('반려 사유는 필수 입력입니다.');
		return false;
	}
	
	if (confirm("반려 하시겠습니까?")) {
		
		$("#status").val("SS03");
		
		$("#form").attr("action", "/cjs/modifyCntrlStatus.do");
		
		var options = {
				success : function(data){
					alert(data.message);
					listThread($("#pageIndex").val());
				},
				type : "POST"
		};
		
		$("#form").ajaxSubmit(options);
		
	} else {
		var insttCd = $("#insttCd").val();
		var status = $("#status").val();
		//e.preventDefault();
        $(".layer_bg, .layer").hide();
        $("body").css("overflowY", "visible");
		
		if('' == status || 'SS01' == status) {
			$("#"+insttCd+'A').prop("checked", false);
			$("#"+insttCd+'B').prop("checked", false);
		}else {
			$("#"+insttCd+'A').prop("checked", true);
		}
	}
}

function pageLink(pageNo){
	$("#pageIndex").val(pageNo);
	document.form.submit();
}

function searchList(){
	if($("#srchStr").val()){
		if(!$("#srchOpt").val()){
			alert("검색분류를 선택하세요."); 
			return;
		}
	}
	$("#pageIndex").val("1");
	document.form.submit();
}
</script>

<form action="/cjs/cntrlRegistMngList.do" method="post" id="form" name="form">

	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }"/>
	<input type="hidden" name="insttCd" id="insttCd" value=""/>
	<input type="hidden" name="status" id="status" value=""/>
	
	<!-- content -->
   <section id="container" class="sub">
       <div class="container_inner">
       
			<div class="box-select-gray">
				<div class="box-select-ty1 type1">
					<div class="selectVal" tabindex="0">
						<a href="#this" value="#this" tabindex="-1" >
							<c:choose>
								<c:when test="${srchOpt eq null or srchOpt eq '' }">선택</c:when>
								<c:when test="${srchOpt eq '1' }">이름</c:when>
								<c:when test="${srchOpt eq '2' }">기관명</c:when>
								<c:when test="${srchOpt eq '3' }">연락처</c:when>
								<c:when test="${srchOpt eq '4' }">핸드폰</c:when>
							</c:choose>
						</a>
						<input type="hidden" id="srchOpt" name="srchOpt" value="${srchOpt }" />
					</div>
					 <ul class="selectMenu" >
						<li><a href="#" value="1">이름</a></li>
						<li><a href="#" value="2">기관명</a></li>
						<li><a href="#" value="3">연락처</a></li>
						<li><a href="#" value="4">핸드폰</a></li>
					 </ul>
				</div>
				
				<div class="inp_sch">
					<input type="text" class="inp_txt w100p" id="srchStr" name="srchStr" title="검색어 입력" placeholder="검색어 입력" class="w40" value="${srchStr }">
					<button type="button" class="btn_sch" onclick="searchList();" ><span class="i-set i_sch">검색</span></button>
				</div>
			</div>
			
			 <div class="wrap_table2 bdno">
				<table class="tbl" summary="번호, 이름, 기관명, 연락처, 핸드폰, 신청일자, 신청서 다운로드, 상태, 승인여부로 구성된 관제 신청관리 리스트입니다.">
					<caption>관제 신청관리 리스트</caption>
					<colgroup>
		              <col>
		              <col>
		              <col class="th1_2">
		              <col>
		              <col>
		              <col>
		              <col>
		              <col>
		              <col>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
                            <th scope="col">이름</th>
                            <th scope="col">기관명</th>
                            <th scope="col">연락처</th>
                            <th scope="col">핸드폰</th>
                            <th scope="col">신청일자</th>
                            <th scope="col">신청서 다운로드</th>
                            <th scope="col">상태</th>
                            <th scope="col">승인여부</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${!empty resultList}">
								<c:forEach var="list" items="${resultList }" varStatus="status">
									<tr>
										<td>${list.rowNum }</td>
										<td>${list.userNm }</td>
										<td>${list.insttNm }</td>
										<td>${list.telNo }</td>
										<td>${list.moblphonNo }</td>
										<td>${list.registDt }</td>
										<c:choose>
											<c:when test="${!empty list.atchmnflId }">
												<c:set var="fileId" value=""/>
		                                		<c:forEach var="i" items="${fileList }" varStatus="status1">
	                                    			<c:if test="${list.insttCd eq i.insttCd }">
	                                    				<c:set var="fileId" value="${fileId}|${i.fileId}"/>
	                                    			</c:if>
	                                    		</c:forEach>
												<td><a href="#" class="btn-pk vs blue" onClick="javascript:fnAttachmentApplyFileDown('${fileId}'); return false;"><span>다운로드</span></a></td>
											</c:when>
											<c:otherwise>
												<td></td>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${empty list.status}">
												<td><span class="i-txt">신청중</span></td>
											</c:when>
											<c:when test="${'SS01' eq list.status }">
												<td><span class="i-txt">신청완료</span></td>
											</c:when>
											<c:when test="${'SS02' eq list.status }">
												<td><span class="i-txt">승인완료</span></td>
											</c:when>
											<c:when test="${'SS03' eq list.status }">
												<td><span class="i-txt">반려</span></td>
											</c:when>
										</c:choose>
										<td>
											<c:set var="statusFlag" value=""/>
											<c:choose>
												<c:when test="${list.status == 'SS02'}">
													<c:set var="statusFlag" value="A"/>
												</c:when>
												<c:when test="${list.status == 'SS03'}">
													<c:set var="statusFlag" value="B"/>
												</c:when>
											</c:choose>
											<span class="d-ib mg-c3"><input type="radio" name="status${status.index}" id="${list.insttCd}A" onclick="fn_status('${list.insttCd}', 'A', '${list.status}', '${statusFlag}')" <c:if test="${list.status == 'SS02'}">checked="true"</c:if> /><label for="${list.insttCd}A" class="mr10">승인</label></span>
                                			<span class="d-ib mg-c3"><input type="radio" name="status${status.index}" id="${list.insttCd}B" value="${list.returnResn}" onclick="fn_status('${list.insttCd}', 'B', '${list.status}', '${statusFlag}')" <c:if test="${list.status == 'SS03'}">checked="true"</c:if>/><label for="${list.insttCd}B">반려</label></span>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr><td colspan="10"><div class="lst-empty">등록된 관제신청이 없습니다.</div></td></tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			
				<div class="pagenation">
					<ul>
						<ui:pagination paginationInfo="${paginationInfo}" type="bbsImage" jsFunction="pageLink" />
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!-- /content -->
</form>

<form id="__downForm" name="__downForm" action="<c:url value='/crossUploader/fileDownload.do'/>" method="post">
	<input type="hidden" id="CD_DOWNLOAD_FILE_INFO" name="CD_DOWNLOAD_FILE_INFO" value="" >
	<input type="hidden" id="fileExt" name="fileExt" value="xlsx;jpg;gif;png;bmp;zip;">
	<input type="hidden" id="maxFileSize" name="maxFileSize" value="">
	<input type="hidden" id="maxTotFileSize" name="maxTotFileSize" value="">
		<input type="hidden" id="maxFileSize1" name="maxFileSize1" value="">
		<input type="hidden" id="maxTotFileSize1" name="maxTotFileSize1" value="">
	<input type="hidden" id="applyFlag" name="applyFlag" value="N">
</form>