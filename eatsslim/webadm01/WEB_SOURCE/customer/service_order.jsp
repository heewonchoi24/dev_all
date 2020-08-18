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
							<span class="current">주문/결제</span>
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
							<a href="/customer/service_partnership.jsp">제휴안내</a>
						</li>
                        <div class="clear"></div>
					</ul>
                    <div class="divider"></div>
                    <ul class="subimgSort marb20">
                        <li>
                            <span class="btn01"><a class="current" href="/customer/service_order.jsp">주문프로세스</a></span>
                        </li>
                        <li>
							<span class="btn02"><a href="/customer/service_order01.jsp">가상계좌결제</a></span>
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
			     <ul class="bubblelist">
                   <li>
                       <span class="bubble">01</span>
                       <h4>주문안내 확인</h4>
                       <p>상품의 종류와 기능을 확인하신 후 주문하실 제품을 선택해주세요.</p>
                    </li>
                    <li>
                       <span class="bubble">02</span>
                       <h4>배달가능지역 확인</h4>
                       <p>일일배달 상품(칼로리 조절 식사, 칼로리 조절 프로그램, 건강식)의 경우 고객님의 지역에서 가까운 대리점을 통하여 매일 냉장<br />
                         배달되고 있습니다. 일일배달 상품을 주문하실 경우 배달가능 지역인지 꼭 확인 후 주문해주세요.</p>
                    </li>
                    <li>
                       <span class="bubble">03</span>
                       <h4>배송기간 선택</h4>
                       <p>선택하신 상품에 따른 식단표와 고객님이 가능하신 일정에 따라 제품별 상세페이지 확인 후, 배송 요일 및 기간(일/ 주)과 제품 수량을 선택해주세요.<br /><p>
                       <p>* 일요일은 배달이 없습니다.<br />
                    </li>
        
                    <li>
                       <span class="bubble">04</span>
                       <h4>첫 배달일 지정</h4>
                       <p>일배배달의 경우 식재료 구매부터 배달까지 총 3일이 소요되며, 접수일 기준 3일 이후 일정부터 선택 가능합니다.<br />
                       택배배달의 경우 배달일 지정은 불가능하며, 결제완료 이후 2~5일후에 상품을 수령하실 수 있습니다.</p>
                    </li>
            <!--        <li>
                       <span class="bubble">05</span>
                       <h4>보냉가방주문</h4>
                       <p>일일배달 상품은 냉장상태로 배송, 보관되어야 하므로 처음 상품을 주문하실 경우 필수적으로 보냉가방을 주문해<br />
                       주셔야 합니다.</p>

                       <p>보냉가방을 이미 구매하여 상품을 받으신 이력이 있는 경우, 선택적으로 구매가 가능합니다.</p>
                    </li> -->
                    <li>
                       <span class="bubble">05</span>
                       <h4>주문/결제</h4>
                       <p>가상계좌결제, 실시간계좌이체, 신용카드 결제 중 원하시는 결제수단을 선택하여 결제하시면 주문이 완료됩니다.</p>
                    </li>
                    <div><img src="/images/serimg_02_02.png" width="721" height="370"></div>
                  </ul>
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