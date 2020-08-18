<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
var pUrl, pParam;

$(document).ready(function(){
	$("#label13").change(function(){
		changeDomain(this.value);
	});
	//fn_numberInit();
	$("#password").on("keypress", function(e) {
		var code = (e.keyCode ? e.keyCode : e.which);
		if(code && (code == 13)) {
			done();
		}
	});
});

function changeDomain(domainVal){
	$("#email_domain").val(domainVal);
}

function done(){
	
	if(!$("#password").val()){alert("비밀번호를 입력 해 주시기 바랍니다."); return;}
	
	var message = '';
	var messageUrl = '';
	var messageCd = '';
	
	var pUrl = "/user/checkPw.do";
	var param = new Object();
    param.userId = $("#userId").val();
    param.password = $("#password").val();
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		
		if('Y' == data.messageCd) {
			if('' != data.messageUrl) {
		    	document.login_form.action = data.messageUrl;
			    document.login_form.submit();
			}
		} else {
			alert(data.message);
		}
		
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}


</script>

<form method="post" id="login_form" name="login_form">
	<input type="hidden" id="userId" name="userId" value="${result.USER_ID}">

<section id="container" class="sub member">
	<div class="container_inner">
	<!-- content -->
	
		<div class="inr-c ty2">
			<div class="titbox">
				<h2 class="h_tit1">나의 정보관리</h2>		
			</div>	
			<p class="mb10"> 나의 정보 변경을 위해서 비밀번호를 한번 더 입력해주세요. </p>
			<div class="wrap_table3">
				<table class="tbl" summary="패스워드를 재확인 하기 위한 입력입니다.">
					<caption>비밀번호 입력</caption>
					<colgroup>
						<col class="th1_1">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="col" id="th_g1">비밀번호</th>
							<td headers="th_g1"><input class="inp_txt wd1" type="password" name="password" id="password" title="비밀번호" placeholder="비밀번호" value=""></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btn-bot noline">
				<a href="#" class="btn-pk b mem2 rv" onclick="done(); return false;">확인</a>
				<a href="/main.do" class="btn-pk b mem3" >취소</a>
			</div>
		</div>
<!-- /content -->
	</div>
</section>
</form>