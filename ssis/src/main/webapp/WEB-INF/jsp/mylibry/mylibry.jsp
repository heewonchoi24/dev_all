<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script>
var pUrl, pParam;
var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	
});


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

//파일 업로드
function fnAddAttachmentFile(seq, fileId, filePath, insttCd, updateYN, attachmentFile ) {
	$( "#seq").val(seq);
	$( "#tempFileId").val(fileId);
	$( "#tempFilePath").val(filePath);
	$( "#insttCd").val(insttCd);
    $( "#updateYN").val(updateYN);

    var url			= "/crossUploader/fileUploadPopUp.do";
    var varParam	= "";
    var openParam	= "height=445px, width=500px";

	var attachmentFile = window.open( "", "attachmentFile", openParam );
    attachmentFile.location.href = url;
}  

function fnAttachmentFileCallback( uploadedFilesInfo, modifiedFilesInfo ) {
	
	$( "#uploadedFilesInfo" ).val( uploadedFilesInfo );
	$( "#modifiedFilesInfo" ).val( modifiedFilesInfo );
	
	pParam = {};
	pUrl = "/mylibry/mylibryFileInsert.do";
	
	pParam.insttCd = $("#insttCd").val();
	pParam.updateYN = $("#updateYN").val();
	pParam.uploadedFilesInfo = uploadedFilesInfo;
	pParam.modifiedFilesInfo = modifiedFilesInfo;
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		if (pParam.updateYN == 'N') {
			html = '';
			for(var i in data.insttFileList){
				html += '<tr>';
				html += '		<td headers="th_a"><a href="#" onclick="fnAttachmentSingleFileDown(\'' + data.insttFileList[i].FILE_ID+ '\'); return false;" class="link1">' + data.insttFileList[i].FILE_NAME + '</a></td>';
				html += '		<td headers="th_b">' + data.insttFileList[i].REGIST_DT + '</td>';
				html += '		<td headers="th_c">' + data.insttFileList[i].USER_NM + '</td>';		
				html += '		<td headers="th_d">';
				html += '			<button class="btn-pk s gray" onClick="fnDelete(\'' + data.insttFileList[i].SEQ + '\',\'' + data.insttFileList[i].FILE_ID+ '\',\'' + data.insttFileList[i].FILE_PATH + '/' + data.insttFileList[i].SAVE_FILE_NAME+'\',\'' + data.insttFileList[i].INSTT_CD + '\', \'N\',\'attachmentFile\');"><span>삭제</span></button>';
				html += '			<button class="btn-pk s blue2 rv" onclick="fnAddAttachmentFile(\'' + data.insttFileList[i].SEQ + '\',\''+ data.insttFileList[i].FILE_ID + '\',\'' + data.insttFileList[i].FILE_PATH + '/' + data.insttFileList[i].SAVE_FILE_NAME+ '\',\'' + data.insttFileList[i].INSTT_CD + '\', \'Y\',\'attachmentFile\'); return false;" >';
				html += '				<span>재업로드</span>';
				html += '			</button>';
				html += '		</td>';
				html += '</tr>';
			}
			html += '<script>';
			html += 'var fileInfo = new Object();';
			html += 'fileInfo.idx			= \'' + data.insttFileList[i].SEQ + '\';';
			html += 'fileInfo.atchmnflId	 = \'' + data.insttFileList[i].ATCHMNFL_ID + '\';';
			html += 'fileInfo.registDt	 = \'' + data.insttFileList[i].REGIST_DT+ '\';';
			html += 'fileInfo.registNm = \'' + data.insttFileList[i].USER_NM + '\';';
			html += 'fileInfo.updtDt = \'' + data.insttFileList[i].REGIST_DT + '\';';
			html += 'fileInfo.fileId		 = \'' + data.insttFileList[i].FILE_ID +'\';';
			html += 'fileInfo.fileName	   = \'' + data.insttFileList[i].FILE_NAME + '\';';
			html += 'fileInfo.saveFileName   = \'' + data.insttFileList[i].SAVE_FILE_NAME +'\';';
			html += 'fileInfo.filePath	   = \'' + data.insttFileList[i].FILE_PATH + '\';';
			html += 'fileInfo.mimeType	   = \'' + data.insttFileList[i].MIME_TYPE+ '\';';
			html += 'fileInfo.isDeleted	  = \'false\';';
			html += 'fileInfo.modifiedFileId = \'' + data.insttFileList[i].FILE_ID + '\';';
			html += 'fileInfo.fileUrl	= "";';
			html += 'attachmentFileArray.push( fileInfo );';
			html += '<\/script>';
			$("#fileList").html(html);
		} else {
			fnDeleteAttachmentFile($( "#seq").val(), $( "#tempFileId").val(), $( "#tempFilePath").val(), pParam.insttCd, pParam.updateYN, 'attachmentFile' );
		}
	}, function(jqXHR, textStatus, errorThrown){
		alert(data.message);
	});
}

