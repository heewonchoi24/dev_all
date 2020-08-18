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
		var pUrl = "/user/certRefresh.do";
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
</script>

<form method="post" id="form" name="form">
	<section id="container" class="sub mypage">
		<!-- content -->
		 <div class="container_inner">
		 
		 	<div class="inr-c ty2">

				<div class="join_box1 ty2">
					<div class="inner">
						<p class="h1">공인인증서 갱신은 인증서의 유효기간을 연장(1년)하는 것으로,<br><span class="c-blue3">유효기간 만료 30일전부터 유효기간까지</span> 발급받은 공인인증서의 기간을 연장하실 수 있습니다.</p>
						<p class="t1">개인정보보호 지원시스템을 이용하기 위해서는 공인인증서의 유효기간을 확인 후 공인인증서를 갱신하시기 바랍니다.</p>
					</div>
				</div>
	                <div class="btn-bot noline">
	                    <a href="#" class="btn-pk b mem2 rv" onclick="cert.target='_self';CheckSendForm();" value="공인인증서 갱신">공인인증서 갱신</a>
	                    <a href="/login/login.do" class="btn-pk b mem3 rv" value="취소">취소</a>
	                </div>
			</div>
		</div>
		<!-- /content -->
	</section>
</form>
<form name = "cert" id="cert" method="post" target="certResultIfr" action="/user/certRefresh.do">
	<input type="hidden" name="INIpluginData" id="INIpluginData">
</form>
</form>