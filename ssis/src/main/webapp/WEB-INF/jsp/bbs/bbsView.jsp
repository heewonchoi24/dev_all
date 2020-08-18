<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>.link{cursor: pointer;}</style>
<script>
var pUrl, pParam;
var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){

});

function moveBbs(seq, bbsCd) {
	$("#bbsSeq").val(seq);
	$("#bbsCd").val(bbsCd);
	$("#form").attr({
		method : "post",
		action : "/bbs/bbsView.do"
	}).submit();
}

function listThread() {
	$("#bbsSeq").val("");
	$("#form").attr({
		method : "post",
		action : "/bbs/bbsList.do"
	}).submit();
}

function fnAttachmentFileDown( index, atchmnflId ) {
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
    //
	var CD_DOWNLOAD_FILE_INFO = chkAttachmentFile;

	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
}

//메모 첨부파일
function fnCheckAttachmentMemoFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "]" ).prop( "checked", $( "#chkAttachmentFile_"+ index ).prop( "checked" ) );
}  

function fnAttachmentSingleFileDown(fileId) {

	var chkAttachmentFile = '';

	var fileInfo = new Object();
	fileInfo.fileId		= fileId;
	fileInfo.fileName	= fileId;
	fileInfo.fileSize	= "0";
	fileInfo.fileUrl	= "";
	
	chkAttachmentFile += JSON.stringify( fileInfo );
	
	chkAttachmentFile = "["+ chkAttachmentFile +"]";

	var CD_DOWNLOAD_FILE_INFO = chkAttachmentFile;

	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
}

function fnCheckAttachmentFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "]" ).prop( "checked", $( "#chkAttachmentFile_"+ index ).prop( "checked" ) );
}  


// 파일 업로드
function fnAddAttachmentFile(index, answerAtchmnflId, attachmentFile ) {
    
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
	
	$( "#uploadedFilesInfo" ).val( uploadedFilesInfo );
	$( "#modifiedFilesInfo" ).val( modifiedFilesInfo );
	
	pParam = {};
	pUrl = "/bbs/bbsAnswerFileInsert.do";
	
	pParam.bbsSeq = $("#bbsSeq").val();
	pParam.uploadedFilesInfo = uploadedFilesInfo;
	pParam.modifiedFilesInfo = modifiedFilesInfo;
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		// 업로드 성공 시 댓글 html 새로 추가
		$("#bbsSeq").val(data.bbsSeq);
		
		html = '';
		
		if(attachmentFileArray.length > 0){
		
			html += '<div class="item">';
			html += '		<div class="col-fl">';
			html += '			<p class="h1"><span class="link">' + data.insttNm + '</span></p>';
			html += '		</div>';
			html += '		<div class="col-fr">';
			html += '			<div class="rlink">';
			html += '				<span class="i-aft i_file1">첨부파일</span>';
			$.each(attachmentFileArray, function(i,v){
				html += '				<p><input type="checkbox" id="' + v.fileId + '" name="chkAttachmentFile_' + data.bbsSeq + '"/>';
				html += '				<a href="#" class="i-aft i_' + v.fileExtsn + ' link" onclick="fnAttachmentSingleFileDown(\'' + v.fileId + '\'); return false;">' + v.fileName + '</a></p>';
			});
			html += '			</div>';
			html += '			<p class="date">2020.11.09 23:35:56</p>';
			html += '			<div class="ta-l pd2 td_log">';
			html += '				<input type="checkbox" id="chkAttachmentFile_' + data.bbsSeq + '" value="" onClick="fnCheckAttachmentMemoFile(\'' + data.bbsSeq + '\');"class="ickjs" >';
			html += '				<label for="chkAttachmentFile_' + data.bbsSeq + '">전체선택</label>';
			html += '				<div class="fl-r">';
			html += '					<button type="button" value="파일삭제" class="btn-pk ss black" onClick="fnDeleteAttachmentFile(\'' + data.bbsSeq + '\',\'\',\'attachmentFile\'); return false;">파일삭제</button>';
			html += '					<button type="button" value="다운로드" class="btn-pk ss gray2 rv" onClick="fnAttachmentFileDown(\'' + data.bbsSeq + '\',\'\'); return false;">다운로드</button>';
			html += '				</div>';
			html += '			</div>';
			html += '		</div>';
			html += '</div>';
		}		
		$(".wrap-comment-ty1").html(html);
	}, function(jqXHR, textStatus, errorThrown){
		alert(data.message);
	});

}

