<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script>
$(document).ready(function(){

	// 검색 옵션 선택 시
	$(".selectMenu>li>a").on('click',function(e){
		e.preventDefault();
		$("#srchOpt").val($(this).attr('value'));
	});

});

//검색 버튼 눌릴 시
function searchList(){
	if($("#srchStr").val()){
		if(!$("#srchOpt").val()){
			alert("검색 분류를 선택하세요."); 
			return;
		}
	}
	
	if('BN04' == $("#bbsCd").val()) {
		$("#category").val($("#srchCategory").val());
	}
	
	$("#pageIndex").val("1");
	document.form.submit();
}

//상세 글 이동
function detail(seq, registId){
	$("#bbsSeq").val(seq);
	$("#registId").val(registId);
	$("#form").attr({
		method : "post",
		action : "/bbs/bbsView.do"
	}).submit();
}

// 상세 글 수정
function modify(seq){
	$("#bbsSeq").val(seq);
	$("#form").attr({
		method : "post",
		action : "/bbs/bbsWrite.do"
	}).submit();
}

function pageLink(pageNo){
	$("#pageIndex").val(pageNo);
	document.form.submit();
}

</script>
<form action="/bbs/bbsList.do" method="post" id="form" name="form">
	<input type="hidden" name="bbsCd" id="bbsCd" value="${bbsCd }"/>
	<input type="hidden" name="bbsSeq" id="bbsSeq" value="${seq }"/>
	<input type="hidden" id="registId" name="registId" value="" > 
	<input type="hidden" name="category" id="category" value="${category }"/>
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }"/>
	
<section id="container" class="sub">
       <div class="container_inner">

			<div class="box-select-gray">
				<div class="box-select-ty1 type1">
					<div class="selectVal" tabindex="0">
						<a href="#this" value="#this" tabindex="-1" >
							<c:choose>
								<c:when test="${srchOpt eq null or srchOpt eq '' }">선택</c:when>
								<c:when test="${srchOpt eq '1' }">제목</c:when>
								<c:when test="${srchOpt eq '2' }">내용</c:when>
								<c:when test="${srchOpt eq '3' }">제목+내용</c:when>
							</c:choose>
						</a>
						<input type="hidden" id="srchOpt" name="srchOpt" value="${srchOpt }" />
					</div>
					 <ul class="selectMenu" >
						<li><a href="#" value="1">제목</a></li>
						<li><a href="#" value="2">내용</a></li>
						<li><a href="#" value="3">제목+내용</a></li>
					 </ul>
				</div>
				
				<div class="inp_sch">
					<input type="text" class="inp_txt w100p" id="srchStr" name="srchStr" title="검색어 입력" placeholder="검색어 입력" class="w40" value="${srchStr }">
					<button type="button" class="btn_sch" onclick="searchList();" ><span class="i-set i_sch">검색</span></button>
				</div>
			</div>

			<div class="layer-header1 clearfix">
				<div class="col-lft">
					<p class="t_total">전체 <strong class="c-blue2">${bbsTotalCnt }</strong>건의 게시물이 있습니다.</p>
				</div>
			</div>
			<c:choose>
				<c:when test="${empty bbsList }">
					<div id="bbsNoDataDiv">데이터가 없습니다.</div>
				</c:when>
				<c:otherwise>
				<div class="wrap_imgtable">
					<ul>
						
							<c:forEach var="i" items="${bbsList }" varStatus="status">
								<li>
								<c:choose>
									<c:when test="${((bbsCd == 'BN05' or bbsCd == 'BN07') and sessionScope.userInfo.authorId eq '7')}">
										<a href="#" onclick="modify('${i.SEQ}'); return false;" class="t_tbl1">
									</c:when>
									<c:otherwise>
										<a href="#" onclick="detail('${i.SEQ}' , '${i.REGIST_ID }'); return false;" title="상세보기" class="t_tbl1">
									</c:otherwise>
								</c:choose>
									<div class="img">
										<span class="i-cut">
											<c:forEach var="j" items="${imgList}" varStatus="status">
												<c:if test="${j.BBS_SEQ == i.SEQ && j.USE_YN =='Y'}">
													<img src="${j.IMG_PATH }${j.IMG_NM}" alt="${j.IMG_NM}">
												</c:if>
											</c:forEach>
										</span>
									</div>
									<div class="cont">
										<p class="h1"><c:if test="${bbsCd == 'BN01' && i.HEAD_CATEGORY_TEXT != '' }">[${i.HEAD_CATEGORY_TEXT }] </c:if>${i.SUBJECT }</p>
										<c:set var="contents" value='${fn:substring(i.CONTENTS.replaceAll("\\\<.*?\\\>",""), 0, 500) }'/>
										<div class="t1"><c:out value='${contents.replaceAll("  ", "") }' escapeXml="false"/></div>
										<p class="t2">${i.REGIST_DT }</p>
									</div>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</c:otherwise>
			</c:choose>
			
			<div class="pagenation">
				<ul>
					<ui:pagination paginationInfo="${paginationInfo}" type="bbsImage" jsFunction="pageLink" />
				</ul>
			</div>

       </div><!-- //container_inner -->
   </section><!-- //container_main -->
   
</form>
