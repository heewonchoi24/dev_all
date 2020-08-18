<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="link.jsp"%>

<!-- login modal -->
<style>
.btn-signup {
	padding: 0px 0px;
}

.loginModal {
	position: fixed;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	display: none;
}

.modal-backdrop.in {
	filter: alpha(opacity = 50);
	opacity: 0;
}

.modal-backdrop {
	top: 0;
	right: unset;
	bottom: 0;
	left: 0;
	z-index: 1040;
	background-color: #000;
}

.modal-dialog {
	width: 300px;
	margin: 100px auto;
}

.popover-content {
	padding: 10px 5px;
	width: 100px;
}
</style>

<script>
	$(function(e) {
		$('[data-toggle="popover"]').popover();
	})
</script>
<!-- Start Atribute Navigation -->
<!-- <div class="attr-nav">
    <ul>
        <li class="search"><a href="#"><i class="fa fa-search"></i></a></li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" >
                <i class="fa fa-shopping-bag"></i>
                <span class="badge">3</span>
            </a>
            <ul class="dropdown-menu cart-list">
                <li>
                    <a href="#" class="photo"><img src="/assets/images/thumb01.jpg" class="cart-thumb" alt="" /></a>
                    <h6><a href="#">Delica omtantur </a></h6>
                    <p class="m-top-10">2x - <span class="price">$99.99</span></p>
                </li>
                <li>
                    <a href="#" class="photo"><img src="/assets/images/thumb01.jpg" class="cart-thumb" alt="" /></a>
                    <h6><a href="#">Delica omtantur </a></h6>
                    <p class="m-top-10">2x - <span class="price">$99.99</span></p>
                </li>
                <li>
                    <a href="#" class="photo"><img src="/assets/images/thumb01.jpg" class="cart-thumb" alt="" /></a>
                    <h6><a href="#">Delica omtantur </a></h6>
                    <p class="m-top-10">2x - <span class="price">$99.99</span></p>
                </li>
                -- More List --
                <li class="total">
                    <span class="pull-right"><strong>Total</strong>: $0.00</span>
                    <a href="#" class="btn btn-cart">Cart</a>
                </li>
            </ul>
        </li>

    </ul>
</div>         -->
<!-- End Atribute Navigation -->

<!-- Start Header Navigation -->
<div class="navbar-header">
	<button type="button" class="navbar-toggle" data-toggle="collapse"
		data-target="#navbar-menu">
		<i class="fa fa-bars"></i>
	</button>
	<!--  <a class="navbar-brand" href="/index.do">
    </a> -->
</div>
<!-- End Header Navigation -->

<!--menu list -->
<div class="collapse navbar-collapse" id="navbar-menu">
	<ul class="nav navbar-nav navbar-right" data-in="fadeInDown"
		data-out="fadeOutUp">
		<li><a href="/" style="color: black;">메인 </a></li>
		<li><a class="header-menu" href="/aboutus.do"
			style="color: black;">소개 </a></li>
		<li><a class="header-menu" href="/gallery.do"
			style="color: black;">갤러리 </a></li>
		<li><a class="header-menu" href="/board/boardList.do" style="color: black;">공지사항
		</a></li>
		<li><a href="/contactus.do" style="color: black;">오시는 길 </a></li>
		<c:choose>
			<c:when test="${null ne sessionScope.userInfo}">
				<li><a href="/user/mypage.do" style="color: black;">마이페이지 </a></li>
				<li><a href="/user/logout.do" style="color: black;">로그아웃 </a></li>
				<li><a style="color: black;">${sessionScope.userInfo.userNm }님
						<c:if test="${sessionScope.userInfo.memYn == 'Y'}"> (정회원)</c:if> <c:if
							test="${sessionScope.userInfo.memYn == 'N'}">
							<div style="margin: 0px -10px 2px -9px;"
								class="btn btn-secondary" data-toggle="popover"
								data-placement="bottom" data-content="정회원 전환하기" id="tooltip">(준회원)</div>
						</c:if>
				</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="#" id="openLoginModalBtn" style="color: black;">로그인</a></li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>

