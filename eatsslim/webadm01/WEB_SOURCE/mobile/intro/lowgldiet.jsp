<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>

<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/orderGuide.css">
</head>
<body>
<div id="wrap">
  <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
    <%@ include file="/mobile/common/include/inc-header.jsp"%>
  </div>
  <!-- End ui-header -->
  <!-- Start Content -->
  <div id="content" class="oldClass">
    <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">브랜드스토리</span></span></h1>
    <div class="grid-navi eatsstory">
      <table class="navi" cellspacing="10" cellpadding="0">
        <tr>
          <td><a href="/mobile/intro/eatsslimStory.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">잇슬림<br />
            스토리</span></span></a></td>
          <td><a href="/mobile/intro/eatsslimFeature.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">잇슬림<br />
            특징</span></span></a></td>
          <td><a href="/mobile/intro/lowgldiet.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">Why <br />
            잇슬림</span></span><span class="active"></span></a></td>
          <td><a href="/mobile/intro/eatsslimCounsel.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">자문단<br />
            소개</span></span></a></td>
          <td><a href="/mobile/intro/eatsslimCkitchen.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">스마트<br />
            키친</span></span></a></td>
        </tr>
      </table>
    </div>

            <div class="row" id="orderGuide">
				<div class="orderGuideTop">
					목표 섭취 칼로리에 맞는 <span>상품군을 선택</span>하세요.<br/> 상품군을 선택하셨다면, <span>상품군별 세부조건 선택</span>하세요.
				</div>
				<ul class="accordion">
					<li class="accordion1">
						<a href="#" class="active">식사중심의 칼로리 조절 식사</a>
						<div class="acc_content">
							<div class="inner">
								<div class="acc_contentTop">
									<p>원하는 스타일의 잇슬림 식사 제품으로 1일 구성 식수, 기간 등을 자유롭게 설정할 수 있는 칼로리 조절 식사</p>
									<ul class="col4">
										<li>
											<img src="/mobile/common/images/guide/ico_1_1.png">
											<p>1일 1식</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_1_2.png">
											<p>1일 1식<br/>+간편식</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_1_3.png">
											<p>1일 2식</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_1_4.png">
											<p>1일 3식</p>
										</li>
									</ul>
								</div>
								<ul class="prd_list">
									<li>
										<div class="photo"><img src="/images/order_guide_img_1_1.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_1.jpg"> --> <div class="cal_info"><p>400Kcal 내외</p></div></div>
										<div class="info">
											<p class="title">퀴진(총22종 메뉴)</p>
											<p class="dec">칼로리 Down, 나트륨 Down 과학적인 영양 설계로 디자인한 칼로리 조절 식사</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=1&menuS=1&eatCoun=">자세히보기</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0300700&cartId=32&groupCode=0300717&pramType=list">바로구매</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_1_2.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_1.jpg"> --> <div class="cal_info"><p>300Kcal 내외</p></div></div>
										<div class="info">
											<p class="title">알라까르떼 슬림(총 10종 메뉴)</p>
											<p class="dec">신선한 채소에 영양 가득한 토핑을 곁들여 포만감도 느낄 수 있는 요리형 샐러드</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=1&menuS=2&eatCoun=">자세히보기</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0300702&cartId=34&groupCode=0300719&pramType=list">바로구매</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_1_3.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_1.jpg"> --> <div class="cal_info"><p>300Kcal 내외</p></div></div>
										<div class="info">
											<p class="title">알라까르떼 헬씨(총 10종 메뉴)</p>
											<p class="dec">간편하고 든든하게 즐길 수 있는 One-dish 형태의 칼로리 조절 식사</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=1&menuS=3&eatCoun=">자세히보기</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0300965&cartId=43&groupCode=0300957&pramType=list">바로구매</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_1_4.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_1.jpg"> --> <div class="cal_info"><p>200Kcal 내외</p></div></div>
										<div class="info">
											<p class="title">미니밀(총 6종 메뉴)</p>
											<p class="dec">식이섬유가 풍부한 건강잡곡밥과 슈퍼푸드로 칼로리는 낮추고 영양은 더한 간편한 영양 컵밥</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=1&menuS=4&eatCoun=">자세히보기</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=52&groupCode=0300993&pramType=list">바로구매</a>
											</div>
										</div>
									</li>
								</ul>
								<!-- <div class="bx">
									<div class="bx_top">
										<div class="title">다이어트 식사를 <span>선택</span>하셨나요?</div>
										<p>다이어트에 도움이 되는 간편식을 <span>같이 주문하시면 보다 좋은 효과</span>를 보실 수 있습니다.</p>
									</div>
									<ul class="prd_list style2">
										<li>
											<div class="photo"><img src="/mobile/common/images/guide/temp_prd_1_4.jpg"></div>
											<div class="info">
												<p class="dec">칼로리 걱정없이 기분좋은 든든함으로 한손에 쏙~간편하게 즐기는 <span>잇슬림 미니밀!</span></p>
												<div class="btns">
													<a href="#">자세히 보기</a>
													<a href="#">바로구매</a>
												</div>
											</div>
										</li>
										<li>
											<div class="photo"><img src="/mobile/common/images/guide/temp_prd_1_5.jpg"></div>
											<div class="info">
												<p class="dec">칼로리는 낮추고, 영양은 채운 체중조절용 식품, 7가지 곡물과 현미 퍼핑으로 고소한 맛의 <span>밸런스 쉐이크!</span></p>
												<div class="btns">
													<a href="#">자세히 보기</a>
													<a href="#">바로구매</a>
												</div>
											</div>
										</li>
									</ul>
								</div> -->
							</div>
						</div>
					</li>
					<li class="accordion2">
						<a href="#">목적별 칼로리 조절 프로그램</a>
						<div class="acc_content">
							<div class="inner">
								<div class="acc_contentTop">
									<p>목표 섭취 칼로리에 따라 잇슬림에서 제안하는 칼로리 조절 전문 프로그램</p>
									<ul class="col4">
										<li>
											<img src="/mobile/common/images/guide/ico_2_1.png">
											<p>단기<br/>프로그램</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_2_2.png">
											<p>칼로리 조절<br/>프로그램</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_2_3.png">
											<p>클렌즈<br/>프로그램</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_2_4.png">
											<p>스마트그램</p>
										</li>
									</ul>
								</div>
								<ul class="prd_list">
									<li>
										<div class="photo"><img src="/images/order_guide_img_2_1.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_2.jpg"> --> <div class="cal_info"><p>1000Kcal(1일) 내외</p></div></div>
										<div class="info">
											<p class="title">단기 프로그램</p>
											<p class="dec">단기간에 칼로리 조절을 목적으로 하는 분들을 위한 3일, 6일 구성의 단기 프로그램</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=2&menuS=1">자세히보기</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=54&groupCode=0300978&pramType=list">바로구매</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_2_2.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_3.jpg"> --> <div class="cal_info"><p>1200Kcal(1일) 내외</p></div></div>
										<div class="info">
											<p class="title">칼로리 조절 프로그램</p>
											<p class="dec">목적별, 기간별로 최적화된 영양 설계를 바탕으로 한 잇슬림의 대표 칼로리 조절 프로그램</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=2&menuS=2">자세히보기</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=88&groupCode=024&pramType=list">바로구매</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_2_3.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_4.jpg"> --> <div class="cal_info"><p>900Kcal(1일) 내외</p></div></div>
										<div class="info">
											<p class="title">클렌즈 프로그램</p>
											<p class="dec">리프레시 클렌즈 주스를 통한 건강한 체내 비움 이후 잇슬림 식단으로 칼로리 조절을 제안하는 프로그램</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=2&menuS=3">자세히보기</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=82&groupCode=02271&pramType=list">바로구매</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_2_4.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_5.jpg"> --> <div class="cal_info"><p>800Kcal(1일) 내외</p></div></div>
										<div class="info">
											<p class="title">스마트그램</p>
											<p class="dec">10g까지 정확한 스마트 체중계와 App으로 구성된 그램바이그램과 잇슬림 식단을 제안하는 스마트한 프로그램</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=2&menuS=4">자세히보기</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=85&groupCode=02411&pramType=list">바로구매</a>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</li>
					<li class="accordion3">
						<a href="#">내 몸을 위한 건강식</a>
						<div class="acc_content">
							<div class="inner">
								<div class="acc_contentTop">
									<p>건강 관리와 칼로리 조절을 위해 과학적인 영양을 적용한 건강한 식사 제품 </p>
									<ul class="col2">
										<li>
											<img src="/mobile/common/images/guide/ico_3_1.png">
											<p>1일 1식</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_3_2.png">
											<p>1일 2식</p>
										</li>
									</ul>
								</div>
								<ul class="prd_list">
									<li>
										<div class="photo"><img src="/images/order_guide_img_3_1.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_6.jpg"> --> <div class="cal_info"><p>500Kcal 내외</p></div></div>
										<div class="info">
											<p class="title">헬씨퀴진(20종 메뉴)</p>
											<p class="dec">건강관리와 칼로리 조절을 동시에 할 수 있는 균형잡힌 건강 도시락</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=3&menuS=1&eatCoun=">자세히보기</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0301369&cartId=89&groupCode=0301369&pramType=list">바로구매</a>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</li>
				</ul>
            </div>
  <!-- End Content -->
  <div class="ui-footer">
    <%@ include file="/mobile/common/include/inc-footer.jsp"%>
  </div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		// Store variables
		var accordion_head = $('.accordion > li > a'),
			accordion_body = $('.accordion > li > .acc_content');
		// Open the first tab on load
		accordion_head.first().addClass('active').next().slideDown('normal');
		// Click function
		accordion_head.on('click', function(e) {
			// Disable header links
			e.preventDefault();
			// Show and hide the tabs on click
			var _this = $(this);
			if (_this.attr('class') != 'active'){
				accordion_body.slideUp('normal');
				_this.next().stop(true,true).slideToggle('normal', function() {
					$("html, body").stop().animate({scrollTop:_this.offset().top}, 500, 'swing');
				});
				accordion_head.removeClass('active');
				_this.addClass('active');
			}else{
				accordion_body.slideUp('normal');
				accordion_head.removeClass('active');
			}
		});
	});
</script>
</body>
</html>