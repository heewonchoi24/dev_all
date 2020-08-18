<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
var pUrl, pParam;
var attachmentFileArray	= [], attachmentFileDeleteArray = [];

$(document).ready(function(){
	$(function(){
        $('#allChk').change(function() {
            if($(this).prop('checked')){
                $('[id*="listChk_"]').prop('checked', true);
            }else{
                $('[id*="listChk_"]').prop('checked', false);
            }
        });
        $('[id*="listChk_"]').change(function() {
            if(!$(this).prop('checked')) 
            	$('#allChk').prop('checked', false);
        });
    });
});

function listThread(pageNo, cat) {
	if(cat){$("#category").val(cat);}
	$("#pageIndex").val(pageNo);
	$("#form").attr({
		method : "post"
	}).submit();
}

function searchList(){
	$("#pageIndex").val("1");
	document.form.submit();
}

function write(){
	document.form.action = "/admin/notice/noticeWrite.do";
	document.form.submit();
}


function modify(seq){
	$("#bbsSeq").val(seq);
	$("#isModify").val("Y");
	$("#form").attr({
		method : "post",
		action : "/admin/notice/noticeWrite.do"
	}).submit();
}

function deleteThread(){
	pParam = {};
	var arr = [];
	var delSeq = "";
	
	$("input[id*='listChk_']:checkbox").each(function(){
		$this = $(this);
		if($this.prop("checked")){
			arr.push($this.val().split(":")[0])	
			delSeq += $this.val().split(":")[0] +",";
		}
	})
	
	delSeq = delSeq.slice(0, -1);
	
	if(arr.legnth < 1){
		alert("미게시 할 글을 선택하시기 바랍니다.");
		return;
	}else{
		if(confirm("미게시 상태로 변경 하시겠습니까?")){
			pParam.delSeqArr = arr.join(",");
			pParam.bbsCd = $("#bbsCd").val();
			pParam.delSeq = delSeq;
			$.post("/admin/notice/deleteThread.do", pParam, function(data){ 
				alert(data.message);
				$("#form").submit();
			});				
		}
	}
}

function rollbackThread(){
	pParam = {};
	var delYn = '';
	var b = true;
	var arr = [];
	
	$("input[id*='listChk_']:checkbox").each(function(){
		$this = $(this);
		
		if($this.prop("checked")){
			delYn = $this.val().split(":")[1];
			arr.push($this.val().split(":")[0])		
		}
		if(delYn =='N'){
			b = false;
		}
	})
	
	if(arr.length < 1){
		alert("게시할 글을 선택하시기 바랍니다.");
		return;
	}else if(!b){
		alert("미게시 상태인 글만 복구가능합니다.");
		return;
	}else{
		if(confirm("게시 하시겠습니까?")){
			pParam.delSeqArr = arr.join(",");
			pParam.bbsCd = $("#bbsCd").val();
			$.post("/notice/rollbackThread.do", pParam, function(data){ 
				alert(data.message);
				$("#form").submit();
			});				
		}		
	}
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

function bbsTypeUpdate(){
	if (confirm("해당 게시판 타입을 변경 하시겠습니까?")) {
		var pUrl = "/admin/notice/typeUpdate.do";
 		var param = new Object();
 		
 		param.bbsType  = $("#bbsType").val();
 		param.bbsCd = $("#bbsCd").val();
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
 			alert(data.message);
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});
	}
}

</script>

