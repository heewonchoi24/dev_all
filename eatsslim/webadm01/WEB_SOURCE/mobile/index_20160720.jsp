<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
	
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
	</script>

	<style>
	/* [s] ���� */
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
				<!--h2>�ս��� ��ǥ �̹���</h2-->
				<li><a href="http://www.eatsslim.co.kr/mobile/shop/healthyMeal.jsp"><img src="images/main_img1.jpg" alt="�ս��� ����ǰ �ﾾ����" />
				<!--p class="p1">�� ���� ���� �ǰ��� �ѳ�,<br /><span class="f1">�ǰ� ���ö� "�ﾾ ����"</span><br /><span class="box">�ڼ������� Ŭ�� ></span></p--></a></li>
				<li><a href="http://www.eatsslim.co.kr/mobile/shop/dietMeal.jsp"><img src="images/main_img2.jpg" alt="�Ļ� ���̾�Ʈ" />
				<!--p class="p2">�Ϸ� �ѳ�, �γ�, ����<br /><span class="f2">���ϴ� Style��, ���ϴ� ���ϸ�ŭ!</span><br ><span class="box">�ڼ������� Ŭ��></span></p--></a></li>
				<li><a href="http://www.eatsslim.co.kr/mobile/shop/weight2weeks.jsp"><img src="images/main_img3.jpg" alt="���̾�Ʈ ���α׷�" />
				<!--p class="p3">�ӻ󿵾�簡 ���� ������ ������ ���̾�Ʈ ���α׷�!<br /><span class="f3">������ ��! �´� ���α׷�!</span><br ><span class="box">�ڼ������� Ŭ��></span></p--></a></li>
				<li><a href="http://www.eatsslim.co.kr/mobile/shop/minimeal.jsp"><img src="images/main_img4.jpg" alt="������" />
				<!--p class="p4">�������� ���ְ�, ����� �ѳ���<br />�Ǵ� ���̾�Ʈ ��������!<br /><span class="f4">�뷱������ũ�� �ս��� �̴Ϲ�!</span><br ><span class="box">�ڼ������� Ŭ��></span></p--></a></li>
			</ul>
		</article>

		<!-- banner -->
		<div class="banner_cont clearfix">
			<div class="column">
				<a class="menu line" href="/mobile/intro/schedule.jsp">
					<span class="icon"></span>
					<p>�̴��� �Ĵ�</p>
				</a>
			</div>
			<div class="column">
				<a class="deliver line" href="/mobile/shop/mypage/orderList.jsp">
					<span class="icon"></span>
					<p>�ֹ�/��� ��ȸ</p>
				</a>
			</div>
			<div class="column">
				<a class="order" href="/mobile/delivery/delivery.jsp">
					<span class="icon"></span>
					<p>�������Ȯ��</p>
				</a>
			</div>
		</div>
		<div class="banner_cont clearfix">
			<div class="column">
				<a class="free line" href="/mobile/customer/service.jsp">
					<span class="icon"></span>
					<p>�ֹ��ȳ�</p>
				</a>
			</div>
			<div class="column">
				<a class="notice line" href="/mobile/customer/notice.jsp">
					<span class="icon"></span>
					<p>��������</p>
				</a>
			</div>
			<div class="column">
				<a class="customer" href="/mobile/customer/indiqna.jsp">
					<span class="icon"></span>
					<p>1:1����</p>
				</a>
			</div>
		</div>
		<!-- //banner -->
		
		<!-- event -->
		<article class="event_main">
			<h2>�ս��� �̺�Ʈ</h2>
			<ul id="slider2">
				<li><a href="/mobile/event/view.jsp?id=240&pgsize=10"><img src="images/event_ban4.jpg" alt="�ս����̺�Ʈ" /></a></li>
				<li><a href="/mobile/event/view.jsp?id=238&pgsize=10"><img src="images/event_ban1.jpg" alt="�ս����̺�Ʈ" /></a></li>
				<li><a href="/mobile/event/view.jsp?id=237&pgsize=10"><img src="images/event_ban2.jpg" alt="�ս����̺�Ʈ" /></a></li>
				<li><a href="/mobile/event/view.jsp?id=236&pgsize=10"><img src="images/event_ban3.jpg" alt="�ս����̺�Ʈ" /></a></li>
			</ul>
		</article>

    <!-- //event -->
		<!-- accordion -->
		<ul class="accordion clearfix">
			<li id="one" class="depth01 step001">
				<a href="#">�ǰ����ö�<span></span></a>
				<ul class="sub_menu">
					<li class="depth02"><a href="/mobile/shop/healthyMeal.jsp">�ﾾ����</a> <div class="btn"><a href="/mobile/shop/healthyMeal.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/healthyMeal-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
				</ul>
			</li>
			<li id="two" class="depth01 step002">
				<a href="#">�Ļ� ���̾�Ʈ<span></span></a>
				<ul class="sub_menu">
					<li class="depth02"><a href="/mobile/shop/dietMeal.jsp">����</a> <div class="btn"><a href="/mobile/shop/dietMeal.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/dietMeal-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/dietMeal-alacarteA.jsp">�˶��� ����</a> <div class="btn"><a href="/mobile/shop/dietMeal-alacarteA.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/dietMeal-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/dietMeal-alacarteB.jsp">�˶��� �ﾾ</a> <div class="btn"><a href="/mobile/shop/dietMeal-alacarteB.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/dietMeal-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
				</ul>
			</li>			
			<li id="three" class="depth01 step003">
				<a href="#">���α׷� ���̾�Ʈ<span></span></a>
				<ul class="sub_menu">
					<li class="depth02"><a href="/mobile/shop/weight3days.jsp">3�� ���α׷�</a> <div class="btn"><a href="/mobile/shop/weight3days.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/weight3days-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/weight2weeks.jsp">���߰��� 2��</a> <div class="btn"><a href="/mobile/shop/weight2weeks.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/weight2weeks-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/fullStep.jsp">����&���� 4��</a> <div class="btn"><a href="/mobile/shop/fullStep.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/dietProgram-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/cleanseProgram.jsp">Ŭ���� ���α׷�</a> <div class="btn"><a href="/mobile/shop/cleanseProgram.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/cleanseProgram-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/smartgram.jsp">����Ʈ�׷�</a> <div class="btn"><a href="/mobile/shop/smartgram.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/smartgram-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/speed4weeks.jsp">���ǵ� ���α׷�</a> <div class="btn"><a href="/mobile/shop/speed4weeks.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/speed4weeks-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
				</ul>
			</li>
			<li id="four" class="depth01 step004">
				<a href="#">������<span></span></a>
				<ul class="sub_menu">
					<li class="depth02"><a href="/mobile/shop/minimeal.jsp">�̴Ϲ�</a> <div class="btn"><a href="/mobile/shop/minimeal.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/minimeal-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/secretSoup.jsp">�뷱������ũ</a> <div class="btn"><a href="/mobile/shop/balanceShake.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/balanceShake-order.jsp"> <em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/balanceShake.jsp">��ũ������</a> <div class="btn"><a href="/mobile/shop/secretSoup.jsp"><em>�󼼺���</em></a><a href="/mobile/shop/dietSoup-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
				</ul>
			</li>
			<li id="five" class="depth01 step005">
				<a href="#">�ǰ���ɽ�ǰ<span></span></a>
				<ul class="sub_menu">					
					<li class="depth02"><a href="/mobile/shop/dietCLA.jsp">���̾�ƮCLA</a> <div class="btn"><a href="/mobile/shop/dietCLA.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/dietCLA-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/digest.jsp">��������Ʈ</a> <div class="btn"><a href="/mobile/shop/digest.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/digest-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/womanBalance.jsp">��չ뷱��</a> <div class="btn"><a href="/mobile/shop/womanBalance.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/womanBalance-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/lock.jsp">���</a> <div class="btn"><a href="/mobile/shop/lock.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/lock-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/vitaminD.jsp">Į����Ÿ��D</a> <div class="btn"><a href="/mobile/shop/vitaminD.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/vitaminD-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
					<li class="depth02"><a href="/mobile/shop/chewable.jsp">������Ƽ����C</a> <div class="btn"><a href="/mobile/shop/chewable.jsp"><em>�󼼺���</em></a> <a href="/mobile/shop/chewable-order.jsp"><em>�ֹ��ϱ�</em></a></div></li>
				</ul>
			</li>
			<!--<li id="siz" class="depth01 step06">
				<a href="#">���ۺ��ߵ�<span></span></a>
				<ul class="sub_menu">					
					<li class="depth02"><a href="/mobile/shop/getProductDealList.do">���ۺ��ߵ�</a> <div class="btn"><a href="/mobile/shop/getProductDealList.do"><em>�ֹ��ϱ�</em></a></div></li>
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
			<a href="/mobile/customer/getInquiryForm.do"><img src="/images/mobile/inquiry_text.png" alt="�ֹ�/��� �������� �����!" width="300px" /></a>
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