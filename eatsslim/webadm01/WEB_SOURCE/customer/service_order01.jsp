<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>

	<script type="text/javascript" src="/common/js/datefield.js"></script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<div class="pageDepth">
				<span>홈</span><span>고객센터</span><strong>이용안내</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li>
							<a href="notice.jsp">공지사항</a>
						</li>
						<li>
							<a href="faq.jsp">FAQ</a>
						</li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">1:1문의</a></li>
						<%} else {%>
						<li><a href="indiqna.jsp">1:1문의</a></li>
						<%}%>
						<li class="active">
							<a href="service_member.jsp">이용안내</a>
						</li>
						<li>
							<a href="presscenter.jsp">언론보도</a>
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
							<span class="current">주문/결재</span>
						</li>
						<li>
							<a href="/customer/service_change.jsp">주문변경</a>
						</li>
						<li>
							<a href="/customer/service_recommand.jsp">취소/교환/환불</a>
						</li>
                        <li>
							<a href="/customer/service_coupon.jsp">쿠폰사용</a>
						</li>
                        <div class="clear"></div>
					</ul>
                    <div class="divider"></div>
                    <ul class="subimgSort marb20">
                        <li>
                            <span class="btn01"><a href="/customer/service_order.jsp">주문프로세스</a></span>
                        </li>
                        <li>
							<span class="btn02"><a class="current" href="/customer/service_order01.jsp">가상계좌결제</a></span>
						</li>
                        <li>
							<span class="btn03"><a href="/customer/service_order02.jsp">실시간 계좌이체</a></span>
						</li>
                        <li>
							<span class="btn04"><a href="/customer/service_order03.jsp">신용카드결제</a></span>
						</li>
                        <li class="last">
							<span class="btn05"><a href="/customer/service_order04.jsp">공인인증서</a></span>
						</li>
                        <div class="clear"></div>
                    </ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
                <dl class="regist">
                  <dt><h2>가상계좌</h2></dt>
                  <dd>
                      <p class="marb20" style="letter-spacing:-1px;">고객님의 편리를 위하여 무통장 입금하시는 고객님께 가상전용계좌(1인 1구좌)를 부여해 드리고 있습니다.<br />부여된 전용계좌로 상품금액을 입금해주시면 주문이 완료됩니다.</p>
                      <ul class="bubblelist">
                            <li>
                               <span class="bubble">01</span>
                               <h4>가상계좌 입금</h4>
                               <p>입금시 입금자와 입금액이 동일해야 결제가 가능하며 예금주는 풀무원건강생활㈜ 서울지점 입니다.</p>
                            </li>
                            <li>
                               <span class="bubble">02</span>
                               <h4>입금확인</h4>
                               <p>입금 후 20분내로 입금확인이 완료되지 않을 경우 고객센터(080-022-0085)로 연락주시기 바랍니다.</p>
                            </li>
                            <li>
                               <span class="bubble">03</span>
                               <h4>입금기간</h4>
                               <p>일배(배달점 일일 배달) 상품은 주문 당일, 택배상품은 주문후 7일이내 입금이 진행되지 않을 경우 주문은 자동취소됩니다. (SMS로 통보드립니다.)</p>
                            </li>
                            <li>
                               <span class="bubble">04</span>
                               <h4>무통장 입금 오류발생</h4>
                               <p>무통장 입금 시 오류 발생의 대부분은 전용계좌번호 및 입금금액이 다른 경우에 발생할 때가 많습니다.<br />입금 오류일 경우 마이페이지 > 주문내역에서 입금계좌번호, 입금액을 확인 후 재시도 부탁드립니다.</p>
                            </li>
                            <li>
                               <span class="bubble">05</span>
                               <h4>결제대행지불시스템</h4>
                              <p>잇슬림은 엘지유플러스 결제대행지불시스템을 이용하고 있으며, 지불 결제 경로에 따른 추가 확인은<br />
                               <a href="http://ecredit.uplus.co.kr" target="new">http://ecredit.uplus.co.kr</a>, 결제시스템 오류는 <a href="http://15446640.wo.to" target="new">http://15446640.wo.to</a> 사이트를 참고해 주십시요.</p>
                            </li>
                      </ul>
                  </dd>
                  </dl>
                  <div class="divider"></div>
                  <dl class="regist">
                      <dt><h2>이용가능<br />은행</h2></dt>
                      <dd><img src="/images/serimg_02_03.png" width="559" height="300"></dd>
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