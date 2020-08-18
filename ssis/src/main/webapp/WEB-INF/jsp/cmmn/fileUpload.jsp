﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1, maximum-scale=2, user-scalable=yes" />
	<link rel="stylesheet" type="text/css" href="/css/common.css" media="all" />
    <link rel="stylesheet" type="text/css" href="/css/style.css" media="all" />
    <script src="/js/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script src="/js/common.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/lib/slick/css/slick.grid.css" />
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/lib/slick/css/smoothness/jquery-ui-1.8.16.custom.css" />
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/lib/slick/css/theme.css" />
    <link rel="stylesheet" type="text/css" href="/crossuploader/app/css/namocrossuploader.css" />
    <script type="text/javascript" src="/crossuploader/app/lib/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/jquery.event.drag-2.2.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/slick.core.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/slick.grid.js"></script>
    <script type="text/javascript" src="/crossuploader/app/lib/slick/plugins/slick.rowselectionmodel.js"></script>
    <script type="text/javascript" src="/crossuploader/app/js/namocrossuploader-config.js"></script>
    <script type="text/javascript" src="/crossuploader/app/js/namocrossuploader.js?1=9"></script>
    <title>보건복지 개인정보보호 지원시스템 &#124; 파일업로드</title>
</head>

<div class="file_layer">
    <!-- -->
    <script type='text/javascript'>
        var fnOpenerAttachmentFileCallback = "fnAttachmentFileCallback";

        $(window).load(function(){
        	
        	var type = $( "#type", opener.document ).val(); 
        	if(type == "edit"){
        		uploader.setMaxFileCount(1); 
        	}
            fnOpenerAttachmentFileCallback = $( "#attachmentFileCallback", opener.document ).val(); 
            if( fnOpenerAttachmentFileCallback == "" )
                fnOpenerAttachmentFileCallback = "fnAttachmentFileCallback";
        });

        function fnInitAttachmentFile() {
            var uploadedFilesInfo = $( "#uploadedFilesInfo", opener.document ).val(); 
            var modifiedFilesInfo = $( "#modifiedFilesInfo", opener.document ).val();
            var modifiedFilesInfoObj = jQuery.parseJSON( modifiedFilesInfo );
            for( obj in modifiedFilesInfoObj ) {
                var fileInfo = new Object();
                fileInfo.fileId		= modifiedFilesInfoObj[ obj ].fileId;
                fileInfo.fileName	= modifiedFilesInfoObj[ obj ].fileName;
                fileInfo.fileSize	= modifiedFilesInfoObj[ obj ].fileSize;
                fileInfo.isDeleted	= modifiedFilesInfoObj[ obj ].isDeleted;
                fileInfo.fileUrl	= ""; 									// 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
                uploader.addUploadedFile( JSON.stringify( fileInfo ) );
            }
        }

        function fnAttachmentFileCallback() {
            var uploadedFilesInfo = uploader.getUploadedFilesInfo();
            var modifiedFilesInfo = uploader.getModifiedFilesInfo();
            window.opener[fnOpenerAttachmentFileCallback]( uploadedFilesInfo, modifiedFilesInfo );
            fnClose();
        }

        function fnClose() {
            window.close();
        }

    </script>
    <style>
    	.file_layer .layer_top {margin-top: -16px;}
		.btn_file, .btn_upload, a.button.bt3.gray{font-weight: bold; width: 80px; padding: 7px 0; display: inline-block;}
		.btn_file, .btn_upload{border: 2px solid #0081cb !important;}
		.btn_file{margin-right: 10px; background-color: white; color: #0081cb;}
		.btn_upload{background-color: #0081cb; color: white;}
		a.button.bt3.gray{background-color: black; color: white; border: 2px solid black;}
    </style>
	    <div class="layer_top">
	        <strong>파일등록</strong>
	    </div>
    <div class="layer_content">
        <div id="uploaderContainer" class="form_area">
            <form name="dataForm" method="post" action="DataProcess.jsp">
                <!-- 파일 정보를 저장할 폼 데이터 -->
                <input type="hidden" name="uploadedFilesInfo" />
            </form>

            <script type='text/javascript'>

                /**
                * NamoCrossUploader Event를 설정합니다.
                * 아래의 Event 이름들은 namocrossuploader-config.js 파일에서 변경하실 수 있습니다.
                */

                /**
                * 업로드 시작 시 호출됩니다.
                */
                var onStartUploadCu = function () {
                    //alert('업로드가 시작됐습니다.');
                }

                /**
                * 개별 파일에 대한 업로드 시작 시 호출됩니다.
                */
                var onStartUploadItemCu = function (rowIndex) {
                    /*
                    var obj = jQuery.parseJSON(uploader.getFileInfoAt(rowIndex));
                    alert("[" + rowIndex + "번째 파일의 정보]\n" +
                        "FileType : " + obj.fileType + " (NORMAL:파일, UPLOADED:업로드된 파일)\n" +
                        "FileId : " + obj.fileId + "\n" +
                        "FileName : " + obj.fileName + "\n" +
                        "FileSize : " + obj.fileSize + "\n" +
                        "Status : " + obj.status + "\n" +
                        "IsDeleted : " + obj.isDeleted + "\n\n" +
                        "FileType, FileId, IsDeleted 게시판 수정모드에 활용되는 속성입니다."
                        );
                    */ 
                }

                /**
                * 개별 파일에 대한 업로드 완료 시 호출됩니다.
                */
                var onEndUploadItemCu = function (rowIndex) {
                    /*
                    var obj = jQuery.parseJSON(uploader.getFileInfoAt(rowIndex));
                    alert("[" + rowIndex + "번째 파일의 정보]\n" +
                        "FileType : " + obj.fileType + " (NORMAL:파일, UPLOADED:업로드된 파일)\n" +
                        "FileId : " + obj.fileId + "\n" +
                        "FileName : " + obj.fileName + "\n" +
                        "FileSize : " + obj.fileSize + "\n" +
                        "Status : " + obj.status + "\n" +
                        "IsDeleted : " + obj.isDeleted + "\n\n" +
                        "FileType, FileId, IsDeleted 게시판 수정모드에 활용되는 속성입니다."
                        );
                    */ 
                }

                /**
                * 업로드 완료 시 호출됩니다.
                */
                var onEndUploadCu = function () {
                    //
                    /**/
                    //alert('업로드가 완료됐습니다.');
                    /**/
                }

                /**
                * 전송창이 닫힐 때 호출됩니다.
                */
                var onCloseMonitorWindowCu = function () {
                    // 데이터 처리 페이지로 업로드 결과를 전송합니다.
                    // onEndUploadCu 나 onCloseMonitorWindowCu 이벤트 시점에 처리하시면 되며,
                    // onCloseMonitorWindowCu 시에는 getUploadStatus()를 호출하여 업로드 완료되어 있는지 체크해 주십시오.
                    if (uploader.getUploadStatus() == 'COMPLETION') {

                        // 업로드된 전체 파일의 정보를 가져옵니다.
                        var uploadedFilesInfo = uploader.getUploadedFilesInfo();

                        /**
                        * 필요 시, 아래처럼 사용해 주십시오. (JSON으로 넘오올 경우)
                        var obj = jQuery.parseJSON(uploadedFilesInfo);
                        alertTimeout(obj.length);
                        alertTimeout(obj[0].name);
                        */
                        //alert(uploadedFilesInfo);
                        // 데이터 처리 페이지로 업로드 결과를 전송합니다.
                        //document.dataForm.uploadedFilesInfo.value = uploadedFilesInfo;
                        //document.dataForm.submit();
                        //alert('파일전송이 완료됐습니다.');
                        // ////////////////////////////////////
                        // 파일전송 후 호출된 곳에 파일 정보를 보낸다.
                        fnAttachmentFileCallback();
                    }
                }

                /**
                * 개별 파일에 대한 업로드 취소 시 호출됩니다.
                */
                var onCancelUploadItemCu = function (rowIndex) {
                    /*
                    var obj = jQuery.parseJSON(uploader.getFileInfoAt(rowIndex));
                    alert('[개별 파일에 대한 업로드 취소 정보]\n' +
                        'FileName : '				+ obj.fileName + '\n' +
                        'FileSize : '				+ obj.fileSize + '\n'
                    );
                    */
                }

                /**
                * 예외 발생 시 호출됩니다.
                */
                var onExceptionCu = function () {
                    // 300~ : 일반적 예외
                    // 400~ : 시스템 예외
                    // 500~ : 서측에서 발생한 예외
                    // 필요한 예외정보만 고객에서 보여주십시오.
                    var exceptionInfo = uploader.getLastExceptionInfo();
                    var obj = jQuery.parseJSON(exceptionInfo);
                    alert(obj.message);

                    if (parseInt(obj.code, 10) > 400000) {
                        //var uploadedFilesInfo = uploader.getUploadedFilesInfo();
                        //document.dataForm.uploadedFilesInfo.value = uploadedFilesInfo;
                        //document.dataForm.action = "ErrorProcess.jsp";
                        //document.dataForm.submit();
                    }
                }

                /**
                * NamoCrossUploader 객체를 생성합니다.
                */
                //var uploadUrl = window.namoCrossUploaderConfig.productPath + 'Upload/BasicFileUpload/UploadProcess.jsp';
                var uploadUrl = "/crossUploader/fileUpload.do";
                var managerProperties = new Object();
                managerProperties.width = '450';                    // FileUploadManager 너비
                managerProperties.height = '280';                   // FileUploadManager 높이
                managerProperties.containerId = 'uploaderContainer';// FileUploadManager 객체가 생성될 html div 태그 id
                managerProperties.uploadUrl = uploadUrl;                   // 파일 업로드 처리 페이지 경로

                var monitorProperties = new Object();
                monitorProperties.monitorLayerClass = 'monitorLayer';      // FileUploadMonitor 창의 스타일입니다. (namocrossuploader.css 파일에 정의, 변경 가능)
                monitorProperties.monitorBgLayerClass = 'monitorBgLayer';  // FileUploadMonitor 창의 백그라운드 스타일입니다. (namocrossuploader.css 파일에 정의, 변경 가능)
                monitorProperties.closeMonitorCheckBoxChecked = true;      // 전송 완료 후 FileUploadMonitor 창 닫기 설정

                var uploader = namoCrossUploader.createUploader(
                    JSON.stringify(managerProperties),                          // FileUploadManager 프로퍼티를 JSON 문자열로 전달
                    JSON.stringify(monitorProperties),                          // FileUploadMonitor 프로퍼티를 JSON 문자열로 전달
                    JSON.stringify(window.namoCrossUploaderConfig.eventNames)); // 이벤트 이름을 JSON 문자열로 전달
              	
				var fileExt = opener.document.getElementById("fileExt").value;
                if(fileExt == ''){
                	uploader.setAllowedFileExtension('hwp;pdf', 'FORWARD');
                }else{
                	uploader.setAllowedFileExtension(fileExt + ';hwp;pdf', 'FORWARD');	
                }
                
                var maxFileSize = opener.document.getElementById("maxFileSize").value;
                var maxTotFileSize = opener.document.getElementById("maxTotFileSize").value;
                var maxFileSize1 = opener.document.getElementById("maxFileSize1").value;
                var maxTotFileSize1 = opener.document.getElementById("maxTotFileSize1").value;
                
                //uploader.setMaxFileCount(5);                    // 파일 개수 제한
                if('' == maxFileSize) {
                	uploader.setMaxFileSize(1024 * 1024 * 50);    // 개별 파일 크기를 50MB로 제한
                } else {
                	uploader.setMaxFileSize(parseInt(maxFileSize));
                }
                if('' == maxFileSize) {
                	uploader.setMaxTotalFileSize(1024 * 1024 * 1024 * 1); // 전체 파일 크기를 1G로 제한
                } else {
                	uploader.setMaxTotalFileSize(parseInt(maxTotFileSize));
                }
                
            </script>
        </div>
        
       	<div id="applyContents">
	       	<div class="box3 mb10">
			총 할당 용량 : <strong id="limitFileSize1"></strong> / 잔여 용량 : <strong id="limitFileSize"></strong><br />
			개별 파일 최대 업로드 용량 : <strong id="limitFileSize2">
			</div>		
			<script>
				var limit = maxTotFileSize / 1048576;
				limit = limit.toFixed(2);
				$("#limitFileSize").text(limit + " MB");
				limit = maxTotFileSize1 / 1048576;
				limit = limit.toFixed(2);
				$("#limitFileSize1").text(limit + " MB");
				limit = maxFileSize1 / 1048576;
				limit = limit.toFixed(2);
				$("#limitFileSize2").text(limit + " MB");
			</script>
			
			<div class="blet01">파일첨부는 pdf, hwp, zip 파일만 가능합니다.</div>
		</div>
       	<div class="tc mt30">
   	        <a href="#" onclick="fnClose();" class="button bt3 gray">닫기</a>
        </div>

		<script>
			var applyFlag = opener.document.getElementById("applyFlag").value;
			if('Y' == applyFlag) {
				$("#applyContents").show();
			} else {
				$("#applyContents").hide();
			}
		</script>
    </div>
</div>