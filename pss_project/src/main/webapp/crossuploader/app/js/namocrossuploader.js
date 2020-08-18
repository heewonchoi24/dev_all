/*
 * NamoCrossUploader program file.
 * Copyright NAMO Interactive Inc.
 */
var __NamoCrossUploaderUtils = function () {
    this.s4 = function () {
        return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    };

    this.getGuid = function () {
        var guid = (this.s4() + this.s4() + "-" + this.s4() + "-4" + this.s4().substr(0, 3) + "-" + this.s4() + "-" + this.s4() + this.s4() + this.s4()).toLowerCase();
        return guid;
    };

    this.stringFormat = function () {
        var expression = arguments[0];
        for (var i = 1; i < arguments.length; i++) {
            var pattern = "{" + (i - 1) + "}";
            expression = expression.replace(pattern, arguments[i]);
        }
        return expression;
    };

    this.convertByteUnit = function (number) {
        var unitLevel = 0;
        var unit = "";
        var resultString = "";

        if (number / 1000.0 / 1000.0 / 1000.0 > 1) {
            unit = "GB";
            unitLevel = 3;
        }
        else if (number / 1000.0 / 1000.0 > 1) {
            unit = "MB";
            unitLevel = 2;
        }
        else if (number / 1000.0 > 1) {
            unit = "KB";
            unitLevel = 1;
        }
        else {
            //unit = "Bytes"; 
            unit = "B";
            unitLevel = 0;
        }
        resultString = this.convertByteUnitWithLevel(number, unitLevel);
        resultString += unit;
        return resultString;
    };

    this.convertByteUnitWithLevel = function (number, unitLevel) { 
        var resultString = ""; 
        var calculatedNumber = 0;  
			
        if(unitLevel == 3)  
            calculatedNumber = number/1024.0/1024.0/1024.0; 
        else if(unitLevel == 2) 
            calculatedNumber = number/1024.0/1024.0; 
        else if(unitLevel == 1) 
            calculatedNumber = number/1024.0;
        else
            calculatedNumber = number; 
			
        resultString = this.numberFormat(calculatedNumber); 
        return resultString;  	
    };

    this.numberFormat = function (number, precision) {
        if (precision == undefined)
            precision = 2;

        number = number.toFixed(precision);
        var parts = number.toString().split(".");
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    };
		

    this.getJsonString = function (keys, values) { 
        if(keys == undefined || keys.length == 0)
            return '{}'; 
       
        var json = ''; 
        for(var i=0; i<keys.length; i++) {
            json += ('"' + keys[i].toString() + '":'); 
            json += ('"' + values[i].toString() + '",'); 
        }
        if(json.length > 0) 
            json = '{' + json.substring(0, json.length-1) + '}'; 
			
        return json; 
    }
};

var __UploadFileInfo = function () {
    this.fileType = '1'; // 1:파일 2:업로드된 파일(게시판 수정모드)
    this.fileId = '';       // 게시판 수정모드를 위한 사용
    this.file;
    this.fileName = '';
    this.fileSize = 0;
    this.status = 'WAIT'; // WAIT, COMPLETION, CANCELLATION
    this.isDeleted = false;
    this.transferedSize = 0;
    this.xmlHttpRequest = null;
    this.modifiedFileId = ''; // 내부 검색용
}; 

var __DownloadFileInfo = function () {
    this.fileId = ''; 
    this.fileName = '';
    this.fileSize = 0;
    this.fileUrl = ''; 
}; 

var __Global = function () { 


    // Max file size
    this.MAX_FILE_SIZE = 2147483647; // (1024*1024*1024*2)-1

    // 일반적 예외 코드 정의 
    this.ALLOWED_EXTENSION_ERROR = "300101"; 
    this.MAX_FILE_COUNT_ERROR= "300102"; 
    this.MAX_FILE_SIZE_ERROR = "300103"; 
    this.MAX_TOTAL_FILE_SIZE_ERROR = "300104"; 
    //this.EMPTY_FILES_TO_TRANSFER_ERROR = "300105";

    // 서버측 예외 코드 정의
    this.HTTP_STATUS_ERROR = "500501"; 
}


