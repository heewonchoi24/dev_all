<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="/smarteditor2-2.10.0/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<style>.icheckbox_square + label { width: auto; text-decoration: underline; color: #0d6090; font-size: 14px; margin-left: 5px; } .icheckbox_square .ickjs { position: absolute; opacity: 0; } td.option_area { padding-left: 60px !important; } .ta-l.pd2.td_log { border-top: 1px solid #dcdbdb; margin-top: 10px; padding-top: 10px; } </style>
<script>
var pUrl, pParam;
var attachmentUserArray	= [];
var attachmentFileArray	= [];
var tmpFileArray	    = [];

$(document).ready(function(){
	$('.ickjs').iCheck({
		checkboxClass: 'icheckbox_square',
		radioClass: 'iradio_square'
	});

	// 검색 옵션 선택 시
	$(document).on("click","#selectMenu1st>li>a",function(e){
		e.preventDefault();
		$("#instt_cl_cd").val(this.dataset.clcd);
		changeSecSearchMenu(this.dataset.clcd);
		changeUserList(this.dataset.clcd, '');
	});
	
	$(document).on("click","#selectMenu2nd>li>a",function(e){
		e.preventDefault();
		$("#instt_cd").val(this.dataset.cd);
		$(this).parents(".box-select-ty1").find(".selectVal a").text($(this).text());
		changeUserList($("#instt_cl_cd").val(), this.dataset.cd);
	});
	
 	// 담당자 눌렀을 때
	$(document).on("click","#selectMenu3rd>li>a",function(e){
		e.preventDefault();
		$("#transmit_id").val(this.dataset.cd);
		$("#transmit_nm").val(this.dataset.nm);
		$(this).parents(".box-select-ty1").find(".selectVal a").text($(this).text());
	})
	.on("click", ".icheckbox_square .iCheck-helper", function(){
		if($(this).hasClass("allChk")) {
			if($( "#chkAttachmentFile_msg").prop("checked") == true) $("#chkAttachmentFile_msg").prop("checked", false);
			else $("#chkAttachmentFile_msg").prop("checked", true);
			fnCheckAttachmentMsgFile();
		}else{
			var idx = $(this).attr("idx");
			if($( ".ickjs[id="+idx+"]").prop("checked") == true) $( ".ickjs[id="+idx+"]").prop("checked", false);
			else $( ".ickjs[id="+idx+"]").prop("checked", true);
			$(".icheckbox_square[idx="+ idx +"]").toggleClass("checked")
		}
	})
	
	if(attachmentUserArray.length == 0) {
		$("#list_data2").hide();
	};
});

function changeChkBox(val){
	$(".icheckbox_square[idx="+ val+"]").toggleClass("checked")
}
function fnCheckAttachmentMsgFile() {
	$( "input[name=chkAttachmentFile_msg]" ).prop( "checked", $( "#chkAttachmentFile_msg").prop( "checked" ) );
	if($( "#chkAttachmentFile_msg").prop("checked") == true) $(".icheckbox_square").addClass("checked");
	else $(".icheckbox_square").removeClass("checked");
}  

function changeSecSearchMenu(instt_cl_cd){
	
	pUrl = "/msg/msgInsttListAjax.do";
	pParam = {};
	pParam.instt_cl_cd = instt_cl_cd;

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		var str = '';
		for(var i in data.resultList){
			str += '<li><a href="#" data-cd="' + data.resultList[i].INSTT_CD + '" data-nm="' + data.resultList[i].INSTT_NM + '">' + data.resultList[i].INSTT_NM + '</a></li>'; 	
		}
		$("#selectMenu2nd").html(str);
		
	}, function(jqXHR, textStatus, errorThrown){
		
	});

}

function changeUserList(instt_cl_cd, instt_cd){

	pUrl = "/msg/msgUserListAjax.do";
	pParam = {};
	pParam.instt_cl_cd = instt_cl_cd;
	pParam.instt_cd    = instt_cd;

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		var str = '';
		for(var i in data.resultList){
			str += '<li><a href="#" data-cd="' + data.resultList[i].USER_ID + '" data-nm="' + data.resultList[i].USER_NM + '">' + data.resultList[i].USER_NM + '('+ data.resultList[i].USER_ID + ')'+ '/' + data.resultList[i].INSTT_NM +'</a></li>'; 	
		}
		$("#selectMenu3rd").html(str);
		
	}, function(jqXHR, textStatus, errorThrown){
		
	});
	
}

