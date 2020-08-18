<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<title>보건복지 개인정보보호 지원시스템 &#124; 알림마당 &#124; ${bbsNm } </title>

<script>
var pUrl, pParam;

$(document).ready(function(){

});

function listThread(pageNo, cat) {
	if(cat){$("#category").val(cat);}
	$("#pageIndex").val(pageNo);
	$("#form").attr({
		method : "post"
	}).submit();
}

function validate(){
	if($("#srchStr").val()){
		if(!$("#srchOpt").val()){alert("검색분류를 선택하세요."); return false;}
		$("#pageIndex").val("1");
	}
	
	return true;
}

function searchList(){
	if($("#srchStr").val()){
		if(!$("#srchOpt").val()){
			alert("검색분류를 선택하세요."); 
			return;
		}
	}
	
	if('BN04' == $("#bbsCd").val()) {
		$("#category").val($("#srchCategory").val());
	}
	
	$("#pageIndex").val("1");
	document.form.submit();
}

function detail(seq){
	$("#bbsSeq").val(seq);
	$("#form").attr({
		method : "post",
		action : "/bbs/bbsView.do"
	}).submit();
}

function modify(seq){
	$("#bbsSeq").val(seq);
	$("#form").attr({
		method : "post",
		action : "/bbs/bbsWrite.do"
	}).submit();
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


</script>
</head>

<form action="/bbs/bbsList.do" method="post" id="form" name="form">
	<input type="hidden" name="bbsCd" id="bbsCd" value="${bbsCd }"/>
	<input type="hidden" name="bbsSeq" id="bbsSeq" value="${seq }"/>
	<c:if test="${bbsCd == 'BN03' }">
		<input type="hidden" name="userId" id="userId" value="${sessionScope.userInfo.userId }"/>
	</c:if>

	<input type="hidden" name="category" id="category" value="${category }"/>
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }"/>
	
	<!-- content -->
	<div id="container">
		<div class="content_wrap">
			<h2 class="h2">${bbsNm }</h2>
				<div class="content">
					<c:if test="${bbsCd == 'BN02' }">
						<div class="bbs_category">
							<ul>
								<li <c:if test="${category == 'ML00' || empty category }">class="on"</c:if>>
									<a href="#" onclick="listThread('${pageIndex}','ML00'); return false;">전체</a>
								</li>
								<li <c:if test="${category == 'ML01' }">class="on"</c:if>>
									<a href="#" onclick="listThread('${pageIndex}', 'ML01'); return false;">관리수준 진단</a>
								</li>
								<li <c:if test="${category == 'ML02' }">class="on"</c:if>>
									<a href="#" onclick="listThread('${pageIndex}', 'ML02'); return false;">관리수준 현황조사</a>
								</li>
								<li <c:if test="${category == 'ML03' }">class="on"</c:if>>
									<a href="#" onclick="listThread('${pageIndex}', 'ML03'); return false;">서면점검</a>
								</li>
							</ul>
						</div>
					</c:if>
				<div class="board_search"> <!-- 20180226 김지웅 수정 위치 자료실에. 카테고리 검색 넣기  --> 
					<fieldset>
						<legend>게시물 검색</legend>
						<c:if test="${bbsCd == 'BN04' }">
							<select id="srchCategory" name="srchCategory" title="검색영역 선택">
								<option value="">전체</option>
								<option value="CT01" <c:if test="${srchCategory eq 'CT01' }">selected</c:if>>서식</option>
								<option value="CT02" <c:if test="${srchCategory eq 'CT02' }">selected</c:if>>지침</option>
								<option value="CT03" <c:if test="${srchCategory eq 'CT03' }">selected</c:if>>보도</option>
								<option value="CT04" <c:if test="${srchCategory eq 'CT04' }">selected</c:if>>홍보</option>
								<option value="CT05" <c:if test="${srchCategory eq 'CT05' }">selected</c:if>>교육</option>
								<option value="CT06" <c:if test="${srchCategory eq 'CT06' }">selected</c:if>>참고</option>
								<option value="CT07" <c:if test="${srchCategory eq 'CT07' }">selected</c:if>>기타</option>
							</select>
						</c:if>
						
						
						<select id="srchOpt" name="srchOpt" title="검색영역 선택">
							<option value="">선택</option>
							<option value="1" <c:if test="${srchOpt == '1' }">selected</c:if>>제목</option>
							<option value="2" <c:if test="${srchOpt == '2' }">selected</c:if>>내용</option>
							<option value="3" <c:if test="${srchOpt == '3' }">selected</c:if>>제목+내용</option>
						</select>
						<input type="text" id="srchStr" name="srchStr" title="검색어 입력" placeholder="검색어 입력" class="w40" value="${srchStr }">
						<input type="button" onclick="searchList();" value="검색" class="button bt3 gray">
					</fieldset>
				</div>
			</div>

			<div class="content">
				<div class="board_info">
					<span>전체</span>
					<strong class="c_black">${bbsTotalCnt }</strong>개,
					<span class="ml05">현재 페이지</span>
					<strong class="c_red">${pageIndex }</strong>/${totalPageCnt }
				</div>
				<c:choose>
					<c:when test="${bbsCd == 'BN02' }">
						<c:choose>
							<c:when test="${empty bbsList }">
								<div class="faq_list none">
									데이터가 없습니다.
								</div>
							</c:when>
							<c:otherwise>
								<div class="faq_list">
									<c:forEach var="i" items="${bbsList }" varStatus="status">
										<dl>
											<dt>
												<a href="#faq">
													<span class="count">${i.ROWNUM }</span>
													<span class="title_wrap">
														<span class="word_q">Q</span>
														<span class="title">${i.SUBJECT }</span>
													</span>
													<span class="arrow"></span>
												</a>
											</dt>
											<dd>
												<span class="word_a">A</span>
												<div class="a_text">
													${i.ANSWER }
													<ul class="file_list mt10">
														<c:forEach var="x" items="${bbsAttachFileList }" varStatus="status">
															<c:if test="${x.SEQ == i.SEQ }">
																<li>
																	<a href="#" onclick="fnAttachmentSingleFileDown('${x.FILE_ID}'); return false;" class="f_<c:out value='${x.fileExtsn}'/>">${x.FILE_NAME }</a>
																</li>
															</c:if>
														</c:forEach>									
													</ul>
												</div>
											</dd>
										</dl>
									</c:forEach>
								</div>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<table class="board" summary="번호, 제목, 첨부, 작성일, 조회수, 처리상황으로 구성된 게시판 리스트입니다.">
							<caption>게시판 리스트</caption>
							<colgroup>
								<c:set var="colSize" value="5"/>
								<col style="width:80px;">
								<col style="width:*;">
								<col style="width:80px;">
								<col style="width:120px;">
								<col style="width:80px;">
								<c:if test="${bbsCd == 'BN03' }">
									<col style="width:100px;">
									<c:set var="colSize" value="6"/>
								</c:if>
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<th scope="col">첨부</th>
									<th scope="col">작성일</th>
									<th scope="col">조회수</th>
									<c:if test="${bbsCd == 'BN03' }">
										<th scope="col">처리상황</th>
									</c:if>
								</tr>
							</thead>
							<tbody>
							<c:choose>
								<c:when test="${empty bbsList }">
									<tr><td colspan="${colSize }">데이터가 없습니다.</td></tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="i" items="${bbsList }" varStatus="status">
										<tr>
											<td>${i.ROWNUM }</td>
											<c:choose>
												<c:when test="${(bbsCd == 'BN03' or ((bbsCd == 'BN05' or bbsCd == 'BN07') and sessionScope.userInfo.authorId eq '7')) && empty i.ANSWER_DT }">	
													<td class="subject"><a href="#" onclick="modify('${i.SEQ}'); return false;" title="상세보기">${i.SUBJECT }</a></td>
												</c:when>
												<c:otherwise>
													<td class="subject"><a href="#" onclick="detail('${i.SEQ}'); return false;" title="상세보기">${i.SUBJECT }</a></td>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${!empty i.ATCHMNFL_ID }">
													<td><img src="/images/common/file_icon.gif" alt="첨부파일"></td>
												</c:when>
												<c:otherwise>
													<td/>
												</c:otherwise>
											</c:choose>
											<td>${i.REGIST_DT }</td>
											<td>${i.READ_COUNT }</td>
											<c:if test="${bbsCd == 'BN03' }">
												<c:choose>
													<c:when test="${!empty i.ANSWER_DT }">
														<td><span class="bbs stats1">답변완료</span></td>
													</c:when>
													<c:otherwise>
														<td><span class="bbs stats2">처리중</span></td>			
													</c:otherwise>
												</c:choose>
											</c:if>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
				<c:if test="${bbsCd == 'BN03' || (bbsCd == 'BN05' && sessionScope.userInfo.authorId == '7') || (bbsCd == 'BN07' && sessionScope.userInfo.authorId == '7') }">
					<div class="mt10 btn_area">
						<div class="right_area">
							<input type="submit" class="button bt1" formaction="/bbs/bbsWrite.do" value="글쓰기"/> 
						</div>
					</div>
				</c:if>
				<div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="listThread" />
				</div>
			</div>
		</div>
	</div>
	<!-- /content -->
</form>
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