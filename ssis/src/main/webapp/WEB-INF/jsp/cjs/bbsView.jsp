<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com"%>

<script type="text/javascript" src="/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/html/egovframework/com/cmm/utl/ckeditor/config.js"></script>
<script type="text/javascript" src="/smarteditor2-2.10.0/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>

<style>
.lst_all_chk .icheckbox_square .iCheck-helper {
	z-index: -1 !important;
}

.icheckbox_square+label, .icheckbox_square+label a {
	width: auto;
	text-decoration: underline;
	color: #0d6090;
	font-size: 14px;
	margin-left: 5px;
}

.icheckbox_square+label a {
	margin-left: 0;
}

.control {
	position: absolute;
	right: 0;
	bottom: -4px;
}

.lst_answer.solo {
	padding: 10px 0 0 0;
}

.file_list>div {
	margin: 5px 0;
}

.lst_answer.solo, .lst_tblinner .tbls>.col.list .lst_answer {
	border: none;
}

.file_control.lst_all_chk {
	border-top: 1px solid #dcdbdb;
	padding-top: 10px;
	margin-top: 10px;
}

label.allChk, label.allChkLabel {
	text-decoration: none;
	color: inherit;
}

.ickjs {
	position: absolute;
	opacity: 0;
}
</style>

<script>
var pUrl, pParam;
var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	$('.ickjs').iCheck({
		checkboxClass : 'icheckbox_square',
		radioClass : 'iradio_square'
	});
}).on("click", ".allChk, .lst_all_chk .icheckbox_square", function() {
	if ($("input.allChk").prop("checked") == true) {
		$("input.allChk").prop("checked", false);
		$(".icheckbox_square").removeClass("checked");
	} else {
		$("input.allChk").prop("checked", true);
		$(".icheckbox_square").addClass("checked");
	}
	$(".ickjs").prop("checked", $("input.allChk").prop("checked"));
}).on("click", ".addChk .iCheck-helper", function() {
	if ($(this).hasClass("allChk")) {
		if ($("input.allChk").prop("checked") == true)
			$("input.allChk").prop("checked", false);
		else
			$("input.allChk").prop("checked", true);
		fnCheckAttachmentMsgFile();
	} else {
		var idx = $(this).attr("idx");
		if ($(".ickjs[id=" + idx + "]").prop("checked") == true)
			$(".ickjs[id=" + idx + "]").prop("checked", false);
		else
			$(".ickjs[id=" + idx + "]").prop("checked", true);
		$(".icheckbox_square[idx=" + idx + "]").toggleClass("checked")
	}
})

function fnCheckAttachmentMsgFile() {
	$("input[name=chkAttachmentFile_" + $("#bbsSeq").val() + "]").prop(
			"checked", $("input.allChk").prop("checked"));
	if ($("input.allChk").prop("checked") == true)
		$(".icheckbox_square").addClass("checked");
	else
		$(".icheckbox_square").removeClass("checked");
}

function listThread() {
	$("#bbsSeq").val("");
	$("#form").attr({
		method : "post",
		action : "/cjs/bbsList.do"
	}).submit();
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

function fnCheckAttachmentFile(index) {
	$( "input[name=chkAttachmentFile_" + index + "]" ).prop( "checked", $( "#chkAttachmentFile_"+ index ).prop( "checked" ) );
}  

</script>

<form action="/bbs/bbsView.do" method="post" id="form" name="form">
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="${bbsView.atchmnflId }" > 
	<input type="hidden" id="bbsSeq" name="seq" value="${bbsView.seq }" > 
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }"/>
	
	<!-- content -->
	<section id="container" class="sub">
		<div class="container_inner">

			<section class="area_tit1 inr-c">
				<header class="tit">
					<h2 class="h1">공지사항</h2>
				</header>
				
				<div class="cont">
					<div class="wrap_table3">
		                <table id="table-1" class="tbl" summary="제목, 작성자, 작성일, 조회수, 첨부파일로 구성된 게시판 내용보기 입니다.">
		                	<caption>게시판 내용보기</caption>
		                    <colgroup>
								<col class="th1_1">
								<col>
								<col class="th1_1">
								<col>
		                    </colgroup>
		                    <tbody>
		                        <tr>
		                        	<th scope="col">제목</th>
		                            <td colspan="3">${bbsView.subject }</td>
		                        </tr>                        
		              <!--           <tr>
		                            <th scope="row">작성자</th>
		                            <td colspan="3">홍길동</td>
		                        </tr> -->
		                        <tr>
		                            <th scope="col">작성일</th>
		                            <td>${bbsView.registDt }</td>
		                            <th scope="row">조회수</th>
		                            <td>${bbsView.readCount }</td>
		                        </tr> 
		                        <tr>
		                            <th scope="row">첨부파일</th>
		                            <td colspan="3" id="fileArea" class="ta-l">
			                            <c:if test="${!empty bbsAttachFileList }">
											<div class="lst_answer solo" id="lst_answer2"
												style="border-top: none; padding-left: 0;">
													<c:forEach var="i" items="${bbsAttachFileList }" varStatus="status">
														<div>
															<input class="ickjs" type="checkbox" id="${i.fileId }" name="chkAttachmentFile_${i.seq }"/>
															<label for="${i.fileId }"><a href="#" onclick="fnAttachmentSingleFileDown('${i.fileId}'); return false;" class="f_<c:out value='${i.fileExtsn}'/>">${i.fileName }</a></label>
														</div>
														<script>
															var fileInfo = new Object();
															fileInfo.idx			= '${i.seq}';
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
												<div class="lst_all_chk solo" id="lst_all_chk2"
												style="padding-left: 0;">
													<input class="ickjs allChk" type="checkbox" id="chkAttachmentFile_${bbsView.seq}" value="" onClick="javascript:fnCheckAttachmentFile('${bbsView.seq}');">
													전체선택
														<a class="btn-pk ss gray2 rv fl-r" value="다운로드"
														onClick="javascript:fnAttachmentFileDown('${bbsView.seq}',''); return false;">다운로드</a>
												</div>
											</div>
										</c:if>
		                            </td>
		                        </tr>
		                        <tr>
		                        	<th scope="col" id="th_a1">내용</th>
		                            <td colspan="3">${bbsView.contents }</td>
		                        </tr>                         
		                    </tbody>
		                </table>
	                </div>
	            </div>
	            <div class="btn-bot2">
		            <div class="mt10 ta-c">
		                <a href="#" onclick="listThread(); return false;" class="btn-pk n black">목록으로</a>
		            </div>
		        </div>
            </section>
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