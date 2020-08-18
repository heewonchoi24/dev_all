<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript" src="/initech/extension/crosswebex6.js"></script>
<script src="/js/jquery-1.12.4.min.js" type="text/javascript"></script>
<script src="/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="/js/jquery.form.js" type="text/javascript"></script>
<script src="/js/dataTables.fixedColumns.min.js" type="text/javascript"></script>
<script src="/js/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
<script src="/js/jquery.mCustomScrollbar.js" type="text/javascript"></script>
<script src="/js/jquery_ui/jquery-ui.js" type="text/javascript"></script>
<script src="/js/ccmsvc.cmd.js" type="text/javascript"></script>
<script src="/js/common.js" type="text/javascript"></script>

<script src="/js/cookie.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resources/admin/css/login.css">

<script>
$(document).ready(function(){
	var msg = '${message}';

	var msgCd = '${messageCd}';
	if('A' == msgCd){
		if(confirm("등록된 공인인증서가 존재하지 않습니다. 다시 등록 하시겠습니까?")){
			document.login_form.action = '/join/join04.do';
		    document.login_form.submit();			
		}
	} else if('dup' == msgCd){
		alert('동일 계정으로 로그인 되어 있습니다.');
	} else if('session' == msgCd){
		alert('개인정보보호를 위하여 아래의 경우\n자동 로그아웃되니 재로그인하여 주십시요\n(세션 타임 아웃)');
	} else {
		if(msg){
			alert(msg);
		}
	}
	
	var userId = $("#userId").val();
	var password = $("#password").val();
	$("#userId").on("keypress", function(e) {
		var code = (e.keyCode ? e.keyCode : e.which);
		if(code && (code == 13)) {
			done();
		}
	});
	
	$("#password").on("keypress", function(e) {
		var code = (e.keyCode ? e.keyCode : e.which);
		if(code && (code == 13)) {
			done();
		}
	});
	
	// ID 기억 쿠키 사용 - start
	var userId = getCookie("userId");
	$("input[name='userId']").val(userId);
	
	if($("input[name='userId']").val() != ""){
		$("#reChk").attr("checked", true);
	}
	
	$("#reChk").change(function(){
		if($("#reChk").is(":checked")){
			var userId = $("input[name='userId']").val();
			setCookie("userId", userId, 365);
		}else{
			deleteCookie("userId");
		}
	});

	$("input[name='userId']").keyup(function(){
		if($("#reChk").is(":checked")){
			var userId = $("input[name='userId']").val();
			setCookie("userId", userId, 365);
		}
	});
	// - end
});

function initCallback(result){
	$(".loading").hide();
	$(".layer_bg, .layer").hide();
    $("body").css("overflowY", "visible");
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

function done(){
	var eUserId = $("#userId").val();
	var ePassword = $("#password").val();
	
	if(!eUserId){alert("아이디를 입력 해 주시기 바랍니다."); return;}
	if(!ePassword){alert("비밀번호를 입력 해 주시기 바랍니다."); return;}
	
	var message = '';
	var messageUrl = '';
	var messageCd = '';
	
	var pUrl = "/user/checkLogin.do";
	var param = new Object();
    param.userId = eUserId;
    param.password = ePassword;
	
    $.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		if('' != data.messageUrl) {
			if('' != data.message){
				alert(data.message);
			}
	    	document.login_form.action = data.messageUrl;
		    document.login_form.submit();
		} else if ('R' == data.messageCd) {
            wrapWindowByMask();  
		} else {
			CheckSendForm();
		} 
		
/* 		if('Y' == data.messageCd) {
			if('' != data.messageUrl) {
		    	document.login_form.action = data.messageUrl;
			    document.login_form.submit();
			} else {
				CheckSendForm();
			}
		} else if('R' == data.messageCd) {
			alert(data.message);
            wrapWindowByMask();  
		} else {
			alert(data.message);
		} */
		
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}

function register(){
	location.href="/join/join01.do";
}

function CheckSendForm(){
	document.cert.target='_self';
	wrapWindowByMask3();
	
	cwOnloadDisable();
	cwInit("initCallback");
}

function CheckSendFormCallback(result){
	
	if(result){
		var pUrl = "/user/certLogin.do";
		var param = new Object();
	    param.INIpluginData = $("#INIpluginData").val();
	    param.certUserId = $("#userId").val();
	    
	    wrapWindowByMask3();
	    
		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			
			$(".loading").hide();
			$(".layer_bg, .layer").hide();
		    $("body").css("overflowY", "visible");
			
			if('A' == data.messageCd) {
				if(confirm("등록된 공인인증서가 존재하지 않습니다. 다시 등록 하시겠습니까?")){
					document.login_form.action = '/join/join04.do';
				    document.login_form.submit();			
				}
			} else if('D' == data.messageCd) {
				document.login_form.action= "/loginProcess";
				document.login_form.submit();
			} else {
				if(confirm(data.message + " 다시 등록 하시겠습니까?")){
					document.login_form.action = '/join/join04.do';
				    document.login_form.submit();			
				}
			}
			
		}, function(jqXHR, textStatus, errorThrown){
			
			$(".loading").hide();
			$(".layer_bg, .layer").hide();
		    $("body").css("overflowY", "visible");
			
		});
		
	} else {
		$(".loading").hide();
		$(".layer_bg, .layer").hide();
	    $("body").css("overflowY", "visible");
	}
}

