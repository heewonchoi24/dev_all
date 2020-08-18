<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="common/link.jsp"%>

<style>
.section_wrap {
	width: 790px;
	margin: 0 auto;
}

.field.v2 {
	width: 365px;
	display: table;
}

.field label {
	display: table-cell;
	width: 80px;
	min-height: 30px;
	vertical-align: middle;
	float: none;
}

.field .label {
	color: #666 !important;
}

.field .label {
	float: left;
	display: inline;
	font-size: 12px;
}
</style>

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
		<!-- Start Top Search -->
		<div class="top-search">
			<div class="container">
				<div class="input-group">
					<span class="input-group-addon"><i class="fa fa-search"></i></span>
					<input type="text" class="form-control" placeholder="Search">
					<span class="input-group-addon close-search"><i
						class="fa fa-times"></i></span>
				</div>
			</div>
		</div>
		<div class="container">
			<%@ include file="common/header.jsp"%>
		</div>
	</nav>

	<section id="feature" class="ab_feature roomy-100"
		style="height: 700px">
		<div class="section_wrap">
			<ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#home"
					id="findId" onclick="clear();">아이디 찾기 </a></li>
				<li><a data-toggle="tab" href="#menu1" id="findPw"
					onclick="clear();">비밀번호 찾기 </a></li>
			</ul>
			<div class="tab-content" style="margin-top: 50px;">
				<div id="home" class="tab-pane fade in active"></div>
				<div id="menu1" class="tab-pane fade"></div>
			</div>
		</div>
	</section>
	<%@ include file="common/footer.jsp"%>
</div>

<script>
        $(document).ready(function(){
        	$("#home").html($("#formFindId").html());
	     });	
        
	     // 아이디 찾기 탭 
	     $('#findId').on('click', function(){
	    	 $("#home").html($("#formFindId").html());
	     });
	     
	     // 비밀번호 찾기 탭 
	     $('#findPw').on('click', function(){
	    	 $("#menu1").html($("#formFindPw").html());
	     });	        
        
	    // 아이디 찾기 확인 버튼 
        function fnFindId(){
	    	 var u_nm    = $("#u_nm").val();
			 var u_telno = $("#u_telno").val();
			 
		     if(!u_nm){ alert("이름을 입력해주세요."); return false; }
		     if(!u_telno){ alert("휴대폰 번호를 입력해주세요."); return false; }
		     
			 $.ajax ({
				  url	: "/user/userFindId.do", // 요청이 전송될 URL 주소
				  type	: "POST", // http 요청 방식 (default: ‘GET’)
				  async : false,  // 요청 시 동기화 여부. 기본은 비동기(asynchronous) 요청 (default: true)
				  cache : false,  // 캐시 여부
				  timeout : 3000, // 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백을 호출.(단위: ms)
				  data  : { u_nm : u_nm, u_telno : u_telno },
				  dataType    : "json", // 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
				  success : function(data, status, xhr) {
					  if(data.messageCd == "Y"){
						  $("#resultId").text("회원님의 아이디는 "+ data.userId + "입니다. ");
					  }else{
						 alert(data.message); 
						 $("#resultId").text("");
					  }
				  },
				  error	: function(xhr, status, error) {
					  alert(xhr + " " +  status + " " +  error);
				  }
			}); 	    	
        }
        
        // 비밀번호 찾기 확인 버튼 
        function fnFindPw(){
        	 var u_id    = $("#u_id2").val();
	    	 var u_telno = $("#u_telno2").val();
	    	 
	    	 if(!u_id){ alert("아이디를 입력해주세요."); return false; }
		     if(!u_telno){ alert("휴대폰 번호를 입력해주세요."); return false; }
		     
			 $.ajax ({
				  url	: "/sendSmsToResetUserPw.do", // 요청이 전송될 URL 주소
				  type	: "POST", // http 요청 방식 (default: ‘GET’)
				  data  : { u_id : u_id, u_telno : u_telno },
				  dataType    : "json", // 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
				  success : function(data, status, xhr) {
					  if(data.messageCd == "Y"){
					  	alert(data.message); 
					  	
					  	document.form.action = data.messageUrl;
					    document.form.submit();
					    
					  }else{
				      	alert(data.message); 
					  }
				  },
				  error	: function(xhr, status, error) {
				  }
			}); 	    	
       }        
        </script>

<!-- 아이디 찾기 -->
<form action="#" method="post" id="formFindId" name="formFindId" hidden>
	<div class="field v2">
		<label for="u_nm" class="label"
			style="margin-top: 8px; font-size: 14px; margin-left: -20px;">이름 </label> <input
			type="text" name="u_nm" id="u_nm" placeholder="이름 입력"
			class="form-control" style="width: 268px; margin: 0px 20px 0px 100px;" maxLength="20">
	</div>
	<div class="field v2">
		<label for="u_telno" class="label"
			style="margin-top: 8px; font-size: 14px;">휴대폰 번호 </label> <input
			type="text" name="u_telno" id="u_telno" placeholder="(ex) 010-1234-5678"
			class="form-control" style="width: 268px; margin: 0px 0px 0px 100px;" maxLength="50">
	</div>
	<div class="form-group">
		<button onclick="fnFindId();" class="btn btn-default"
			style="margin: 40px 280px; padding: 0.5rem 1.5rem;">확인</button>
	</div>
	<div id="resultId" style="margin: -220px 50px 40px 450px; font-size: 15px;"></div>
</form>

<!-- 비밀번호 찾기 -->
<form action="#" method="post" id="formFindPw" name="formFindPw" hidden>
	<p>
		가입 시 등록했던 휴대폰 번호를 입력해주세요. 
		<br /> 
		해당 휴대폰 번호로 임시 비밀번호를 발송해 드립니다.
	</p>
	<br />
	<div class="field v2">
		<label for="u_id2" class="label"
			style="margin: 7px 17px 5px -13px; font-size: 14px;">아이디 </label> <input
			type="text" name="u_id2" id="u_id2" placeholder="아이디 입력"
			class="form-control" style="width: 268px; margin: 0px 0px 0px 100px;" maxLength="20">
	</div>
	<div class="field v2">
		<label for="u_telno2" class="label"
			style="margin-top: 8px; font-size: 14px;">휴대폰 번호 </label> <input
			type="text" name="u_telno2" id="u_telno2" placeholder="(ex) 010-1234-5678"
			class="form-control" style="width: 268px; margin: 0px 0px 0px 100px;" maxLength="50">
	</div>
	<div class="form-group">
		<button onclick="fnFindPw();" class="btn btn-default"
			style="margin: 40px 298px; padding: 0.5rem 1.5rem;">확인</button>
	</div>
</form>
