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
			<h1>
				이용안내
			</h1>
			<div class="pageDepth">
				HOME > 고객센터 > <strong>이용안내</strong>
			</div>
			<div class="clear">
			</div>
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
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">1:1문의</a></li>
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
							<span class="current">
							회원가입
							</span>
						</li>
						<li>
							<a href="/customer/service_order.jsp">주문/결제</a>
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
					</ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
			      <div class="marb50"><img src="/images/serimg_01_01.png" width="721" height="160"></div>
                  <dl class="regist">
                      <dt><h2>회원가입<br />전 안내</h2></dt>
                      <dd>
                          <ul class="bubblelist">
                              <li>
                              <span class="bubble">1</span>
                              <h4>풀무원 전체 통합 회원관리</h4>
                              <p>풀무원은 풀무원 관계사의 모든 유익한 정보를 고객님들께서 함께 공유하고 편리하게 이용하실 수 있도록 풀무원 전체 통합 회원관리를 이용하고 있습니다.</p>
                              </li>
                              <li>
                              <span class="bubble">2</span>
                              <h4>철저한 개인정보 보호 방침</h4>
                              <p>고객님들 개인의 정보는 동의 없이 공개되지 않으며, 풀무원의 다양한 웹사이트를 이용하는 과정에서 제공한 개인정보를 보호하기 위해 최선을 다하고 있습니다.</p>
                              </li>
                          </ul>
                      </dd>
                  </dl>
                  <dl class="regist">
                      <dt><h2>회원가입<br />방법</h2></dt>
                      <dd>
                          <div class="marb10"><img src="/images/serimg_01_02.png" width="559" height="127"></div>
                          <p class="list-star">만 14세 이상의 대한민국 국민이라면 누구나 풀무원 잇슬림 회원으로 가입하실 수 있습니다.</p>
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