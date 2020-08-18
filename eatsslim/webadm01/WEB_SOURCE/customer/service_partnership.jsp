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
							<a href="/customer/service_mobile.jsp">알림톡 주문변경</a>
						</li>
						<li>
							<a href="/customer/service_recommand.jsp">취소/교환/환불</a>
						</li>
                        <li>
							<a href="/customer/service_coupon.jsp">쿠폰안내</a>
						</li>
					 <li>
							<span class="current">제휴안내</span>
						</li>
					</ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
			  <!--
			      <div class="marb50"><img src="/images/partnership01.png" width="100%"></div> -->
                  <dl class="regist">
                      <dt><h2>마케팅</br>/제휴/광고</h2></dt>
                      <dd>
                          <ul class="bubblelist">
                              <li>
                              <span class="bubble">1</span>
                              <h4>관련 사항</h4>
                              <p>풀무원 잇슬림 온/오프라인 제휴 문의 <br/> 온라인 광고 문의 및 제안 <br/> 이벤트, 프로모션 관련 제안<br/>신규 사업, 신제품 제안 <br/>기타 마케팅/제휴/광고 관련 문의 등은<br/>아래 담당자의 이메일 주소로 문의바랍니다.</p>
                              </li>
							    <li>
                              <span class="bubble">2</span>
                              <h4>마케팅/제휴/광고 담당자</h4>
							  <p>yhkime@pulmuone.com </p>
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