<div class="loginModal" id="loginModal" hidden>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
				<h4 class="modal-title" id="exampleModalLabel">로그인</h4>
			</div>
			<div class="modal-body">
				<form id="loginForm" name="loginForm" method="post">
					<div class="form-group">
						<label for="user_id">아이디 </label> <input type="email"
							class="form-control" id="userId" name="userId"
							aria-describedby="emailHelp" placeholder="Enter Id"
							maxLength="20">
					</div>
					<div class="form-group">
						<label for="user_pw">비밀번호 </label> <input type="password"
							class="form-control" id="userPw" name="userPw"
							placeholder="Password" maxLength="20">
					</div>
					<div class="form-group">
						<small id="signUpBtn" class="btn btn-signup">회원가입 </small> <br />
						<small id="findUserInfoBtn" class="btn btn-signup">아이디/비밀번호
							찾기 </small>
					</div>
				</form>
			</div>
			<div class="modal-footer" style="text-align: center">
				<button type="button" class="btn-primary btn-sm"
					id="closeLoginModalBtn">닫기</button>
				<button type="button" class="btn btn-default" data-dismiss="modal"
					id="signInBtn">로그인</button>
			</div>
		</div>
	</div>
</div>

<form id="form" name="form"></form>

<script>
	$(document).ready(function() {
		
		var userId = '${sessionScope.userInfo.userId}';
		var memYn = '${sessionScope.userInfo.memYn}';
		

		// 정회원 전환 툴팁 클릭 시 
		$('#tooltip').on('click', function(e) {
			$(".popover-content").on('click', function(e) {
				pay();
			});
		});

		function pay() {
			document.form.action = "/pay/order.do";
			document.form.submit();
		}

		// 팝업 공지
		var popup_name = "noticePopup";
		if (getCookie(popup_name) != "no") {
			//popNotice();
		}

		// 상단 메뉴 선택시 
		/*  $('.header-menu').on('click', function(){
		 	if(memYn != "Y"){
		 		alert("정회원만 볼 수 있습니다.");
		 		return false;
		 	}
		 }); */
	})

	function popNotice() {
		var pop3 = window.open("/popup/noticePopup.do", "noticePopup",
				"width=630,height=480");
		setCookie("noticePopup", "no", 1);
	}

	// 로그인 버튼
	$('#openLoginModalBtn').on('click', function(e) {
		$('#loginModal').show();
		e.preventDefault();
	});

	// 로그인 모달 닫기 버튼 
	$('#closeLoginModalBtn').on('click', function() {
		$('#loginModal').hide();
	});

	// 회원가입 버튼
	$('#signUpBtn').on('click', function() {
		$("#loginForm").attr({
			method : "post",
			action : "/user/joinPage.do"
		}).submit();
	});

	// 아이디/비밀번호 찾기 버튼 
	$('#findUserInfoBtn').on('click', function() {
		$("#loginForm").attr({
			method : "post",
			action : "/user/findUserInfoPage.do"
		}).submit();
	});

	//로그인
	$('#signInBtn').on('click', function() {

		var userId = $("#userId").val();
		var userPw = $("#userPw").val();

		if (!userId) {
			alert("아이디를 입력 해 주시기 바랍니다.");
			return false;
		}
		if (!userPw) {
			alert("비밀번호를 입력 해 주시기 바랍니다.");
			return false;
		}

		var formData = $('#loginForm').serialize();

		$.ajax({
			url : "/user/login.do", // 요청이 전송될 URL 주소
			type : "POST", // http 요청 방식 (default: ‘GET’)
			async : false, // 요청 시 동기화 여부. 기본은 비동기(asynchronous) 요청 (default: true)
			cache : false, // 캐시 여부
			timeout : 3000, // 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백을 호출.(단위: ms)
			data : formData, // 요청 시 포함되어질 데이터
			dataType : "json", // 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
			success : function(data, status, xhr) {
				alert(data.message);
				if (data.messageCd == "Y") {
					window.location.reload(true);
					document.form.action = "/";
					document.form.submit();
				} else {
					return false;
				}
			},
			error : function(xhr, status, error) {
				alert(xhr + " " + status + " " + error);
			}
		});

	});
</script>