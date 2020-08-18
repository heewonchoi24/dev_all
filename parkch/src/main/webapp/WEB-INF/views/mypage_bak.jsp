<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/assets2/css/main.css" />

<style>
.req-red {
	color: red;
}
</style>

<script>
var sendMailChk = true;
var authCode = "";
var authCodeChk = true;
    
// 휴대전화 숫자 타입 체크 
function onlyNumber(){
          if((event.keyCode<48)||(event.keyCode>57))
             event.returnValue=false;
}

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
	
	var u_pw = $("#u_pw").val();
	var num = u_pw.search(/[0-9]/g); 
	var eng = u_pw.search(/[a-z]/ig); 
	var spe = u_pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi); 
	
	var u_pw_chk = $("#u_pw_chk").val();
	
	var u_telno2 = $("#u_telno2").val();
	var u_telno3 = $("#u_telno3").val();
	var u_telno = $(".tel").map(function(){return this.value;}).get().join("-");
	$("#u_telno").val(u_telno);
	var regExpTelno = /^[0-9]+$/;
	
	var u_email = $("#u_email").val();
	var regExpEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/; // 이메일 유효성 검사
	
	var u_addr = $("#u_addr").val();

	if($("input:checkbox[id=agree_yn]").is(":checked") == false){ 
		alert("(필수) (사)박정희대통령 정신문화선양회 회원 개인정보 수집 및 이용 동의에 동의해주세요.");
		$("#agree_yn").val("N");
		return false; 
    } else{
		$("#agree_yn").val("Y");
	}
	if(!u_pw){ alert("비밀번호는 필수입력 사항입니다."); return false;}
	if(u_pw.length < 8 || u_pw.length > 20){ alert("8자리 ~ 20자리 이내로 입력해주세요."); return false; }
	else if(u_pw.search(/\s/) != -1){ alert("비밀번호는 공백 없이 입력해주세요."); return false; }
	else if(num < 0 || eng < 0 || spe < 0 ){ alert("영문, 숫자, 특수문자를 혼합하여 입력해주세요."); return false; }			
	if(u_pw != u_pw_chk){ alert("비밀번호가 일치하지 않습니다."); return false;}
	if(!u_telno2){ alert("휴대폰 번호는 필수입력 사항입니다."); return false; }
	if(!u_telno3){ alert("휴대폰 번호는 필수입력 사항입니다."); return false; }
	if(!regExpTelno.test(u_telno2) || !regExpTelno.test(u_telno3)){ alert("휴대폰 번호는 숫자를 입력해주세요."); return false; }
	if(!u_email){ alert("이메일는 필수입력 사항입니다."); return false; }
	if(!regExpEmail.test(u_email)){ alert("이메일 주소가 정확하지 않습니다."); return false; }
	if(!sendMailChk){ alert("이메일 인증번호 전송 버튼을 눌러주시기 바랍니다."); return false; }
	if(!authCodeChk){ alert("이메일 인증번호 확인 버튼을 눌러주시기 바랍니다. "); return false; }
	if(!u_addr){ alert("배송 주소는 필수입력 사항입니다."); return false; }
	
	if(confirm(msg)){
		$("#signUpForm").attr({
			method : "post",
			action : "/user/updateUser.do"
		}).submit();
	}
}

// 이메일 인증	
function fnSendMailtoCertifyEmailAddress() {
	
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
	 
}	

// 이메일 인증번호 확인 
function fnEmailAuthCodeConfirm(){
    var emailAuthCode = $("#auth_code").val();
    
	if(authCode == emailAuthCode){
		alert("이메일 주소 인증에 성공하였습니다.");
		authCodeChk = true;
	}else{
		alert("인증번호가 다릅니다.")
		authCodeChk = false;
	}
}

// 이메일 수정 시 
function fnSetEmail(){
	sendMailChk = false;
    authCode = "";
    authCodeChk = false;
}

// 회원 탈퇴 
function fnUnRegister(){
	var msg = "정말 탈퇴하시겠습니까? 정회원일 경우 정회원만 이용 가능한 콘텐츠를 더 이상 이용하실 수 없습니다.";
	if(confirm(msg)){
		$("#signUpForm").attr({
			method : "post",
			action : "/user/deleteUser.do"
		}).submit();
	}
}
</script>

