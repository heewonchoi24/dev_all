<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script>
function modify(){
	$("#joinForm").attr({
		action : "/join/join02.do"
	}).submit();	
}

function goLogin(){
	$("#joinForm").attr({
		action : "/login/login.do"
	}).submit();	
}	
</script>

<section id="container" class="sub member">
   <div class="container_inner">
		<div class="inr-c ty2">
			<div class="mem_step1">
				<ul>
					<li>
						<span class="num">1</span>
						<div>
							<p class="t1">Step 01</p>
							<p class="t2">기본정보 입력</p>
						</div>
					</li>
					<li class="on">
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

			<div class="join_box1">
				<div class="inner">
					<c:choose>
            			<c:when test="${userStatus.STATUS_CD == 'SS01' }">
							<p class="h1">회원가입이 <span class="c-blue3">접수 완료</span>되었습니다. <br/>보건복지부 담당자가 확인 후 가입승인 여부를 통보해 드리겠습니다.<br/>회원가입 시 입력한 아이디/비밀번호로 로그인 하시면, 현재 가입 진행 상태를 확인하실수 있습니다.</p>
						</c:when>
						<c:when test="${userStatus.STATUS_CD == 'SS03' }">
							<p class="h1">회원가입이 <span class="c-blue3">반려</span>되었습니다.<br/>반려사유를 확인해 주시기 바랍니다.<br/>[반려사유 : ${userStatus.RETURN_RESN }]</p>
						</c:when>
            			<c:otherwise>
							<p class="h1">회원가입이 <span class="c-blue3">승인 진행중</span>입니다. <br>담당자가 확인 후 회원가입 완료 여부를 알려드리겠습니다.</p>
						</c:otherwise>
            		</c:choose>  
					<p class="t1">시스템 이용 문의 : 02-6360-6574 (내선번호 6574) / privacy@ssis.or.kr (※ 전화상담이 원할하지 않은 경우 이메일로 문의 바랍니다.)</p>
				</div>
			</div>

			<div class="btn-bot noline">
				<c:if test="${userStatus.STATUS_CD == 'SS03' }">
					<a href="#" onclick="modify(); return false;" class="btn-pk b mem2 rv">정보수정</a>
				</c:if>
				<a href="/login/login.do" class="btn-pk b mem2 rv">로그인 화면으로</a>
				<form id="joinForm" name="joinForm" method="post" action="/join/join03.do">
                	<input type="hidden" id="userId" name="userId" value="${userId }">
                </form>
			</div>


		</div>

   </div><!-- //container_inner -->
</section><!-- //container_main -->






























<%-- 



<body>
    <!-- header -->
    <div id="header_m">
        <h1><img src="/images/common/logo_black.png" alt="보건복지 개인정보보호 지원시스템"></h1>
    </div>
    <!-- /header -->
	
    <!-- content -->
    <div id="container_m">
        <h2>회원가입</h2>
        <div class="content_wrap">
            <div class="step_wrap">
                <span>수집이용 동의</span>
                <span>기본정보 입력</span>
                <span class="on">가입승인 대기</span>
                <span>가입 완료</span>
            </div>
            
            <div class="join_approval">
            	<c:choose>
            		<c:when test="${userStatus.STATUS_CD == 'SS01' }">
            			<div>
		                    <p>회원가입이 <strong>접수 완료</strong>되었습니다.</p>                
		                    <p>보건복지부 담당자가 확인 후 가입승인 여부를 통보해 드리겠습니다.</p>
		                    <p>회원가입 시 입력한 아이디/비밀번호로 로그인 하시면, 현재 가입 진행 상태를 확인하실수 있습니다.</p>
		                </div>
            		</c:when>
            		<c:when test="${userStatus.STATUS_CD == 'SS03' }">
            			<div>
		                    <p>회원가입이 <strong class="red">반려</strong>되었습니다.</p>                
		                    <p>반려사유를 확인해 주시기 바랍니다.</p>
		                    <p>[반려사유 : ${userStatus.RETURN_RESN }]</p>
		                </div>
            		</c:when>
            		<c:otherwise>
            			<div>
		                    <p>회원가입이 <strong>승인 진행중</strong>입니다.</p>
		                    <p>담당자가 확인 후 회원가입 완료 여부를 알려드리겠습니다.</p>
		                </div>
            		</c:otherwise>
            	</c:choose>              
            </div>
            
            <ul class="list01">
                <li>시스템 이용 문의 : 02-6360-6575 / privacy@ssis.or.kr (※ 전화상담이 원활하지 않은 경우 이메일로 문의 바랍니다.)</li>
            </ul>
            
            <div class="tc mt50">
            	<c:if test="${userStatus.STATUS_CD == 'SS03' }">
            		<a href="#" onclick="modify(); return false;" class="button bt1">정보수정</a>
            	</c:if>
                <a href="#" onclick="goLogin(); return false;" class="button bt1 gray">로그인 화면으로</a>
                <form id="joinForm" name="joinForm" method="post" action="/join/join03.do">
                	<input type="hidden" id="userId" name="userId" value="${userId }">
                </form>
            </div>              
        </div>
    </div>
    <!-- /content -->
</body> --%>