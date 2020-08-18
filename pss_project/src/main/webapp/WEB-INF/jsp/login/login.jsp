<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" src="/initech/extension/crosswebex6.js"></script>
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
	
	var userId = $("#userId");
	var password = $("#password");
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
	
	var eUserId = $("#userId");
	var ePassword = $("#password");
	
	if(!eUserId.val()){alert("아이디를 입력 해 주시기 바랍니다."); return;}
	if(!ePassword.val()){alert("비밀번호를 입력 해 주시기 바랍니다."); return;}
	
	var message = '';
	var messageUrl = '';
	var messageCd = '';
	
	var pUrl = "/user/checkLogin.do";
	var param = new Object();
    param.userId = eUserId.val();
    param.password = ePassword.val();
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		if('' != data.messageUrl) {
			if('' != data.message){
				alert(data.message);
			}
	    	document.login_form.action = data.messageUrl;
		    document.login_form.submit();
		} else if ('R' == data.messageCd) {
            /* wrapWindowByMask();   */
            layer_popup("#layer2");
		} 
		else {
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
	location.href="/join/join02.do";
}

function CheckSendForm(){
	document.cert.target='_self';
	wrapWindowByMask3();
	
	cwOnloadDisable();
	cwInit("initCallback");
}

function CheckSendFormCallback (result){
	
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

function  fnChengePass(){
	var eId = $("#userId");		
	var ePasswordNew = $("#password_new");
	var ePasswordNewRe = $("#password_new_re");
	
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
function layer_popup(el){
	var $el = $(el);
	var isDim = $el.prev().hasClass("dimBg");
	isDim? $('.dim-layer').fadeIn() : $el.fadeIn();
	var $elWidth = ~~($el.outerWidth()), $elHeight = ~~($el.outerHeight()), docWidth = $(document).width(), docHeight = $(document).height();
	
	if($elHeight < docHeight || $elWidth < docWidth){
		$el.css({
			marginTop : -$elHeight/2,
			marginLeft : -$elWidth/2
		})
	}else{
		$el.css({top:0, left:0});
	}
	
	$el.find("a.btn-layerClose").click(function(){
		isDim? $('.dim-layer').fadeOut() : $el.fadeOut();
		return false;
	})
	
	$('.dimBg').click(function(){
		$('.dim-layer').fadeOut();
		return false;
	})
}
</script>
	<div class="dim-layer">
		<div class="dimBg"></div>
		<div id="layer2" class="pop-layer">
			<div class="pop-container">
				<div class="pop-conts">
					<h1 class="blind">비밀번호 찾기</h1>
						<div style="text-align: right;">
							<a href="#" class="close btn-layerClose" onclick="layerPopupV2.close('.layerPopupT4'); return false;">
								<i class="icon-ei-close"></i>
								<span class="blind">닫기</span>
							</a>
						</div>
						<p class="t1 ta-2">· 새로운 비밀번호로 재설정해주세요.<br/>· 영문, 숫자, 특수문자 중 최소 2가지 이상 조합해서 입력 (10자 이상)</p>
						<div class="wrap_table3">
							<table id="table-1" class="tbl write" summary="새 비밀번호, 새 비밀번호 확인으로 구성된 비밀번호 재설정입니다.">
								<caption>비밀번호 수정</caption>
								<colgroup>
									<col class="th1_1">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th scope="col" id="th_a1">새 비밀번호</th>
										<td headers="th_a1"><input type="password" class="inp_txt w100p" maxLength="20" id="password_new"></td>
									</tr>
									<tr>
										<th scope="col" id="th_a1">새 비밀번호 확인</th>
										<td headers="th_a1"><input type="password" class="inp_txt w100p" maxLength="20" id="password_new_re"></td>
									</tr>
								</tbody>
							</table>				
						</div>
					</div>
					<div class="btn_bot noline btn-r">
						<a href="#" onClick="javascript:fnChengePass()" class="btn-pk n mem rv">변경</a>
	    				<a href="#" class="btn-pk n mem3 rv btn-layerClose">취소</a>
 					</div>
				</div>
			</div>
		</div> 
	</div>
	
	<section id="container" class="sub member">
	   <div class="container_inner">
			<div class="inr-c ty1">
				<div class="box_login clearfix">
					<div class="lft">
						<form name="login_form" id="login_form" action="/loginProcess" method="post" >
							<input type="text" class="inp_txt w100p" placeholder="아이디를 입력해주세요." title="아이디 입력란" name="userId" id="userId">
							<input type="password" class="inp_txt w100p" placeholder="비밀번호를 입력해주세요." title="비밀번호 입력란" name="password" id="password">
							<div class="btn">
								<a href="#" class="btn-pk b mem rv w100p" onclick="done(); return false;">로그인</a>
							</div>
							<div class="ta-r">
								<a href="/user/idPwdFind.do"><span class="i-aft i_arr_r3">아이디/비밀번호 찾기</span></a>
							</div>
						</form>
					</div>
					<div class="rgh">
						<p class="t1">개인정보보호 지원시스템은<br>회원가입 후 이용하실 수 있습니다.</p>
						<a href="#" class="btn-pk n mem w100p" onclick="register(); return false;">회원가입</a>
						<p class="t1 mt50">공인인증서 갱신이 필요하신가요?</p>
						<a href="/user/certUpdate.do" class="btn-pk n mem w100p">공인인증서 갱신</a>
					</div>
				</div>
	
				<div class="box_loginfo">
					<span class="i-set i_info1"></span>
					<div class="info">
						<ul>
							<li>- 아이디/비밀번호 1차 로그인 후, 공인인증서로 2차 로그인 하시기 바랍니다.</li>
							<li>- 회원가입 및 공인인증서 로그인은 개인 공인인증서만 가능합니다. (※ 기관 공인인증서 불가)</li>
							<li>- 아이디/비밀번호는 대소문자를 구별하여 입력해 주세요.</li>
							<li>- 시스템 이용 문의 : 02-6360-6574(내선번호 6574) / <span class="i-aft i_letter1">privacy@ssis.or.kr</span></li>
							<li>- 보건복지 개인정보보호 지원시스템 사전등록 신청서</li>
						</ul>
						<a href="/common/privacyApply.hwp" class="btn-pk gray rv download">신청 양식 다운로드<span><i class="i-set i_down1"></i></span></a>
					</div>
				</div>
			</div>
	
	   </div><!-- //container_inner -->
	</section><!-- //container_main -->

<form name = "cert" id="cert" method="post" target="certResultIfr" action="/user/certLogin.do">
	<input type="hidden" name="INIpluginData" id="INIpluginData">
	<input type="hidden" name="certUserId" id="certUserId">
</form>	
	</div>
</div>

