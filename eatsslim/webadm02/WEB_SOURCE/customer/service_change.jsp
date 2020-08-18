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
							<a href="/customer/service_member.jsp">회원가입</a>
						</li>
						<li>
							<a href="/customer/service_order.jsp">주문/결제</a>
						</li>
						<li>
							<span class="current">주문변경</span>
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
			  <div class="marb50"><img src="/images/serimg_03_01.png" width="721" height="160"></div>
              <dl class="regist">
                  <dt><h2>변경가능<br />일정</h2></dt>
                  <dd>
                      <ul class="bubblelist">
                          <li>
                          <span class="bubble">01</span>
                          <h4>배송지 변경</h4>
                          <p>택배 제품의 경우에는 제품이 발송되기 전 결제완료 단계에서만 변경이 가능합니다.<br />일배 제품의 경우 배송변경 희망일로 부터 최소 3일(주말 및 공휴일인 포함된경우는 5일이전)전까지<br />변경이 가능합니다.</p>
                          </li>
                          <li>
                              <span class="bubble">02</span>
                              <h4>배달일정 변경</h4>
                              <p>배송하고자 하는 날짜로부터 최소 3일 전까지 취소, 연기 관련해 변경 가능합니다. <br />잇슬림은 주문과 동시에 식재료가 구매되고 조리되어, 신선하게 배송되는 시스템으로, 접수일 기준 3일 후부터 배송일 취소 및 연기가 가능하시며, 
							  그 외 접수일 기준 1~2일 후 제품은 이미 주문 및 생산 작업이 진행되고 있어, 별도 취소/환불 등이 불가한 점 양해부탁드립니다.  또한, 주문생산 시스템으로 인해 배송일을 앞당기는 부분은 수정 접수일로부터 6일 이후부터 가능하십니다. <br />잇슬림 홈페이지 '마이잇슬림' 배송일변경을 통해 직접 조정하시거나 1:1 게시판을 통해 문의하세요.</p>
                              <div class="bg-gray mart10 marb10" style="padding:15px;">
                                  <h5>잇슬림 홈페이지에서 주문한 경우</h5>
                                  <p>
                                  1) 마이잇슬림 > 주문배송조회 > 배송일자변경 버튼을 클릭하여 직접 변경해주세요.<br />
                                  2) 고객기쁨센터(080-022-0085) 또는 1:1상담 게시판을 통해 문의해주세요.
                                  </p>
                                  <div class="divider"></div>
                                  <h5>외부몰에서 주문한 경우</h5>
                                  <p>
                                  고객기쁨센터(080-022-0085) 또는 1:1상담 게시판을 통해 문의해주세요. 
                                  </p>
                              </div>
                          </li>
                      </ul>
                  </dd> 
              </dl>
              <dl class="regist">
                  <dt><h2>주문변경<br />프로세스</h2></dt>
                  <dd><div class="marb10"><img src="/images/serimg_03_02.png" width="558" height="160"></div></dd>
              </dl>
              <div class="divider"></div>
              <dl class="regist">
                  <dt><h2>공휴일배송</h2></dt>
                  <dd><p>주말 및 공휴일은 별도 배송이 없습니다.<br/>공휴일 배송 건은 영업일 기준으로 마지막 배송일 뒷 날짜에 +1로 자동 지정됩니다.</p></dd>
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