<form action="/admin/notice/mngNoticeDtlList.do" method="post" id="form" name="form">

	<input type="hidden" name="bbsCd" id="bbsCd" value="${bbsCd }"/>
	<input type="hidden" name="bbsSeq" id="bbsSeq" value="${seq }"/>
	<input type="hidden" name="category" id="category" value="${category }"/>
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }"/>
	<input type="hidden" name="isModify" id="isModify" />
	
	<!-- content -->
	<div id="main">
		<div class="group">
			<div class="header">
				<h3>
					<c:if test="${bbsCd == 'BN01'}">공지사항</c:if>
					<c:if test="${bbsCd == 'BN02'}">자주하는 질문</c:if>
					<c:if test="${bbsCd == 'BN03'}">질의응답</c:if>
					<c:if test="${bbsCd == 'BN04'}">자료실</c:if>
					<c:if test="${bbsCd == 'BN05'}">개인정보 언론동향</c:if>
					<c:if test="${bbsCd == 'BN06'}">우수사례자료실</c:if>
				</h3>
			</div>
			<div class="body">
			<c:if test="${bbsCd != 'BN02' && bbsCd != 'BN03' && bbsCd != 'BN06'  }">
				<div class="board_list_type">
	                <label>게시판 스타일</label>
	                <div class="select_field">
	                    <select id="bbsType" name="boardType">
	                        <option value="T" data-img="/resources/admin/images/board/boardtype_1.png">텍스트형</option>
	                        <option value="G" data-img="/resources/admin/images/board/boardtype_2.png">타일형</option>
	                        <option value="I" data-img="/resources/admin/images/board/boardtype_3.png">이미지+텍스트형</option>
	                    </select>
	                </div>
	                <button type="button" class="btn blue" onclick="bbsTypeUpdate();">적용</button>
	            </div>
            </c:if>
				
		        <div class="board_list_top">
	                <div class="board_list_info">
		                <strong class="c_black" id="totalCount">${bbsTotalCnt }</strong>개,
						<span class="ml05">현재 페이지</span>
						<strong class="c_red">${pageIndex }</strong>/${totalPageCnt }
	                </div>
	                
	                <div class="board_list_search">
	                    <div class="ipt_group">
	                    	<div class="ipt_left">
		                    <select id="srchOptYn" name="srchOptYn" title="검색영역 선택"  class="ipt">
								<option value="">전체</option>
								<option value="N" <c:if test="${srchOptYn == 'N' }">selected</c:if>>게시</option>
								<option value="Y" <c:if test="${srchOptYn == 'Y' }">selected</c:if>>미게시</option>
							</select>
							</div>
	                        <input type="text" id="srchStr" name="srchStr" value="${srchStr}" class="ipt" placeholder="검색어를 입력하세요">
	                        <span class="ipt_right addon"><button type="submit" class="btn searhBtn" onclick="searchList();">검색</button></span>
	                    </div>
	                </div>
	            </div>
            
				<table class="board_list_normal" summary="전체선택, 번호, 제목, 첨부, 작성일, 조회수, 처리상황, 삭제여부로 구성된 게시판 리스트입니다.">
					
					<colgroup>
						<c:choose>
							<c:when test="${bbsCd == 'BN02' }">
								<c:set var="colSize" value="6"/>
								<col style="width:50px;">
								<col style="width:80px;">
								<col style="width:*">
								<col style="width:80px;">
								<col style="width:120px;">
								<col style="width:80px;">
							</c:when>
							<c:when test="${bbsCd == 'BN03' }">
								<c:set var="colSize" value="8"/>
								<col style="width:50px;">
								<col style="width:80px;">
								<col style="width:*">
								<col style="width:80px;">
								<col style="width:120px;">
								<col style="width:80px;">
								<col style="width:100px;">
								<col style="width:80px;">
							</c:when>
							<c:otherwise>
								<c:set var="colSize" value="7"/>
								<col style="width:50px;">
								<col style="width:80px;">
								<col style="width:*">
								<col style="width:80px;">
								<col style="width:120px;">
								<col style="width:100px;">
								<col style="width:80px;">
							</c:otherwise>
						</c:choose>
					</colgroup>
					
					<thead>
						<tr>
							<th>
	                            <input type="checkbox" id="allChk" class="custom" />
	                            <label for="allChk" class="text-none"></label>
                        	</th>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<c:if test="${bbsCd != 'BN02' }">
								<th scope="col">첨부</th>
							</c:if>
							<th scope="col">작성일</th>
							<c:if test="${bbsCd != 'BN02' }">
								<th scope="col">조회수</th>
							</c:if>
							<c:if test="${bbsCd == 'BN03' }">
								<th scope="col">처리상황</th>
							</c:if>
							<th scope="col">게시</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty bbsList }">
								<tr>	
									 <td class="none" colspan="${colSize }">게시물이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="i" items="${bbsList }" varStatus="status">
									<tr>
										<td class="chk">
				                            <input type="checkbox" name="listChk_${i.SEQ}" id="listChk_${i.SEQ}" class="custom" value="${i.SEQ }:${i.DELETE_YN }"/>
				                            <label for="listChk_${i.SEQ}" class="text-none"></label>
				                        </td>
										<td class="num">${i.ROWNUM }</td>
										<td class="title"><a href="#" onclick="modify('${i.SEQ}'); return false;" title="상세보기">
											<c:if test="${bbsCd == 'BN01' && i.HEAD_CATEGORY_TEXT != '' }">[${i.HEAD_CATEGORY_TEXT }] </c:if>${i.SUBJECT }</a>
										</td>
										<!-- 첨부 -->
										<c:if test="${bbsCd != 'BN02' }">
										<td class="file">
											<c:forEach var="j" items="${bbsAttachFileList }" varStatus="status">
												<c:if test="${!empty i.ATCHMNFL_ID && i.SEQ == j.SEQ}">
													<a href="#" class="${j.fileExtsn }">${j.fileExtsn }</a>
												</c:if>
											</c:forEach>
										</td>
										</c:if>
										<td class="date">${i.REGIST_DT }</td>
										<c:if test="${bbsCd != 'BN02' }">
											<td class="num">${i.READ_COUNT }</td>
										</c:if>
										<c:if test="${bbsCd == 'BN03' }">
											<c:choose>
												<c:when test="${!empty i.ANSWER_DT }">
													<td class="state">답변완료</td>
												</c:when>
												<c:otherwise>
													<td class="state">처리중</td>			
												</c:otherwise>
											</c:choose>	
										</c:if>
										<c:choose>
											<c:when test="${i.DELETE_YN == 'N'}">
												<td class="state"><span class="active">게시</span></td>
											</c:when>
											<c:otherwise>
												<td class="state"><span>미게시</span></td>
											</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				<div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="listThread" />
				</div>

				<div class="board_list_btn right">
	                <a href="javascript:void(0);" class="btn black" onclick="rollbackThread(); return false;">선택 게시</a>
	                <a href="javascript:void(0);" class="btn black" onclick="deleteThread(); return false;">선택 미게시</a>
	                <c:if test="${bbsCd != 'BN03' }">
		                <a href="javascript:write();" class="btn blue" >신규 작성</a>
					</c:if>
	            </div>
			</div>
		</div>
	</div>
	<!-- /content -->
</form>

<!--  파일 다운로드에 사용 -->  
<c:if test="${bbsCd == 'BN02' }">
	<form id="__downForm" name="__downForm" action="<c:url value='/crossUploader/fileDownload.do'/>" method="post">
		<input type="hidden" id="CD_DOWNLOAD_FILE_INFO" name="CD_DOWNLOAD_FILE_INFO" value="" >
		<input type="hidden" id="fileExt" name="fileExt" value="xlsx;jpg;gif;png;bmp;zip;">
		<input type="hidden" id="maxFileSize" name="maxFileSize" value="">
		<input type="hidden" id="maxTotFileSize" name="maxTotFileSize" value="">
		<input type="hidden" id="maxFileSize1" name="maxFileSize1" value="">
		<input type="hidden" id="maxTotFileSize1" name="maxTotFileSize1" value="">
		<input type="hidden" id="applyFlag" name="applyFlag" value="N">
	</form> 
</c:if>
<!--  파일 다운로드에 사용 -->