var __FileUploadManager = function () {
    this.utils = new __NamoCrossUploaderUtils();
    this.global = new __Global(); 
    this.containerId = ""; 

    this.mainPanel = this.utils.getGuid();

    this.buttonPanel = this.utils.getGuid();
    this.addFileButton = this.utils.getGuid();
    this.fileButton = this.utils.getGuid();
    this.uploadButton = this.utils.getGuid();

    this.topSplitLine = this.utils.getGuid(); 

    this.managerDataGrid = this.utils.getGuid();

    this.statusPanel = this.utils.getGuid();
    this.deleteFileButton = this.utils.getGuid();
    this.statusLabel = this.utils.getGuid();

    this.width = 0;
    this.height = 0;
    this.buttonPanelHeight = 40;
    this.buttonWidth = 92;
    this.buttonHeight = 30;
    this.topSplitLineHeight = 1;
    this.statusPanelHeight = 28;
    this.statusHeight = 20;
    this.deleteFileButtonHeight = 20;
    this.deleteFileButtonWidth = 60; 
    this.statusLabelHeight= 20;

    this.uploadButtonVisible = true; 

    this.defaultMargin = 4;
    this.leftMargin = 10;
    this.rightMargin = 10;
    this.topMargin = 5;

    this.fileInfoList = [];
    this.totalFileSize = 0;
    this.totalUploadedFileSize = 0; 
    this.currentUploadItemIndex = 0;
    this.uploadUrl = "";
    this.uploadedFileInfoList = [];
    this.modifiedFilesInfoList = [];

    this.dataGrid;

    this.fontFamily = "Malgun Gothic";

    // event
    this.onStartUpload = "";
    this.onStartUploadItem = "";
    this.onEndUploadItem = "";
    this.onEndUpload = "";
    this.onCloseMonitorWindow = "";
    this.onCancelUploadItem = "";
    this.onException = "";

    this.uploadStatus = "WAIT";

    this.progressTimer; 
    this.startTime = 0; // for checking speed
    this.lastExceptionInfo = ''; 

    this.allowedFileExtensionList = [];
    this.fileExtensionCheckMode = 'NORMAL'; // NORMAL, REVERSE
    this.maxFileCount = -1;
    this.maxTotalFileSize = -1;
    this.maxFileSize = this.global.MAX_FILE_SIZE;
    
    this.create = function (properties, eventNames) {

        this.setProperties(properties);
        this.setEvnetNames(eventNames); 
        this.createControls(); 
        this.setEventHandler(); 
        this.setUploadStatus("WAIT");
        this.setLastExceptionInfo('');
    };

    this.setProperties = function (properties) {
        var obj = jQuery.parseJSON(properties);
        this.width = obj.width;
        this.height = obj.height;
        this.containerId = obj.containerId;
        this.uploadUrl = obj.uploadUrl;

        this.uploadButtonVisible = obj.uploadButtonVisible == undefined ? true : false;
    };

    this.resetProperties = function (properties) {
        var obj = jQuery.parseJSON(properties);

        if (obj.width != undefined) {
            this.width = obj.width; 
            $('#' + this.mainPanel).css('width', obj.width + 'px'); 
        }
        if (obj.height != undefined) {
            this.height = obj.height; 
            $('#' + this.mainPanel).css('height', obj.height + 'px');
        }
        if (obj.borderColor != undefined) {
            $('#' + this.mainPanel).css('border-color', obj.borderColor);
        }
        if (obj.topPanelDisplayStyle != undefined) {
            $('#' + this.buttonPanel).css('display', obj.topPanelDisplayStyle);
            $('#' + this.topSplitLine).css('display', obj.topPanelDisplayStyle);
        }

        if (obj.selectFilesButtonDisplayStyle != undefined) 
            obj.selectFilesButtonDisplayStyle == 'block' ? $('#' + this.addFileButton).show() : $('#' + this.addFileButton).hide();
        if (obj.selectFilesButtonDisabledStyle != undefined)
            $('#' + this.addFileButton).prop('disabled', obj.selectFilesButtonDisabledStyle);

        if (obj.uploadButtonDisplayStyle != undefined)
            $('#' + this.uploadButton).css('display', obj.uploadButtonDisplayStyle);
        if (obj.uploadButtonDisabledStyle != undefined)
            $('#' + this.uploadButton).prop('disabled', obj.uploadButtonDisabledStyle);

        if (obj.selectFilesButtonDisplayStyle != undefined && obj.selectFilesButtonDisplayStyle == 'none' &&
            obj.uploadButtonDisplayStyle != undefined && obj.uploadButtonDisplayStyle == 'none') {
            $('#' + this.buttonPanel).css('display', 'none');
            $('#' + this.topSplitLine).css('display', 'none');
        }

        // 크기, 위치 변경
        $('#' + this.buttonPanel).css('width', this.width + 'px');
        $('#' + this.topSplitLine).css('width', this.width + 'px');

        var dataGridWidth = this.width - (this.leftMargin + this.rightMargin);
        var dataGridHeight = 0;
        if ($('#' + this.buttonPanel).css('display') == 'block') {
            dataGridHeight = this.height - (this.buttonPanelHeight + this.topSplitLineHeight + this.statusPanelHeight + (this.topMargin * 3));
            $('#' + this.managerDataGrid).css('margin-top', this.topMargin + 'px');
        }
        if ($('#' + this.buttonPanel).css('display') == 'none') {
            dataGridHeight = this.height - (this.statusPanelHeight + (this.topMargin * 4));
            $('#' + this.managerDataGrid).css('margin-top', (this.topMargin * 2) + 'px');
        }
        $('#' + this.managerDataGrid).css('width', dataGridWidth + 'px'); 
        $('#' + this.managerDataGrid).css('height', dataGridHeight + 'px');
        namoCrossUploader.fileUploadManager.dataGrid.width = dataGridWidth; 
        namoCrossUploader.fileUploadManager.dataGrid.height = dataGridHeight;
        var columns = namoCrossUploader.fileUploadManager.dataGrid.getColumns(); 
        columns[0].width = dataGridWidth - 200; 
        columns[1].width = 100; 
        columns[2].width = 100; 
        namoCrossUploader.fileUploadManager.dataGrid.setColumns(columns);

        $('#' + this.statusPanel).css('width', dataGridWidth + 'px');
    };


    this.createControls = function () {
        // Main panel
        $('#' + this.containerId).append(this.utils.stringFormat('<div id="{0}" style="width:100%;height:{2}px;"></div>',
            this.mainPanel, this.width, this.height)); 

        // Button panel
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;"></div>',
            this.buttonPanel, this.width, this.buttonPanelHeight));
        $('#' + this.buttonPanel).append(this.utils.stringFormat('<input type="file" id="{0}" style="display:none;" multiple/>', this.fileButton)); 
        $('#' + this.buttonPanel).append(this.utils.stringFormat('<input type="button" id="{0}" value="파일선택" ' +
            'class="button bt2 btn_file"/>', 
            this.addFileButton, this.buttonWidth, this.buttonHeight, this.leftMargin, this.topMargin, this.fontFamily));
            //'background-image:url(../../app/image/select-file.png);background-repeat: no-repeat;background-position:left;padding-left:18px;" />',
        $('#' + this.buttonPanel).append(this.utils.stringFormat('<input type="button" id="{0}" value="업로드" ' + 
            'class="button bt3 btn_upload"/>',
            this.uploadButton, this.buttonWidth, this.buttonHeight, this.rightMargin, 5, this.fontFamily, this.uploadButtonVisible ? 'block' : 'none'));

        // Top split line
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" ></div>',
          this.topSplitLine, this.width, this.topSplitLineHeight));

        // DataGrid
        var dataGridWidth = this.width - (this.leftMargin + this.rightMargin);
        var dataGridHeight = this.height - (this.buttonPanelHeight + this.topSplitLineHeight + this.statusPanelHeight + (this.topMargin *3));
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1};height:{2}px;background:#f7f7f7;"></div>',
            this.managerDataGrid, dataGridWidth, dataGridHeight, this.leftMargin, this.topMargin));
        
        var gridWidth = this.width - (this.leftMargin + this.rightMargin);
        var fieldWidth = 100; 
        var grid;
        var columns = [
          { id: "title", name: "파일이름", field: "title", width: gridWidth - (fieldWidth * 2) },
          { id: "size", name: "크기", field: "size", width:fieldWidth},
          { id: "status", name: "상태", field: "status", width: fieldWidth }
        ];

        var options = {
            enableCellNavigation: true,
            enableColumnReorder: false,
            editable: true,
            enableCellNavigation: true,
            forceFitColumns: true,
            autoEdit: false
        };

        var data = [];
        namoCrossUploader.fileUploadManager.dataGrid = new Slick.Grid("#" + namoCrossUploader.fileUploadManager.managerDataGrid, data, columns, options);
        namoCrossUploader.fileUploadManager.dataGrid.setSelectionModel(new Slick.RowSelectionModel({ selectActiveRow: true }));
        //$(function () {
        //});

        // Status panel
        var statusPanelWidth = dataGridWidth;
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:100%;height:30px;background-color:#333;"></div>',
            this.statusPanel, statusPanelWidth, this.statusPanelHeight, this.leftMargin));

        /*
        $('#' + this.statusPanel).append(this.utils.stringFormat('<span align="left" style="width:{0}px;height:{1}px;"> ' +
            '<a id={2} href="#" style="display: inline-block;text-decoration: none !important; ' + 
            'margin-left:{3}px;margin-top:{4}px;font-family:{5};font-size:12px;color:white;">X 삭제</a></span>',
             this.deleteFileButtonWidth, this.deleteFileButtonHeight, this.deleteFileButton, this.defaultMargin, 6, this.fontFamily));
             */ 

        $('#' + this.statusPanel).append(this.utils.stringFormat('<input type="button" id="{0}" value="x 삭제" ' +
           'style="width:{1}px;height:{2}px;margin-left:{3}px;margin-top:{4}px;font-size:12px; ' +
           'background:none;border:none;color:white;button:focus {outline:none;};"/>',
           this.deleteFileButton, this.deleteFileButtonWidth, this.deleteFileButtonHeight, 0, this.defaultMargin, this.fontFamily));
        

        $('#' + this.deleteFileButton).on("mouseover", function () {
            $(this).css("color", "#E0E0E0");
            $(this).css("outline", "none");
        }).on("mouseout", function () {
            $(this).css("color", "white");
        });
        $('#' + this.statusPanel).append(this.utils.stringFormat('<span id="{0}" ' +
            'style="height:{1}px;float:right;text-align:right;margin-right:{2}px;margin-top:{3}px;font-size:12px;color:white;">0개의 파일 : 0.00B</span>',
            this.statusLabel, this.statusLabelHeight, this.rightMargin, 6, this.fontFamily));
    };

    this.onClickAddFileButton = function () {
        namoCrossUploader.fileUploadManager.selectFiles(); 
    };
    this.selectFiles = function () {
        $('#' + namoCrossUploader.fileUploadManager.fileButton).click();
    }

    ////
    // 선택한 모든 데이터가 삭제되도록 수정
    // 20170516
    /*
    this.onClickDeleteFileButton = function () {
        var grid = namoCrossUploader.fileUploadManager.dataGrid;
        var dataList = grid.getData();
        if (grid.getActiveCell()) {
            var currentRow = grid.getActiveCell().row;
            namoCrossUploader.fileUploadManager.deleteFiles(currentRow);

            dataList.splice(currentRow, 1);
            var r = currentRow;
            while (r < dataList.length) {
                grid.invalidateRow(r);
                r++;
            }
            grid.updateRowCount();
            grid.render();
            grid.scrollRowIntoView(currentRow - 1)
        }
    };
    */
    this.onClickDeleteFileButton = function ()
    {
        var grid = namoCrossUploader.fileUploadManager.dataGrid;
        var dataList = grid.getData();
        var rowsToDelete = grid.getSelectedRows().sort().reverse();

        for (var i = 0; i < rowsToDelete.length; i++)
        {
            namoCrossUploader.fileUploadManager.deleteFiles(rowsToDelete[i]);
            dataList.splice(rowsToDelete[i], 1);

            grid.scrollRowIntoView(rowsToDelete[i] - 1)
        }

        grid.invalidate();
        grid.setSelectedRows([]);
    };
    ////

    this.deleteFiles = function(currentRow)
    {
        var fileInfo = this.fileInfoList[currentRow];
        if (fileInfo.fileType == 'UPLOADED') {
            for (var i = 0; i < this.modifiedFilesInfoList.length; i++) {
                if (fileInfo.modifiedFileId == this.modifiedFilesInfoList[i].modifiedFileId) {
                    this.modifiedFilesInfoList[i].isDeleted = true;
                    break; 
                }
            }
        }

        this.totalFileSize -= fileInfo.fileSize;
        this.fileInfoList.splice(currentRow, 1);
        this.updateStatus();
    }

    this.deleteAllFiles = function () {
        /*
        for(var i=0; i<)
        this.totalFileSize = 0;
        this.fileInfoList.splice(currentRow, 1);
        this.updateStatus();
        */ 
    }

    this.onClickUploadFileButton = function () {
        namoCrossUploader.fileUploadManager.startUpload();
    };

    this.startUpload = function () {
        var manager = namoCrossUploader.fileUploadManager;
        var monitor = namoCrossUploader.fileUploadMonitor;

        if (manager.fileInfoList.length == 0) {
            alert("업로드 할 파일을 선택해 주십시오.");
            return;
        }

        manager.currentUploadItemIndex = 0;

        // 업로드 모니터에 데이터 전달
        monitor.clear();
        monitor.addFiles(manager.fileInfoList);
        monitor.open();

        manager.startTime = new Date().getTime();
        manager.progressTimer = setInterval(manager.startProgressTimer, 500);

        manager.totalUploadedFileSize = 0;
        manager.setUploadStatus("TRANSFER");
        monitor.resetButtonStatus();
        manager.dispatchEvent(manager.onStartUpload);
        manager.sendFormData();
    };

    this.startProgressTimer = function () {
        var manager = namoCrossUploader.fileUploadManager;
        var fileInfo = manager.fileInfoList[manager.currentUploadItemIndex];
        manager.updateProgressStatus(fileInfo.status, fileInfo.transferedSize);
    };

    this.setEventHandler = function () {
        $('#' + this.addFileButton).bind("click", this.onClickAddFileButton);
        $('#' + this.deleteFileButton).bind("click", this.onClickDeleteFileButton);
        $('#' + this.uploadButton).bind("click", this.onClickUploadFileButton);

        /*
        $('#' + this.fileButton).bind("change", this.onFileSelect);
        $('#' + this.managerDataGrid).bind("dragover", this.onDragOver);
        $('#' + this.managerDataGrid).bind("drop", this.onDrop)n
        */ 

        document.getElementById(this.fileButton).addEventListener("change", this.onFileSelect, false);
        document.getElementById(this.managerDataGrid).addEventListener("dragover", this.onDragOver, false);
        document.getElementById(this.managerDataGrid).addEventListener("drop", this.onDrop, false);
    };

    this.updateStatus = function () {
        var status = this.utils.stringFormat('{0}개의 파일 : {1}',
            this.fileInfoList.length,
            this.utils.convertByteUnit(this.totalFileSize));
        $('#' + this.statusLabel).text(status);
    }

    this.updateProgressStatus = function (status, loaded) {

        var manager = namoCrossUploader.fileUploadManager;
        var monitor = namoCrossUploader.fileUploadMonitor;

        fileInfo = manager.fileInfoList[manager.currentUploadItemIndex];
        fileInfo.status = status;

        var statusLabel = "";
        if (fileInfo.status == "COMPLETION") {
            fileInfo.transferedSize = fileInfo.fileSize; 
            manager.totalUploadedFileSize += fileInfo.fileSize;
            statusLabel = "완료";
        }
        else if (fileInfo.status == "CANCELLATION") {
            fileInfo.transferedSize = 0;
            statusLabel = "취소";
        }
        else if (fileInfo.status == "FAILURE") {
            fileInfo.transferedSize = 0;
            statusLabel = "실패";
        }
        else if (fileInfo.status == "TRANSFER") {
            fileInfo.transferedSize = loaded;
            statusLabel = manager.utils.convertByteUnit(fileInfo.transferedSize);
        }
        else {
            fileInfo.transferedSize = 0;
            statusLabel = "대기";
        }

        // Title
        $('#' + monitor.titleLabel).text(manager.utils.stringFormat('{0}개의 파일 중 {1}번째 파일을 업로드하고 있습니다.',
            manager.fileInfoList.length, manager.currentUploadItemIndex + 1));

        // Each uploaded file size
        manager.dataGrid.getDataItem(manager.currentUploadItemIndex)["status"] = statusLabel;
        manager.dataGrid.updateCell(manager.currentUploadItemIndex, 2);
        manager.dataGrid.render();

        monitor.dataGrid.getDataItem(manager.currentUploadItemIndex)["status"] = statusLabel;
        monitor.dataGrid.updateCell(manager.currentUploadItemIndex, 2);
        monitor.dataGrid.render();

        // Total uploaded file size
        var transferedSize = (fileInfo.status == "COMPLETION") ? 0 : fileInfo.transferedSize;
        $('#' + monitor.totalUploadedFileSizeLabel).text(manager.utils.convertByteUnit(manager.totalUploadedFileSize + transferedSize));
        $('#' + monitor.totalFileSizeLabel).text("/" + manager.utils.convertByteUnit(manager.totalFileSize));

        // Upload speed
        var currentTime = new Date().getTime(); 
        var totalUploadedFileSizePerMillisec = manager.getTotalUploadedFileSizePerMillisec(manager.totalUploadedFileSize + transferedSize, currentTime);
        $('#' + monitor.transferSpeedLabel).text("(" + manager.utils.convertByteUnit(totalUploadedFileSizePerMillisec) + "/sec)");

        // Remaining time
        var remainingTime = 0;
        var remainingFileSize = manager.totalFileSize - (manager.totalUploadedFileSize + transferedSize);
        if(remainingFileSize > 0 && totalUploadedFileSizePerMillisec > 0)
            remainingTime = ((remainingFileSize * 1000.0) / totalUploadedFileSizePerMillisec)/1000;  
        $('#' + monitor.remainingTimeLabel).text(parseInt(remainingTime, 10));
			

        // Percent
        var percent = ((manager.totalUploadedFileSize + transferedSize) / manager.totalFileSize) * 100;
        percent = parseInt(percent, 10);
        $('#' + monitor.totalUploadedPercentLabel).text(percent.toString() + "%");

        // 프로그래스바
        $('#' + monitor.progressBar).val(percent);
     
    };

    this.getTotalUploadedFileSizePerMillisec = function (totalUploadedFileSize, currentTime) {
        var totalUploadedFileSizePerMillisec = 0; 
        if(this.totalFileSize > 0 && totalUploadedFileSize > 0 && (currentTime - this.startTime) > 0) {  
            totalUploadedFileSizePerMillisec = (totalUploadedFileSize * 1000) / (currentTime - this.startTime);
        }
        return totalUploadedFileSizePerMillisec; 
    }

    this.onDrop = function (event) {
        event.stopPropagation();
        event.preventDefault();
        namoCrossUploader.fileUploadManager.addFiles(event.dataTransfer.files);
        namoCrossUploader.fileUploadManager.updateStatus();
    }


    this.onDragOver = function (event) {
        event.stopPropagation();
        event.preventDefault();
        event.dataTransfer.dropEffect = "copy";
    }

    this.nextOrEndUpload = function () {
        var manager = namoCrossUploader.fileUploadManager;
        var monitor = namoCrossUploader.fileUploadMonitor;

        if ((manager.currentUploadItemIndex + 1) == manager.fileInfoList.length) {
            clearInterval(manager.progressTimer);
            manager.setUploadStatus('COMPLETION');
            monitor.resetButtonStatus();

            manager.dispatchEvent(manager.onEndUpload);

            if (monitor.getCloseMonitorCheckBoxStatus() == true) {
                monitor.close();
                manager.dispatchEvent(manager.onCloseMonitorWindow);
            }
        }
        else {
            manager.currentUploadItemIndex++;
            setTimeout(manager.sendFormData(), 0);
        }
    };

    this.sendFormData = function () {

        for (var i = this.currentUploadItemIndex; i < this.fileInfoList.length; i++) {
            var fileInfo = this.fileInfoList[this.currentUploadItemIndex];

            //  WAIT인 것만 업로드
            if (fileInfo.status != "WAIT") {
                if (fileInfo.status == "COMPLETION")
                    this.updateProgressStatus('COMPLETION');

                this.nextOrEndUpload(); 
                break; 
            }

            // 게시판 수정 모드 처리
            if (fileInfo.fileType == "UPLOADED") {
                this.dispatchEvent(this.onStartUploadItem, this.currentUploadItemIndex);
                this.updateProgressStatus('COMPLETION');
                this.dispatchEvent(this.onEndUploadItem, this.currentUploadItemIndex);
                
                this.nextOrEndUpload();
                break; 
            }

            this.updateProgressStatus("TRANSFER", 0);
            this.dispatchEvent(this.onStartUploadItem, this.currentUploadItemIndex);

            var formData = new FormData();
            formData.append("CU_FILE", fileInfo.file);

            fileInfo.xmlHttpRequest = new XMLHttpRequest();
            fileInfo.xmlHttpRequest.open("POST", this.uploadUrl, true);

            fileInfo.xmlHttpRequest.onreadystatechange = function () {
                var manager = namoCrossUploader.fileUploadManager;
                var monitor = namoCrossUploader.fileUploadMonitor;
                var fileInfo = manager.fileInfoList[manager.currentUploadItemIndex];

                if (fileInfo.xmlHttpRequest.readyState == 4 && fileInfo.xmlHttpRequest.status == 200) {

                    manager.uploadedFileInfoList.push(fileInfo.xmlHttpRequest.responseText);
                    manager.updateProgressStatus('COMPLETION');
                    manager.dispatchEvent(manager.onEndUploadItem, manager.currentUploadItemIndex);

                    // Next or end upload
                    manager.nextOrEndUpload();
                }
                else if (fileInfo.xmlHttpRequest.readyState == 4 && fileInfo.xmlHttpRequest.status >= 500) {
                    clearInterval(manager.progressTimer);
                    manager.updateProgressStatus('FAILURE');
                    manager.setUploadStatus('FAILURE');
                    monitor.resetButtonStatus();

                    var keys = new Array('code', 'message', 'detailMessage');
                    var values = new Array(manager.global.HTTP_STATUS_ERROR, fileInfo.xmlHttpRequest.status.toString(), fileInfo.xmlHttpRequest.responseText);
                    manager.setLastExceptionInfo(manager.utils.getJsonString(keys, values));
                    manager.dispatchEvent(manager.onException);
                }
            };

            fileInfo.xmlHttpRequest.upload.addEventListener("progress", this.updateProgress, false);
            fileInfo.xmlHttpRequest.addEventListener("load", this.transferComplete, false);
            fileInfo.xmlHttpRequest.upload.addEventListener("error", this.transferFailed, false);
            fileInfo.xmlHttpRequest.addEventListener("abort", this.transferCanceled, false);

            fileInfo.xmlHttpRequest.send(formData);
            break; 
        }
    };

    this.setLastExceptionInfo = function (lastExceptionInfo) {
        this.lastExceptionInfo = lastExceptionInfo;
    }
    this.getLastExceptionInfo = function () {
        return this.lastExceptionInfo;
    }

    this.updateProgress = function (event) {
        if (event.lengthComputable) {
            //namoCrossUploader.fileUploadManager.updateProgressStatus("TRANSFER", event.loaded);
            namoCrossUploader.fileUploadManager.fileInfoList[namoCrossUploader.fileUploadManager.currentUploadItemIndex].transferedSize = event.loaded; 
        }
        else {
            // Unable to compute progress information since the total size is unknown
        }
    }

    this.transferComplete = function(event) {
        //console.log("The transfer is complete.");
    }

    this.transferFailed = function (event) {
        //console.log("An error occurred while transferring the file.");
        //clearInterval(namoCrossUploader.fileUploadManager.progressTimer);
        //console.log(event.status);
    }

    this.transferCanceled = function (evnet) {
        //console.log("The transfer has been canceled by the user.");
        //clearInterval(namoCrossUploader.fileUploadManager.progressTimer);
    }

    this.getUploadedFilesInfo = function () { 
        var fileItem;
        var i = 0; 
        var json = ""; 
			
        if (this.uploadedFileInfoList.length == 0)
            return '[]'; 
            
        for (i = 0; i < this.uploadedFileInfoList.length; i++) {
            json += this.uploadedFileInfoList[i] + ',';
        }
            
        if(json.length > 0) 
            json = '[' + json.substring(0, json.length-1) + ']'; 

        return json; 
    }


    this.getModifiedFilesInfo = function () {
        var fileItem;
        var i = 0;
        var json = "";

        if (this.modifiedFilesInfoList.length == 0)
            return '[]';

        for (i = 0; i < this.modifiedFilesInfoList.length; i++) {
            json += this.getFileInfoToJson(this.modifiedFilesInfoList[i]) + ',';
        }

        if (json.length > 0)
            json = '[' + json.substring(0, json.length - 1) + ']';

        return json;
    }



    /*
    this.getUploadedFileInfoAt = function (rowIndex) {
        var fileItem;
        var i = 0;

        if (this.uploadedFileInfoList.length < (rowIndex+1))
            return '{}';

        return this.uploadedFileInfoList[rowIndex];
    }
    */ 

    this.getFileInfoAt = function (rowIndex) {
        if (this.fileInfoList.length < (rowIndex + 1))
            return '{}';

        return this.getFileInfoToJson(this.fileInfoList[rowIndex]);
    }

    this.getFileInfoToJson = function (fileInfo) {
        var keys = new Array('fileType', 'fileId', 'fileName', 'fileSize', 'status', 'isDeleted');
        var values = new Array(fileInfo.fileType, fileInfo.fileId, fileInfo.fileName, fileInfo.fileSize, fileInfo.status, fileInfo.isDeleted);
        return this.utils.getJsonString(keys, values);
    }

    this.dispatchEvent = function (eventName, eventParam) {
        if (eventName == undefined || eventName == "")
            return;

        if (eventParam != undefined) 
            setTimeout(this.utils.stringFormat(eventName + '(' + eventParam + ')'), 0);
        else
            setTimeout(this.utils.stringFormat(eventName + '()'), 0);
    };

    this.setEvnetNames = function (eventNames) {
        var obj = jQuery.parseJSON(eventNames);

        this.onStartUpload = obj.onStartUpload;
        this.onStartUploadItem = obj.onStartUploadItem;
        this.onEndUploadItem = obj.onEndUploadItem;
        this.onEndUpload = obj.onEndUpload;
        this.onCloseMonitorWindow = obj.onCloseMonitorWindow;
        this.onCancelUploadItem = obj.onCancelUploadItem;
        this.onException = obj.onException;
    };

    this.getUploadStatus = function () {
        return this.uploadStatus;
    };

    this.setUploadStatus = function (uploadStatus) {
        this.uploadStatus = uploadStatus;
    };

    this.getTotalFileCount = function () {
        return this.dataGrid.getData().length;
    }

    this.addUploadedFile = function (fileInfo) {
        var obj = jQuery.parseJSON(fileInfo);
        var fileId = obj.fileId;
        var fileName = obj.fileName;
        var fileSize = obj.fileSize;

        var dataGrid = namoCrossUploader.fileUploadManager.dataGrid;

        var fileInfo = new __UploadFileInfo();
        fileInfo.fileId = obj.fileId;
        fileInfo.fileName = obj.fileName;
        fileInfo.fileSize = parseInt(obj.fileSize);
        fileInfo.fileType = 'UPLOADED';
        fileInfo.status = 'WAIT';
        fileInfo.modifiedFileId = this.utils.getGuid(); 
        var statusLabel = '대기';

        namoCrossUploader.fileUploadManager.fileInfoList.push(fileInfo);
        namoCrossUploader.fileUploadManager.modifiedFilesInfoList.push(fileInfo);

        var datas = dataGrid.getData();
        datas.splice(datas.length, 0, {
            'title': fileName,
            'size': namoCrossUploader.fileUploadManager.utils.convertByteUnit(fileSize),
            'status': statusLabel
        });
        dataGrid.invalidateRow(datas.length);
        dataGrid.updateRowCount();
        dataGrid.render();
        dataGrid.scrollRowIntoView(datas.length - 1)

        namoCrossUploader.fileUploadManager.totalFileSize += fileInfo.fileSize;
        namoCrossUploader.fileUploadManager.updateStatus();
    }

   this.addFiles = function (files) {
        var dataGrid = namoCrossUploader.fileUploadManager.dataGrid;
        for (var i = 0; i < files.length; i++) {
            // Check limit
            if (this.checkLimit(files[i]) == false)
                break;

            var fileInfo = new __UploadFileInfo();
            fileInfo.file = files[i];
            
            // 20180615 IE 파일을 서버에 업로드할 때 로컬 디렉터리 경로 포함 수정
            //var fileName = fileInfo.file.name.split('\\');
            //fileInfo.fileName = fileName[fileName.length -1];
            fileInfo.fileName = fileInfo.file.name;
            
            fileInfo.fileSize = fileInfo.file.size;
            fileInfo.fileType = 'NORMAL';
            fileInfo.status = 'WAIT';
            var statusLabel = '대기';

            namoCrossUploader.fileUploadManager.fileInfoList.push(fileInfo);

            var datas = dataGrid.getData();
            datas.splice(datas.length, 0, {
                'title': fileInfo.fileName,
                'size': namoCrossUploader.fileUploadManager.utils.convertByteUnit(fileInfo.fileSize),
                'status': statusLabel
            });
            dataGrid.invalidateRow(datas.length);
            dataGrid.updateRowCount();
            dataGrid.render();
            dataGrid.scrollRowIntoView(datas.length - 1)

            namoCrossUploader.fileUploadManager.totalFileSize += fileInfo.fileSize;
        }
    };

    this.onFileSelect = function (event) {
        namoCrossUploader.fileUploadManager.addFiles(event.target.files);
        namoCrossUploader.fileUploadManager.updateStatus();

        // 연속된 동일파일 선택에 대한 예외처리
        this.value = ""; 
    };

    this.setFileFilter = function (fileFilterInfo) {
        if (fileFilterInfo == undefined || fileFilterInfo == '')
            return;
        $('#' + this.fileButton).prop('accept', fileFilterInfo);
    };

    this.setAllowedFileExtension = function (allowedExtension, fileExtensionCheckMode) {
        this.allowedFileExtensionList = allowedExtension.toLowerCase().split(';'); 
        this.fileExtensionCheckMode = fileExtensionCheckMode; 
    };

    this.setMaxFileCount = function (maxFileCount) {
        if(maxFileCount <= 0)
            maxFileCount = -1; 

        this.maxFileCount = maxFileCount;
    }; 

    this.setMaxTotalFileSize = function (maxTotalFileSize) {
        if(maxTotalFileSize <= 0)
            maxTotalFileSize = -1; 

        this.maxTotalFileSize = maxTotalFileSize; 
    }; 

    this.setMaxFileSize = function (maxFileSize) {
        if(maxFileSize <= 0 || maxFileSize > this.global.MAX_FILE_SIZE)
            maxFileSize = this.global.MAX_FILE_SIZE; 

        this.maxFileSize = maxFileSize; 
    }; 

    this.checkLimit = function(file) { 
        var isValid = true; 
        var keys = null;
        var values = null;

        if(this.allowedFileExtensionList.length > 0) {
            // Check extension 
            var ext = '';
            var index = file.name.lastIndexOf('.');
            if (index != -1) {
                ext = file.name.substring(index + 1);
                ext = ext.toLowerCase();
            }

            // 허용된 확장자 검사
            if (this.fileExtensionCheckMode == 'FORWARD') {
                isValid = false;
                for (var i = 0; i < this.allowedFileExtensionList.length; i++) {
                    if (this.allowedFileExtensionList[i] == ext) {
                        isValid = true;
                        break; 
                    }
                }
                if (isValid == false) {
                    keys = new Array('code', 'message', 'detailMessage');
                    values = new Array(this.global.ALLOWED_EXTENSION_ERROR,
                        this.utils.stringFormat('({0}) 파일은 전송이 제한된 파일 확장자입니다.', file.name), '');
                }
            }
            // 허용되지 않은 확장자 검사
            else {
                isValid = true;
                for (var i = 0; i < this.allowedFileExtensionList.length; i++) {
                    if (this.allowedFileExtensionList[i] == ext) {
                        isValid = false;
                        break;
                    }
                }
                if (isValid == false) {
                    keys = new Array('code', 'message', 'detailMessage');
                    values = new Array(this.global.ALLOWED_EXTENSION_ERROR,
                        this.utils.stringFormat('({0}) 파일은 전송이 제한된 파일 확장자입니다.', file.name), '');
                }
            }
        }

        if (isValid == true) {
            // Check max file count
            if (this.maxFileCount != -1 && this.maxFileCount < this.fileInfoList.length + 1) {
                keys = new Array('code', 'message', 'detailMessage');
                values = new Array(this.global.MAX_FILE_COUNT_ERROR,
                    this.utils.stringFormat('전송할 수 있는  파일 개수는 {0} 입니다.', this.utils.numberFormat(this.maxFileCount, 0)), '');

                isValid = false;
            }
                // Check max file size
            else if (this.maxFileSize < file.size) {
                keys = new Array('code', 'message', 'detailMessage');
                values = new Array(this.global.MAX_FILE_SIZE_ERROR,
                    this.utils.stringFormat('{0}보다 큰 파일({1})은 전송할 수 없습니다.', this.utils.numberFormat(this.maxFileSize, 0), file.name), '');

                isValid = false;
            }
                // Check max total file size
            else if (this.maxTotalFileSize != -1 && this.maxTotalFileSize < this.totalFileSize + file.size) {
                keys = new Array('code', 'message', 'detailMessage');
                values = new Array(this.global.MAX_FILE_COUNT_ERROR,
                    this.utils.stringFormat('전송할 수 있는 전체 파일의 크기는 {0}입니다.', this.utils.numberFormat(this.maxTotalFileSize, 0)), '');

                isValid = false;
            }
        }

        if (isValid == false) {
            this.setLastExceptionInfo(this.utils.getJsonString(keys, values));
            this.dispatchEvent(this.onException);
        }

        return isValid; 
    };
};



