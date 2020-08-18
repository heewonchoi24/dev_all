<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	.i-aft.link a { text-decoration: underline; color: #0d6090; font-size: 13px; }
	.iradio_square {
	    background-position: -210px -9px;
	    background-size: 394px;
	}
	.iradio_square.checked {
	    background-position: -284px -9px;
	}
	.iradio_square.disabled {
	    background-position: -320px -9px;
	    cursor: default;
	}
</style>
<script type="text/javascript">
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

var pUrl, pParam;
var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	var msg = '${message}';
	if(msg){ alert(msg); }
	
	// 체크박스 전체 클릭 시
	$(".ickjs.allChk").on('ifChanged', function(e){
		if( $(".ickjs.allChk").is(":checked")) $('[name*="chkAttachmentFile_"]').iCheck("check");
		else $('[name*="chkAttachmentFile_"]').iCheck("uncheck");
	});
    
	// 첫 번째 검색 옵션 선택 시
	$(document).on("click","#insttClCdList>li>a",function(e){
		e.preventDefault();
		$("#instt_cl_cd").val(this.dataset.clcd);
		$("#instt_cl_nm").val(this.dataset.clnm);
		changeInsttList(this.dataset.clcd);
	});
	
	// 두 번째 검색 옵션 선택 시
	$(document).on("click","#insttCdList>li>a",function(){
		$("#instt_cd").val(this.dataset.cd);
		$("#instt_nm").val(this.dataset.nm);
		selectList();
	});
	
	// 차수 옵션 선택 시
	$(document).on("click","#yyyy>li>a",function(){
		$("#order_no").val(this.dataset.yyyy);
		selectList();
	});
});

// 첫 번째 검색 옵션 선택하여 두 번째 옵션 리스트 가져오기
function changeInsttList(instt_cl_cd){
	
	pUrl = "/statusExaminReq/statusExaminInsttListAjax.do";
	pParam = {};
	pParam.instt_cl_cd = instt_cl_cd;

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		var str = '';
			str += '<div class="selectVal insttSelectVal" tabindex="0">'; 	
			str += '<a href="#this" tabindex="-1">선택해주세요</a>'; 	
			str += '</div>'; 	
			str += '<ul class="selectMenu insttSelectMenu" id="insttCdList">'; 
		for(var i in data.resultList){
			str += '<li><a href="#" data-cd="' + data.resultList[i].INSTT_CD + '" data-nm="' + data.resultList[i].INSTT_NM +'">' + data.resultList[i].INSTT_NM + '</a></li>'; 	
		}
			str += '</ul>';
		$(".box-select-ty1.type1.sec").html(str);
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}

function goBack(){
	$( "#insttCd").val("");
	$( "#insttClCd").val("");
	$( "#s_index_seq").val("");
	
	$("#form").attr({
        action : '/statusExaminReq/statusExaminResultModifyList.do',
        method : "post"
    }).submit();
}

function selectList(){
	$("#form").attr({
        action : "/statusExaminReq/statusExaminResultMemoList.do",
        method : "post"
    }).submit();
}

function done(atchmnflId){
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;
	
	if($("#periodCd").val() != "E") {
		alert( "현장점검 등록 기간이 아닙니다. 확인바랍니다.");
		return false;
	}
	var radioCnt = 0;
	var checkedCnt = 0;
	var checkedYCnt = 0;
	var checkedPCnt = 0;
	var checkedNCnt = 0;
	var checkedNACnt = 0;
    var p_name =  [];
    var p_val  =  [];
    var p_save_name  = "";

    $( "#atchmnfl_id").val(atchmnflId);
    $("input:radio").each(function( key ) {
    	var name = $(this).attr("name");
    	
		if(radioCnt== 0)  p_save_name = name;
		
    	if($(this).prop("checked")) {
    		checkedCnt++;
    		p_name[radioCnt] = name;
    		p_val[radioCnt]  = $(this).val();
    		if($(this).val() == 'Y') {
    			checkedYCnt++;
    		} else if ($(this).val() == 'P') {
    			checkedPCnt++;
    		} else if ($(this).val() == 'N') {
    			checkedNCnt++;
    		} else if ($(this).val() == 'N/A') {
    			checkedNACnt++;
    		}
    	}
        radioCnt++;
    });

    if(checkedCnt < radioCnt/4) {
    	alert("점검 결과는 필수 입력 사항입니다."); 
    	return;
    };
	
	pParam = {};
	pUrl = '/statusExaminReq/insertStatusExaminRes.do';
	
	pParam.instt_cd = '${instt_cd}';
	pParam.index_seq = '${s_index_seq}';
	if($("#periodCd").val() =="E")
	{
		if(checkedCnt == checkedNACnt) {
			pParam.resultScore1 = '';
			pParam.resultScore2 = '';
		} else {
			pParam.resultScore1 = ((checkedYCnt * 1) + (checkedPCnt * 0.5))/(checkedYCnt + checkedPCnt + checkedNCnt) * 100;
			pParam.resultScore2 = ((checkedYCnt * 1) + (checkedPCnt * 0.5))/(checkedYCnt + checkedPCnt + checkedNCnt) * 100;
		}
		pParam.status = "ES01";
	}
	pParam.detail_seq = p_name;
	pParam.detail_val = p_val;
	pParam.memo = $("#memo").val();
	pParam.evlOpinion = $("#evl_opinion").val();

	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.gubun     = '2';
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		alert(data.message);
	}, function(jqXHR, textStatus, errorThrown){
			
	});
	
	goBack();
}