function fnDeleteAttachmentFile(index, atchmnflId, attachmentFile ) {
	var deleteAttachmentFile = "";
	var chkAttachmentFile = "";
	
	$( "input:checkbox[name=chkAttachmentFile_" + index + "]" ).each( function() {
		if( $(this).prop( "checked" ) ) 
			chkAttachmentFile += "," + $(this).attr("id");
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

		var pUrl = "/bbs/bbsFileDelete.do";
 		var param = new Object();
		
 		param.atchmnflId = p_atchmnflId;
 		param.fileId = p_fileId;
 		param.filePath = p_filePath;
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
 			alert(data.message);
			
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});
	}
	return false;
}



</script>

<form action="/bbs/bbsView.do" method="post" id="form" name="form">
	<input type="hidden" name="bbsCd" id="bbsCd" value="${bbsCd }"/>
	<input type="hidden" name="category" id="category" value="${category }"/>
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="${bbsView.ATCHMNFL_ID }" > 
	<input type="hidden" id="bbsSeq" name="bbsSeq" value="${bbsSeq }" > 
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }"/>
	
	<!-- content -->
	<section id="container" class="sub">
		<div class="container_inner">
		
			<c:choose>
				<c:when test="${bbsCd == 'BN03' }">
					<!-- 질의응답 -->
					<section class="bbsView">
						<h2 class="tit">${bbsView.SUBJECT}</h2>
						<div class="wrap_table2">
							<div class="top">
								<p><span>작성일 : ${bbsView.REGIST_DT}</span><span>작성자 : ${bbsView.REGIST_ID}</span></p>
							</div>
							<div class="cont">
								<c:if test="${!empty bbsAttachFileList }">
									<div class="rlink">
										<span class="i-aft i_file1">첨부파일 :</span>
										<c:forEach var="i" items="${bbsAttachFileList }" varStatus="status">
											<%-- <p><a href="#" onclick="fnAttachmentSingleFileDown('${i.FILE_ID}'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">${i.FILE_NAME }</a></p> --%>
											<p><span class="i-aft i_${i.fileExtsn} link" onclick="fnAttachmentSingleFileDown('${i.FILE_ID}'); return false;">${i.FILE_NAME}</span></p>
											<script>
												var fileInfo = new Object();
												fileInfo.idx			= '${i.SEQ}';
												fileInfo.atchmnflId	 = '${i.ATCHMNFL_ID}';
												fileInfo.fileId		 = '${i.FILE_ID}';
												fileInfo.fileName	   = '${i.FILE_NAME}';
												fileInfo.saveFileName   = '${i.SAVE_FILE_NAME}';
												fileInfo.filePath	   = '${i.FILE_PATH}';
												fileInfo.mimeType	   = '${i.MIME_TYPE}';
												fileInfo.isDeleted	  = 'false';
												fileInfo.modifiedFileId = '${i.FILE_ID}';
												fileInfo.fileUrl	= ""; // 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
												attachmentFileArray.push( fileInfo );
											</script>
										</c:forEach>
									</div>
								</c:if>
							<div class="txt" style="margin-top: 30px;">${bbsView.CONTENTS}</div>
							</div>
							<c:if test="${!empty bbsView.ANSWER && !empty bbsView.ANSWER_ID && !empty bbsView.ANSWER_DT}">
								<div class="mb-c3">
									<div class="wrap_table2">
										<table id="table-1" class="tbl">
											<colgroup>
												<col class="th1_1">
												<col>
												<col class="th1_1">
												<col>
											</colgroup>
											<tbody>
												<tr>
													<th class="bg" scope="row">답변자</th>
													<td class="ta-1">${bbsView.ANSWER_ID}</td>
													<th class="bg" scope="row">답변일</th>
													<td class="ta-1">${bbsView.ANSWER_DT}</td>
												</tr>
												<tr>
													<th class="bg" scope="row">답변내용</th>
													<td colspan="4" class="ta-1">
														<div class="wrap-editor">${bbsView.ANSWER}</div>
													</td> 
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</c:if>
						</div>
						<div class="botm bdt">
							<p><span class="i-aft i_arr_t1">다음글</span>
								<span>
									<c:choose>
										<c:when test="${bbsNext.SUBJECT == null || bbsNext.SUBJECT == '' }">다음 글이 없습니다.</c:when>
										<c:otherwise>
											<a href="#" onclick="moveBbs('${bbsNext.SEQ}', '${bbsNext.BBS_CD}')">${bbsNext.SUBJECT }</a>
										</c:otherwise>
									</c:choose>
								</span>
							</p>
							<p><span class="i-aft i_arr_b1">이전글</span>
								<span>
									<c:choose>
										<c:when test="${bbsPrev.SUBJECT == null || bbsPrev.SUBJECT == '' }">이전 글이 없습니다.</c:when>
										<c:otherwise>
											<a href="#" onclick="moveBbs('${bbsPrev.SEQ}', '${bbsPrev.BBS_CD}')">${bbsPrev.SUBJECT }</a>
										</c:otherwise>
									</c:choose>
								</span>
							</p>
						</div>
					</section>
				</c:when>
				
				<c:otherwise>
					<!-- 기본 게시판 -->
					<section class="bbsView">
						<h2 class="tit"><c:if test="${bbsCd == 'BN01' && bbsView.HEAD_CATEGORY_TEXT != '' }">[${bbsView.HEAD_CATEGORY_TEXT }] </c:if>${bbsView.SUBJECT }</h2>
						<div class="wrap_table2">
							<div class="top">
								<p><span>작성일 : ${bbsView.REGIST_DT }</span><span>작성자 : ${bbsView.REGIST_NM }</span><c:if test="${bbsCd == 'BN05'}"><span>출처 : ${bbsView.SOURCE }</span></c:if></p>
							</div>
							<div class="cont">
								<div class="rlink">
									<c:if test="${!empty bbsAttachFileList }">
										<span class="i-aft i_file1">첨부파일: </span>
											<c:forEach var="i" items="${bbsAttachFileList }" varStatus="status">
												<p><span class="i-aft i_${i.fileExtsn} link" onclick="fnAttachmentSingleFileDown('${i.FILE_ID}'); return false;">${i.FILE_NAME}</span></p>
												<script>
													var fileInfo = new Object();
													fileInfo.idx			= '${i.SEQ}';
													fileInfo.atchmnflId	 = '${i.ATCHMNFL_ID}';
													fileInfo.fileId		 = '${i.FILE_ID}';
													fileInfo.fileName	   = '${i.FILE_NAME}';
													fileInfo.saveFileName   = '${i.SAVE_FILE_NAME}';
													fileInfo.filePath	   = '${i.FILE_PATH}';
													fileInfo.mimeType	   = '${i.MIME_TYPE}';
													fileInfo.isDeleted	  = 'false';
													fileInfo.modifiedFileId = '${i.FILE_ID}';
													fileInfo.fileUrl	= ""; // 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
													attachmentFileArray.push( fileInfo );
												</script>
											</c:forEach>
									</c:if>
								</div>
								<div class="txt">${bbsView.CONTENTS }</div>
							</div>
							<!-- 기관별 댓글 파일 업로드 기능 숨김
								<div class="wrap-comment-ty1">
									<c:if test="${!empty bbsAnswerFileList }">
										<c:forEach var="i" items="${bbsAnswerFileList }" varStatus="status">
											<c:if test="${i.INSTT_NM ne currentValue }">
												<c:choose>
													<c:when test="${i.INSTT_NM eq sessionScope.userInfo.insttNm }">
														<div class="item on">
															<div class="col-fl"><p class="h1"><span class="link">${i.INSTT_NM }</span></p></div>
															<div class="col-fr">
																<div class="rlink">
																	<span class="i-aft i_file1">첨부파일</span>
																	<c:forEach var="j" items="${bbsAnswerFileList }" varStatus="status">
																		<c:if test="${i.INSTT_NM eq j.INSTT_NM }">
																			<p><input type="checkbox" id="${j.FILE_ID }" name="chkAttachmentFile_${j.BBS_SEQ }" class="ickjs" />
																			<a href="#" class="i-aft i_${j.fileExtsn} link" onclick="fnAttachmentSingleFileDown('${j.FILE_ID}'); return false;">${j.FILE_NAME}</a></p>
																			<script>
																				var fileInfo = new Object();
																				fileInfo.idx			= '${i.BBS_SEQ}';
																				fileInfo.answerAtchmnflId	 = '${i.ANSWER_ATCHMNFL_ID}';
																				fileInfo.fileId		 = '${i.FILE_ID}';
																				fileInfo.fileName	   = '${i.FILE_NAME}';
																				fileInfo.saveFileName   = '${i.SAVE_FILE_NAME}';
																				fileInfo.filePath	   = '${i.FILE_PATH}';
																				fileInfo.mimeType	   = '${i.MIME_TYPE}';
																				fileInfo.isDeleted	  = 'false';
																				fileInfo.modifiedFileId = '${i.FILE_ID}';
																				fileInfo.fileUrl	= ""; // 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
																				attachmentFileArray.push( fileInfo );
																			</script>
																		</c:if>
																	</c:forEach>
																	<div class="ta-l pd2 td_log">
																		<input type="checkbox" id="chkAttachmentFile_${bbsSeq}" value="" onClick="fnCheckAttachmentMemoFile('${bbsSeq}');"class="ickjs" >
																		<label for="chkAttachmentFile_${bbsSeq}">전체선택</label>
																		<div class="fl-r">
																			<button type="button" value="파일삭제" class="btn-pk ss black" onClick="fnDeleteAttachmentFile('${bbsSeq}','','attachmentFile'); return false;">파일삭제</button>
																			<button type="button" value="다운로드" class="btn-pk ss gray2 rv" onClick="fnAttachmentFileDown('${bbsSeq}',''); return false;">다운로드</button>
																		</div>
																	</div>
															</div>
														</c:when>
														<c:otherwise>
														<div class="item">
															<div class="col-fl"><p class="h1">${i.INSTT_NM }</p></div>
															<div class="col-fr">
																<div class="rlink">
																	<span class="i-aft i_file1">첨부파일</span>
																	<c:forEach var="j" items="${bbsAnswerFileList }" varStatus="status">
																		<c:if test="${i.INSTT_NM eq j.INSTT_NM }">
																			<p><span class="i-aft i_hwp link none">${j.FILE_NAME}</span></p>
																		</c:if>
																	</c:forEach>
																</div>
														</c:otherwise>
														</c:choose>
														<p class="date">${i.REGIST_DT} </p>
															</div>
														</div>
													<c:set var="currentValue" value="${i.INSTT_NM }"/>
													</c:if>
												</c:forEach>
											</c:if>
											<div class="btn">
												<a href="#download" class="btn-pk s gray rv"><i class="icon-download22"></i>전체 기관 담당자 엑셀 다운로드</a>
												<a href="#download" class="btn-pk s gray rv" onclick="fnAddAttachmentFile('${bbsSeq}','${bbsView.ANSWER_ATCHMNFL_ID}','attachmentFile'); return false;">
												<i class="icon-upload22"></i>첨부파일 업로드</span></a>
											</div>
											-->
						</div>

						<div class="botm bdt">
							<p><span class="i-aft i_arr_t1">다음글</span>
								<span>
									<c:choose>
										<c:when test="${bbsNext.SUBJECT == null || bbsNext.SUBJECT == '' }">다음 글이 없습니다.</c:when>
										<c:otherwise>
											<a href="#" onclick="moveBbs('${bbsNext.SEQ}', '${bbsNext.BBS_CD}')">${bbsNext.SUBJECT }</a>
										</c:otherwise>
									</c:choose>
								</span>
							</p>
							<p><span class="i-aft i_arr_b1">이전글</span>
								<span>
									<c:choose>
										<c:when test="${bbsPrev.SUBJECT == null || bbsPrev.SUBJECT == '' }">이전 글이 없습니다.</c:when>
										<c:otherwise>
											<a href="#" onclick="moveBbs('${bbsPrev.SEQ}', '${bbsPrev.BBS_CD}')">${bbsPrev.SUBJECT }</a>
										</c:otherwise>
									</c:choose>
								</span>
							</p>
						</div>
				
					</section>
				</c:otherwise>
			</c:choose>
			<div class="btn-bot noline">
				<a href="#" class="btn-pk n black" onclick="listThread(); return false;"><span>목록보기</span></a>
			</div>
			
       </div><!-- //container_inner -->
	</section><!-- //container_main -->
</form>

<!--  파일 업로드에 사용 -->
<input type="hidden" id="answerAtchmnflId" name="answerAtchmnflId" value="${bbsView.ANSWER_ATCHMNFL_ID }" > 
<input type="hidden" id="bbsSeq" name="bbsSeq" value="${bbsSeq }" > 
<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
<!--  파일 업로드에 사용 -->  

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
<!--  파일 다운로드에 사용 --> 

<script>
$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square',
	radioClass: 'iradio_square'
});
</script>