<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script src="/js/jquery.form.js" type="text/javascript"></script>
<script>
var pUrl, pParam, isModify;
var bChk = false;

$(document).ready(function(){
	fn_numberInit();
	isModify = $("#isModify").val();
});
function insertVal(target, value){
	$(target).val(value);
}
function fn_numberInit() {
	$(".onlyNumber").keyup(function() {
		this.value = this.value.replace(/[^0-9]/g,'');
	});
	$(".onlyNumber2").keyup(function() {
		this.value = this.value.replace(/[^0-9.]/g,'');
	});
}
function done() {

	var cMsg = ((isModify == 'Y') ? "정보를 수정하시겠습니까?" : "가입하시겠습니까?");
	var eName = $("#label0"); //이름 el
	var eId = $("#label1"); //아이디 el
	var ePwd = $("#label2"); //암호 el
	var eRePwd = $("#label3"); //암호 재입력 el
	var eInst = $("#label4"); //기관 el
	var ePart = $("#label5"); //부서 el
	var vTask = $(".chrg_duty_cd").map(function() {
		if (this.checked) {
			return this.value;
		}
	}).get().join(":"); //담당업무 val
	var eRank = $("#label7"); //직급 el
	var ePosition = $("#label8"); //직책 el
	var eTel1 = $("#label9_1"); //연락처(첫번째) el
	var eTel2 = $("#label9_2"); //연락처(두번째) el
	var eTel3 = $("#label9_3"); //연락처(세번째) el
	var vTel = $(".tel1").map(function() {
		return this.value;
	}).get().join("-"); 
	//연락처 val
	var eExtel = $("#label10"); //내선번호 el
	var mTel2 = $("#label11_1"); //휴대폰번호(첫번째) el
	var mTel3 = $("#label11_2"); //휴대폰번호(두번째) el
	var vMobile = $(".mobile").map(function() {
		return this.value;
	}).get().join("-"); //휴대폰번호 val
	var eEmail = $("#email");

	var vEmail = $("#email").val();
	if (isModify != 'Y') {
		if (!eName.val()) {
			alert("이름은 필수입력 사항입니다.");
			eName.focus();
			return;
		}
		if (!eId.val()) {
			alert("아이디는 필수입력 사항입니다.");
			eId.focus();
			return;
		}
		if (!idChk(eId.val())) {
			eId.focus();
			return;
		}
		if (!bChk) {
			alert("아이디 입력 후 중복확인 버튼을 눌러주시기 바랍니다.");
			return;
		}
	}

	if (!ePwd.val()) {
		alert("비밀번호는 필수입력 사항입니다.");
		ePwd.focus();
		return;
	}
	if (!pwdChk(ePwd.val())) {
		ePwd.focus();
		return;
	}
	if (!eRePwd.val()) {
		alert("비밀번호 재입력은 필수입력 사항입니다.");
		eRePwd.focus();
		return;
	}
	if (ePwd.val() != eRePwd.val()) {
		alert("비밀번호가 일치하지 않습니다.");
		ePwd.focus();
		return;
	}
	if (!eInst.val()) {
		alert("기관명은 필수입력 사항입니다.");
		eInst.focus();
		return;
	}
	if (!ePart.val()) {
		alert("부서명은 필수입력 사항입니다.");
		ePart.focus();
		return;
	}
	if (!vTask) {
		alert("담당업무는 필수입력 사항입니다.");
		return;
	}
	if (!eTel1.val()) {
		alert("연락처는 필수입력 사항입니다.");
		eTel1.focus();
		return;
	}
	if (!eTel2.val()) {
		alert("연락처는 필수입력 사항입니다.");
		eTel2.focus();
		return;
	}
	if (!eTel3.val()) {
		alert("연락처는 필수입력 사항입니다.");
		eTel3.focus();
		return;
	}
	if (!mTel2.val()) {
		alert("휴대전화는 필수입력 사항입니다.");
		mTel2.focus();
		return;
	}
	if (!mTel3.val()) {
		alert("휴대전화는 필수입력 사항입니다.");
		mTel3.focus();
		return;
	}
	if (!eEmail.val()) {
		alert("이메일은 필수입력 사항입니다.");
		eEmail.focus();
		return;
	}
	if (vEmail) {
		if (!emailRegExp.test(vEmail)) {
			alert("이메일 주소가 정확하지 않습니다.");
			return;
		}
	}

/* 	var cntUser = 0;
	pUrl = "/join/joinCertChk.do";
	pParam = {};
	pParam.user_nm = eName.val();
	pParam.email = vEmail;
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR) {
		cntUser = data.cntUser;
		if (cntUser == 11) {
			alert("공문을 통해 신청된 사용자만 회원가입이 가능합니다. 관리자에게 문의하세요.");
		} else if(cntUser != 0) {
			alert("이미 등록된 사용자 입니다.");
		}
	}, function(jqXHR, textStatus, errorThrown) {
		
	});

	if (cntUser != 0) {
		return;
	} */
	if($(".tempId").val() != $(".joinId").val() && isModify != 'Y'){
		alert("아이디 입력 후 중복확인 버튼을 눌러주시기 바랍니다.");
		$(".joinId").focus();
		return;
	}
	if (confirm(cMsg)) {

		$("#tel_no").val(vTel);
		$("#moblphon_no").val(vMobile);
		$("#email").val(vEmail);
		$("#chrg_duty_cd").val(vTask);
	
		$("#join_form").attr("action", "/join/join.do");
		
		var options = {
			success : function(data){
				alert(data.message);
		 		//document.join_form.action = "/join/join03.do";
		 		document.join_form.action = data.url;
		 		document.join_form.submit();
			},
			type : "POST"
		};
		
		$("#join_form").ajaxSubmit(options);
		
// 		document.join_form.action = "/join/join.do";
// 		document.join_form.submit();
	}
}

