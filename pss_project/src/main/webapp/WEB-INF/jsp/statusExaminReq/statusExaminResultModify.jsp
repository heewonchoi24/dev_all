<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.lst_answer.solo {border-top: none; padding: 10px 20px 10px 0;}
.lst_all_chk.solo {padding: 15px 30px 15px 0px;}
</style>
<script type="text/javascript">
var pUrl, pParam;
var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	$(".lst_all_chk.solo .iCheck-helper").click(function(){
		if($(".allChk").is(":checked")) {
			$(".ickjs").prop("checked", true);
			$(".icheckbox_square").addClass("checked");
		}else {
			$(".ickjs").prop("checked", false);
			$(".icheckbox_square").removeClass("checked");
		}
	})
});

function fnCheckAttachmentEvlFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "_evl]" ).prop( "checked", $( "#chkAttachmentFile_"+ index + "_evl" ).prop( "checked" ) );
}  

function fnAttachmentEvlFileDown( index, atchmnflId ) {
	var chkAttachmentFile = atchmnflId;
	// Check Box 선택 
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

function registTotalEvl(atchmnflId, resultCnt){
    $( "#atchmnfl_id").val(atchmnflId);

	pParam = {};
	pUrl = '/statusExaminReq/insertStatusExaminRes.do';
	
	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.instt_cd  = '${instt_cd}';
	pParam.orderNo   = '${order_no}';
	pParam.totResultScore1 = 0;
	pParam.totResultScore2 = 0;

	pParam.gnrlzEvl1 = $("#gnrlzEvl").val();
	pParam.gnrlzEvl2 = $("#gnrlzEvl").val();
	pParam.status = "ES05";

	pParam.gubun     = '1';
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		alert(data.message);
	}, function(jqXHR, textStatus, errorThrown){
			
	});

	document.form.action = "/statusExaminReq/statusExaminResultModifyList.do";
	document.form.submit();

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
	//
	$( "#uploadedFilesInfo" ).val( uploadedFilesInfo );
	$( "#modifiedFilesInfo" ).val( modifiedFilesInfo );
	
	pParam = {};
	pUrl = "/statusExaminReq/updateStatusExaminRes.do";

	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.uploadedFilesInfo = uploadedFilesInfo;
	pParam.modifiedFilesInfo = modifiedFilesInfo;
	
	pParam.instt_cd  = '${instt_cd}';
	pParam.orderNo   = '${order_no}';
// 	pParam.totResultScore1 = 0;
// 	pParam.totResultScore2 = 0;

	pParam.gubun     = '1';
// 	pParam.gnrlzEvl1 = $("#gnrlzEvl").val();
 	pParam.gnrlzEvl2 = $("#gnrlzEvl").val();

	if(pParam.atchmnfl_id == "") {
		pUrl = "/statusExaminReq/insertStatusExaminRes.do";
	}

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		
	}, function(jqXHR, textStatus, errorThrown){
			
	});
		
	document.form.action = "/statusExaminReq/statusExaminResultModify.do";
	document.form.submit();	 	
}

function fnDeleteAttachmentFile(index, atchmnflId, attachmentFile ) {
	var deleteAttachmentFile = "";
	var chkAttachmentFile = "";
	$( "input:checkbox[name=chkAttachmentFile_" + index + "_evl]" ).each( function() {
		if( $(this).prop( "checked" ) ) 
			chkAttachmentFile += "," + $(this).attr("id");
	});
	if( chkAttachmentFile == "" )
		return;

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

		var pUrl = "/statusExaminReq/deleteStatusExaminRes.do";
 		var param = new Object();
		
 		param.atchmnflId = p_atchmnflId;
 		param.fileId = p_fileId;
 		param.filePath = p_filePath;
 		param.indexSeq = index;
 		param.insttCd = ${instt_cd};
 		param.gubun = "1";
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});

 		document.form.action = "/statusExaminReq/statusExaminResultModify.do";
 		document.form.submit();	 	
	}
	return;
} 

function fn_resultModifyList(instt_cd, instt_nm, instt_cl_nm, order_no, instt_cl_cd, periodCd){
	document.form.instt_cd.value = instt_cd;
	document.form.instt_nm.value = instt_nm;
	document.form.instt_cl_nm.value = instt_cl_nm;
	document.form.order_no.value = order_no;
	document.form.instt_cl_cd.value = instt_cl_cd;
	document.form.periodCd.value = periodCd;
	
	document.form.action = "/statusExaminReq/statusExaminResultModifyList.do";
	document.form.submit();
}

</script>

