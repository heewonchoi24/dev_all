<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>.bbsView .cont { padding: 0 50px 50px; border-bottom: none; } .i-aft.link a { text-decoration: underline; color: #0d6090; font-size: 13px; }</style>
<script>
var pUrl, pParam;

$(document).ready(function(){

});

function list_Thread(pageNo) {
	if(pageNo < 1) { pageNo = 1; }
	document.form.pageIndex.value = pageNo;
	document.form.action = "<c:url value='/msg/trnsmitMsgList.do'/>";
	document.form.submit();
}

function moveMsg(seq, user_id) {
 	document.form.threadSeq.value = seq;
 	document.form.user_id.value = user_id;
	document.form.action = "<c:url value='/msg/trnsmitMsgView.do'/>";
	document.form.submit();
}

function fnCheckAttachmentMsgFile() {
	$( "input[name=chkAttachmentFile_msg]" ).prop( "checked", $( "#chkAttachmentFile_msg").prop( "checked" ) );
}  

function fnAttachmentMsgFileDown(atchmnflId) {
	var chkAttachmentFile = atchmnflId;
	// Check Box 선택 
	if( atchmnflId == "" ) {
		$( "input:checkbox[name=chkAttachmentFile_msg]" ).each( function() {
			if( $(this).prop( "checked" ) ) 
				chkAttachmentFile += "," + $(this).attr("id");

		});
		chkAttachmentFile = chkAttachmentFile.substring( 1, chkAttachmentFile.length )
	}
	if( chkAttachmentFile == "" ) {
		alert( "다운로드할 파일을 선택 하십시요.")
		return;
	}
	// 다운 목록에 넣는다 
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

<form method="post" id="form" name="form">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<input type="hidden" id="threadSeq" name="threadSeq" value="${threadSeq}">
	<input type="hidden" id="typeTR" name="typeTR" value="${typeTR}">
	<input type="hidden" id="user_id" name="user_id" value="${user_id}">
	
	
	<section id="container" class="sub mypage">
		<div class="container_inner">
		<!-- content -->
			<section class="bbsView">
            <h2 class="tit">${result.SUBJECT}</h2>
            <div class="wrap_table2">
            	<div class="top">
            		<p>
	            		<span>
	            		받는 사람 : 
	            			<c:forEach var="data" items="${resultList}" varStatus="status">
								[<c:out value="${data.USER_NM}"/>/<c:out value="${data.INSTT_NM}"/>] 
								<%-- <span>
								 <c:if test="${data.RECPTN_YN =='Y' }"><c:out value="${data.RECPTN_DT}"/>
								</c:if> --%>
							</c:forEach>
	            		</span>
	            		<span>날짜 : ${result.T_REGIST_DT}</span>
	            	</p>
            	</div>
            	<div class="cont pr-mb1" <c:if test="${fileList.size() eq 0}">style="padding-bottom: 10px;"</c:if>>
            		<c:if test="${fileList.size() > 0}">  
						<div class="rlink">
	            			<span class="i-aft i_file1">첨부파일 :</span>
	           				<c:forEach var="file" items="${fileList}" varStatus="status">		                			                	
								<p>
									<input type="checkbox" id="${file.FILE_ID }" name="chkAttachmentFile_msg" style="position: absolute; opacity: 0;"/>
									<label for="${file.FILE_ID }">
										<a href="#" onClick="fnAttachmentMsgFileDown('${file.FILE_ID }'); return false;" class="f_<c:out value='${file.FILE_EXTSN}'/>">
											<span class="i-aft i_${file.FILE_EXTSN} link">${file.FILE_NAME }</span>
										</a>
									</label>
								</p>
							</c:forEach>
						</div>
					</c:if>
					<div class="txt" style="margin-top: 30px;">${result.CONTENTS }</div>
				</div>
            	
            	<div class="botm bdt">
					<p><span class="i-aft i_arr_t1">다음글</span>
						<span>
							<c:choose>
								<c:when test="${msgNext.SUBJECT == null || msgNext.SUBJECT == '' }">다음 글이 없습니다.</c:when>
								<c:otherwise>
									<a href="#" onclick="javascript:moveMsg('${msgNext.SEQ}', '${msgNext.USER_ID}')">${msgNext.SUBJECT }</a>
								</c:otherwise>
							</c:choose>
						</span>
					</p>
					<p><span class="i-aft i_arr_b1">이전글</span>
						<span>
							<c:choose>
								<c:when test="${msgPrev.SUBJECT == null || msgPrev.SUBJECT == '' }">이전 글이 없습니다.</c:when>
								<c:otherwise>
									<a href="#" onclick="javascript:moveMsg('${msgPrev.SEQ}', '${msgPrev.USER_ID}')">${msgPrev.SUBJECT }</a>
								</c:otherwise>
							</c:choose>
						</span>
					</p>
				</div>
            	
            	<div class="btn-bot noline">
	                <a href="#" class="btn-pk n black" onClick="javascript:list_Thread('${pageIndex}')">목록</a>
	            </div>

<!-- <c:forEach var="data" items="${resultList}" varStatus="status">
    <li>
        <span><c:out value="${data.USER_NM}"/>/<c:out value="${data.INSTT_NM}"/>/<c:out value="${data.RSPOFC}"/></span>
        <span>
         <c:if test="${data.RECPTN_YN =='Y' }"><c:out value="${data.RECPTN_DT}"/>
         </c:if>
         <c:if test="${data.RECPTN_YN =='N' }">미확인</c:if>
         <c:if test="${data.RECPTN_YN =='' }">미확인</c:if>
        </span>
    </li>
    </c:forEach> -->
		                 
             
			</div>
		</section>
    <!-- /content -->
	</div>
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