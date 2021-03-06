<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
if(!request.getServerName().equals("www.eatsslim.co.kr") || !request.getScheme().equals("http")){
	response.sendRedirect("http://www.eatsslim.co.kr" + request.getRequestURI());if(true)return;
}
%>

	<script type="text/javascript" src="/mobile/common/js/jquery.cycle.js"></script>
	<script type="text/javascript" src="/mobile/common/js/eatsslim.js"></script>
</head>
<body>
<div id="wrap" class="home">
	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content" class="main-page">
		<div id="index_slider" class="index_slider">
			<div id="index-slider-control" class="index-slider-control">
				<div class="index-slider-nav index-active-lt">
					<h2>식사<br/>다이어트</h2>
					<span class="index-order">1</span>
					<span class="arrow-right"></span>
				</div>
				<div class="index-slider-nav">
					<h2>프로그램<br/>다이어트</h2>
					<span class="index-order">2</span>
					<span class="arrow-right"></span>
				</div>
				<div class="index-slider-nav">
					<h2>타입별<br/>다이어트</h2>
					<span class="index-order">3</span>
					<span class="arrow-right"></span>
				</div>
			</div>
			<div id="index_slides" class="index_slides">
				<div class="index_slideri" id="index_slideri_1">
					<div class="index_inner_wrap">
						<div class="caption">과학적인<br><strong>다이어트 식사</strong></div>
						<a href="/mobile/shop/dietMeal.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-icon-right ui-btn-up-c">
							<span class="ui-btn-inner">
								<span class="ui-btn-text">주문하기</span>
								<span class="ui-icon ui-icon-arrow-r blueicon"></span>
							</span>
						</a>
					</div>
					<div style="text-align:right;"><img src="/mobile/images/banner_main01.png" width="312" height="142" alt="" /></div>
				</div>
				<div class="index_slideri" id="index_slideri_2">
					<div class="index_inner_wrap">
						<div class="caption">감량VS유지<br><strong>프로그램 다이어트</strong></div>
						<a href="/mobile/shop/reductionProgram.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-icon-right ui-btn-up-c">
							<span class="ui-btn-inner">
								<span class="ui-btn-text">주문하기</span>
								<span class="ui-icon ui-icon-arrow-r blueicon"></span>
							</span>
						</a>
					</div>
					<div style="text-align:right;"><img src="/mobile/images/banner_main02.png" width="312" height="142" alt="" /></div>
				</div>
				<div class="index_slideri" id="index_slideri_3">
					<div class="index_inner_wrap">
						<div class="caption">잇슬림만의 특별한<br><strong>타입별 다이어트</strong></div>
						<a href="/mobile/shop/secretSoup.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-icon-right ui-btn-up-c">
							<span class="ui-btn-inner">
								<span class="ui-btn-text">주문하기</span>
								<span class="ui-icon ui-icon-arrow-r blueicon"></span>
							</span>
						</a>
					</div>
					<div style="text-align:right;"><img src="/mobile/images/banner_main03.png" width="312" height="142" alt="" /></div>
				</div>
			</div>
			<div class="sldr_clearlt"></div>
		</div>
		<!-- End index_slider -->
		<div class="grid-banner">
			<table width="100%" border="0" cellspacing="3" cellpadding="0">
				<tr>
					<td>
						<a id="banner1" class="grid-banner-wrap" href="/mobile/intro/eatsslimStory.jsp">
							<div class="caption">
								<p class="hcopy font-blue">잇슬림 소개</p>
								<p>바른 다이어트 잇슬림!</p>
							</div>
						</a>
					</td>
					<td>
						<a id="banner2" class="grid-banner-wrap" href="/mobile/goods/cuisine.jsp">
							<div class="caption">
								<p class="hcopy font-blue">제품 소개</p>
								<p>잇슬림만의 특별함</p>
							</div>
						</a>
					</td>
				</tr>
				<tr>
					<td>
						<a id="banner3" class="grid-banner-wrap" href="/mobile/intro/schedule.jsp">
							<div class="caption">
								<p class="hcopy font-blue">이달의 식단</p>
								<p>식단표를 확인하세요!</p> 
							</div>    
						</a>
					</td>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<a class="grid-banner-halfwrap bg-graymain" href="/mobile/customer/notice.jsp">
										<span class="noticego"></span>
										<p class="btn-text">고객센터</p>
									</a>
								</td>
								<td>
									<a class="grid-banner-halfwrap bg-orange" href="/mobile/customer/indiqna.jsp">
										<span class="indiqnago"></span>
										<p class="btn-text">1:1문의</p>
									</a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<a class="ad-banner" href="/mobile/event/index.jsp">
			<img src="/mobile/images/ad_banner.png" width="314" height="111" alt="광고" />
		</a>


		<div id="slider2_container" class="event_slider">
			<div u="slides" class="event_slider_img">
					<div><a href="/mobile/shop/dietMeal.jsp"><img u="image" src="/images/mobile/event_test01.jpg" /></a></div>			
					<div><a href="/mobile/shop/weight2weeks.jsp"><img u="image" src="/images/mobile/event_test02.jpg" /></a></div>		
			</div>
			<span u="arrowleft" class="arrow_left"></span>
			<span u="arrowright" class="arrow_right"></span>
		</div>


	</div>
	<!-- End Content -->
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
</body>
</html>