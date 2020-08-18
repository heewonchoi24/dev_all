<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="ckeditor" uri="http://ckeditor.com" %> --%>
<style>.btn.small {line-height: 0;} .ajax_file_upload{line-height: 0;} tbody td.option_area span { padding : 0; } .uploadFile .fileOpt .name {
    margin-left: 0;
}</style>
<script src="/js/jquery.form.js" type="text/javascript"></script>
<script>
var pUrl, pParam;
var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	$("#listImg_1").on("click", function(){ $("#useYN").val('N'); });
	$("#listImg_2").on("click", function(){ $("#useYN").val('Y'); });

	$('[name*="chkAttachmentFile_"]').change(function() {
        if(!$(this).prop('checked')) 
        	$('#allChk').prop('checked', false);
    });
	
});

function fn_allChk(t){
	if($(t).prop('checked')){
        $('[name*="chkAttachmentFile_"]').prop('checked', true);
    }else{
        $('[name*="chkAttachmentFile_"]').prop('checked', false);
    }
}

function list(pageNo, cat) {
	if(cat){$("#category").val(cat);}
	$("#pageIndex").val(pageNo);
	
	// bbsSeq가 없을 때(새 글 등록 시) 이미지가 있을 시 지우고 리스트로 돌아감
	if( ($("#img_nm").val() != '' && $("#img_nm").val() != null) && $("#bbsSeq").val() == ''){
		pParam = {};
		pUrl = '/admin/notice/bbsImgFileDelete.do';
		
		pParam.bbsSeq = $("#bbsSeq").val();
		pParam.img_nm = $("#img_nm").val();
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
			$("#bbsSeq").val("");
			$("#form").attr({
		        method : "post",
		        action : "/admin/notice/mngNoticeDtlList.do"
			}).submit();
		}, function(jqXHR, textStatus, errorThrown){
			
		});
	} else {
		$("#form").attr({
	        method : "post",
	        action : "/admin/notice/mngNoticeDtlList.do"
		}).submit();
	}
}

function validate(){
	return true;
}

function fnAddAttachmentFile(index, atchmnflId, attachmentFile ) {
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
	
	$( "#uploadedFilesInfo" ).val( uploadedFilesInfo );
	$( "#modifiedFilesInfo" ).val( modifiedFilesInfo );
	
	pParam = {};
	pUrl = "/notice/noticeFileUpdate.do";
	
	pParam.bbsCd = $("#bbsCd").val();
	pParam.bbsNm = $("#bbsNm").val();
	pParam.bbsSeq = $("#bbsSeq").val();
	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	
	pParam.uploadedFilesInfo = uploadedFilesInfo;
	pParam.modifiedFilesInfo = modifiedFilesInfo;
	
	if(pParam.atchmnfl_id == "") {
		pUrl = "/notice/noticeFileInsert.do";
	}
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		$("#bbsSeq").val(data.bbsSeq);
		$("#atchmnfl_id").val(data.atchmnfl_id);
		html = '';
		
		if(attachmentFileArray.length > 0){
			html += '<div class="uploadFile">';
			html += '		<button type="button" id="btn_' + data.bbsSeq + '"  class="btn black ajax_file_upload" onclick="fnAddAttachmentFile(\'' + data.bbsSeq + '\',\'' + data.atchmnfl_id + '\',\'attachmentFile\'); return false;">파일첨부</button>';
			html += '		<ul class="fileList">';
			$.each(attachmentFileArray, function(i,v){
				html += '		<li class="file">';
				html += '			<input type="checkbox" id="' + v.fileId + '" name="chkAttachmentFile_' + data.bbsSeq + '" class="custom" />';
				html += '			<label for="' + v.fileId + '" class="text-none">';
				html += '				<a href="#" onclick="fnAttachmentSingleFileDown(\'' + v.fileId + '\'); return false;" class="f_' + v.fileExtsn + '">';
				html += '				<span class="name">' + v.fileName + '</span></a>';
				html += '			</label>';
				html += '		</li>';
			});
			html += '		</ul>';
			html += '		<div class="fileOpt">';
			html += '			<div class="allChk">';
			html += '				<input type="checkbox" id="allChk" class="custom" onClick="fn_allChk(this);">';
			html += '				<label for="allChk" class="text-none"></label><span class="name">전체선택</span>';
			html += '			</div>';
			html += '			<div class="btns">';
			html += '				<button type="button" value="파일삭제" class="btn small red" onClick="javascript:fnDeleteAttachmentFile(\'' + data.bbsSeq + '\', \'\', \'attachmentFile\'); return false;">파일삭제</button>';
			html += '				<button type="button" value="다운로드" class="btn small blue" onClick="javascript:fnAttachmentFileDown(\'' + data.bbsSeq + '\', \'\'); return false;">다운로드</button>';
			html += '			</div>';
			html += '		</div>';
			html += '</div>';
		}
		$("#fileArea").html(html);
		//alert(data.message);
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}


