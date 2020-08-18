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
							<span class="current">쿠폰안내</span>
						</li>
						<li>
							<a href="/customer/service_partnership.jsp">제휴안내</a>
						</li>
                        <div class="clear"></div>
					</ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
			  <!--
				   <div class="marb20"><img src="/images/img_coupon.png" width="823" height="183"></div> -->
                    <dl class="regist">
                      <dt><h2>쿠폰안내</h2></dt>
                      <dd>
                          <ul class="bubblelist">
                              <li>
                              <span class="bubble">1</span>
                              <h4>쿠폰 사용시 유의사항</h4>
                   <p>
                    고객님께 감사드리는 마음으로 잇슬림은 다양한 Event를 통하여 고객님께 많이 혜택과 편의를  드리기 위해 쿠폰을 지급해 드립니다.<br />
                    <br />
                    - 쿠폰은 잇슬림 사이트에서 판매되는 제품에만 적용되며, 가입회원 중 잇슬림에서 정한 대상자에 한하여 지급받을 수 있습니다.<br />
                    <br />
                    - 쿠폰은 구매시 혜택을 드리는 것으로 결제시에 사용할 수 있으며, 주문시에 적용 후 잔액이 남았더라도 1회 사용으로 자동 소멸됩니다.<br />
                    <br />
                    - 발급되는 쿠폰의 사용제한에 따라 실제 적용 가능한 상품이 제한적일 수 있으며, 이럴 경우 주문단계 적용 가능한 쿠폰리스트에서
                    보이지 않을 수 있습니다.쿠폰은 사용기간이 있으며, 기간 경과 후 자동 소멸됩니다.<br />
                    <br />
                    - 주문취소 및 반품을 할 경우 사용했던 쿠폰은 소멸되며, 재발행 되지 않습니다. 단, 주문 시 사용 실수에 의해 소멸되었거나, 시스템상 오류로 인해 소멸된 경우에는 고객기쁨센터(080-800-0434)로 문의주시면, 확인 후 재발급 가능합니다.<br />
                       <br />
                    - 사용가능한 쿠폰은 '로그인 후 > 마이페이지'에서 확인하실 수 있으며, 주문시 적용가능한 쿠폰이 자동으로 적용되어 보여집니다.<br />
                    <br />
                    - 오프라인 쿠폰(인증번호)는 '로그인 후 > 마이페이지 > 쿠폰 더보기 > 쿠폰등록' 또는, 주문단계에서 등록 후 사용하실 수 있습니다.<br />
                    <br />
                    </p>
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