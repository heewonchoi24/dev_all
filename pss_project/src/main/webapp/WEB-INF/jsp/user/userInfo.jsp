<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	var pUrl, pParam;

	$(document).ready(function() {

		// 휴대전화 첫 자리 옵션 선택 시
		$(".selectMenu>li>a").on('click', function(e) {
			$("#label11").val($(this).attr('value'));
			e.preventDefault();
		});
		
	});

	function done() {
		var cMsg = "정보를 수정하시겠습니까?";

		//부서 el
		var ePart = $("#label5");
		//담당업무 val
		var vTask = $(".ickjs").map(function() {
			if (this.checked) {
				return this.value;
			}
		}).get().join(":");
		//직급 el
		var eRank = $("#label7");
		//직책 el
		var ePosition = $("#label8");

		//연락처 val
		var eTel1 = $("#label9"); //연락처(첫번째)
		var eTel2 = $("#label9_1"); //연락처(두번째)
		var eTel3 = $("#label9_2"); //연락처(세번째)
		//var vTel = $(".tel1").map(function(){return this.value;}).get().join("-");
		var vTel = eTel1.val() + "-" + eTel2.val() + "-" + eTel3.val();

		//내선번호 el
		var eExtel = $("#label10");

		//휴대폰번호 val
		var mTel1 = $("#label11"); //휴대폰번호(첫번째)
		var mTel2 = $("#label11_1"); //휴대폰번호(두번째)
		var mTel3 = $("#label11_2"); //휴대폰번호(세번째)
		//var vMobile = $(".mobile").map(function(){return this.value;}).get().join("-");
		var vMobile = mTel1.val() + "-" + mTel2.val() + "-" + mTel3.val();

		var vEmail = $("#label12").val(); // 이메일 val
		var regExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/; // 이메일 유효성 검사

		if (!ePart.val()) {
			alert("부서명은 필수입력 사항입니다.");
			ePart.focus();
			return;
		}
		if (!vTask) {
			alert("담당업무는 필수입력 사항입니다.");
			return;
		}
		if (isNaN(eTel2.val()	)){
			alert("연락처는 숫자로만 입력 바랍니다.");
			eTel2.focus();
			return;
		}
		if (!eTel2.val()) {
			alert("연락처는 필수입력 사항입니다.");
			eTel2.focus();
			return;
		}
		if (isNaN(eTel3.val()	)){
			alert("연락처는 숫자로만 입력 바랍니다.");
			eTel2.focus();
			return;
		}
		if (!eTel3.val()) {
			alert("연락처는 필수입력 사항입니다.");
			eTel3.focus();
			return;
		}
		if (isNaN(mTel2.val())){
			alert("휴대전화는 숫자로만 입력 바랍니다.");
			mTel2.focus();
			return;
		}
		if (!mTel2.val()) {
			alert("휴대전화는 필수입력 사항입니다.");
			mTel2.focus();
			return;
		}
		if (isNaN(mTel3.val())){
			alert("휴대전화는 숫자로만 입력 바랍니다.");
			mTel3.focus();
			return;
		}
		if (!mTel3.val()) {
			alert("휴대전화는 필수입력 사항입니다.");
			mTel3.focus();
			return;
		}
		if (!regExp.test(vEmail)) {
			alert("이메일 주소가 정확하지 않습니다.");
			return;
		}

		if (confirm(cMsg)) {
			pParam = {};
			pUrl = '/user/updateUser.do';

			pParam.dept = ePart.val();
			pParam.clsf = eRank.val();
			pParam.chrg_duty_cd = vTask;
			pParam.rspofc = ePosition.val();
			pParam.moblphon_no = vMobile;
			pParam.tel_no = vTel;
			pParam.lxtn_no = eExtel.val();
			pParam.email = vEmail;

			$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data,
					textStatus, jqXHR) {
				alert(data.message);
				document.form.action = "/main.do";
				document.form.submit();
			}, function(jqXHR, textStatus, errorThrown) {

			});
		}
	}

	function removeUser() {

		if (confirm("정말 탈퇴하시겠습니까?")) {
			pParam = {};
			pParam.user_ids = $("#user_id").val();

			$.ccmsvc.ajaxSyncRequestPost('/user/userDelete.do', pParam,
					function(data, textStatus, jqXHR) {
						alert(data.message);
					}, function(jqXHR, textStatus, errorThrown) {
					});
			$("#form").attr({
				method : "post",
				action : "/login/login.do"
			}).submit();
		}
	}
</script>