function fnDelete(seq, fileId, filePath, insttCd, updateYN, attachmentFile){
	if (confirm( "삭제하시겠습니까?")) {	
		fnDeleteAttachmentFile(seq, fileId, filePath, insttCd, updateYN, attachmentFile);
	}
}

function fnDeleteAttachmentFile(seq, fileId, filePath, insttCd, updateYN, attachmentFile ) {
	
	var pUrl = "/mylibry/mylibryFileDelete.do";
	var param = new Object();

	param.file_id = fileId;
	param.filePath = filePath;
	param.insttCd = insttCd;
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		html = '';
		for(var i in data.insttFileList){
			html += '<tr>';
			html += '		<td headers="th_a"><a href="#" onclick="fnAttachmentSingleFileDown(\'' + data.insttFileList[i].FILE_ID+ '\'); return false;" class="link1">' + data.insttFileList[i].FILE_NAME + '</a></td>';
			html += '		<td headers="th_b">' + data.insttFileList[i].REGIST_DT + '</td>';
			html += '		<td headers="th_c">' + data.insttFileList[i].USER_NM + '</td>';		
			html += '		<td headers="th_d">';
			html += '			<button class="btn-pk s gray" onClick="fnDelete(\'' + data.insttFileList[i].SEQ + '\',\'' + data.insttFileList[i].FILE_ID+ '\',\'' + data.insttFileList[i].FILE_PATH + '/' + data.insttFileList[i].SAVE_FILE_NAME+'\',\'' + data.insttFileList[i].INSTT_CD + '\', \'N\',\'attachmentFile\');"><span>삭제</span></button>';
			html += '			<button class="btn-pk s blue2 rv" onclick="fnAddAttachmentFile(\'' + data.insttFileList[i].SEQ + '\',\''+ data.insttFileList[i].FILE_ID + '\',\'' + data.insttFileList[i].FILE_PATH + '/' + data.insttFileList[i].SAVE_FILE_NAME+'\',\'' +data.insttFileList[i].INSTT_CD + '\', \'Y\',\'attachmentFile\'); return false;" >';
			html += '				<span>재업로드</span>';
			html += '			</button>';
			html += '		</td>';
			html += '</tr>';
		}

		$("#fileList").html(html);
	}, function(jqXHR, textStatus, errorThrown){
		
	});
   	
}

function fnMoveBsisInsttDetail(){
	document.form.sMenuId.value = '56';
	document.form.sUrl.value = '/bsis/institutionDetail.do';

	document.form.action = "/bsis/institutionDetail.do";
	document.form.submit();	 
}

</script>
<form method="post" id="form" name="form" >
	<input type="hidden" name="insttCd" id="insttCd" value="${requestZvl.insttCd }"/>
	<input type="hidden" name="updateYN" id="updateYN" value=""/>
	<input type="hidden" name="seq" id="seq" value=""/>
	<input type="hidden" id="type" name="type" value="edit">
	<input type="hidden" id="tempFileId" name="tempFileId" value="">
	<input type="hidden" id="tempFilePath" name="tempFilePath" value="">
	<input type="hidden" id="sMenuId" name="sMenuId" value=""/>
	<input type="hidden" id="sUrl" name="sUrl" value=""/>
	
