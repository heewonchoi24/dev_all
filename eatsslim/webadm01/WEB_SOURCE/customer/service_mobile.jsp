<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<div class="pageDepth">
				<span>HOME</span><span>고객센터</span><strong>이용안내</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li>
							<a href="/customer/notice.jsp">공지사항</a>
						</li>
						<li>
							<a href="/customer/faq.jsp">FAQ</a>
						</li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">1:1문의</a></li>
						<%} else {%>
						<li><a href="indiqna.jsp">1:1문의</a></li>
						<%}%>
						<li class="active">
							<a href="/customer/service_member.jsp">이용안내</a>
						</li>
						<li>
							<a href="/customer/presscenter.jsp">언론보도</a>
						</li>
					</ul>
					<div class="clear">
					</div>
				</div>
			</div>

			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<ul class="listSort">
						<li>
							<a href="/customer/service_member.jsp">회원가입</a>
						</li>
						<li>
							<a href="/customer/service_order.jsp">주문/결제</a>
						</li>
						<li>
							<a href="/customer/service_change.jsp">주문변경</a>
						</li>
						<li>
							<span class="current">알림톡 주문변경</span>
						</li>
						<li>
							<a href="/customer/service_recommand.jsp">취소/교환/환불</a>
						</li>
                        <li>
							<a href="/customer/service_coupon.jsp">쿠폰안내</a>
						</li>
                        <li>
							<a href="/customer/service_partnership.jsp">제휴안내</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
			  <!--
			  <div class="marb50"><img src="/images/serimg_03_01.png" width="100%"></div>-->
              <dl class="regist">
                  <dt><h2>카카오 알림톡<br/> 주문변경 방법</h2></dt>
                  <dd>
                      <ul class="bubblelist">
                          <li>
                          <span class="bubble">01</span>
                          <h4>잇슬림 카카오톡</h4>
                          <p>'풀무원 잇슬림' 카카오톡 플러스친구 추가 후, 잇슬림과의 1:1 대화창 하단 메뉴에서 배송일정, 배송지변경, 식단표는 물론 수시로 진행되는 다양한 이벤트 정보도 받아보세요.<br/ >
						  (풀무원 고객 기쁨센터 카카오톡과 연계하여, 카카오톡 앱 내에서 편리하게 변경하실 수 있습니다)</p>
						    <div class="mart10 marb10"><img src="/images/serimg_mobile_01.jpg" width="600" height="603"></div>
                          </li>
                          <li>
                              <span class="bubble">02</span>
                              <h4>풀무원 고객기쁨센터 카카오톡</h4>
                              <p>카카오톡 풀무원 고객센터에서도 배송 일정, 배송지 변경이 가능합니다. 관리받는 식단 잇슬림 외에도 풀무원 녹즙, 풀무원 베이비밀의 일일배달 제품 관련 주문 확인과 변경이 가능합니다. </p>
                            <div class="mart10 marb10"><img src="/images/serimg_mobile_02.jpg" width="600" height="603"></div>
                          </li>
                          <li>
                              <span class="bubble">03</span>
                              <h4>주문 변경 전, 체크!</h4>
                              <p>잇슬림은 주문 맞춤 생산으로 원하시는 날짜 3일 전까지 조정이 가능합니다.  추가 문의사항이 있으신 경우,  고객기쁨센터(080-800-0434) 또는 1:1상담 게시판을 통해 문의해주세요.</p>
                          </li>
                      </ul>
                  </dd>
              </dl>
			</div>
						</div>
			<!-- End row -->
		</div>
		<!-- End twelve columns offset-by-one -->
		<div class="sidebar four columns">
		   <%@ include file="/common/include/inc-sidecustomer.jsp"%>
		</div>
		<!-- End sidebar four columns -->
		<div class="clear"></div>
	</div>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div> <!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
</body>
</html>