function attachmentUser(delYn){
    var str = $("#list_data2").html();
    var chkDup =0;
     
    if($("#transmit_id").val() =="") {
    	$("#selectMenu3rd>li>a").each( function() {
    		
    		if($(this).val() != ""){
    			
	    		chkDup =0;
	    		for(var i in attachmentUserArray){
	    			if(attachmentUserArray[i] == $(this).val() ){
	    				chkDup++;
	    			}
	    		}   		
	    	    if(chkDup == 0){
	    			str +='<div class="col" id="' + $(this).val() +'"><span class="box">'+ $(this).text() + '<button class="close" onclick="delUser(this); return false"></button></span></div>'
	    			attachmentUserArray.push($(this).val());
	    	    }  
    		}
    	});    	
    } else {
    	
		for(var i in attachmentUserArray){
			if(attachmentUserArray[i] == $("#transmit_id").val() ){
				chkDup++;
			}
		}
		
	    if(chkDup == 0){
			str +='<div class="col" id="' + $("#transmit_id").val() + '"><span class="box">' + $("#transmit_nm").val() + '<button type="button" class="close" onclick="delUser(this); return false"></span></button>'
			
			attachmentUserArray.push($("#transmit_id").val());
	    }
    }
    $("#list_data2").html(str);
	if(attachmentUserArray.length > 0) {
		$("#list_data2").show();
	}
	
	initializeSelectBox();

}

// 기관 담당자 select box 초기화
function initializeSelectBox(){
	$(".box-select-ty1.type1.1st div a").text("기관구분 전체");
    $(".box-select-ty1.type1.2nd div a").text("기관명 전체");
    $(".box-select-ty1.type1.3rd div a").text("담당자 전체");
    
    changeSecSearchMenu('');
    changeUserList('','');
}

function list_Thread(pageNo) {
	document.form.pageIndex.value = pageNo;
	if($("#userId").val() == "") {
		document.form.action = '/msg/trnsmitMsgList.do';
	} else {
		document.form.action = '/msg/receiveMsgList.do';
	}
	document.form.submit();
}

function done() {
	if($("#subject").val() == "") {
		alert("제목을 입력해 주세요.");
		return;
	}
	if(attachmentUserArray.length == 0) {
		alert("받는사람을 선택해 주세요.");
		return;
	}
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	var conVal = $("#contents").val().replace(/<p>|<\/p>|<br>|\s|&nbsp;/gi, "");
	if(conVal == null || conVal == ''){
		alert("내용은 필수입력 사항입니다."); 
		oEditors.getById["contents"].exec("FOCUS");
		return;
	}
	
	pParam = {};
	pUrl = '/msg/insertTrnsmitMsg.do';
	
	pParam.user_list = attachmentUserArray;
	pParam.subject = $("#subject").val();
	pParam.contents = $("#contents").val();
	
	pParam.uploadedFilesInfo = JSON.stringify(attachmentFileArray);
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		alert(data.message);
	}, function(jqXHR, textStatus, errorThrown){
			
	});
	
	$("#userId").val("");
	list_Thread(1);
}

function delUser(el){

	attachmentUserArray =[];
	jQuery(el).closest('div').remove();
	$("#list_data2>div").each(function() {
		attachmentUserArray.push($(this).attr("id"));
	});
	
	if(attachmentUserArray.length == 0) {
		$("#list_data2").hide();
	}
}

function fnAddAttachmentFile() {
    var url			= "/crossUploader/fileUploadPopUp.do";
    var varParam	= "";
    var openParam	= "height=445px, width=500px";

	var attachmentFile = window.open( "", "attachmentFile", openParam );
    attachmentFile.location.href = url;

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

	fnAttachmentFileList();
}

