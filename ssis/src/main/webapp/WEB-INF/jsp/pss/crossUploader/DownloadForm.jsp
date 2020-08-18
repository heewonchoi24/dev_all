<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>멀티플/싱글 파일 다운로드 예제입니다.</title>

    <!-- 샘플 설명을 위한 화면 스타일입니다. 중요하지 않으며, 필요 없을 시 삭제해 주십시오. -->
    <link rel="stylesheet" type="text/css" href="/crossuploader/css/common.css" />

    <!-- NamoCrossUploader Client HTML5 Edition 이 동작하기 위한 필수 파일입니다. -->
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/lib/slick/css/slick.grid.css" />
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/lib/slick/css/smoothness/jquery-ui-1.8.16.custom.css" />
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/lib/slick/css/theme.css" />
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/css/namocrossuploader.css" />
    <script type="text/javascript" src="/crossuploader/app/lib/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/jquery.event.drag-2.2.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/slick.core.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/slick.grid.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/slick.formatters.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/plugins/slick.checkboxselectcolumn.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/plugins/slick.rowselectionmodel.js"></script>
    <script type="text/javascript" src="/crossuploader/app/js/namocrossuploader-config.js"></script>
    <script type="text/javascript" src="/crossuploader/app/js/namocrossuploader.js?1=7"></script>
    <!-- -->
</head>

<body>
    <div class="content_title_area">
        <div class="content_title">샘플 설명</div>
        <div class="content_desc">싱글 파일 다운로드 예제입니다.</div>
        <div class="content_title">샘플 경로</div>
        <div class="content_desc">Samples/Download/SingleFileDownload</div>
    </div><br />

	<form:form commandName="downform" name="downform" method="post" >
	<input type="hidden" name="CD_DOWNLOAD_FILE_INFO" id="CD_DOWNLOAD_FILE_INFO" value=""  >

    <div id="downloaderContainer" class="form_area">

        <script type='text/javascript'>

            /**
            * NamoCrossDownloader 객체를 생성합니다.
            */
            //var downloadUrl = window.namoCrossUploaderConfig.productPath + 'Download/SingleFileDownload/DownloadProcess.jsp';
            var downloadUrl = "/crossUploader/fileDownload.do";
            
            var managerProperties = new Object();
            managerProperties.width = '436';                        // FileDownloadManager 너비
            managerProperties.height = '280';                       // FileDownloadManager 높이
            managerProperties.containerId = 'downloaderContainer';  // FileDownloadManager 객체가 생성될 html div 태그 id
            //managerProperties.uiMode = 'SINGLE';                  // FileDownloadManager UI 모드 설정
            managerProperties.uiMode = 'MULTIPLE';                  // FileDownloadManager UI 모드 설정
            managerProperties.downloadUrl = downloadUrl;            // 다운로드 처리 페이지 

            var downloader = namoCrossUploader.createDownloader(
                JSON.stringify(managerProperties));                 // FileDownloadManager 프로퍼티를 JSON 문자열로 전달

            /**
            * 다운로드 할 파일 추가
            */ 
            /*
            var fileIdArray = new Array('FILEID_0001', 'FILEID_0002', 'FILEID_0003'); 
            var fileNameArray = new Array('나모크로스에디터3_제품소개서.pdf', 'ActiveSquare 7_brochure.pdf', '130617_나모_펍트리_브로셔_130702.pdf');
            var fileSizeArray = new Array('2210715', '2816868', '2717166');

            for (var i = 0; i < fileIdArray.length; i++) {
                var fileInfo = new Object();
                fileInfo.fileId = fileIdArray[i];
                fileInfo.fileName = fileNameArray[i];
                fileInfo.fileSize = fileSizeArray[i];
                fileInfo.fileUrl = downloadUrl; // 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.

                downloader.addFile(JSON.stringify(fileInfo));
            }
            */
			<c:forEach var="result" items="${resultList}" varStatus="status">
				var fileInfo = new Object();
				fileInfo.fileId		= "<c:out value="${result.FILE_ID}"/>";
				fileInfo.fileName	= "<c:out value="${result.FILE_NAME}"/>";
				fileInfo.fileSize	= "<c:out value="${result.FILE_SIZE}"/>";
				fileInfo.fileUrl	= downloadUrl;											// 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
				downloader.addFile( JSON.stringify( fileInfo ) );
			</c:forEach>
        </script>
    </div>
    <script type='text/javascript'>
        function fileDownload( url, data ) {
        	document.downform.CD_DOWNLOAD_FILE_INFO.value = data;
        	document.downform.action = "<c:url value='/crossUploader/fileDownload.do'/>";
        	document.downform.submit();
        }
    </script>
    </form:form>

</body>
</html>
