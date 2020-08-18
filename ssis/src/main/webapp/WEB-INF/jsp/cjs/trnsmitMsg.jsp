<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<title>관제업무지원 시스템 &#124; 마이페이지 &#124; 업무 협업</title>

<script>
var pUrl, pParam;
var attachmentUserArray	= [];
var attachmentFileArray	= [];
var tmpFileArray	    = [];

$(document).ready(function(){
	$("#label1").change(function(){
		changeInsttList(this.value);
	});

	$("#label2").change(function(){
		changeUserList('', this.value);
	});

	if(attachmentUserArray.length == 0) {
		$("#user_list").hide();
	};

});

function changeInsttList(instt_cl_cd){

	pUrl = "/cjs/msgInsttListAjax.do";
	pParam = {};
	pParam.instt_cl_cd = instt_cl_cd;

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		var str = '<option value="">기관명 전체</option>';
		for(var i in data.resultList){
			str += '<option value=' + data.resultList[i].INSTT_CD + '>' + data.resultList[i].INSTT_NM + '</option>'; 	
		}
		$("#label2").html(str);
	}, function(jqXHR, textStatus, errorThrown){
		
	});
	changeUserList(instt_cl_cd,'');
}

function changeUserList(instt_cl_cd, instt_cd){

	pUrl = "/cjs/msgUserListAjax.do";
	pParam = {};
	pParam.instt_cl_cd = instt_cl_cd;
	pParam.instt_cd    = instt_cd;

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		var str = '<option value="">담당자 전체</option>';
		for(var i in data.resultList){
			str += '<option value=' + data.resultList[i].USER_ID + '>' + data.resultList[i].USER_NM + '/' + data.resultList[i].INSTT_NM +'</option>'; 	
		}
		$("#label3").html(str);
	}, function(jqXHR, textStatus, errorThrown){
		
	});
	
}

function attachmentUser(delYn){
    var str = $("#user_list").html();

    var chkDup =0;
    
    if($("#label3").val() =="") {
    	$("#label3>option").each( function() {
    		if($(this).val() != ""){
	    		chkDup =0;
	    		for(var i in attachmentUserArray){
	    			if(attachmentUserArray[i] == $(this).val() ){
	    				chkDup++;
	    			}
	    		}   		
	    	    if(chkDup == 0){
	    			str +='<li id=' + $(this).val() + '><span>' + $(this).text() + '</span><button type="button" class="btn_del" onclick="delUser(this); return false"> 삭제</button></li>'
	    			attachmentUserArray.push($(this).val());
	    	    }  
    		}
    	});    	
    } else {
		for(var i in attachmentUserArray){
			if(attachmentUserArray[i] == $("#label3").val() ){
				chkDup++;
			}
		}
		
	    if(chkDup == 0){
	    	if(delYn == "N") {
				str +='<li id=' + $("#label3").val() + '><span>' + $("#label3>option:selected").text() + '</span></li>'
	    	} else {
				str +='<li id=' + $("#label3").val() + '><span>' + $("#label3>option:selected").text() + '</span><button type="button" class="btn_del" onclick="delUser(this); return false"> 삭제</button></li>'
	    	}
			attachmentUserArray.push($("#label3").val());
	    }
    }
	$("#user_list").html(str);
	//alert(attachmentUserArray);
	if(attachmentUserArray.length > 0) {
		$("#user_list").show();
	}	
}

