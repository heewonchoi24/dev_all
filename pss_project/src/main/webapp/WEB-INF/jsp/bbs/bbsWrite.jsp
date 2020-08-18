<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript" src="/smarteditor2-2.10.0/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<style> .lst_all_chk .icheckbox_square .iCheck-helper{z-index: -1 !important;} .icheckbox_square + label, .icheckbox_square + label a { width: auto; text-decoration: underline; color: #0d6090; font-size: 14px; margin-left: 5px; } .icheckbox_square + label a { margin-left: 0; } .control { position: absolute; right: 0; bottom: -4px; } .lst_answer.solo { padding: 10px 0 0 0; } .file_list > div { margin: 5px 0; } .lst_answer.solo, .lst_tblinner .tbls > .col.list .lst_answer { border: none; } .file_control.lst_all_chk { border-top: 1px solid #dcdbdb; padding-top: 10px; margin-top: 10px; } label.allChk, label.allChkLabel { text-decoration: none; color: inherit; } .ickjs { position: absolute; opacity: 0; }</style>
<script>
var pUrl, pParam, html;
var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	$('.ickjs').iCheck({
		checkboxClass: 'icheckbox_square',
		radioClass: 'iradio_square'
	});
})
.on("click", ".allChk, .lst_all_chk .icheckbox_square", function(){
	if($("input.allChk").prop("checked") == true) {
		$("input.allChk").prop("checked", false);
		$(".icheckbox_square").removeClass("checked");
	}else {
		$("input.allChk").prop("checked", true);
		$(".icheckbox_square").addClass("checked");
	}
	$(".ickjs").prop("checked", $("input.allChk").prop("checked"));
})
.on("click", ".addChk .iCheck-helper", function(){
	if($(this).hasClass("allChk")) {
		if($( "input.allChk").prop("checked") == true) $("input.allChk").prop("checked", false);
		else $("input.allChk").prop("checked", true);
		fnCheckAttachmentMsgFile();
	}else{
		var idx = $(this).attr("idx");
		if($( ".ickjs[id="+idx+"]").prop("checked") == true) $( ".ickjs[id="+idx+"]").prop("checked", false);
		else $( ".ickjs[id="+idx+"]").prop("checked", true);
		$(".icheckbox_square[idx="+ idx +"]").toggleClass("checked")
	}
})
function fnCheckAttachmentMsgFile() {
	$( "input[name=chkAttachmentFile_"+ $("#bbsSeq").val() +"]" ).prop( "checked", $( "input.allChk").prop( "checked" ) );
	if($( "input.allChk").prop("checked") == true) $(".icheckbox_square").addClass("checked");
	else $(".icheckbox_square").removeClass("checked");
}  
function listThread(pageNo, cat) {
	if(cat){$("#category").val(cat);}
	$("#pageIndex").val(pageNo);
	$("#form").attr({
        method : "post"
    }).submit();
}

function validate(){
	if($("#srchStr").val()){
		if(!$("#srchOpt").val()){alert("검색분류를 선택하세요."); return false;}
	}
	return true;
}

function fnCheckAttachmentEvlFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "_evl]" ).prop( "checked", $( "#chkAttachmentFile_"+ index + "_evl" ).prop( "checked" ) );
}  

function fnAttachmentEvlFileDown( index, atchmnflId ) {
	var chkAttachmentFile = atchmnflId;

	if( atchmnflId == "" ) {
		$( "input:checkbox[name=chkAttachmentFile_" + index + "_evl]" ).each( function() {
			if( $(this).prop( "checked" ) ) 
				chkAttachmentFile += "," + $(this).attr("id");

		});
		chkAttachmentFile = chkAttachmentFile.substring( 1, chkAttachmentFile.length )
	}
	if( chkAttachmentFile == "" ) {
		alert( "다운로드할 파일을 선택 하십시요.")
		return;
	}

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

//메모 첨부파일
function fnCheckAttachmentMemoFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "]" ).prop( "checked", $( "#chkAttachmentFile_"+ index ).prop( "checked" ) );
}  

function fnAttachmentMemoFileDown( index, atchmnflId ) {
	var chkAttachmentFile = atchmnflId;

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
	//
	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
}



