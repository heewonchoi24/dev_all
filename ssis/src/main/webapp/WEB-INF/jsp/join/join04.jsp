<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/initech/extension/crosswebex6.js"></script>
<script>
$(document).ready(function(){
	var msg = '${message}'; 
	if(msg){
		alert(msg);
	}
});

function initCallback(result){
	$(".loading").hide();
	$(".layer_bg").hide();
	if(result){
		// 페이지 로딩
		InitCache();
		//GPKI 인증서 정책
		SetProperty("certmanui_gpki","all");
		EncFormVerify(document.cert, "CheckSendFormCallback");
	} else {
		alert('공인인증서 모듈이 정상적이지 않습니다.');
	}
}

function CheckSendForm(){
	document.cert.target='_self';
	wrapWindowByMask3();
	
	cwOnloadDisable();
	cwInit("initCallback");
}

function CheckSendFormCallback (result){
	if(result){
		var pUrl = "/user/certRegist.do";
		var param = new Object();
	    param.INIpluginData = $("#INIpluginData").val();
		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			
			if('A' == data.messageCd) {
				alert(data.message);
			} else if('B' == data.messageCd) {
				alert(data.message);
				document.cert.action= "/login/login.do";
				document.cert.submit();
			}
		}, function(jqXHR, textStatus, errorThrown){
			
		});
	}
}

// 공인인증서 기능 패스하고 메뉴화면 바로가기 함수 2018.1.12
// 20180124 대표번호를 수정하여 운영에 반영하기 위해서 주석처리 함.
function test(){
	document.temp.target = "";
	document.temp.action = '/loginProcess';
	document.temp.submit();
}

</script>

<section id="container" class="sub member">
   <div class="container_inner">
		<div class="inr-c ty2">
			<div class="mem_step1">
				<ul>
					<li>
						<span class="num">1</span>
						<div>
							<p class="t1">Step 01</p>
							<p class="t2">기본정보 입력</p>
						</div>
					</li>
					<li>
						<span class="num">2</span>
						<div>
							<p class="t1">Step 02</p>
							<p class="t2">가입승인 대기</p>
						</div>
					</li>
					<li class="on">
						<span class="num">3</span>
						<div>
							<p class="t1">Step 03</p>
							<p class="t2">가입완료</p>
						</div>
					</li>
				</ul>
			</div>

			<div class="join_box1 ty2">
				<div class="inner">
					<span class="i-set i_join1"></span>
					<p class="h1">회원가입이 <span class="c-blue3">완료</span>되었습니다.<br><span class="c-blue3">공인인증서</span>를 등록 해 주시기 바랍니다.</p>
					<p class="t1">시스템 이용 문의 : 02-6360-6574(내선번호 6574) / privacy@ssis.or.kr (※ 전화상담이 원할하지 않은 경우 이메일로 문의 바랍니다.)</p>
				</div>
			</div>
			
 			<!--공인인증서 기능 패스하고 메뉴화면 바로가기 함수 - 아래 한줄만 빼세요.-->
			<div class="btn-bot noline">
				<a href="#" onclick="test(); return false;" class="btn-pk b mem2 rv">메인화면</a>
				<a href="#" onclick="cert.target='_self';CheckSendForm();" class="btn-pk b mem2 rv">공인인증서 등록</a>
				<a href="/login/login.do" class="btn-pk b mem3 rv">취소</a>
			</div>

		</div>

   </div><!-- //container_inner -->
</section><!-- //container_main -->
 <!--공인인증서 기능 패스하고 메뉴화면 바로가기 함수 - form 전체 삭제하세요.-->
<form name="temp" id="temp" method="post">
	<input type="hidden" name="userId" id="userId" value="${userId}" >     	
</form>

<form name = "cert" id="cert" method="post" target="certResultIfr" action="/user/certRegist.do">
	<input type="hidden" name="INIpluginData" id="INIpluginData" >
</form>
