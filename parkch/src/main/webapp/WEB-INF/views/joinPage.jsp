<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/assets2/css/main.css" />
<script src="/assets/js/vendor/jquery-1.11.2.min.js"></script>
<%@ include file="common/link.jsp"%>

<style>
.req-red {
	color: red;
}
</style>

<script>
var idDupChk = false;
/* var sendMailChk = false;
var authCode = "";
var authCodeChk = false; */
var sendChk = false;
var resultCode = "";
var confirmChk = false; 

//아이디 수정 시
function fnSetId(){
	idDupChk = false;
}

// 휴대폰 번호 수정 시 
function fnSetTelno(){
	sendChk = false;
	resultCode = "";
	confirmChk = false;
}

// 휴대폰 번호 숫자 타입 체크 
function onlyNumber(){
	if((event.keyCode<48)||(event.keyCode>57))
	   event.returnValue=false;
}

// 휴대폰 번호 입력 시 탭 이동 
$(function() {
  $(".tel").keydown(function(e) {
      var charLimit = $(this).attr("maxlength");
      var keys = [8, 9, /*16, 17, 18,*/ 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145];
      if (e.which == 8 && this.value.length == 0) {
          $(this).prev('.tel').focus();
      } else if ($.inArray(e.which, keys) >= 0) {
          return true;
      } else if (this.value.length >= charLimit) {
          $(this).next('.tel').focus();
          return false;
      } else if (e.shiftKey || e.which <= 47 || e.which >= 106) {
          return false;
      } else if (e.shiftKey || (e.which >= 58 && e.which <= 95)) {
          return false;
      }
  }).keyup (function () {
      var charLimit = $(this).attr("maxlength");
      if (this.value.length >= charLimit) {
            $(this).next('.tel').focus();
            return false;
        }
    });
});

function goAddrPopup(){
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	
	var pop = window.open("/popup/jusoPopup.do","_blank","width=570,height=420, scrollbars=yes, resizable=yes"); 
	
	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
    //var pop = window.open("/popup/jusoPopup.do","pop","scrollbars=yes, resizable=yes"); 
}		

function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	$("#u_addr").val(roadFullAddr);
	$("#u_addr").text(roadFullAddr);
}

