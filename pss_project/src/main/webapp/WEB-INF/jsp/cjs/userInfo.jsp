<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<title>관제업무지원 시스템 &#124; 마이페이지 &#124; 나의정보</title>

<script>
var pUrl, pParam;

$(document).ready(function(){
	$("#label13").change(function(){
		changeDomain(this.value);
	});
	fn_numberInit();
});

function changeDomain(domainVal){
	$("#email_domain").val(domainVal);
}

function done() {
	var cMsg = "정보를 수정하시겠습니까?";

	//부서 el
	var ePart = $("#label5");
// 	//담당업무 val
// 	var vTask = $(".chrg_duty_cd").map(function(){if(this.checked){return this.value;}}).get().join(":");
	//직급 el
	var eRank = $("#label7");
	//직책 el
	var ePosition = $("#label8");
	//연락처 val
	var vTel = $(".tel1").map(function(){return this.value;}).get().join("-");
	//연락처(첫번째) el
	var eTel2 = $("#label9_1");
	//연락처(두번째) el
	var eTel3 = $("#label9_2");
	//내선번호 el
	var eExtel = $("#label10");
	//휴대폰번호(첫번째) el
	var mTel2 = $("#label11_1");
	//휴대폰번호(첫번째) el
	var mTel3 = $("#label11_2");
	//휴대폰번호 val
	var vMobile = $(".mobile").map(function(){return this.value;}).get().join("-");
	//이메일 val
	if($("#label12").val() && $("#email_domain").val()){
		var vEmail = $("#label12").val() + "@" + $("#email_domain").val();	
	}else{
		var vEmail = "";
	}
	
	if(!ePart.val()){alert("부서명은 필수입력 사항입니다."); ePart.focus(); return;}

	if(!eTel2.val()){alert("연락처는 필수입력 사항입니다."); eTel2.focus(); return;}
	if(!eTel3.val()){alert("연락처는 필수입력 사항입니다."); eTel3.focus(); return;}
	if(vEmail){if(!emailRegExp.test(vEmail)){alert("이메일 주소가 정확하지 않습니다."); return;}}
	
	if(confirm(cMsg)){
		pParam = {};
		pUrl = '/cjs/updateUser.do';
		
		pParam.dept   = ePart.val();
		pParam.clsf   = eRank.val();
		pParam.rspofc = ePosition.val();
		pParam.moblphon_no  = vMobile;
		pParam.tel_no       = vTel;
		pParam.lxtn_no      = eExtel.val();
		pParam.email        = vEmail;
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
			alert(data.message);
		}, function(jqXHR, textStatus, errorThrown){
				
		});
	}
}

function removeUser(){

	if(confirm("정말 탈퇴하시겠습니까?")){
		pParam = {};
		pParam.user_ids = $("#user_id").val();
		
		$.ccmsvc.ajaxSyncRequestPost(
				'/user/userDelete.do',
				pParam,
				function(data, textStatus, jqXHR){
					alert(data.message);
				}, 
				function(jqXHR, textStatus, errorThrown){
				});
		$("#form").attr({
			method : "post",
			action : "/login/login.do"
		}).submit();
	}
}

</script>
</head>

<form action="/cjs/userInfo.do" method="post" id="form" name="form">
	<input type="hidden" id="user_id" name="user_id" value="${result.USER_ID}">
    <!-- content -->
    <div id="container">
        <div class="content_wrap">
            <h2 class="h2">나의 정보관리</h2>
            <div class="content">
                    <fieldset>
                        <legend>나의 정보관리</legend>            
                        <div class="join_form pos_none">
                            <div class="pos_t0">
                                <span class="star1"><em class="hidden">필수</em></span> 표시는 필수입력 사항입니다.
                            </div>
                            <table class="write mt0" summary="이름, 아이디, 기관명, 부서명, 직급, 직책, 연락처, 내선번호, 휴대전화, 이메일로 구성된 나의 정보등록입니다.">
                                <caption>나의 정보등록</caption>
                                <colgroup>
                                    <col style="width:15%">
                                    <col style="width:35%">
                                    <col style="width:15%">
                                    <col style="width:auto">                                
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row"><label for="label0" >이름</label></th>
                                        <td colspan="3">${result.USER_NM}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="label1" >아이디</label></th>
                                        <td colspan="3">${result.USER_ID}</td>
                                    </tr> 
                                    <tr>
                                        <th scope="row"><label for="label4" >기관명</label></th>
                                        <td colspan="3" value="${result.INSTT_CD }">
                                       		<c:forEach var="resultIn" items="${resultInstList}" varStatus="status">
                                       			 <c:if test="${fn:contains(result.INSTT_CD, resultIn.INSTT_CD)}">${resultIn.INSTT_NM }</c:if>
                                       		</c:forEach>
                                       	</td>
                                    </tr> 
                                    <tr>
                                        <th scope="row"><label for="label5" class="star1">부서명</label><span class="hidden">필수</span></th>
                                        <td colspan="3"><input type="text" id="label5"  value="${result.DEPT}" maxLength="25"></td>
                                    </tr>
