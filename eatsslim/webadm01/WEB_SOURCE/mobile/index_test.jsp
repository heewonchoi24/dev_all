<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%

SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
String table		= "ESL_EVENT";
String where		= "";
String query		= "";
int intTotalCnt	= 0;
int eventId			= 0;
String listImg		= "";
String imgUrl		= "";
String eventUrl		= "";
String viewLink		= "";
String title		= "";
String bannerImg = "";
String clickLink = "";

%>
	
	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/idangerous.swiper.css" />
	<script src="/mobile/common/js/idangerous.swiper.js" type="text/javascript"></script>
	
	<link href="/mobile/common/css/main_style.css" rel="stylesheet" />
	<link href="/mobile/common/css/jquery.bxslider.css" rel="stylesheet" />
	<!-- bxSlider Javascript file -->
	<script src="/mobile/common/js/jquery.bxslider.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$('#slider1').bxSlider({
		  mode: 'fade',
		  auto: true,
		  autoControls: true,
		  pause: 2000
		});
		
		$('#slider2').bxSlider({
		  auto: true,
		  autoControls: true,
		  pause: 3000
		});
	});
	
	function clickMainBanner(url) {
	
		ga('send', 'event', 'main', 'click', '잇슬림이벤트');
		
		if (url) {
			location = url;
		}	
		
	}
	</script>

	<style>
	/* [s] 공통 */
	/* IE10 Windows Phone 8 Fixes */
	.swiper-wp8-horizontal {
		-ms-touch-action: pan-y
	}

	.swiper-wp8-vertical {
		-ms-touch-action: pan-x
	}
	
	#mBanner {margin-top: 5px; padding: 0 5px}
	#mBanner a {display: block;}
	#mBanner a img {width: 100%; max-width: auto}
	</style>
	
	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/stylesheet_n2.css" />
	<script type="text/javascript" src="/mobile/common/js/jssor.js"></script>
	<script type="text/javascript" src="/mobile/common/js/jssor.slider.js"></script>
	<meta name="format-detection" content="telephone=no" />
</head>

<body class="home demo">
<div id="wrap">
	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<div class="clearfix"></div>
	<div id="content" style="background-color:#fff">
		
		<!-- main_slider --> 
		<article class="main_img">
			<ul id="slider1">

<%				
				
				query		= "SELECT ID, TITLE, BANNER_IMG, LINK";
				query		+= " FROM ESL_BANNER ";
				query		+= " WHERE GUBUN in ('5') AND OPEN_YN = 'Y' AND ('"+ today +"' BETWEEN STDATE AND LTDATE)";
				query		+= " ORDER BY ID DESC";
				pstmt		= conn.prepareStatement(query);
				rs			= pstmt.executeQuery();

				while (rs.next()) {
					title			= rs.getString("TITLE");
					bannerImg		= rs.getString("BANNER_IMG");
					if (bannerImg.equals("") || bannerImg == null) {
						imgUrl		= "../images/event_thumb01.jpg";
					} else {
						imgUrl		= webUploadDir +"banner/"+ bannerImg;
					}
					clickLink		= rs.getString("LINK");
				%>
					<li>
					<a href="javascript:;" onclick="clickMainBanner('<%=clickLink%>');" title="<%=title%>" ><img src="<%=imgUrl%>" alt="<%=title%>" /></a>
					</li>
				<%
				}

				rs.close();