function fnAttachmentFileList() {
	var html = '';
	if(attachmentFileArray.length ==0) {
		$("#file_list").html(html);
		return;
	}
	html += '<td  colspan="3" class="option_area" >';
	html += '<div class="lst_answer">';

	$.each( attachmentFileArray, function( key, value ) {
		html += '<div class="file_list">';
		html += '<div class="icheckbox_square" style="position: relative;" idx="'+ value.fileId +'" >';
		html += '<input type="checkbox" class="ickjs" id='+ value.fileId + ' name="chkAttachmentFile_msg" onClick="javascript:changeChkBox('+"'"+value.fileId+"'"+');"/>';
		html += '<ins class="iCheck-helper" idx="'+ value.fileId +'" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>';
		html += '</div>';
		/* html += '<label for='+ value.fileId +  '>' + value.fileName  +'</label>'; */
		html += '<label for='+ value.fileId +  '>';
		html += '<a href="#" onClick="fnAttachmentMsgFileDown(\'' + value.fileId + '\'); return false;" class="f_' + value.fileExtension + '/>">'
		html += '<span class="i-aft i_' + value.fileExtension + ' link">' + value.fileName + '</span>'
		html += '</a>'
		html += '</label>';
		html += '</div>';
	});
	
	html += '<div class="ta-l pd2 td_log">';
	html += '<div class="icheckbox_square" style="position: relative;">';
	html += '<input type="checkbox" class="ickjs" id="chkAttachmentFile_msg" onClick="javascript:fnCheckAttachmentMsgFile();">';
	html += '<ins class="iCheck-helper allChk" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>';
	html += '</div>';
	html += '<label for="chkAttachmentFile_msg">전체선택</label>';
	html += '<div class="fl-r">';
	html += '<button type="button" value="파일삭제" style="margin-top: 3px; margin-right: 5px;" class="btn-pk ss black" onClick="javascript:fnDeleteAttachmentFile(); return false;">파일삭제</button>';
	html += '<a href="#download" class="btn-pk ss gray2 rv" style="margin-top: 3px;" id="downBtn" onClick="javascript:fnAttachmentMsgFileDown(\'\'); return false;"><span>다운로드</span></a>';
	html += '</div>';
	html += '</div>';
	html += '</div>';
	html += '</div>';
	html += '</td> ';
	
	$("#file_list").html(html);
}

function fnDeleteAttachmentFile() {
	var chkAttachmentFile = "";

	$( "input:checkbox[name=chkAttachmentFile_msg]" ).each( function() {
		if( $(this).prop( "checked" ) ) {
			chkAttachmentFile += "," + $(this).attr("id")  ;
		}
	});
	
	if( chkAttachmentFile == "" )
		return;
	
	if (confirm("삭제하시겠습니까?")) {
	    var p_fileId =  [];
	    var p_filePath =  [];
	    var p_cnt= 0;
	    var p_key =  [];

	 	$.each( attachmentFileArray, function( key, value ) {
 				if( chkAttachmentFile.indexOf( value.fileId  ) > 0 ) {
					p_fileId[p_cnt]		= value.fileId;
					p_filePath[p_cnt]	= value.lastSavedDirectoryPath + "/" + value.lastSavedFileName;
					p_key[p_cnt]        = key;
					p_cnt++;
				}
		});	

	 	tmpFileArray	= [];
		$.each( attachmentFileArray, function( key, value ) {
			var isDel = false;
			for(var i = 0 ; i  < p_key.length ; i++) {
				if( key == p_key[i] ) {
					isDel = true;
				}
			}
			if( isDel == false ) {
				tmpFileArray.push( value );
			}
		});
		attachmentFileArray = tmpFileArray;
		
		var pUrl = "/msg/deleteMsgFile.do";
 		var param = new Object();
		
 		param.fileId = p_fileId;
 		param.filePath = p_filePath;
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});
		
	}
	fnAttachmentFileList();
}
</script>

<form method="post" id="form"  name="form">
	<input type="hidden" id="pageIndex"  name="pageIndex"  value="${pageIndex}">
	<input type="hidden" id="userId"     name="userId"     value="${requestZvl.userId}">
	<input type="hidden" id="fileExt" name="fileExt" value="xlsx;jpg;gif;png;bmp;zip;">
	<input type="hidden" id="maxFileSize" name="maxFileSize" value="">
	<input type="hidden" id="maxTotFileSize" name="maxTotFileSize" value="">
	<input type="hidden" id="maxFileSize1" name="maxFileSize1" value="">
	<input type="hidden" id="maxTotFileSize1" name="maxTotFileSize1" value="">
	<input type="hidden" id="applyFlag" name="applyFlag" value="N"> 
	
	<!--  파일 업로드에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="" > 
	<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
	<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
	<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
	<!--  파일 업로드에 사용 -->
	
	<input type="hidden" id="instt_cd" name="instt_cd" value="${requestZvl.instt_cd }"/>
	<input type="hidden" id="instt_cl_cd" name="instt_cl_cd" value="${requestZvl.instt_cl_cd }"/>
	<input type="hidden" id="transmit_id" name="transmit_id" value="${requestZvl.transmit_id }"/>
	<input type="hidden" id="transmit_nm" name="transmit_nm" value="${requestZvl.transmit_nm }"/>
	
	
