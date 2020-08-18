<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	
	var attachmentFileArray	= [], attachmentFileDeleteArray = [];
	
	$(document).ready(function(){
		// 차수 옵션 선택 시
		$(document).on("click","#yyyy>li>a",function(){
			$("#searchYyyy").val(this.dataset.yyyy);
			goSearch();
		});
		$(".ta-l.pd2.td_log .iCheck-helper").click(function(){
			var seq = $(this).prev().attr("seq");
			if($(".allChk[seq="+seq+"]").is(":checked")) {
				$(".ickjs[seq="+seq+"]").prop("checked", true);
				$("."+seq+" .icheckbox_square").addClass("checked");
			}else {
				$(".ickjs[seq="+seq+"]").prop("checked", false);
				$("."+seq+" .icheckbox_square").removeClass("checked");
			} 
		})
	});

	function goSummary(){
		
		$("#insttCd").val(insttCd);
		$("#insttNm").val(insttNm);
		
		$("#pinnForm").attr({
	        action : "/pinn/pinnSummaryDtlList.do",
	        method : "post"
	    }).submit();
	}

	function goSearch(){
		
		$("#pinnForm").attr({
	        action : "/pinn/pinnInsttDtlList.do",
	        method : "post"
	    }).submit();
	}
	
	function fnAddAttachmentFile(index, atchmnflId, attachmentFile ) {
	    //
	    $( "#atchmnfl_id").val(atchmnflId);
	    $( "#schdulSeq").val(index);
	    
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
		pUrl = "/pinn/updatePinnReqst.do";

		pParam.atchmnfl_id = $("#atchmnfl_id").val();
		pParam.uploadedFilesInfo = uploadedFilesInfo;
		pParam.modifiedFilesInfo = modifiedFilesInfo;
		pParam.schdulSeq = $( "#schdulSeq").val();

		$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
			//alert(data.message);
			
		}, function(jqXHR, textStatus, errorThrown){
				
		});
			
		goSearch();
	}
	
	function fnCheckAttachmentFile(index) {
		$( "input[name=chkAttachmentFile_" + index + "]" ).prop( "checked", $( "#chkAttachmentFile_"+ index + "all" ).prop( "checked" ) );
	}
	
	function fnAttachmentFileDown( index, atchmnflId ) {
	    //
		var chkAttachmentFile = atchmnflId;
		// Check Box 선택 
		if( atchmnflId == "" ) {
			$( "input:checkbox[name=chkAttachmentFile_" + index + "]" ).each( function() {
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
		$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
		$( "#__downForm" ).submit();
	}
	
	function fnAttachmentEvalFileDown( chkAttachmentFile ) {
		
		// 삭제 목록에 넣는다 
		var chkAttachmentFileArr = chkAttachmentFile.split("|");
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
	
	
// 	function fnFileDownProhibit( chkAttachmentFile ) {
// 		// 해당 함수는 임시적으로 생성되었으며, 서면점검의 다운로드 기능이 정상 동작 시 제거해야한다. 
// 		// 일자 : 2018.04.18
// 		// 목적 : 다운로드 금지 및 메시지창 팝업 등의 임시 방편		
// 			alert('[ 점검기간: 2018.4.18~19 ] \n서면점검결과 다운로드 기능을 개선중이오니, 차주 확인 부탁드립니다.\n 불편을 드려서 죄송합니다.');
// 			return;
// 	}
	
	function fnDeleteAttachmentFile(index, atchmnflId, attachmentFile ) {
		var deleteAttachmentFile = "";
		var chkAttachmentFile = "";
		
		$( "input:checkbox[name=chkAttachmentFile_" + index + "]" ).each( function() {
			if( $(this).prop( "checked" ) ) 
				chkAttachmentFile += "," + $(this).attr("id");;
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

			var pUrl = "/pinn/deletePinnReqst.do";
	 		var param = new Object();
			
	 		param.atchmnflId = p_atchmnflId;
	 		param.fileId = p_fileId;
	 		param.filePath = p_filePath;
	 		param.schdulSeq = index;
			
	 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
	 			alert(data.message);
				
	 		}, function(jqXHR, textStatus, errorThrown){
	 			
	 		});

	 		goSearch();	 	
		}
		return false;
	}
</script>

<form method="post" id="pinnForm" name="pinnForm">
	<input type="hidden" name="insttCd" value="${requestZvl.insttCd}"/>
	<input type="hidden" name="insttNm" value="${requestZvl.insttNm}"/>
	<input type="hidden" id="searchYyyy" name="searchYyyy" value="${requestZvl.searchYyyy}"/>
	
	<!--  파일 업로드에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="" > 
	<input type="hidden" id="schdulSeq" name="schdulSeq" value="" > 
	<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
	<!--  파일 업로드에 사용 -->

	<!-- content -->
	<section id="container" class="sub">
		<div class="container_inner">
		
 			<div class="layer-header1 clearfix">
 				<div class="box-select-ty1 type1">
					<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1" onchange="goSearch(); return false;">${requestZvl.searchYyyy}</a></div>
					<ul class="selectMenu" id="yyyy">
						<c:forEach var="list" items="${yyyyList}"  varStatus="status">
							<li><a href="#" data-yyyy="${list.yyyy}">${list.yyyy}</a></li>
						</c:forEach>
	             	</ul>
	           	</div>
				<div class="col-rgh">
					<span class="ico_state i_reg_comp"><em>등록완료</em></span>
					<span class="ico_state i_result_total"><em>최종결과</em></span>
					<span class="ico_state i_noreg"><em>미등록</em></span>
				</div>
			</div>

			<table class="wrap_table2" summary="월, 서면점검 항목, 실적제출, 상태, 점검결과로 구성된 서면점검 실적등록 및 조회 리스트입니다.">
				<caption>서면점검 실적등록 및 조회 리스트</caption>
				<colgroup>
					<col class="th1_5">
					<col>
					<col class="th1_4">
					<col class="th1_5">
					<col class="th1_4">
				</colgroup>
				<thead>
					<tr>
						<th scope="col" id="th_a">월</th>
						<th scope="col" id="th_b">서면점검 항목</th>
						<th scope="col" id="th_c">실적제출</th>
						<th scope="col" id="th_e">상태</th>
						<th scope="col" id="th_f">점검결과</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="list" items="${resultList}" varStatus="status">
				<c:choose>
					<c:when test="${empty list.atchmnflId}">
					<tr>
						<td class="bdl0">${list.mm}</td>
						<td class="ta-l">
						<span>${list.mngLevelCn}</span>
                      	</td>
                         	<c:choose>
                         		<c:when test="${empty list.status}">
                         			<td>
                         				<div class="inp_file ty2">
                         					<button type="button" class="inp_file_btn" id="btn_${list.seq}" onclick="fnAddAttachmentFile('${list.seq}','${list.atchmnflId}','attachmentFile'); return false;"><span>파일첨부</span></button>
                         				</div>
                         			</td>
                         			<td>
                             			<span class="ico_state i_noreg"><em>미등록</em></span>
                             		</td>
                             		<td></td>
                             	</c:when>
                             	<c:when test="${'RS03' eq list.status}">
                             		<td>
                             			<div class="inp_file ty2">
                             				<button type="button" class="inp_file_btn" id="btn_${list.seq}" onclick="fnAddAttachmentFile('${list.seq}','${list.atchmnflId}','attachmentFile'); return false;"><span>파일첨부</span></button>
                             			</div>
                             		</td>
                             		<td>
                             			<span class="ico_state i_reg_comp"><em>등록완료</em></span>
                             		</td>
                             		<td></td>
                             	</c:when>
                             	<c:otherwise>
                             		<td></td>
                             		<td>
                             			<span class="ico_state i_result_total"><em>최종결과</em></span>
                         			</td>
                         			<td>
	                                <c:set var="fileId" value=""/>
		                                <c:forEach var="i" items="${evalFileList }" varStatus="status">
		                                   	<c:if test="${list.seq eq i.schdulSeq }">
		                                   		<c:if test="${!empty i.fileId }">
		                                   			<c:set var="fileId" value="${fileId}|${i.fileId}"/>
		                                   		</c:if>
		                                   	</c:if>
	                                   </c:forEach>
                                   <!--  button type="button" value="다운로드">다운로드</button-->
                                <!--<button type="button" value="다운로드" class="button bt2 small" onClick="javascript:fnFileDownProhibit('${fileId}'); return false;">다운로드</button>-->
                                <!-- 2018.04.18 점검결과 다운로드 기능 기존 소스 -->
									<c:if test="${!empty fileId }">
										<button type="button" value="다운로드"  class="btn-pk ss gray2 rv" onClick="javascript:fnAttachmentEvalFileDown('${fileId}'); return false;">다운로드</button>
									</c:if>
								</td>
							</c:otherwise>
							</c:choose>
						</tr>
							</c:when>
							
							
							<c:when test="${!empty list.atchmnflId}">
							<tr>
						<td class="bdl0" rowspan="3">${list.mm}</td>
						<td class="ta-l">
						<span>${list.mngLevelCn}</span>
                      	</td>
                         	<c:choose>
                         		<c:when test="${empty list.status}">
                         			<td rowspan="3">
                         				<div class="inp_file ty2">
                         					<button type="button" class="inp_file_btn" id="btn_${list.seq}" onclick="fnAddAttachmentFile('${list.seq}','${list.atchmnflId}','attachmentFile'); return false;"><span>파일첨부</span></button>
                       					</div>
                         			</td>
                         			<td rowspan="3">
                             			<span class="ico_state i_noreg"><em>미등록</em></span>
                             		</td>
                             		<td rowspan="3"></td>
                             	</c:when>
                             	<c:when test="${'RS03' eq list.status}">
                             		<td rowspan="3">
                             			<div class="inp_file ty2">
                             				<button type="button" class="inp_file_btn" id="btn_${list.seq}" onclick="fnAddAttachmentFile('${list.seq}','${list.atchmnflId}','attachmentFile'); return false;"><span>파일첨부</span></button>
                             			</div>
                             		</td>
                             		<td rowspan="3">
                             			<span class="ico_state i_reg_comp"><em>등록완료</em></span>
                             		</td>
                             		<td rowspan="3"></td>
                             	</c:when>
                             	<c:otherwise>
                             		<td rowspan="3"></td>
                             		<td rowspan="3">
                             			<span class="ico_state i_result_total"><em>최종결과</em></span>
                         			</td>
                         			<td rowspan="3">
	                                <c:set var="fileId" value=""/>
		                                <c:forEach var="i" items="${evalFileList }" varStatus="status">
		                                   	<c:if test="${list.seq eq i.schdulSeq }">
		                                   		<c:if test="${!empty i.fileId }">
		                                   			<c:set var="fileId" value="${fileId}|${i.fileId}"/>
		                                   		</c:if>
		                                   	</c:if>
	                                   </c:forEach>
                                   <!--  button type="button" value="다운로드">다운로드</button-->
                                <!--<button type="button" value="다운로드" class="button bt2 small" onClick="javascript:fnFileDownProhibit('${fileId}'); return false;">다운로드</button>-->
                                <!-- 2018.04.18 점검결과 다운로드 기능 기존 소스 -->
									<c:if test="${!empty fileId }">
										<button type="button" value="다운로드"  class="btn-pk s blue2 rv" onClick="javascript:fnAttachmentEvalFileDown('${fileId}'); return false;">다운로드</button>
									</c:if>
								</td>
							</c:otherwise>
							</c:choose>
						</tr>
							<tr>
							<td class="ta-l pd">
							<div class="lst_answer">
									<c:forEach var="i" items="${fileList }" varStatus="status">
										<c:if test="${list.seq eq i.schdulSeq }">
											<div class="${i.schdulSeq}">
												<input class="ickjs" type="checkbox" id="${i.fileId }" name="chkAttachmentFile_${i.schdulSeq }" seq="${i.schdulSeq}"/>
												<label for="${i.fileId }"><a href="#" onClick="javascript:fnAttachmentFileDown('${list.seq}','${i.fileId }'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">
												<span class="i-aft i_${i.fileExtsn} link">${i.fileName }</span></a></label>
											</div>
											<script>
											var fileInfo = new Object();
											fileInfo.idx			= '${i.schdulSeq}';
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
										</c:if>
									</c:forEach>
								</div>
								</td>
								</tr>
								<tr>
								<td class="ta-l pd2 td_log">
									<input type="checkbox" class="ickjs allChk" id="chkAttachmentFile_${list.seq}all" value="" seq="${list.seq}"/>
									<label for="chkAttachmentFile_${list.seq}">전체선택</label>
									<div class="fl-r">
										<c:if test="${'ES05' ne list.status}">
											<button type="button" value="파일삭제" class="btn-pk ss black" onClick="javascript:fnDeleteAttachmentFile('${list.seq}','','attachmentFile'); return false;">파일삭제</button>
										</c:if>
									<button type="button" value="다운로드" class="btn-pk ss gray2 rv" onClick="javascript:fnAttachmentFileDown('${list.seq}',''); return false;">다운로드</button>
									<script>
										var fileInfo2 = new Object();
										fileInfo2.idx			= '${list.seq}';
										fileInfo2.atchmnflId		= '${list.atchmnflId}';
										fileInfo2.fileId			= '${list.fileId}';
										fileInfo2.fileName		= '${list.fileName}';
										fileInfo2.saveFileName	= '${list.saveFileName}';
										fileInfo2.filePath		= '${list.filePath}';
										fileInfo2.mimeType		= '${list.mimeType}';
										fileInfo2.isDeleted		= 'false';
										fileInfo2.modifiedFileId	= '${list.fileId}';
										fileInfo2.fileUrl	= ""; // 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
										attachmentFileArray.push( fileInfo2 );
										</script>
									</div>
								</td>
							</tr>
						</c:when>
					</c:choose>
					</c:forEach>
				</tbody>
			</table>
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