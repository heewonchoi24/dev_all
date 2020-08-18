<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ include file="link.jsp" %>

<!--menu list -->
<div class="collapse navbar-collapse" id="navbar-menu">
    <ul class="nav navbar-nav navbar-right" data-in="fadeInDown" data-out="fadeOutUp">
        <li><a href="index.do" >메인 </a></li> 
		<li><a href="aboutus.do" >소개 </a></li> 							                   
        <li><a href="model.do" >갤러리 </a></li> 							
       <!--  <li><a href="blog.jsp">소통 </a></li> -->
        <li><a href="contactus.do" >오시는 길 </a></li>       
        <li><a id="openModalBtn">로그인 </a></li>                        
    </ul>
</div>

<!-- login modal -->
<style>
.loginModal {
	position: fixed;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	display: none;
}
.modal-backdrop.in {
	filter: alpha(opacity=50);
	opacity: 0;
}
.modal-backdrop {
  position: fixed;
  top: 0;
  right: unset;
  bottom: 0;
  left: 0;
  z-index: 1040;
  background-color: #000;
}
.modal-dialog {
  width: 400px;
  margin: 100px auto;
}
</style> 

<div class="loginModal" id="loginModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
        <h4 class="modal-title" id="exampleModalLabel">로그인 </h4>
      </div>
      <div class="modal-body">
		<form id="loginForm" name="loginForm" method="post">
		  <div class="form-group">
		    <label for="user_id">아이디 </label>
		    <input type="email" class="form-control" id="user_id" name="user_id" aria-describedby="emailHelp" placeholder="Enter email">
		    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
		  </div>
		  <div class="form-group">
		    <label for="user_pw">비밀번호 </label>
		    <input type="password" class="form-control" id="user_pw" name="user_pw" placeholder="Password">
		  </div>
		</form>
      </div>
      <div class="modal-footer" style="text-align:center">
      	<button type="submit" class="btn btn-primary" id="closeModalBtn">닫기 </button>
        <button type="button" class="btn btn-default" data-dismiss="modal" id="signInBtn">로그인 </button>
      </div>
    </div>
  </div>
</div>  

<script>
// 모달 버튼에 이벤트를 건다.
$('#openModalBtn').on('click', function(){
	$('#loginModal').modal('show');
});

// 모달 안의 취소 버튼에 이벤트를 건다.
$('#closeModalBtn').on('click', function(){
	$('#loginModal').modal('hide');
});

//로그인
$('#signInBtn').on('click', function(){
	var userId = $("#user_id").val();
	var userPw = $("#user_pw").val();
	
	if(!userId){alert("아이디를 입력 해 주시기 바랍니다."); return false;}
	if(!userPw){alert("비밀번호를 입력 해 주시기 바랍니다."); return false;}
	
/* 	var message = '';
	var messageUrl = '';
	var messageCd = '';
	
	var pUrl = "/user/checkLogin.do";
	var param = {};
    param.userId = userId;
    param.userPw = userPw; */
    
    var formData = $("#loginForm").serialize();

    $.ajax({
        cache : false,
        url : "/user/checkLogin.do", 
        type : 'POST', 
        data : formData, 
        success : function(data) {
        	alert(1);
            var jsonObj = JSON.parse(data);
        }, // success 

        error : function(xhr, status) {
        	alert(2);
            alert(xhr + " : " + status);
        }
    }); // $.ajax */
});
</script>  