// 파일 다운로드
function fnAttachmentEvlFileDown( index, atchmnflId ) {
	
	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;
	
	var chkAttachmentFile = atchmnflId;
	// Check Box 선택 
	if( atchmnflId == "" ) {
		$( "input:checkbox[name=chkAttachmentFile_" + index + "_evl]" ).each( function() {
			if( $(this).prop( "checked" ) ) 
				chkAttachmentFile += "," + $(this).attr("id");

		});
		chkAttachmentFile = chkAttachmentFile.substring( 1, chkAttachmentFile.length );
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

// 메모 첨부파일 다운로드
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

// 메모 첨부 파일 업로드
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
	$( "#uploadedFilesInfo" ).val( uploadedFilesInfo );
	$( "#modifiedFilesInfo" ).val( modifiedFilesInfo );
	
	pParam = {};
	pUrl = "/statusExaminReq/updateStatusExaminRes.do";

	pParam.atchmnfl_id = $("#atchmnfl_id").val();
	pParam.uploadedFilesInfo = uploadedFilesInfo;
	pParam.modifiedFilesInfo = modifiedFilesInfo;
	
	pParam.instt_cd  = '${instt_cd}';
	pParam.index_seq = '${s_index_seq}';
	pParam.gubun     = '2';
	
	pParam.resultScore1 = $("s_result_score").val();
	pParam.resultScore2 = $("s_result_score").val();

	pParam.memo = $("#memo").val();
	pParam.evlOpinion = $("#evl_opinion").val();

	if(pParam.atchmnfl_id == "") {
		pUrl = "/statusExaminReq/insertStatusExaminRes.do";
	}

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		//alert(data.message);
	}, function(jqXHR, textStatus, errorThrown){
			
	});

	document.form.action = "/statusExaminReq/statusExaminResultMemoList.do";
	document.form.submit();
}

// 파일 삭제
function fnDeleteAttachmentFile(index, atchmnflId, attachmentFile ) {
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;	

	var deleteAttachmentFile = "";
	var chkAttachmentFile = "";
	$( "input:checkbox[name=chkAttachmentFile_" + index + "_memo]" ).each( function() {
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
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});

 		document.form.action = "/statusExaminReq/statusExaminResultMemoList.do";
 		document.form.submit();	 	
	}
	return;
} 
</script>

<form method="post" id="form" name="form">
	<input type="hidden" id="order_no" name="order_no" value="${order_no }"/>
	<input type="hidden" id="instt_cd" name="instt_cd" value="${instt_cd }"/>
	<input type="hidden" id="instt_nm" name="instt_nm" value="${instt_nm }"/>
	<input type="hidden" id="instt_cl_cd" name="instt_cl_cd"  value="${instt_cl_cd }"/>
	<input type="hidden" id="instt_cl_nm" name="instt_cl_nm"  value="${instt_cl_nm }"/>
	<input type="hidden" name="result_score" value="${statusExaminInsttIdxDetailList[0].RESULT_SCORE2 }"/>
	<input type="hidden" id="periodCd" name="periodCd" value="${requestZvl.periodCd }"/>
	<input type="hidden" id="s_index_seq" name="s_index_seq" value="${requestZvl.s_index_seq }"/>
	
	<!--  파일 업로드에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="${statusExaminRegist.ATCHMNFL_ID }" > 
	<input type="hidden" id="indexSeq" name="indexSeq" value="" > 
	<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
	<!--  파일 업로드에 사용 -->              
	 