<div class="culmn">
	<!--Home page style-->
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
					<h2 class="align-center">회원 정보 수정</h2>
					<hr />
					<form action="#" method="post" id="signUpForm" name="signUpForm">
						<div class="field half first">
							<label for=""><label class="req-red">*</label> 약관동의 </label> <br />
							<input type="checkbox" id="agree_yn" name="agree_yn"
								<c:if test="${agreeYn == 'Y'}">checked="true"</c:if>> <label
								for="agree_yn">(필수) 개인정보 수집, 이용 안내
								&nbsp;&nbsp;&nbsp;&nbsp;</label><a id="openPrivacyModalBtn"
								style="color: gray; font-size: 1rem;">[내용확인] </a>
						</div>
						<div class="field half first">
							<label for="u_id" style="text-align: left"><label
								class="req-red">*</label> 아이디 </label> <input type="text" name="u_id"
								id="u_id" placeholder="아이디 입력" maxLength="20" value="${userId}"
								readonly>
						</div>
						<div class="field half first">
							<label for="rec_u_id" style="text-align: left"> 추천 아이디 </label> <input
								type="text" name="rec_u_id" id="rec_u_id"
								placeholder="추천 아이디 입력" maxLength="20" value="${recUid}">
						</div>
						<div class="field half first">
							<label for="u_pw"><label class="req-red">*</label> 비밀번호 </label>
							<input type="password" name="u_pw" id="u_pw"
								placeholder="8~20자 영문, 숫자, 특수문자 조합 " maxLength="20"> <input
								type="password" name="u_pw_chk" id="u_pw_chk"
								placeholder="비밀번호 재확인 " style="margin: 10px 0 0 0px;"
								maxLength="20">
						</div>
						<div class="field half first">
							<label for="u_nm"><label class="req-red">*</label> 이름 </label> <input
								type="text" name="u_nm" id="u_nm" placeholder="이름 입력 "
								maxLength="20" value="${userNm}" readonly>
						</div>
						<div class="field half first">
							<label for="u_telno"><label class="req-red">*</label>휴대폰
								번호 </label> <br />
							<td colspan="3"><select id="u_telno1" title="휴대전화 앞 자리(국번)"
								class="tel" style="width: 60px">
									<option value="010"
										<c:if test="${fn:contains(fn:split(userTelno,'-')[0], '010') }">selected</c:if>>010</option>
									<option value="011"
										<c:if test="${fn:contains(fn:split(userTelno,'-')[0], '011') }">selected</c:if>>011</option>
									<option value="016"
										<c:if test="${fn:contains(fn:split(userTelno,'-')[0], '016') }">selected</c:if>>016</option>
									<option value="017"
										<c:if test="${fn:contains(fn:split(userTelno,'-')[0], '017') }">selected</c:if>>017</option>
									<option value="018"
										<c:if test="${fn:contains(fn:split(userTelno,'-')[0], '018') }">selected</c:if>>018</option>
									<option value="019"
										<c:if test="${fn:contains(fn:split(userTelno,'-')[0], '192') }">selected</c:if>>019</option>
							</select> - <input type="text" name="u_telno2" id="u_telno2" class="tel"
								style="width: 60px" maxLength="4" onkeypress="onlyNumber();"
								value="${fn:split(userTelno,'-')[1] }" /> - <input type="text"
								name="u_telno3" id="u_telno3" class="tel" style="width: 60px"
								maxLength="4" onkeypress="onlyNumber();"
								value="${fn:split(userTelno,'-')[2] }" /> <input type="hidden"
								name="u_telno" id="u_telno" value=""></td>
						</div>
						<div class="field half first">
							<label for="u_email" style="text-align: left"><label
								class="req-red">*</label> 이메일 주소 </label> <input type="button"
								onClick="fnSendMailtoCertifyEmailAddress();" value="인증번호 전송 "
								style="margin: 0px 0px 10px 20px; font-size: 1rem;" /> <input
								type="text" name="u_email" id="u_email"
								placeholder="이메일주소 입력 (ex) parkjh@parkjh.net" maxLength="50"
								value="${userEmail}" onkeydown="fnSetEmail();">
							<div id="emailAuthCodeDiv"></div>
						</div>
						<div class="field half first">
							<label for="u_addr"><label class="req-red">*</label> 배송
								주소 </label> <input type="button" onClick="goAddrPopup();" value="검색"
								style="margin: 0px 0px 10px 20px; font-size: 1rem;" /> <input
								readonly type="text" id="u_addr" name="u_addr"
								value="${userAddr}" />
						</div>
						<ul class="actions" style="margin-top: 30px;">
							<li style="text-align: left"><input value="회원 탈퇴"
								class="button special" type="button" onclick="fnUnRegister();"
								style="background: black;"></li>
							<li style="text-align: right"><input value="저장 "
								class="button special" type="button" onClick="save();"
								style="margin: 0 0 0 840px;"></li>

						</ul>
					</form>
				</div>
			</div>
		</section>
		<div class="copyright">(사) 박정희 대통령 정신문화 선양회</div>
	</div>
</footer>

<script>
//개인정도 동의 약관 내용 
$('#openPrivacyModalBtn').on('click', function(){
	var pop2 = window.open("/popup/privacyPopup.do","_blank","width=570,height=420, scrollbars=yes, resizable=yes"); 
});
</script>