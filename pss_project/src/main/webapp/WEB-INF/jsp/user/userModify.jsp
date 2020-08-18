<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>.ipt,select.ipt{width: 215px;} .fz_s1 {display: inline-block;vertical-align: middle;margin-left: 10px;font-size: 13px;line-height: 1.3;} #return_resn_area{margin-top: 10px;}</style>
<script>
var pUrl, pParam, isModify;
var bChk = false;

$(document).ready(function(){
	fn_numberInit();
	isModify = $("#isModify").val();
	
	$("input[name=confm_yn]").change(function(){
		var v = $(this).prop("checked", true).val();
		if(v == 'Y'){
			$("#return_resn_area").css("display", "none");
			$("#status_cd").val("SS02");
			$("#return_resn").val("");
		}else if(v == 'N'){
			$("#return_resn_area").css("display", "");
			$("#status_cd").val("SS03");
		}
	});
	
	if($("#status_cd").val() == 'SS01') $("#status_cd").val('SS02'); 
	
	$("#author_id").on("change", function(){
		if($(this).val() == '1' || $(this).val() == '4'){
			$("#chrg_duty_cd_area").hide();
		}else{
			$("#chrg_duty_cd_area").show();
		}
	});
})

function cancle() {
	$("#form").attr({
		method : "post",
		action : "/admin/user/userList.do"
	}).submit();
}

function validate(){
	return true;
}

function done(){
	var cMsg = ((isModify==="Y") ? "정보를 수정하시겠습니까?" : "사용자를 등록하시겠습니까?");
	var vConfmYn = $("input[name=confm_yn]:checked").val();
	var vAuthorId = $("#author_id").val();
	var eName = $("#label0"); //이름 el
	var eId = $("#label1"); //아이디 el
	var ePwd = $("#label2"); //암호 el
	var eRePwd = $("#label3"); //암호 재입력 el
	var eInst = $("#label4"); //기관 el
	var ePart = $("#label5"); //부서 el
	var vTask = $(".chrg_duty_cd").map(function(){if(this.checked){return this.value;}}).get().join(":"); //담당업무 val
	var eRank = $("#label7"); //직급 el
	var ePosition = $("#label8"); //직책 el
	var eTel1 = $("#label9_1"); //연락처(첫번째) el
	var eTel2 = $("#label9_2"); //연락처(두번째) el
	var eTel3 = $("#label9_3"); //연락처(세번째) el
	var vTel = $(".tel1").map(function(){return this.value;}).get().join("-"); //연락처 val
	var eExtel = $("#label10"); //내선번호 el
	var mTel2 = $("#label11_1"); //휴대폰번호(첫번째) el
	var mTel3 = $("#label11_2"); //휴대폰번호(두번째) el
	var vMobile = $(".mobile").map(function(){return this.value;}).get().join("-"); //휴대폰번호 val
	var eEmail1 = $("#label12"); //이메일(첫번째) el
	var eEmail2 = $("#email_domain"); //이메일(두번째) el
	if($("#label12").val() && $("#email_domain").val()){var vEmail = $("#label12").val() + "@" + $("#email_domain").val();}else{var vEmail = "";}//이메일 val
	
	
	if(vConfmYn === undefined){alert("승인여부는 필수선택 사항입니다."); $("#label6_1").focus(); return;}
	if(isModify != "Y"){
		if(!eName.val()){alert("이름은 필수입력 사항입니다."); eName.focus(); return;}
		if(!eId.val()){alert("아이디는 필수입력 사항입니다."); eId.focus(); return;}	
		if(!idChk(eId.val())){eId.focus(); return;}
		if(!bChk){alert("아이디 입력 후 중복확인 버튼을 눌러주시기 바랍니다."); return;}
		if(!ePwd.val()){alert("비밀번호는 필수입력 사항입니다."); ePwd.focus(); return;}
		if(!pwdChk(ePwd.val())){ePwd.focus(); return;}
		if(!eRePwd.val()){alert("암호2는 필수입력 사항입니다."); eRePwd.focus(); return;}
		if(ePwd.val() != eRePwd.val()){alert("비밀번호가 일치하지 않습니다."); ePwd.focus(); return;}
	}
	if(!eInst.val()){alert("기관명은 필수선택 사항입니다."); eInst.focus(); return;}
	if(!ePart.val()){alert("부서명은 필수입력 사항입니다."); ePart.focus(); return;}
	if(vAuthorId == "") {alert("권한설명은 필수선택 사항입니다."); return;}
	if(!(vAuthorId == '1' || vAuthorId == '4')){
		if(!vTask){alert("담당업무는 필수선택 사항입니다."); return;}	
	}
	if(!eTel1.val()){alert("연락처는 필수입력 사항입니다."); eTel1.focus(); return;}
	if(!eTel2.val()){alert("연락처는 필수입력 사항입니다."); eTel2.focus(); return;}
	if(!eTel3.val()){alert("연락처는 필수입력 사항입니다."); eTel3.focus(); return;}
	if(!mTel2.val()){alert("휴대전화는 필수입력 사항입니다."); mTel2.focus(); return;}
	if(!mTel3.val()){alert("휴대전화는 필수입력 사항입니다."); mTel3.focus(); return;}
	if(!eEmail1.val()){alert("이메일은 필수입력 사항입니다."); eEmail1.focus(); return;}
	if(!eEmail2.val()){alert("이메일은 필수입력 사항입니다."); eEmail2.focus(); return;}
	if(vEmail){if(!emailRegExp.test(vEmail)){alert("이메일 주소가 정확하지 않습니다."); return;}}
	if(vConfmYn == 'N'){
		if($("#return_resn").val() == "" || $("#return_resn").val() == null){
			alert("반려시 반려사유는 필수입력 사항입니다.");
			return false;
		}
	} 
	if(confirm(cMsg)){
		
		if(vConfmYn == 'Y') $("#return_resn").val("&nbsp;");
		
		$("#tel_no").val(vTel);
		$("#moblphon_no").val(vMobile);
		$("#email").val(vEmail);
		
		if(!(vAuthorId == '1' || vAuthorId == '4')) $("#chrg_duty_cd").val(vTask);
		else $("#chrg_duty_cd").val('');
		
		$.ccmsvc.ajaxSyncRequestPost(
				'/admin/user/userInfoModify.do',
				$("#form").serializeArray(),
				function(data, textStatus, jqXHR){
					if(data.isModify == 'Y') alert("수정이 완료되었습니다. 사용자 목록으로 이동합니다.");
					else alert("등록이 완료되었습니다. 사용자 목록으로 이동합니다."); 
					$("#form").attr({
						method : "post",
						action : "/admin/user/userList.do"
					}).submit();
				}, 
				function(jqXHR, textStatus, errorThrown){
				});	
	}
}

