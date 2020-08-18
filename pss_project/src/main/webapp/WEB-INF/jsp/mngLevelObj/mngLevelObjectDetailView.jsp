<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
var pUrl, pParam;

var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	
	$("#form").on("keyup keypress", function(e){
		var keyCode = e.keyCode || e.which;
		if(keyCode === 13){
			e.preventDefault();
			return false;
		}
	})
	
	fn_numberInit();
	
	var msg = '${message}';
	if(msg){
		alert(msg);
	}
	
	index = '${s_index_seq}';
	
	$("#lst_all_chk1 .iCheck-helper").on("click", function() {
		
		if($( ".lst_all_chk #chkAttachmentFile_"+ index + "_evl" ).is(":checked") == true){
			$( "#lst_answer1 .icheckbox_square" ).addClass("checked");
			$( "#lst_answer1 .ickjs" ).prop("checked", true);
			
		}else if($( ".lst_all_chk #chkAttachmentFile_"+ index + "_evl" ).is(":checked") == false){
			$( "#lst_answer1 .icheckbox_square" ).removeClass("checked");
			$( "#lst_answer1 .ickjs" ).prop("checked", false);
			
		}
	})
	
	$("#lst_all_chk2 .iCheck-helper").on("click", function() {
		
		if($( "#lst_all_chk2 #chkAttachmentFile_"+ index + "_memo" ).is(":checked") == true){
			$( "#lst_answer2 .icheckbox_square" ).addClass("checked");
			$( "#lst_answer2 .ickjs" ).prop("checked", true);
			
		}else if($( "#lst_all_chk2 #chkAttachmentFile_"+ index + "_memo" ).is(":checked") == false){
			$( "#lst_answer2 .icheckbox_square" ).removeClass("checked");
			$( "#lst_answer2 .ickjs" ).prop("checked", false);
		}
	})	
	
});

function goBack(){
	$("#s_index_seq").val('');
	document.form.action = '/mngLevelReq/mngLevelDocumentEvaluationDetail.do';
	document.form.submit();
}

function done(){
	
	<c:if test="${mngLevelInsttDetailEvlInfo.EXCP_PERM_YN != 'Y'}">
		if(!$("#result_score").val()){alert("평가결과는 필수 입력 사항입니다."); return;}
		if($("#result_score").val() < 0 || $("#result_score").val() > 100){alert("평가 점수는 0 ~ 100 사이의 값만 입력할 수 있습니다."); return;}
	</c:if>
	
	pParam = {};
	pUrl = '/mngLevelReq/mngLevelDocumentEvaluationInsertAjax.do';
	
	pParam.instt_cd = $("#s_instt_cd").val();
	pParam.index_seq = $("#s_index_seq").val();
	pParam.result_score = $("#result_score").val();
	pParam.memo = $("#memo").val();
	pParam.evl_opinion = $("#evl_opinion").val();
	pParam.uploadedFilesInfo = $( "#uploadedFilesInfo" ).val();
	pParam.modifiedFilesInfo = $( "#modifiedFilesInfo" ).val();
	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.excpPermYn = $("#excpPermYn").val();

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		alert(data.message);
		goBack();	
	}, function(jqXHR, textStatus, errorThrown){
			
	});
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

function fnAttachmentMemoFileDown( index, atchmnflId ) {
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
	pUrl = "/mngLevelReq/mngLevelDocumentEvaluationFileUpdateAjax.do";

	pParam.uploadedFilesInfo = uploadedFilesInfo;
	pParam.modifiedFilesInfo = modifiedFilesInfo;
	
	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.instt_cd = $("#s_instt_cd").val();
	pParam.index_seq = $("#s_index_seq").val();
	pParam.result_score = $("#result_score").val();
	pParam.memo = $("#memo").val();
	pParam.evl_opinion = $("#evl_opinion").val();
	pParam.excpPermYn = $("#excpPermYn").val();
	
	if(pParam.atchmnfl_id == "") {
		pUrl = "/mngLevelReq/mngLevelDocumentEvaluationFileInsertAjax.do";
	}

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
			//alert(data.message);
	}, function(jqXHR, textStatus, errorThrown){
			
	});

	document.form.action = "/mngLevelReq/mngLevelDocumentEvaluationRegist.do";
	document.form.submit();	 	
}


function fnDeleteAttachmentFile(index, atchmnflId, attachmentFile ) {
	var deleteAttachmentFile = "";
	var chkAttachmentFile = "";
	$( "input:checkbox[name=chkAttachmentFile_" + index + "_memo]" ).each( function() {
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

		var pUrl = "/mngLevelReq/mngLevelDocumentEvaluationFileDeleteAjax.do";
 		var param = new Object();
		
 		param.atchmnfl_id = p_atchmnflId;
 		param.file_id = p_fileId;
 		param.filePath = p_filePath;
 		param.index_seq = index;
 		param.instt_cd = ${s_instt_cd};
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
 			alert(data.message);
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});
 		
 		document.form.action = "/mngLevelReq/mngLevelDocumentEvaluationRegist.do";
 		document.form.submit();	 	
	}
	return;
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
</script>

