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
							<a href="/customer/service_order.jsp">주문/결제</a>
						</li>
						<li>
							<a href="/customer/service_change.jsp">주문변경</a>
						</li>
						<li>
							<a href="/customer/service_recommand.jsp">취소/교환/환불</a>
						</li>
                        <li>
							<span class="current">쿠폰사용</span>
						</li>
                        <div class="clear"></div>
					</ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
				   <!--div class="marb20"><img src="/images/serimg_05_01.png" width="721" height="248"></div-->
                <h3 class="marb20">쿠폰안내</h3>
                    </p>
                    1. 고객님께 감사드리는 마음으로 잇슬림은 다양한 Event를 통하여 고객님께 많이 혜택과 편의를  드리기 위해 쿠폰을 지급해 드립니다.<br />
                    <br />
                    2. 쿠폰은 잇슬림 사이트에서 판매되는 제품에만 적용되며, 가입회원 중 잇슬림에서 정한 대상자에 한하여 지급받을 수 있습니다.<br />
                    <br />
                    3. 쿠폰은 구매시 혜택을 드리는 것으로 결제시에 사용할 수 있으며, 주문시에 적용 후 잔액이 남았더라도 1회 사용으로 자동 소멸됩니다.<br />
                    <br />
                    4. 발급되는 쿠폰의 사용제한에 따라 실제 적용 가능한 상품이 제한적일 수 있으며, 이럴 경우 주문단계적용 가능한 쿠폰리스트에서<br /> 
                    보이지 않을 수 있습니다.쿠폰은 사용기간이 있으며, 기간 경과 후 자동 소멸됩니다.<br />
                    <br />
        
                    5. 주문취소 및 반품을 할 경우 사용했던 쿠폰은 소멸되며, 재발행 되지 않습니다.<br />
                    단, 주문 시 사용 실수에 의해 소멸되었거나, 시스템상 오류로 인해 소멸된 경우에는
                       고객기쁨센터(080-022-0085)로 문의주시면,<br /> 확인 후 재발급 가능합니다.<br />
                       <br />
                    6. 사용가능한 쿠폰은 마이이슬림 > 쿠폰내역에서 확인하실 수 있습니다.<br />
                    <br />
                    7. 오프라인쿠폰(인증번호)는 마이잇슬림 > 쿠폰내역에서 인증 후 사용하실 수 있습니다.<br />
                    <br />
                    </p>
                   <div class="divider"></div>
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