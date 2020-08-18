<!DOCTYPE html>
<html>
<head>
    <title>나모 크로스업로더 체험하기</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="shortcut icon" href="../img/icon_ul_03.ico" />
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
    <script type="text/javascript" src="/crossuploader/app/lib/slick/plugins/slick.rowselectionmodel.js"></script>
    <script type="text/javascript" src="/crossuploader/app/js/namocrossuploader-config.js"></script>
    <script type="text/javascript" src="/crossuploader/app/js/namocrossuploader.js"></script>
    <!-- -->
</head>

<body>
<div id="wrap">
	<div id="content">
		
			<div class="content_title_area">
				<div class="content_title">샘플 설명</div>
				<div class="content_desc">게시판 수정 모드 시 기존 업로드한 파일을 삭제 및 새로운 파일을 추가하는 예제입니다.</div>
				<div class="content_title">샘플 경로</div>
				<div class="content_desc">Samples/Upload/ModifiedFileUpload</div>
			</div><br />
			<div id="uploaderContainer" class="form_area">
						<form name="dataForm" method="post" action="DataProcess.jsp">
						<table class="form_table">
							<!-- 파일 -->
							<tr>
								<td colspan="2">
									<div id="uploaderContainer" class="form_area">
				
										<!-- 파일 정보를 저장할 폼 데이터 -->
										<input type="hidden" name="uploadedFilesInfo" />
										<input type="hidden" name="modifiedFilesInfo" />
									
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
												//alert('업로드가 완료됐습니다.');
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
													var modifiedFilesInfo = uploader.getModifiedFilesInfo(JSON); 
													/**
													* 필요 시, 아래처럼 사용해 주십시오. (JSON으로 넘오올 경우)
													var obj = jQuery.parseJSON(uploadedFilesInfo);
													alertTimeout(obj.length);
													alertTimeout(obj[0].name);
													*/
													alert(uploadedFilesInfo);
													alert(modifiedFilesInfo);
													// 데이터 처리 페이지로 업로드 결과를 전송합니다.
													document.dataForm.uploadedFilesInfo.value = uploadedFilesInfo;
													document.dataForm.modifiedFilesInfo.value = modifiedFilesInfo; 
												
													//document.dataForm.submit();
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
												alert('[예외 정보]\n' + 'code : ' + obj.code + '\n' + 'message : ' + obj.message + '\n' + 'detailMessage : ' + obj.detailMessage);

												if (parseInt(obj.code, 10) > 400000) {
													var uploadedFilesInfo = uploader.getUploadedFilesInfo();
													document.dataForm.uploadedFilesInfo.value = uploadedFilesInfo;
													document.dataForm.action = "ErrorProcess.jsp";
													document.dataForm.submit();
												}
											}

											/**
											* NamoCrossUploader 객체를 생성합니다.
											*/
											//var uploadUrl = 'UploadProcess.jsp';
								            var uploadUrl = "/crossUploader/fileUpload.do";
								            var downloadUrl = "/crossUploader/fileDownload.do";

											var managerProperties = new Object();
											managerProperties.width = '436';                    	// FileUploadManager 너비
											managerProperties.height = '280';                   	// FileUploadManager 높이
											managerProperties.containerId = 'uploaderContainer';	// FileUploadManager 객체가 생성될 html div 태그 id
											managerProperties.uploadUrl = uploadUrl;                // 파일 업로드 처리 페이지 경로
											managerProperties.uploadButtonVisible = false;			// ???? 업로드 버튼
													
											var monitorProperties = new Object();
											monitorProperties.monitorLayerClass = 'monitorLayer';      // FileUploadMonitor 창의 스타일입니다. (namocrossuploader.css 파일에 정의, 변경 가능)
											monitorProperties.monitorBgLayerClass = 'monitorBgLayer';  // FileUploadMonitor 창의 백그라운드 스타일입니다. (namocrossuploader.css 파일에 정의, 변경 가능)
											monitorProperties.closeMonitorCheckBoxChecked = true;      // 전송 완료 후 FileUploadMonitor 창 닫기 설정
											
											var uploader = namoCrossUploader.createUploader(
												JSON.stringify(managerProperties),                          // FileUploadManager 프로퍼티를 JSON 문자열로 전달
												JSON.stringify(monitorProperties),                          // FileUploadMonitor 프로퍼티를 JSON 문자열로 전달
												JSON.stringify(window.namoCrossUploaderConfig.eventNames)); // 이벤트 이름을 JSON 문자열로 전달
												
											/**
											 * 예외 발생 시 호출됩니다.
											 */
											var onStartUpload = function () {
												var totalFileCount = uploader.getTotalFileCount();
												alert("onStartUpload {{"+ totalFileCount +"}}");
												if( totalFileCount > 0 )
												{
													uploader.startUpload();
												}
												else
												{
													var uploadedFilesInfo = uploader.getUploadedFilesInfo();
													var modifiedFilesInfo = uploader.getModifiedFilesInfo();
													document.dataForm.uploadedFilesInfo.value = uploadedFilesInfo;
													document.dataForm.modifiedFilesInfo.value = modifiedFilesInfo;
													//document.dataForm.submit();
												}
												//uploader.startUpload();
											}
											
											/**
											* 기존에 업로드 된 파일정보 추가
											*/
											/* */
											for(var i=1; i<4; i++) {
												var uploadedFileInfo = new Object();
												uploadedFileInfo.fileId = 'FILEID_000' + i.toString();
												uploadedFileInfo.fileName = '테스트 업로드 파일 0' + i.toString() + '.txt';
												uploadedFileInfo.fileSize = '10240';
											
												uploader.addUploadedFile(JSON.stringify(uploadedFileInfo));
											}
											/* */
										</script>
									</div>
								</td>
							</tr>

					</table>
				</form>
				<div class="btn ac"><input type="button" value="업로드" onclick="onStartUpload()" /></div>
			</div>

	</div>	

</div>
</body>
</html>
