<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>

$(document).ready(function(){
	var msg = '${message}';
	if(msg){
		alert(msg);
	}
	
	/* function wrapWindowByMask2(){
 		var maskHeight = $(document).height();
 		var maskWidth = $(window).width();    
 
		$(".layer_bg").css({"width":maskWidth,"height":maskHeight});
 		$(".layer_bg").fadeIn(0);
 		$(".layer_bg").fadeTo("slow",0.7)
 
 		var left = ($(window).scrollLeft() + ($(window).width() - $(".layer2").width()) / 2);
 		var top = ($(window).scrollTop() + ($(window).height() - $(".layer2").height()) / 2);
 
 		$(".layer2").css({'left':left, 'top':top, 'position':"absolute"});    
 		$(".layer2").show();
	} */
	
	/* layer popup */
    $(".layer_open4").click(function(e){
    	
    	
    	var html= '';
    	
    	var eName = $("#form_name1");
    	var eEmail = $("#form_email1");
    	
    	if(!eName.val()){alert("이름을 입력 해 주시기 바랍니다."); return false;}
    	if(!eEmail.val()){alert("이메일을 입력 해 주시기 바랍니다."); return false;}
    	
    	if(eName.val() && eEmail.val()) {
            e.preventDefault();
            //wrapWindowByMask();  
            $("body").css("overflowY", "hidden");
    		
    	    var pUrl = "/user/idPwdFind.do";

    		var param = new Object();
    		
    		param.userNm = $("#form_name1").val();
    		param.email = $("#form_email1").val();

    		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
    	        if(data.result) {
					var findedId = data.result.USER_ID.substr(0,3);
					for(var j=3;j < data.result.USER_ID.length;j++) {
						findedId += '*';
					}
    				html = ' <div id="layerPopupT4" class="layerPopupT4"> ';
    				html += ' <div class="inner"> ';
    				html += ' <section class="wrap-popup-ty1 inr-c"> ';
    				html += ' <div class="mid_small"> ';
    				html += ' <h1 class="blind">아이디찾기</h1> ';
    				html += ' <a href="#" class="close" onclick="layerPopupV2.close(\'.layerPopupT4\'); return false;"><i class="icon-ei-close"></i><span class="blind">닫기</span></a> ';
    				html += ' <p class="t1">입력하신 정보로 등록된 아이디는 아래와 같습니다.</p> ';
    				html += ' <p class="t2">' +  findedId + '</p> ';
    				html += ' <div class="btn-bot noline"> ';
    				html += ' <a href="/login/login.do" class="btn-pk n mem rv">로그인</a> ';
    				html += ' <a href="/user/idPwdFind.do" class="btn-pk n mem rv">비밀번호 찾기</a> ';
    				html += ' </div> ';
    				html += ' </div> ';
    				html += ' </section> ';
    				html += ' </div> ';
    				html += ' <div class="cover"></div> ';
    				html += ' </div> ';
    			} else {
    				html = ' <div id="layerPopupT4" class="layerPopupT4"> ';
    				html += ' <div class="inner"> ';
    				html += ' <section class="wrap-popup-ty1 inr-c"> ';
    				html += ' <div class="mid_small"> ';
    				html += ' <h1 class="blind">아이디찾기</h1> ';
    				html += ' <a href="#" class="close" onclick="layerPopupV2.close(\'.layerPopupT4\'); return false;"><i class="icon-ei-close"></i><span class="blind">닫기</span></a> ';
    				html += ' <p class="t1"><b>아이디를 찾을 수 없습니다.</b></p> ';
    				html += ' <p class="t1">입력정보가 정확한지 확인 후 다시 한번 입력해주세요.</p> ';
    				html += ' <div class="btn-bot noline"> ';
    				html += ' <a href="/login/login.do" class="btn-pk n mem rv">로그인</a> ';
    				html += ' <a href="/user/idPwdFind.do" class="btn-pk n mem rv">비밀번호 찾기</a> ';
    				html += ' </div> ';
    				html += ' </div> ';
    				html += ' </section> ';
    				html += ' </div> ';
    				html += ' <div class="cover"></div> ';
    				html += ' </div> ';
    			}
    			$("#cData1").html(html);
    		}, function(jqXHR, textStatus, errorThrown){
    			
    		});	

    	}
        
    });

    /* layer popup */
    $(".layer_open5").click(function(e){
    	
    	/* 20191030 임시조치 by jung */
    	alert("시스템담당자에게 문의하세요. 02-6360-6574(내선번호 6574)"); return false;
    	
    	var eId = $("#form_id");
    	
    	var eName = $("#form_name2");
    	var eEmail = $("#form_email2");
    	
    	if(!eId.val()){alert("아이디을 입력 해 주시기 바랍니다."); return false;}
    	if(!eName.val()){alert("이름을 입력 해 주시기 바랍니다."); return false;}
    	if(!eEmail.val()){alert("이메일을 입력 해 주시기 바랍니다."); return false;}
    	
    	if(eName.val() && eEmail.val() && eId) {

            e.preventDefault();
    		
    	    var pUrl = "/user/idPwdFind.do";
    		var param = new Object();
    		
    		param.user_id = $("#form_id").val();
    		param.userNm = $("#form_name2").val();
    		param.email = $("#form_email2").val();
    		param.password = "";
    		param.password_new = "";

    		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
    	        if(data.result  && data.result.USER_ID == eId.val()) {
    				html  = ' <ul class="list01 mt10"> ';
    				html += ' <li>새로운 비밀번호로 재설정해주세요.</li> ';
    				html += ' <li>영문, 숫자, 특수문자 중 최소 2가지 이상 조합해서 입력(10자이상)</li> ';
    				html += ' </ul> ';
    				html += ' <table class="write" summary="새 비밀번호, 새 비밀번호 확인으로 구성된 비밀번호 재설정입니다."> ';
    				html += ' <caption>비밀번호 재설정</caption> ';
    				html += ' <colgroup> ';
    				html += ' <col style="width:150px;"> ';
    				html += ' <col style="width:*"> ';
    				html += ' </colgroup> ';
    				html += ' <tbody> ';
    				html += ' <tr> ';
    				html += ' <th scope="row"><label for="label2" class="star1">새 비밀번호</label><span class="hidden">필수</span></th> ';
    				html += ' <td><input type="password" id="password" maxLength="20"></td> ';
    				html += ' </tr> ';
    				html += ' <tr> ';
    				html += ' <th scope="row"><label for="label3" class="star1">새 비밀번호 확인</label><span class="hidden">필수</span></th> ';
    				html += ' <td><input type="password" id="password_new" maxLength="20"></td> ';
    				html += ' </tr> ';
    				html += ' </tbody></table> ';
    				html += ' <div class="tc mt30"> ';
    				html += ' <a href="#" onClick="javascript:fnChengePass()" class="button bt1">변경</a> ';
    				html += ' <a href="/user/idPwdFind.d" class="button bt1 gray close">취소</a> ';
    				html += ' </div> ';
    			} else {
    				html  = ' <div class="box2 tc"> ';
    				html += ' <strong class="c_black d_block">비밀번호를 찾을 수 없습니다.</strong> ';
    				html += ' <span class="d_block">입력정보가 정확한지 확인 후 다시 한번 입력해주세요.</span> ';
    				html += ' </div> ';
    				html += ' <div class="tc mt30"> ';
    				html += ' <a href="/login/login.do" class="button bt1">로그인</a> ';
    				html += ' <a href="/user/idPwdFind.do" class="button bt1 gray close">다시찾기</a> ';
    				html += ' </div>';
    			}
    			$("#cData2").html(html);
    		}, function(jqXHR, textStatus, errorThrown){
    			
    		});	
    	}        
    });
});

