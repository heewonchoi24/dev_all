<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>

</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<div class="iconQuickBtn">
			<a href="javascript:;" onClick="moveUrl('http://www.eatsslim.co.kr/mobile/index.jsp');"><span class="home"></span>메인</a>
			<a href="javascript:;" onClick="moveUrl('/mobile/shop/cart.jsp');"><span class="cart"></span>장바구니</a>
		</div>
		<button id="cboxClose" type="button">close</button>
		<div class="clear"></div>
	</div>
	<div class="contentpop">
		<ul class="ui-listview">
			<li class="ui-li ui-li-static ui-btn-up-c ui-first-child"><a href="javascript:;" onClick="moveUrl('/mobile/customer/service.jsp');" class="font-blue">상품안내</a></li>
			<ul class="ui-listview">
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/goods/cuisine.jsp');">제품소개</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/customer/service.jsp');">주문안내</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/intro/schedule.jsp');">이달의 식단</a></li>
			</ul>
			<li class="ui-li ui-li-static ui-btn-up-c"><a href="javascript:;" onClick="moveUrl('/mobile/shop/dietMeal.jsp');" class="font-blue">SHOP</a></li>
			<ul class="ui-listview">
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/healthyMeal.jsp');">헬씨퀴진</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/dietMeal.jsp');">식사 다이어트</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/fullStep.jsp');">프로그램 다이어트</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/secretSoup.jsp');">타입별 다이어트</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/dietCLA.jsp');">기타 제품</a></li>
			</ul>
			<li class="ui-li ui-li-static ui-btn-up-c"><a href="javascript:;" onClick="moveUrl('/mobile/intro/eatsslimStory.jsp');" class="font-blue">잇슬림 소개</a></li>
            <li class="ui-li ui-li-static ui-btn-up-c"><a href="javascript:;" onClick="moveUrl('/mobile/delivery/delivery.jsp');" class="font-blue">배달안내</a></li>
			<ul class="ui-listview">
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/delivery/delivery.jsp');">배달 가능지역</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/delivery/deliveryGuide.jsp');">배달 상세안내</a></li>
			</ul>
			<li class="ui-li ui-li-static ui-btn-up-c"><a href="javascript:;" onClick="moveUrl('/mobile/shop/mypage/index.jsp');" class="font-blue">마이페이지</a></li>
			<ul class="ui-listview">
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/mypage/index.jsp');">마이페이지 홈</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/mypage/orderList.jsp');">주문/배송</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/mypage/couponSearch.jsp');">쿠폰내역</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/mypage/myqna.jsp');">1:1문의</a></li>
			</ul>
			<li class="ui-li ui-li-static ui-btn-up-c"><a href="javascript:;" onClick="moveUrl('/mobile/event/index.jsp');" class="font-blue">이벤트</a></li>
		</ul>
	</div>
	<!-- End contentpop -->
</div>
<script type="text/javascript">
function moveUrl(url) {
	parent.location.href = url;
}
</script>
</body>
</html>