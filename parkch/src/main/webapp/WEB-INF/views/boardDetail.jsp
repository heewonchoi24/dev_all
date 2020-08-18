<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="common/link.jsp"%>
<link rel="stylesheet" href="/assets2/css/main.css" />
<!-- ckeditor5 -->
<script src="//cdn.ckeditor.com/4.14.0/standard/ckeditor.js"></script>

<style>
.req-red {
	color: red;
}

textarea {
	min-height: 500px;
}
</style>

<script>
	function fnList() {
		$("#boardForm").attr({
			method : "get",
			action : "/board/boardList.do"
		}).submit();
	}

	function fnModify() {
		$("#boardForm").attr({
			method : "post",
			action : "/board/boardWrite.do"
		}).submit();
	}
</script>


<div class="culmn">
	<nav
		class="navbar navbar-default navbar-fixed white no-background bootsnav text-uppercase">
		<div class="container">
			<%@ include file="common/header.jsp"%>
		</div>
	</nav>
</div>

<!-- Footer -->
<footer id="footer" class="wrapper">
	<div class="inner">
		<section>
			<div class="box">
				<div class="content">
					<h2 class="align-center">공지사항</h2>
					<hr />
					<form method="post" id="boardForm" name="boardForm">
						<input type="hidden" id="idx" name="idx" value="${list.idx}" /> <input
							type="hidden" id="u_id" name="u_id"
							value="${sessionScope.userInfo.userId}" />
						<div class="">
							<label for="title" style="text-align: left; font-size: 16px;">제목</label>
							<input type="text" name="title" id="title" maxLength="50"
								value="${list.title}" readonly>
						</div>
						<div style="margin-top:10px">
							<div class="field half first">
								<label for="title" style="text-align: left; font-size: 16px;">작성자</label>
								<input type="text" name="title" id="title" maxLength="50"
									value="${list.u_nm}" readonly>
							</div>
							<div class="field half">
								<label for="title" style="text-align: left; font-size: 16px;">작성날짜</label>
								<input type="text" name="title" id="title" maxLength="50"
									value="${list.regist_dt}" readonly>
							</div>
						</div>
						<textarea class="form-control" id="content" name="content">${list.content }</textarea>
						<script>
						CKEDITOR.replace("content", {
				            width:'100%',
				            height:'600px'
						});
						
						var config = CKEDITOR.instances.content.config;
						config.readOnly = true;
						</script>
						<ul class="actions" style="text-align: right">
							<li><input value="목록으로" class="button special" type="button"
								onClick="fnList();" style="margin-top: 50px; background: black;"></li>
							<c:if test="${sessionScope.userInfo.userId == list.regist_id }">
								<li><input value="수정" class="button special" type="button"
									onClick="fnModify();" style="margin-top: 50px;"></li>
							</c:if>
						</ul>
					</form>
				</div>
			</div>
		</section>
		<div class="copyright">(사) 박정희 대통령 정신문화 선양회</div>
	</div>
</footer>