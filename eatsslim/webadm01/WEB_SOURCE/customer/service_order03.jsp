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
							<span class="btn03"><a href="/customer/service_order02.jsp">실시간 계좌이체</a></span>
						</li>
                        <li>
							<span class="btn04"><a class="current" href="/customer/service_order03.jsp">신용카드결제</a></span>
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
                  <dt><h2>카드결제</h2></dt>
                  <dd>
                      <p class="marb20">카드결제시 인터넷 사용이 가능하도록 안심클릭, 안심결제를 필수로 등록하셔야 합니다.<br />안심클릭을 통한 카드결제를 하시면 안심하고 편리하게 쇼핑을 즐길 수 있습니다.</p>
                  </dd>
                </dl>
                <dl class="regist">
                  <dt><h2>안심클릭<br />서비스등록</h2></dt>
                     <dd>
                      <ul class="bubblelist">
                            <li>
                               <span class="bubble">01</span>
                               <h4>안심클릭 서비스란?</h4>
                               <p>인터넷쇼핑 카드결제 시 신용카드번호, 비밀번호 등을 입력함으로써 발생할 수 있는 개인정보 유출의 문제점을 차단하기 위해 삼성, LG, 외환, 신한, 현대, 롯데, 하나, 한미, 씨티, 신세계, 전북, 수협, 제주, 수협, 제주카드, 조흥(舊 강원카드)가 시행하는 전자상거래용 사설인증 서비스 입니다.<br />카드사 별 등록방법은 아래 프로세스를 참고해 주시기 바랍니다.</p>
                               <div class="marb10 mart10"><img src="/images/serimg_02_05.png" width="561" height="93"></div>
                               <p class="list-star">만 14세 이상의 대한민국 국민이라면 누구나 풀무원 잇슬림 회원으로 가입하실 수 있습니다.</p>
                            </li>
                            <li>
                               <span class="bubble">02</span>
                               <h4>안심클릭 서비스 신규가입 절차</h4>
                               <p>안심클릭 서비스 가입(등록)시 주의사항 안심클릭 서비스 가입은 안심클릭 결제서비스를 제공하는 복수의 신용카드를 소지하고 계실 경우 각 신용카드사마다 안심클릭 서비스를 가입하셔야 합니다.</p>
                               <div class="mart10"><img src="/images/serimg_02_06.png" width="561" height="250"></div>
                            </li>
                            <li>
                               <span class="bubble">03</span>
                               <h4>안심클릭서비스 지금 등록하기</h4>
                               <ul class="cardRegister">
                                   <li class="first"><span class="lg"></span><p class="button small dark"><a href="https://www.shinhancard.com/conts/person/main.jsp" target="new">등록</a></p></li>
                                   <li><span class="hn"></span><p class="button small dark"><a href="http://www.hanaskcard.com/" target="new">등록</a></p></li>
                                   <li><span class="ss"></span><p class="button small dark"><a href="https://www.samsungcard.com/index.do" target="new">등록</a></p></li>
                                   <li class="last"><span class="cb"></span><p class="button small dark"><a href="http://www.citibank.co.kr/" target="new">등록</a></p></li>
                                   <li class="first"><span class="keb"></span><p class="button small dark"><a href="http://card.keb.co.kr/veraport/install/install.html" target="new">등록</a></p></li>
                                   <li><span class="sh"></span><p class="button small dark"><a href="https://www.shinhancard.com/conts/person/main.jsp" target="new">등록</a></p></li>
                                   <li><span class="hd"></span><p class="button small dark"><a href="https://www.hyundaicard.com/index.jsp" target="new">등록</a></p></li>
                                   <li class="last"><span class="lt"></span><p class="button small dark"><a href="http://www.lottecard.co.kr/app/index.jsp" target="new">등록</a></p></li>
                                   <li class="first"><span class="suh"></span><p class="button small dark"><a href="https://www.suhyup-bank.com/" target="new">등록</a></p></li>
                                   <li><span class="jb"></span><p class="button small dark"><a href="http://www.jbbank.co.kr/" target="new">등록</a></p></li>
                                   <li><span class="kj"></span><p class="button small dark"><a href="http://www.kjbank.com/banking/index.jsp" target="new">등록</a></p></li>
                                   <li class="last"><span class="jj"></span><p class="button small dark"><a href="https://www.e-jejubank.com/JeJuBankInfo.do" target="new">등록</a></p></li>
                                  <div class="clear"></div>
						       </ul>
                            </li>
                      </ul>
                  </dd>
                  </dl>
                  <div class="divider"></div>
                  <dl class="regist">
                      <dt><h2>ISP인증<br />카드결제</h2></dt>
                      <dd>
                          <ul class="bubblelist">
                            <li>
                                <span class="bubble">01</span>
                                <h4>ISP인증 안전결제란?</h4>
                                <p>삼성, LG, 외환, 신한, 전북, 한미, 하나, 현대, 롯데, 수협, 제주, 농협, 비씨, 국민카드로 카드결제시 안심클릭을 선택하시면 됩니다. 30만원 미만 구매 시 안심클릭 결제 창에서 공인인증서 또는 패스워드 방식을 선택하시면 되고 30만원 이상 구매 시 공인인증서 방식으로 결제 하셔야 합니다.</p>
                            </li>
                            <li>
                                <span class="bubble">02</span>
                                <h4>ISP인증을 통한 카드 안전결제 방법</h4>
                                <ul class="colorchart">
                                    <li>STEP 01. 주문서 작성시 결제수단 선택</li>
                                    <li>STEP 02. ISP 인증 등록확인</li>
                                    <li>STEP 03. 안심클릭 등록확인</li>
                                    <li>STEP 04. ISP인증 비밀번호 입력(30만원 미만 구매시)</li>
                                    <li>STEP 05. ISP비밀번호 입력 +공인인증서 비밀번호 입력</li>
                                    <li>STEP 06. 주문완료</li>
                                </ul>
                            </li>
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