function  fnChengePass(){
		var eId = $("#form_id");		
		var eName = $("#form_name2");
		var eEmail = $("#form_email2");
		var ePassword = $("#password");
		var ePssword_new = $("#password_new");
		
		if(!ePassword.val()){alert("새 비밀번호는 필수입력 사항입니다.");ePassword.focus(); return;}
		if(!pwdChk(ePassword.val())){ePassword.focus(); return;}
		if(!ePssword_new.val()){alert("새 비밀번호 확인은 필수입력 사항입니다."); ePssword_new.focus(); return;}
		if(ePassword.val() != ePssword_new.val()){alert("비밀번호가 일치하지 않습니다."); ePssword_new.focus(); return;}
		
		if(ePassword.val() && ePssword_new.val() && eId) {
		    var pUrl = "/user/idPwdFind.do";

			var param = new Object();
			
			param.user_id = $("#form_id").val();
			param.userNm = $("#form_name2").val();
			param.email = $("#form_email2").val();
			param.password = $("#password").val();
			param.password_new = $("#password_new").val();

			$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
				alert(data.message);
				
				document.form.action = "/login/login.do";
				document.form.submit();	 	

			}, function(jqXHR, textStatus, errorThrown){
				
			});	
		}
}

</script>

<div id="layer1" class="layer">
    <div class="layer_content" id="cData1"></div>    