function fnDeleteAttachmentFile(index, atchmnflId, attachmentFile ) {
	var deleteAttachmentFile = "";
	var chkAttachmentFile = "";
	$( "input:checkbox[name=chkAttachmentFile_" + index + "]" ).each( function() {
		if( $(this).prop( "checked" ) ) 
			chkAttachmentFile += "," + $(this).attr("id");
	});

	if( chkAttachmentFile == "" ){
		return;
	}
		
	var p_atchmnflId =  [];
    var p_fileId =  [];
    var p_filePath =  [];
    var p_cnt= 0;
    var p_key =  [];
    
	if (confirm("삭제하시겠습니까?")) {
	 	$.each( attachmentFileArray, function( key, value ) {
			if( chkAttachmentFile.indexOf( value.fileId  ) > 0 ) {
				p_atchmnflId[p_cnt]	= value.atchmnflId;
				p_fileId[p_cnt]		= value.fileId;
				p_filePath[p_cnt]	= value.filePath + "/" + value.saveFileName;
				p_key[p_cnt]        = key;
				p_cnt++;

			}
		});	
	
	 	var tmpFileArray = [];
		$.each( attachmentFileArray, function( key, value ) {
			var isDel = false;
			for(var i = 0 ; i  < p_key.length ; i++) {
				if( key == p_key[i] ) {
					isDel = true;
				}
			}
			if( isDel == false ) {
				tmpFileArray.push( value );
			}
		});
		attachmentFileArray = tmpFileArray;
		
		var pUrl = "/notice/noticeFileDelete.do";
 		var param = new Object();
		
 		
 		param.atchmnfl_id = p_atchmnflId;
 		param.file_id = p_fileId;
 		param.filePath = p_filePath;
 		param.bbsSeq = index;
 		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			$("#bbsSeq").val(data.bbsSeq);
			$("#atchmnfl_id").val(data.atchmnfl_id);
			html = '';
			
			if(tmpFileArray.length > 0){
				
				html += '<div class="uploadFile">';
				html += '		<button type="button" id="btn_' + data.bbsSeq + '"  class="btn black ajax_file_upload" onclick="fnAddAttachmentFile(\'' + data.bbsSeq + '\',\'' + data.atchmnfl_id + '\',\'attachmentFile\'); return false;">파일첨부</button>';
				html += '		<ul class="fileList">';
				$.each(tmpFileArray, function(i,v){
					html += '		<li class="file">';
					html += '			<input type="checkbox" id="' + v.fileId + '" name="chkAttachmentFile_' + data.bbsSeq + '" class="custom" />';
					html += '			<label for="' + v.fileId + '" class="text-none">';
					html += '				<a href="#" onclick="fnAttachmentSingleFileDown(\'' + v.fileId + '\'); return false;" class="f_' + v.fileExtsn + '">';
					html += '				<span class="name">' + v.fileName + '</span></a>';
					html += '			</label>';
					html += '		</li>';
				});
				html += '		</ul>';
				html += '		<div class="fileOpt">';
				html += '			<div class="allChk">';
				html += '				<input type="checkbox" id="allChk" class="custom" onClick="fn_allChk(this);">';
				html += '				<label for="allChk" class="text-none"></label><span class="name">전체선택</span>';
				html += '			</div>';
				html += '			<div class="btns">';
				html += '				<button type="button" value="파일삭제" class="btn small red" onClick="javascript:fnDeleteAttachmentFile(\'' + data.bbsSeq + '\', \'\', \'attachmentFile\'); return false;">파일삭제</button>';
				html += '				<button type="button" value="다운로드" class="btn small blue" onClick="javascript:fnAttachmentFileDown(\'' + data.bbsSeq + '\', \'\'); return false;">다운로드</button>';
				html += '			</div>';
				html += '		</div>';
				html += '</div>';
			}else if(tmpFileArray.length == 0){
				html += '<div class="uploadFile">';
				html += '		<button type="button" id="btn_' + data.bbsSeq + '"  class="btn black ajax_file_upload" onclick="fnAddAttachmentFile(\'' + data.bbsSeq + '\',\'' + data.atchmnfl_id + '\',\'attachmentFile\'); return false;">파일첨부</button>';
				html += '</div>';
				
				$("#atchmnfl_id").val('');
			}
			$("#fileArea").html(html);
			alert(data.message);
		}, function(jqXHR, textStatus, errorThrown){
			
		});
	}
} 

