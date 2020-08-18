<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <!-- <ul class="subnavi">
                   <li class="current"><a href="/mobile/goods/cuisine.jsp">제품소개</a></li>
            <li><a href="/mobile/intro/schedule.jsp">이달의 식단</a></li>
                   <li><a href="/mobile/customer/service.jsp">주문안내</a></li>
                </ul> -->
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content" class="oldClass">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">제품소개</span></span></h1>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
			     <td><a href="/mobile/goods/healthyCuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">헬씨퀴진</span></span></a></td>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">퀴진</span></span><span class="active"></span></a></td>
                 <td><a href="/mobile/goods/alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">알라까르떼</span></span></a></td>
				</tr>
				<tr>
                 <td><a href="/mobile/goods/minimeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">미니밀</span></span></a></td>
				 <td><a href="/mobile/goods/secretSoup.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">시크릿수프</span></span></a></td>
				 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">밸런스쉐이크</span></span></a></td>
			   </tr>
           </table>
           </div>

           <div class="row">
               <div class="goods cuisine">
                   <div class="top-wrap">
                        <span class="goods-copy bg-brown">
                            균형있는 영양설계와 다양한 메뉴는 기본
                        </span>
                        <p class="goods-caption">나트륨Down & 칼로리Down으로<br />디자인된 맛있는 식사, <strong>퀴진</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/goods_img01.png" width="235" height="160" alt="퀴진"></div>
                   <h2 class="font-wbrown">과학적인 영양설계</h2>
                   <p>GI/GL의 원리를 다이어트 식사에 적용하여, 탄수화물 특성에 따른 열량의 체내 흡수율을 고려하고, 그에 따른 적합한 식단을 설계</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">안전한 냉장온도 유지</h2>
                   <p>출고 후 고객이 배달받기까지 냉장 0~10˚C로 유지될 수 있도록 풀무원 극신선배송시스템으로 냉장차량온도 관리 및 보냉팩키지 설계</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">쉽고 간편한 식사</h2>
                   <p>식사준비 필요없이 가정(사무실)에서 데우기만 하면 OK! 평균 367Kcal의 다이어트 전문 식단</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">나트륨기준 충족</h2>
                   <p>식이섬유와 단백질이 풍부한 식사구성을 지향하며, 일일 2,000mg나트륨기준을 충족하여 설계</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">호텔출신 쉐프팀이 펼치는 각국 대표요리</h2>
                   <p>각국 도시의 대표요리가 호텔 출신 잇슬림 쉐프들의 손을 거쳐 과학적인 다이어트식으로 재탄생 </p>
               </div>
           </div>


  		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/popup/dietmeal_info.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
					<td><a href="/mobile/shop/dietMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">식사 다이어트 구매하기</span></span></a></td>
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