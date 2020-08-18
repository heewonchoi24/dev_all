<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
var pUrl, pParam;
var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	
	$(".ickjs").on('ifChanged', function(e){
		// 전체선택 checkbox
		if($( ".lst_all_chk #"+ e.target.id ).is(":checked") == true){
			$(".lst_answer."+e.target.id+" .icheckbox_square").addClass("checked");
			$(".lst_answer."+e.target.id+" .ickjs").prop("checked", true);
		}else if($( ".lst_all_chk #"+ e.target.id ).is(":checked") == false){
			$(".lst_answer."+e.target.id+" .icheckbox_square").removeClass("checked");
			$(".lst_answer."+e.target.id+" .ickjs").prop("checked", false);
		}
	});
	
});

function fnCheckAttachmentFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "]" ).prop( "checked", $( "#chkAttachmentFile_"+ index ).prop( "checked" ) );
}

function fnAddAttachmentFile(index, atchmnflId, attachmentFile ) {
	
	$( "#atchmnfl_id").val(atchmnflId);
    
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
	
	//여기까지
	pParam = {};
	pUrl = "/cjs/createCntrlFile.do";
	
	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.uploadedFilesInfo = uploadedFilesInfo;
	pParam.modifiedFilesInfo = modifiedFilesInfo;
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
			//alert(data.message);
	}, function(jqXHR, textStatus, errorThrown){
			
	});
	
	$("#form").attr({
		method : "post"
	}).submit();
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
    
	if (confirm("삭제하시겠습니까?")) {
	 	$.each( attachmentFileArray, function( key, value ) {
			if( chkAttachmentFile.indexOf( value.fileId  ) > 0 ) {
				p_atchmnflId[p_cnt]	= value.atchmnflId;
				p_fileId[p_cnt]		= value.fileId;
				p_filePath[p_cnt]	= value.filePath + "/" + value.saveFileName;
				p_cnt++;

			}
		});	

		var pUrl = "/cjs/deleteCntrlFile.do";
 		var param = new Object();
 		
 		param.atchmnfl_id = p_atchmnflId;
 		param.file_id = p_fileId;
 		param.filePath = p_filePath;
 		param.seq = index;
 		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
 			alert(data.message);
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});

 		$("#form").attr({
			method : "post"
		}).submit();
	}
	return;
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

