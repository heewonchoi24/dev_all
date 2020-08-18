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
    <div id="content" class="oldClass">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">제품소개</span></span></h1>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
			     <td><a href="/mobile/goods/healthyCuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">헬씨퀴진</span></span></a></td>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">퀴진</span></span></a></td>
                 <td><a href="/mobile/goods/alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">알라까르떼</span></span></a></td>
				</tr>
				<tr>
                 <td><a href="/mobile/goods/minimeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">미니밀</span></span></a></td>
				 <td><a href="/mobile/goods/secretSoup.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">시크릿수프</span></span><span class="active"></span></a></td>
				 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">밸런스쉐이크</span></span></a></td>
			   </tr>
           </table>
           </div>

           <div class="row">
               <div class="goods ssoup">
                   <div class="top-wrap">
                        <span class="goods-copy bg-brown">
                            홈메이드타입·다이어트수프
                        </span>
                        <p class="goods-caption">6가지 채소의 비법레시피,<br /><strong>잇슬림 시크릿수프(HOT)</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/goods_img03_01.png" width="235" height="160" alt="시크릿수프"></div>
                   <h2 class="font-wbrown">칼로리 Down</h2>
                   <p>탄수화물의 특성을 고려한 원재료를 구성으로 섭취한 열량대비 체내에서 흡수되는 열량을 낮추도록 설계.</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">즐거운 다이어트</h2>
                   <p>토마토 파스타, 팥죽, 미역국 컨셉으로 맛까지 잡은 즐거운 다이어트</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">비법재료와 레시피</h2>
                   <p>6가지 비법재료로 만든 홈메이드타입 다이어트 수프입니다. 열량은 낮고 영양이 풍부한 레드빈(팥)과 율무, 곤약, 닭가슴살, 이집트콩등을 함유한 잇슬림만의 비법 레시피!</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">Beauty&Balance</h2>
                   <p>장내 배변활동을 원활하게 도와주는 식이섬유와 뷰티레시피 콜라겐을 넣어 다이어트 기간에 부족하기 쉬운 밸런스 맞춤</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">따뜻하게 데워서 즐기는 홈메이드 타입 다이어트 수프</h2>
                   <div class="divider"></div>
                   <p><img width="100%" src="/mobile/images/eatsslim_goods03.jpg"></p>
                   <div class="divider"></div>
                   <h3 class="font-wbrown">시크릿수프 스케줄</h3>
                   <p><img width="100%" src="/mobile/images/eatsslim_goods03_01_01.jpg"></p>
               </div>
           </div>


  	<div class="grid-navi">
      <table class="navi" border="0" cellspacing="10" cellpadding="0">
        <tr>
          <td><a href="/mobile/shop/popup/ssoup_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
          <td><a href="/mobile/shop/dietSoup-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">시크릿수프 구매하기</span></span></a></td>
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