function fnAddAttachmentFile(index, atchmnflId, attachmentFile ) {
    //
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
	pUrl = "/bbs/bbsFileUpdate.do";
	
	pParam.bbsCd = $("#bbsCd").val();
	pParam.bbsNm = $("#bbsNm").val();
	pParam.bbsSeq = $("#bbsSeq").val();
	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.uploadedFilesInfo = uploadedFilesInfo;
	pParam.modifiedFilesInfo = modifiedFilesInfo;
	
	if(pParam.atchmnfl_id == "") {
		pUrl = "/bbs/bbsFileInsert.do";
	}

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		
		$("#bbsSeq").val(data.bbsSeq);
		$("#atchmnfl_id").val(data.atchmnfl_id);
		html = '';
		html += '<button type="button" id="btn_' + data.bbsSeq + '"  class="btn-pk vs blue" onclick="fnAddAttachmentFile(\'' + data.bbsSeq + '\',\'' + data.atchmnfl_id + '\',\'attachmentFile\'); return false;">파일첨부</button>';
		
		if(attachmentFileArray.length > 0){
			
			html += '<div class="option lst_answer solo chkAttachmentFile_0all">';
			html += '<div class="file_list">';
			$.each(attachmentFileArray, function(i,v){
				html += '<div>';	
				html += '<div class="icheckbox_square addChk" style="position: relative;" idx="'+ v.fileId +'" >';
				html += '<input type="checkbox" class="ickjs" id="' + v.fileId + '" name="chkAttachmentFile_' + data.bbsSeq + '"/>';
				html += '<ins class="iCheck-helper" idx="'+ v.fileId +'" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>';
				html += '</div>';
				html += '<label for="' + v.fileId + '"><span class="i-aft i_${v.fileExtsn} link"><a href="#" onclick="fnAttachmentSingleFileDown(\'' + v.fileId + '\'); return false;" class="f_' + v.fileExtsn + '">' + v.fileName + '</a></span></label>';
				html += '</div>';
			});
			html += '</div>';
			html += '<div class="file_control lst_all_chk">';
			html += '<div class="icheckbox_square addChk" style="position: relative;">';
			html += '<input type="checkbox" class="ickjs allChk" id="chkAttachmentFile_' + data.bbsSeq + '" value="" onClick="javascript:fnCheckAttachmentMemoFile(\'' + data.bbsSeq + '\');">';
			html += '<ins class="iCheck-helper allChk" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0; z-index: 1 !important;"></ins>';
			html += '</div>';
			html += '<label for="label4" class="allChkLabel">전체선택</label>';
			html += '<div class="control">';
			html += '<button type="button" value="파일삭제" class="btn-pk ss purple rv fl-r ml10" onClick="javascript:fnDeleteAttachmentFile(\'' + data.bbsSeq + '\', \'\', \'attachmentFile\'); return false;">파일삭제</button>';
			html += '<button type="button" value="다운로드" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown(\'' + data.bbsSeq + '\', \'\'); return false;">다운로드</button>';
			html += '</div>';
			html += '</div>';
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
	 	
		var pUrl = "/bbs/bbsFileDelete.do";
 		var param = new Object();
		
 		
 		param.atchmnfl_id = p_atchmnflId;
 		param.file_id = p_fileId;
 		param.filePath = p_filePath;
 		param.bbsSeq = index;
 		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			$("#bbsSeq").val(data.bbsSeq);
			$("#atchmnfl_id").val(data.atchmnfl_id);
			html = '';
			html += '<button type="button" id="btn_' + data.bbsSeq + '"  class="btn-pk vs blue" onclick="fnAddAttachmentFile(\'' + data.bbsSeq + '\',\'' + data.atchmnfl_id + '\',\'attachmentFile\'); return false;">파일첨부</button>';
			
			if(tmpFileArray.length > 0){
				html += '<div class="option lst_answer solo chkAttachmentFile_0all">';
				html += '<div class="file_list">';
				$.each(tmpFileArray, function(i,v){
					html += '<div>';
					html += '<div class="icheckbox_square addChk" style="position: relative;" idx="'+ v.fileId +'" >';
					html += '<input type="checkbox" class="ickjs" id="' + v.fileId + '" name="chkAttachmentFile_' + data.bbsSeq + '"/>';
					html += '<ins class="iCheck-helper" idx="'+ v.fileId +'" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>';
					html += '</div>';
					html += '<label for="' + v.fileId + '"><span class="i-aft i_${v.fileExtsn} link"><a href="#" onclick="fnAttachmentSingleFileDown(\'' + v.fileId + '\'); return false;" class="f_' + v.fileExtsn + '">' + v.fileName + '</a></span></label>';
					html += '</div>';
				});
				html += '</div>';
				html += '<div class="file_control lst_all_chk">';
				html += '<div class="icheckbox_square addChk" style="position: relative;">';
				html += '<input type="checkbox" class="ickjs allChk" id="chkAttachmentFile_' + data.bbsSeq + '" value="" onClick="javascript:fnCheckAttachmentMemoFile(\'' + data.bbsSeq + '\');">';
				html += '<ins class="iCheck-helper allChk" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0; z-index: 1 !important;"></ins>';
				html += '</div>';
				html += '<label for="label4" class="allChkLabel">전체선택</label>';
				html += '<div class="control">';
				html += '<button type="button" value="파일삭제" class="btn-pk ss purple rv fl-r ml10" onClick="javascript:fnDeleteAttachmentFile(\'' + data.bbsSeq + '\', \'\', \'attachmentFile\'); return false;">파일삭제</button>';
				html += '<button type="button" value="다운로드" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown(\'' + data.bbsSeq + '\', \'\'); return false;">다운로드</button>';
				html += '</div>';
				html += '</div>';
				html += '</div>';
			}else if(tmpFileArray.length == 0){
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
	if(!$("#label0").val()){alert("제목은 필수 입력 사항입니다."); return;}
	
	pParam = {};
	pUrl = '/bbs/bbsRegistThread.do';
	
	pParam.bbsSeq = $("#bbsSeq").val();
	pParam.bbsCd = $("#bbsCd").val();
	pParam.subject = $("#label0").val();
	//pParam.contents = CKEDITOR.instances.label2.getData();
	
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	var conVal = $("#contents").val().replace(/<p>|<\/p>|<br>|\s|&nbsp;/gi, "");
	if(conVal == null || conVal == ''){alert("내용은 필수입력 사항입니다."); return;}
	
	pParam.contents = $("#contents").val();
	pParam.uploadedFilesInfo = $( "#uploadedFilesInfo" ).val();
	pParam.modifiedFilesInfo = $( "#modifiedFilesInfo" ).val();
	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.boardUserId = $("#boardUserId").val();
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		alert("등록이 완료되었습니다. 목록으로 이동합니다.");
		$("#bbsSeq").val("");
		$("#form").attr({
			method : "post"
		}).submit();
	}, function(jqXHR, textStatus, errorThrown){
		alert("비정상적인 접근입니다.");
		history.back();
	});
}


