<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>.lst_answer.solo, .lst_tblinner .tbls > .col.list .lst_answer{ border-top: none; }.lst_all_chk.solo, .lst_answer.solo { padding-left: 0; }.lst_all_chk.solo { padding-bottom: 5px; }/* .fileInfoP { display: inline-block; width: 25%; } */ .wrap_table2 tbody tr th:first-child{border-left: 1px solid #dcdbdb;} .wrap_table2 tbody tr th.bdl0 { border-left: none; } .icheckbox_square + label{width: 93%;}</style>
<script type="text/javascript">
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

var html = '';

$(document).ready(function(){
	
	$(".btn-pk.vs.blue").on('click',function(e){
		e.preventDefault();
	});
	
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
	
	// 해당없음 checkbox
	$(".ickjs.excp").on('ifChanged', function(e){
		fnCheckExcpPermYn(e.target.id);
	})	
	
	$(".wrap_table2 .lst_answer>div>label").each(function(){
		if($(this).height()>34) { 
			$(this).css({"marginTop":"-11px", "marginBottom" : "5px"});
			$(this).parent().css("marginTop", "15px"); 
			($(this).parent()).parent().css({"paddingTop" : "15px", "paddingBottom" : "5px"});
		}
	})
});
	
//<!--  파일 업로드에 사용 -->  
var attachmentFileArray	   	  = new Array();
var attachmentFileDeleteArray = new Array();

function request1Callback(){
	// 재등록 요청 콜백 함수
};	//request1Callback

function request2Callback(){
	// 재등록 사유
};	//request1Callback

function responsePopup(sInsttCd, indexSeq, checkItem){
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;
	
	layerPopup3.open('/mngLevelRes/reponsePopup.do?insttCd='+sInsttCd+'&&mngLevelIdxSeq='+indexSeq+'&&check_item='+encodeURIComponent(checkItem),'request1', request1Callback);
}

function fnCheckAttachmentFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "]" ).prop( "checked", $( "#chkAttachmentFile_"+ index + "all" ).prop( "checked" ) );
}  

function fnCheckExcpPermYn(index) {
	
	var cntAttachmentFile = 0;
	$( "input:checkbox[name=chkAttachmentFile_" + index + "]" ).each( function() {
		cntAttachmentFile++;
	});

	if( cntAttachmentFile > 0 ) {
		
		setTimeout(function(){
			$('.col.state.'+index+' .icheckbox_square').removeClass("checked");
			$('.col.state.'+index+' .ickjs.excp').prop("checked", false);
			
			alert( "첨부파일을 먼저 삭제 하십시요.")
		},0);
		
		return;
		
	}

	var pUrl = "/mngLevelRes/insertMngLevelExcpYn.do";
	var param = new Object();
	
	param.insttCd = '${s_instt_cd}';
	param.mngLevelIdxSeq = index;

	if( $("input:checkbox[id=" + index + "]" ).prop( "checked")) 
	{
		param.excpPermYn = "Y";
		$("#btn_"+index).hide();
	} else {
		param.excpPermYn = "N";
		$("#btn_"+index).show();
	}

	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		
	}, function(jqXHR, textStatus, errorThrown){
			
	});

}  

function fnAddAttachmentFile(gubun, index, atchmnflId, attachmentFile, checkItem) {
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;	
	
	$( "#atchmnfl_id" ).val(atchmnflId);
	$( "#indexSeq" ).val(index);
	$( "#gubun_cd" ).val(gubun);
	
	$( "#check_item" ).val(checkItem);
	
	var url			= "/crossUploader/fileUploadPopUp.do";
	var varParam	= "";
	var openParam	= "height=450px, width=500px";
	
	var attachmentFile = window.open( "", "attachmentFile", openParam );
	attachmentFile.location.href = url; 
	
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
	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
}

function fnDeleteAttachmentFile(index, atchmnflId, attachmentFile ) {
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;		

	attachmentFileDeleteArray = new Array();
	var deleteAttachmentFile = "";
	var chkAttachmentFile = "";
	$( "input:checkbox[name=chkAttachmentFile_" + index + "]" ).each( function() {
		if( $(this).prop( "checked" ) ) 
			chkAttachmentFile += "," + $(this).attr("id");;
	});
	if( chkAttachmentFile == "" )
		return;
	//
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
				attachmentFileDeleteArray.push(value);
				p_cnt++;
			}
		});	

		var pUrl = "/mngLevelRes/deleteMngLevelRes.do";
 		var param = new Object();
		
 		param.atchmnflId = p_atchmnflId;
 		param.fileId = p_fileId;
 		param.filePath = p_filePath;
 		param.modifiedFilesInfo = JSON.stringify(attachmentFileDeleteArray);
 		param.mngLevelIdxSeq = index;
 		param.insttCd = ${s_instt_cd};
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});

 		document.form.action = "/mngLevelRes/mngLevelModifyList.do";
 		document.form.submit();	 	
	}
	return;
}  