</div>
<div id="layer2" class="layer2">
    <div class="layer_content" id="cData2"></div>    
</div>

<section id="container" class="sub member">
	<form method="post" id="form" name="form">
   <div class="container_inner">
		<div class="inr-c ty1">
			<div class="box_findid">
				<div class="lft">
					<h2 class="h_tit1">아이디 찾기</h2>
					<input type="text" class="inp_txt w100p" placeholder="이름을 입력해주세요." title="이름 입력란" id="form_name1">
					<input type="text" class="inp_txt w100p" placeholder="이메일을 입력해주세요." title="이메일 입력란" id="form_email1">
					<div class="btn">
						<a href="#" class="btn-pk n mem rv layer_open4" onclick="">아이디 찾기</a>
						<a href="/login/login.do" class="btn-pk n mem3 rv">취소</a>
					</div>
				</div>
				<div class="rgh">
					<h2 class="h_tit1">비밀번호 찾기</h2>
					<!-- <input type="text" class="inp_txt w100p" placeholder="아이디를 입력해주세요." title="아이디 입력란" id="form_id">
					<input type="text" class="inp_txt w100p" placeholder="이름을 입력해주세요." title="이름 입력란" id="form_name2">
					<input type="text" class="inp_txt w100p" placeholder="이메일을 입력해주세요." title="이메일 입력란" id="form_email2"> -->
					<div class="btn">
						<a href="#" class="btn-pk n mem rv layer_open5">비밀번호 찾기</a>
						<a href="/login/login.do" class="btn-pk n mem3 rv">취소</a>
					</div>
				</div>
			</div>

			<div class="box_loginfo">
				<span class="i-set i_info1"></span>
				<div class="info">
					<ul>
						<li>- 아이디/비밀번호 로그인은 회원가입 후 최초 로그인 시, 공인인증서 갱신 시 이용</li>
						<li>- 회원가입 및 공인인증서 로그인은 개인 공인인증서만 가능합니다. (※ 기관 공인인증서 불가)</li>
						<li>- 아이디/비밀번호는 대소문자를 구별하여 입력해 주세요.</li>
						<li>- 시스템 이용 문의 : 02-6360-6574(내선번호 6574) / <span class="i-aft i_letter1">privacy@ssis.or.kr</span></li>
						<li class="pl">(※ 전화상담이 원활하지 않은 경우 이메일로 문의 바랍니다.)</li>
					</ul>
				</div>
			</div>
		</div>

   </div><!-- //container_inner -->
   </form>
</section><!-- //container_main -->