<form method="post" id="form" name="form">
	<input type="hidden" id="user_id" name="user_id"
		value="${result.USER_ID}">

	<section id="container" class="sub member">
		<!-- content -->
		<div id="container" class="container_inner">

			<div class="inr-c ty2">

				<div class="titbox">
					<h2 class="h_tit1">나의 정보관리</h2>
					<p class="fz">
						<span class="c-red">* </span> 표시는 필수입력 사항입니다.
					</p>
				</div>

				<div class="wrap_table3">
					<table id="table-1" class="tbl"
						summary="이름, 아이디, 기관명, 부서명, 직급, 직책, 연락처, 내선번호, 휴대전화, 이메일로 구성된 기본정보입력입니다.">
						<caption>회원가입 정보입력</caption>
						<colgroup>
							<col class="th1_1">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="col">이름</th>
								<td>${result.USER_NM}</td>
							</tr>
							<tr>
								<th scope="col">아이디</th>
								<td>${result.USER_ID}</td>
							</tr>
							<tr>
								<th scope="col">기관명</th>
								<td value="${result.INSTT_CD }"><c:forEach var="resultIn"
										items="${resultInstList}" varStatus="status">
										<c:if
											test="${fn:contains(result.INSTT_CD, resultIn.INSTT_CD)}">${resultIn.INSTT_NM }</c:if>
									</c:forEach></td>
							</tr>
							<tr>
								<th scope="col">부서명<span class="c-red">*</span></th>
								<td><input type="text" class="inp_txt wd1" id="label5"
									value="${result.DEPT}" maxLength="25"></td>
							</tr>
							<tr>
								<th scope="col" id="th_f1">담당업무<span class="c-red">*</span></th>
								<td>
									<c:forEach var="resultChrgDutyList" items="${resultChrgDutyList }" varStatus="status">
										<input class="ickjs" type="checkbox" id="chrg_duty_cd_${status.count }" value="${resultChrgDutyList.CODE }"
											<c:if test="${fn:contains(result.CHRG_DUTY_CD, resultChrgDutyList.CODE) }">checked="checkbox"</c:if> />
										<label for="chrg_duty_cd_${status.count }" class="mr30">${resultChrgDutyList.CODE_NM }</label>
									</c:forEach> <input type="hidden" id="chrg_duty_cd" name="chrg_duty_cd" value="" /></td>
							</tr>
							<tr>
								<th scope="col">직급</th>
								<td><input class="inp_txt wd1" type="text" id="label7" value="${result.CLSF}" maxLength="25"></td>
							</tr>
							<tr>
								<th scope="col">직책</th>
								<td><input class="inp_txt wd1" type="text" id="label8" value="${result.RSPOFC}" maxLength="25"></td>
							</tr>
							<tr>
								<th scope="col">연락처<span class="c-red">*</span></th>
								<td>
									<input type="text" class="inp_txt" id="label9" title="전화번호 앞 자리(국번)" value="${fn:split(result.TEL_NO,'-')[0] }" maxLength="4">
									<span class="fz_b1">-</span> 
									<input type="text" class="inp_txt" id="label9_1" title="전화번호 두 번째 자리" value="${fn:split(result.TEL_NO,'-')[1] }" maxLength="4">
									<span class="fz_b1">-</span> 
									<input type="text" class="inp_txt" id="label9_2" title="전화번호 끝 자리" value="${fn:split(result.TEL_NO,'-')[2] }" maxLength="4">
									<input type="hidden" name="tel_no" id="tel_no" value="">
								</td>
							</tr>
							<tr>
								<th scope="col">내선번호</th>
								<td colspan="3"><input class="inp_txt" type="text"
									id="label10" class="tel onlyNumber" value="${result.LXTN_NO}"
									maxLength="4"></td>
							</tr>
							<tr>
								<th scope="col">휴대전화<span class="c-red">*</span></th>
								<td>
									<div class="box-select-ty1 type1" title="휴대전화 첫 번째 입력란">
										<div class="selectVal" tabindex="0">
											<a href="#this" tabindex="-1">
												<c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '010') }">010</c:if>
												<c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '011') }">011</c:if>
												<c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '016') }">016</c:if>
												<c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '017') }">017</c:if>
												<c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '018') }">018</c:if>
												<c:if test="${fn:contains(fn:split(result.MOBLPHON_NO,'-')[0], '019') }">019</c:if>
											</a>
										</div>
										<ul class="selectMenu">
											<li><a href="#" value="010">010</a></li>
											<li><a href="#" value="011">011</a></li>
											<li><a href="#" value="016">016</a></li>
											<li><a href="#" value="017">017</a></li>
											<li><a href="#" value="018">018</a></li>
											<li><a href="#" value="019">019</a></li>
										</ul>
										<input type="hidden" id="label11" name="label11" value="010" />
									</div> 
									<span class="fz_b1">-</span>
									<input type="text" id="label11_1" class="inp_txt" title="휴대전화 두 번째 자리" value="${fn:split(result.MOBLPHON_NO,'-')[1]}" maxLength="4">
									<span class="fz_b1">-</span> 
									<input type="text" id="label11_2" class="inp_txt" title="휴대전화 끝 자리" value="${fn:split(result.MOBLPHON_NO,'-')[2]}" maxLength="4">
									<input type="hidden" name="moblphon_no" id="moblphon_no" value="">
								</td>
							</tr>
							<tr>
								<th scope="row">이메일<span class="c-red">*</span></th>
								<td><input class="inp_txt wd1" type="text" id="label12" title="이메일 입력란" value="${result.EMAIL}"></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-bot noline">
					<a href="#" class="btn-pk b mem2 rv" onclick="done(); return false;">수정</a> 
					<a href="/main.do" class="btn-pk b mem3 rv">취소</a> 
					<!-- <a href="#" class="button bt1 red" onclick="removeUser(); return false;">회원탈퇴</a> -->
				</div>
			</div>
		</div>
		<!-- /content -->
	</section>
</form>

<script>
	$('.ickjs').iCheck({
		checkboxClass : 'icheckbox_square3',
		radioClass : 'iradio_square3'
	});
</script>