function save(){
	
	var msg = "정보를 저장하시겠습니까?";
	
	var u_id = $("#u_id").val();
	var regExpId = /^[A-Za-z0-9+]*$/; 
	
	var u_pw = $("#u_pw").val();
	var num = u_pw.search(/[0-9]/g); 
	var eng = u_pw.search(/[a-z]/ig); 
	//var spe = u_pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi); 
	
	var u_pw_chk = $("#u_pw_chk").val();
	var u_nm = $("#u_nm").val();
	
	var u_telno2 = $("#u_telno2").val();
	var u_telno3 = $("#u_telno3").val();
	var u_telno = $(".tel").map(function(){return this.value;}).get().join("-");
	$("#u_telno").val(u_telno);
	
 	var u_email = $("#u_email").val();
	//var regExpEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/; // 이메일 유효성 검사 
	
	var u_addr = $("#u_addr").val();

	if($("input:checkbox[id=agree_yn]").is(":checked") == false){ 
		alert("(필수) (사)박정희대통령 정신문화선양회 회원 개인정보 수집 및 이용 동의에 동의해주세요.");
		$("#agree_yn").val("N");
		return false; 
    } else{
		$("#agree_yn").val("Y");
	}
	if(!u_id){ alert("아이디는 필수입력 사항입니다."); return false; }
	else if(u_id.length < 4 || u_id.length > 20){ alert("4자리 ~ 20자리 이내로 입력해주세요."); return false; }
	else if(!regExpId.test(u_id)){ alert("아이디는 한글과 특수문자를 제외한 영문, 숫자로 입력해주세요."); return false; }
	else if(!idDupChk){ alert("아이디 중복 확인 버튼을 눌러주시기 바랍니다."); return false; }
	if(!u_pw){ alert("비밀번호는 필수입력 사항입니다."); return false;}
	else if(u_pw.length < 6 || u_pw.length > 20){ alert("6자리 ~ 20자리 이내로 입력해주세요."); return false; }
	else if(u_pw.search(/\s/) != -1){ alert("비밀번호는 공백 없이 입력해주세요."); return false; }
	else if(num < 0 || eng < 0 ){ alert("영문, 숫자를 혼합하여 입력해주세요."); return false; }			
	else if(u_pw != u_pw_chk){ alert("비밀번호가 일치하지 않습니다."); return false;}
	if(!u_nm){ alert("이름은 필수입력 사항입니다."); return false; }
	if(!u_telno2){ alert("휴대폰 번호는 필수입력 사항입니다."); return false; }
	else if(!u_telno3){ alert("휴대폰 번호는 필수입력 사항입니다."); return false; }
	else if(!sendChk){ alert("휴대폰 인증번호 전송 버튼을 눌러주시기 바랍니다."); return false; }
	else if(!resultCode){ alert("휴대폰 인증번호를 입력해주세요."); return false; }
	else if(!confirmChk){ alert("휴대폰 인증번호 확인 버튼을 눌러주시기 바랍니다. "); return false; }
 	//if(!u_email){ alert("이메일는 필수입력 사항입니다."); return false; }
	/*if(!regExpEmail.test(u_email)){ alert("이메일 주소가 정확하지 않습니다."); return false; }
 	else if(!sendMailChk){ alert("이메일 인증번호 전송 버튼을 눌러주시기 바랍니다."); return false; }
	else if(!authCodeChk){ alert("이메일 인증번호 확인 버튼을 눌러주시기 바랍니다. "); return false; }  */
	if(!u_addr){ alert("배송 주소는 필수입력 사항입니다."); return false; }
	
	if(confirm(msg)){
		$("#signUpForm").attr({
			method : "post",
			action : "/user/insertUser.do"
		}).submit();
	}
}

// 아이디 중복 확인 
function fnIdDupChk() {
	
	var u_id = $("#u_id").val();
	var regExpId = /^[A-Za-z0-9+]*$/; 
	
	if(!u_id){ alert("아이디는 필수입력 사항입니다."); return false; }
	if(u_id.length < 4 || u_id.length > 20){ alert("4자리 ~ 20자리 이내로 입력해주세요."); return false; }
	if(!regExpId.test(u_id)){ alert("아이디는 한글과 특수문자를 제외한 영문, 숫자로 입력해주세요."); return false; }
	
	var formData = $('#signUpForm').serialize();
	
	 $.ajax ({
		  url	: "/user/idDupChk.do", // 요청이 전송될 URL 주소
		  type	: "POST", // http 요청 방식 (default: ‘GET’)
		  async : false,  // 요청 시 동기화 여부. 기본은 비동기(asynchronous) 요청 (default: true)
		  cache : false,  // 캐시 여부
		  timeout : 3000, // 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백을 호출.(단위: ms)
		  data  : formData, // 요청 시 포함되어질 데이터
		  dataType    : "json", // 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
		  success : function(data, status, xhr) {
			  alert(data.message);
			  if(data.messageCd == "Y"){
				  idDupChk = true;
			  }else{
				  idDupChk = false;
			  }
		  },
		  error	: function(xhr, status, error) {
			  alert(xhr + " " +  status + " " +  error);
		  }
	}); 
	
	return idDupChk;
}	

