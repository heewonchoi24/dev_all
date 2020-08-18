<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	// 체크박스 전체 클릭 시
	$(".ickjs.allChk").on('ifChanged', function(e){
		if( $(".ickjs.allChk").is(":checked")) $('input:checkbox[name*="chkAttachmentFile_"]').iCheck("check");
		else $('input:checkbox[name*="chkAttachmentFile_"]').iCheck("uncheck");
	});
});

function fn_goDtl() {
   	$("#resultForm").attr({
           action : "/statusExaminRst/statusExaminRstSummaryDtlList.do",
           method : "post"
       }).submit();
}

function fnAttachmentApplyFileDown( index, atchmnflId ) {
	
	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;
	
	var chkAttachmentFile = atchmnflId;
	// Check Box 선택 
	if( atchmnflId == "" ) {
		$( "input:checkbox[name=chkAttachmentFile_" + index + "_apply]" ).each( function() {
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
		//
		var fileInfo = new Object();
		fileInfo.fileId		= fileId;
		fileInfo.fileName	= fileId;
		fileInfo.fileSize	= "0";
		fileInfo.fileUrl	= "";
		//
		chkAttachmentFile += JSON.stringify( fileInfo );		
	}	
	chkAttachmentFile = "["+ chkAttachmentFile +"]";    
    //
	var CD_DOWNLOAD_FILE_INFO = chkAttachmentFile;
	//
	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
}

function fnAttachmentMemoFileDown( index, atchmnflId ) {
	
	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;
	
	var chkAttachmentFile = atchmnflId;
	// Check Box 선택 
	if( atchmnflId == "" ) {
		$( "input:checkbox[name=chkAttachmentFile_" + index + "_memo]" ).each( function() {
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
		//
		var fileInfo = new Object();
		fileInfo.fileId		= fileId;
		fileInfo.fileName	= fileId;
		fileInfo.fileSize	= "0";
		fileInfo.fileUrl	= "";
		//
		chkAttachmentFile += JSON.stringify( fileInfo );		
	}	
	chkAttachmentFile = "["+ chkAttachmentFile +"]";    
    //
	var CD_DOWNLOAD_FILE_INFO = chkAttachmentFile;
	//
	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
}

function fnAttachmentFobjctFileDown( index, atchmnflId ) {
	
	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;
	
	var chkAttachmentFile = atchmnflId;
	// Check Box 선택 
	if( atchmnflId == "" ) {
		$( "input:checkbox[name=chkAttachmentFile_" + index + "_fobjct]" ).each( function() {
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
		//
		var fileInfo = new Object();
		fileInfo.fileId		= fileId;
		fileInfo.fileName	= fileId;
		fileInfo.fileSize	= "0";
		fileInfo.fileUrl	= "";
		//
		chkAttachmentFile += JSON.stringify( fileInfo );		
	}	
	chkAttachmentFile = "["+ chkAttachmentFile +"]";    
    //
	var CD_DOWNLOAD_FILE_INFO = chkAttachmentFile;
	//
	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
}

function fnAddAttachmentFile(index, atchmnflId, attachmentFile ) {
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;
	
    $( "#atchmnfl_id").val(atchmnflId);
    $( "#indexSeq").val(index);
    
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
	//
	$( "#uploadedFilesInfo" ).val( uploadedFilesInfo );
	$( "#modifiedFilesInfo" ).val( modifiedFilesInfo );
	
	pParam = {};
	pUrl = "/statusExaminRst/updateStatusExaminRstFobjctFile.do";

	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.uploadedFilesInfo = uploadedFilesInfo;
	pParam.modifiedFilesInfo = modifiedFilesInfo;
	
	pParam.insttCd = $("#insttCd").val();
	pParam.indexSeq = $("#indexSeq").val();
	pParam.fobjctResn = $("#fobjctResn").val();

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		//alert(data.message);
		$("#resultForm").attr({
            action : "/statusExaminRst/statusExaminRstDtl.do",
            method : "post"
        }).submit();
	}, function(jqXHR, textStatus, errorThrown){
			
	});
}

function fnDeleteAttachmentFile(index, atchmnflId, attachmentFile ) {
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;
	
	var deleteAttachmentFile = "";
	var chkAttachmentFile = "";
	
	$( "input:checkbox[name=chkAttachmentFile_" + index + "_fobjct]" ).each( function() {
		if( $(this).prop( "checked" ) ) 
			chkAttachmentFile += "," + $(this).attr("id");
	});
	
	if( chkAttachmentFile == "" ){
		alert('삭제 파일을 선택해 주세요');
		return;
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

		var pUrl = "/statusExaminRst/deleteStatusExaminRstFobjct.do";
 		var param = new Object();
		
 		param.atchmnfl_id = p_atchmnflId;
 		param.file_id = p_fileId;
 		param.filePath = p_filePath;
 		param.indexSeq = index;
 		param.insttCd = $("#insttCd").val();
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
 			alert(data.message);
 			$("#resultForm").attr({
	            action : "/statusExaminRst/statusExaminRstDtl.do",
	            method : "post"
	        }).submit();
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});
	}
	return;
}

function fn_save() {
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;
	
	var pUrl = "/statusExaminRst/updateStatusExaminRstFobjct.do";
	
	var param = new Object();
	
	param.insttCd = $("#insttCd").val();
	param.indexSeq = $("#indexSeq").val();
	param.fobjctResn = $("#fobjctResn").val();
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		
		alert(data.message);
		
		$("#resultForm").attr({
            action : "/statusExaminRst/statusExaminRstDtl.do",
            method : "post"
        }).submit();
		
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}
</script>

<form action="/statusExaminRst/statusExaminRstDtl.do" method="post" id="resultForm" name="resultForm">
	
	<input name="orderNo" id="orderNo" type="hidden" value="${requestZvl.orderNo}"/>
	<input name="insttCd" id="insttCd" type="hidden" value="${requestZvl.insttCd}"/>
	<input name="insttNm" id="insttNm" type="hidden" value="${requestZvl.insttNm}"/>
	<input name="indexSeq" id="indexSeq" type="hidden" value="${result.indexSeq}"/>
	
	<!--  파일 업로드에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="${result.indexSeq }" > 
	<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
	<!--  파일 업로드에 사용 -->
	
	<section id="container" class="sub">
       <div class="container_inner">
       
       
            <h1 class="title2 mb-c3">${requestZvl.orderNo }년 ${requestZvl.insttNm } <span class="fc_blue">점검결과 상세정보</span></h1>
            
            <h1 class="title4">점검 결과</h1>
            
            <div class="wrap_table2 mb-c1">
                <table id="table-1" class="tbl" summary="대분류, 중분류, 소분류, 점검지표, 점검결과-환산점수, 점검수준으로 구성된 점검결과 리스트입니다.">
                    <caption>점검결과 리스트</caption>
                    <colgroup>
                        <col style="width:10%">
                        <col style="width:20%">
                        <col style="width:auto">
                        <c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
							<c:forEach var="list" items="${scoreSeList}" varStatus="status">
	                        	<col style="width:5%">
		                  	</c:forEach>
		               	</c:if>
                        <col style="width:10%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2" scope="col">대분류</th>
                            <th rowspan="2" scope="col">중분류</th>
                            <th rowspan="2" scope="col">점검지표</th>
                            <c:choose>
                            	<c:when test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
                            		<th colspan="${fn:length(scoreSeList)}" scope="colgroup">점검결과</th>
                            		<th rowspan="2" scope="col">환산<br />점수</th>
                            	</c:when>
                            	<c:otherwise>
                            		<th rowspan="2" scope="col">점검<br />수준</th>
                            	</c:otherwise>
                            </c:choose>
                        </tr>
                        <c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
                        	<tr>
                        		<c:forEach var="list" items="${scoreSeList}" varStatus="status">
                        			<th scope="col">${list.scoreSeNm}</th>
	                        	</c:forEach>
                        	</tr>
                        </c:if>
                    </thead>
                    <tbody>
						<c:set var="rowCnt" value=""/>
						<c:if test="${'2' ne sessionScope.userInfo.authorId}">
							<c:choose>
								<c:when test="${1 eq fn:length(resultDtlList)}">
									<c:set var="rowCnt" value="rowspan='2'"/>
								</c:when>
								<c:otherwise>
									<c:set var="rowCnt" value="rowspan='${fn:length(resultDtlList)}'"/>
								</c:otherwise>
							</c:choose>
						</c:if>
                        <tr>
                            <td rowspan="${rowCnt}" scope="rowgroup"  class="bdl0">${result.lclas}</td>
                            <td rowspan="${rowCnt}">${result.mlsfc}</td>
                            <td class="option_area" class="ta-l bg_orange">
                                <span>${result.checkItem}</span>
                                <!-- 2017.09.27 전체 파일 다운로드로 변경 하고 추후 관리수준 현황조사 지표 생성 시 1 : 1로 매핑 되면 사용될 수 있음
                                <div class="option">
                                    <ul class="file_list">
                                    	<c:forEach var="i" items="${resultFile }" varStatus="status">
                                    		<li>
                                    			<input type="checkbox" id="${i.fileId }" name="chkAttachmentFile_${i.indexSeq }_apply"/>
                                    			<label for="${i.fileId }"><a href="#" onClick="javascript:fnAttachmentApplyFileDown('${result.indexSeq}','${i.fileId }'); return false;" class="f_hwp">${i.fileName }</a></label>
                                    		</li>
                                    	</c:forEach>
                                    </ul>
                                    <div class="file_control">
                                        <input type="checkbox" id="chkAttachmentFile_${result.indexSeq}_apply" value="" onClick="javascript:fnCheckAttachmentApplyFile('${result.indexSeq}');">
                                        <label for="label4">전체선택</label>
                                        <div class="control">
											<button type="button" value="다운로드" class="button bt2 small" onClick="javascript:fnAttachmentApplyFileDown('${result.indexSeq}',''); return false;">다운로드</button>
                                        </div>
                                    </div>
                                </div>
                                -->
                            </td>
                            <c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
                               	<c:forEach var="scoreSeList" items="${scoreSeList}">
                               		<c:set var="scoreCnt" value="0"/>
                               		<c:forEach var="resultDtlList" items="${resultDtlList}">
                               			<c:if test="${scoreSeList.scoreSeNm eq resultDtlList.resultScore2}">
                               				<c:set var="scoreCnt" value="${scoreCnt + 1}"/>
                               			</c:if>
                               		</c:forEach>
                               		<td>${scoreCnt}</td>
                               	</c:forEach>
                          	</c:if>
                          	<c:choose>
                               	<c:when test="${'A' eq evalType}">
                               		<td>${result.resultScore2}</td>
                               	</c:when>
                               	<c:when test="${'2' ne sessionScope.userInfo.authorId}">
                               		<td>${result.resultScore2}</td>
                               	</c:when>
                               	<c:otherwise>
                               		<c:choose>
                               			<c:when test="${!empty result.resultScore2}">
	                                		<c:set var="scoreScoreCnt" value="0"/>
	                                		<c:forEach var="sctnScoreList" items="${sctnScoreList}" varStatus="status1">
	                                			<fmt:parseNumber value="${sctnScoreList.sctnScore}" var="score"/>
	                                			<fmt:parseNumber value="${result.resultScore2}" var="resultScore"/>
	                                			<c:if test="${score < resultScore and scoreScoreCnt eq '0'}">
	                                				<td>${sctnScoreList.sctnNm}</td>
	                                				<c:set var="scoreScoreCnt" value="1"/>
	                                			</c:if>
	                                			<c:if test="${status1.last and scoreScoreCnt eq '0'}">
	                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
	                                			</c:if>
	                                		</c:forEach>
	                                	</c:when>
	                                	<c:otherwise>
	                                		<td>-</td>
	                                	</c:otherwise>
	                                </c:choose>
                               	</c:otherwise>
                        	</c:choose>
                        </tr>
                        <c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
	                        <tr>
								<c:forEach var="resultDtlList" items="${resultDtlList}" varStatus="status1">
									<td colspan="${fn:length(scoreSeList)-1}" class="bdl0">${resultDtlList.checkItem}</td>
										<c:forEach var="scoreSeList" items="${scoreSeList}" varStatus="status2">
											<c:choose>
												<c:when test="${resultDtlList.resultScore2 eq scoreSeList.scoreSeNm}">
													<td>○</td>
												</c:when>
												<c:otherwise>
													<td></td>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									<td></td>
								</c:forEach>                                        
	                        </tr>
	                	</c:if>
	                	
	                	<tr>
	                		<th scope="col" class="bdl0" >평가 의견</th>
	                		<td colspan="${fn:length(scoreSeList)+3}" class="ta-l">${result.evlOpinion}</td>
	                	</tr>
	                	<c:if test="${sessionScope.userInfo.authorId ne '2'}">
		                	<tr>
		                		<th scope="col" class="bdl0" >메모</th>
		                		<td colspan="${fn:length(scoreSeList)+3}" class="ta-l"><span>${result.memo}</span></td>
		                	</tr>
	                	</c:if>
	                	<!-- 첨부파일이 있을 경우 -->
						<c:if test="${!empty memoFile }">
		                	<tr>
		                		<th scope="col" class="bdl0" >메모 첨부파일</th>
		                		<td colspan="${fn:length(scoreSeList)+3}" class="ta-l">
									<div class="lst_answer solo">
										<c:forEach var="i" items="${memoFile }" varStatus="status">
										<div id="fileChkBox">
											<input type="checkbox" class="ickjs" id="${i.fileId }" index="${i.fileId}" name="chkAttachmentFile_${i.indexSeq }_memo" />
											<label for="${i.fileId }"><a href="#" onClick="javascript:fnAttachmentMemoFileDown('${result.indexSeq}','${i.fileId }'); return false;" class="f_<c:out value='${i.fileExtsn}'/>"><span class="i-aft i_${i.fileExtsn} link">${i.fileName }</a></label>
										</div>
				                       	</c:forEach>
				                    </div>
									<div class="lst_all_chk solo">
										<input type="checkbox" class="ickjs allChk" index="allChk" id="chkAttachmentFile_${result.indexSeq}_memo" value="" style="position: absolute; opacity: 0; z-index: -1;">
										<label for="label4">전체선택</label>
										<button type="button" value="다운로드" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentMemoFileDown('${result.indexSeq}',''); return false;">다운로드</button>
				                    </div>
								</td>
		                	</tr>
						</c:if>
                    </tbody>
                </table>
            </div>
			 <!-- /첨부파일이 있을 경우 -->
            
            <div class="btn-bot noline ta-c">
            	<c:if test="${'2' eq sessionScope.userInfo.authorId  and 'E' eq requestZvl.periodCd}">
					<a href="#" onclick="fn_save(); return false;" class="btn-pk n purple rv">저장</a>
				</c:if>
                <a href="#" onclick="fn_goDtl(); return false;" class="btn-pk n black">목록</a>
            </div>
		</div>
    <!-- /content -->
    </section>
</form>

<!--  파일 다운로드에 사용 -->  
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
