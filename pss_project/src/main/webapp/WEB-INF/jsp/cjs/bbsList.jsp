<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
	var pUrl, pParam;

	$(document).ready(function() {

		$(".selectMenu>li>a").on('click', function(e) {
			e.preventDefault();
			$("#srchOpt").val($(this).attr('value'));
		});

	});

	function listThread(pageNo) {

		$("#pageIndex").val(pageNo);
		$("#form").attr({
			method : "post"
		}).submit();
	}

	function searchList() {
		if ($("#srchStr").val()) {
			if (!$("#srchOpt").val()) {
				alert("검색분류를 선택하세요.");
				return;
			}
		}
		$("#pageIndex").val("1");
		document.form.submit();
	}

	function detail(seq) {
		$("#bbsSeq").val(seq);
		$("#form").attr({
			method : "post",
			action : "/cjs/bbsView.do"
		}).submit();
	}

	function update(seq) {
		$("#bbsSeq").val(seq);
		$("#form").attr({
			method : "post",
			action : "/cjs/bbsWrite.do"
		}).submit();
	}

	function createWrite() {

		$("#bbsSeq").val("");
		$("#form").attr({
			method : "post",
			action : "/cjs/bbsWrite.do"
		}).submit();
	}

	function fn_print() {
		if (confirm("사용자 정보를 다운로드 하시겠습니까?")) {

			$("#form").attr({
				action : "/cjs/cjsUserExcelDown.do",
				method : "post"
			}).submit();
		}
	}

	function pageLink(pageNo) {
		$("#pageIndex").val(pageNo);
		document.form.submit();
	}
</script>

<form action="/cjs/bbsList.do" method="post" id="form" name="form">

	<input type="hidden" name="seq" id="bbsSeq" value="${seq }" /> <input
		type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }" />

	<!-- content -->
	<section id="container" class="sub">
		<div class="container_inner">

			<div class="box-select-gray">
				<div class="box-select-ty1 type1">
					<div class="selectVal" tabindex="0">
						<a href="#this" value="#this" tabindex="-1"> <c:choose>
								<c:when test="${srchOpt eq null or srchOpt eq '' }">선택</c:when>
								<c:when test="${srchOpt eq '1' }">제목</c:when>
								<c:when test="${srchOpt eq '2' }">내용</c:when>
								<c:when test="${srchOpt eq '3' }">제목+내용</c:when>
							</c:choose>
						</a> <input type="hidden" id="srchOpt" name="srchOpt"
							value="${srchOpt }" />
					</div>
					<ul class="selectMenu">
						<li><a href="#" value="1">제목</a></li>
						<li><a href="#" value="2">내용</a></li>
						<li><a href="#" value="3">제목+내용</a></li>
					</ul>
				</div>

				<div class="inp_sch">
					<input type="text" class="inp_txt w100p" id="srchStr"
						name="srchStr" title="검색어 입력" placeholder="검색어 입력" class="w40"
						value="${srchStr }">
					<button type="button" class="btn_sch" onclick="searchList();">
						<span class="i-set i_sch">검색</span>
					</button>
				</div>
			</div>

			<%-- 			<div class="content">
				<div class="board_search">
					<fieldset>
						<legend>게시물 검색</legend>
						<select id="srchOpt" name="srchOpt" title="검색영역 선택" id="label0">
							<option value="">선택</option>
							<option value="1" <c:if test="${srchOpt == '1' }">selected</c:if>>제목</option>
							<option value="2" <c:if test="${srchOpt == '2' }">selected</c:if>>내용</option>
							<option value="3" <c:if test="${srchOpt == '3' }">selected</c:if>>제목+내용</option>
						</select>
						<input type="text" id="srchStr" name="srchStr" title="검색어 입력" placeholder="검색어 입력" class="w40" value="${srchStr }">
						<input type="button" onclick="searchList();" value="검색" class="button bt3 gray">
					</fieldset>
				</div>
			</div> --%>

			<div class="layer-header1 clearfix">
				<div class="col-lft">
					<p class="t_total mt1">
						전체 <strong class="c-blue2">${bbsTotalCnt }</strong>건의 게시물이 있습니다.
					</p>
					<%-- <span class="ml05">현재 페이지</span>
						<strong class="c_red">${pageIndex }</strong>/${totalPageCnt } --%>
				</div>
			</div>

			<div class="wrap_table2 bdno">
				<table id="table-1" class="tbl"
					summary="번호, 제목, 첨부, 작성일, 조회수로 구성된 게시판 리스트입니다.">
					<caption>게시판 리스트</caption>
					<colgroup>
						<col class="th1_5">
						<col>
						<col class="th1_4">
						<col class="th1_5">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${!empty bbsList}">
								<c:forEach var="i" items="${bbsList }" varStatus="status">
									<tr>
										<td>${i.rowNum }</td>
										<c:choose>
											<c:when test="${'Y' eq writeYn }">
												<td class="ta-l"><a class="link1" href="#"
													onclick="update('${i.seq}'); return false;" title="상세보기">${i.subject }</a>
													<c:choose>
														<c:when test="${!empty i.atchmnflId }">
															<div class="fl-r">
																<span class="i-set i_hwp">HWP파일</span>
															</div>
														</c:when>
														<c:otherwise>
														</c:otherwise>
													</c:choose></td>
											</c:when>
											<c:otherwise>
												<td class="ta-l"><a class="link1" href="#"
													onclick="detail('${i.seq}'); return false;" title="상세보기">${i.subject }</a>
													<c:choose>
														<c:when test="${!empty i.atchmnflId }">
															<div class="fl-r">
																<span class="i-set i_hwp">HWP파일</span>
															</div>
														</c:when>
														<c:otherwise>
														</c:otherwise>
													</c:choose></td>

											</c:otherwise>
										</c:choose>
										<%-- 	<c:choose>
												<c:when test="${!empty i.atchmnflId }">
													<td><img src="/images/common/file_icon.gif" alt="첨부파일"></td>
												</c:when>
												<c:otherwise>
													<td></td>
												</c:otherwise>
											</c:choose> --%>
										<td>${i.registDt }</td>
										<td>${i.readCount }</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5">등록된 공지사항이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<c:if test="${'Y' eq writeYn }">
				<div class="btn-bot2">
					<a class="btn-pk s blue rv" onclick="createWrite(); return false;">글쓰기</a>
					<a class="btn-pk s gray rv" onclick="fn_print();"><span
						class="i-aft i_down">관제담당자 엑셀 다운로드</span></a>
				</div>
			</c:if>
			<!--  and sessionScope.userInfo.authorId eq '1' 관리자만 다운로도 가능하게 추가 2018-05-03 -->
			<c:if
				test="${'Y' ne writeYn and sessionScope.userInfo.authorId eq '1'}">
				<div class="mt10 btn_area">
					<div class="right_area">
						<a href="#" class="button bt1 green" onclick="fn_print();">관제담당자
							엑셀 다운로드</a>
					</div>
				</div>
			</c:if>

			<div class="pagenation">
				<ul>
					<ui:pagination paginationInfo="${paginationInfo}" type="bbsImage"
						jsFunction="pageLink" />
				</ul>
			</div>
		</div>
		</div>
	</section>
	<!-- /content -->
</form>