%>		
		
			</ul>
		</article>

		<!-- banner -->
		<div class="banner_cont clearfix">
			<div class="column">
				<a class="menu line" href="/mobile/intro/schedule.jsp">
					<span class="icon"></span>
					<p>이달의 식단</p>
				</a>
			</div>
			<div class="column">
				<a class="deliver line" href="/mobile/shop/mypage/orderList.jsp">
					<span class="icon"></span>
					<p>주문/배송 조회</p>
				</a>
			</div>
			<div class="column">
				<a class="order" href="/mobile/delivery/delivery.jsp">
					<span class="icon"></span>
					<p>배달지역확인</p>
				</a>
			</div>
		</div>
		<div class="banner_cont clearfix">
			<div class="column">
				<a class="free line" href="/mobile/customer/service.jsp">
					<span class="icon"></span>
					<p>주문안내</p>
				</a>
			</div>
			<div class="column">
				<a class="notice line" href="/mobile/customer/notice.jsp">
					<span class="icon"></span>
					<p>공지사항</p>
				</a>
			</div>
			<div class="column">
				<a class="customer" href="/mobile/customer/indiqna.jsp">
					<span class="icon"></span>
					<p>1:1문의</p>
				</a>
			</div>
		</div>
		<!-- //banner -->
		
		<!-- event -->
		<article class="event_main">
			<h2>잇슬림 이벤트</h2>
			<ul id="slider2">
			
			<%
			
				where		= " WHERE GUBUN in ('0', '2') AND OPEN_YN = 'Y' AND ('"+ today +"' BETWEEN STDATE AND LTDATE)";
				query		= "SELECT ID, EVENT_TYPE, TITLE, DATE_FORMAT(STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(LTDATE, '%Y.%m.%d') LTDATE,";
				query		+= "	EVENT_TARGET, DATE_FORMAT(ANC_DATE, '%Y.%m.%d') ANC_DATE, LIST_IMG, EVENT_URL";
				query		+= " FROM "+ table + where;
				query		+= " ORDER BY ID DESC";
				pstmt		= conn.prepareStatement(query);
				rs			= pstmt.executeQuery();


			
				while (rs.next()) {
						eventId		= rs.getInt("ID");
						title		= rs.getString("TITLE");
						listImg		= rs.getString("LIST_IMG");
						if (listImg.equals("") || listImg == null) {
							imgUrl		= "../images/event_thumb01.jpg";
						} else {
							imgUrl		= webUploadDir +"promotion/"+ listImg;
						}
						eventUrl	= rs.getString("EVENT_URL");
						viewLink	= (eventUrl == null || eventUrl.equals(""))? "href=\"/mobile/event/view.jsp?id="+ eventId + "\"" : "href=\""+ eventUrl +"\" target=\"press\"";
			%>
				<li>
				   <a <%=viewLink%>> 
					  <img src="<%=imgUrl%>" alt="잇슬림이벤트">
				   </a>
				</li>
			<%
				}
			%>
			
			
			
			
			
				<!--li><a href="/mobile/event/view.jsp?id=239&pgsize=10"><img src="images/event_ban4.jpg" alt="잇슬림이벤트" /></a></li>
				<li><a href="/mobile/event/view.jsp?id=238&pgsize=10"><img src="images/event_ban1.jpg" alt="잇슬림이벤트" /></a></li>
				<li><a href="/mobile/event/view.jsp?id=237&pgsize=10"><img src="images/event_ban2.jpg" alt="잇슬림이벤트" /></a></li>
				<li><a href="/mobile/event/view.jsp?id=236&pgsize=10"><img src="images/event_ban3.jpg" alt="잇슬림이벤트" /></a></li-->
			</ul>
		</article>

    <!-- //event -->
		<!-- accordion -->
		<ul class="accordion clearfix">
			<li id="one" class="depth01 step001">
				<a href="#">건강도시락<span></span></a>
				<ul class="sub_menu">
					<li class="depth02"><a href="/mobile/shop/healthyMeal.jsp">헬씨퀴진</a> <div class="btn"><a href="/mobile/shop/healthyMeal.jsp"><em>상세보기</em></a> <a href="/mobile/shop/healthyMeal-order.jsp"><em>주문하기</em></a></div></li>
				</ul>
			</li>
			<li id="two" class="depth01 step002">
				<a href="#">식사 다이어트<span></span></a>
				<ul class="sub_menu">
					<li class="depth02"><a href="/mobile/shop/dietMeal.jsp">퀴진</a> <div class="btn"><a href="/mobile/shop/dietMeal.jsp"><em>상세보기</em></a> <a href="/mobile/shop/dietMeal-order.jsp?grpId=32"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/dietMeal-alacarteA.jsp">알라까르떼 슬림</a> <div class="btn"><a href="/mobile/shop/dietMeal-alacarteA.jsp"><em>상세보기</em></a> <a href="/mobile/shop/dietMeal-order.jsp?grpId=34"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/dietMeal-alacarteB.jsp">알라까르떼 헬씨</a> <div class="btn"><a href="/mobile/shop/dietMeal-alacarteB.jsp"><em>상세보기</em></a> <a href="/mobile/shop/dietMeal-order.jsp?grpId=43"><em>주문하기</em></a></div></li>
				</ul>
			</li>			
			<li id="three" class="depth01 step003">
				<a href="#">프로그램 다이어트<span></span></a>
				<ul class="sub_menu">
					<li class="depth02"><a href="/mobile/shop/weight3days.jsp">3일 프로그램</a> <div class="btn"><a href="/mobile/shop/weight3days.jsp"><em>상세보기</em></a> <a href="/mobile/shop/weight3days-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/weight2weeks.jsp">집중감량 2주</a> <div class="btn"><a href="/mobile/shop/weight2weeks.jsp"><em>상세보기</em></a> <a href="/mobile/shop/weight2weeks-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/fullStep.jsp">감량&유지 4주</a> <div class="btn"><a href="/mobile/shop/fullStep.jsp"><em>상세보기</em></a> <a href="/mobile/shop/dietProgram-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/cleanseProgram.jsp">클렌즈 프로그램</a> <div class="btn"><a href="/mobile/shop/cleanseProgram.jsp"><em>상세보기</em></a> <a href="/mobile/shop/cleanseProgram-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/smartgram.jsp">스마트그램</a> <div class="btn"><a href="/mobile/shop/smartgram.jsp"><em>상세보기</em></a> <a href="/mobile/shop/smartgram-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/speed4weeks.jsp">스피드 프로그램</a> <div class="btn"><a href="/mobile/shop/speed4weeks.jsp"><em>상세보기</em></a> <a href="/mobile/shop/speed4weeks-order.jsp"><em>주문하기</em></a></div></li>
				</ul>
			</li>
			<li id="four" class="depth01 step004">
				<a href="#">간편식<span></span></a>
				<ul class="sub_menu">
					<li class="depth02"><a href="/mobile/shop/minimeal.jsp">미니밀</a> <div class="btn"><a href="/mobile/shop/minimeal.jsp"><em>상세보기</em></a> <a href="/mobile/shop/minimeal-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/secretSoup.jsp">밸런스쉐이크</a> <div class="btn"><a href="/mobile/shop/balanceShake.jsp"><em>상세보기</em></a> <a href="/mobile/shop/balanceShake-order.jsp"> <em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/balanceShake.jsp">시크릿수프</a> <div class="btn"><a href="/mobile/shop/secretSoup.jsp"><em>상세보기</em></a><a href="/mobile/shop/dietSoup-order.jsp"><em>주문하기</em></a></div></li>
				</ul>
			</li>
			<li id="five" class="depth01 step005">
				<a href="#">건강기능식품<span></span></a>
				<ul class="sub_menu">					
					<li class="depth02"><a href="/mobile/shop/dietCLA.jsp">다이어트CLA</a> <div class="btn"><a href="/mobile/shop/dietCLA.jsp"><em>상세보기</em></a> <a href="/mobile/shop/dietCLA-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/digest.jsp">다이제스트</a> <div class="btn"><a href="/mobile/shop/digest.jsp"><em>상세보기</em></a> <a href="/mobile/shop/digest-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/womanBalance.jsp">우먼밸런스</a> <div class="btn"><a href="/mobile/shop/womanBalance.jsp"><em>상세보기</em></a> <a href="/mobile/shop/womanBalance-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/lock.jsp">쾌락</a> <div class="btn"><a href="/mobile/shop/lock.jsp"><em>상세보기</em></a> <a href="/mobile/shop/lock-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/vitaminD.jsp">칼슘비타민D</a> <div class="btn"><a href="/mobile/shop/vitaminD.jsp"><em>상세보기</em></a> <a href="/mobile/shop/vitaminD-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/chewable.jsp">베리뷰티츄어블C</a> <div class="btn"><a href="/mobile/shop/chewable.jsp"><em>상세보기</em></a> <a href="/mobile/shop/chewable-order.jsp"><em>주문하기</em></a></div></li>
				</ul>
			</li>
			<li id="six" class="depth01 step006">
				<a href="#">건강즙<span></span></a>
				<ul class="sub_menu">					
					<li class="depth02"><a href="/mobile/shop/onion.jsp">양파&삼채</a> <div class="btn"><a href="/mobile/shop/onion.jsp"><em>상세보기</em></a> <a href="/mobile/shop/onion-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/pomegranate.jsp">석류</a> <div class="btn"><a href="/mobile/shop/pomegranate.jsp"><em>상세보기</em></a> <a href="/mobile/shop/pomegranate-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/acaiberry.jsp">아사이수퍼베리</a> <div class="btn"><a href="/mobile/shop/acaiberry.jsp"><em>상세보기</em></a> <a href="/mobile/shop/acaiberry-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/blueberry.jsp">야생블루베리</a> <div class="btn"><a href="/mobile/shop/blueberry.jsp"><em>상세보기</em></a> <a href="/mobile/shop/blueberry-order.jsp"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/aronia.jsp">아로니아세트</a> <div class="btn"><a href="/mobile/shop/aronia.jsp"><em>상세보기</em></a> <a href="/mobile/shop/aronia-order.jsp"><em>주문하기</em></a></div></li>
				</ul>
			</li>

			<!--<li id="siz" class="depth01 step06">
				<a href="#">수퍼베추딜<span></span></a>
				<ul class="sub_menu">					
					<li class="depth02"><a href="/mobile/shop/getProductDealList.do">수퍼베추딜</a> <div class="btn"><a href="/mobile/shop/getProductDealList.do"><em>주문하기</em></a></div></li>
				</ul>
			</li>-->
		</ul>
		<script type="text/javascript">
		$(document).ready(function() {
			// Store variables
			var accordion_head = $('.accordion > li > a'),
				accordion_body = $('.accordion li > .sub_menu');
			// Open the first tab on load
			accordion_head.first().addClass('active').next().slideDown('normal');
			// Click function
			accordion_head.on('click', function(event) {
				// Disable header links
				event.preventDefault();
				// Show and hide the tabs on click
				if ($(this).attr('class') != 'active'){
					accordion_body.slideUp('normal');
					$(this).next().stop(true,true).slideToggle('normal');
					accordion_head.removeClass('active');
					$(this).addClass('active');
				}
			});
		});
		</script>
		<!-- //accordion -->
		
		
		<!-- faq
		<div class="main_faq">
			<a href="/mobile/customer/getInquiryForm.do"><img src="/images/mobile/inquiry_text.png" alt="주문/배송 간편문의 남기기!" width="300px" /></a>
		</div>
 //faq -->
	</div>
	<!-- End content -->
	<div class="ui-footer">
	<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
</body>
</html>