<section id="container" class="sub mypage">
	<!-- content -->
    <div id="container" class="container_inner">
        <h2 class="h_tit1">업무 송신</h2>
            <div class="wrap_table3">
			<table id="table-2" class="tbl" summary="제목, 받는사람, 내용, 파일첩부로 구성된 업무송신 글쓰기 입니다.">
				<caption>업무송신 정보 입력</caption>
				<colgroup>
					<col class="th1_1">
					<col>
				</colgroup>
				<tbody>
					<tr>
					    <th scope="col" id="th_a1">제목</th>
				        <td><input type="text" id="subject" name="subject" class="inp_txt w100p" value="${requestZvl.subject }" maxLength="50" title="제목 입력란"></td>
					</tr>                        
					<tr rowspan="2">
						<th scope="col" id="th_b2">받는사람</th>
						<td>
							
							<div class="box-select-ty1 type1 1st">
								<div class="selectVal" tabindex="0">
									<a href="#this" tabindex="-1" >
										<c:choose>
											<c:when test="${requestZvl.instt_cl_cd eq '' or requestZvl.instt_cl_cd eq null }">기관구분 전체</c:when>
											<c:otherwise>${requestZvl.instt_cl_nm }</c:otherwise>
										</c:choose>
									</a>
								</div>
								 <ul class="selectMenu" id="selectMenu1st">
									 <c:forEach var="i" items="${msgInsttClCdList }" varStatus="status">
										<li><a href="#" data-clcd="${i.INSTT_CL_CD }" data-clnm="${i.INSTT_CL_NM }">${i.INSTT_CL_NM }</a></li>
									 </c:forEach>
								 </ul>
							</div>
							
							<div class="box-select-ty1 type1 2nd">
								<div class="selectVal insttSelectVal" tabindex="0">
									<a href="#this" tabindex="-1">
										<c:choose>
											<c:when test="${requestZvl.instt_cd eq '' or requestZvl.instt_cd eq null }">기관명 전체</c:when>
											<c:otherwise>${requestZvl.instt_nm }</c:otherwise>
										</c:choose>
									</a>
								</div>
								 <ul class="selectMenu insttSelectMenu" id="selectMenu2nd">
									 <c:forEach var="i" items="${msgInsttSelectList }" varStatus="status">
										<li><a href="#" data-cd="${i.INSTT_CD }" data-nm="${i.INSTT_NM }">${i.INSTT_NM }</a></li>
									 </c:forEach>
								 </ul>
							</div>

							<div class="box-select-ty1 type1 3rd">
								<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1" style="min-width: 200px;">
									<c:choose>
										<c:when test="${requestZvl.transmit_nm eq '' or requestZvl.transmit_nm eq null }">담당자 전체</c:when>
										<c:otherwise>${requestZvl.transmit_nm }</c:otherwise>
									</c:choose>
									</a>
								</div>
								<ul class="selectMenu receiveSel" id="selectMenu3rd">
									<c:forEach var="i" items="${msgInsttUserList }" varStatus="status">
										<li><a href="#" data-cd="${i.USER_ID }" data-nm="${i.USER_NM }">${i.USER_NM }(${i.USER_ID })/${i.INSTT_NM}</a></li>
									</c:forEach>
								</ul>
							</div>
							
							<button type="button" class="btn-pk n black rv" onclick="attachmentUser('Y'); return false;">추가</button>
							
							<div class="lst_data2" id="list_data2">
								
							</div>

						</td>
					</tr>
					
					<c:if test="${requestZvl.trnsmitId ne '' }"><script>attachmentUser('N')</script></c:if>
					<tr>
						<th scope="col" id="th_c1">내용</th>
						<td headers="th_c1">
							<div class="editor_area_view">
								<textarea  id="contents" name="contents" rows="10"  style="width: 100%; height: auto;" maxlength="2000"  title="내용을 입력하세요." ></textarea>
							</div>
						</td>
					</tr>
					<c:if test="${sessionScope.userInfo.authorId == '1' || sessionScope.userInfo.authorId == '4' }">
						<tr>
							<th rowspan="2" scope="col" id="th_d1">파일첨부</th>
							<td headers="th_d1">
								<div class="inp_file">
									<button type="button" id="btn_${statusExaminInsttTotalEvl.INSTT_CD}"  class="inp_file_btn" onclick="fnAddAttachmentFile('${statusExaminInsttTotalEvl.INSTT_CD}','${statusExaminInsttTotalEvl.ATCHMNFL_ID}','attachmentFile'); return false;">파일찾기</button>
                                </div>
                            </td>
                        </tr>
	                    <tr id="file_list">
						</tr>
					</c:if>
				</tbody>
			</table>
			<div class="btn-bot noline">
				<a href="#" class="btn-pk b mem2 rv" onclick="done(); return false;">보내기</a>
				<a href="#" class="btn-pk b mem3 rv" onClick="javascript:list_Thread(1)">취소</a>
			</div>
	   	</div>
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
<script language="javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "contents",
	sSkinURI: "<c:url value='/smarteditor2-2.10.0/SmartEditor2Skin.html' />",
	fCreator: "createSEditor2"
});
</script>