<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

	<title>로그인</title>
</head>
<body>
	<div class="pop-wrap">
		<div class="headpop">
		    <h2>로그인</h2>
			<p>주문하기 및 결제를 계속 진행하기 위해서는 풀무원 통합회원 로그인이 필요합니다.</p>
		</div>
	    <div class="contentpop">
		    <div class="popup columns offset-by-one"> 
					<div class="row">
					   <div class="one last col center">
					      <p class="mart30 marb20">풀무원 통합회원 로그인 페이지로 이동하시겠습니까?</p>
                          <div class="button white small"><a href="/sso/single_sso.jsp">예 ></a></div>
                          <div class="button white small"><a href="javascript:;" onclick="$.lightbox().close();">아니오 ></a></div>
                          <div class="divider"></div>
                          <p>풀무원 통합회원 아이디가 없으신 분은<br />풀무원 통합회원에 가입 하셔야 주문하기 및 결제를 계속 진행하실 수 있습니다.</p>
					   </div>
					</div>
					<!-- End row -->  
					<div class="row">
						<div class="one last col center">
							<div class="button small dark"><a href="https://member.pulmuone.co.kr/customer/register_R1.jsp?siteno=0002400000">풀무원 회원가입</a></div>
						</div>
					</div>
					<!-- End row -->
			  </div>
			  <!-- End popup columns offset-by-one -->	
		</div>
		<!-- End contentpop -->
	</div>
</body>
</html>