<section id="container" class="sub">
    <!-- content -->
    <div id="container" class="container_inner">
            	
		<div class="layer-header1 clearfix">
			<div class="col-rgh">
				<span class="ico_state i_eval"><em>현장점검</em></span>
				<span class="ico_state i_result_total"><em>최종결과</em></span>
			</div>
		</div>
			
            <div class="wrap_table2">
                <table id="table-1" class="tbl" summary="대분류, 중분류, 소분류, 점검지표, 점검결과-Y,P,N,N/A로 구성된 현장점검결과 입력입니다.">
                    <caption>현장점검 등록 상세메모</caption>
                    <colgroup>
						<col class="th1_1">
						<col class="th1_2">
						<col>
						<col class="th1_5">
						<col class="th1_5">
						<col class="th1_5">
						<col class="th1_5">
					</colgroup>
                    <thead>
                        <tr>
                            <th scope="col" >분야</th>
                            <th scope="col" >진단지표</th>
                            <th scope="col" >진단항목</th>
                            <th scope="col">Y</th>
                            <th scope="col">P</th>
                            <th scope="col">N</th>
                            <th scope="col">N/A</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="col" class="bdl0">${statusExaminRegist.LCLAS}</th>
                            <td scope="col" class="ta-l">${statusExaminRegist.MLSFC }</td>
                            <td class="ta-l bg_orange"><span>${statusExaminRegist.CHECK_ITEM } </span></td>
							
                            <c:forEach var="j" items="${statusExaminInsttIdxDetailList }" varStatus="status">
								<c:choose>
								 <c:when test="${requestZvl.periodCd eq 'E'}">
	                                <!-- <td class="ta-l">${j.CHECK_ITEM }</td> --> <!-- 이건 주석처리 안해제 -->
	                                <td>
	                                	<div class="iradio_square">
											<input type="radio" class="ickjs" id="label<c:out value='${j.INDEX_DETAIL_SEQ}'/>" name="<c:out value='${j.INDEX_DETAIL_SEQ}'/>" value='Y' <c:if test="${j.detailScore2 eq 'Y'}">checked</c:if> >
										</div>
									</td>
									<td>
										<div class="iradio_square">
											<input type="radio" class="ickjs" id="label<c:out value='${j.INDEX_DETAIL_SEQ}'/>" name="<c:out value='${j.INDEX_DETAIL_SEQ}'/>" value='P' <c:if test="${j.detailScore2 eq 'P'}">checked</c:if>>
										</div>
									</td>
									<td>
										<div class="iradio_square">
											<input type="radio" class="ickjs" id="label<c:out value='${j.INDEX_DETAIL_SEQ}'/>" name="<c:out value='${j.INDEX_DETAIL_SEQ}'/>" value='N' <c:if test="${j.detailScore2 eq 'N'}">checked</c:if>>
										</div>
									</td>
									<td>
										<div class="iradio_square">
											<input type="radio" class="ickjs" id="label<c:out value='${j.INDEX_DETAIL_SEQ}'/>" name="<c:out value='${j.INDEX_DETAIL_SEQ}'/>" value='N/A' <c:if test="${j.detailScore2 eq 'N/A'}">checked</c:if> <c:if test="${statusExaminRegist.EXCP_PERM_YN eq 'N'}">disabled</c:if>>
										</div>
	                                 </td>
								</c:when>
								<c:otherwise>
                                 	<td class="tc">
                                 		<c:if test="${j.detailScore2 eq 'Y' && j.STATUS eq 'ES01'}"><span class="ico_state i_eval"><em>현장점검</em></span></c:if>
                                 		<c:if test="${j.detailScore2 eq 'Y' && j.STATUS eq 'ES05'}"><span class="ico_state i_result_total"><em>최종결과</em></span></c:if>
                                 	</td>
		                            <td class="tc">
		                            	<c:if test="${j.detailScore2 eq 'P' && j.STATUS eq 'ES01'}"><span class="ico_state i_eval"><em>현장점검</em></span></c:if>
		                            	<c:if test="${j.detailScore2 eq 'P' && j.STATUS eq 'ES05'}"><span class="ico_state i_result_total"><em>최종결과</em></span></c:if>
		                            </td>
		                            <td class="tc">
		                            	<c:if test="${j.detailScore2 eq 'N' && j.STATUS eq 'ES01'}"><span class="ico_state i_eval"><em>현장점검</em></span></c:if>
		                            	<c:if test="${j.detailScore2 eq 'N' && j.STATUS eq 'ES05'}"><span class="ico_state i_result_total"><em>최종결과</em></span></c:if>
		                            </td>
		                            <td class="tc">
		                            	<c:if test="${j.detailScore2 eq 'N/A' && j.STATUS eq 'ES01'}"><span class="ico_state i_eval"><em>현장점검</em></span></c:if>
		                            	<c:if test="${j.detailScore2 eq 'N/A' && j.STATUS eq 'ES05'}"><span class="ico_state i_result_total"><em>최종결과</em></span></c:if>
		                            </td>
								</c:otherwise>
								</c:choose>
                            </tr>
						</c:forEach>
						<c:choose>
							 <c:when test="${requestZvl.periodCd eq 'E'}">
								<tr>
									<th scope="col" id="a_b" class="bdl0">평가의견</th>
									<td headers="a_b" colspan="6">
										<input type="text" id="evl_opinion" class="inp_txt w100p ty2" value="${statusExaminRegist.EVL_OPINION }" placeholder="진단항목에 대한 평가의견이 있을 경우 입력하실 수 있습니다." title="평가의견 입력란">
									</td>
								</tr>
								<tr>
									<th scope="col" id="a_c" class="bdl0">메모</th>
									<td headers="a_c" colspan="6">
										<input type="text" id="memo" class="inp_txt w100p ty2" value="${statusExaminRegist.MEMO }" placeholder="특이사항이나 이슈사항이 있을 경우 입력 및 파일첨부가 가능합니다." title="메모 입력란">
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<th scope="col" id="a_b" class="bdl0">평가의견</th>
									<td headers="a_b" colspan="6" class="ta-l">${statusExaminRegist.EVL_OPINION }</td>
								</tr>
								<tr>
									<th scope="col" id="a_c" class="bdl0">메모</th>
									<td headers="a_c" colspan="6" class="ta-l">${statusExaminRegist.MEMO }</td>
								</tr>
							</c:otherwise>
						</c:choose>
						<tr>
							<th scope="col" id="a_d" class="bdl0" <c:if test='${statusExaminIdxFileList.size() > 0 }'>rowspan="2"</c:if> >첨부파일</th>
							<td headers="a_d" colspan="6" class="ta-l"> 
								<div class="ta-l pd">
									<c:if test="${requestZvl.periodCd eq 'E'}">
										<div class="inp_file">
											<button type="button" id="btn_${statusExaminRegist.INDEX_SEQ}"  class="inp_file_btn" onclick="fnAddAttachmentFile('${statusExaminRegist.INDEX_SEQ}','${statusExaminRegist.ATCHMNFL_ID}','attachmentFile'); return false;"><span>파일찾기</span></button>
										</div>
									</c:if>
								</div>
								<c:if test="${!empty statusExaminIdxFileList}">                                
                                	<div class="lst_answer solo" style="border-top: none; padding: 10px 20px 10px 0">
	                               		<c:forEach var="i" items="${statusExaminIdxFileList }" varStatus="status">
	                               			<div id="fileChkBox">
		                               			<input type="checkbox" class="ickjs" id="${i.FILE_ID }" name="chkAttachmentFile_${i.INDEX_SEQ}_memo"/>
		                               			<label for="${i.FILE_ID }"><span class="i-aft i_${i.FILE_EXTSN} link"><a href="#" onClick="javascript:fnAttachmentMemoFileDown('${i.INDEX_SEQ}','${i.FILE_ID }'); return false;" class="f_<c:out value='${i.FILE_EXTSN}'/>">${i.FILE_NAME }</a></span></label>
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
                                   	</div>
                                    <div class="lst_all_chk solo" style="padding: 15px 30px 15px 0;">
                                        <input type="checkbox" class="ickjs allChk" id="chkAttachmentFile_${s_index_seq}_memo">
                                        <label for="chkAttachmentFile_${s_index_seq}_memo">전체선택</label>
                                        <div class="fl-r">
                                        	<c:if test="${requestZvl.periodCd=='E'}">
                                        		<button type="button" value="파일삭제" class="btn-pk ss black" onClick="javascript:fnDeleteAttachmentFile('${s_index_seq}','','attachmentFile'); return false;">파일삭제</button>
											</c:if>
											<button type="button" value="다운로드" class="btn-pk ss gray2 rv" onClick="javascript:fnAttachmentMemoFileDown('${s_index_seq}',''); return false;">다운로드</button>
                                        </div>
                                    </div>
                       			</c:if>
							</td>
						</tr>
						

                    </tbody>
                </table>
            </div>  
            
            <div class="btn-bot noline ta-c">
            	<c:if test="${requestZvl.periodCd=='E'}">
                	<a href="#" onclick="done('${statusExaminRegist.ATCHMNFL_ID }'); return false;" class="btn-pk n purple rv">저장</a>
                </c:if>
                <a href="#" onclick="goBack(); return false;" class="btn-pk n black">목록</a>
            </div>            
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
<!--  파일 다운로드에 사용 -->  

<script>
$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square',
	radioClass: 'iradio_square'
});
</script>