function fnAttachmentFileCallback( uploadedFilesInfo, modifiedFilesInfo ) {

	var indexSeq   = $( "#indexSeq"   ).val();
	var checkItem  = $( "#check_item" ).val();
	var sInsttCd   = $( "#s_instt_cd" ).val();
	var gubunCd    = $( "#gubun_cd" ).val();
	var atchmnflId = $( "#atchmnfl_id" ).val();
	
	var param = new Object();
	
	param.check_item = checkItem;
	param.mngLevelIdxSeq   = indexSeq;
	param.insttCd    = sInsttCd;
	param.uploadedFilesInfo = JSON.stringify(uploadedFilesInfo);
	param.gubunCd = gubunCd;
	param.atchmnfl_id =atchmnflId;
	
   if( checkItem != '' ){
		layerPopup3.open('/mngLevelRes/fileMemoPopup.do','request2', request2Callback, param);
   }else{ 
		fnUploadedFiles( uploadedFilesInfo, modifiedFilesInfo, '' );
   }

}

function fnUploadedFiles( uploadedFilesInfo, modifiedFilesInfo, memo ){
	
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

	var pUrl = "/mngLevelRes/updateMngLevelRes.do";
	var param = new Object();

	param.atchmnfl_id = $("#atchmnfl_id").val();
	param.uploadedFilesInfo = uploadedFilesInfo;
	param.modifiedFilesInfo = modifiedFilesInfo;
	
	param.insttCd = ${s_instt_cd};
	param.mngLevelIdxSeq = $("#indexSeq").val();
	param.gubunCd = $("#gubun_cd").val();
	
	param.memo = memo;
	
	if(param.atchmnfl_id == "") {
		pUrl = "/mngLevelRes/insertMngLevelRes.do";
	}

	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		
	}, function(jqXHR, textStatus, errorThrown){
			
	});
	
	document.form.action = "/mngLevelRes/mngLevelModifyList.do";
	document.form.submit();	 
	
}

function fnCheckCompleted() {
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;	
	
	// 해당없음 표시가 되어있지 않으면서 진단항목에 파일이 없는 경우
	var idx;
	<c:forEach var="i" items="${resultList }" varStatus="status">
		idx		= '${i.indexSeq}';
		if( $("input:checkbox[id=" + idx + "]" ).prop( "checked") ){
	
		}else{
			if( $(".chkAttachmentFile_" + idx).length < 1 ){
				alert( "실적등록이 완료되지 않았습니다. 실적을 등록하여 주시기 바랍니다.");
				return;
			}
		}
	</c:forEach>	
	
	var pUrl = "/mngLevelRes/checkEndMngLevelRes.do";
	var param = new Object();
	var compCnt = 0;
	var compIdxCnt = 0;
	var compCntRs04 = 0;
	var bsisCnt = 0;
	param.insttCd = '${s_instt_cd}';

	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		compCnt = data.result;
		compCntRs04 = data.resultRs04;
		compIdxCnt = data.resultIdx;
		bsisCnt	= data.bsisCnt;
	}, function(jqXHR, textStatus, errorThrown){
			
	});

	// 2018.08.06 기초현황 등록 체크 삭제
 	bsisCnt = 7;
	
 	if(bsisCnt < 7) {
		alert( "기초현황 등록이 완료되지 않았습니다. 미등록 기초항목을 등록하여 주시기 바랍니다.")
		return;
	} else {
		if( compCnt < compIdxCnt ) {
				alert( "실적등록이 완료되지 않았습니다. 미등록 실적을 등록하여 주시기 바랍니다.")
				return;
		} 
/* 		else {
			if( compCntRs04 > 0 ) {
				alert( "재등록이 완료되지 않았습니다.  재등록 실적을 등록하여 주시기 바랍니다." )
				return;
			}
		} */
	} 
	 
	<c:if test="${empty fileList}">
		alert( "결과보고서가 등록되지 않았습니다. 결과보고서를 등록하여 주시기 바랍니다." );
		return;
	</c:if>
	
	pUrl = "/mngLevelRes/updateMngLevelResStat.do";
		
	param.insttCd = '${s_instt_cd}';
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			alert( "등록완료 처리 되었습니다.");
			document.form.action = "/mngLevelRes/mngLevelModifyList.do";
			document.form.submit();	 	
				
		}, function(jqXHR, textStatus, errorThrown){
	});

}  
</script>