function idDupChk(){
	$(".idExplain").css("display", "none");
	pUrl = "/join/idDupChk.do";
	pParam = {};
	pParam.user_id = $("#label1").val();
	
	var idReg = /^[a-zA-Z]+[a-zA-Z0-9]{5,19}$/g;
	
	if (!pParam.user_id) {
		alert("아이디는 필수입력 사항입니다.");
		return;
	}
	
	if(!idReg.test($("#label1").val())) {
		alert("아이디는 영문자로 시작하는 6~12자 영문자 또는 숫자이여야 합니다.");
		return;
	}
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		if(data.cntId==0){
			$("#idChkFail").hide();
			$("#idChkPass").show();
			bChk = true;
		}else{
			$("#idChkPass").hide();
			$("#idChkFail").show();
		}
		return bChk;
	}, function(jqXHR, textStatus, errorThrown){
		
	});
	
	
}

function resetPassword(){
	
	pParam = {};
	pParam.userId = $("#user_id").val();
	
	if(confirm("비밀번호를 이메일주소로 초기화 하시겠습니까?")){
		$.ccmsvc.ajaxSyncRequestPost(
				'/admin/user/resetPassword.do',
				pParam,
				function(data, textStatus, jqXHR){
					alert(data.message);
					$(".info_txt").text("새 비밀번호 : " + data.newPassword);
				}, 
				function(jqXHR, textStatus, errorThrown){
				});	
	}
}


function removeUser(){

	if(confirm("정말 탈퇴하시겠습니까?")){
		pParam = {};
		pParam.user_ids = $("#user_id").val();
		
		$.ccmsvc.ajaxSyncRequestPost(
				'/admin/user/userDelete.do',
				pParam,
				function(data, textStatus, jqXHR){
					alert(data.message);
				}, 
				function(jqXHR, textStatus, errorThrown){
				});
		$("#form").attr({
			method : "post",
			action : "/admin/user/userList.do"
		}).submit();
	}
}

</script>