<div id="layerPopupT2" class="layerPopupT2">
  <div class="inner">
    <section class="wrap-popup-ty1 inr-c">
		<header class="header">
			<h1>${requestZvl.insttNm } <span>님의 라이브러리</span></h1>
			<a href="#" class="close" onclick="layerPopupV2.close('.layerPopupT2'); return false;"><i class="icon-ei-close"></i><span class="blind">닫기</span></a>
		</header>

		<section class="area_mid">
			<div class="wrap-dash-top clearfix pr-mb1">
				<div class="col fl">
					<h1 class="title4"><span class="bg">최신 <span class="c">서식</span></span></h1>
					<div class="slider">
						<div class="owl-carousel owl-theme">
							<c:forEach var="i" items="${bbsList }" varStatus="status">
								<c:forEach var="j" items="${bbsAttachFileList }" varStatus="status">
									<c:if test="${i.CATEGORY == 'CT01' and i.ATCHMNFL_ID eq j.ATCHMNFL_ID }">
										<div class="item">
											<div class="thumb">
												<a href="#" onclick="fnAttachmentSingleFileDown('${j.FILE_ID}'); return false;">
													<c:forEach var="x" items="${bbsImg}" varStatus="status">
														<c:if test="${(x.BBS_SEQ == i.SEQ && i.IMG_NM == x.IMG_NM) && x.USE_YN == 'Y'}">
															<img src="${x.IMG_PATH}${x.IMG_NM}" style="width: 123px; height: 158px;">
														</c:if>
													</c:forEach>
												</a>
											</div>
											<div class="cont">
												<p class="t1">${i.SUBJECT }</p>
												<p class="t2">${i.REGIST_DT }</p>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</c:forEach>
						</div>
						
						<div class="owl-nav">
							<div class="owl-prev" ><span>이전</span></div>
							<div class="owl-next"><span>다음</span></div>
						</div>
						
					</div>
	              <!-- //owl-carousel -->
				</div>
	            <!-- //col -->
				<div class="col fr">
					<h1 class="title4"><span class="bg">최신 <span class="c">지침</span></span></h1>
					<div class="slider">
						<div class="owl-carousel owl-theme">
		                  	<c:forEach var="i" items="${bbsList }" varStatus="status">
								<c:forEach var="j" items="${bbsAttachFileList }" varStatus="status">
									<c:if test="${i.CATEGORY == 'CT02' and i.ATCHMNFL_ID eq j.ATCHMNFL_ID }">
										<div class="item">
											<div class="thumb">
												<a href="#" onclick="fnAttachmentSingleFileDown('${j.FILE_ID}'); return false;">
													<c:forEach var="x" items="${bbsImg}" varStatus="status">
														<c:if test="${(x.BBS_SEQ == i.SEQ && i.IMG_NM == x.IMG_NM) && x.USE_YN == 'Y'}">
															<img src="${x.IMG_PATH}${x.IMG_NM}" style="width: 123px; height: 158px;">
														</c:if>
													</c:forEach>
												</a>
											</div>
											<div class="cont">
												<p class="t1">${i.SUBJECT }</p>
												<p class="t2">${i.REGIST_DT }</p>
											</div>
				                  		</div>
		                  			</c:if>
	                  			</c:forEach>
                  			</c:forEach>
						</div>
	
						<div class="owl-nav">
							<div class="owl-prev"><span>이전</span></div>
							<div class="owl-next"><span>다음</span></div>
						</div>
	
					</div>
			<!-- //owl-carousel -->
				</div>
				<!-- //col -->
			</div>
			<!-- //wrap-dash-top -->

            <div class="inr-c2">
				<div class="hd_tit_wrap clearfix">
					<h1 class="title5"><span>우리 기관 자료실</span></h1>
					<a href="#" class="btn-pk n green bdrs" onclick="fnAddAttachmentFile('', '', '','${requestZvl.insttCd}','N','attachmentFile'); return false;">
						<span class="i-aft i_plus1">신규등록</span>
					</a>
				</div>
				<div class="wrap_table2 pr-mb1">
					<table id="table-1" class="tbl">
						<caption>우리 기관 자료실 목록</caption>
						<colgroup>
							<col>
							<col class="th1_4">
							<col class="th1_4">
							<col class="th1_2">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" id="th_a">파일명</th>
								<th scope="col" id="th_b">등록일</th>
								<th scope="col" id="th_c">등록자</th>
								<th scope="col" id="th_d">관리</th>
							</tr>
						</thead>
						<tbody  id="fileList">
							<c:choose>
								<c:when test="${!empty insttFileList }">
									<c:forEach var="x" items="${insttFileList }" varStatus="status">
										<tr>
											<td headers="th_a"><a href="#" onclick="fnAttachmentSingleFileDown('${x.FILE_ID}'); return false;" class="link1">${x.FILE_NAME }</a></td>
											<td headers="th_b">${x.REGIST_DT} </td>
											<td headers="th_c">${x.USER_NM } </td>
											<td headers="th_d">
												<button type="button" class="btn-pk s gray" onClick="fnDelete('${x.SEQ}', '${x.FILE_ID}', '${x.FILE_PATH }/${x.SAVE_FILE_NAME }', '${x.INSTT_CD }', 'N', 'attachmentFile');"><span>삭제</span></button>
												<button type="button" class="btn-pk s blue2 rv" onclick="fnAddAttachmentFile('${x.SEQ}', '${x.FILE_ID}', '${x.FILE_PATH }/${x.SAVE_FILE_NAME }', '${x.INSTT_CD }', 'Y', 'attachmentFile'); return false;">
													<span>재업로드</span>
												</button>
											</td>
										</tr>
										<script>
											var fileInfo = new Object();
											fileInfo.idx			= '${x.SEQ}';
											fileInfo.atchmnflId	 = '${x.ATCHMNFL_ID}';
											fileInfo.registDt	 = '${x.REGIST_DT}';
											fileInfo.registNm = '${x.USER_NM}';
											fileInfo.updtDt = '${x.REGIST_DT}';
											fileInfo.fileId		 = '${x.FILE_ID}';
											fileInfo.fileName	   = '${x.FILE_NAME}';
											fileInfo.saveFileName   = '${x.SAVE_FILE_NAME}';
											fileInfo.filePath	   = '${x.FILE_PATH}';
											fileInfo.mimeType	   = '${x.MIME_TYPE}';
											fileInfo.isDeleted	  = 'false';
											fileInfo.modifiedFileId = '${x.FILE_ID}';
											fileInfo.fileUrl	= ""; // 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
											attachmentFileArray.push( fileInfo );
										</script>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
									 <td colspan="4">파일이 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>

	            <h1 class="title5"><span>${currentOrder.orderNo }년 기초 현황</span></h1>
	            <c:choose>
	            <c:when test="${cntSet.FILECNT == 0 && cntSet.SYSCNT == 0 && cntSet.VIDEOCNT == 0 }" >
	            	<div class="wrap_table2 pr-mb1">
						<div class="td_notx">
							<p>금년도 기초현황이 아직 등록되지 않았습니다.</p>
							<div class="btn-bot2 ta-c">
								<a href="#" onclick="fnMoveBsisInsttDetail();" class="btn-pk n green2 rv"><span class="i-aft i_arr_r2">등록 바로가기</span></a>
							</div>
						</div>
					</div>
	            </c:when>
	            <c:otherwise>
					<div class="wrap_table2 tblfix pr-mb1">
						<table id="table-2" class="tbl">
							<caption>
									${currentOrder.orderNo }년 기초 현황 목록
							</caption>
							<thead> 
								<tr>
									<th scope="col" id="th_b">개인정보파일</th>
									<th scope="col" id="th_d">개인정보처리 시스템 현황</th>
									<th scope="col" id="th_e">영상정보처리기기<br>운영현황</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td headers="th_b">${cntSet.FILECNT }개</td>
									<td headers="th_b">${cntSet.SYSCNT }개</td>
									<td headers="th_e">${cntSet.VIDEOCNT}개</td>        
								</tr>
							</tbody>  
						</table>
					</div>
				</c:otherwise>
				</c:choose>

	            <h1 class="title5"><span>${currentOrder.orderNo }년 관리수준 진단</span></h1>
				<c:if test="${currentOrder.orderNo eq orderList.orderNo }">
				<div class="box_purple pr-mb1">
					<div class="wrap-step-type1 dashboard">
						<div class="clearfix">
							<div class="step n1">
								<span class="circle"><span class="txt">예정</span></span>
								<div class="step_tit1">
									<p class="h1"><span class="i-aft i_arr_r1">실적 등록 기간</span></p>
									<p class="t1">
									<c:choose>
										<c:when test="${sessionScope.userInfo.authorId eq '2' and (('IC01' eq sessionScope.userInfo.insttClCd or 'IC04' eq sessionScope.userInfo.insttClCd))}" >
											<fmt:parseDate  value="${orderList.mngLevelRegistBgnde2}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
											<fmt:parseDate  value="${orderList.mngLevelRegistEndde2}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
											<fmt:formatDate value="${dateStartFmt}" var="startFmt" pattern="yyyy.MM.dd" /> 
											<fmt:formatDate value="${dateEndFmt}" var="endFmt" pattern="MM.dd" />
											${startFmt} ~ ${endFmt}
										</c:when>
										<c:otherwise>
											<fmt:parseDate  value="${orderList.mngLevelRegistBgnde}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
											<fmt:parseDate  value="${orderList.mngLevelRegistEndde}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
											<fmt:formatDate value="${dateStartFmt}" var="startFmt" pattern="yyyy.MM.dd" /> 
											<fmt:formatDate value="${dateEndFmt}" var="endFmt" pattern="MM.dd" />
											${startFmt} ~ ${endFmt}
										</c:otherwise>
									</c:choose>
									</p>
								</div>
								<div class="step_memo1">
									<div style="text-align: center;">
										<c:set var="checkItemOrd" value=""  />
										<c:forEach var="list" items="${mngLevelSummary}" varStatus="status">
											<c:if test="${ (list.atchmnflId eq null || list.atchmnflId eq '' ) and excpYn eq 'N'}">
												<p>${list.checkItemOrd} 파일누락</p>
											</c:if>
											<c:if test="${ checkItemOrd ne list.checkItemOrd}" > 
												<c:if test="${list.status == 'RS04' || list.status == 'RS05'}">
													<p>${list.checkItemOrd} 재등록 요청</p>
												</c:if>
											</c:if>
											<c:set var="checkItemOrd" value="${list.checkItemOrd}"  />
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="step n2">
								<span class="circle"><span class="txt">예정</span></span>
								<div class="step_tit1">
									<p class="h1"><span class="i-aft i_arr_r1">추가자료 제출</span></p>
									<p class="t1">
										<fmt:parseDate  value="${orderList.mngLevelEvlBgnde}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
										<fmt:parseDate  value="${orderList.mngLevelEvlEndde}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
										<fmt:formatDate value="${dateStartFmt}" var="startFmt" pattern="yyyy.MM.dd" /> 
										<fmt:formatDate value="${dateEndFmt}" var="endFmt" pattern="MM.dd" />
										${startFmt} ~ ${endFmt}
									</p>
								</div>
								<div class="step_memo1">
									<div style="text-align: center;">
										<c:if test="${mngLevelResult.totResultScore1 ne null }">
											<p>중간결과 : <br/><span class="c-green">${mngLevelResult.totResultScore1 }</span> 점</p>
										</c:if>
									</div>
								</div>
							</div>
							<div class="step n3">
								<span class="circle"><span class="txt">예정</span></span>
								
								<div class="step_tit1">
									<p class="h1"><span class="i-aft i_arr_r1">이의신청</span></p>
									<p class="t1">
										<fmt:parseDate  value="${orderList.mngLevelFobjctBgnde}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
										<fmt:parseDate  value="${orderList.mngLevelFobjctEndde}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
										<fmt:formatDate value="${dateStartFmt}" var="startFmt" pattern="yyyy.MM.dd" /> 
										<fmt:formatDate value="${dateEndFmt}" var="endFmt" pattern="MM.dd" />
										${startFmt} ~ ${endFmt}
									</p>
								</div>
							</div>
							<div class="step n4">
								<span class="circle"><span class="txt">예정</span></span>
								
								<div class="step_tit1">
									<p class="h1"><span class="i-aft i_arr_r1">개선조치 등록</span></p>
									<p class="t1">
										<fmt:parseDate  value="${orderList.mngLevelResultBgnde}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
										<fmt:parseDate  value="${orderList.mngLevelResultEndde}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
										<fmt:formatDate value="${dateStartFmt}" var="startFmt" pattern="yyyy.MM.dd" /> 
										<fmt:formatDate value="${dateEndFmt}" var="endFmt" pattern="MM.dd" />
										${startFmt} ~ ${endFmt}
									</p>
								</div>
								<div class="step_memo1">
									<div style="text-align: center;">
										<c:if test="${mngLevelResult.totResultScore2 ne null }">
											<p>최종결과 : <br/><span class="c-green">${mngLevelResult.totResultScore2 }</span> 점</p>
										</c:if>
									</div>
								</div>
							</div>
						</div>
						<script>
						if( $(".step.n1 .step_memo1 p").length < 1 ){
							$(".step.n1 .step_memo1").css("display", "none");
						}
						if( $(".step.n2 .step_memo1 p").length < 1 ){
							$(".step.n2 .step_memo1").css("display", "none");
						}						
						if( $(".step.n4 .step_memo1 p").length < 1 ){
							$(".step.n4 .step_memo1").css("display", "none");
						}
						</script>
						<div class="line"></div>
						<c:choose>
							<c:when test="${sessionScope.userInfo.authorId eq '2' and (('IC02' eq sessionScope.userInfo.insttClCd or 'IC03' eq sessionScope.userInfo.insttClCd) and fn:contains(orderList.periodCode, 'A'))}" >
								<script>
									$('.step.n1').addClass('on');
									$('.step.n1 span').addClass('c2');
									$('.step.n1 span span').text('진행중');
		                                                                                                                                         
									$('.step.n2 span').addClass('c3');
									$('.step.n3 span').addClass('c3');
									$('.step.n4 span').addClass('c3');
									
									$('.step.n2 span span').text('예정');
									$('.step.n3 span span').text('예정');
									$('.step.n4 span span').text('예정');						
								</script>
							</c:when>
							<c:when test="${sessionScope.userInfo.authorId eq '2' and (('IC01' eq sessionScope.userInfo.insttClCd or 'IC04' eq sessionScope.userInfo.insttClCd) and fn:contains(orderList.periodCode, 'H'))}" >	
								<script>
									$('.step.n1').addClass('on');
									$('.step.n1 span').addClass('c2');
									$('.step.n1 span span').text('진행중');
		                                                                                                                                         
									$('.step.n2 span').addClass('c3');
									$('.step.n3 span').addClass('c3');
									$('.step.n4 span').addClass('c3');
									
									$('.step.n2 span span').text('예정');
									$('.step.n3 span span').text('예정');
									$('.step.n4 span span').text('예정');						
								</script>
							</c:when>
							<c:when test="${fn:contains(orderList.periodCode, 'A') || fn:contains(orderList.periodCode, 'H')}">
								<script>
									$('.step.n1').addClass('on');
									$('.step.n1 span').addClass('c2');
									$('.step.n1 span span').text('진행중');
		                                                                                                                                         
									$('.step.n2 span').addClass('c3');
									$('.step.n3 span').addClass('c3');
									$('.step.n4 span').addClass('c3');
									
									$('.step.n2 span span').text('예정');
									$('.step.n3 span span').text('예정');
									$('.step.n4 span span').text('예정');						
								</script>
							</c:when>					
							<c:when test="${fn:contains(orderList.periodCode, 'Y')}"> 
								<script>
									$('.step.n2').addClass('on');
									$('.step.n2 span').addClass('c2');
									$('.step.n2 span span').text('진행중');
		                                                                                                                                         
									$('.step.n1 span').addClass('c1');
									$('.step.n3 span').addClass('c3');
									$('.step.n4 span').addClass('c3');
									
									$('.step.n1 span span').text('완료');
									$('.step.n3 span span').text('예정');
									$('.step.n4 span span').text('예정');								
								</script>
							</c:when>		
							<c:when test="${fn:contains(orderList.periodCode, 'C')}"> 
								<script>
									$('.step.n3').addClass('on');
									$('.step.n3 span').addClass('c2');
									$('.step.n3 span span').text('진행중');
		                                                                                                                                         
									$('.step.n1 span').addClass('c1');
									$('.step.n2 span').addClass('c1');
									$('.step.n4 span').addClass('c3');
									
									$('.step.n1 span span').text('완료');
									$('.step.n2 span span').text('완료');
									$('.step.n4 span span').text('예정');								
								</script>
							</c:when>		
							<c:when test="${fn:contains(orderList.periodCode, 'D')}"> 
								<script>
									$('.step.n4').addClass('on');
									$('.step.n4 span').addClass('c2');
									$('.step.n4 span span').text('진행중');
		                                                                                                                                         
									$('.step.n1 span').addClass('c1');
									$('.step.n2 span').addClass('c1');
									$('.step.n3 span').addClass('c1');
									
									$('.step.n1 span span').text('완료');
									$('.step.n2 span span').text('완료');
									$('.step.n3 span span').text('완료');							
								</script>
							</c:when>	
							<c:when test="${fn:contains(orderList.periodCode, 'E')}"> 
								<script>
									$('.step.n1 span').addClass('c3');
									$('.step.n2 span').addClass('c3');
									$('.step.n3 span').addClass('c3');
									$('.step.n4 span').addClass('c3');							
									
									$('.step.n1 span span').text('예정');
									$('.step.n2 span span').text('예정');
									$('.step.n3 span span').text('예정');	
									$('.step.n4 span span').text('예정');
								</script>
							</c:when>
							<c:when test="${fn:contains(orderList.periodCode, 'F')}"> 
								<script>
									$('.step.n1 span').addClass('c1');
									$('.step.n2 span').addClass('c1');
									$('.step.n3 span').addClass('c1');
									$('.step.n4 span').addClass('c1');							
									
									$('.step.n1 span span').text('완료');
									$('.step.n2 span span').text('완료');
									$('.step.n3 span span').text('완료');	
									$('.step.n4 span span').text('완료');						
								</script>
							</c:when>
						</c:choose>
					</div>
				</div>
				</c:if>
	            <h1 class="title5"><span>${currentOrder.orderNo }년 서면점검</span></h1>
	            <div class="layer-header1 clearfix">
					<div class="col-rgh">
						<span class="ico_state i_reg_comp"><em>등록완료</em></span>
						<span class="ico_state i_result_total"><em>최종결과</em></span>
						<span class="ico_state i_noreg"><em>미등록</em></span>
					</div>
				</div>
				<div class="wrap_table pr-mb1">
					<table id="table-3" class="tbl table-bordered">
						<caption>${currentOrder.orderNo }년 서면점검 리스트</caption>
						<thead>
							<tr>
								<th scope="col" id="th_a">1월</th>
								<th scope="col" id="th_b">2월</th>
								<th scope="col" id="th_c">3월</th>
								<th scope="col" id="th_d">4월</th>
								<th scope="col" id="th_e">5월</th>
								<th scope="col" id="th_f">6월</th>
								<th scope="col" id="th_g">7월</th>
								<th scope="col" id="th_h">8월</th>
								<th scope="col" id="th_i">9월</th>
								<th scope="col" id="th_j">10월</th>
								<th scope="col" id="th_k">11월</th>
								<th scope="col" id="th_l">12월</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<c:forEach var="list" items="${pinnSummaryList}" varStatus="status">
									<c:if test="${list.insttCd eq requestZvl.insttCd}">
										<td>
											<c:choose>
												<c:when test="${'' eq list.status}">
													<span class="ico_state i_noreg"><em>미등록</em></span>
												</c:when>
												<c:when test="${'RS03' eq list.status}">
													<span class="ico_state i_reg_comp"><em>등록완료</em></span>
												</c:when>
												<c:otherwise>
													<span class="ico_state i_result_total"><em>최종결과</em></span>
												</c:otherwise>
											</c:choose>
										</td>
									</c:if>
									<c:set var="cnt" value="${list.mm }"></c:set>
								</c:forEach>
								<c:set var="monthCnt" value="${12-cnt }"></c:set>
								<c:forEach begin="1" end="${monthCnt }">
									<td></td>
								</c:forEach>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</section>

		</section>
		</div>
	<div class="cover"></div>
</div>

</form>

<!--  파일 업로드에 사용 -->
<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
<!--  파일 업로드에 사용 -->  

<form id="__downForm" name="__downForm" action="<c:url value='/crossUploader/fileDownload.do'/>" method="post">
	<input type="hidden" id="CD_DOWNLOAD_FILE_INFO" name="CD_DOWNLOAD_FILE_INFO" value="" >
	<input type="hidden" id="fileExt" name="fileExt" value="xlsx;jpg;gif;png;bmp;zip;">
	<input type="hidden" id="maxFileSize" name="maxFileSize" value="">
	<input type="hidden" id="maxTotFileSize" name="maxTotFileSize" value="">
	<input type="hidden" id="maxFileSize1" name="maxFileSize1" value="">
	<input type="hidden" id="maxTotFileSize1" name="maxTotFileSize1" value="">
	<input type="hidden" id="applyFlag" name="applyFlag" value="N">
</form>