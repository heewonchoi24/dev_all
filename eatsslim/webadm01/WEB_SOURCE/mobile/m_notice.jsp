<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>


	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/idangerous.swiper.css" />
	<script src="/mobile/common/js/idangerous.swiper.js" type="text/javascript"></script>

	<!-- <link href="/mobile/common/css/main_style.css" rel="stylesheet" /> -->
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

	</style>

	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/stylesheet_n2.css" />
	<script type="text/javascript" src="/mobile/common/js/jssor.js"></script>
	<script type="text/javascript" src="/mobile/common/js/jssor.slider.js"></script>
	<meta name="format-detection" content="telephone=no" />
</head>

<body class="">
<div id="wrap" class="expansioncss">

	<div id="main_container1">

		<!-- main_slider -->
		<div class="visual_area1">
			<div class="main_visual">
				<img src="/mobile/images/notice/01.jpg" alt="잇슬림 주문 변경안내" border="0" />
				<img src="/mobile/images/notice/02.jpg" alt="잇슬림 주문 변경안내" border="0" />
				<img src="/mobile/images/notice/03.jpg" alt="잇슬림 주문 변경안내" border="0" />
				<img src="/mobile/images/notice/04.jpg" alt="잇슬림 주문 변경안내" border="0" />
			</div>

			<div class="main_visual_count1">
				<span class="current"></span>/<span class="total"></span>
			</div> 

		</div>
	
		</div>
		</div>
	</div>
	<!-- End content -->

</body>

</html>