var __FileUploadMonitor = function () {
    this.utils = new __NamoCrossUploaderUtils();

    this.backgroundPanel = this.utils.getGuid();
    this.mainPanel = this.utils.getGuid();

    this.titlePanel = this.utils.getGuid();
    this.titleLabel = this.utils.getGuid();

    this.progressPanel = this.utils.getGuid();
    this.totalUploadedFileSizeLabel = this.utils.getGuid();
    this.totalFileSizeLabel = this.utils.getGuid();
    this.transferSpeedLabel = this.utils.getGuid();
    this.totalUploadedPercentLabel = this.utils.getGuid();
    this.remainingTimeLabel = this.utils.getGuid();
    this.remainingTimeUnitLabel = this.utils.getGuid();
    this.progressBar = this.utils.getGuid();

    this.monitorDataGrid = this.utils.getGuid(); 

    this.buttonPanel = this.utils.getGuid(); 
    this.closeCheckBox = this.utils.getGuid(); 
    this.transferButton = this.utils.getGuid(); 
    this.closeButton = this.utils.getGuid();

    this.width = 450;
    this.height = 358; 
    this.defaultMargin = 4; 
    this.leftMargin = 16;
    this.rightMargin = 16; 
    this.topMargin = 4;
    this.titlePanelHeight = 33; 
    this.progressPanelHeight = 58; 
    this.progressBarHeight = 17; 
    this.dataGridHeight = 207; // 213
    this.buttonPanelHeight = 33;

    this.dataGrid;

    this.fontFamily = "Malgun Gothic";
    this.monitorLayerClass = "";
    this.monitorBgLayerClass = ""; 

    this.create = function (properties) {
        var obj = jQuery.parseJSON(properties);
        this.monitorLayerClass = obj.monitorLayerClass;
        this.monitorBgLayerClass = obj.monitorBgLayerClass;

        this.createControls();
        this.setEventHandler();
        this.setCloseMonitorCheckBoxStatus(obj.closeMonitorCheckBoxChecked)
    };

    this.setProperties = function (properties) {
    };

    this.resetProperties = function (properties) {
        var obj = jQuery.parseJSON(properties);

        if (obj.closeMonitorCheckBoxChecked != undefined)
            this.setCloseMonitorCheckBoxStatus(obj.closeMonitorCheckBoxChecked);
    };

    this.createControls = function () {
        // Background Panel
        $('body').append(this.utils.stringFormat('<div id="{0}" style="display:none;" class="{1}"></div>',
            this.backgroundPanel, this.monitorBgLayerClass));

        // Main Panel
        $('body').append(this.utils.stringFormat('<div id="{0}" style="display:none;width:{1}px;height:{2}px;background:#EEEEEE;" class={3}></div>',
            this.mainPanel, this.width, this.height, this.monitorLayerClass));

        // Title Panel 
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;"></div>',
            this.titlePanel, this.width, this.titlePanelHeight));
        $('#' + this.titlePanel).append(this.utils.stringFormat('<span id="{0}" ' +
            'style="display:inline-block;margin-left:{1}px;margin-top:{2}px;color:#000;font-size:12px;">파일 업로드</span>',
            this.titleLabel, this.leftMargin, this.topMargin*2, this.fontFamily));

        // Progressbar Panel
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;"></div>',
            this.progressPanel, this.width, this.progressPanelHeight));
        $('#' + this.progressPanel).append(this.utils.stringFormat('<span id="{0}" ' +
            'style="display:inline-block;margin-left:{1}px;margin-top:{2}px;color:#037bc1;font-weight:bold;font-size:12px;">0.00B</span>',
            this.totalUploadedFileSizeLabel, this.leftMargin, 14, this.fontFamily));
        $('#' + this.progressPanel).append(this.utils.stringFormat('<span id="{0}" ' +
            'style="display:inline-block;margin-left:{1}px;margin-top:{2}px;color:#555;font-weight:bold;font-size:12px;">/0.00B</span>',
            this.totalFileSizeLabel, 0, 14, this.fontFamily));
        $('#' + this.progressPanel).append(this.utils.stringFormat('<span id="{0}"  ' +
            'style="display:inline-block;margin-left:{1}px;margin-top:{2}px;color:#555;font-weight:bold;font-size:12px;">(0/sec)</span>',
            this.transferSpeedLabel, 0, 14, this.fontFamily));
        var totalUploadedPercentLeft = (this.width / 2) - ($('#' + this.totalUploadedPercentLabel).width() / 2);
        $('#' + this.progressPanel).append(this.utils.stringFormat('<span id="{0}" ' +
            'style="display:inline-block;margin-left:{1}px;margin-top:{2}px;color:#000000;' + 
            'font-weight:bold;text-align:center;position: absolute;left:{3}px;font-size:20px;">0%</span>',
            this.totalUploadedPercentLabel, 0, this.topMargin, totalUploadedPercentLeft, this.fontFamily));
        $('#' + this.progressPanel).append(this.utils.stringFormat('<span id="{0}" ' +
            'style="display:inline-block;float:right;text-align:right;margin-right:{1}px;margin-top:{2}px;color:#555;' +
            'font-weight:bold;font-size:12px;">초 남음</span>',
            this.remainingTimeUnitLabel, this.rightMargin, 14, this.fontFamily));
        $('#' + this.progressPanel).append(this.utils.stringFormat('<span id="{0}" ' +
            'style="display:inline-block;float:right;text-align:right;margin-right:{1}px;margin-top:{2}px;color:#037bc1;' +
            'font-weight:bold;font-size:12px;">0</span>',
            this.remainingTimeLabel, 2, 14));
        var progressBarWidth = this.width - (this.leftMargin + this.rightMargin);
        $('#' + this.progressPanel).append(this.utils.stringFormat('<div><progress id="{0}" max="100" value="0" ' +
            'style="width:{1}px;height:{2}px;margin-left:{3}px;color:#4072CB;background-color:#B5B5B5;border:none;"></progress></div>',
            this.progressBar, progressBarWidth, this.progressBarHeight, this.leftMargin));

        // DataGrid
        var dataGridWidth = progressBarWidth; 
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;margin-left:{3}px;background:#FFFFFF;"></div>',
            this.monitorDataGrid, dataGridWidth, this.dataGridHeight, this.leftMargin));

        var gridWidth = this.width - (this.leftMargin + this.rightMargin);
        var fieldWidth = 100;
        var grid;
        var columns = [
          { id: "title", name: "파일이름", field: "title", width: gridWidth - (fieldWidth * 2) },
          { id: "size", name: "크기", field: "size", width: fieldWidth },
          { id: "status", name: "상태", field: "status", width: fieldWidth }
        ];

        var options = {
            enableCellNavigation: true,
            enableColumnReorder: false,
            editable: true,
            enableCellNavigation: true,
            forceFitColumns: true,
            autoEdit: false
        };

        var data = [];
        namoCrossUploader.fileUploadMonitor.dataGrid = new Slick.Grid("#" + namoCrossUploader.fileUploadMonitor.monitorDataGrid, data, columns, options);
        namoCrossUploader.fileUploadMonitor.dataGrid.setSelectionModel(new Slick.RowSelectionModel({ selectActiveRow: true }));
        //$(function () {
        //});

        // Button panel
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;"></div>',
            this.buttonPanel, this.width, this.buttonPanelHeight));
        $('#' + this.buttonPanel).append(this.utils.stringFormat('<input type="checkbox" id="{0}" checked="checked" ' +
            'style="margin-left:{1}px;margin-top:0;"></checkbox>',
            this.closeCheckBox, this.leftMargin, 24));
        $('#' + this.buttonPanel).append(this.utils.stringFormat('<span style="display:inline-block;margin-left:{0}px;margin-top:22px;' +
            'font-size:12px;">전송이 완료되면 창을 종료합니다.</span>',
            2, 0, this.fontFamily));
        $('#' + this.buttonPanel).append(this.utils.stringFormat('<input type="button" id="{0}" value="닫기"' +
                   'style="margin-right:{1}px;margin-top:{2}px;" class="button bt2 fr" />',
                   this.closeButton, this.rightMargin, 15, this.fontFamily));
        $('#' + this.buttonPanel).append(this.utils.stringFormat('<input type="button" id="{0}" value="전송"' +
                       'style="margin-right:{1}px;margin-top:{2}px;" class="button bt2 fr"/>',
                       this.transferButton, this.defaultMargin, 15, this.fontFamily));
    };

    this.addFiles = function (fileInfoList) {
        for (var i = 0; i < fileInfoList.length; i++) {
            var fileInfo = fileInfoList[i];
            var statusLabel = "";
            if (fileInfo.status == "COMPLETION")
                statusLabel = "완료";
            else if (fileInfo.status == "CANCELLATION")
                statusLabel = "취소";
            else if (fileInfo.status == "FAILURE") {
                statusLabel = "실패";
            }
            else if (fileInfo.status == "TRANSFER")
                statusLabel = this.utils.convertByteUnit(fileInfo.transferedSize);
            else
                statusLabel = "대기";

            var datas = this.dataGrid.getData();
            datas.splice(datas.length, 0, {
                "title": fileInfo.fileName,
                "size": this.utils.convertByteUnit(fileInfo.fileSize),
                "status": statusLabel
            });
            this.dataGrid.invalidateRow(datas.length);
            this.dataGrid.updateRowCount();
            this.dataGrid.render();
            this.dataGrid.scrollRowIntoView(datas.length - 1)
        }
    };


    this.open = function () {
        $('#' + this.backgroundPanel).css('display', 'block');
        $('#' + this.mainPanel).css('display', 'block');
    };

    this.close = function () {


        $('#' + this.backgroundPanel).css('display', 'none');
        $('#' + this.mainPanel).css('display', 'none');
    };

    this.deleteAllGridFiles = function () {
        var grid = namoCrossUploader.fileUploadMonitor.dataGrid;
        var dataList = grid.getData();

        while (dataList.length > 0) {
            var currentRow = dataList.length - 1;
            dataList.splice(currentRow, 1);
            var r = currentRow;
            while (r < dataList.length) {
                grid.invalidateRow(r);
                r++;
            }
            grid.updateRowCount();
            grid.render();
            grid.scrollRowIntoView(currentRow - 1)
        }
    };

    this.clear = function () {
        // Title
        $('#' + this.titleLabel).text('파일 업로드');

        // Grid
        this.deleteAllGridFiles(); 

        // Total uploaded file size
        $('#' + this.totalUploadedFileSizeLabel).text('0.00B');
        $('#' + this.totalFileSizeLabel).text('/0.00B');

        // Upload speed
        $('#' + this.transferSpeedLabel).text('(0.00B/sec)');

        // Remaining time
        $('#' + this.remainingTimeLabel).text('0');

        // Percent
        $('#' + this.totalUploadedPercentLabel).text('0%');

        // 프로그래스바
        $('#' + this.progressBar).val(0);
    }

    this.setEventHandler = function () {
        $('#' + this.closeButton).bind("click", this.onClickCloseButton);
        $('#' + this.transferButton).bind("click", this.onClickTransferButton);
    };

    this.onClickTransferButton = function () {
        var manager = namoCrossUploader.fileUploadManager;
        var monitor = namoCrossUploader.fileUploadMonitor;

        var uploadStatus = manager.uploadStatus;

        if (uploadStatus == 'WAIT') {
            manager.startTime = new Date().getTime();
            manager.progressTimer = setInterval(manager.startProgressTimer, 500);

            manager.totalUploadedFileSize = 0;
            manager.setUploadStatus('TRANSFER');
            monitor.resetButtonStatus();
            manager.dispatchEvent(manager.onStartUpload);
            manager.sendFormData();
        }
        else if (uploadStatus == 'TRANSFER') {
            manager.fileInfoList[manager.currentUploadItemIndex].xmlHttpRequest.abort(); 
            clearInterval(manager.progressTimer);
            manager.updateProgressStatus('WAIT');
            manager.setUploadStatus('WAIT');
            monitor.resetButtonStatus();
            manager.dispatchEvent(manager.onCancelUploadItem, manager.currentUploadItemIndex);
        }
    };

    this.resetButtonStatus = function () {
        var uploadStatus = namoCrossUploader.fileUploadManager.uploadStatus;

        if (uploadStatus == 'WAIT') {
            $('#' + this.transferButton).prop('value', '전송');
            $('#' + this.closeButton).prop('value', '닫기');

            $('#' + this.transferButton).prop('disabled', false);
            $('#' + this.closeButton).prop('disabled', false);
        }
        else if (uploadStatus == 'TRANSFER') {
            $('#' + this.transferButton).prop('value', '취소');
            $('#' + this.closeButton).prop('value', '닫기');

            $('#' + this.transferButton).prop('disabled', false);
            $('#' + this.closeButton).prop('disabled', true);
        }
        else { // COMPLETION, FAILURE, CANCELLATION 
            $('#' + this.transferButton).prop('value', '전송');
            $('#' + this.closeButton).prop('value', '닫기');

            $('#' + this.transferButton).prop('disabled', true);
            $('#' + this.closeButton).prop('disabled', false);
        }
    };
    this.getCloseMonitorCheckBoxStatus = function () {
        return $('#' + this.closeCheckBox).prop('checked');
    };

    this.setCloseMonitorCheckBoxStatus = function (checked) {
        $('#' + this.closeCheckBox).prop('checked', checked);
    };

    this.onClickCloseButton = function () {
        clearInterval(namoCrossUploader.fileUploadManager.progressTimer);
        namoCrossUploader.fileUploadMonitor.close();
        namoCrossUploader.fileUploadManager.dispatchEvent(namoCrossUploader.fileUploadManager.onCloseMonitorWindow);
    };
};