function fn_update(e) {
	
	e.preventDefault();
	
	if('' == $("#atchmnfl_id").val()) {
		alert('관제 신청서를 첨부해주세요.');
		return false;
	}
	
	if (confirm("관제신청 하시겠습니까?")) {
		
		$("#status").val("SS01");
		
		$("#form").attr("action", "/cjs/modifyCntrlStatus.do");
		
		var options = {
				success : function(data){
					alert(data.message);
				},
				type : "POST"
		};
		
		$("#form").ajaxSubmit(options);
		
		$("#form").attr({
			method : "post",
			action : "/cjs/intrcnRegist.do"
		}).submit();
	}
}
</script>
<!-- /header -->
<form action="/cjs/intrcnRegist.do" method="post" id="form" name="form">

	<input type="hidden" id="status" name="status" value="" >
	
	<!--  파일 업로드에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="${result.atchmnflId }" > 
	<input type="hidden" id="insttCd" name="insttCd" value="${result.insttCd}" >
	<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
	<!--  파일 업로드에 사용 -->

   <section id="container" class="sub">
       <div class="container_inner">
        
          <section class="wrap-control1">
            <h1 class="title4">통합관제란</h1>
            <div class="box-info">
              <div class="icon"><span class="i-set i_info_i"></span></div>
              <div class="cont">
                <ul class="lst-dots">
                  <li>약 55만명의 개인정보취급자의 접속기록 수집ㆍ분석ㆍ의심사례 추측 및 소명요청</li>
                  <li>개인정보취급자에게 소명전달ㆍ소명답변을 받아 최종 소명판정 후 결과 보고</li>
                </ul>
              </div>
            </div>
            
            <h1 class="h1">통합관제 절차 및 흐름도</h1>
            <div class="img" style="margin-bottom: 50px;">
              <img src="/resources/front/images/cjs/img_control1.jpg" alt="통합관제 절차 및 흐름도">
            </div>

            <c:if test="${'Y' eq result.cntrlPrearngeYn or !empty result.registId}"> 
           
	            <h1 class="title4">관제신청</h1>
	            <ul class="lst-dots mb-c2">
	              <li>관제 신청 양식을 다운받아서 작성 후 양식에 맞체 작성하신 파일을 첨부하시면 됩니다. <a href="/common/privacyCjsApply.hwp" class="btn-pk ss gray2">신청 양식 다운로드</a></li> 
	              <li>최종적으로 신청을 완료하려면 <span class="">관제신청 바튼을 클릭</span>하시면 됩니다.</li>
	              <li>담당자가 확인 후 신청현황에서 승인여부를 확인하실 수 있습니다.</li>
	            </ul>
	            
	            <div class="wrap_table3 pr-mb3">
	                <table class="tbl" summary="신청현황, 신청서 첨부로 구성된 관제신청 등록입니다.">
	                    <caption>관제신청 등록</caption>
	                    <colgroup>
			              <col class="th1_1">
			              <col>
	                    </colgroup>
	                    <tbody>
	                        <tr>
	                            <th scope="col" class="bdl0">신청현황</th>
	                            <td>
	                            	<c:choose>
		                                <c:when test="${empty result.status}">
		                                	<div class="lh22">관제신청 내역이 없습니다.</div>
		                                </c:when>
		                                <c:when test="${'SS01' eq result.status}">
		                                	<div class="lh22">관제신청이 <strong class="c_blue">승인 진행중</strong>입니다.</div>
		                                </c:when>
		                                <c:when test="${'SS02' eq result.status}">
		                                	<div class="lh22">
			                                    관제신청이 <strong class="c_blue">승인</strong>되었습니다.<br>
			                                    통합관제시스템을 이용하실 수 있습니다.
			                                </div>
		                                </c:when>
		                                <c:when test="${'SS03' eq result.status}">
		                                	<div class="lh22">
			                                    관제신청이 <strong class="c_red">반려</strong>되었습니다.<br>
			                                    <strong class="c_black">반려사유</strong> : ${result.returnResn}
			                                </div>
		                                </c:when>
	                                </c:choose>
	                            </td>
	                        </tr>                        
	                        <tr>
	                            <th scope="col" rowspan="3" class="bdl0">신청서 첨부</th>
	                            <td headers="th_a1">
	                            	<c:if test="${empty result.status or 'SS03' eq result.status}">
	                                	<a class="btn-pk vs blue" id="btn_${result.insttCd}" onclick="fnAddAttachmentFile('${result.insttCd}','${result.atchmnflId}','attachmentFile'); return false;"><span>파일첨부</span></a>
	                                </c:if>
	                                <c:if test="${!empty fileList}">
		                                 <div class="lst_answer solo chkAttachmentFile_${result.insttCd}">
	                                        <c:forEach var="i" items="${fileList }" varStatus="status">
							                    <div>
						                          <input type="checkbox" id="${i.fileId }" name="chkAttachmentFile_${i.insttCd }" class="ickjs">
						                          <label for="${i.fileId }"><a href="#" onclick="fnAttachmentSingleFileDown('${i.fileId}'); return false;"><span class="i-aft i_${i.fileExtsn} link">${i.fileName }</span></a></label>
						                        </div>
												<script>
													var fileInfo = new Object();
													fileInfo.idx			= '${i.insttCd}';
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
											</c:forEach>
										</div>
	                                    <div class="lst_all_chk solo">
	                                        <input class="ickjs" type="checkbox" id="chkAttachmentFile_${result.insttCd}" value="" onClick="javascript:fnCheckAttachmentFile('${result.insttCd}');">
											<label for="chkAttachmentFile_${result.insttCd}">전체선택</label>
											<c:if test="${empty result.status or 'SS03' eq result.status}">
												<a class="btn-pk ss purple rv fl-r ml10" onClick="javascript:fnDeleteAttachmentFile('${result.insttCd}','','attachmentFile'); return false;"><span>파일삭제</span></a>
											</c:if>
											<a class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown('${result.insttCd}',''); return false;"><span>다운로드</span></a>
	                                    </div>
	                                </c:if>                               
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>

	                <c:if test="${empty result.status or 'SS03' eq result.status}">
		                <div class="btn-bot2 ta-c">
		                    <a href="#" class="btn-pk n rv blue" onclick="fn_update(event);"><span>관제신청</span></a>
		                </div>
	                </c:if>
                </section>
	    	 </c:if> 
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

<script>
$('.ickjs').iCheck({
  checkboxClass: 'icheckbox_square',
  radioClass: 'iradio_square'
});
</script>