function fnChengePass(){
	var eId = $("#userId").val();		
	var ePasswordNew = $("#password_new").val();
	var ePasswordNewRe = $("#password_new_re").val();
	
	if(!ePasswordNew.val()){alert("새 비밀번호는 필수입력 사항입니다.");ePasswordNew.focus(); return;}
	if(!pwdChk(ePasswordNew.val())){ePasswordNew.focus(); return;}
	if(!ePasswordNewRe.val()){alert("새 비밀번호 확인은 필수입력 사항입니다."); ePasswordNewRe.focus(); return;}
	if(ePasswordNew.val() != ePasswordNewRe.val()){alert("비밀번호가 일치하지 않습니다."); ePasswordNewRe.focus(); return;}
	
	if(ePasswordNew.val() && ePasswordNewRe.val() && eId) {
	    var pUrl = "/user/changePwd.do";

		var param = {};
		
		param.userId = $("#userId").val();
		param.password = $("#password").val();
		param.password_new = $("#password_new").val();

		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			alert(data.message);
			if(data.messageCd == 'D'){
				$("#password_new").val('');
				$("#password_new_re").val('');
			}else{
				location.href = "/login/login.do";	
			}
		}, function(jqXHR, textStatus, errorThrown){
		});	
	}
}
</script>
	
<form name="login_form" id="login_form" action="/loginProcess" method="post" >
	<div id="wrap">
		<section id="loginBoxArea">
			<div class="loginBox">
				<h1><img src="/resources/admin/images/common/site_logo.png" alt="LOGO"></h1>
				<div class="inputBox">
					<form id="form" name="form" method="post" action="">
					<input type="hidden" name="returnurl" id="returnurl" value="${returnurl}" />
					<div class="flid">
					    <div class="id_box"><input type="text" name="userId" id="userId" class="inp {label:'아이디',required:true}" required="" value=""></div>
					    <div class="pw_box"><input type="password" name="password" id="password" class="inp {label:'비밀번호',required:true}" required="" value=""></div>
					    <div class="chk_box">
					    	<input name="reChk" type="checkbox" id="reChk" class="custom" />
		      				<label for="reChk">Remember ID</label>
						</div>
				    </div><!-- //flid -->
				    <button type="button" id="btnLogin" onclick="done();">LOGIN</button>
				    </form>
				</div><!-- //blueBox -->
			</div>
		</section><!-- //loginBoxArea -->
	</div>
</form>

<!-- /content -->
   <form name = "cert" id="cert" method="post" target="certResultIfr" action="/user/certLogin.do">
	<input type="hidden" name="INIpluginData" id="INIpluginData">
	<input type="hidden" name="certUserId" id="certUserId">
</form>