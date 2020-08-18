<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style> .icheckbox_square + label { width: 95%; } .i-aft.link a { text-decoration: underline; color: #0d6090; font-size: 13px; }</style>
<script type="text/javascript">
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	
	index = '${result.indexSeq}';
	
	$("#lst_all_chk1 .iCheck-helper").on("click", function() {
		if($( ".lst_all_chk #chkAttachmentFile_"+ index + "_apply" ).is(":checked") == true){
			$( "#lst_answer1 .icheckbox_square" ).addClass("checked");
			$( "#lst_answer1 .ickjs" ).prop("checked", true);
			
		}else if($( ".lst_all_chk #chkAttachmentFile_"+ index + "_apply" ).is(":checked") == false){
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
	
	$(".wrap_table2 .lst_answer>div>label").each(function(){
		if($(this).height()>34) { 
			$(this).css({"marginTop":"-11px", "marginBottom" : "5px"});
			$(this).parent().css("marginTop", "15px"); 
			($(this).parent()).parent().css({"paddingTop" : "15px", "paddingBottom" : "5px"});
		}
	})
});

function fn_goDtl() {
   	$("#resultForm").attr({
           action : "/mngLevelRst/mngLevelRstSummaryDtlList.do",
           method : "post"
       }).submit();
}

function fnCheckAttachmentApplyFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "_apply]" ).prop( "checked", $( "#chkAttachmentFile_"+ index + "_apply" ).prop( "checked" ) );
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

//메모 첨부파일
function fnCheckAttachmentMemoFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "_memo]" ).prop( "checked", $( "#chkAttachmentFile_"+ index + "_memo" ).prop( "checked" ) );
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

// 이의신청 첨부파일
function fnCheckAttachmentFobjctFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "_fobjct]" ).prop( "checked", $( "#chkAttachmentFile_"+ index + "_fobjct" ).prop( "checked" ) );
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

/* function fnAddAttachmentFile(index, atchmnflId, attachmentFile ) {
    //
    $( "#atchmnfl_id").val(atchmnflId);
    $( "#indexSeq").val(index);
    
    var url			= "/crossUploader/fileUploadPopUp.do";
    var varParam	= "";
    var openParam	= "height=445px, width=500px";

	var attachmentFile = window.open( "", "attachmentFile", openParam );
    attachmentFile.location.href = url;
} */

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
	pUrl = "/mngLevelRst/updateMngLevelRstFobjctFile.do";

	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.uploadedFilesInfo = uploadedFilesInfo;
	pParam.modifiedFilesInfo = modifiedFilesInfo;
	
	pParam.insttCd = $("#insttCd").val();
	pParam.indexSeq = $("#indexSeq").val();
	pParam.fobjctResn = $("#fobjctResn").val();

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		//alert(data.message);
		$("#resultForm").attr({
            action : "/mngLevelRst/mngLevelRstDtl.do",
            method : "post"
        }).submit();
	}, function(jqXHR, textStatus, errorThrown){
			
	});
}

/* function fnDeleteAttachmentFile(index, atchmnflId, attachmentFile ) {
	
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

		var pUrl = "/mngLevelRst/deleteMngLevelRstFobjct.do";
 		var param = new Object();
		
 		param.atchmnfl_id = p_atchmnflId;
 		param.file_id = p_fileId;
 		param.filePath = p_filePath;
 		param.indexSeq = index;
 		param.insttCd = $("#insttCd").val();
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
 			alert(data.message);
 			$("#resultForm").attr({
	            action : "/mngLevelRst/mngLevelRstDtl.do",
	            method : "post"
	        }).submit();
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});
	}
	return;
} */
/* 
function fn_save() {
	
	var pUrl = "/mngLevelRst/updateMngLevelRstFobjct.do";
	
	var param = new Object();
	
	param.insttCd = $("#insttCd").val();
	param.indexSeq = $("#indexSeq").val();
	param.fobjctResn = $("#fobjctResn").val();
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		alert(data.message);
		
		$("#resultForm").attr({
            action : "/mngLevelRst/mngLevelRstDtl.do",
            method : "post"
        }).submit();
		
	}, function(jqXHR, textStatus, errorThrown){
		
	});
} */
</script>