<!--                                     <tr> -->
<!--                                         <th scope="row"><label for="label6" class="star1">담당업무</label><span class="hidden">필수</span></th> -->
<!--                                     <td colspan="3"> -->
<%-- 										<c:forEach var="resultCo" items="${resultChrgDutyList }" varStatus="status"> --%>
<%-- 											&nbsp;<input type="checkbox" id="chrg_duty_cd_${status.count }" class="chrg_duty_cd" value="${resultCo.CODE }" <c:if test="${fn:contains(result.CHRG_DUTY_CD, resultCo.CODE) }">checked</c:if>/>&nbsp;&nbsp;<label for="chrg_duty_cd_${status.count }">${resultCo.CODE_NM }</label> --%>
<%-- 										</c:forEach> --%>
<!-- 										<input type="hidden" id="chrg_duty_cd" name="chrg_duty_cd" value=""/> -->
<!--                                     </td> -->
<!--                                     </tr>  -->
                                    <tr>
                                        <th scope="row"><label for="label7">직급</label></th>
                                        <td><input type="text" id="label7" value="${result.CLSF}" maxLength="25"></td>
                                        <th scope="row"><label for="label8">직책</label></th>
                                        <td><input type="text" id="label8" value="${result.RSPOFC}" maxLength="25"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="label9" class="star1">연락처</label><span class="hidden">필수</span></th>
                                        <td colspan="3">
<!--                                             <select class="tel1" id="label9" title="전화번호 앞 자리(국번)"> -->
<%--                                             <option value="02" <c:if test="${fn:contains(fn:split(result.TEL_NO,'-')[0], '02') }">selected</c:if>>서울(02)</option> --%>
<%--                                             <option value="031" <c:if test="${fn:contains(fn:split(result.TEL_NO,'-')[0], '031') }">selected</c:if>>경기(031)</option> --%>
<!--                                             </select><span class="hipun">-</span> -->
											<input type="text" id="label9"   class="tel tel1 onlyNumber" title="전화번호 앞 자리(국번)" value="${fn:split(result.TEL_NO,'-')[0] }" maxLength="4"><span class="hipun">-</span>                                            
                                            <input type="text" id="label9_1" class="tel tel1 onlyNumber" title="전화번호 두번 째 자리" value="${fn:split(result.TEL_NO,'-')[1] }" maxLength="4"><span class="hipun">-</span>
                                            <input type="text" id="label9_2" class="tel tel1 onlyNumber" title="전화번호 끝 자리" value="${fn:split(result.TEL_NO,'-')[2] }" maxLength="4">
											<input type="hidden" name="tel_no" id="tel_no" value="">
                                        </td>
                                    </tr> 
                                    <tr>
                                        <th scope="row"><label for="label10">내선번호</label></th>
                                        <td colspan="3"><input type="text" id="label10" class="tel" value="${result.LXTN_NO}" maxLength="4"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="label11">휴대전화</label></th>
                                        <td colspan="3">
                                            <select id="label11" class="mobile" title="휴대전화 앞 자리(국번)">
                                            <option value="010" <c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '010') }">selected</c:if>>010</option>
                                            <option value="011" <c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '011') }">selected</c:if>>011</option>
                                            <option value="016" <c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '016') }">selected</c:if>>016</option>
                                            <option value="017" <c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '017') }">selected</c:if>>017</option>
                                            <option value="018" <c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '018') }">selected</c:if>>018</option>
                                            <option value="019" <c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '019') }">selected</c:if>>019</option>
                                            </select><span class="hipun">-</span>
                                            <input type="text" id="label11_1" class="tel mobile onlyNumber" title="휴대전화 두번 째 자리" value="${fn:split(result.MOBLPHON_NO,'-')[1]}" maxLength="4"><span class="hipun">-</span>
                                            <input type="text" id="label11_2" class="tel mobile onlyNumber" title="휴대전화 끝 자리" value="${fn:split(result.MOBLPHON_NO,'-')[2]}" maxLength="4">
                                        	<input type="hidden" name="moblphon_no" id="moblphon_no" value="">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="label12">이메일</label></th>
                                        <td colspan="3">
                                            <input type="text" id="label12" title="이메일주소" value="${fn:split(result.EMAIL,'@')[0]}" maxLength="25"><span class="hipun">@</span>
                                            <input type="text" id="email_domain"  title="이메일 도메인"  value="${fn:split(result.EMAIL,'@')[1]}" maxLength="25">
<!--                                             <select title="이메일 도메인 선택" id="label13"> -->
<!--                                                 <option value="">직접입력</option> -->
<!--                                                 <option value="hotmail.com">hotmail.com</option> -->
<!--                                             </select> -->
                                            <input type="hidden" id="email" name="email">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="tc mt50">
                            <a href="#" class="button bt1" onclick="done(); return false;">수정</a>
                            <a href="#" class="button bt1 red" onclick="removeUser(); return false;">회원탈퇴</a>
                            <a href="/cjs/intrcnRegist.do" class="button bt1 gray" >취소</a>
                        </div>
                    </fieldset>
            </div>
        </div>
    </div>
    <!-- /content -->
</form>