function fnAttachmentResultReportFileDown(fileId) {

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

function regist(){
	if(!$("#subject").val()){alert("제목은 필수 입력 사항입니다."); return;}
	
	if($("#bbsCd").val() == 'BN05'){
		if(!$("#source").val()){alert("출처는 필수 입력 사항입니다."); return;}
	}	
	if($("#bbsCd").val() == 'BN01'){
		if(!$("#headCategoryText").val()){alert("분류는 필수 입력 사항입니다."); return;}
	}
	
	if($("#listImg_2").prop('checked') == true) $("#useYN").val("Y");
	else $("#useYN").val("N");
	if(!$("#useYN").val()){alert("게시물 목록이미지 선택은 필수 사항 입니다."); return;}
	
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	var conVal = $("#contents").val().replace(/<p>|<\/p>|<br>|\s|&nbsp;/gi, "");
	if(conVal == null || conVal == ''){
		alert("내용은 필수입력 사항입니다."); 
		oEditors.getById["contents"].exec("FOCUS");
		return; 
	}
	pParam = {};
	pUrl = '/admin/notice/noticeRegistThread.do';
	
	pParam.bbsSeq = $("#bbsSeq").val();
	pParam.bbsCd = $("#bbsCd").val();
	pParam.subject = $("#subject").val();
	pParam.headCategoryText = $("#headCategoryText").val();
	if($("#bbsCd").val() == 'BN02'){
		pParam.answer = $("#contents").val();
	} else {
		pParam.contents = $("#contents").val();
	}

	if($("#bbsCd").val() == 'BN01'){
		if($("#workNotice").prop('checked') == true){
			pParam.category = $("#workNotice").val();
		}
	}
	if($("#bbsCd").val() == 'BN05'){
		pParam.source = $("#source").val();
	}	
	
	if($("#bbsCd").val() == 'BN04' || $("#bbsCd").val() == 'BN02'){
		pParam.category = $("input[name=categoryList]:checked").val();
	}
	pParam.uploadedFilesInfo = $( "#uploadedFilesInfo" ).val();
	pParam.modifiedFilesInfo = $( "#modifiedFilesInfo" ).val();
	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.img_nm = $("#img_nm").val();
	pParam.useYN = $("#useYN").val();
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		alert("등록이 완료되었습니다. 목록으로 이동합니다.");
		$("#bbsSeq").val("");
		$("#form").attr({
			method : "post",
			action : "/admin/notice/mngNoticeDtlList.do"
		}).submit();
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}

function answer(){
	
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	var conVal = $("#contents").val().replace(/<p>|<\/p>|<br>|\s|&nbsp;/gi, "");
	if(conVal == null || conVal == ''){
		alert("내용은 필수입력 사항입니다."); 
		oEditors.getById["contents"].exec("FOCUS");
		return;
	}
	
	pParam = {};
	pUrl = '/notice/noticeRegistThreadAnswer.do';
	
	pParam.bbsSeq = $("#bbsSeq").val();
	pParam.answer = $("#contents").val();
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		alert("등록이 완료되었습니다. 목록으로 이동합니다.");
		$("#bbsSeq").val("");
		$("#form").attr({
			method : "post",
			action : "/admin/notice/mngNoticeDtlList.do"
		}).submit();
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}

function handleImgFileSelect(e){
	var filesArr = Array.prototype.slice.call(e);
	
	filesArr.forEach(function(f){
		 if(!f.type.match("image.*")){
			alert("확장자는 이미지 확장자만 가능합니다.");
			return ;
		} 
		sel_file = f;
		
		var reader = new FileReader();
		reader.onload = function(e){
			$('.img.ajax_image_file').html(
					'<img src="' + e.target.result + '">');
			fn_imgInsert();
		}
		reader.readAsDataURL(f);
	});
	
}

function fn_imgInsert() {
	$("#form").attr( "action", "/admin/notice/listImgInsert.do");
	
	var options = {
			success : function(data) {
				$("#img_nm").val(data.img_nm);
				$("#listImg_2").prop('checked', true);
				$("#useYN").val("Y");
				
				alert(data.message);
			},
			type : "POST"
	};
	
	$("#form").ajaxSubmit(options);
}

function fn_imageDelete() {
	$('.img.ajax_image_file').html('');
	$('#img_nm').val('');
}

</script>

<form action="/admin/notice/noticeWrite.do" method="post" id="form" name="form" onsubmit="return validate();" enctype="multipart/form-data">
	<input type="hidden" name="bbsCd" id="bbsCd" value="${bbsCd }"/>
	<input type="hidden" name="bbsNm" id="bbsNm" value="${bbsNm }"/>
	<input type="hidden" name="category" id="category" value="${category }"/>
	<input type="hidden" name="isModify" id="isModify" value="${isModify }"/>
	<input type="hidden" name="useYN" id="useYN" value="N"/>
	
	<!--  파일 업로드에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="${bbsView.ATCHMNFL_ID }" > 
	<input type="hidden" id="img_nm" name="img_nm" value="${bbsView.IMG_NM }" > 
	<input type="hidden" id="bbsSeq" name="bbsSeq" value="${bbsSeq }" > 
	<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
	<!--  파일 업로드에 사용 -->  
	
	<div id="main">
	<c:choose>
		<c:when test="${bbsCd == 'BN03' }">	
			<!-- 질의응답의 경우 -->
				<!-- content -->
				<div class="group">
					<div class="header">
						<h3>질문내용</h3>
					</div>
					<div class="body">
						<table class="board_list_write">
							<tbody>
								<tr>
									<th>제목</th>
									<td title="제목">${bbsView.SUBJECT }</td>
								</tr>
								<tr>
									<th scope="row">작성자</th>
									<td>${bbsView.REGIST_NM }</td>
								</tr>
								<tr>
									<th scope="row">처리상태</th>
                           			<c:choose>
										<c:when test="${!empty bbsView.ANSWER_DT }">
											<td><span class="bbs stats1">답변완료</span></td>
										</c:when>
										<c:otherwise>
											<td><span class="bbs stats2">처리중</span></td>
										</c:otherwise>
									</c:choose>
								</tr>
								<tr>
									<th scope="row">작성일</th>
									<td>${bbsView.REGIST_DT }</td>
								</tr>
								<tr>
									<th scope="row">조회수</th>
									<td>${bbsView.READ_COUNT }</td>
								</tr>
								<tr>
									<th scope="row">첨부파일</th>
									<td colspan="3" id="fileArea" class="option_area">
										<c:if test="${!empty bbsAttachFileList }">
											<div class="uploadFile">
												<ul class="fileList">
													<c:forEach var="i" items="${bbsAttachFileList }" varStatus="status">
														<li class="file">
															<input type="checkbox" class="custom" id="${i.FILE_ID }" name="chkAttachmentFile_${i.SEQ }"/>
															<label for="${i.FILE_ID }" class="text-none">
																<a href="#" onclick="fnAttachmentSingleFileDown('${i.FILE_ID}'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">
																	<span class="name">${i.FILE_NAME }</span>
																</a>
															</label>
														</li>
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
												</ul>
												<div class="fileOpt">
													<div class="allChk">
														<%-- <input type="checkbox" class="custom" id="chkAttachmentFile_${bbsSeq}" value="" onClick="javascript:fnCheckAttachmentMemoFile('${bbsSeq}');"> --%>
														<input type="checkbox" class="custom" id="allChk" onClick="fn_allChk(this);">
														<label for="allChk" class="name">전체선택</label>
													</div>
													<div class="btns">
														<button type="button" value="다운로드" class="btn small blue" onClick="javascript:fnAttachmentFileDown('${bbsSeq}',''); return false;">다운로드</button>
													</div>
												</div>
											</div>
										</c:if>
									</td>
								</tr>
								<tr>
									<th scope="row" style="height:150px;">
										<label for="label2">내용</label>
									</th>
									<td>${bbsView.CONTENTS }</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
					<!-- content -->
				<div class="group">
					<div class="header">
						<h3>답변쓰기</h3>
					</div>
					<div class="body2">
                        <table class="board_list_write">
                            <tbody>
                                <tr>
                                    <th scope="row">답변자</th>
                                    <c:choose>
										<c:when test="${!empty bbsView.ANSWER_ID }">
											<td>${bbsView.ANSWER_NM }</td>
										</c:when>
										<c:otherwise>
											<td>${sessionScope.userInfo.userNm }</td>
										</c:otherwise>
									</c:choose>
								</tr>
								<tr>
                                    <th scope="row">답변일</th>
                                    <c:choose>
										<c:when test="${!empty bbsView.ANSWER_DT }">
											<td>${bbsView.ANSWER_DT }</td>
										</c:when>
										<c:otherwise>
											<c:set var="now" value="<%= new java.util.Date() %>" />
                                    		<td><fmt:formatDate pattern="yyyy.MM.dd" value="${now }"/></td>
										</c:otherwise>
									</c:choose>
                                </tr>
                                <tr>
                                    <th scope="row" class="req">답변내용</th>
                                    <td>
                                        <textarea name="contents" id="contents" class="ipt" style="width: 100%; height: 200px;" placeholder="내용" title="내용을 입력하세요.">
                                        	${bbsView.ANSWER }
                                        </textarea>                                        
                                    </td>
								</tr>                         
							</tbody>
						</table>
					</div>
				</div>
			</c:when>
					
			<c:otherwise>
				<!-- content -->
				<div class="group">
					<div class="header">
						<h3>${bbsNm } 등록/수정</h3>
					</div>
					<div class="body">
						<table class="board_list_write">
							<tbody>
								<c:if test="${bbsCd == 'BN01'}">
									<tr>
										<th class="req" scope="row">분류</th>
										<td>
											<input type="text" name="headCategoryText" id="headCategoryText" class="ipt" maxlength="80" value="${bbsView.HEAD_CATEGORY_TEXT }"/>
											<%-- <span>
												<input type="checkbox" id="workNotice" name="workNotice" class="custom" value="BC01"  <c:if test="${bbsView.CATEGORY != '' && bbsView.CATEGORY == 'BC01' }">checked</c:if>/>
												<label for="workNotice" class="text-none"> 작업공지</label>
											</span> --%>
										</td>
									</tr>
								</c:if>
								<tr>
									<th scope="row" class="req">제목</th>
									<td>
										<input type="text" name="subject" id="subject" class="ipt" style="width: 100%;" maxlength="100" value="${bbsView.SUBJECT }">
									</td>
								</tr>
								<c:if test="${bbsCd == 'BN05' }">
									<tr>
										<th scope="row" class="req">출처</th>
										<td>
											<input type="text" name="source" id="source" class="ipt" style="width: 100%;" maxlength="100" value="${bbsView.SOURCE}">
										</td>
									</tr>
								</c:if>
								<tr>
									<c:choose>
										<c:when test="${!empty bbsView.SEQ }">
												<th scope="row">작성자</th>
												<td>${bbsView.REGIST_NM }</td>
											</tr>
											<tr>
												<th scope="row">기관명</th>
												<td>${bbsView.INSTT_NM }</td>
											</tr>
										</c:when>
										<c:otherwise>
												<th scope="row">작성자</th>
												<td>${sessionScope.userInfo.userNm }</td>
											</tr>
											<tr>
												<th scope="row">기관명</th>
												<td>${sessionScope.userInfo.insttNm }</td>
											</tr>	
										</c:otherwise>
									</c:choose>
								<c:if test="${bbsCd == 'BN04' }">
									<tr>
										<th scope="row">카테고리</th>
										<td colspan="3">
											<c:forEach var="i" items="${resourceBbsCategoryList }" varStatus="status">
												<input type="radio" name="categoryList" id="category_${status.count }" class="custom" value="${i.CODE }" <c:if test="${bbsView.CATEGORY == i.CODE }">checked</c:if>><label for="category_${status.count }" class="mr15">${i.CODE_NM }</label>
											</c:forEach>
										</td>
									</tr>
								</c:if>
								
								<tr>
									<th class="req">목록 이미지<br/>[500 x 500]</th>
                       				<td>
	                       				<ul class="defaultImg" id="imgFileList">
			                                <li>
			                                    <div class="thumb" style="width: 300px;">
			                                        <div class="chk">
			                                            <input name="listImg" type="radio" id="listImg_1" class="custom" <c:if test="${imgList.USE_YN == 'N' or imgList.USE_YN == null}">checked="true"</c:if>>
			                                            <label for="listImg_1" class="text-none"></label>
			                                        </div>
			                                        <div class="img">
			                                        	<img src="/resources/admin/images/board/list_img_1.jpg" />
			                                        </div>
			                                    </div>
			                                </li>
			                            </ul>
										<div class="uploadImgFile" style="max-width: 300px;">
											<div class="chk">
			                                    <input name="listImg" type="radio" id="listImg_2" class="custom" <c:if test="${imgList.USE_YN == 'Y' }">checked="true"</c:if>>
			                                    <label for="listImg_2" class="text-none"></label>
			                                </div>
			                                <div class="thumb">
			                                	<div class="img ajax_image_file">
		                                			<c:if test="${(bbsSeq != null && bbsSeq != '') && (bbsSeq == imgList.BBS_SEQ && bbsView.IMG_NM != '') && imgList.IMG_NM != null }">
														<img id="thumb" src="${imgList.IMG_PATH }${imgList.IMG_NM}"/>
													</c:if>
			                                	</div>
			                                    <button type="button" class="btn_delete" onclick="fn_imageDelete();"></button>
			                                </div>
			                                <div class="ajax_image_upload">
												<div class="inp_file">
			                                        <button type="button" class="k-button k-primary k-upload-button ajax_image_upload2" style="position: absolute; right: 0;">파일찾기</button>
			                                        	<input type="file" class="imagefile file_input_hidden" id="input_img" onchange="handleImgFileSelect(this.files)" name="imagefile_thumb"/>
			                                    </div>
			                                </div>
	                         			</div>
									</td>
								</tr>
								<c:if test="${bbsCd != 'BN02' }">
								<tr>
									<th scope="row">첨부파일</th>
									<td colspan="3" id="fileArea" >
										<div class="uploadFile">
											<button type="button" id="btn_${bbsSeq}"  class="btn black ajax_file_upload" onclick="fnAddAttachmentFile('${bbsSeq}','${bbsView.ATCHMNFL_ID}','attachmentFile'); return false;">파일첨부</button>
											<c:if test="${!empty bbsAttachFileList }">
												<ul class="fileList">
													<c:forEach var="i" items="${bbsAttachFileList }" varStatus="status">
														<li class="file">
															<input type="checkbox" id="${i.FILE_ID }" name="chkAttachmentFile_${i.SEQ }" class="custom"/>
															<label for="${i.FILE_ID }" class="text-none">
																<a href="#" onclick="fnAttachmentSingleFileDown('${i.FILE_ID}'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">
																<span class="name">${i.FILE_NAME }</span>
																</a>
															</label>
														</li>
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
												</ul>
												<div class="fileOpt">
													<div class="allChk">
														<%-- <input type="checkbox" id="chkAttachmentFile_${bbsSeq}" class="custom" value="" onClick="javascript:fnCheckAttachmentMemoFile('${bbsSeq}');"> --%>
														<input type="checkbox" id="allChk" class="custom" onClick="fn_allChk(this);">
														<label for="allChk" class="text-none"></label><span class="name">전체선택</span>
													</div>
													<div class="btns">
														<button type="button" value="파일삭제" class="btn small red" onClick="javascript:fnDeleteAttachmentFile('${bbsSeq}','','attachmentFile'); return false;">파일삭제</button>
														<button type="button" value="다운로드" class="btn small blue" onClick="javascript:fnAttachmentFileDown('${bbsSeq}',''); return false;">다운로드</button>
													</div>
												</div>
											</c:if>
										</div>
									</td>
								</tr>
								</c:if>
								<tr>
									<th scope="row" class="req">
										<label for="label2">내용</label>
									</th>
									<td>
										<div class="editor_area_view">
											<textarea id="contents" name="contents" rows="10"  style="width: 100%; height: auto;" maxlength="2000" >
												<c:choose>
													<c:when test="${bbsCd == 'BN02' }">
														${bbsView.ANSWER }
													</c:when>
													<c:otherwise>
														${bbsView.CONTENTS }
													</c:otherwise>
												</c:choose>
											</textarea>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
			</div>
		</c:otherwise>
	</c:choose>
				
				<div class="board_list_btn right">
					<c:choose>
						<c:when test="${bbsCd == 'BN03' }">
							<a href="#" class="btn blue" onclick="answer(); return false;">저장</a>
						</c:when>
						<c:otherwise>
							<a href="#" class="btn blue" onclick="regist(); return false;">저장</a>
						</c:otherwise>
					</c:choose>
					<a href="#" class="btn black" onclick="list(); return false; ">취소</a>
					<!-- <a href="#" class="btn red" onclick="regist(); return false;">삭제</a> -->
				</div>
	<!-- /content -->
	</div>
	
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
<!--  파일 다운로드에 사용 --> 


<script language="javascript">

var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "contents",
	sSkinURI: "<c:url value='/smarteditor2-2.10.0/SmartEditor2Skin.html' />",
	fCreator: "createSEditor2"
});
</script>