var __MultipleFileDownloadManager = function () {
    this.utils = new __NamoCrossUploaderUtils();
    this.global = new __Global();
    this.containerId = "";

    this.mainPanel = this.utils.getGuid();

    this.downloadLink = this.utils.getGuid();
    this.topDummyPanel = this.utils.getGuid();
    this.managerDataGrid = this.utils.getGuid();

    this.statusPanel = this.utils.getGuid();
    this.statusLabel = this.utils.getGuid();

    this.buttonPanel = this.utils.getGuid();
    this.selectAllButton = this.utils.getGuid();
    this.downloadButton = this.utils.getGuid();

    this.width = 0;
    this.height = 0;
    this.buttonPanelHeight = 40;
    this.buttonWidth = 92;
    this.buttonHeight = 30;
    this.topDummyPanelHeight = 10;
    this.statusPanelHeight = 28;
    this.statusHeight = 20;
    this.statusLabelHeight = 20;

    this.defaultMargin = 4;
    this.leftMargin = 10;
    this.rightMargin = 10;
    this.topMargin = 5;

    this.fileInfoList = [];
    this.totalFileSize = 0;

    this.dataGrid;

    this.fontFamily = "Malgun Gothic";
    this.downloadUrl = '';

    this.create = function (properties) {

        this.setProperties(properties);
        this.createControls();
        this.setEventHandler(); 
        //this.setLastExceptionInfo('');
    };

    this.setProperties = function (properties) {
        var obj = jQuery.parseJSON(properties);
        this.width = obj.width;
        this.height = obj.height;
        this.containerId = obj.containerId;
        this.downloadUrl = obj.downloadUrl; 
    };

    this.resetProperties = function (properties) {
        var obj = jQuery.parseJSON(properties);

        if (obj.width != undefined) {
            this.width = obj.width;
            $('#' + this.mainPanel).css('width', obj.width + 'px');
        }
        if (obj.height != undefined) {
            this.height = obj.height;
            $('#' + this.mainPanel).css('height', obj.height + 'px');
        }
        if (obj.borderColor != undefined) {
            $('#' + this.mainPanel).css('border-color', obj.borderColor);
        }
        if (obj.bottomPanelDisplayStyle != undefined) {
            $('#' + this.buttonPanel).css('display', obj.bottomPanelDisplayStyle);
        }

        if (obj.downloadButtonDisplayStyle != undefined)
            obj.downloadButtonDisplayStyle == 'block' ? $('#' + this.downloadButton).show() : $('#' + this.downloadButton).hide();
        if (obj.downloadButtonDisabledStyle != undefined)
            $('#' + this.downloadButton).prop('disabled', obj.downloadButtonDisabledStyle);

        if (obj.downloadButtonDisplayStyle != undefined && obj.downloadButtonDisplayStyle == 'none')
            $('#' + this.buttonPanel).css('display', 'none');


        // 크기, 위치 변경
        $('#' + this.buttonPanel).css('width', this.width + 'px');

        var dataGridWidth = this.width - (this.leftMargin + this.rightMargin);
        var dataGridHeight = 0; 
        if ($('#' + this.buttonPanel).css('display') == 'block') {
            dataGridHeight = this.height - (this.topDummyPanelHeight + this.statusPanelHeight + this.buttonPanelHeight);
        }
        if ($('#' + this.buttonPanel).css('display') == 'none') {
            dataGridHeight = this.height - (this.topDummyPanelHeight + this.statusPanelHeight + (this.topMargin *2));
        }
        $('#' + this.managerDataGrid).css('width', dataGridWidth + 'px');
        $('#' + this.managerDataGrid).css('height', dataGridHeight + 'px');
        namoCrossUploader.multipleFileDownloadManager .dataGrid.width = dataGridWidth;
        namoCrossUploader.multipleFileDownloadManager.dataGrid.height = dataGridHeight;
        var columns = namoCrossUploader.multipleFileDownloadManager.dataGrid.getColumns();
        columns[1].width = dataGridWidth - 100;
        columns[2].width = 100;
        namoCrossUploader.multipleFileDownloadManager.dataGrid.setColumns(columns);

        $('#' + this.statusPanel).css('width', dataGridWidth + 'px');
    };

    this.createControls = function () {
        // Main panel
        $('#' + this.containerId).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;background:#EEEEEE;border:solid 1px #EEEEEE;"></div>',
            this.mainPanel, this.width, this.height));

        // Download a tag
        $('#' + this.mainPanel).append(this.utils.stringFormat('<a id="{0}" href="#" download="#" style="display:none;"></a>', this.downloadLink));

        // Top dummy panel
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;margin-left:{3}px;margin-top:{4}px;"></div>',
             this.topDummyPanel, this.width, this.topDummyPanelHeight, 0, 0));

        // DataGrid
        var dataGridWidth = this.width - (this.leftMargin + this.rightMargin);
        var dataGridHeight = this.height - (this.topDummyPanelHeight + this.statusPanelHeight + this.buttonPanelHeight); 
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;margin-left:{3}px;margin-top:{4}px;background:#FFFFFF;"></div>',
            this.managerDataGrid, dataGridWidth, dataGridHeight, this.leftMargin, 0));

        var gridWidth = this.width - (this.leftMargin + this.rightMargin);
        var fieldWidth = 100;
        var grid;

        var checkboxSelector = new Slick.CheckboxSelectColumn({
            cssClass: "slick-cell-checkboxsel"
        });

        var columns = [];
        columns.push(checkboxSelector.getColumnDefinition());
        columns.push({ id: "title", name: "파일이름", field: "title", width: gridWidth - fieldWidth});
        columns.push({ id: "size", name: "크기", field: "size", width: fieldWidth });

        var options = {
            enableCellNavigation: true,
            enableColumnReorder: false,
            editable: true,
            enableCellNavigation: true,
            forceFitColumns: true,
            autoEdit: false
        };

        var data = [];
        namoCrossUploader.multipleFileDownloadManager.dataGrid = new Slick.Grid("#" + namoCrossUploader.multipleFileDownloadManager.managerDataGrid, data, columns, options);
        namoCrossUploader.multipleFileDownloadManager.dataGrid.setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false}));
        namoCrossUploader.multipleFileDownloadManager.dataGrid.registerPlugin(checkboxSelector);

        //var columnpicker = new Slick.Controls.ColumnPicker(columns, grid, options);
        //$(function () {
        //});

        // Status panel
        var statusPanelWidth = dataGridWidth;
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;background-color:#737373;margin-left:{3}px;"></div>',
            this.statusPanel, statusPanelWidth, this.statusPanelHeight, this.leftMargin));
        $('#' + this.statusPanel).append(this.utils.stringFormat('<span id="{0}" ' +
            'style="height:{1}px;float:right;text-align:right;margin-right:{2}px;margin-top:{3}px;font-size:12px;color:white;">0개의 파일 : 0.00B</span>',
            this.statusLabel, this.statusLabelHeight, this.rightMargin, 6, this.fontFamily));

        // Button panel
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;"></div>',
            this.buttonPanel, this.width, this.buttonPanelHeight));
        /*
        $('#' + this.buttonPanel).append(this.utils.stringFormat('<input type="button" id="{0}" value="전체 선택" ' +
            'style="width:{1}px;height:{2}px;margin-left:{3}px;margin-top:{4}px;font-family:{5};font-size:12px; ' + 
            'background:#FFFFFF;border-style:solid;border-width:1px;border-color:#4072CB;"/>', 
            this.selectAllButton, this.buttonWidth, this.buttonHeight, this.leftMargin, 5, this.fontFamily));
            */ 
        $('#' + this.buttonPanel).append(this.utils.stringFormat('<input type="button" id="{0}" value="다운로드" ' + 
            'style="width:{1}px;height:{2}px;float:right;margin-right:{3}px;margin-top:{4}px; ' + 
            'font-size:12px;background:#FFFFFF;border-style:solid;border-width:1px;border-color:#4072CB;"/>',
            this.downloadButton, this.buttonWidth, this.buttonHeight, this.rightMargin, 5, this.fontFamily));
    };

    this.setEventHandler = function () {
        //$('#' + this.selectAllButton).bind("click", this.onClickSelectAllButton);
        $('#' + this.downloadButton).bind("click", this.onClickDownloadButton);
    };

    /*
    this.onClickSelectAllButton = function () {

    };
    */ 
    this.startDownload = function () {
        var fileInfoList = namoCrossUploader.multipleFileDownloadManager.fileInfoList;
        var downloadLink = namoCrossUploader.multipleFileDownloadManager.downloadLink;
        var utils = namoCrossUploader.multipleFileDownloadManager.utils;
        var dataGrid = namoCrossUploader.multipleFileDownloadManager.dataGrid;

        var selectedRows = dataGrid.getSelectedRows();

        var formData = '';
        var index = 0; 
        for (var i = 0; i < selectedRows.length; i++) {
            index = selectedRows[i];

            var obj = new Object();
            obj.fileId = fileInfoList[index].fileId;
            obj.fileName = fileInfoList[index].fileName;
            obj.fileSize = fileInfoList[index].fileSize;
            obj.fileUrl = fileInfoList[index].fileUrl;

            formData += (JSON.stringify(obj) + ',');
        }
        if (formData.length > 0) {
            formData = '[' + formData.substring(0, formData.length - 1) + ']';
        }

        var href = utils.stringFormat('{0}?CD_DOWNLOAD_FILE_INFO={1}', namoCrossUploader.multipleFileDownloadManager.downloadUrl, formData);
        $('#' + downloadLink).prop('href', href);
        if(selectedRows.length > 1)
            $('#' + downloadLink).prop('download', 'zipFileDownload');
        else
            $('#' + downloadLink).prop('download', fileInfoList[index].fileName);
        $('#' + downloadLink)[0].click();
    };

    this.onClickDownloadButton = function () {
        namoCrossUploader.multipleFileDownloadManager.startDownload(); 
    };

    this.addFile = function (fileInfo) {
    	var rLastPath = /\/(a-aA-Z0-9._]+)(?:\?.*)?$/;
        var obj = jQuery.parseJSON(fileInfo);
        var fileId = obj.fileId;
        var fileName = rLastPath.test(obj.fileName) && RegExp.$1;
        var fileSize = obj.fileSize;
        var fileUrl = obj.fileUrl;

        var fileInfo = new __DownloadFileInfo();
        fileInfo.fileId = obj.fileId;
        fileInfo.fileName = rLastPath.test(obj.fileName) && RegExp.$1;
        fileInfo.fileSize = parseInt(obj.fileSize);
        fileInfo.fileUrl = obj.fileUrl;
      
        this.fileInfoList.push(fileInfo);

        var dataGrid = this.dataGrid;
        var datas = dataGrid.getData();
        datas.splice(datas.length, 0, {
            'title': fileName,
            'size': this.utils.convertByteUnit(fileSize)
        });
        dataGrid.invalidateRow(datas.length);
        dataGrid.updateRowCount();
        dataGrid.render();
        dataGrid.scrollRowIntoView(datas.length - 1)

        this.totalFileSize += fileInfo.fileSize;

        this.updateStatus();
    }

    this.updateStatus = function () {
        var status = this.utils.stringFormat('{0}개의 파일 : {1}',
            this.fileInfoList.length,
            this.utils.convertByteUnit(this.totalFileSize));
        $('#' + this.statusLabel).text(status);
    }

    this.getTotalFileCount = function () {
        return this.dataGrid.getData().length;
    }

    this.getFileInfoAt = function (rowIndex) {
        if (this.fileInfoList.length < (rowIndex + 1))
            return '{}';

        return this.getFileInfoToJson(this.fileInfoList[rowIndex]);
    }

    this.getFileInfoToJson = function (fileInfo) {
        var keys = new Array('fileId', 'fileName', 'fileSize', 'fileUrl');
        var values = new Array(fileInfo.fileId, fileInfo.fileName, fileInfo.fileSize, fileInfo.fileUrl);
        return this.utils.getJsonString(keys, values);
    }
};