function list_Thread(pageNo) {
	document.form.pageIndex.value = pageNo;
	if($("#userId").val() == "") {
		document.form.action = '/cjs/trnsmitMsgList.do';
	} else {
		document.form.action = '/cjs/receiveMsgList.do';
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
	if($("#contents").val() == "") {
		alert("내용을 입력해 주세요.");
		return;
	}
	
	pParam = {};
	pUrl = '/cjs/insertTrnsmitMsg.do';
	
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
// 	$("#user_list>li>#btn_del").live("click",function(){
// 		$(this).parents().remove();
// 	})
	attachmentUserArray =[];
	jQuery(el).parents('li').remove();
	$("#user_list>li").each(function() {
		//alert($(this).attr("id"));
		attachmentUserArray.push($(this).attr("id"));
	});
	if(attachmentUserArray.length == 0) {
		$("#user_list").hide();
	}	
}
function fnCheckAttachmentMsgFile() {
	$( "input[name=chkAttachmentFile_msg]" ).prop( "checked", $( "#chkAttachmentFile_msg").prop( "checked" ) );
}  

function fnAddAttachmentFile() {
    //    
    var url			= "/crossUploader/fileUploadPopUp.do";
    var varParam	= "";
    var openParam	= "height=445px, width=500px";

	var attachmentFile = window.open( "", "attachmentFile", openParam );
    attachmentFile.location.href = url;

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
	html += '<div class="option">';
	html += '    <ul class="file_list">';

	$.each( attachmentFileArray, function( key, value ) {
		html += '';
		html += '<li>';
		html += '<input type="checkbox" id='+ value.fileId + ' name="chkAttachmentFile_msg"/>';
		html += '<label for='+ value.fileId +  '>' + value.fileName  +'</label>';;
		html += '</li>';
	});

	html += '</ul>';
	html += '<div class="file_control">';
	html += ' <input type="checkbox" id="chkAttachmentFile_msg" value="" onClick="javascript:fnCheckAttachmentMsgFile();">';
	html += '<label for="chkAttachmentFile_msg">전체선택</label>';
	html += '<div class="control">';
	html += '<button type="button" value="파일삭제" class="button bt2 small red_l" onClick="javascript:fnDeleteAttachmentFile(); return false;">파일삭제</button>';
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
		
		var pUrl = "/cjs/deleteMsgFile.do";
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
</head>

<form action="/cjs/trnsmitMsg.do" method="post" id="form" name="form">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<input type="hidden" id="userId"    name="userId"    value="${requestZvl.userId}">
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
	<!-- content -->
    <div id="container">
        <div class="content_wrap">
            <h2 class="h2">업무 송신</h2>
            <div class="content">
                <fieldset>
                    <legend>업무 글쓰기</legend>            
                    <div class="content">
                        <table class="write" summary="제목, 받는사람, 내용, 파일첨부로 구성된 업무 글쓰기입니다.">
                        	<caption>업무 글쓰기</caption>
                            <colgroup>
                                <col style="width:15%;">
                                <col style="width:*;">                        
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">
                                        <label for="subject">제목</label>
                                    </th>
                                    <td colspan="3">
                                        <input type="text" id="subject" name="subject" class="w100" value="${requestZvl.subject }"  maxLength="50">
                                    </td>
                                </tr>                        
                                <tr>
                                    <th scope="row">받는사람</th>
                                    <td colspan="3">
                                        <label for="label1" class="hidden">기관구분 선책</label>
				                        <select name="instt_cl_cd" id="label1" title="기관구분 선택" <c:if test="${requestZvl.instt_cl_cd ne '' }">disabled</c:if>>
				                            <option value="">기관구분 전체</option>
				                            <c:forEach var="i" items="${msgInsttClCdList }" varStatus="status">
					                            <c:choose>
					                       			<c:when test="${i.INSTT_CL_CD == requestZvl.instt_cl_cd  }">
					                       				<option value="${i.INSTT_CL_CD }" selected>${i.INSTT_CL_NM }</option>	
					                       			</c:when>
					                       			<c:otherwise>
					                       				<option value="${i.INSTT_CL_CD }">${i.INSTT_CL_NM }</option>
					                       			</c:otherwise>	
					                        	</c:choose>
				                        	</c:forEach>
				                        </select>
                                        <label for="label2" class="hidden">기관 선택</label>
				                        <select name="instt_nm" id="label2" title="기관명 선택" style="width:300px;" <c:if test="${requestZvl.instt_nm ne '' }">disabled</c:if>>
				                        	<option value="">기관명 전체</option>
				                        	<c:forEach var="i" items="${msgInsttSelectList }" varStatus="status">
				                        	 	<c:choose>
					                       			<c:when test="${i.INSTT_CD == requestZvl.instt_nm  }">
					                       				<option value="${i.INSTT_CD }" selected>${i.INSTT_NM }</option>	
					                       			</c:when>
					                       			<c:otherwise>
					                       				<option value="${i.INSTT_CD }">${i.INSTT_NM }</option>
					                       			</c:otherwise>	
					                        	</c:choose>
				                        	</c:forEach>
				                        </select>
                                        <label for="label3" class="hidden">담당자 선택</label>
 				                        <select name="user_nm" id="label3" title="담당자 선택" style="width:300px;" <c:if test="${requestZvl.trnsmitId ne '' }">disabled</c:if>>
				                        	<option value="">담당자 전체</option>
				                        	<c:forEach var="i" items="${msgInsttUserList }" varStatus="status">
				                        	 	<c:choose>
					                       			<c:when test="${i.USER_ID == requestZvl.trnsmitId  }">
					                       				<option value="${i.USER_ID }" selected>${i.USER_NM }/${i.INSTT_NM}</option>	
					                       			</c:when>
					                       			<c:otherwise>
					                       				<option value="${i.USER_ID }">${i.USER_NM }/${i.INSTT_NM}</option>
					                       			</c:otherwise>	
					                        	</c:choose>
				                        	</c:forEach>
				                        </select>				                        
                                        <a href="#" class="button bt2" onclick="attachmentUser('Y'); return false;"  >추가</a>
                                        <!-- 받는 사람 목록 -->
                                        <ul class="recipient" id="user_list">
                                        </ul>
                                        <!-- /받는 사람 목록 -->
                                    </td>                            
                                </tr>
                                <c:if test="${requestZvl.trnsmitId ne '' }"><script>attachmentUser('N');</script></c:if>
                                <tr>
                                    <th scope="row">
                                        <label for="contents">내용</label>
                                    </th>
                                    <td colspan="3">
                                        <textarea id="contents" name="contents" class="w100 h300" title="내용을 입력하세요."  maxLength="1000">${requestZvl.contents}</textarea>
                                    </td>
                                </tr> 
                                <c:if test="${sessionScope.userInfo.authorId == '1' || sessionScope.userInfo.authorId == '3' }">
	                                <tr>
	                                    <th rowspan="2"  scope="row">파일첨부</th>
	                                    <td colspan="3" class="option_area">
											<button type="button" value="파일첨부" class="button bt2 small" onclick="fnAddAttachmentFile(); return false;">파일첨부</button>
	                                    </td>
	                                </tr>
	                                <tr id="file_list"></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                    <div class="tc mt50">
                        <a href="#" class="button bt1" onclick="done(); return false;">보내기</a>
                        <a href="#" class="button bt1 gray" onClick="javascript:list_Thread(1)">취소</a>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
    <!-- /content -->
</form>