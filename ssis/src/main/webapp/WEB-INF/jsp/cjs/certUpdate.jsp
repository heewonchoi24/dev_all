<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	if(confirm("공인인증서를 갱신하겠습니까?")){
		document.cert.target='_self';
		wrapWindowByMask3();
		
		cwOnloadDisable();
		cwInit("initCallback");		
	}
}

function CheckSendFormCallback (result){
	if(result){
		document.cert.submit();
	}
}
</script>
</head>

<form action="/cjs/certUpdate.do" method="post" id="form" name="form">
	<!-- content -->
	<div id="container">
		<div class="content_wrap">
			<h2 class="h2">공인인증서 갱신</h2>
			<div class="content">
                <div class="box1 lh22">
                    공인인증서 갱신은 인증서의 유효기간을 연장(1년)하는 것으로,<br>
                    <strong class="c_blue">유효기간 만료 30일전부터 유효기간까지</strong> 발급받은 공인인증서의 기간을 연장하실 수 있습니다.<br><br>
                    개인정보보호 지원시스템을 이용하기 위해서는 공인인증서의 유효기간을 확인 후 공인인증서를 갱신하시기 바랍니다.
                </div>
                <div class="mt50 tc">
                    <a href="#" class="button bt1" onclick="cert.target='_self';CheckSendForm();" value="공인인증서 갱신">공인인증서 갱신</a>
                </div>
            </div>
		</div>
	</div>
	<!-- /content -->
</form>
<form name = "cert" id="cert" method="post" target="certResultIfr" action="/cjs/certRegist.do">
	<input type="hidden" name="INIpluginData">
</form>
</form>