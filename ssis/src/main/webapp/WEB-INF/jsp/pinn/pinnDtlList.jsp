<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style> .icheckbox_square + label { width: 93%; } </style>

<script type="text/javascript">
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	
	// 검색 옵션 선택 시
	$(document).on("click","#insttClCdList>li>a",function(e){
		e.preventDefault();
		$("#insttClCd").val(this.dataset.clcd);
		$("#insttClNm").val(this.dataset.clnm);
		changeInsttList(this.dataset.clcd);
	});
	
	$(document).on("click","#insttCdList>li>a",function(){
		$("#insttCd").val(this.dataset.cd);
		$("#insttNm").val(this.dataset.nm);
		selectList();
	});
	
	// 차수 옵션 선택 시
	$(document).on("click","#yyyy>li>a",function(){
		$("#searchYyyy").val(this.dataset.yyyy);
		selectList();
	});
	
	$(".ta-l.pd2.td_log .iCheck-helper, .ta-l.pd2.td_log label").click(function(){
		var seq = $(this).prev().attr("seq");
		if($(".allChk[seq="+seq+"]").is(":checked")) {
			$(".ickjs[seq="+seq+"]").prop("checked", true);
			$("."+seq+" .icheckbox_square").addClass("checked");
		}else {
			$(".ickjs[seq="+seq+"]").prop("checked", false);
			$("."+seq+" .icheckbox_square").removeClass("checked");
		} 
	})
	
});

function changeInsttList(insttClCd){

	pUrl = "/pinn/selectBoxInsttList.do";
	pParam = {};
	pParam.insttClCd = insttClCd;
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		var str = '';
		str += '<div class="selectVal insttSelectVal" tabindex="0">'; 	
		str += '<a href="#this" tabindex="-1">선택해주세요</a>'; 	
		str += '</div>'; 	
		str += '<ul class="selectMenu insttSelectMenu" id="insttCdList">'; 
		for(var i in data.orgBoxList){
			str += '<li><a href="#" data-cd="' + data.orgBoxList[i].insttCd + '" data-nm="' + data.orgBoxList[i].insttNm + '">' + data.orgBoxList[i].insttNm + '</a></li>';
		}
		$(".box-select-ty1.type1.sec").html(str);
	}, function(jqXHR, textStatus, errorThrown){
		
	});
	
}

function goSummary(){
	$( "#insttCd").val("");
	$( "#insttClCd").val("");
	
	$("#pinnForm").attr({
        action : "/pinn/pinnSummaryList.do",
        method : "post"
    }).submit();
}

function selectList(){
	$("#pinnForm").attr({
        action : "/pinn/pinnDtlList.do",
        method : "post"
    }).submit();
}

function fnAddAttachmentFile(index, atchmnflId, attachmentFile ) {
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;
	
    $( "#atchmnfl_id").val(atchmnflId);
    $( "#schdulSeq").val(index);
    
    var url			= "/crossUploader/fileUploadPopUp.do";
    var varParam	= "";
    var openParam	= "height=445px, width=500px";

	var attachmentFile = window.open( "", "attachmentFile", openParam );
    attachmentFile.location.href = url;

}

function fnAttachmentFileCallback( uploadedFilesInfo, modifiedFilesInfo ) {

	var uploadedFilesInfoObj = jQuery.parseJSON( uploadedFilesInfo );
	if( uploadedFilesInfoObj != null ) {
		$.each( uploadedFilesInfoObj, function( uKey, uValue ) {
			var isIn = false;
			$.each( attachmentFileArray, function( key, value ) {				
				if( uValue.fileId == value.fileId ) {
					isIn = true;
				}
			});
			if( isIn == false ) {
				attachmentFileArray.push( uValue );
			}
		});
	}

	$( "#uploadedFilesInfo" ).val( uploadedFilesInfo );
	$( "#modifiedFilesInfo" ).val( modifiedFilesInfo );
	
	pParam = {};
	pUrl = "/pinn/updatePinnEval.do";

	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.uploadedFilesInfo = uploadedFilesInfo;
	pParam.modifiedFilesInfo = modifiedFilesInfo;
	pParam.schdulSeq = $( "#schdulSeq").val();
	pParam.insttCd = $( "#insttCd").val();

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		//alert(data.message);
		
	}, function(jqXHR, textStatus, errorThrown){
			
	});

	selectList();
}

function fnCheckAttachmentFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "]" ).prop( "checked", $( "#chkAttachmentFile_"+ index + "all" ).prop( "checked" ) );
}

function fnAttachmentFileDown( index, atchmnflId ) {

	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;
	
	var chkAttachmentFile = atchmnflId;
	// Check Box 선택 
	if( atchmnflId == "" ) {
		$( "input:checkbox[name=chkAttachmentFile_" + index + "]" ).each( function() {
			if( $(this).prop( "checked" ) ) 
				chkAttachmentFile += "," + $(this).attr("id");
		});
		chkAttachmentFile = chkAttachmentFile.substring( 1, chkAttachmentFile.length )
	}
	if( chkAttachmentFile == "" ) {
		alert( "다운로드할 파일을 선택 하십시요.")
		return;
	}
	// 삭제 목록에 넣는다 
	var chkAttachmentFileArr = chkAttachmentFile.split(",");
	if( chkAttachmentFileArr.length < 1 )
		return;
	chkAttachmentFile = "";
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

function fnDeleteAttachmentFile(index, atchmnflId, attachmentFile ) {
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;
	
	var deleteAttachmentFile = "";
	var chkAttachmentFile = "";
	
	$( "input:checkbox[name=chkAttachmentFile_" + index + "]" ).each( function() {
		if( $(this).prop( "checked" ) ) 
			chkAttachmentFile += "," + $(this).attr("id");;
	});
	
	if( chkAttachmentFile == "" ) {
		alert('삭제 하실 파일을 선택해 주세요');
		return false;
	}
	
	var p_atchmnflId =  [];
    var p_fileId =  [];
    var p_filePath =  [];
    var p_cnt= 0;
    
	if (confirm("삭제하시겠습니까?")) {
	 	$.each( attachmentFileArray, function( key, value ) {
			if( chkAttachmentFile.indexOf( value.fileId  ) > 0 ) {
				p_atchmnflId[p_cnt]	= value.atchmnflId;
				p_fileId[p_cnt]		= value.fileId;
				p_filePath[p_cnt]	= value.filePath + "/" + value.saveFileName;
				p_cnt++;
			}
		});	

		var pUrl = "/pinn/deletePinnEval.do";
 		var param = new Object();
		
 		param.atchmnflId = p_atchmnflId;
 		param.fileId = p_fileId;
 		param.filePath = p_filePath;
 		param.schdulSeq = index;
 		param.insttCd = $("#insttCd").val();
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
 			alert(data.message);
			
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});

 		selectList();	 	
	}
	return false;
}

function fnAttachmentApplyFileDown( chkAttachmentFile ) {

	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;
	
	// 삭제 목록에 넣는다 
	var chkAttachmentFileArr = chkAttachmentFile.split("|");
	if( chkAttachmentFileArr.length < 1 )
		return;
	chkAttachmentFile = "";
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

function fnEvalFil(index, status, crud, flag) {
	var tf = false;
	if(flag == "cancel") tf = confirm("완료해제 하시겠습니까?");
	else if (flag == "finish") tf = confirm("점검완료 하시겠습니까?")
	
	if (tf) {

		var pUrl = "/pinn/updatePinnEvalStatus.do";
 		var param = new Object();
 		
 		param.schdulSeq = index;
 		param.status = status;
 		param.crud = crud;
 		param.insttCd = $("#insttCd").val();
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
 			alert(data.message);
			
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});

 		selectList();	 	
	}
	return false;
}
</script>

