<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<title>관제업무지원 시스템 &#124; 마이페이지 &#124; 업무 협업</title>

<script>
var pUrl, pParam;

$(document).ready(function(){

});

function list_Thread(pageNo) {
	if(pageNo < 1) { pageNo = 1; }
	document.form.pageIndex.value = pageNo;
	document.form.action = "<c:url value='/cjs/receiveMsgList.do'/>";
	document.form.submit();
}

function trnsmitMsg(){
	document.form.action = "/cjs/trnsmitMsg.do";
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
</head>

<form action="/cjs/receiveMsgView.do" method="post" id="form" name="form">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<!-- content -->
    <div id="container">
        <div class="content_wrap">
            <h2 class="h2">수신 업무</h2>
            <div class="content">
                <table class="write" summary="제목, 보낸사람, 받은날짜, 업무내용, 첨부파일로 구성된 수신업무 내용보기입니다.">
                	<caption>수신업무 내용보기</caption>
                    <colgroup>
                        <col style="width:15%;">
                        <col style="width:35%;">
                        <col style="width:15%;">
                        <col style="width:*;">
                    </colgroup>
                    <tbody>
                        <tr>
                            <td colspan="4" class="subject" ><c:out value="${result.SUBJECT}"/></td>
                        </tr>                        
                        <tr>
                            <th scope="row">보낸사람</th>
                            <td colspan="3"><c:out value="${result.TRNSMIT_NM}"/></td>
                        </tr>
                        <tr>
                            <th scope="row">받은날짜</th>
                            <td colspan="3"><c:out value="${result.R_REGIST_DT}"/></td>
                        </tr> 
                        <tr>
                            <th scope="row">업무 내용</th>
                            <td colspan="3" >${result.CONTENTS}</td>
                        </tr>   
                        <c:if test="${fileList.size() > 0}">                        
		                	<tr>
		                	<th scope="row">첨부파일</th>
		                	<td colspan="3" class="option_area">
		                	<div class="option">
		                	<ul class="file_list">	
		                	<c:forEach var="file" items="${fileList}" varStatus="status">		                			                	
		                        <li>
		                            <input type="checkbox" id="${file.FILE_ID }" name="chkAttachmentFile_msg"/>
		                            <label for="${file.FILE_ID }"><a href="#" onClick="fnAttachmentMsgFileDown('${file.FILE_ID }'); return false;" class="f_<c:out value='${file.FILE_EXTSN}'/>">${file.FILE_NAME }</a></label>
		                       </li>
		                	</c:forEach>
		                	</ul>
		                    <div class="file_control">
		                          <input type="checkbox" id="chkAttachmentFile_msg" value="" onClick="javascript:fnCheckAttachmentMsgFile();">
		                         <label for="chkAttachmentFile_msg">전체선택</label>
		                         <div class="control">
									 <button type="button" value="다운로드" class="button bt2 small" onClick="javascript:fnAttachmentMsgFileDown(''); return false;">다운로드</button>
		                         </div>
		                     </div>
							</div>
							</td>
		                	</tr>
		                </c:if>                                              
						<input type="hidden" id="userId"    name="userId" value="${result.REGIST_ID}">
						<input type="hidden" id="trnsmitId" name="trnsmitId" value="${result.REGIST_ID}">
						<input type="hidden" id="subject"   name="subject"   value="Re: ${result.SUBJECT}">
						<input type="hidden" id="contents"  name="contents"  value="${result.CONTENTS}">
						<input type="hidden" id="instt_cl_cd"  name="instt_cl_cd"  value="${result.INSTT_CL_CD}">
						<input type="hidden" id="instt_nm"  name="instt_nm"  value="${result.INSTT_CD}">
                    </tbody>
                </table>
            </div>
            <div class="tc mt50">
                <a href="#" class="button bt1 gray" onClick="javascript:list_Thread('${pageIndex}')">목록</a>
                <a href="#" class="button bt1" onClick="javascript:trnsmitMsg()")">답글</a>
            </div>            
        </div>
    </div>
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