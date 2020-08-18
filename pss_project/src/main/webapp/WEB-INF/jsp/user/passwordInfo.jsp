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
});

function changeDomain(domainVal){
	$("#email_domain").val(domainVal);
}

function done() {
	var cMsg = "정보를 수정하시겠습니까?";

	//암호 el
	var oPwd = $("#label1");
	//암호 el
	var ePwd = $("#label2");
	//암호 재입력 el
	var eRePwd = $("#label3");

	if(!oPwd.val()){alert("현재 비밀번호는 필수입력 사항입니다."); oPwd.focus(); return;}

	if(!ePwd.val()){alert("새 비밀번호는 필수입력 사항입니다."); ePwd.focus(); return;}
	if(!pwdChk(ePwd.val())){ePwd.focus(); return;}
	if(!eRePwd.val()){alert("새 비밀번호 확인은 필수입력 사항입니다."); eRePwd.focus(); return;}
	if(ePwd.val() != eRePwd.val()){alert("비밀번호가 일치하지 않습니다."); ePwd.focus(); return;}

	if(confirm(cMsg)){
		pParam = {};
		pUrl = '/user/updatePass.do';
		
		pParam.password     = oPwd.val();
		pParam.password_new = ePwd.val();
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
				alert(data.message);
			if(data.updateStat == "Y") {
				document.form.action = "/main.do";
				document.form.submit();	 	
			} else {
				oPwd.focus();
			}
		}, function(jqXHR, textStatus, errorThrown){
				
		});
	}
}

</script>

<form method="post" id="form" name="form">
<section id="container" class="sub mypage">
    <!-- content -->
    <div id="container" class="container_inner">
    
        <div class="inr-c ty2">
			<div class="titbox">
				<h2 class="h_tit1">비밀번호 변경</h2>
				<p class="fz"><span class="c-red">* </span> 표시는 필수입력 사항입니다.</p>
			</div>
			
			<div class="wrap_table3">
				<table id="table-1" class="tbl" summary="현재 비밀번호, 새 비밀번호, 새 비밀번호 확인으로 구성된 비밀번호 변경입니다.">
					<caption>비밀번호변경 정보입력</caption>
					<colgroup>
						<col class="th1_1">
						<col>
					</colgroup>
					<tbody>
					    <tr>
					        <th scope="col" id="th_c1">현재 비밀번호<span class="c-red">*</span></th>
					        <td>
					            <input type="password" name="password_old" id="label1" maxLength="20"  title="현재 비밀번호 입력란" class="inp_txt wd1" >
					            <span class="fz_s1 c-red">현재 사용하고 있는 비밀번호 입력</span>                                            
					        </td>
					    </tr>
					    <tr>
					        <th scope="col" id="th_c1">새 비밀번호<span class="c-red">*</span></th>
					        <td>
					        	<div class="inp_pwd">
						            <input type="password" name="password"  id="label2" maxLength="20" class="inp_txt wd1" title="새 비밀번호 입력란">
						            <button type="button" class="btn_pw"><span class="i-set i_pw2">비밀번호보기</span></button>
					            </div>
					            <span class="fz_s1 c-red">영문, 숫자, 특수문자 중 최소 2가지 이상 조합해서 <br>입력(10자이상)</span>
					        </td>
					    </tr> 
					    <tr>
					        <th scope="col" id="th_d1">새 비밀번호 확인<span class="c-red">*</span></th>
					        <td>
					        	<div class="inp_pwd">
						            <input type="password" name="password_re" id="label3" maxLength="20" class="inp_txt wd1" title="새 비밀번호 입력란">
						            <button type="button" class="btn_pw"><span class="i-set i_pw2">비밀번호보기</span></button>
					            </div>
					            <span class="fz_s1 c-red">영문, 숫자, 특수문자 중 최소 2가지 이상 조합해서 <br>입력(10자이상)</span>
					        </td>
					    </tr>
					</tbody>
				</table>
			</div>
			
			<div class="btn-bot noline pr-mb1">
			    <a href="#" class="btn-pk b mem2 rv" onclick="done(); return false;">변경</a>
			    <a href="/main.do"" class="btn-pk b mem3 rv">취소</a>
			</div>
			
            <div class="box_loginfo">
            	<span class="i-set i_info1"></span>
                <div class="info">
					<p class="h_tit2">비밀번호 안전규칙</p>
                        <ul>
						<li>- 반드시 10~20자의 영문 대/소문자, 숫자, 특수문자 중 2가지 이상으로 조합</li>
						<li>- 아이디 및 아이디를 포함한 문자/숫자는 비밀번호로 사용 불가</li>
						<li>- 특수문자는 !@#$%^&*()-_ 사용가능</li>
						<li>- 동일한 문자(숫자), 연속적인 숫자 4자 이상 사용불가 예) 1234, 1111, aaaa</li>
						<li>- 생년월일, 전화번호와 동일한 번호는 사용 자제</li>
					</ul>
				</div>
            </div>            
        </div>
    </div>
    <!-- /content -->
</section>
</form>

<script>
// 눈표시 클릭 시 패스워드 보이기
$('.btn_pw').on('click',function(){
	var obj = $(this).prev('input')
	obj.toggleClass('active');
	if( obj.hasClass('active') == true ){
		$(this).find('.i-set').attr('class',"i-set i_pw1");
		obj.attr('type',"text").focus();
	} else{
		$(this).find('.i-set.i_pw1').attr('class',"i-set i_pw2");
		obj.attr('type','password').focus();
	}
});
</script>
