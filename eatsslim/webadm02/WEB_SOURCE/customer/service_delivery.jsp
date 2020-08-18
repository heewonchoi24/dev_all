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
							<a href="notice.jsp">공지사항</a>
						</li>
						<li>
							<a href="faq.jsp">FAQ</a>
						</li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">1:1문의</a></li>
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
							<a href="/customer/service_order.jsp">주문/결재</a>
						</li>
						<li>
							<span class="current">배송안내</span>
						</li>
						<li>
							<a href="/customer/service_coupon.jsp">쿠폰사용</a>
						</li>
						<li>
							<a href="/customer/service_change.jsp">주문변경</a>
						</li>
						<li>
							<a href="/customer/service_recommand.jsp">취소/교환/환불</a>
						</li>
                        <div class="clear"></div>
					</ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
				   <h3 class="marb20">배송비 기준</h3>
                   <p>택배 상품의 경우 40,000원 이상 결제시 배송비는 무료이며, 40,000원 미만시 배송비 3,000원이 부과됩니다.</p>
                   <div class="divider"></div>
                   
                   <h3 class="marb20">배송안내 단계</h3>
                   <h4 class="font-blue marb10">일배</h4>
                   <p>잇슬림의 일배 상품의 모든 메뉴는 주문과 동시에 식재료가 구매되고 조리되어, 안전하고 신선하게 고객님의 댁까지 배달됩니다.</p>
                   <br />
                   <img src="/images/service_delivery_01.jpg" width="507" height="167" alt="일배배송단계"> 
                   <div class="divider"></div>
                   <h4 class="font-blue marb10">택배</h4>
                   <img src="/images/service_delivery_02.jpg" width="716" height="165" alt="택배배송단계"> 
                   <div class="divider"></div>
                   <h4 class="font-blue marb10">주문 마감시각 및 배송일정</h4>
                   <img src="/images/service_delivery_03.jpg" width="721" height="101" alt="배송일정">
                   <div class="divider"></div>
                   
                   <h3 class="marb10">신선배송시스템</h3>
                   <p class="marb10">잇슬림은 식재료 구매과정에서 배송까지 모든 시스템이 냉장 유통되고, 보냉가방에 담겨 고객님께 배송됩니다.</p>
                   <img src="/images/service_delivery_04.jpg" width="624" height="115" alt="신선배송시스템">
                   <div class="divider"></div>
                   
                   <h5 class="font-blue marb10">1. 배달시간</h5>
                   <p>자정에서 아침(00:00~06:00)사이에 이루어 집니다. 악천후, 교통상황, 배달물량의 급격한 증가, 고객님의 요청 등의 상황에 따라 정해진 배달 시간에서 1시간 정도는 조기, 연장 배달될 수 있습니다.</p>
                   <div class="divider"></div>
                   
                   <h5 class="font-blue marb10">2. 보냉가방 안내</h5>
                   <p>
                   - 처음 구매하실 때에는 배달을 위한 보냉가능을 구매하셔야 합니다. (기존 고객님께서도 추가로 필요하신 경우 구매가 가능합니다.)<br />
                   - 보냉가방의 분실은 잇슬림에서 책임지지 않으며, 추가로 구매해주셔야 합니다.<br />
                   - 일배 상품과 보냉가방을 같이 구입하실 경우 첫 배송일에 같이 배송됩니다.<br />
                   </p>
                   <div class="divider"></div>
                   
                   <h5 class="font-blue marb10">3. 수령방법</h5>
                   <p>잇슬림 자체 배송시스템을 통해 배송이 이루어지며, 현관앞비치, 경비실 위탁수령 2가지 방법 중에서 고객님의 편의에 따라 선택하여 배송을 받으실 수 있습니다.<br />
                   <br />
                   주문시 배송 메시지에 기입하신 배송지 정보가 정확하고 구체적일수록 정확하고 안전한 배송이 이루어집니다.<br />
                   예) 현관 출입문 비밀번호, 카드키 출입일 경우 출입방법, 부재시 수령관련 연락처 안내
                   </p>
                   <div class="divider"></div>
                   
                   <h5 class="font-blue marb10">4. 배달가능지역</h5>
                   <p>배달안내 > 배달가능지역 검색을 통해 확인이 가능합니다.</p>
                   <br />
                   <div class="deliveryarea">
                       <h5 class="font-green">배달가능지역</h5>
                       <div class="positionlist">
                           <dl>
                               <dt>수도권</dt>
                               <dd>
                                  <ul>
                                      <li>서울</li>
                                      <li>경기</li>
                                  </ul>
                               </dd>
                           </dl>
                           <dl>
                               <dt>광역시</dt>
                               <dd>
                                  <ul>
                                      <li>인천</li>
                                      <li>부산</li>
                                      <li>대구</li>
                                      <li>울산</li>
                                      <li>대전</li>
                                      <li>광주</li>
                                  </ul>
                               </dd>
                           </dl>
                           <dl>
                               <dt>주요도시</dt>
                               <dd>
                                  <ul>
                                      <li>천안</li>
                                      <li>아산</li>
                                      <li>청주</li>
                                      <li>익산</li>
                                      <li>전주</li>
                                      <li>김해</li>
                                      <li>양산</li>
                                      <li>경산</li>
                                      <li>구미</li>
                                      <li>통합차창원</li>
                                  </ul>
                               </dd>
                           </dl>
                       </div>
                   </div>
                
                </div>
			</div>
			<!-- End row -->
		</div>
		<!-- End twelve columns offset-by-one -->
		<div class="sidebar four columns">
		    <p><a href="#"><img src="../images/side_banner_01.jpg" alt="잇슬림 한눈에 알아보기" width="242" height="211" /></a></p>
			<div class="bestfaq">
			   <h3>자주하는 질문</h3>
			   <ul>
			       <li><a href="#">식단 구매시 잇슬림 퀴진 이외 어떤 서비스를 받게되나요?</a></li>
				   <li><a href="#">프로그램 진행 중 궁금한 사항이 있으면 어떻게 하면 되나요?</a></li>
				   <li><a href="#">잇슬림 퀴진에 대해 설면해 주세요.</a></li>
				   <li><a href="#">어떤 종류의 음식이 제공되나요?</a></li>
				   <li><a href="#">별도의 조리가 필요한가요?</a></li>
			   </ul>
			</div>
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