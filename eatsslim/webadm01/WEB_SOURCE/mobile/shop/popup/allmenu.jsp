<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>

</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<div class="iconQuickBtn">
			<a href="javascript:;" onClick="moveUrl('http://www.eatsslim.co.kr/mobile/index.jsp');"><span class="home"></span>����</a>
			<a href="javascript:;" onClick="moveUrl('/mobile/shop/cart.jsp');"><span class="cart"></span>��ٱ���</a>
		</div>
		<button id="cboxClose" type="button">close</button>
		<div class="clear"></div>
	</div>
	<div class="contentpop">
		<ul class="ui-listview">
			<li class="ui-li ui-li-static ui-btn-up-c ui-first-child"><a href="javascript:;" onClick="moveUrl('/mobile/customer/service.jsp');" class="font-blue">��ǰ�ȳ�</a></li>
			<ul class="ui-listview">
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/goods/cuisine.jsp');">��ǰ�Ұ�</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/customer/service.jsp');">�ֹ��ȳ�</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/intro/schedule.jsp');">�̴��� �Ĵ�</a></li>
			</ul>
			<li class="ui-li ui-li-static ui-btn-up-c"><a href="javascript:;" onClick="moveUrl('/mobile/shop/dietMeal.jsp');" class="font-blue">SHOP</a></li>
			<ul class="ui-listview">
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/healthyMeal.jsp');">�ﾾ����</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/dietMeal.jsp');">�Ļ� ���̾�Ʈ</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/fullStep.jsp');">���α׷� ���̾�Ʈ</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/secretSoup.jsp');">Ÿ�Ժ� ���̾�Ʈ</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/dietCLA.jsp');">��Ÿ ��ǰ</a></li>
			</ul>
			<li class="ui-li ui-li-static ui-btn-up-c"><a href="javascript:;" onClick="moveUrl('/mobile/intro/eatsslimStory.jsp');" class="font-blue">�ս��� �Ұ�</a></li>
            <li class="ui-li ui-li-static ui-btn-up-c"><a href="javascript:;" onClick="moveUrl('/mobile/delivery/delivery.jsp');" class="font-blue">��޾ȳ�</a></li>
			<ul class="ui-listview">
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/delivery/delivery.jsp');">��� ��������</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/delivery/deliveryGuide.jsp');">��� �󼼾ȳ�</a></li>
			</ul>
			<li class="ui-li ui-li-static ui-btn-up-c"><a href="javascript:;" onClick="moveUrl('/mobile/shop/mypage/index.jsp');" class="font-blue">����������</a></li>
			<ul class="ui-listview">
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/mypage/index.jsp');">���������� Ȩ</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/mypage/orderList.jsp');">�ֹ�/���</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/mypage/couponSearch.jsp');">��������</a></li>
				<li class="ui-li ui-li-static ui-btn-up-e"><a href="javascript:;" onClick="moveUrl('/mobile/shop/mypage/myqna.jsp');">1:1����</a></li>
			</ul>
			<li class="ui-li ui-li-static ui-btn-up-c"><a href="javascript:;" onClick="moveUrl('/mobile/event/index.jsp');" class="font-blue">�̺�Ʈ</a></li>
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