<form method="post" id="form" name="form">
	<input type="hidden" id="order_no" name="order_no" value="${order_no }"/>
	<input type="hidden" id="instt_nm" name="instt_nm" value="${instt_nm }"/>
	<input type="hidden" id="instt_cd" name="instt_cd" value="${instt_cd }"/>
	<input type="hidden" id="instt_cl_cd" name="instt_cl_cd" value="${instt_cl_cd }"/>
	<input type="hidden" id="instt_cl_nm" name="instt_cl_nm" value="${instt_cl_nm }"/>
	<input type="hidden" id="periodCd" name="periodCd" value="${requestZvl.periodCd }"/>
	<!--  파일 업로드에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="${statusExaminInsttTotalEvl.ATCHMNFL_ID }" > 
	<input type="hidden" id="indexSeq" name="indexSeq" value="" > 
	<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
	<!--  파일 업로드에 사용 -->               
	    
    <!-- content -->
<section id="container" class="sub">
	<div class="container_inner">
		<h1 class="title2 pr-mb1">${order_no }년 ${instt_nm } <span class="fc_blue">관리수준 현황조사</span></h1>

		<h1 class="title4">종합평가 의견 작성</h1>

		<section class="area_tit1 inr-c">
			<div class="cont">
				<div class="wrap_table3">
             		<table class="tbl" summary="종합평가 의견, 결과보고서 첨부로 구성된 종합평가 의견 등록입니다.">
                    	<caption>종합평가 의견 등록</caption>
	                    <colgroup>
	                        <col style="width:15%">
	                        <col style="width:*">
	                    </colgroup>
	                    <tbody>
							<tr>
							    <th scope="col">종합평가 의견</th>
							    <td>
							    	<textarea id="gnrlzEvl" class="textarea wa" title="내용을 입력하세요." maxLength="1000">${statusExaminInsttTotalEvl.GNRLZ_EVL2 }</textarea>
							    </td>
							</tr>
							<tr>
	                            <th scope="col">결과보고서 첨부</th>
	                            <td class="ta-l pd">
	                            	<div class="inp_file">
										<button type="button" id="btn_${statusExaminInsttTotalEvl.INSTT_CD}" class="inp_file_btn" onclick="fnAddAttachmentFile('${statusExaminInsttTotalEvl.INSTT_CD}','${statusExaminInsttTotalEvl.ATCHMNFL_ID}','attachmentFile'); return false;">파일첨부</button>
									</div>
									<c:if test="${statusExaminFileList.size() > 0 }">
										<div class="lst_answer solo">
	                                   	<c:forEach var="i" items="${statusExaminFileList }" varStatus="status">
	                                   		<div>
												<input class="ickjs" type="checkbox" id="${i.FILE_ID }" name="chkAttachmentFile_${i.INSTT_CD }_evl"/>
												<label for="${i.FILE_ID }"><span class="i-aft i_${i.FILE_EXTSN} link"><a href="#" onClick="javascript:fnAttachmentEvlFileDown('${i.INDEX_SEQ}','${i.FILE_ID }'); return false;" class="f_<c:out value='${i.FILE_EXTSN}'/>">
												<span class="i-aft i_${i.fileExtsn} link">${i.FILE_NAME }</span></a></span></label>
											</div>
			                                <script>
				                                var fileInfo = new Object();
				                                fileInfo.idx			= '${i.INSTT_CD}';
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
	                                    <div class="ta-l pd2 td_log lst_all_chk solo">
	                                        <input type="checkbox" class="ickjs allChk" id="chkAttachmentFile_${instt_cd}_evl" value="" onClick="javascript:fnCheckAttachmentEvlFile('${instt_cd}');">
	                                        <label for="chkAttachmentFile_${instt_cd}_evl">전체선택</label>
	                                        <div class="fl-r">
	                                        	<button type="button" value="파일삭제" class="btn-pk ss black" onClick="javascript:fnDeleteAttachmentFile('${instt_cd}','','attachmentFile'); return false;">파일삭제</button>
												<button type="button" value="다운로드" class="btn-pk ss gray2 rv" onClick="javascript:fnAttachmentEvlFileDown('${instt_cd}',''); return false;">다운로드</button>
	                                        </div>
	                                    </div>
		                            </c:if>
	                            </td>
	                        </tr>                        
	                    </tbody>
	                </table>
            	</div>
            </div>
		</section>
		<div class="btn-bot2 ta-c"> 
			<a href="#" onclick="fn_resultModifyList('${instt_cd}','${instt_nm}', '${instt_cl_nm}', '${order_no}', '${instt_cl_cd}', '${periodCd}');" class="btn-pk n rv black">이전화면</a>
			<a href="#" onclick="registTotalEvl('${statusExaminInsttTotalEvl.ATCHMNFL_ID}','${statusExaminInsttDetailList.size()}');" class="btn-pk n rv purple">최종완료</a>
		</div>
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

<script>
$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square',
	radioClass: 'iradio_square'
});
</script>