var __SingleFileDownloadManager = function () {
    this.utils = new __NamoCrossUploaderUtils();
    this.global = new __Global();
    this.containerId = "";

    this.mainPanel = this.utils.getGuid();

    this.downloadLink = this.utils.getGuid();
    this.topDummyPanel = this.utils.getGuid();
    this.managerDataGrid = this.utils.getGuid();

    this.statusPanel = this.utils.getGuid();
    this.statusLabel = this.utils.getGuid();

    this.buttonPanel = this.utils.getGuid();
    this.selectAllButton = this.utils.getGuid();
    this.downloadButton = this.utils.getGuid();

    this.width = 0;
    this.height = 0;
    //this.buttonWidth = 92;
    //this.buttonHeight = 30;
    this.topDummyPanelHeight = 10;
    this.statusPanelHeight = 28;
    this.statusHeight = 20;
    this.statusLabelHeight = 20;

    this.defaultMargin = 4;
    this.leftMargin = 10;
    this.rightMargin = 10;
    this.topMargin = 5;

    this.fileInfoList = [];
    this.totalFileSize = 0;

    this.dataGrid;

    this.fontFamily = "Malgun Gothic";
    this.downloadUrl = '';

    this.create = function (properties) {

        this.setProperties(properties);
        this.createControls();
        this.setEventHandler();
        //this.setLastExceptionInfo('');
    };

    this.setProperties = function (properties) {
        var obj = jQuery.parseJSON(properties);
        this.width = obj.width;
        this.height = obj.height;
        this.containerId = obj.containerId;
        this.downloadUrl = obj.downloadUrl;
    };


    this.resetProperties = function (properties) {
        var obj = jQuery.parseJSON(properties);

        if (obj.width != undefined) {
            this.width = obj.width;
            $('#' + this.mainPanel).css('width', obj.width + 'px');
        }
        if (obj.height != undefined) {
            this.height = obj.height;
            $('#' + this.mainPanel).css('height', obj.height + 'px');
        }
        if (obj.borderColor != undefined) {
            $('#' + this.mainPanel).css('border-color', obj.borderColor);
        }

        // 크기, 위치 변경
        var dataGridWidth = this.width - (this.leftMargin + this.rightMargin);
        var dataGridHeight = this.height - (this.topDummyPanelHeight + this.statusPanelHeight + (this.topMargin * 2));
        $('#' + this.managerDataGrid).css('width', dataGridWidth + 'px');
        $('#' + this.managerDataGrid).css('height', dataGridHeight + 'px');
        namoCrossUploader.singleFileDownloadManager.dataGrid.width = dataGridWidth;
        namoCrossUploader.singleFileDownloadManager.dataGrid.height = dataGridHeight;
        var columns = namoCrossUploader.singleFileDownloadManager.dataGrid.getColumns();
        columns[0].width = dataGridWidth - 200;
        columns[1].width = 100;
        columns[2].width = 100;
        namoCrossUploader.singleFileDownloadManager.dataGrid.setColumns(columns);

        $('#' + this.statusPanel).css('width', dataGridWidth + 'px');
    };

    this.createControls = function () {
        // Main panel
        $('#' + this.containerId).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;background:#EEEEEE;border:solid 1px #EEEEEE;"></div>',
            this.mainPanel, this.width, this.height));

        // Download a tag
        $('#' + this.mainPanel).append(this.utils.stringFormat('<a id="{0}" href="#" download="#" style="display:none;"></a>', this.downloadLink));

        // Top dummy panel
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;margin-left:{3}px;margin-top:{4}px;"></div>',
             this.topDummyPanel, this.width, this.topDummyPanelHeight, 0, 0));

        // DataGrid
        var dataGridWidth = this.width - (this.leftMargin + this.rightMargin);
        var dataGridHeight = this.height - (this.topDummyPanelHeight + this.statusPanelHeight + (this.topMargin * 2));
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;margin-left:{3}px;margin-top:{4}px;background:#FFFFFF;"></div>',
            this.managerDataGrid, dataGridWidth, dataGridHeight, this.leftMargin, 0));

        var gridWidth = this.width - (this.leftMargin + this.rightMargin);
        var fieldWidth = 100;
        var grid;

        var columns = [];
        columns.push({ id: "title", name: "파일이름", field: "title", width: gridWidth - (fieldWidth * 2)});
        columns.push({ id: "size", name: "크기", field: "size", width: fieldWidth });
        columns.push({ id: "downloadButton", name: "다운로드", field: "downloadButton", width: fieldWidth, formatter: Slick.Formatters.Link });

        var options = {
            enableCellNavigation: true,
            enableColumnReorder: false,
            editable: true,
            enableCellNavigation: true,
            forceFitColumns: true,
            autoEdit: false
        };

        var data = [];
        namoCrossUploader.singleFileDownloadManager.dataGrid = new Slick.Grid("#" + namoCrossUploader.singleFileDownloadManager.managerDataGrid, data, columns, options);
        namoCrossUploader.singleFileDownloadManager.dataGrid.setSelectionModel(new Slick.RowSelectionModel({ selectActiveRow: true }));

        //var columnpicker = new Slick.Controls.ColumnPicker(columns, grid, options);
        //$(function () {
        //});

        // Status panel
        var statusPanelWidth = dataGridWidth;
        $('#' + this.mainPanel).append(this.utils.stringFormat('<div id="{0}" style="width:{1}px;height:{2}px;background-color:#737373;margin-left:{3}px;"></div>',
            this.statusPanel, statusPanelWidth, this.statusPanelHeight, this.leftMargin));
        $('#' + this.statusPanel).append(this.utils.stringFormat('<span id="{0}" ' +
            'style="height:{1}px;float:right;text-align:right;margin-right:{2}px;margin-top:{3}px;font-size:12px;color:white;">0개의 파일 : 0.00B</span>',
            this.statusLabel, this.statusLabelHeight, this.rightMargin, 6, this.fontFamily));
    };

    this.setEventHandler = function () {
        //$('#' + this.selectAllButton).bind("click", this.onClickSelectAllButton);
        //$('#' + this.downloadButton).bind("click", this.onClickDownloadButton);
    };

    /*
    this.onClickSelectAllButton = function () {

    };
    */

    this.onClickDownloadButton = function (id, rowId) {
        var fileInfoList = namoCrossUploader.singleFileDownloadManager.fileInfoList;
        var downloadLink = namoCrossUploader.singleFileDownloadManager.downloadLink;
        var utils = namoCrossUploader.singleFileDownloadManager.utils;
        var dataGrid = namoCrossUploader.singleFileDownloadManager.dataGrid;

        if (rowId < 0 || rowId >= dataGrid.length)
            return; 

        var obj = new Object();
        obj.fileId = fileInfoList[rowId].fileId;
        obj.fileName = fileInfoList[rowId].fileName;
        obj.fileSize = fileInfoList[rowId].fileSize;
        obj.fileUrl = fileInfoList[rowId].fileUrl;

        var formData = JSON.stringify(obj); 

        var href = utils.stringFormat('{0}?CD_DOWNLOAD_FILE_INFO={1}', fileInfoList[rowId].fileUrl, formData);
        alert(href);
        $('#' + downloadLink).prop('href', href);
        $('#' + downloadLink).prop('download', fileInfoList[rowId].fileName);
        $('#' + downloadLink)[0].click();
    };

    this.addFile = function (fileInfo) {
        var obj = jQuery.parseJSON(fileInfo);
        var fileId = obj.fileId;
        var fileName = obj.fileName;
        var fileSize = obj.fileSize;
        var fileUrl = obj.fileUrl;

        var fileInfo = new __DownloadFileInfo();
        fileInfo.fileId = obj.fileId;
        fileInfo.fileName = obj.fileName;
        fileInfo.fileSize = parseInt(obj.fileSize);
        fileInfo.fileUrl = obj.fileUrl;

        this.fileInfoList.push(fileInfo);

        var dataGrid = this.dataGrid;
        var datas = dataGrid.getData();
        datas.splice(datas.length, 0, {
            'title': fileName,
            'size': this.utils.convertByteUnit(fileSize)
        });
        dataGrid.invalidateRow(datas.length);
        dataGrid.updateRowCount();
        dataGrid.render();
        dataGrid.scrollRowIntoView(datas.length - 1)

        this.totalFileSize += fileInfo.fileSize;

        this.updateStatus();
    }

    this.updateStatus = function () {
        var status = this.utils.stringFormat('{0}개의 파일 : {1}',
            this.fileInfoList.length,
            this.utils.convertByteUnit(this.totalFileSize));
        $('#' + this.statusLabel).text(status);
    }

    this.getTotalFileCount = function () {
        return this.dataGrid.getData().length;
    }

    this.getFileInfoAt = function (rowIndex) {
        if (this.fileInfoList.length < (rowIndex + 1))
            return '{}';

        return this.getFileInfoToJson(this.fileInfoList[rowIndex]);
    }

    this.getFileInfoToJson = function (fileInfo) {
        var keys = new Array('fileId', 'fileName', 'fileSize', 'fileUrl');
        var values = new Array(fileInfo.fileId, fileInfo.fileName, fileInfo.fileSize, fileInfo.fileUrl);
        return this.utils.getJsonString(keys, values);
    }
};


