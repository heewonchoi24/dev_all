<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/link.jsp"%>

<!doctype html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8">
<title>공지사항</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Crimson+Text:400,400i,600,600i,700,700i"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Condensed:300,300i,400,400i,700,700i"
	rel="stylesheet">

<script>
	//이전 버튼 이벤트
	function fn_prev(page, range, rangeSize) {
		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;

		var url = "/board/boardList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;

		location.href = url;
	}

	//페이지 번호 클릭
	function fn_pagination(page, range, rangeSize, searchType, keyword) {
		var url = "/board/boardList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;

		location.href = url;
	}

	//다음 버튼 이벤트
	function fn_next(page, range, rangeSize) {
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;

		var url = "/board/boardList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;

		location.href = url;
	}

	function fnWrite() {
		document.form.action = "/board/boardWrite.do";
		document.form.submit();
	}

	function fnDetail(idx) {
		location.href = "/board/boardDetail.do?idx=" + idx+"&board_cd=01";
	}
</script>
</head>

<form></form>

<body data-spy="scroll" data-target=".navbar-collapse">
	<div id="loading">
		<div id="loading-center">
			<div id="loading-center-absolute">
				<div class="object" id="object_one"></div>
				<div class="object" id="object_two"></div>
				<div class="object" id="object_three"></div>
				<div class="object" id="object_four"></div>
			</div>
		</div>
	</div>

	<div class="culmn">
		<nav
			class="navbar navbar-default navbar-fixed white no-background bootsnav text-uppercase">
			<div class="container">
				<%@ include file="common/header.jsp"%>
			</div>
		</nav>

		<style>
.main-gallery .grid-item img {
	max-width: 100%;
	height: 220px;
}

.separator_left {
	width: 130px;
}
</style>

		<section id="feature" class="ab_feature roomy-100"
			style="height: 1000px">
			<div class="container">
				<div class="row">
					<div class="main_ab_feature">
						<div class="col-md-6" style="margin-bottom: 70px;">
							<div class="head_title">
								<h2>공지사항</h2>
								<div class="separator_left"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<table class="table">
					<thead>
						<tr>
							<th>#</th>
							<th style="width: 800px;">제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty list }">
								<tr>
									<td>데이터가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="i" items="${list }" varStatus="status">
									<tr>
										<th scope="row">${i.num}</th>
										<td><a onclick="fnDetail('${i.idx}'); return false;">
										<c:if test="${i.top_yn == 'Y'}"><span style="color:red">[중요] </span></c:if>${i.title}</a>
										</td>
										<td>${i.u_nm}</td>
										<td>${i.regist_dt}</td>
										<td>${i.read_cnt}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>

					</tbody>
				</table>
			</div>
			<!-- pagination{s} -->
			<div id="paginationBox" style="text-align: center;">
				<ul class="pagination">
					<c:if test="${pagination.prev}">
						<li class="page-item"><a class="page-link" href="#"
							onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">이전</a></li>
					</c:if>

					<c:forEach begin="${pagination.startPage}"
						end="${pagination.endPage}" var="idx">
						<li
							class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a
							class="page-link" href="#"
							onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')">
								${idx} </a></li>
					</c:forEach>

					<c:if test="${pagination.next}">
						<li class="page-item"><a class="page-link" href="#"
							onClick="fn_next('${pagination.range}', 
		'${pagination.range}', '${pagination.rangeSize}')">다음</a></li>
					</c:if>
				</ul>
			</div>
			<!-- pagination{e} -->
			<c:if test="${sessionScope.userInfo.authYn == 'Y'}">
				<div class="form-group" style="margin: 10px 100px 0px 0px;text-align: right;">
					<a onClick="fnWrite();" class="btn btn-default">작성하기</a>
				</div>
			</c:if>
		</section>

		<%@ include file="common/footer.jsp"%>
	</div>
</body>
</html>