// 휴대폰 번호 인증
function fnSendMobilePhoneAuthNum(){
	
	sendChk = false;
	resultCode = "";
	confirmChk = false; 
	
	var u_telno2 = $("#u_telno2").val();
	var u_telno3 = $("#u_telno3").val();
	var u_telno = $(".tel").map(function(){return this.value;}).get().join("");
	
	if(!u_telno2){ alert("휴대폰 번호는 필수입력 사항입니다."); return false; }
	else if(!u_telno3){ alert("휴대폰 번호는 필수입력 사항입니다."); return false; }
	
	 $.ajax ({
		  url	: "/sendPHAuthCode.do", 
		  type	: "POST",
		  data  :   { u_telno : u_telno },
		  dataType    : "json", 
		  success : function(data, status, xhr) {
			  if(data.messageCd == "Y"){
				  alert(data.message); 
				  resultCode = data.authCode;
				  var html = '';
				  html += '<input type="text"  name="auth_code" id="auth_code" placeholder="인증번호 입력" style="margin: 10px 0 0 0px; width: 150px" maxLength="10">';
				  html += '<input type="button" onClick="fnAuthCodeConfirm();" value="확인" style="margin: 0px 0px 10px 20px;font-size:1rem;"/>';
				  $("#phAuthNumDiv").html(html);
				  
				  sendChk = true;
			  }else{
				 alert(data.message); 
			  }
		  },
		  error	: function(xhr, status, error) {
		  }
	}); 
	 
}

// 휴대폰 인증번호 확인 
function fnAuthCodeConfirm(){
	
	confirmChk = false;
    var authCode = $("#auth_code").val();
    
	if(resultCode == authCode){
		alert("휴대폰 번호 인증에 성공하였습니다.");
		confirmChk = true;
	}else{
		alert("인증번호가 올바르지 않습니다.")
		confirmChk = false;
	}
}
// 이메일 인증	
/* function fnSendMailtoCertifyEmailAddress() {
	
	sendMailChk = false;
	
	var u_email = $("#u_email").val();
	var regExpEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/; // 이메일 유효성 검사
	
	if(!u_email){ alert("이메일 주소는 필수입력 사항입니다."); return false; }
	if(!regExpEmail.test(u_email)){ alert("이메일 주소가 정확하지 않습니다."); return false; }
	
	 $.ajax ({
		  url	: "/sendMailtoCertifyEmailAddress.do", // 요청이 전송될 URL 주소
		  type	: "POST", // http 요청 방식 (default: ‘GET’)
		  data  :   { u_email : u_email },
		  dataType    : "json", // 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
		  success : function(data, status, xhr) {
			  if(data.messageCd == "Y"){
				  alert(data.message); 
				  authCode = data.authCode;
				  var html = '';
				  html += '<input type="text"  name="auth_code" id="auth_code" placeholder="인증번호 입력" style="margin: 10px 0 0 0px; width: 150px" maxLength="10">';
				  html += '<input type="button" onClick="fnEmailAuthCodeConfirm();" value="확인" style="margin: 0px 0px 10px 20px;font-size:1rem;"/>';
				  $("#emailAuthCodeDiv").html(html);
				  
				  sendMailChk = true;
			  }else{
				 alert(data.message); 
			  }
		  },
		  error	: function(xhr, status, error) {
		  }
	}); 
	 
}	 */

// 이메일 인증번호 확인 
/* function fnEmailAuthCodeConfirm(){
    var emailAuthCode = $("#auth_code").val();
    
	if(authCode == emailAuthCode){
		alert("이메일 주소 인증에 성공하였습니다.");
		authCodeChk = true;
	}else{
		alert("인증번호가 다릅니다.")
		authCodeChk = false;
	}
}
 */