<form method="post" id="form" name="form">
	<input type="hidden" name="s_order_no" id="s_order_no" value="${s_order_no }"/>
	<input type="hidden" name="s_instt_cd" id="s_instt_cd" value="${s_instt_cd }"/>
	<input type="hidden" name="s_instt_nm" id="s_instt_nm" value="${s_instt_nm }"/>
	<input type="hidden" name="s_index_seq" id="s_index_seq" value="${s_index_seq }"/>
	<input type="hidden" name="s_instt_cl_cd" id="s_instt_cl_cd" value="${s_instt_cl_cd }"/>
	<input type="hidden" name="excpPermYn" id="excpPermYn" value="${mngLevelInsttDetailEvlInfo.EXCP_PERM_YN }"/>
	
	<!--  파일 업로드에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="${mngLevelInsttDetailEvlInfo.ATCHMNFL_ID }" > 
	<input type="hidden" id="indexSeq" name="indexSeq">
	<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
	<!--  파일 업로드에 사용 -->               

	<!-- content -->
    <section id="container" class="sub">
       <div class="container_inner">
       
			<div class="box-info mb30">
				<div class="icon"><span class="i-set i_info_i"></span></div>
				<div class="cont">
					<ul class="lst-dots">
						<li>특이사항이나 이슈사항이 있으시면 메모입력 기능을 이용하여 작성하실 수 있습니다.</li>
					</ul>
				</div>
			</div>		       
                  
            <div class="wrap_table2">
                <table id="table-1" class="tbl">
                    <caption>분야, 진단지표, 진단항목, 평가결과로 구성된 서면평가</caption>
                    <colgroup>
						<col class="th1_1">
						<col class="th1_2">
						<col>
                        <col class="th1_5">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">분야</th>
                            <th scope="col">진단지표</th>
                            <th scope="col">진단항목</th>
                            <th scope="col">평가결과</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="col" class="bdl0">${mngLevelInsttDetailEvlInfo.LCLAS }</th>
                            <td scope="row" class="ta-l">${mngLevelInsttDetailEvlInfo.MLSFC }</td>
                            <c:if test="${! empty mngLevelInsttDetailEvlFileList }">
	                            <td class="pd0">
									<div class="lst_tblinner">
										<div class="tbls">
											<div class="col list">
												<div class="tbls">
													<div class="col list">
														<p class="h1">${mngLevelInsttDetailEvlInfo.CHECK_ITEM }</p>
														<div class="lst_answer" id="lst_answer1">
															<c:forEach var="i" items="${mngLevelInsttDetailEvlFileList }" varStatus="status">
																<div>
																	<input type="checkbox" class="ickjs" id="${i.FILE_ID }" name="chkAttachmentFile_${i.INDEX_SEQ }_evl">
																	<label for="${i.FILE_ID }"><span class="i-aft i_${i.fileExtsn} link"><a href="#" onclick="fnAttachmentResultReportFileDown('${i.FILE_ID}'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">${i.FILE_NAME }</a></span></label>
																</div>
															</c:forEach>
														</div>
														<div class="lst_all_chk" id="lst_all_chk1">
				                                       	 	<input class="ickjs" type="checkbox" id="chkAttachmentFile_${s_index_seq}_evl" value="" onClick="javascript:fnCheckAttachmentEvlFile('${s_index_seq}');">
				                                        	<label for="chkAttachmentFile_${s_index_seq}_evl">전체선택</label>
				                                        	
															<a href="#download" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentEvlFileDown('${s_index_seq}',''); return false;"><span>다운로드</span></a>
														</div>
													</div>
												</div><!--// tbls -->
											</div>
											<div class="col btns">
												<c:choose>
				                                	<c:when test="${mngLevelInsttDetailEvlInfo.EXCP_PERM_YN == 'Y'}">
				                                		<input type="text" id="result_score" class="inp_txt w100p" value="" disabled="disabled" title="평가결과 입력란">
				                                	</c:when>
				                                	<c:otherwise>
				                                		<input type="text" id="result_score" class="inp_txt w100p" maxlength="5" value="${mngLevelInsttDetailEvlInfo.RESULT_SCORE2 }">
				                                	</c:otherwise>
				                                </c:choose>										
											</div>
										</div>
									</div><!--// lst_tblinner -->                        
		                        </td>			                                        
		                     </c:if>
			                 <c:if test="${empty mngLevelInsttDetailEvlFileList }">
	                            <td class="pd0">
									<div class="lst_tblinner">
										<div class="tbls">
											<div class="col list">
												<div class="tbls">
													<div class="col list">
														<p class="h1">${mngLevelInsttDetailEvlInfo.CHECK_ITEM }</p>
													</div>
												</div><!--// tbls -->
											</div>
											<div class="col btns">
												<c:choose>
				                                	<c:when test="${mngLevelInsttDetailEvlInfo.EXCP_PERM_YN == 'Y'}">
				                                		<input type="text" id="result_score" class="inp_txt w100p" value="" disabled="disabled" title="평가결과 입력란">
				                                	</c:when>
				                                	<c:otherwise>
				                                		<input type="text" id="result_score" class="inp_txt w100p" maxlength="5" value="${mngLevelInsttDetailEvlInfo.RESULT_SCORE2 }">
				                                	</c:otherwise>
				                                </c:choose>										
											</div>
										</div>
									</div><!--// lst_tblinner -->                        
		                        </td>				                 
				             </c:if>
                        </tr>
						<tr>
							<th scope="col" id="a_b" class="bdl0">평가의견</th>
							<td headers="a_b" colspan="4">
				            <c:choose>
								<c:when test="${fn:contains(periodCode, 'B') ||  fn:contains(periodCode, 'D')}">
									<input id="evl_opinion" maxlength="1000" type="text" class="inp_txt w100p ty2" value="${mngLevelInsttDetailEvlInfo.EVL_OPINION2 }" placeholder="진단항목에 대한 평가의견이 있을 경우 입력하실 수 있습니다."  title="평가의견 입력란">
								 </c:when>
								<c:otherwise>
									${mngLevelInsttDetailEvlInfo.EVL_OPINION2 }
								</c:otherwise> 
							</c:choose>						
							</td>
						</tr>
			            <tr>
			              <th scope="col" id="a_c" class="bdl0">이의신청</th>
			              <td headers="a_c" colspan="4"><input type="text" class="inp_txt w100p ty2" value="" placeholder=""  title="이의신청 입력란"></td>
			            </tr>
 						<tr>
							<th scope="col" id="a_d" class="bdl0">첨부파일</th>
							<td headers="a_d" colspan="4" class="ta-l"> 
								<c:if test="${fn:contains(periodCode, 'B') ||  fn:contains(periodCode, 'D')}">
								<div class="inp_file">
									<button type="button" id="btn_${mngLevelInsttDetailEvlInfo.INDEX_SEQ}" class="inp_file_btn" onclick="fnAddAttachmentFile('${mngLevelInsttDetailEvlInfo.INDEX_SEQ}','${mngLevelInsttDetailEvlInfo.ATCHMNFL_ID}','attachmentFile'); return false;"><span>파일찾기</span></button>
								</div>
								</c:if>
								<c:if test="${! empty mngLevelInsttDetailMemoFileList }">
								
									<div class="lst_answer" id="lst_answer2">
										<c:forEach var="i" items="${mngLevelInsttDetailMemoFileList }" varStatus="status">
											<div>
												<input type="checkbox" class="ickjs" id="${i.FILE_ID }" name="chkAttachmentFile_${i.INDEX_SEQ }_memo">
												<label for="${i.FILE_ID }"><span class="i-aft i_${i.fileExtsn} link"><a href="#" onclick="fnAttachmentResultReportFileDown('${i.FILE_ID}'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">${i.FILE_NAME }</a></span></label>
											</div>
											<script> 
												var fileInfo = new Object();
												fileInfo.idx			= '${i.INDEX_SEQ}';
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
										<div class="lst_all_chk" id="lst_all_chk2">
                                       	 	<input class="ickjs" type="checkbox" id="chkAttachmentFile_${s_index_seq}_memo" value="" onClick="javascript:fnCheckAttachmentMemoFile('${s_index_seq}');">
                                        	<label for="chkAttachmentFile_${s_index_seq}_memo">전체선택</label>
                                        	
											<c:if test="${fn:contains(periodCode, 'B') ||  fn:contains(periodCode, 'D')}">
												<button type="button" class="btn-pk ss black" onClick="javascript:fnDeleteAttachmentFile('${s_index_seq}','','attachmentFile'); return false;">파일삭제</button>
											</c:if>                                     	
                                       	
											<a type="button" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentMemoFileDown('${s_index_seq}',''); return false;"><span>다운로드</span></a>
										</div>			
									</div>
								</c:if>							
							</td>
						</tr>                      
                    </tbody>
                </table>
            </div>  
            
            <div class="btn-bot noline ta-c">
            	<c:if test="${fn:contains(periodCode, 'B') ||  fn:contains(periodCode, 'D')}">
					<a href="#" onclick="done(); return false;" class="btn-pk n black">평가완료</a>
				</c:if>
                <a href="javascript:history.back();" class="btn-pk n black">목록으로</a>
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

<script>
$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square',
	radioClass: 'iradio_square'

});
</script>