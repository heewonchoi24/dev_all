<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<section id="container" class="sub member">

<form name="join_form" id="join_form" method="post" action="/join/join02.do">
	<input type="hidden" id="agree1" name="agree1" value="Y">

   <div class="container_inner">
		
		<div class="inr-c ty2">
			<div class="mem_step1">
				<ul>
					<li class="on">
						<span class="num">1</span>
						<div>
							<p class="t1">Step 01</p>
							<p class="t2">수집이용 동의</p>
						</div>
					</li>
					<li>
						<span class="num">2</span>
						<div>
							<p class="t1">Step 02</p>
							<p class="t2">기본정보 입력</p>
						</div>
					</li>
					<li>
						<span class="num">3</span>
						<div>
							<p class="t1">Step 03</p>
							<p class="t2">가입승인 대기</p>
						</div>
					</li>
					<li>
						<span class="num">4</span>
						<div>
							<p class="t1">Step 04</p>
							<p class="t2">가입완료</p>
						</div>
					</li>
				</ul>
			</div>

			<section class="area_terms">
				<h2 class="h_tit1">개인정보 수집이용 동의</h2>

				<div class="box">
					<p><strong>수집 · 이용목적</strong></p>
					<p class="mb20">보건복지 개인정보보호지원시스템 이용자 관리</p>

					<p><strong>항목</strong></p>
					<p class="mb20">필수항목 : 이름, 아이디, 비밀번호, 기관명, 부서명, 담당업무, 연락처, 휴대전화, 이메일
					<br>선택항목 : 직급, 직책, 내선번호</p>

					<p class="mb20"><strong>보유 및 이용기간</strong> : 3년</p>

					<p><strong>동의 거부 및 불이익</strong></p>
					<p class="mb20">개인정보 수집·이용에 대하여 동의를 거부할 권리가 있습니다. 단, 동의를 거부할 경우 보건복지 개인정보보호 지원시스템 이용이 어렵습니다.
					<br>보건복지 개인정보보호 지원시스템은 사전 승인된 이용자에 한하여 회원가입이 가능합니다.</p>

					<p><strong>개인정보의 제3자 제공에 관한 사항</strong></p>
					<p>보건복지 개인정보지원시스템은 정보주체의 동의, 법률의 특별한 규정 등 "개인정보보호법" 제17조(개인정보의 제공) 및 제18조(개인정보의 이용·제공 제한)에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.
					<br>현재, 보건복지 개인정보보호지원시스템은 제3자에게 제공하는 개인정보가 없습니다.
					<br>다만, 다음과 같은 경우에는 정보주체 또는 제3자의 이익을 부당하게 침해할 우려가 있을 때를 제외하고는 이용자의 개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공할 수 있습니다.
					<br>정보주체로부터 별도의 동의를 받은 경우
					<br>법률에 특별한 규정이 있거나 법령상 의무를 준수하기 위하여 불가피한 경우
					<br>정보주체 또는 그 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우
					<br>통계작성 및 학술연구 등의 목저을 위하여 필요한 경우로서 특정 개인을 알아볼수 없는 형태로 개인정보를 제공하는 경우
					<br>개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공하지 아니하면 다른 법률에서 정하는 소관업무를 수행할 수 없는 경우로서 보호위원회의 심의·의결을 거친 경우</p>
				</div>

				<div class="agree">
					<input type="checkbox" id="checkbox0101" class="ickjs">
					<label for="checkbox0101">이용약관에 동의합니다.</label>
				</div>
			</section>			

			<div class="ta-c">
				<a href="#" class="btn-pk b mem2 rv" onclick="done(); return false;">다음</a>
			</div>
		</div>

   </div><!-- //container_inner -->
   
</form>
</section><!-- //container_main -->

<script>
$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square2',
	radioClass: 'iradio_square2'
});

function done(){
	if($("input:checkbox[id=checkbox0101]" ).prop("checked")) {
		$("#join_form").submit();
	} else {
		alert("이용약관에 동의해주세요.");
		return false;
	}
}

</script>