function deleteThread(){
	pParam = {};
	if(confirm("삭제 하시겠습니까?")){
		pParam.bbsSeq = $("#bbsSeq").val();
		$.post("/bbs/deleteThread.do", pParam, function(data){ 
			alert(data.message);
			$("#form").submit();
		});				
	}
}
</script>

<form action="/bbs/bbsList.do" method="post" id="form" name="form" onsubmit="return validate();">
	<input type="hidden" name="bbsCd" id="bbsCd" value="${bbsCd }"/>
	<input type="hidden" name="category" id="category" value="${category }"/>
	<input type="hidden" name="userId" id="userId" value="${userId }" />

	<!--  파일 업로드에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="${bbsView.ATCHMNFL_ID }" > 
	<input type="hidden" id="bbsSeq" name="bbsSeq" value="${bbsSeq }" > 
	<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
	<!--  파일 업로드에 사용 -->  

<section id="container" class="sub">
    <div class="container_inner">
    <!-- content -->
    <section class="area_tit1 inr-c">
        <header class="tit">
        	<h2 class="h1">${bbsNm } 작성하기</h2>
        </header>
        <div class="cont">
        	<div class="wrap_table3">
				<table id="table-1" class="tbl" summary="제목, 작성자, 기관명, 파일첨부, 내용으로 구성된 게시판 글쓰기입니다.">
					<caption>${bbsNm } 작성하기 정보</caption>
					<colgroup>
						<col class="th1_1">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="col" id="th_a1">제목</th>
							<td colspan="3">
								<input type="text" name="subject" id="label0" class="inp_txt w100p" maxlength="100" value="${bbsView.SUBJECT }">
							</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${sessionScope.userInfo.userNm }</td>
							<th>기관명</th>
							<td>${sessionScope.userInfo.insttNm }</td>                            
						</tr>
						<tr>
							<th>파일첨부</th>
							<td id="fileArea" colspan="3">
								<button type="button" id="btn_${bbsSeq}" class="btn-pk vs blue" onclick="fnAddAttachmentFile('${bbsSeq}','${bbsView.ATCHMNFL_ID}','attachmentFile'); return false;">파일첨부</button>                                        
								<c:if test="${!empty bbsAttachFileList }">
								<div class="option lst_answer solo chkAttachmentFile_0all">
									<div class="file_list">
										<c:forEach var="i" items="${bbsAttachFileList }" varStatus="status">
											<div>
												<input class="ickjs" type="checkbox" id="${i.FILE_ID }" name="chkAttachmentFile_${i.SEQ }"/>
												<label for="${i.FILE_ID }"><span class="i-aft i_${i.fileExtension} link"><a href="#" onclick="fnAttachmentSingleFileDown('${i.FILE_ID}'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">${i.FILE_NAME }</a></span></label>
											</div>
											<script>
												fileInfo = {};
												fileInfo.idx			= '${i.SEQ}';
												fileInfo.atchmnflId		= '${i.ATCHMNFL_ID}';
												fileInfo.fileId			= '${i.FILE_ID}';
												fileInfo.fileName		= '${i.FILE_NAME}';
												fileInfo.saveFileName	= '${i.SAVE_FILE_NAME}';
												fileInfo.filePath		= '${i.FILE_PATH}';
												fileInfo.mimeType		= '${i.MIME_TYPE}';
												fileInfo.isDeleted		= 'false';
												fileInfo.modifiedFileId	= '${i.FILE_ID}';
												fileInfo.fileUrl	= ""; // 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
												attachmentFileArray.push( fileInfo );
											</script>	
										</c:forEach>
									</div>
									<div class="file_control lst_all_chk">
										<input type="checkbox" class="ickjs allChk" id="chkAttachmentFile_${bbsSeq}" value="" onClick="javascript:fnCheckAttachmentMemoFile('${bbsSeq}');">
										<label for="label4" class="allChk">전체선택</label>
										<div class="control">
											<button type="button" value="파일삭제" class="btn-pk ss purple rv fl-r ml10" onClick="javascript:fnDeleteAttachmentFile('${bbsSeq}','','attachmentFile'); return false;">파일삭제</button>
											<button type="button" value="다운로드" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown('${bbsSeq}',''); return false;">다운로드</button>
										</div>
									</div>
								</div>
							</c:if>
						</td>
					</tr> 
					<tr>
						<th scope="col" id="th_a1">내용</th>
						<td colspan="3">
							<div class="editor_area_view">
								<textarea id="contents" name="contents" rows="10"  style="width: 100%; height: auto;" maxlength="2000" title="내용을 입력하세요.">${bbsView.CONTENTS }</textarea>
							</div>
						</td>
						</tr>                         
					</tbody>
				</table>
			</div>
			<div class="btn-bot2 ta-c">
				<c:if test="${!empty bbsSeq }">
					<a href="#" onclick="deleteThread(); return false;" class="btn-pk n rv purple2">삭제</a>
				</c:if>
				<a href="#" class="btn-pk n rv blue" onclick="regist(); return false;">저장</a>
				<a href="#" class="btn-pk n rv gray" onclick="listThread(); return false; ">취소</a>
			</div>
        </div>
	</section>
	</div>
</section>
    <!-- /content -->
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