//이메일 수정 시 
/* function fnSetEmail(){
	sendMailChk = false;
    authCode = "";
    authCodeChk = false;
} */
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
					<h2 class="align-center">회원 가입</h2>
					<hr />
					<form action="#" method="post" id="signUpForm" name="signUpForm">
						<div class="field half first">
							<label for=""><label class="req-red">*</label> 약관동의</label> <br />
							<input type="checkbox" id="agree_yn" name="agree_yn" value="N">
							<label for="agree_yn">(필수) 개인정보 수집, 이용 안내
								&nbsp;&nbsp;&nbsp;&nbsp;</label><a id="openPrivacyModalBtn"
								style="color: gray; font-size: 1rem;">[내용확인] </a>
						</div>
						<div class="field half first">
							<label for="u_id" style="text-align: left"><label
								class="req-red">*</label> 아이디 </label> <input type="button"
								onClick="fnIdDupChk();" value="중복 확인"
								style="margin: 0px 0px 10px 20px; font-size: 1rem;" /> <input
								type="text" name="u_id" id="u_id"
								placeholder="아이디 입력 (4~20자, 한글과 특수문자를 제외한 영문, 숫자)"
								maxLength="20" onkeydown="fnSetId();">
						</div>
						<div class="field half first">
							<label for="rec_u_id" style="text-align: left"> 추천 아이디 </label> <input
								type="text" name="rec_u_id" id="rec_u_id"
								placeholder="추천 아이디 입력" maxLength="20">
						</div>
						<div class="field half first">
							<label for="u_pw"><label class="req-red">*</label> 비밀번호 </label>
							<input type="password" name="u_pw" id="u_pw"
								placeholder="6~20자 영문, 숫자 조합 " maxLength="20"> <input
								type="password" name="u_pw_chk" id="u_pw_chk"
								placeholder="비밀번호 재확인 " style="margin: 10px 0 0 0px;"
								maxLength="20">
						</div>
						<div class="field half first">
							<label for="u_nm"><label class="req-red">*</label> 이름 </label> <input
								type="text" name="u_nm" id="u_nm" placeholder="이름 입력 "
								maxLength="20">
						</div>
						<div class="field half first">
							<label for="u_telno"><label class="req-red">*</label> 휴대폰
								번호 </label> <br />
							<td colspan="3"><select id="u_telno1" title="휴대전화 앞 자리(국번)"
								class="tel" style="width: 60px">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
							</select> - <input type="text" name="u_telno2" id="u_telno2" class="tel"
								style="width: 60px" maxLength="4" onkeypress="onlyNumber();"
								onkeydown="fnSetTelno();" /> - <input type="text"
								name="u_telno3" id="u_telno3" class="tel" style="width: 60px"
								maxLength="4" onkeypress="onlyNumber();"
								onkeydown="fnSetTelno();" /> <input type="hidden"
								name="u_telno" id="u_telno" value=""> <input
								type="button" onClick="fnSendMobilePhoneAuthNum();"
								value="인증번호 전송 "
								style="margin: 0px 0px 10px 20px; font-size: 1rem;" /></td>
							<div id="phAuthNumDiv"></div>
						</div>
						<div class="field half first">
							<label for="u_email" style="text-align: left"> 이메일 주소 </label>
							<!-- <input type="button"
								onClick="fnSendMailtoCertifyEmailAddress();" value="인증번호 전송 "
								style="margin: 0px 0px 10px 20px; font-size: 1rem;" /> -->
							<input type="text" name="u_email" id="u_email"
								placeholder="이메일주소 입력 (ex) parkjh@parkjh.net" maxLength="50">
							<!-- <div id="emailAuthCodeDiv"></div> -->
						</div>
						<div class="field half first">
							<label for="u_addr"><label class="req-red">*</label> 배송
								주소 </label> <input type="button" onClick="goAddrPopup();" value="검색 "
								style="margin: 0px 0px 10px 20px; font-size: 1rem;" /> <input
								readonly type="text" id="u_addr" name="u_addr" />
						</div>
						<ul class="actions" style="text-align: right">
							<li><input value="저장" class="button special" type="button"
								onClick="save();"></li>
						</ul>
					</form>
				</div>
			</div>
		</section>
		<div class="copyright">(사) 박정희 대통령 정신문화 선양회</div>
	</div>
</footer>

<script>
// 개인정도 동의 약관 내용 
$('#openPrivacyModalBtn').on('click', function(){
	var pop2 = window.open("/popup/privacyPopup.do","_blank","width=570,height=420, scrollbars=yes, resizable=yes"); 
});
</script>