<form action="/mngLevelRst/mngLevelRstDtl.do" method="post" id="resultForm" name="resultForm">
	
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
            <h1 class="title2 pr-mb1">${requestZvl.orderNo }년 ${requestZvl.insttNm } <span class="fc_blue">수준진단 결과 상세정보</span></h1>
            
            <h1 class="title4">평가결과</h1>
            <div class="wrap_table2">
                <table id="table-1" class="tbl" summary="분야, 진단지표, 진단항목, 평가결과로 구성된 수준진단 결과 상세정보입니다.">
                    <caption>수준진단 결과 상세보기</caption>
                    <colgroup>
			            <col class="th1_1">
			            <col class="th1_2">
			            <col>
			            <col class="th1_4">
                    </colgroup>
                    <thead>
                        <tr>
			              <th scope="col" id="th_a">분야</th>
			              <th scope="col" id="th_b">진단지표</th>
			              <th scope="col" id="th_c">진단항목</th>
			              <th scope="col" id="th_d">평가결과</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="col" id="a_a" class="bdl0" scope="rowgroup">${result.lclas}</th>
                            <td scope="row" id="a_a_1" class="ta-l">${result.mlsfc}</td>
                            <td colspan="3" headers="th_c th_d th_e a_a a_a_1" class="pd0">
								<div class="lst_tblinner">
										<div class="tbls">
											<div class="col list">                            
				                                <p class="h1">${result.checkItem}</p>
				                                <c:if test="${!empty resultFile}">
					                                <div class="lst_answer" id="lst_answer1">
				                                    	<c:forEach var="i" items="${resultFile }" varStatus="status">
				                                    		<div>
				                                    			<input class="ickjs" type="checkbox" id="${i.fileId }" name="chkAttachmentFile_${i.indexSeq }_apply"/>
				                                    			<label for="${i.fileId }"><span class="i-aft i_${i.fileExtsn } link"<a href="#" onClick="javascript:fnAttachmentApplyFileDown('${result.indexSeq}','${i.fileId }'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">${i.fileName }</a></span></label>
				                                    		</div>
				                                    	</c:forEach>
				                                    </div>
				                                    <div class="lst_all_chk" id="lst_all_chk1">
				                                        <input class="ickjs" type="checkbox" id="chkAttachmentFile_${result.indexSeq}_apply" value="" onClick="javascript:fnCheckAttachmentApplyFile('${result.indexSeq}');">
				                                        <label for="chkAttachmentFile_${result.indexSeq}_apply">전체선택</label>
														<a class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentApplyFileDown('${result.indexSeq}',''); return false;">다운로드</a>
				                                    </div>
					                            </c:if>
					                        </div>
					                        <div class="col btns">${result.resultScore2}</div>
					                    </div>
					              </div><!--// lst_tblinner -->
                            </td>
                        </tr>
          				<tr>
			              <th scope="col" id="a_b" class="bdl0">평가의견</th>
			              <td headers="a_b" colspan="4" class="ta-l">${result.evlOpinion2}</td>
			            </tr>
			            <!-- 소속/산하기관만 노출 -->
			            <c:if test="${!empty result.fobjctResn or 'C' eq requestZvl.periodCd}"> 			            
				            <tr>
				              <th scope="col" id="a_c" class="bdl0">이의신청</th>
                              <td  colspan="4" style="text-align: left;">${result.fobjctResn}</td>
				            </tr>
				        </c:if>
				        <!--// 소속/산하기관만 노출 -->
			            <!-- 보건복지부, 점검원만 노출 -->
			            <c:if test="${'2' ne sessionScope.userInfo.authorId}">
							<tr>
								<th scope="col" id="a_c" class="bdl0">메모</th>
								<td headers="a_c" colspan="4" style="text-align: left;">
									${result.memo}
								</td>
							</tr>   
	 						<tr>
								<th scope="col" id="a_d" class="bdl0">첨부파일</th>
								<td headers="a_d" colspan="4" class="ta-l"> 
									<c:if test="${! empty memoFile }">
										<div class="lst_answer solo" id="lst_answer2" style="border-top: none; padding-left: 0;">
											<c:forEach var="i" items="${memoFile }" varStatus="status">
												<div>
													<input type="checkbox" class="ickjs" id="${i.fileId }" name="chkAttachmentFile_${i.indexSeq }_memo">
													<label for="${i.fileId }"><span class="link i-aft i_${i.fileExtsn }"><a href="#" onClick="javascript:fnAttachmentMemoFileDown('${result.indexSeq}','${i.fileId }'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">${i.fileName }</a></span></label>
												</div>
											</c:forEach>
										</div>
										<div class="lst_all_chk solo" id="lst_all_chk2" style="padding-left: 0;">
	                                      	<input class="ickjs" type="checkbox" id="chkAttachmentFile_${result.indexSeq}_memo" value="" onClick="javascript:fnCheckAttachmentMemoFile('${result.indexSeq}');">
	                                       	<label for="chkAttachmentFile_${result.indexSeq}_memo">전체선택</label>
	                                       	
											<a type="button" style="margin-top: 5px;" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentMemoFileDown('${result.indexSeq}',''); return false;" style="margin-top: 5px;"><span>다운로드</span></a>
										</div>			
									</c:if>							
								</td>
							</tr>  							
				        </c:if> 
				         <!--// 보건복지부, 점검원만 노출 -->              
                    </tbody>
                </table>
            </div>
            
            <div class="btn-bot noline ta-c">
<%--             	<c:if test="${'2' eq sessionScope.userInfo.authorId and 'C' eq requestZvl.periodCd}">
					<a href="#" onclick="fn_save(); return false;"  class="btn-pk n purple rv">저장</a>
				</c:if> --%>
                <a href="#" onclick="fn_goDtl(); return false;" class="btn-pk n black">목록으로</a>
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

<script>
$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square',
	radioClass: 'iradio_square'

});
</script>