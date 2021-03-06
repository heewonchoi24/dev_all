<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content" class="esMinimeal oldClass">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">제품소개</span></span></h1>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
			     <td><a href="/mobile/goods/healthyCuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">헬씨퀴진</span></span></a></td>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">퀴진</span></span></a></td>
                 <td><a href="/mobile/goods/alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">알라까르떼</span></span></a></td>
				</tr>
				<tr>
                 <td><a href="/mobile/goods/minimeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">미니밀</span></span><span class="active"></span></a></td>
				 <td><a href="/mobile/goods/secretSoup.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">시크릿수프</span></span></a></td>
				 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">밸런스쉐이크</span></span></a></td>
			   </tr>
           </table>
           </div>

           <div class="row">
               <div class="goods ssoup">
                   <div class="top-wrap">
                        <span class="goods-copy bg-brown">
                            한손에 쏙, 간편하게 즐기는 미니컵밥
                        </span>
                        <p class="goods-caption">칼로리 걱정없이 기분좋은 든든함,<br /><strong>잇슬림 미니밀</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/esMinimeal01.png" width="235" height="160" alt="잇슬림 라이스"></div>
                   <h2 class="font-wbrown">Simple! 미니컵 타입으로 한손으로 간편하게</h2>
                   <p>언제 어디서나 간편하게 한끼 해결! 다이어터, 바쁜 직장인 등 현대인들의 건강한 한 끼를 위해 Mini- Cup 타입으로 한손에 들고, 간편하게 섭취하는 One-dish meal</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">Healthy! 슈퍼곡물, 푸드로 건강한 다이어트를</h2>
                   <p>슈퍼곡물 퀴노아와 귀리를 비롯한 흑미, 자수정보리, 현미 등 모든 메뉴에 건강 잡곡을 사용한 밥으로 건강함을! 슈퍼푸드 녹차 및 우엉, 두부 등 다이어트에 도움을 주는 재료를 사용!</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">Tasty! 다이어트중에도 맛있게 먹자!</h2>
                   <p>200kcal지만 포만감을 주는 식재료 구성으로 든든하고 맛있게 즐길 수 있는 잇슬림 미니밀! 식이섬유가 풍부해 포만감을 더하는 녹차, 귀리, 유기 현미  등의 식재료 사용!</p>
                   <div class="divider"></div>
               </div>
           </div>


               <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
			   <td><a href="/mobile/shop/popup/ssoup_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
                 <td><a href="/mobile/shop/minimeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">미니밀 구매하기</span></span></a></td>
               </tr>
           </table>
           </div>
		     </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>