<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
	
	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/idangerous.swiper.css" />
	<script src="/mobile/common/js/idangerous.swiper.js" type="text/javascript"></script>

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
	<%@ include file="/mobile/common/include/inc-header.jsp"%>
	<div id="content" style="background-color:#fff">
		<div class="clearfix" style="height:50px"></div>
		<!-- main_slider --> 
		<div id="slider1_container" class="main_slider">
			<div u="slides" class="main_slider_img">
				<div><a href="/mobile/community/getEventView.do?currentPage=1&schType=end&seq=90&schKeyword="><img u="image" src="/mobile/images/main_event.jpg" /></a></div>
				<div><a href="/mobile/community/getEventView.do?currentPage=1&schType=end&seq=89&schKeyword="><img u="image" src="/images/mobile/main_slider_img_01.jpg" /></a></div>
				<div><a href="/mobile/community/getEventView.do?currentPage=1&schType=end&seq=88&schKeyword="><img u="image" src="/images/mobile/main_slider_img_02.jpg" /></a></div>			
				<div><a href="/mobile/promotion/getEventGCampaign.do?seq=99999"><img u="image" src="/images/mobile/main_slider_img_04.jpg" /></a></div>
				<div><a href="/mobile/community/getEventView.do?seq=85"><img u="image" src="/images/mobile/main_slider_img_03.jpg" /></a></div>				
			</div>
			<div u="navigator" class="bul_navi">
				<div u="prototype"></div>
			</div>
			<span u="arrowleft" class="arrow_left"></span>
			<span u="arrowright" class="arrow_right"></span>
		</div>
		<script>
			jQuery(document).ready(function ($) {

				var _CaptionTransitions = [];
				_CaptionTransitions["L"] = { $Duration: 900, x: 0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
				_CaptionTransitions["R"] = { $Duration: 900, x: -0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
				_CaptionTransitions["T"] = { $Duration: 900, y: 0.6, $Easing: { $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
				_CaptionTransitions["B"] = { $Duration: 900, y: -0.6, $Easing: { $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
				_CaptionTransitions["ZMF|10"] = { $Duration: 900, $Zoom: 11, $Easing: { $Zoom: $JssorEasing$.$EaseOutQuad, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 };
				_CaptionTransitions["RTT|10"] = { $Duration: 900, $Zoom: 11, $Rotate: 1, $Easing: { $Zoom: $JssorEasing$.$EaseOutQuad, $Opacity: $JssorEasing$.$EaseLinear, $Rotate: $JssorEasing$.$EaseInExpo }, $Opacity: 2, $Round: { $Rotate: 0.8} };
				_CaptionTransitions["RTT|2"] = { $Duration: 900, $Zoom: 3, $Rotate: 1, $Easing: { $Zoom: $JssorEasing$.$EaseInQuad, $Opacity: $JssorEasing$.$EaseLinear, $Rotate: $JssorEasing$.$EaseInQuad }, $Opacity: 2, $Round: { $Rotate: 0.5} };
				_CaptionTransitions["RTTL|BR"] = { $Duration: 900, x: -0.6, y: -0.6, $Zoom: 11, $Rotate: 1, $Easing: { $Left: $JssorEasing$.$EaseInCubic, $Top: $JssorEasing$.$EaseInCubic, $Zoom: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear, $Rotate: $JssorEasing$.$EaseInCubic }, $Opacity: 2, $Round: { $Rotate: 0.8} };
				_CaptionTransitions["CLIP|LR"] = { $Duration: 900, $Clip: 15, $Easing: { $Clip: $JssorEasing$.$EaseInOutCubic }, $Opacity: 2 };
				_CaptionTransitions["MCLIP|L"] = { $Duration: 900, $Clip: 1, $Move: true, $Easing: { $Clip: $JssorEasing$.$EaseInOutCubic} };
				_CaptionTransitions["MCLIP|R"] = { $Duration: 900, $Clip: 2, $Move: true, $Easing: { $Clip: $JssorEasing$.$EaseInOutCubic} };

				var options = {
					$FillMode: 2,                                       //[Optional] The way to fill image in slide, 0 stretch, 1 contain (keep aspect ratio and put all inside slide), 2 cover (keep aspect ratio and cover whole slide), 4 actual size, 5 contain for large image, actual size for small image, default value is 0
					$AutoPlay: true,                                    //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
					$AutoPlayInterval: 2500,                            //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
					$PauseOnHover: 1,                                   //[Optional] Whether to pause when mouse over if a slider is auto playing, 0 no pause, 1 pause for desktop, 2 pause for touch device, 3 pause for desktop and touch device, 4 freeze for desktop, 8 freeze for touch device, 12 freeze for desktop and touch device, default value is 1

					$ArrowKeyNavigation: true,   			            //[Optional] Allows keyboard (arrow key) navigation or not, default value is false
					$SlideEasing: $JssorEasing$.$EaseOutQuint,          //[Optional] Specifies easing for right to left animation, default value is $JssorEasing$.$EaseOutQuad
					$SlideDuration: 800,                               //[Optional] Specifies default duration (swipe) for slide in milliseconds, default value is 500
					$MinDragOffsetToSlide: 20,                          //[Optional] Minimum drag offset to trigger slide , default value is 20
					//$SlideWidth: 600,                                 //[Optional] Width of every slide in pixels, default value is width of 'slides' container
					//$SlideHeight: 300,                                //[Optional] Height of every slide in pixels, default value is height of 'slides' container
					$SlideSpacing: 0, 					                //[Optional] Space between each slide in pixels, default value is 0
					$DisplayPieces: 1,                                  //[Optional] Number of pieces to display (the slideshow would be disabled if the value is set to greater than 1), the default value is 1
					$ParkingPosition: 0,                                //[Optional] The offset position to park slide (this options applys only when slideshow disabled), default value is 0.
					$UISearchMode: 1,                                   //[Optional] The way (0 parellel, 1 recursive, default value is 1) to search UI components (slides container, loading screen, navigator container, arrow navigator container, thumbnail navigator container etc).
					$PlayOrientation: 1,                                //[Optional] Orientation to play slide (for auto play, navigation), 1 horizental, 2 vertical, 5 horizental reverse, 6 vertical reverse, default value is 1
					$DragOrientation: 1,                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $DisplayPieces is greater than 1, or parking position is not 0)

					$CaptionSliderOptions: {                            //[Optional] Options which specifies how to animate caption
						$Class: $JssorCaptionSlider$,                   //[Required] Class to create instance to animate caption
						$CaptionTransitions: _CaptionTransitions,       //[Required] An array of caption transitions to play caption, see caption transition section at jssor slideshow transition builder
						$PlayInMode: 1,                                 //[Optional] 0 None (no play), 1 Chain (goes after main slide), 3 Chain Flatten (goes after main slide and flatten all caption animations), default value is 1
						$PlayOutMode: 3                                 //[Optional] 0 None (no play), 1 Chain (goes before main slide), 3 Chain Flatten (goes before main slide and flatten all caption animations), default value is 1
					},

					$BulletNavigatorOptions: {                          //[Optional] Options to specify and enable navigator or not
						$Class: $JssorBulletNavigator$,                 //[Required] Class to create navigator instance
						$ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
						$AutoCenter: 1,                                 //[Optional] Auto center navigator in parent container, 0 None, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
						$Steps: 1,                                      //[Optional] Steps to go for each navigation request, default value is 1
						$Lanes: 1,                                      //[Optional] Specify lanes to arrange items, default value is 1
						$SpacingX: 8,                                   //[Optional] Horizontal space between each item in pixel, default value is 0
						$SpacingY: 8,                                   //[Optional] Vertical space between each item in pixel, default value is 0
						$Orientation: 1                                 //[Optional] The orientation of the navigator, 1 horizontal, 2 vertical, default value is 1
					},

					$ArrowNavigatorOptions: {                           //[Optional] Options to specify and enable arrow navigator or not
						$Class: $JssorArrowNavigator$,                  //[Requried] Class to create arrow navigator instance
						$ChanceToShow: 1,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
						$AutoCenter: 2,                                 //[Optional] Auto center arrows in parent container, 0 No, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
						$Steps: 1                                       //[Optional] Steps to go for each navigation request, default value is 1
					}
				};

				var jssor_slider1 = new $JssorSlider$("slider1_container", options);

				//responsive code begin
				//you can remove responsive code if you don't want the slider scales while window resizes
				function ScaleSlider() {
					var bodyWidth = document.body.clientWidth;
					if (bodyWidth)
						jssor_slider1.$ScaleWidth(Math.min(bodyWidth, 1920));
					else
						window.setTimeout(ScaleSlider, 30);
				}
				ScaleSlider();

				$(window).bind("load", ScaleSlider);
				$(window).bind("resize", ScaleSlider);
				$(window).bind("orientationchange", ScaleSlider);
				//responsive code end
			});
		</script>
		<!-- //main_slider -->
		
		<!-- banner -->
		<div class="banner_cont clearfix">
			<div class="column">
				<a class="menu line" href="/mobile/mypage/getMonthMenu.do">
					<span class="icon"></span>
					<p>이달의 식단</p>
				</a>
			</div>
			<div class="column">
				<a class="deliver line" href="/mobile/mypage/getMemberOrderList.do">
					<span class="icon"></span>
					<p>배달 스케쥴 조정</p>
				</a>
			</div>
			<div class="column">
				<a class="order" href="/common/forwardPage.do?forwardPage=babymeal/mobile/brand/service">
					<span class="icon"></span>
					<p>주문에서 배달까지</p>
				</a>
			</div>
		</div>
		<div class="banner_cont clearfix">
			<div class="column">
				<a class="free line" href="/mobile/community/getEventCampaign.do">
					<span class="icon"></span>
					<p>이유식 무료 신청</p>
				</a>
			</div>
			<div class="column">
				<a class="notice line" href="/mobile/customer/getNoticeList.do">
					<span class="icon"></span>
					<p>공지사항</p>
				</a>
			</div>
			<div class="column">
				<a class="customer" href="tel:080-800-0433">
					<span class="icon"></span>
					<p>고객센터<br>080-800-0433</p>
				</a>
			</div>
		</div>
		<!-- //banner -->
		
		<!-- accordion -->
		<ul class="accordion">
			<li id="one" class="depth01 step01">
				<a href="#">주식(첫돌 이전)<span></span></a>
				<ul class="sub_menu">
					<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_01">초기(만4~5개월)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_01"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=1&goodsCode=0001"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_02">중기(만6~7개월)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_02"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=1&goodsCode=0002"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_03">후기(만8~9개월)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_03"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=1&goodsCode=0003"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_04">병행기(만10~11개월)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_04"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=1&goodsCode=0004"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_05">완료기2팩(만12~13개월)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_05"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=1&goodsCode=0005"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_05">완료기3팩(만12~13개월)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product01_05"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=1&goodsCode=0013"><em>주문하기</em></a></div></li>
				</ul>
			</li>
			<li id="two" class="depth01 step02">
				<a href="#">주식(첫돌 이후)<span></span></a>
				<ul class="sub_menu">
					<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product02">영양덮밥(만13~36개월)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product02"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=2&goodsCode=0007"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product03">요리반찬(만24~48개월)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product03"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=2&goodsCode=0008"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product03_1">골고루쿡(만27~72개월)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product03_1"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=2&goodsCode=0018"><em>주문하기</em></a></div></li>
				</ul>
			</li>			
			<li id="three" class="depth01 step03">
				<a href="#">이유식 재료<span></span></a>
				<ul class="sub_menu">
					<!--<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product06">셀프쿠킹(만6개월부터)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product06"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=4&goodsCode=0016"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product06">셀프쿠킹(만8개월부터)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product06"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=4&goodsCode=0017"><em>주문하기</em></a></div></li>-->
					<li class="depth02"><a href="/mobile/shop/getProductOrgaList.do">이유식재료</a> <div class="btn"><a href="/mobile/shop/getProductOrgaList.do"><em>주문하기</em></a></div></li>
				</ul>
			</li>
			<li id="four" class="depth01 step04">
				<a href="#">간식<span></span></a>
				<ul class="sub_menu">
					<li class="depth02"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product05">퓨레(만6~48개월)</a> <div class="btn"><a href="/common/forwardPage.do?forwardPage=babymeal/mobile/product/product05"><em>상세보기</em></a> <a href="/mobile/shop/getProductShop.do?categoryType=1&categorySeq=3&goodsCode=0010"><em>주문하기</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/getProductOrgaList.do">과자/음료</a> <div class="btn"><a href="/mobile/shop/getProductOrgaList.do"><em>주문하기</em></a></div></li>
				</ul>
			</li>
			<li id="five" class="depth01 step05">
				<a href="#">건강기능식품<span></span></a>
				<ul class="sub_menu">					
					<li class="depth02"><a href="/mobile/shop/getProductFullVitaList.do">풀비타</a> <div class="btn"><a href="/mobile/shop/getProductFullVitaList.do"><em>주문하기</em></a></div></li>
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
		
		<!-- event --> 
		<div id="slider2_container" class="event_slider">
			<div u="slides" class="event_slider_img">
				<div><a href=""><img src="/images/upload/banner" /></a></div>
				<div><a href=""><img src="/images/upload/banner" /></a></div>
			</div>
			<span u="arrowleft" class="arrow_left"></span>
			<span u="arrowright" class="arrow_right"></span>
		</div>
		<script>
			jQuery(document).ready(function ($) {

				var _CaptionTransitions = [];
				_CaptionTransitions["L"] = { $Duration: 900, x: 0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
				_CaptionTransitions["R"] = { $Duration: 900, x: -0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
				_CaptionTransitions["T"] = { $Duration: 900, y: 0.6, $Easing: { $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
				_CaptionTransitions["B"] = { $Duration: 900, y: -0.6, $Easing: { $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
				_CaptionTransitions["ZMF|10"] = { $Duration: 900, $Zoom: 11, $Easing: { $Zoom: $JssorEasing$.$EaseOutQuad, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 };
				_CaptionTransitions["RTT|10"] = { $Duration: 900, $Zoom: 11, $Rotate: 1, $Easing: { $Zoom: $JssorEasing$.$EaseOutQuad, $Opacity: $JssorEasing$.$EaseLinear, $Rotate: $JssorEasing$.$EaseInExpo }, $Opacity: 2, $Round: { $Rotate: 0.8} };
				_CaptionTransitions["RTT|2"] = { $Duration: 900, $Zoom: 3, $Rotate: 1, $Easing: { $Zoom: $JssorEasing$.$EaseInQuad, $Opacity: $JssorEasing$.$EaseLinear, $Rotate: $JssorEasing$.$EaseInQuad }, $Opacity: 2, $Round: { $Rotate: 0.5} };
				_CaptionTransitions["RTTL|BR"] = { $Duration: 900, x: -0.6, y: -0.6, $Zoom: 11, $Rotate: 1, $Easing: { $Left: $JssorEasing$.$EaseInCubic, $Top: $JssorEasing$.$EaseInCubic, $Zoom: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear, $Rotate: $JssorEasing$.$EaseInCubic }, $Opacity: 2, $Round: { $Rotate: 0.8} };
				_CaptionTransitions["CLIP|LR"] = { $Duration: 900, $Clip: 15, $Easing: { $Clip: $JssorEasing$.$EaseInOutCubic }, $Opacity: 2 };
				_CaptionTransitions["MCLIP|L"] = { $Duration: 900, $Clip: 1, $Move: true, $Easing: { $Clip: $JsstacysorEasing$.$EaseInOutCubic} };
				_CaptionTransitions["MCLIP|R"] = { $Duration: 900, $Clip: 2, $Move: true, $Easing: { $Clip: $JssorEasing$.$EaseInOutCubic} };

				var options = {
					$FillMode: 2,                                       //[Optional] The way to fill image in slide, 0 stretch, 1 contain (keep aspect ratio and put all inside slide), 2 cover (keep aspect ratio and cover whole slide), 4 actual size, 5 contain for large image, actual size for small image, default value is 0
					$AutoPlay: true,                                    //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
					$AutoPlayInterval: 2500,                            //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
					$PauseOnHover: 1,                                   //[Optional] Whether to pause when mouse over if a slider is auto playing, 0 no pause, 1 pause for desktop, 2 pause for touch device, 3 pause for desktop and touch device, 4 freeze for desktop, 8 freeze for touch device, 12 freeze for desktop and touch device, default value is 1

					$ArrowKeyNavigation: true,   			            //[Optional] Allows keyboard (arrow key) navigation or not, default value is false
					$SlideEasing: $JssorEasing$.$EaseOutQuint,          //[Optional] Specifies easing for right to left animation, default value is $JssorEasing$.$EaseOutQuad
					$SlideDuration: 800,                               //[Optional] Specifies default duration (swipe) for slide in milliseconds, default value is 500
					$MinDragOffsetToSlide: 20,                          //[Optional] Minimum drag offset to trigger slide , default value is 20
					//$SlideWidth: 600,                                 //[Optional] Width of every slide in pixels, default value is width of 'slides' container
					//$SlideHeight: 300,                                //[Optional] Height of every slide in pixels, default value is height of 'slides' container
					$SlideSpacing: 0, 					                //[Optional] Space between each slide in pixels, default value is 0
					$DisplayPieces: 1,                                  //[Optional] Number of pieces to display (the slideshow would be disabled if the value is set to greater than 1), the default value is 1
					$ParkingPosition: 0,                                //[Optional] The offset position to park slide (this options applys only when slideshow disabled), default value is 0.
					$UISearchMode: 1,                                   //[Optional] The way (0 parellel, 1 recursive, default value is 1) to search UI components (slides container, loading screen, navigator container, arrow navigator container, thumbnail navigator container etc).
					$PlayOrientation: 1,                                //[Optional] Orientation to play slide (for auto play, navigation), 1 horizental, 2 vertical, 5 horizental reverse, 6 vertical reverse, default value is 1
					$DragOrientation: 1,                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $DisplayPieces is greater than 1, or parking position is not 0)

					$CaptionSliderOptions: {                            //[Optional] Options which specifies how to animate caption
						$Class: $JssorCaptionSlider$,                   //[Required] Class to create instance to animate caption
						$CaptionTransitions: _CaptionTransitions,       //[Required] An array of caption transitions to play caption, see caption transition section at jssor slideshow transition builder
						$PlayInMode: 1,                                 //[Optional] 0 None (no play), 1 Chain (goes after main slide), 3 Chain Flatten (goes after main slide and flatten all caption animations), default value is 1
						$PlayOutMode: 3                                 //[Optional] 0 None (no play), 1 Chain (goes before main slide), 3 Chain Flatten (goes before main slide and flatten all caption animations), default value is 1
					},

					$ArrowNavigatorOptions: {                           //[Optional] Options to specify and enable arrow navigator or not
						$Class: $JssorArrowNavigator$,                  //[Requried] Class to create arrow navigator instance
						$ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
						$AutoCenter: 2,                                 //[Optional] Auto center arrows in parent container, 0 No, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
						$Steps: 1                                       //[Optional] Steps to go for each navigation request, default value is 1
					}
				};

				var jssor_slider1 = new $JssorSlider$("slider2_container", options);

				//responsive code begin
				//you can remove responsive code if you don't want the slider scales while window resizes
				function ScaleSlider() {
					var bodyWidth = document.body.clientWidth;
					if (bodyWidth)
						jssor_slider1.$ScaleWidth(Math.min(bodyWidth, 1920));
					else
						window.setTimeout(ScaleSlider, 30);
				}
				ScaleSlider();

				$(window).bind("load", ScaleSlider);
				$(window).bind("resize", ScaleSlider);
				$(window).bind("orientationchange", ScaleSlider);
				//responsive code end
			});
		</script>
		<!-- //event -->
		
		<!-- faq -->
		<div class="main_faq">
			<a href="/mobile/customer/getInquiryForm.do"><img src="/images/mobile/inquiry_text.png" alt="주문/배송 간편문의 남기기!" width="300px" /></a>
		</div>
        <!-- //faq -->
	</div>
	<!-- End content -->
	<%@ include file="/mobile/common/include/inc-footer.jsp"%>
</div>
</body>
</html>