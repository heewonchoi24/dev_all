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
							<span class="btn04"><a href="/customer/service_order03.jsp">신용카드결제</a></span>
						</li>
                        <li class="last">
							<span class="btn05"><a class="current" href="/customer/service_order04.jsp">공인인증서</a></span>
						</li>
                        <div class="clear"></div>
                    </ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
                <dl class="regist">
                  <dt><h2>공인인증서<br />의무사용</h2></dt>
                     <dd>
                      <ul class="bubblelist">
                            <li>
                               <span class="bubble">01</span>
                               <h4>30만원 이상 결제시 공인인증 의무사용</h4>
                               <p>2005년 11월 1일부터 금융감독원의 전자금융거래 안정성 강화에 따라 30만원 이상일 경우 모든 인터넷 쇼핑의 신용카드 결제 시 공인인증서를 반드시 사용하도록 정하고 있습니다. 고객님의 카드를 확인하신 후 해당하는 인증을 받으시기 바랍니다.</p>
                               <div class="marb10 mart10">
                                  <table class="termstable" width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <th>신용카드</th>
                                        <th>30만원 미만 결제</th>
                                        <th>30만원 이상 결제</th>
                                      </tr>
                                      <tr>
                                        <td>국민, 비씨, 우리(舊 평화카드)</td>
                                        <td>ISP인증<br />(안전결제)</td>
                                        <td class="last">ISP인증(안전결제)<br />+ 공인인증</td>
                                      </tr>
                                      <tr>
                                        <td>삼성, 엘지, 외환, 신한, 하나, 한미, 씨티, 롯데,<br />신세계, 현대, 수협, 전국, 제주, 조흥 (舊 강원)</td>
                                        <td>안심클릭인증</td>
                                        <td class="last">공인인증</td>
                                      </tr>
                                      <tr>
                                        <td>축협</td>
                                        <td>인증없음</td>
                                        <td class="last">인증없음</td>
                                      </tr>
                                    </table>
                               </div>
                            </li>
                      </ul>
                  </dd>
                  </dl>
                  <div class="divider"></div>
                  <dl class="regist">
                      <dt><h2>공인인증서<br />발급안내</h2></dt>
                      <dd>
                          <ul class="bubblelist">
                            <li>
                                <span class="bubble">02</span>
                                <h4>공인인증서가 있는 경우 </h4>
                                <ul class="colorchart">
                                    <li>STEP 01. 거래은행 또는 증권사에 방문하여 본인확인 후 인터넷뱅킹/ 사이버트레이딩 신청</li>
                                    <li>STEP 02. 은행/증권사 홈페이지에서 은행/증권 공인인증서 발급(운행/증권 거래용)</li>
                                    <li>STEP 03. 금융결제원/한국정보인증/한국증권전산 홈페이지에서 공인인증서 발급</li>
                                </ul>
                            </li>
                            <li>
                                <span class="bubble">02</span>
                                <h4>공인인증서가 없는 경우 </h4>
                                <ul class="colorchart marb20">
                                    <li>STEP 01. 은행/증권사용 공인인증서 또는 개인범용 공인인증서</li>
                                    <li>STEP 02. 금융결제원/한국정보인증/한국증권전산 홈페이지에서 공인인증서 발급</li>
                                </ul>
                                <p class="list-star">금융결제원에서 공인인증서 발급 <span class="button small dark"><a href="http://www.yessign.or.kr/" target="new">발급</a></span></p>
                                <p class="list-star">한국정보인증에서 공인인증서 발급(우체국 공인인증서 발급 가능) <span class="button small dark"><a href="http://renew.signgate.com/certificate/cert.sg" target="new">발급</a></span></p>
                            </li>
                      </dd>
                  </dl>
                  <dl class="regist">
                      <dt><h2>현금영수증<br />자진발급제</h2></dt>
                      <dd>
                      <p class="marb20">현금영수증 사용내역은 전산으로 수록되어 현금영수증 홈페이지에서 3개월간의 사용내역 (일자,상호, 금액 등)및 1년간의 월별 사용내역을 확인할 수 있으므로 내역확인이 되면 보관하실 필요는 없습니다. 현금영수증 신청시, 사용하시는 모든 인식 매체는 현금영수증 홈페이지에 회원가입 및  사용등록이 되어 있어야 혜택을 받으실 수 있습니다.</p>
                      <table class="termstable" width="100%" border="0" cellspacing="0" cellpadding="0">
                         <tr>
                           <th>현금영수증상담센터</th>
                           <th>국세청 홈페이지</th>
                            <th>현금영수증 홈페이지</th>
                         </tr>
                         <tr>
                            <td>☎ 1544-2020</td>
                            <td><a href="http://www.nts.go.kr" target="new">http://www.nts.go.kr</a></td>
                            <td class="last"><a href="http://www.texsave.co.kr" target="new">http://www.texsave.co.kr</a></td>
                         </tr>
                        </table>
                    </dd>
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