<form action="/mngLevelRes/mngLevelSummaryListDetail.do" method="post" id="form" name="form">
	
	<input name="lclas" id="lclas" type="hidden" value=""/>
	<input type="hidden" id="instt_cl_cd"  name="instt_cl_cd" value="${instt_cl_cd}" /> 
	<input type="hidden" id="s_instt_cl_nm"  name="s_instt_cl_nm" value="${s_instt_cl_nm}" /> 
	<input type="hidden" id="s_instt_cd" name="s_instt_cd" value="${s_instt_cd}">
	<input type="hidden" id="s_instt_nm" name="s_instt_nm" value="${s_instt_nm}">
	<input type="hidden" id="orderNo" name="orderNo" value="${requestZvl.orderNo}" />
	<input type="hidden" id="gubun_cd" name="gubun_cd" value="" />

    <!-- content -->
    <section id="container" class="sub">
       <div class="container_inner">
       
			<h1 class="title4"><c:out value='${s_instt_nm}'/> 실적등록</h1>
			<section class="area_tit1 inr-c">
				<div class="cont">
					<div class="wrap_table3">
						<table id="table-1" class="tbl">
							<caption>결과보고서 첨부 정보</caption>
							<colgroup>
								<col class="th1_1">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="col" id="th_a1">결과보고서 첨부</th>
									<td headers="th_a1">
										<a id="btn_0" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','0','${result.ATCHMNFL_ID}','attachmentFile','');return false;" ><span>파일첨부</span></a>
										<%-- <a style="margin: 0 0px 10px 20px;" id="btn_0" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','0','${result.ATCHMNFL_ID}','attachmentFile','');return false;" ><span>파일첨부</span></a> --%>
										<c:if test="${!empty fileList}"> 
											<div class="lst_answer solo chkAttachmentFile_0all">
												<c:forEach var="k" items="${fileList }" varStatus="status">
													<div>
														<input class="ickjs" type="checkbox" id="${k.FILE_ID }" name="chkAttachmentFile_0"/>
														<label for="${k.FILE_ID }">
															<span class="i-aft link i_<c:out value='${k.fileExtsn}'/>">
																<a href="#" onClick="javascript:fnAttachmentFileDown('0','${k.FILE_ID }'); return false;" class="link i_<c:out value='${k.fileExtsn}'/>">${k.FILE_NAME }</a>
															</span>
														</label>
													</div>
													<script>
														var fileInfo = new Object();
														fileInfo.idx			= "<c:out value="0"/>";
														fileInfo.atchmnflId		= "<c:out value="${result.ATCHMNFL_ID}"/>";
														fileInfo.fileId			= "<c:out value="${k.FILE_ID}"/>";
														fileInfo.fileName		= "<c:out value="${k.FILE_NAME}"/>";
														fileInfo.saveFileName	= "<c:out value="${k.SAVE_FILE_NAME}"/>";
														fileInfo.filePath		= "<c:out value="${k.FILE_PATH}"/>";
														fileInfo.mimeType		= "<c:out value=""/>";
														fileInfo.isDeleted		= "false";
														fileInfo.modifiedFileId	= "<c:out value="${k.FILE_ID}"/>";
														fileInfo.fileUrl	= "";											// 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
														attachmentFileArray.push( fileInfo );
													</script>										 
												</c:forEach>
											</div>
											<div class="lst_all_chk solo">
												<input type="checkbox" class="ickjs" id="chkAttachmentFile_0all" value="" onClick="javascript:fnCheckAttachmentFile('0');">
												<label for="label4">전체선택</label>
												<a class="btn-pk ss purple rv fl-r ml10" onClick="javascript:fnDeleteAttachmentFile('0','','attachmentFile'); return false;"><span>파일삭제</span></a>
												<a value="다운로드" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown('0',''); return false;"><span>다운로드</span></a>
											</div>
										</c:if>										
									</td>
								</tr>

							</tbody>
						</table>
					</div>
				</div>
			</section>
			
                <c:choose>
					<c:when test="${!empty resultList}">
                		
		                <div class="wrap_table2">
		                    <table id="table-1" class="tbl">
		                        <caption>실적등록및조회 상세</caption>
		                        <colgroup>
									<col class="th1_1">
									<col class="th1_6">
									<col>
									<col class="th1_0">
									<col class="th1_3">
									<col class="th1_4">
		                        </colgroup>
		                        <thead>
		                            <tr>
										<th scope="col" id="th_a">분야</th>
										<th scope="col" id="th_b">진단지표</th>
										<th scope="col" id="th_c">진단항목</th>
										<th scope="col" id="th_d">실적등록</th>
										<th scope="col" id="th_g">해당없음</th>
										<th scope="col" id="th_e">재등록요청</th>	                                
		                            </tr>
		                        </thead>
		                        <tbody>
		                        	<c:set var="tmpLclas" value=""/>
                                    <c:set var="tmpMlsfc" value=""/>
                                    
                                    <c:forEach var="list" items="${resultList}" varStatus="status">
                                    	<c:choose>
											<c:when test="${status.first}">
												<tr>
					                                <th rowspan="${list.maxlclasCnt}" scope="col" class="bdl0">${list.lclas}</th>
					                                <th scope="row" class="ta-l">${list.mlsfc}</th>
					                                <td colspan="4" class="pd0">
					                                
					                                <!-- 파일이 있을때 -->
					                                <c:if test="${list.fileId !='' }">
					                                	<div class="lst_tblinner">
															<div class="tbls">
																<div class="col list">
																	<p class="h1">${list.checkItem}</p>
																	<div class="lst_answer chkAttachmentFile_${list.indexSeq}">
																		<div>
																			<input type="checkbox" id="${list.fileId}" name="chkAttachmentFile_<c:out value='${list.indexSeq}'/>" class="ickjs">
																			<label for="${list.fileId}"><span class="i-aft i_${list.fileExtsn} link"><a href="#"  onClick="javascript:fnAttachmentFileDown('${list.indexSeq}','${list.fileId }'); return false;" class="f_<c:out value='${list.fileExtsn}'/>">${list.fileName}</a></span></label>
																		</div>
													</c:if>	
													
													<!-- 파일이 없을때 -->
													<c:if test="${list.fileId =='' }">
														<div class="lst_tblinner">
															<div class="tbls">
																<div class="col list">
																	<p class="h1">${list.checkItem}</p>
																</div>
																<div class="col state w2">
																	<c:if test="${list.status == ''}">
																		<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																	</c:if>
																	<c:if test="${list.status == 'RS03' }">
																		<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																	</c:if>
																	<c:if test="${list.status == 'RS04'}">
																		<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																	</c:if>
																	<c:if test="${list.status == 'RS05'}">
																		<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																	</c:if>																
																</div><!-- //col state w2 -->    																
																<div class="col state ${list.indexSeq}">
																	<input type="checkbox" id="${list.indexSeq}" class="ickjs excp" value="1" <c:if test="${list.excpYn eq 'Y'}">checked="true"</c:if> <c:if test="${list.excpPermYn eq 'N'}"> style="display:none"</c:if>>																
																	<label for="${list.indexSeq}" class="blind">해당없음</label>
			                                					</div>
																<div class="col btns">
																	<c:if test="${reqStatus == 'RS04' || reqStatus == 'RS05'}">
																		<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onClick="responsePopup('${s_instt_cd}', '${list.indexSeq}', '${list.checkItem}');"><span>사유</span></a>
																	</c:if>															
																</div>
															</div>	
														</div>															
													</c:if>		
																		
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${list.lclas != tmpLclas}">
																<c:if test="${fileId !='' }">
																	</div><!-- //lst_answer -->
																	<div class="lst_all_chk">
																		<input type="checkbox" id="chkAttachmentFile_<c:out value='${indexSeq}'/>" class="ickjs" onclick="fnCheckAttachmentFile('${indexSeq}');">
																		<label for="chkAttachmentFile_<c:out value='${indexSeq}'/>">전체선택</label>
																		<a href="#" class="btn-pk ss purple rv fl-r ml10" onClick="javascript:fnDeleteAttachmentFile('${indexSeq}','','attachmentFile'); return false;"><span>파일삭제</span></a>
																		<a href="#" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown('${indexSeq}',''); return false;"><span>다운로드</span></a>
																	</div>
                                    							</div><!-- //col list -->
																<div class="col state w2">
																	<c:if test="${reqStatus == ''}">
																		<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																	</c:if>
																	<c:if test="${reqStatus == 'RS03' }">
																		<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																	</c:if>
																	<c:if test="${reqStatus == 'RS04'}">
																		<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																	</c:if>
																	<c:if test="${reqStatus == 'RS05'}">
																		<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																	</c:if>																				
																</div><!-- //col state w2 -->                                        							
                                    							<div class="col state ${indexSeq}">
																	<input type="checkbox" id="${indexSeq}" class="ickjs excp" value="1" <c:if test="${excpYn eq 'Y'}">checked="true"</c:if> <c:if test="${excpPermYn eq 'N'}"> style="display:none"</c:if>>																
																	<label for="${indexSeq}" class="blind">해당없음</label>
                                    							</div>
																<div class="col btns">
																	<c:if test="${reqStatus == 'RS04' || reqStatus == 'RS05'}">
																		<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onClick="responsePopup('${s_instt_cd}', '${indexSeq}', '${checkItem}');"><span>사유</span></a>
																	</c:if>	
																</div>
															</div> <!-- //tbls -->
															<div class="lst_log">
																<span>Log.</span>
																<div class="log ${indexSeq}"></div>
															</div>
														</div><!--// lst_tblinner -->
															</td>
															</tr>
															<script>
																$(".log.${indexSeq}").append(html); html = ''; 
																$(".lst_log .log").each(function(){
																	if($(this).html() == '') $(this).prev().css("top", "14px");	
																})
															</script>
	                										</c:if>
													
														<tr>
															<th rowspan="${list.maxlclasCnt}" scope="col" class="bdl0">${list.lclas}</th>
							                                <th scope="row" class="ta-l">${list.mlsfc}</th>
							                                <td colspan="4" class="pd0">
							                                		
							                                		<!-- 파일이없을때 -->
							                                		<c:if test="${list.fileId =='' }">
								                                		<div class="lst_tblinner">
																			<div class="tbls">
																				<div class="col list">
																					<p class="h1">${list.checkItem}</p>
																				</div>
																				<div class="col state w2">
																					<c:if test="${list.status == ''}">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>
																					<c:if test="${list.status == 'RS03' }">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>
																					<c:if test="${list.status == 'RS04'}">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>
																					<c:if test="${list.status == 'RS05'}">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>																							
																				</div><!-- //col state w2 -->    																				
				                                    							<div class="col state ${list.indexSeq}">
																					<input type="checkbox" id="${list.indexSeq}" class="ickjs excp" value="1" <c:if test="${list.excpYn eq 'Y'}">checked="true"</c:if> <c:if test="${list.excpPermYn eq 'N'}"> style="display:none"</c:if>>																
																					<label for="${list.indexSeq}" class="blind">해당없음</label>				                                    							
				                                    							</div>
																				<div class="col btns">
																					<c:if test="${reqStatus == 'RS04' || reqStatus == 'RS05'}">
																						<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onClick="responsePopup('${s_instt_cd}', '${list.indexSeq}', '${list.checkItem}');"><span>사유</span></a>
																					</c:if>																			
																				</div>																					
																			</div>
																		</div>
							                                		</c:if>
																	
																	<!-- 파일이있을때 -->                            							                                									                                									                                		
							                                		<c:if test="${list.fileId !='' }">
							                                		<div class="lst_tblinner">
																		<div class="tbls">
																			<div class="col list">
																				<p class="h1">${list.checkItem}</p>
																				<div class="lst_answer chkAttachmentFile_${list.indexSeq}">
																					<div>
																						<input type="checkbox" id="${list.fileId}" name="chkAttachmentFile_<c:out value='${list.indexSeq}'/>" class="ickjs">
																						<label for="${list.fileId}"><span class="i-aft i_${list.fileExtsn} link"><a href="#"  onClick="javascript:fnAttachmentFileDown('${list.indexSeq}','${list.fileId }'); return false;" class="f_<c:out value='${list.fileExtsn}'/>">${list.fileName}</a></span></label>
																					</div>
                            										</c:if>                                 							                                									                                									                                		
 													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${list.mlsfc != tmpMlsfc}">
					                                			 <c:if test="${fileId !='' }">
		                           											</div><!-- lst_answer -->
																			<div class="lst_all_chk">
																				<input type="checkbox" id="chkAttachmentFile_<c:out value='${indexSeq}'/>" class="ickjs" onClick="javascript:fnCheckAttachmentFile('${indexSeq}');">
																				<label for="chkAttachmentFile_<c:out value='${indexSeq}'/>">전체선택</label>
																				<a href="#" class="btn-pk ss purple rv fl-r ml10" onClick="javascript:fnDeleteAttachmentFile('${indexSeq}','','attachmentFile'); return false;"><span>파일삭제</span></a>
																				<a href="#" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown('${indexSeq}',''); return false;"><span>다운로드</span></a>
																			</div>
		                                    							</div><!-- col list -->
																		<div class="col state w2">
																			<c:if test="${reqStatus == ''}">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>
																			<c:if test="${reqStatus == 'RS03' }">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>
																			<c:if test="${reqStatus == 'RS04'}">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>
																			<c:if test="${reqStatus == 'RS05'}">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>																				
																		</div><!-- //col state w2 -->                                        							
		                                    							<div class="col state ${indexSeq}">
																			<input type="checkbox" id="${indexSeq}" class="ickjs excp" value="1" <c:if test="${excpYn eq 'Y'}">checked="true"</c:if> <c:if test="${excpPermYn eq 'N'}"> style="display:none"</c:if>>																
																			<label for="${indexSeq}" class="blind">해당없음</label>
		                                    							</div>
																		<div class="col btns">
																			<c:if test="${reqStatus == 'RS04' || reqStatus == 'RS05'}">
																				<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onClick="responsePopup('${s_instt_cd}', '${indexSeq}', '${checkItem}');"><span>사유</span></a>
																			</c:if>	
																		</div>
																	</div> <!-- tbls -->
																	<div class="lst_log">
																		<span>Log.</span>
																		<div class="log ${indexSeq}"></div>
																	</div>
																</div><!--// lst_tblinner -->
                           											</td>
							                                		</tr>
							                                		<script>
							                                			$(".log.${indexSeq}").append(html); html = ''; 
							                                			$(".lst_log .log").each(function(){
																			if($(this).html() == '') $(this).prev().css("top", "14px");	
																		})
							                                		</script>
		                										</c:if>
															
																<tr>
									                                <th scope="row" class="ta-l">${list.mlsfc}</th>
									                                <td colspan="4" class="pd0">
							                                		
							                                		<!-- 파일이없을때 -->
							                                		<c:if test="${list.fileId =='' }">
							                                			<div class="lst_tblinner">
																			<div class="tbls">
																				<div class="col list">
																					<p class="h1">${list.checkItem}</p>
																				</div>
																				<div class="col state w2">
																					<c:if test="${list.status == ''}">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>
																					<c:if test="${list.status == 'RS03' }">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>
																					<c:if test="${list.status == 'RS04'}">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>
																					<c:if test="${list.status == 'RS05'}">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>																								
																				</div><!-- //col state w2 -->    																				
				                                    							<div class="col state ${list.indexSeq}">
																					<input type="checkbox" id="${list.indexSeq}" class="ickjs excp" value="1" <c:if test="${list.excpYn eq 'Y'}">checked="true"</c:if> <c:if test="${list.excpPermYn eq 'N'}"> style="display:none"</c:if>>																
																					<label for="${list.indexSeq}" class="blind">해당없음</label>			                                    							
				                                    							</div>
																				<div class="col btns">
																					<c:if test="${reqStatus == 'RS04' || reqStatus == 'RS05'}">
																						<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onClick="responsePopup('${s_instt_cd}', '${list.indexSeq}', '${list.checkItem}');"><span>사유</span></a>
																					</c:if>																					
																				</div>																				
																			</div>
																		</div>
                            										</c:if>
																	
																	<!-- 파일이있을때 -->                            										                              							                                									                                									                                		
							                                		<c:if test="${list.fileId !='' }">
																		<div class="lst_tblinner">
																			<div class="tbls">
																				<div class="col list">
																					<p class="h1">${list.checkItem}</p>
																					<div class="lst_answer chkAttachmentFile_${list.indexSeq}">
																						<div>
																							<input type="checkbox" id="${list.fileId}" name="chkAttachmentFile_<c:out value='${list.indexSeq}'/>" class="ickjs">
																							<label for="${list.fileId}"><span class="i-aft i_${list.fileExtsn} link"><a href="#"  onClick="javascript:fnAttachmentFileDown('${list.indexSeq}','${list.fileId }'); return false;" class="f_<c:out value='${list.fileExtsn}'/>">${list.fileName}</a></span></label>
																						</div>
                            										</c:if>                
															</c:when>
															<c:otherwise>
																<c:choose>
																<c:when test="${list.checkItem != checkItem}">
					                                			 <c:if test="${fileId !='' }">
                            											</div><!-- lst_answer -->
																			<div class="lst_all_chk">
																				<input type="checkbox" id="chkAttachmentFile_<c:out value='${indexSeq}'/>" class="ickjs" onClick="javascript:fnCheckAttachmentFile('${indexSeq}');">
																				<label for="chkAttachmentFile_<c:out value='${indexSeq}'/>">전체선택</label>
																				<a href="#" class="btn-pk ss purple rv fl-r ml10" onClick="javascript:fnDeleteAttachmentFile('${indexSeq}','','attachmentFile'); return false;"><span>파일삭제</span></a>
																				<a href="#" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown('${indexSeq}',''); return false;"><span>다운로드</span></a>
																			</div>
		                                    							</div><!-- col list -->
																		<div class="col state w2">
																			<c:if test="${reqStatus == ''}">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>
																			<c:if test="${reqStatus == 'RS03' }">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>
																			<c:if test="${reqStatus == 'RS04'}">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>
																			<c:if test="${reqStatus == 'RS05'}">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>																				
																		</div><!-- //col state w2 -->                                        							
		                                    							<div class="col state ${indexSeq}">
																			<input type="checkbox" id="${indexSeq}" class="ickjs excp" value="1" <c:if test="${excpYn eq 'Y'}">checked="true"</c:if> <c:if test="${excpPermYn eq 'N'}"> style="display:none"</c:if>>																
																			<label for="${indexSeq}" class="blind">해당없음</label>
		                                    							</div>
																		<div class="col btns">
																			<c:if test="${reqStatus == 'RS04' || reqStatus == 'RS05'}">
																				<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onClick="responsePopup('${s_instt_cd}', '${indexSeq}', '${checkItem}');"><span>사유</span></a>
																			</c:if>																		
																		</div>
																	</div> <!-- tbl	s -->
																	<div class="lst_log">
																		<span>Log.</span>
																		<div class="log ${indexSeq}"></div>
																	</div>
																</div><!--// lst_tblinner -->
																<script>
																	$(".log.${indexSeq}").append(html); html = ''; $(".log.${indexSeq} p").css("minHeight", "25px");
																	$(".lst_log .log").each(function(){
																		if($(this).html() == '') $(this).prev().css("top", "14px");	
																	})
																</script>
		                										</c:if>
																
							                                		<!-- 파일이없을때* -->
							                                		<c:if test="${list.fileId =='' }">
								                                		<div class="lst_tblinner">
																			<div class="tbls">
																				<div class="col list">
																					<p class="h1">${list.checkItem}</p>
																				</div>
																				<div class="col state w2">
																					<c:if test="${list.status == ''}">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>
																					<c:if test="${list.status == 'RS03' }">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>
																					<c:if test="${list.status == 'RS04'}">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>
																					<c:if test="${list.status == 'RS05'}">
																						<a id="btn_${list.indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${list.indexSeq}','${list.atchmnflId}','attachmentFile','${list.checkItem}');return false;" <c:if test="${list.excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																					</c:if>																							
																				</div><!-- //col state w2 -->    																				
				                                    							<div class="col state ${list.indexSeq}">
																					<input type="checkbox" id="${list.indexSeq}" class="ickjs excp" value="1" <c:if test="${list.excpYn eq 'Y'}">checked="true"</c:if> <c:if test="${list.excpPermYn eq 'N'}"> style="display:none"</c:if>>																
																					<label for="${list.indexSeq}" class="blind">해당없음</label>				                                    							
				                                    							</div>
																				<div class="col btns">
																					<c:if test="${reqStatus == 'RS04' || reqStatus == 'RS05'}">
																						<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onClick="responsePopup('${s_instt_cd}', '${list.indexSeq}', '${list.checkItem}');"><span>사유</span></a>
																					</c:if>																			
																				</div>																					
																			</div>
																		</div>
							                                		</c:if>
							                                		
																	<!-- 파일이있을때 -->                           										                              							                                									                                									                                		
							                                		<c:if test="${list.fileId !='' }">
																		<div class="lst_tblinner">
																			<div class="tbls">
																				<div class="col list">
																					<p class="h1">${list.checkItem}</p>
																					<div class="lst_answer chkAttachmentFile_${list.indexSeq}">
																						<div>
																							<input type="checkbox" id="${list.fileId}" name="chkAttachmentFile_<c:out value='${list.indexSeq}'/>" class="ickjs">
																							<label for="${list.fileId}"><span class="i-aft i_${list.fileExtsn} link"><a href="#"  onClick="javascript:fnAttachmentFileDown('${list.indexSeq}','${list.fileId }'); return false;" class="f_<c:out value='${list.fileExtsn}'/>">${list.fileName}</a></span></label>
																						</div>
                            										</c:if> 
																                       							                                									                                									                                		
																</c:when>
																<c:otherwise>
	                                    							<div>
																		<input type="checkbox" id="${list.fileId}" name="chkAttachmentFile_<c:out value='${list.indexSeq}'/>" class="ickjs">
																		<label for="${list.fileId}"><span class="i-aft i_${list.fileExtsn} link"><a href="#"  onClick="javascript:fnAttachmentFileDown('${list.indexSeq}','${list.fileId }'); return false;" class="f_<c:out value='${list.fileExtsn}'/>">${list.fileName}</a></span></label>
																	</div>
                                                           		</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
				                                <c:set var="tmpLclas" value="${list.lclas}"/>
                                   				<c:set var="tmpMlsfc" value="${list.mlsfc}"/>
				                    			<c:set var="checkItem" value="${list.checkItem}"/>  
				                    			<c:set var="fileId" value="${list.fileId}"/>                                   				
				                    			<c:set var="atchmnflId" value="${list.atchmnflId}"/>                                   				
				                    			<c:set var="indexSeq" value="${list.indexSeq}"/>                                   				
				                    			<c:set var="excpPermYn" value="${list.excpPermYn}"/>                                   				
				                    			<c:set var="excpYn" value="${list.excpYn}"/>                                   				
				                    			<c:set var="reqStatus" value="${list.status}"/>                                   				
				                    			<c:set var="requstDe" value="${list.requstDe}"/>                                   				
				                    			<c:set var="fileExtsn" value="${list.fileExtsn}"/>  
										<c:if test="${list.fileId !='' }">
					                                <script>
					                            	var fileInfo = new Object();
					                            	
					                            	fileInfo.idx			= "<c:out value="${list.indexSeq}"/>";
					                            	fileInfo.atchmnflId		= "<c:out value="${list.atchmnflId}"/>";
					                            	fileInfo.fileId			= "<c:out value="${list.fileId}"/>";
					                            	fileInfo.fileName		= "<c:out value="${list.fileName}"/>";
					                            	fileInfo.saveFileName	= "<c:out value="${list.saveFileName}"/>";
					                            	fileInfo.filePath		= "<c:out value="${list.filePath}"/>";
					                            	fileInfo.mimeType		= "<c:out value="${list.mimeType}"/>";
					                            	fileInfo.isDeleted		= "false";
					                            	fileInfo.modifiedFileId	= "<c:out value="${list.fileId}"/>";
					                            	fileInfo.fileUrl	= "";											// 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
					                            	attachmentFileArray.push( fileInfo );
					                            	
					                            	// 첨부파일 업로드시 변경 사유 메모/ 입력 날짜
					                            	fileInfo.memo			= "<c:out value="${list.memo}"/>";
					                            	fileInfo.memoRegistDt	= "<c:out value="${list.memoRegistDt}"/>";
					                            	
					                            	if(fileInfo.memo != ''){
					                            		html += '<p><span class="fileInfoP">['+ fileInfo.memoRegistDt +'] ' + fileInfo.fileName +' 업로드</span><span class="t_memo"> 메모 : ' + fileInfo.memo + '</span></p><div class="clear" style="clear:both;"></div>';
					                            	}
					                                </script>										
										</c:if>										
									</c:forEach>
												<c:if test="${fileId !='' }">
																		</div><!-- lst_answer -->
																			<div class="lst_all_chk">
																				<input type="checkbox" id="chkAttachmentFile_<c:out value='${indexSeq}'/>" class="ickjs" onClick="javascript:fnCheckAttachmentFile('${indexSeq}');">
																				<label for="chkAttachmentFile_<c:out value='${indexSeq}'/>">전체선택</label>
																				<a href="#" class="btn-pk ss purple rv fl-r ml10" onClick="javascript:fnDeleteAttachmentFile('${indexSeq}','','attachmentFile'); return false;"><span>파일삭제</span></a>
																				<a href="#" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown('${indexSeq}',''); return false;"><span>다운로드</span></a>
																			</div>
		                                    							</div><!-- col list -->
																		<div class="col state w2">
																			<c:if test="${reqStatus == ''}">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>
																			<c:if test="${reqStatus == 'RS03' }">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('1','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>
																			<c:if test="${reqStatus == 'RS04'}">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>
																			<c:if test="${reqStatus == 'RS05'}">
																				<a id="btn_${indexSeq}" class="btn-pk vs blue" onClick="javascript:fnAddAttachmentFile('2','${indexSeq}','${atchmnflId}','attachmentFile','${checkItem}');return false;" <c:if test="${excpYn eq 'Y'}"> style="display:none"</c:if>><span>파일첨부</span></a>
																			</c:if>																				
																		</div><!-- //col state w2 -->                                        							
		                                    							<div class="col state ${indexSeq}">
																			<input type="checkbox" id="${indexSeq}" class="ickjs excp" value="1" <c:if test="${excpYn eq 'Y'}">checked="true"</c:if> <c:if test="${excpPermYn eq 'N'}"> style="display:none"</c:if>>																
																			<label for="${indexSeq}" class="blind">해당없음</label>
		                                    							</div>
																		<div class="col btns">
																			<c:if test="${reqStatus == 'RS04' || reqStatus == 'RS05'}">
																				<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onClick="responsePopup('${s_instt_cd}', '${indexSeq}', '${checkItem}');"><span>사유</span></a>
																			</c:if>	
																		</div>
																	</div> <!-- tbls -->
																	<div class="lst_log">
																		<span>Log.</span>
																		<div class="log ${indexSeq}"></div>
																	</div>
																</div><!--// lst_tblinner -->
																</td>
                       										</tr>
                       										<script>
                       											$(".log.${indexSeq}").append(html); html = ''; 
																$(".lst_log .log").each(function(){
																	if($(this).html() == '') $(this).prev().css("top", "14px");	
																})
	                       									</script>
                            					</c:if>                                 							                                									                                									                                											
		                        </tbody>
		                    </table>
		                </div>
		            </c:when>
                    <c:otherwise>
                        <div class="box1 mt20">
		                    <p class="c_gray f17">등록된 지표가 없습니다.</p>
		                    <p class="mt20">※ <strong class="c_blue">지표등록</strong>을 관리자에게 문의해주세요.</p>
		                </div>
                    </c:otherwise>
                </c:choose>
                
	            <div class="btn-bot2 ta-c">
	            	<a id="createMngLevelRes" class="btn-pk n rv blue" onClick="javascript:fnCheckCompleted('1'); return false;">등록완료</a>
	            </div>
        </div>
    </section>
  	<!--  파일 업로드에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="" > 
	<input type="hidden" id="indexSeq" name="indexSeq" value="" >
	<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" >
	
	<input type="hidden" id="check_item" name="check_item" value="" >  
	<!--  파일 업로드에 사용 -->               
    
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