<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<title>관제업무지원 시스템 &#124; 마이페이지 &#124; 비밀번호변경</title>

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
		pUrl = '/cjs/updatePass.do';
		
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
</head>

<form action="/main.do" method="post" id="form" name="form">
    <!-- content -->
    <div id="container">
        <div class="content_wrap">
            <h2 class="h2">비밀번호 변경</h2>
            <div class="content">
                <fieldset>
                    <legend>비밀번호 변경</legend>            
                    <div class="join_form pos_none">
                        <div class="pos_t0">
                            <span class="star1"><em class="hidden">필수</em></span> 표시는 필수입력 사항입니다.
                        </div>
                        <table class="write mt0" summary="현재 비밀번호, 새 비밀번호, 새비밀번호 확인으로 구성된 비밀번호 변경입니다.">
                            <caption>비밀번호 변경</caption>
                            <colgroup>
                                <col style="width:20%">
                                <col style="width:auto">                                
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="label1" class="star1">현재 비밀번호</label><span class="hidden">필수</span></th>
                                    <td>
                                        <input type="password" name="password_old" id="label1" maxLength="20">
                                        <span class="info_txt">현재 사용하고 있는 비밀번호 입력</span>                                            
                                    </td>
                                </tr>                                     
                                <tr>
                                    <th scope="row"><label for="label2" class="star1">새 비밀번호</label><span class="hidden">필수</span></th>
                                    <td>
                                        <input type="password" name="password"  id="label2" maxLength="20">
                                        <span class="info_txt">영문, 숫자, 특수문자 중 최소 2가지 이상 조합해서 입력(10자이상)</span>
                                    </td>
                                </tr> 
                                <tr>
                                    <th scope="row"><label for="label3" class="star1">새 비밀번호 확인</label><span class="hidden">필수</span></th>
                                    <td>
                                        <input type="password" name="password_re" id="label3" maxLength="20">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="tc mt50">
                        <a href="#" class="button bt1" onclick="done(); return false;">변경</a>
                        <a href="/main.do"" class="button bt1 gray">취소</a>
                    </div>
                </fieldset>
            </div>
            <div class="help_wrap">
                <div class="help_box">
                    <dl>
                        <dt>비밀번호 안전규칙</dt>
                        <dd>
                            <ul class="list01">
                                <li>반드시 10~20자의 영문 대/소문자, 숫자, 특수문자 중 2가지 이상으로 조합</li>
                                <li>아이디 및 아이디를 포함한 문자/숫자는 비밀번호로 사용 불가</li>
                                <li>특수문자는 !@#$%^&*()-_ 사용가능</li>
                                <li>동일한 문자(숫자), 연속적인 숫자 4자 이상 사용불가 예) 1234, 1111, aaaa</li>
                                <li>생년월일, 전화번호와 동일한 번호는 사용 자제</li>
                            </ul>
                        </dd>
                    </dl>
                </div>    
            </div>            
        </div>
    </div>
    <!-- /content -->
</form>