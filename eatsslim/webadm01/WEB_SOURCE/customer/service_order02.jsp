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
							<span class="btn02"><a href="/customer/service_order01.jsp">가상계좌결제</a></span>
						</li>
                        <li>
							<span class="btn03"><a class="current" href="/customer/service_order02.jsp">실시간 계좌이체</a></span>
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
                  <dt><h2>실시간<br />계좌이체</h2></dt>
                  <dd>
                      <p class="marb20">별도의 서비스 가입절차나 프로그램 설치 없이 계좌번호, 계좌비밀번호, 주민번호만 입력하시면 결제가<br />실시간으로 이루어지는 결제방법입니다.</p>
                      <ul class="bubblelist">
                            <li>
                               <span class="bubble">01</span>
                               <h4>입금내역 확인</h4>
                               <p>실시간 계좌이체의 경우 주문/결제 후 10분 이내 입금내역이 확인됩니다.</p>
                            </li>
                            <li>
                               <span class="bubble">02</span>
                               <h4>출금내역</h4>
                               <p>고객님의 통장 출금내역에는 ㈜LG유플러스 가맹점으로 기재됩니다.</p>
                            </li>
                            <li>
                               <span class="bubble">03</span>
                               <h4>최소 입금 가능액</h4>
                               <p>실시간 계좌이체 최소 입금 가능액은 1,000원 입니다.</p>
                            </li>
                            <li>
                               <span class="bubble">04</span>
                               <h4>결제대행지불시스템</h4>
                               <p>잇슬림은 엘지유플러스 결제대행지불시스템을 이용하고 있으며, 지불 결제 경로에 따른 추가 확인은<br /> <a href="http://ecredit.uplus.co.kr" target="new">http://ecredit.uplus.co.kr</a>, 결제시스템 오류는 <a href="http://15446640.wo.to" target="new">http://15446640.wo.to</a> 사이트를 참고해 주십시요.</p>
                            </li>
                      </ul>
                  </dd>
                  </dl>
                  <div class="divider"></div>
                  <dl class="regist">
                      <dt><h2>이용가능<br />은행</h2></dt>
                      <dd><img src="/images/serimg_02_04.png" width="559" height="200"></dd>
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