<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/resources/front/css/icheck.css"/>
<link rel="stylesheet" href="/resources/front/css/default.css" />
<link rel="stylesheet" href="/resources/front/css/layout.css" />
<link rel="stylesheet" href="/resources/front/css/content_ys.css" />

<script src="/resources/front/js/jquery-1.11.2.min.js"></script>
<script src="/resources/front/js/icheck.js"></script>
<script src="/resources/front/js/common.js"></script>
<script type="text/javascript" src="/resources/front/js/cmmAuthCheck.js"></script>
<script src="/js/ccmsvc.cmd.js" type="text/javascript"></script>
<script src="/js/jquery_ui/jquery-ui.js" type="text/javascript"></script>

<script>
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

$(document).ready(function(){
	
	var index = '${s_index_seq}';
	
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

function fnAttachmentResultReportFileDown(fileId) {
	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;	

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
</script>

<div id="layerPopupT3" class="layerPopupT2">
  <div class="inner">
    <section class="wrap-popup-ty1 inr-c">
          <header class="header">
            <h1>서면평가</h1>
            <a href="/mngLevelReq/mngLevelDocumentEvaluation.do" class="close"><i class="icon-ei-close"></i><span class="blind">닫기</span></a>
          </header>

          <section class="area_mid pd">
            <div class="wrap_table2">
				<table id="table-1" class="tbl">
					<caption>서면평가 등록 상세메모</caption>
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
							<th scope="col" id="th_e">평가결과</th>
						</tr>
					</thead>
					<tbody>
                        <tr>
                            <th scope="col" class="bdl0">${mngLevelInsttDetailEvlInfo.LCLAS }</th>
                            <td scope="row" class="ta-l">${mngLevelInsttDetailEvlInfo.MLSFC }</td>
                            <c:if test="${! empty mngLevelInsttDetailEvlFileList }">
	                            <td colspan="3" class="pd0">
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
																	<label for="${i.FILE_ID }"><span class="i-aft i_${i.fileExtsn } link"><a href="#" onclick="fnAttachmentResultReportFileDown('${i.FILE_ID}'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">${i.FILE_NAME }</a></span></label>
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
		                                		${mngLevelInsttDetailEvlInfo.RESULT_SCORE2 }
											</div>
										</div>
									</div><!--// lst_tblinner -->                        
		                        </td>			                                        
		                     </c:if>
			                 <c:if test="${empty mngLevelInsttDetailEvlFileList }">
	                            <td colspan="3" class="pd0">
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
		                                		${mngLevelInsttDetailEvlInfo.RESULT_SCORE2 }
											</div>
										</div>
									</div><!--// lst_tblinner -->                        
		                        </td>				                 
				             </c:if>
                        </tr>
						<tr>
							<th scope="col" id="a_b" class="bdl0">평가의견</th>
							<td headers="a_b" colspan="4" style="text-align: left;">
								${mngLevelInsttDetailEvlInfo.EVL_OPINION2 }
							</td>
						</tr>
						<tr>
							<th scope="col" id="a_c" class="bdl0">메모</th>
							<td headers="a_c" colspan="4" style="text-align: left;">
								${mngLevelInsttDetailEvlInfo.MEMO }
							</td>
						</tr>
						<!-- 소속/산하기관만 노출 -->
			            <c:if test="${(!empty mngLevelFobjctResn.FOBJCT_RESN or 'C' eq requestZvl.periodCd) and sessionScope.userInfo.authorId eq '2'}">
                        	<td headers="a_c" colspan="4" style="text-align: left;">${mngLevelFobjctResn.FOBJCT_RESN}</td>
			            </c:if>
			            <!-- 소속/산하기관만 노출 -->
 						<tr>
							<th scope="col" id="a_d" class="bdl0">첨부파일</th>
							<td headers="a_d" colspan="4" class="ta-l"> 
								<c:if test="${! empty mngLevelInsttDetailMemoFileList }">
									<div class="lst_answer solo" id="lst_answer2" style="border-top: none; padding-left: 0;">
										<c:forEach var="i" items="${mngLevelInsttDetailMemoFileList }" varStatus="status">
											<div>
												<input type="checkbox" class="ickjs" id="${i.FILE_ID }" name="chkAttachmentFile_${i.INDEX_SEQ }_memo">
												<label for="${i.FILE_ID }"><span class="i-aft i_${i.fileExtsn } link"><a href="#" onclick="fnAttachmentResultReportFileDown('${i.FILE_ID}'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">${i.FILE_NAME }</a></span></label>
											</div>
										</c:forEach>
									</div>
									<div class="lst_all_chk solo" id="lst_all_chk2" style="padding-left: 0;">
                                      	<input class="ickjs" type="checkbox" id="chkAttachmentFile_${s_index_seq}_memo" value="" onClick="javascript:fnCheckAttachmentMemoFile('${s_index_seq}');">
                                       	<label for="chkAttachmentFile_${s_index_seq}_memo">전체선택</label>
										<a class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentMemoFileDown('${s_index_seq}',''); return false;" style="margin-top: 5px;"><span>다운로드</span></a>
									</div>			
								</c:if>							
							</td>
						</tr>   
					</tbody>
				</table>
			</div>
          </section>
    </section>
  </div>
  <div class="cover"></div>
</div>
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