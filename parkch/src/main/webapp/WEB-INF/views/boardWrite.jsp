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

.ck-editor__editable {
	min-height: 500px;
}
</style>

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
					<h2 class="align-center">공지사항 작성</h2>
					<hr />
					<form method="post" id="form" name="form">
						<input type="hidden" id="idx" name="idx" value="${list.idx }" />
						<input type="hidden" id="board_cd" name="board_cd" value="01" />
						<div class="field half">
							<label for="title"
								style="text-align: left; margin: 30px 10px 0px 0px; font-size: 16px;">제목</label>
							<input value="${list.title }" type="text" name="title" id="title"
								placeholder="제목 입력" maxLength="50"
								style="margin: -30px 60px 0px 60px;">
						</div>
						<div class="">
							<label for="top_yn1"
							style="text-align: left; font-size: 16px;">유형</label>
							</div>
							<div style="margin: -30px 30px 1px;">
							<input type="radio" id="top_yn1" name="top_yn" value="N" <c:if test="${list.top_yn != 'Y'}">checked="true"</c:if>>
							<label for="top_yn1">공지</label>
							<input type="radio" id="top_yn2" name="top_yn" value="Y" <c:if test="${list.top_yn == 'Y'}">checked="true"</c:if>>
							<label for="top_yn2">중요</label>
						</div>
						<div class="field half">
							<input type="radio">
						</div>						
						<textarea class="form-control" id="content" name="content">${list.content }</textarea>
						<script>
						CKEDITOR.replace("content", {
				            width:'100%',
				            height:'600px',
							filebrowserUploadUrl : "/board/imageUpload.do"
								
						});
						window.parent.CKEDITOR.tools.callFunction('${callback}','${fileUrl}', '업로드완료');
						
						config.extraPlugins = 'youtube';
						
						</script>
						<ul class="actions" style="text-align: right">
							<li><input value="삭제" class="button special" type="button"
								onClick="fnDel();" style="margin-top: 50px; background: black;"></li>
							<li><input value="저장" class="button special" type="button"
								onClick="fnSave();" style="margin-top: 50px;"></li>

						</ul>
					</form>
				</div>
			</div>
		</section>
		<div class="copyright">(사) 박정희 대통령 정신문화 선양회</div>
	</div>
</footer>


<script>
	var u_id = "";

	$(document).ready(function() {
		u_id = "${sessionScope.userInfo.userId}";
		if (u_id == "") {
			$("#loginForm").attr({
				method : "get",
				action : "/"
			}).submit();
		}
		
	})

	function fnSave() {
		var msg = "정보를 저장하시겠습니까?";

		var idx = $("#idx").val();
		var title = $("#title").val();
		var content = CKEDITOR.instances.content.getData();
		var board_cd = $("#board_cd").val();
		var top_yn = '';

		$("input:radio").each(function( key ) {
			if($(this).prop("checked")) {
				top_yn = $(this).val();
			}
		});
		
		if (!title) {
			alert("제목을 입력해주세요.");
			return false;
		}
		if (!content) {
			alert("내용을 입력해주세요.");
			return false;
		}
		
		if (confirm(msg)) {

			if (idx != "") {
				$.ajax({
					url : "/board/updateBoard.do",
					type : "POST",
					data : {
						title : title,
						content : content,
						idx : idx,
						top_yn : top_yn
					},
					dataType : "json",
					success : function(data, status, xhr) {
						if (data.messageCd == "Y") {
							alert(data.message);
							location.href = data.messageUrl;
						}
					},
					error : function(xhr, status, error) {
					}
				});

			} else {
				$.ajax({
					url : "/board/insertBoard.do",
					type : "POST",
					data : {
						title : title,
						content : content,
						board_cd : board_cd,
						top_yn : top_yn
					},
					dataType : "json",
					success : function(data, status, xhr) {
						if (data.messageCd == "Y") {
							alert(data.message);
							location.href = data.messageUrl;
						}
					},
					error : function(xhr, status, error) {
					}
				});
			}

		}
	}

	function fnDel() {
		var msg = "게시글을 삭제하시겠습니까?";

		var idx = $("#idx").val();
		if (idx != "") {
			$.ajax({
				url : "/board/deleteBoard.do",
				type : "POST",
				data : {
					idx : idx
				},
				dataType : "json",
				success : function(data, status, xhr) {
					if (data.messageCd == "Y") {
						alert(data.message);
						location.href = data.messageUrl;
					}
				},
				error : function(xhr, status, error) {
				}
			});

		}
	}
	
	/* window.parent.CKEDITOR.tools.callFunction('${CKEditorFuncNum}', '${url}', '파일 전송 완료.');  */

</script>