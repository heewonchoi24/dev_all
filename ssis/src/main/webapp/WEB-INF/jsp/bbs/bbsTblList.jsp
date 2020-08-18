<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
$(document).ready(function(){

	// 검색 옵션 선택 시
	$(".selectMenu>li>a").on('click',function(e){
		e.preventDefault();
		$("#srchOpt").val($(this).attr('value'));
	});
	
});

// 검색 버튼 눌릴 시
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

// 상세 글 이동
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
	<c:if test="${bbsCd == 'BN03' }">
		<input type="hidden" name="userId" id="userId" value="${sessionScope.userInfo.userId }"/>
	</c:if>
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
				<c:when test="${bbsCd eq 'BN02'}">
				<!-- 자주 묻는 질문 -->
					<c:choose>
					<c:when test="${empty bbsList }">
						<div id="bbsNoDataDiv">데이터가 없습니다.</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="x" items="${bbsList }" varStatus="status">
							<c:if test="${bbsCd eq x.BBS_CD }">
								<dl class="wrap_accodian">
									<dt>
										<div class="num">${x.ROWNUM }</div>
										<div class="cont">
											<span class="ico">Q.</span>
											<div class="txt">${x.SUBJECT }</div>
										</div>
									</dt>
									<dd>
										<div class="cont">
											<span class="ico">A.</span>
											<div class="txt">
												<div class="img" >
													<c:forEach var="img" items="${imgList}" varStatus="status">
														<c:choose>
															<c:when test='${img.BBS_SEQ == x.SEQ && img.USE_YN =="Y"}'>
																<img src="${img.IMG_PATH}${img.IMG_NM}" alt="${img.IMG_NM}" style="max-width: 300px;">
															</c:when>
															<c:when test='${img.BBS_SEQ == x.SEQ && img.USE_YN !="Y"}'>
																<img src="/resources/admin/images/board/list_img_1.jpg" style="max-width: 300px;">
															</c:when>
															<c:otherwise> </c:otherwise>
														</c:choose>
													</c:forEach>
												</div>
												${x.ANSWER }
											</div>
										</div>
									</dd>
								</dl>
							</c:if>
						</c:forEach>
					</c:otherwise>
					</c:choose>
				</c:when>
			
			
				<c:otherwise>
					<div class="wrap_table2 bdno">
						<table id="table-1" class="tbl">
							<caption>게시판 리스트</caption>
							<colgroup>
								<c:set var="colSize" value="5"/>
								<col class="th1_5">
								<col>
								<col class="th1_4">
								<col class="th1_5">
								<c:if test="${bbsCd == 'BN03' }">
									<col style="width:100px;">
									<c:set var="colSize" value="6"/>
								</c:if>
							</colgroup>
							<thead>
								<tr>
									<th scope="col" id="th_a">번호</th>
									<th scope="col" id="th_b">제목</th>
									<th scope="col" id="th_c">작성일</th>
									<th scope="col" id="th_d">조회수</th>
									<c:if test="${bbsCd == 'BN03' }">
										<th scope="col" id="th_e">처리상황</th>
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
											<td headers="th_a">${i.ROWNUM }</td> <!-- 번호 -->
											<td headers="th_b" class="ta-l"> <!-- 제목 -->
												<c:choose>
													<c:when test="${(bbsCd == 'BN03' or ((bbsCd == 'BN05' or bbsCd == 'BN07') and sessionScope.userInfo.authorId eq '7')) && empty i.ANSWER_DT }">
														<a href="#" onclick="modify('${i.SEQ}'); return false;" class="link1"><c:if test="${bbsCd == 'BN01' && i.HEAD_CATEGORY_TEXT != '' }">[${i.HEAD_CATEGORY_TEXT }] </c:if>${i.SUBJECT }</a>
													</c:when>
													<c:otherwise>
														<a href="#" onclick="detail('${i.SEQ}' , '${i.REGIST_ID }'); return false;" title="상세보기" class="link1"><c:if test="${bbsCd == 'BN01' && i.HEAD_CATEGORY_TEXT != '' }">[${i.HEAD_CATEGORY_TEXT }] </c:if>${i.SUBJECT }</a>
													</c:otherwise>
												</c:choose>
												<c:if test="${!empty i.ATCHMNFL_ID }">
													<c:forEach var="j" items="${bbsAttachFileList }" varStatus="status">
														<c:if test="${!empty i.ATCHMNFL_ID && i.SEQ == j.SEQ}">
															<div class="fl-r" style="margin-top: 3px;">
																<span class="i-set i_${j.fileExtsn }">${j.fileExtsn }파일</span>
															</div>
														</c:if>
													</c:forEach>
												</c:if>
											<td headers="th_c">${i.REGIST_DT } </td>
											<td headers="th_d">${i.READ_COUNT } </td>
											<c:if test="${bbsCd == 'BN03' }">
												<c:choose>
													<c:when test="${!empty i.ANSWER_DT }">
														<td><strong class="c-blue2">답변완료</strong></td>
													</c:when>
													<c:otherwise>
														<td><strong style="color: #a0a0a0;">처리중</strong></td>	
													</c:otherwise>
												</c:choose>
											</c:if>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
					</div>
				</c:otherwise>
			</c:choose>

			<c:if test="${bbsCd == 'BN03' || (bbsCd == 'BN05' && sessionScope.userInfo.authorId == '7') || (bbsCd == 'BN07' && sessionScope.userInfo.authorId == '7') }">
				<div class="mt10 btn_area">
					<div class="right_area">
						<input type="submit" class="btn-pk n black" formaction="/bbs/bbsWrite.do" value="글쓰기"/> 
					</div>
				</div>
			</c:if>

			<div class="pagenation">
				<ul>
					<ui:pagination paginationInfo="${paginationInfo}" type="bbsImage" jsFunction="pageLink" />
				</ul>
			</div>

    	</div><!-- //container_inner -->
	</section><!-- //container_main -->
</form>

<script type="text/javascript">
var acodian = {
		  click: function(target) {
		    var $target = $(target);
		    $target.on('click', function() {

		      if ($(this).hasClass('on')) {
		        slideUp($target);
		      } else {
		        slideUp($target);
		        $(this).addClass('on').next().stop().slideDown();
		      }

		      function slideUp($target) {
		        $target.removeClass('on').next().stop().slideUp();
		      }

		    });
		  }
		};
		acodian.click('.wrap_accodian > dt');
</script>