function idDupChk() {
	
	pUrl = "/join/idDupChk.do";
	pParam = {};
	pParam.user_id = $("#label1").val();
	
	var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
	$(".tempId").val($(".joinId").val());
	if (!pParam.user_id) {
		alert("아이디는 필수입력 사항입니다.");
		return;
	}
	
	if(!idReg.test($("#label1").val())) {
		alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이여야 합니다.");
		return;
	}
	
	$(".idExplain").css("display", "none");
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus,
			jqXHR) {
		if (data.cntId == 0) {
			$("#idChkFail").hide();
			$("#idChkPass").show();
			bChk = true;
		} else {
			$("#idChkPass").hide();
			$("#idChkFail").show();
		}
	}, function(jqXHR, textStatus, errorThrown) {});

	return bChk;
}
</script>


<section id="container" class="sub member">
   <div class="container_inner">
		<div class="inr-c ty2">
			<div class="mem_step1">
				<ul>
					<li class="on">
						<span class="num">1</span>
						<div>
							<p class="t1">Step 01</p>
							<p class="t2">기본정보 입력</p>
						</div>
					</li>
					<li>
						<span class="num">2</span>
						<div>
							<p class="t1">Step 02</p>
							<p class="t2">가입승인 대기</p>
						</div>
					</li>
					<li>
						<span class="num">3</span>
						<div>
							<p class="t1">Step 03</p>
							<p class="t2">가입완료</p>
						</div>
					</li>
				</ul>
			</div>

			<div class="titbox">
				<h2 class="h_tit1">개인정보 수집이용 동의</h2>
				<p class="fz"><span class="c-red">* </span> 표시는 필수입력 사항입니다.</p>
			</div>

			<form name="join_form" id="join_form" method="post">
			<input type="hidden" id="isModify" name="isModify" value="${isModify}">
			
			<div class="wrap_table3">
				<table id="table-1" class="tbl" summary="이름, 아이디, 비밀번호, 비밀번호 확인, 기관명, 부서명, 담당업무, 직급, 직책, 연락처, 내선번호, 휴대전화, 이메일로 구성된 기본정보 등록입니다.">
					<caption>회원가입 정보입력</caption>
					<colgroup>
						<col class="th1_1">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="col" id="th_a1">이름<span class="c-red">*</span></th>
							<td headers="th_a1">
								<c:choose>
                               		<c:when test="${isModify == 'Y'}">
                               			${resultUserInfo.USER_NM}
                               			<input type="hidden" class="inp_txt wd1" name="user_nm" id="label0" value="${resultUserInfo.USER_NM}">
                               		</c:when>
                               		<c:otherwise>
                               			<input type="text" class="inp_txt wd1" name="user_nm" id="label0" maxLength="10">
                               		</c:otherwise>
                               	</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="col" id="th_b1">아이디<span class="c-red">*</span></th>
							<td headers="th_b1">
								<c:choose>
                               		<c:when test="${isModify == 'Y'}">
                               			${resultUserInfo.USER_ID}
                               			<input type="hidden" class="inp_txt wd3" name="user_id" id="label1" value="${resultUserInfo.USER_ID}">
                               		</c:when>
                               		<c:otherwise>
                               			<input type="text" class="inp_txt wd3 joinId" name="user_id" id="label1" maxLength="20">
                               			<button type="button" class="btn-pk gray rv n" onclick="idDupChk(); return false;">중복체크</button>
                               			<span class="fz_s1 c-red idExplain">영문, 소문자, 숫자로 입력(6-20자)</span>
                               		</c:otherwise>
                               	</c:choose>
                               	<input type="hidden" class="tempId">
								<span id="idChkPass" class="id_search fz_s1 c-red" style="display: none;">사용 가능한 아이디입니다.</span>
                                <span id="idChkFail" class="id_search fz_s1 c-red" style="display: none;">사용 중인 아이디입니다.</span>
							</td>
						</tr>
						<tr>
							<th scope="col" id="th_c1">비밀번호<span class="c-red">*</span></th>
							<td headers="th_c1">
								<div class="inp_pwd">
									<input type="password" class="inp_txt wd1" title="비밀번호 입력란" name="password" id="label2" maxLength="20">
									<button type="button" class="btn_pw"><span class="i-set i_pw2">비밀번호보기</span></button>
								</div>
								<span class="fz_s1 c-red">영문, 숫자, 특수문자 중 최소 2가지 이상 조합해서 <br>입력(10자이상)</span>
							</td>
						</tr>
						<tr>
							<th scope="col" id="th_d1">비밀번호 재입력<span class="c-red">*</span></th>
							<td headers="th_d1">
								<div class="inp_pwd">
									<input type="password" class="inp_txt wd1" title="비밀번호 재입력란" name="password_re" id="label3">
									<button type="button" class="btn_pw"><span class="i-set i_pw2">비밀번호보기</span></button>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="col" id="th_e1">기관명<span class="c-red">*</span></th>
							<td headers="th_e1">
								<div class="box-select-ty1 type1" style="min-width: 280px;">
									<div class="selectVal" tabindex="0">
										<c:choose>
											<c:when test="${isModify == 'Y' }">
												<a href="#this" tabindex="-1" value="${resultUserInfo.INSTT_CD}">${resultUserInfo.INSTT_NM}</a>
											</c:when>
											<c:otherwise>
												<a href="#this" tabindex="-1">선택해주세요.</a>
											</c:otherwise>
										</c:choose>
									</div>
									<ul class="selectMenu" style="height: 350px !important; overflow: auto !important;">
										<c:forEach var="result" items="${resultInstList}" varStatus="status">
											<li><a href="javascript:void(0); onclick=insertVal('#label4', '${result.INSTT_CD}');" value="${result.INSTT_CD}">${result.INSTT_NM}</a></li>
										</c:forEach>
										<input type="hidden" id="label4" name="instt_cd" <c:if test="${isModify == 'Y' }">value="${resultUserInfo.INSTT_CD}"</c:if>>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="col" id="th_e2">부서명<span class="c-red">*</span></th>
							<td headers="th_e2"><input type="text" class="inp_txt wd1" title="부서명 입력란" name="dept" id="label5" value="${resultUserInfo.DEPT }" maxLength="25"></td>
						</tr>
						<tr>
							<th scope="col" id="th_f1">담당업무<span class="c-red">*</span></th>
							<td headers="th_f1">
								<c:forEach var="result" items="${resultChrgDutyList }" varStatus="status">
									<c:choose>
										<c:when test="${status.count % 2 == 0}">
											<input type="checkbox" id="chrg_duty_cd_${status.count }" class="ickjs chrg_duty_cd" value="${result.CODE }" <c:if test="${fn:contains(resultUserInfo.CHRG_DUTY_CD, result.CODE) }">checked</c:if>/><label for="chrg_duty_cd_${status.count }" class="mr30">${result.CODE_NM }</label>
										</c:when>
										<c:otherwise>
											<input type="checkbox" id="chrg_duty_cd_${status.count }" class="ickjs chrg_duty_cd" value="${result.CODE }" <c:if test="${fn:contains(resultUserInfo.CHRG_DUTY_CD, result.CODE) }">checked</c:if>/><label for="chrg_duty_cd_${status.count }" class="mr30">${result.CODE_NM }</label>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<input type="hidden" id="chrg_duty_cd" name="chrg_duty_cd" value=""/>
							</td>
						</tr>
						<tr>
							<th scope="col" id="th_g1">직급</th>
							<td headers="th_g1"><input type="text" class="inp_txt wd1" title="직급 입력란" name="clsf" id="label7" value="${resultUserInfo.CLSF }" maxLength="25"></td>
						</tr>
						<tr>
							<th scope="col" id="th_h1">직책</th>
							<td headers="th_h1"><input type="text" class="inp_txt wd1" title="직책 입력란" name="rspofc" id="label8" value="${resultUserInfo.RSPOFC }" maxLength="25"></td>
						</tr>
						<tr>
							<th scope="col" id="th_i1">연락처<span class="c-red">*</span></th>
							<td headers="th_i1">
								<input type="text" class="inp_txt tel1 onlyNumber" title="연락처 첫번째 입력란" id="label9_1" value="${fn:split(resultUserInfo.TEL_NO,'-')[0] }" maxLength="4">
								<span class="fz_b1">-</span>
								<input type="text" class="inp_txt tel1 onlyNumber" title="연락처 중간 입력란" id="label9_2" value="${fn:split(resultUserInfo.TEL_NO,'-')[1] }" maxLength="4">
								<span class="fz_b1">-</span>
								<input type="text" class="inp_txt tel1 onlyNumber" title="연락처 마지막 입력란" id="label9_3" value="${fn:split(resultUserInfo.TEL_NO,'-')[2] }" maxLength="4">
								<input type="hidden" name="tel_no" id="tel_no" value="">
							</td>
						</tr>
						<tr>
							<th scope="col" id="th_j1">내선번호</th>
							<td headers="th_j1"><input type="text" class="inp_txt wd2 onlyNumber" title="내선번호 입력란" name="lxtn_no" id="label10" value="${resultUserInfo.LXTN_NO }" maxLength="4"></td>
						</tr>
						<tr>
							<th scope="col" id="th_k1">휴대전화<span class="c-red">*</span></th>
							<td headers="th_k1">
								<div class="box-select-ty1 type1" title="휴대전화 첫번째 입력란">
									<div class="selectVal" tabindex="0">
										<a href="#this" tabindex="-1" id="selLa11">
											<c:choose>
												<c:when test="${isModify == 'Y' }">${fn:split(resultUserInfo.MOBLPHON_NO,'-')[0]}</c:when>
												<c:otherwise>010</c:otherwise>
											</c:choose>
										</a>
									</div>
									<ul class="selectMenu">
										<li><a href="javascript:void(0); onclick=insertVal('#label11', '010')">010</a></li>
										<li><a href="javascript:void(0); onclick=insertVal('#label11', '011')">011</a></li>
										<li><a href="javascript:void(0); onclick=insertVal('#label11', '016')">016</a></li>
										<li><a href="javascript:void(0); onclick=insertVal('#label11', '017')">017</a></li>
										<li><a href="javascript:void(0); onclick=insertVal('#label11', '018')">018</a></li>
										<li><a href="javascript:void(0); onclick=insertVal('#label11', '019')">019</a></li>
									</ul>
									<input type="hidden" id="label11" class="mobile" <c:choose><c:when test="${isModify == 'Y' }">value="${fn:split(resultUserInfo.MOBLPHON_NO,'-')[0]}"</c:when><c:otherwise>value="010"</c:otherwise></c:choose>>
								</div>
								<span class="fz_b1">-</span>
								<input type="text" id="label11_1" class="inp_txt mobile onlyNumber" title="휴대전화 중간 입력란" value="${fn:split(resultUserInfo.MOBLPHON_NO,'-')[1] }" maxLength="4">
								<span class="fz_b1">-</span>
								<input type="text" id="label11_2" class="inp_txt mobile onlyNumber" title="휴대전화 마지막 입력란" value="${fn:split(resultUserInfo.MOBLPHON_NO,'-')[2] }" maxLength="4">
								<input type="hidden" name="moblphon_no" id="moblphon_no" value="">
							</td>
						</tr>
						<tr>
							<th scope="col" id="th_l1">이메일<span class="c-red">*</span></th>
							<td headers="th_l1">
								<input type="text" class="inp_txt wd1" title="이메일 입력란" id="email" name="email" value="${resultUserInfo.EMAIL }">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>

			<div class="btn-bot noline">
				<a class="btn-pk b mem2 rv" onclick="done(); return false;">
				<c:choose>
					<c:when test="${isModify == 'Y' }">수정</c:when>
					<c:otherwise>입력완료</c:otherwise>
				</c:choose>
				</a>
				<a href="/login/login.do" class="btn-pk b mem3 rv">취소</a>
			</div>
		</div>
   </div><!-- //container_inner -->
</section><!-- //container_main -->

<script>
$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square3',
	radioClass: 'iradio_square3'
});

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