<form method="post" id="pinnForm" name="pinnForm">
	<input type="hidden" id="insttCd" name="insttCd" value="${requestZvl.insttCd}" >
	<input type="hidden" id="insttNm" name="insttNm" value="${requestZvl.insttNm}" >
	<input type="hidden" id="searchYyyy" name="searchYyyy" value="${requestZvl.searchYyyy}"/>
	<input type="hidden" id="insttClCd" name="insttClCd" value="${requestZvl.insttClCd}"/>
	<input type="hidden" id="insttClNm" name="insttClNm" value="${requestZvl.insttClNm}"/>
	
	<!--  파일 업로드에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="" >
	<input type="hidden" id="schdulSeq" name="schdulSeq" value="" > 
	<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
	<!--  파일 업로드에 사용 -->

<section id="container" class="sub">
	<!-- content -->
    <div id="container" class="container_inner">
    
            <div class="box-select-gray">
            	<div class="box-select-ty1 type1">
	            	<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1">${requestZvl.insttClNm }</a></div>
	            	<ul class="selectMenu" id="insttClCdList">
	            		<c:forEach var="list" items="${orgBoxClList }" varStatus="status">
							<li><a href="#" data-clcd="${list.code }" data-clnm="${list.codeNm }">${list.codeNm }</a></li>
						</c:forEach>
					</ul>
            	</div>
                
                <div class="box-select-ty1 type1 sec">
					<div class="selectVal insttSelectVal" tabindex="0"><a href="#this" tabindex="-1">${requestZvl.insttNm }</a></div>
					<ul class="selectMenu insttSelectMenu" id="insttCdList">
                       	<c:forEach var="list" items="${orgBoxList }" varStatus="status">
							<li><a href="#" data-cd="${list.insttCd }" data-nm="${list.insttNm }">${list.insttNm }</a></li>
						</c:forEach>
					</ul>
				</div>
				
				<div class="box-select-ty1 type1">
					<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1">${requestZvl.searchYyyy}</a></div>
					<ul class="selectMenu" id="yyyy">
						<c:forEach var="list" items="${yyyyList}"  varStatus="status">
							<li><a href="#" data-yyyy="${list.yyyy}">${list.yyyy}</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>

			<div class="layer-header1 clearfix">
				<div class="col-rgh">
					<span class="ico_state i_reg_comp"><em>등록완료</em></span>
					<span class="ico_state i_result_total"><em>최종결과</em></span>
					<span class="ico_state i_noreg"><em>미등록</em></span>
				</div>
			</div>
                
			<div class="wrap_table2">
			<table id="table-1" class="tbl">
				<caption>서면점검 실적등록 및 조회 상세</caption>
                    <colgroup>
						<col class="th1_5">
						<col>
						<col class="th1_4">
						<col class="th1_4">
						<col class="th1_5">
						<col class="th1_4">
						<col class="th1_4">
					</colgroup>
                    <thead>
						<tr>
							<th scope="col" id="th_a">월</th>
							<th scope="col" id="th_b">서면점검 항목</th>
							<th scope="col" id="th_c">실적제출 <br>다운로드</th>
							<th scope="col" id="th_d">등록일</th>
							<th scope="col" id="th_e">상태</th>
							<th scope="col" id="th_f">점검결과 통보</th>
							<th scope="col" id="th_g">점검완료</th>
						</tr>
					</thead>
                    <tbody>
                    	<c:forEach var="list" items="${resultList}" varStatus="status">
                        <tr>
                        <c:choose>
                    	<c:when test="${empty list.evalAtchmnflId}">
                            <th scope="col" id="a_a" class="bdl0"><fmt:formatNumber value="${list.mm}" /></th>
                            <th scope="col" id="a_a_1" class="ta-l">
                            	<span>${list.mngLevelCn}</span>
                            </th>
                            <c:choose>
                           		<c:when test="${empty list.status}"><!-- 미등록인 경우 -->
                           			<td></td>
			                      	<td>${list.registDt}</td>
                           			<td><span class="ico_state i_noreg"><em>미등록</em></span></td>
                               		<td></td>
                               	</c:when>
                               	<c:when test="${'RS03' eq list.status}"><!-- 등록완료인 경우 -->
                               		<td>
                               			<c:set var="fileId" value=""/>
		                                <c:forEach var="i" items="${fileList }" varStatus="status">
	                                    	<c:if test="${list.seq eq i.schdulSeq }">
	                                    		<c:set var="fileId" value="${fileId}|${i.fileId}"/>
	                                    	</c:if>
	                                    </c:forEach>
		                                <a href="#download" value="다운로드" class="btn-pk s blue2 rv" onClick="javascript:fnAttachmentApplyFileDown('${fileId}'); return false;"><span>다운로드</span></a>
                               		</td>
			                      	<td>${list.registDt}</td>
                               		<td><span class="ico_state i_reg_comp"><em>등록완료</em></span></td>
                               		<td>
                               			<div class="inp_file ty2">
		                                	<button type="button" id="btn_${list.seq}" onclick="fnAddAttachmentFile('${list.seq}','${list.evalAtchmnflId}','attachmentFile'); return false;" class="inp_file_btn"><span>파일첨부</span></button>
		                                	<!-- <input type="file" class="file_input_hidden"/> -->
										</div>
		                            </td>
                               	</c:when>
                               	<c:otherwise><!-- 최종결과인 경우 -->
                               		<td>
                               			<c:set var="fileId" value=""/>
		                                <c:forEach var="i" items="${fileList }" varStatus="status">
	                                    	<c:if test="${list.seq eq i.schdulSeq }">
	                                    		<c:set var="fileId" value="${fileId}|${i.fileId}"/>
	                                    	</c:if>
	                                    </c:forEach>
	                                    <c:if test="${!empty list.atchmnflId}">
		                                	<button type="button" value="다운로드" class="btn-pk s blue2 rv" onClick="javascript:fnAttachmentApplyFileDown('${fileId}'); return false;"><span>다운로드</span></button>
		                                </c:if>
                               		</td>
			                      	<td>${list.registDt}</td>
                               		<td><span class="ico_state i_result_total"><em>최종결과</em></span></td>
                           			<td>
                           				<c:if test="${!empty list.atchmnflId}">
                           					<div class="inp_file ty2">
											<button type="button" id="btn_${list.seq}" onclick="fnAddAttachmentFile('${list.seq}','${list.evalAtchmnflId}','attachmentFile'); return false;"class="inp_file_btn"><span>파일첨부</span></button>
											<!-- <input type="file" class="file_input_hidden"/> -->
											</div>
										</c:if>
		                            </td>
                               	</c:otherwise>
                           	</c:choose>
                           	<td>
                           		<c:choose>
                           			<c:when test="${empty list.status}">
                           				<button type="button" value="점검완료" class="btn-pk s green rv" onClick="javascript:fnEvalFil('${list.seq}', 'ES05', 'I', 'finish'); return false;">점검완료</button>
                           			</c:when>
                           			<c:when test="${'RS03' eq list.status}">
                           				<button type="button" value="점검완료" class="btn-pk s green rv" onClick="javascript:fnEvalFil('${list.seq}', 'ES05', 'U', 'finish'); return false;">점검완료</button>
                           			</c:when>
                           			<c:otherwise>
                           				<c:choose>
                           					<c:when test="${empty list.atchmnflId}">
                           						<button type="button" value="완료해제" class="btn-pk s gray3 rv" onClick="javascript:fnEvalFil('${list.seq}', '', 'D', 'cancel'); return false;">완료해제</button>
                           					</c:when>
                           					<c:otherwise>
                           						<button type="button" value="완료해제" class="btn-pk s gray3 rv" onClick="javascript:fnEvalFil('${list.seq}', 'RS03', 'U', 'cancel'); return false;">완료해제</button>
                           					</c:otherwise>
                           				</c:choose>
                           			</c:otherwise>
                           		</c:choose>
                           	</td>
                           	</c:when>
                           	<c:otherwise>
                           	<tr>
                            <th scope="col" rowspan="3" id="a_b" class="bdl0"><fmt:formatNumber value="${list.mm}" /></th>
                            <th scope="col" id="a_b_1" class="ta-l">
                            	<span>${list.mngLevelCn}</span>
                            </th>
                            <c:choose>
                           		<c:when test="${empty list.status}"><!-- 미등록인 경우 -->
                           			<td rowspan="3" ></td>
			                      	<td rowspan="3" >${list.registDt}</td>
                           			<td rowspan="3" ><span class="ico_state i_noreg"><em>미등록</em></span></td>
                               		<td rowspan="3" ></td>
                               	</c:when>
                               	<c:when test="${'RS03' eq list.status}"><!-- 등록완료인 경우 -->
                               		<td rowspan="3" >
                               			<c:set var="fileId" value=""/>
		                                <c:forEach var="i" items="${fileList }" varStatus="status">
	                                    	<c:if test="${list.seq eq i.schdulSeq }">
	                                    		<c:set var="fileId" value="${fileId}|${i.fileId}"/>
	                                    	</c:if>
	                                    </c:forEach>
		                                <a href="#download" value="다운로드" class="btn-pk s blue2 rv" onClick="javascript:fnAttachmentApplyFileDown('${fileId}'); return false;"><span>다운로드</span></a>
                               		</td>
			                      	<td rowspan="3" >${list.registDt}</td>
                               		<td rowspan="3" ><span class="ico_state i_reg_comp"><em>등록완료</em></span></td>
                               		<td rowspan="3" >
                               			<div class="inp_file ty2">
		                                	<button type="button" id="btn_${list.seq}" onclick="fnAddAttachmentFile('${list.seq}','${list.evalAtchmnflId}','attachmentFile'); return false;" class="inp_file_btn"><span>파일첨부</span></button>
		                                	<!-- <input type="file" class="file_input_hidden"/> -->
										</div>
		                            </td>
                               	</c:when>
                               	<c:otherwise><!-- 최종결과인 경우 -->
                               		<td rowspan="3" >
                               			<c:set var="fileId" value=""/>
		                                <c:forEach var="i" items="${fileList }" varStatus="status">
	                                    	<c:if test="${list.seq eq i.schdulSeq }">
	                                    		<c:set var="fileId" value="${fileId}|${i.fileId}"/>
	                                    	</c:if>
	                                    </c:forEach>
	                                    <c:if test="${!empty list.atchmnflId}">
		                                	<button type="button" value="다운로드" class="btn-pk s blue2 rv" onClick="javascript:fnAttachmentApplyFileDown('${fileId}'); return false;"><span>다운로드</span></button>
		                                </c:if>
                               		</td>
			                      	<td rowspan="3" >${list.registDt}</td>
                               		<td rowspan="3" ><span class="ico_state i_result_total"><em>최종결과</em></span></td>
                           			<td rowspan="3" >
                           				<c:if test="${!empty list.atchmnflId}">
	                           				<div class="inp_file ty2">
												<button type="button" id="btn_${list.seq}" onclick="fnAddAttachmentFile('${list.seq}','${list.evalAtchmnflId}','attachmentFile'); return false;" class="inp_file_btn"><span>파일첨부</span></button>
												<!-- <input type="file" class="file_input_hidden"/> -->
											</div>
										</c:if>
		                            </td>
                               	</c:otherwise>
                           	</c:choose>
                           	<td rowspan="3" >
                           		<c:choose>
                           			<c:when test="${empty list.status}">
                           				<button type="button" value="점검완료" class="btn-pk s green rv" onClick="javascript:fnEvalFil('${list.seq}', 'ES05', 'I', 'finish'); return false;">점검완료</button>
                           			</c:when>
                           			<c:when test="${'RS03' eq list.status}">
                           				<button type="button" value="점검완료" class="btn-pk s green rv" onClick="javascript:fnEvalFil('${list.seq}', 'ES05', 'U', 'finish'); return false;">점검완료</button>
                           			</c:when>
                           			<c:otherwise>
                           				<c:choose>
                           					<c:when test="${empty list.atchmnflId}">
                           						<button type="button" value="완료해제" class="btn-pk s gray3 rv" onClick="javascript:fnEvalFil('${list.seq}', '', 'D', 'cancel'); return false;">완료해제</button>
                           					</c:when>
                           					<c:otherwise>
                           						<button type="button" value="완료해제" class="btn-pk s gray3 rv" onClick="javascript:fnEvalFil('${list.seq}', 'RS03', 'U', 'cancel'); return false;">완료해제</button>
                           					</c:otherwise>
                           				</c:choose>
                           			</c:otherwise>
                           		</c:choose>
                           	</td>
						</tr>
                           		<tr>
									<td headers="th_b a_b a_b_1" class="ta-l pd">
										<div class="lst_answer">
                           				<c:forEach var="i" items="${evalFileList }" varStatus="status">
                               				<c:if test="${list.seq eq i.schdulSeq }">
												<div class="${i.schdulSeq}">
													<input type="checkbox" id="${i.fileId }" name="chkAttachmentFile_${i.schdulSeq }" class="ickjs" seq="${i.schdulSeq}"/>
													<label for="${i.fileId }"><span class="i-aft i_${i.fileExtsn } link" onClick="javascript:fnAttachmentFileDown('${list.seq}','${i.fileId }'); return false;">${i.fileName }</span></label>
												</div>
												<script>
					                                var fileInfo = new Object();
					                                fileInfo.idx			= '${i.schdulSeq}';
					                                fileInfo.atchmnflId		= '${i.atchmnflId}';
					                                fileInfo.fileId			= '${i.fileId}';
					                                fileInfo.fileName		= '${i.fileName}';
					                                fileInfo.saveFileName	= '${i.saveFileName}';
					                                fileInfo.filePath		= '${i.filePath}';
					                                fileInfo.mimeType		= '${i.mimeType}';
					                                fileInfo.isDeleted		= 'false';
					                                fileInfo.modifiedFileId	= '${i.fileId}';
					                                fileInfo.fileUrl	= ""; // 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
					                                attachmentFileArray.push( fileInfo );
				                                </script>
											</c:if>
										</c:forEach>
										</div>
									</td>
								</tr>
								<tr>
									<td class="ta-l pd2 td_log">
										<input type="checkbox" id="chkAttachmentFile_${list.seq}all" value="" onClick="javascript:fnCheckAttachmentFile('${list.seq}');" class="ickjs allChk" seq="${list.seq}" >
										<label for="chkAttachmentFile_${list.seq}all">전체선택</label>
										
										<div class="fl-r">
											<c:if test="${'RS03' eq list.status}">
												<button type="button" class="btn-pk ss black" onClick="javascript:fnDeleteAttachmentFile('${list.seq}','','attachmentFile'); return false;"><span>파일삭제</span></button>
											</c:if>
											<a href="#download"  class="btn-pk ss gray2 rv" onClick="javascript:fnAttachmentFileDown('${list.seq}',''); return false;"><span>다운로드</span></a>
										</div>
									</td>
								</tr>
                           	</c:otherwise>
                          	</c:choose>
                          	</tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
             <div class="mt30 ta-c">
                <a href="#" class="btn-pk n black" onclick="goSummary(); return false;">전체현황</a>
            </div> 
        </div>
    </div>
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

<script>
$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square',
	radioClass: 'iradio_square'
});
</script>