<form action="/admin/user/userModify.do" method="post" id="form" name="form" onsubmit="return validate();">
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }"/>
	<input type="hidden" name="isModify" id="isModify" value="${isModify }"/>
	<input type="hidden" name="status_cd" id="status_cd" value="${user.STATUS_CD}"/>
	 
	<!-- main -->
	<div id="main">
	    <div class="group">
	        <div class="header">
	            <h3>사용자 등록/수정</h3>
	        </div>
	        <div class="body">
	           <table class="board_list_write">
	                <tbody>
	                    <tr>
	                        <th class="req">사용자 승인</th>
	                        <td colspan="3">
	                            <input type="radio" id="label6_1" name="confm_yn" class="custom" value="Y" <c:if test="${user.CONFM_YN == 'Y' || user.STATUS_CD == 'SS01'}">checked</c:if>/>
	                            <label for="label6_1">승인</label>
	                            <input type="radio" id="label6_2" name="confm_yn" class="custom" value="N" <c:if test="${user.CONFM_YN == 'N' && user.STATUS_CD != 'SS01'}">checked</c:if>/>
	                            <label for="label6_2">반려</label>
	                            <!-- 반려 체크 시 노출 -->
								<div class="mt10" id="return_resn_area" <c:if test="${user.CONFM_YN != 'N' or user.STATUS_CD == 'SS01'}">style="display: none;"</c:if>>
									<label for="" ><strong style="margin-right: 10px;">반려사유</strong></label>
									<input type="text" id="return_resn" name="return_resn" class="ipt" value="${user.RETURN_RESN }">
								</div>
								<!-- /반려 체크 시 노출 -->
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="req">권한설명</th>
	                        <td colspan="3">
	                           <select id="author_id" name="author_id" class="ipt">
	                           		<option value="">선택해주세요.</option>
									<c:forEach var="i" items="${authorList}" varStatus="status">
										<c:if test="${'5' ne i.authorId}">
											<option value="${i.authorId}" <c:if test="${i.authorId == user.AUTHOR_ID}">selected</c:if>>${i.authorNm}
											</option>
										</c:if>
								   </c:forEach>
	                           </select>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="req">이름</th>
	                        <c:choose>
								<c:when test="${isModify == 'Y'}">
									<td colspan="3">${user.USER_NM}</td>
								</c:when>
								<c:otherwise>
									<td colspan="3"><input name="user_nm" type="text" class="ipt" id="label0"></td>
								</c:otherwise>
							</c:choose>
	                    </tr>
	                    <tr>
	                        <th class="req">아이디</th>
	                        <c:choose>
								<c:when test="${isModify == 'Y' }">
									<td colspan="3">${user.USER_ID }</td>
									<input type="hidden" id="user_id" name="user_id" value="${user.USER_ID }"/>
								</c:when>
								<c:otherwise>
									<td colspan="3">
										<input type="text" name="user_id" id="label1" class="ipt" >
										<a href="javascript:idDupChk();" class="btn black">중복확인</a>
										<span class="info_txt fz_s1 c-red idExplain" > 영문 소문자, 숫자로 입력(6~12자)</span>
                                        <span id="idChkPass" class="id_search fz_s1 c-red" style="display: none;">사용 가능한 아이디입니다.</span>
                                        <span id="idChkFail" class="id_search fz_s1 c-red" style="display: none;">사용 중인 아이디입니다.</span>
									</td>
								</c:otherwise>
							</c:choose>
	                    </tr>
	                    <c:choose>
							<c:when test="${isModify == 'Y'}">
								<tr>
									<th>비밀번호 초기화</th>
									<td colspan="3">
										<a href="javascript:resetPassword();" class="btn black">초기화</a> <span style="color: #999; padding-left: 10px;">*이메일 주소로 초기화 됩니다.</span>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
                                    <th class="req">비밀번호</th>
                                    <td colspan="3">
                                        <input type="password" name="password" id="label2" class="ipt" >
                                        <span class="fz_s1 c-red">영문, 숫자, 특수문자 중 최소 2가지 이상 조합해서 입력(10자이상)</span>
                                    </td>
                                </tr> 
                                <tr>
                                    <th class="req">비밀번호 확인</th>
                                    <td colspan="3">
                                        <input type="password" name="password_re" id="label3" class="ipt" >
                                    </td>
                                </tr>
							</c:otherwise>
						</c:choose>
	                    <tr id="insttRow">
	                        <th class="req">기관명</th>
	                        <td colspan="3">
	                            <select class="ipt" style="width: 241px;" id="label4" name="instt_cd">
									<option value="">선택해주세요.</option>
									<c:forEach var="i" items="${instList}" varStatus="status">
										<option value="${i.INSTT_CD }" <c:if test="${fn:contains(user.INSTT_CD, i.INSTT_CD)}">selected</c:if>>${i.INSTT_NM }</option>
									</c:forEach>
								</select>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="req">부서명</th>
	                        <td colspan="3">
	                            <input type="text" name="dept" id="label5" class="ipt" style="width: 300px;" value="${user.DEPT}" maxLength="25">
	                        </td>
	                    </tr>
	                    <tr id="chrg_duty_cd_area" <c:if test="${user.AUTHOR_ID == '1' || user.AUTHOR_ID == '4'}"> style="display: none;"</c:if>>
							<th class="req">담당업무</th>
							<td colspan="3">
								<c:forEach var="i" items="${chrgDutyList }" varStatus="status">
									<input type="checkbox" id="chrg_duty_cd_${status.count }" class="chrg_duty_cd custom" value="${i.CODE }" <c:if test="${fn:contains(user.CHRG_DUTY_CD, i.CODE) }">checked</c:if>/>
									<label for="chrg_duty_cd_${status.count }">${i.CODE_NM }</label>								</c:forEach>
							<input type="hidden" id="chrg_duty_cd" name="chrg_duty_cd" value=""/>
							</td>
						</tr>
	                    <tr>
	                        <th>직급</th>
	                        <td>
	                            <input type="text" name="clsf" id="label7" class="ipt" value="${user.CLSF }" maxLength="25">
	                        </td>
	                        <th>직책</th>
	                        <td>
	                            <input type="text" name="rspofc" id="label8" class="ipt" value="${user.RSPOFC }" maxLength="25">
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="req">연락처</th>
	                        <td>
	                            <input type="text" id="label9_1" class="ipt tel tel1 onlyNumber" title="전화번호 첫번째 자리" maxlength="4" value="${fn:split(user.TEL_NO,'-')[0] }">
                                <span class="hipun">-</span>
                                <input type="text" id="label9_2" class="ipt tel tel1 onlyNumber" title="전화번호 두번째 자리" maxlength="4" value="${fn:split(user.TEL_NO,'-')[1] }">
                                <span class="hipun">-</span>
                                <input type="text" id="label9_3" class="ipt tel tel1 onlyNumber" title="전화번호 끝 자리" maxlength="4" value="${fn:split(user.TEL_NO,'-')[2] }">
                                <input type="hidden" name="tel_no" id="tel_no" value="">
	                        </td>
	                        <th>내선번호</th>
	                        <td>
	                            <input type="text" name="lxtn_no" id="label10" class="ipt tel onlyNumber" maxlength="4" value="${user.LXTN_NO }">
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="req">휴대전화</th>
	                        <td>
	                            <select id="label11" class="ipt tel mobile onlyNumber" title="휴대전화 앞 자리(국번)" style="width: 214px;">
									<option value="010" <c:if test="${fn:contains(fn:split(user.MOBLPHON_NO,'-')[0], '010') }">selected</c:if>>010</option>
									<option value="011" <c:if test="${fn:contains(fn:split(user.MOBLPHON_NO,'-')[0], '011') }">selected</c:if>>011</option>
									<option value="016" <c:if test="${fn:contains(fn:split(user.MOBLPHON_NO,'-')[0], '016') }">selected</c:if>>016</option>
									<option value="017" <c:if test="${fn:contains(fn:split(user.MOBLPHON_NO,'-')[0], '017') }">selected</c:if>>017</option>
									<option value="018" <c:if test="${fn:contains(fn:split(user.MOBLPHON_NO,'-')[0], '018') }">selected</c:if>>018</option>
									<option value="019" <c:if test="${fn:contains(fn:split(user.MOBLPHON_NO,'-')[0], '019') }">selected</c:if>>019</option>
								</select>
								<span class="hipun">-</span>
								<input type="text" id="label11_1" class="ipt tel mobile onlyNumber" title="휴대전화 두번 째 자리" maxlength="4" value="${fn:split(user.MOBLPHON_NO,'-')[1] }">
								<span class="hipun">-</span>
								<input type="text" id="label11_2" class="ipt tel mobile onlyNumber" title="휴대전화 끝 자리" maxlength="4" value="${fn:split(user.MOBLPHON_NO,'-')[2] }">
								<input type="hidden" name="moblphon_no" id="moblphon_no" value="">
	                        </td>
	                        <th class="req">이메일</th>
	                        <td>
	                            <input type="text" class="ipt" id="label12" title="이메일주소" maxlength="25" value="${fn:split(user.EMAIL, '@')[0] }">
								<span class="hipun">@</span>
								<input type="text" class="ipt" id="email_domain" title="이메일 도메인" maxlength="25" value="${fn:split(user.EMAIL, '@')[1] }">
								<input type="hidden" id="email" name="email">
	                        </td>
	                    </tr>
	                </tbody>
	           </table>
	           <div class="board_list_btn right">
	           		<c:if test="${isModify == 'Y'}">
	                	<a href="#" onclick="removeUser(); return false;" class="btn gray">탈퇴처리</a>
	                </c:if>
	                <a href="#" onclick="cancle(); return false;" class="btn black">목록으로</a>
	                <a href="#" onclick="done(); return false;" class="btn blue">저장</a>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- main -->	 

</form>