var __NamoCrossUploader = function () {
    this.fileUploadManager = null; 
    this.fileUploadMonitor = null;

    this.multipleFileDownloadManager = null; 
    this.singleFileDownloadManager = null; 

    this.createUploader = function (managerProperties, monitorProperties, eventNames) {
        this.fileUploadManager = new __FileUploadManager();
        this.fileUploadMonitor = new __FileUploadMonitor();

        this.fileUploadManager.create(managerProperties, eventNames);
        this.fileUploadMonitor.create(monitorProperties);

        return this.fileUploadManager;
    };

    this.createDownloader = function (managerProperties) {
        var obj = jQuery.parseJSON(managerProperties);
        if (obj.uiMode == undefined || obj.uiMode == 'MULTIPLE') {
            this.multipleFileDownloadManager = new __MultipleFileDownloadManager();
            this.multipleFileDownloadManager.create(managerProperties);
            return this.multipleFileDownloadManager;
        }
        else {
            this.singleFileDownloadManager = new __SingleFileDownloadManager();
            this.singleFileDownloadManager.create(managerProperties);
            return this.singleFileDownloadManager;
        }
    };

    this.setUploaderProperties = function (managerProperties, monitorProperties) {
        this.fileUploadManager.resetProperties(managerProperties);
        this.fileUploadMonitor.resetProperties(monitorProperties);
    }

    this.setDownloaderProperties = function (managerProperties) {
        var obj = jQuery.parseJSON(managerProperties);
        if (obj.uiMode == undefined || obj.uiMode == 'MULTIPLE') {
            this.multipleFileDownloadManager.resetProperties(managerProperties);
        }
        else {
            this.singleFileDownloadManager.resetProperties(managerProperties);
        }
    };
};

// NamoCrossUploader 전역 객체
var namoCrossUploader = new __NamoCrossUploader(); 