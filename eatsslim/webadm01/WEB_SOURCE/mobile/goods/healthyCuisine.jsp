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
			   <td><a href="/mobile/goods/healthyCuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">헬씨퀴진</span></span><span class="active"></span></a></td>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">퀴진</span></span></a></td>
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
                            사계절 신선한 자연 식재료를 적용하여 영양설계된 건강 도시락
                        </span>
                        <p class="goods-caption">나트륨,칼로리 조정, LowGL설계로<br />디자인된 맛있는 식사, <strong>헬씨퀴진</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/healthyCuisine_goods_img01.jpg" width="235" height="160" alt="헬씨퀴진"></div>
                   <h2 class="font-wbrown">자연을 담은 건강 도시락!</h2>
                   <p>사계절 신선한 제철 자연 식재료를 적용하여 나물, 샐러드 등의 채소 2가지, 잡곡밥, 튀기지 않는 조리법을 적용한 건강 도시락</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">체중 관리 및 건강 관리!</h2>
                   <p>내몸을 위한 건강 관리와 체중 관리가 가능하도록 설계된 제품 </p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">과학적인 영양설계!</h2>
                   <p>대한지역사회영양학회 영양자문, 1식 기준 kcal 평균 500kcal이하 , 나트륨 평균 950mg이하, 40eGL의 영양설계 적용</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">1식 40eGL설계 잇슬림 Low GL!</h2>
				   <p>GL(Glycemic load)은 식후 혈당 변화량을 나타내는 지표로, 동일한 열량을 섭취하더라도 GL(혈당부하)이 낮은 식사는 혈당을 많이 올리지 않아 인슐린의 과다 분비와 체지방 축적을 예방 가능. <br />
				   한국인은 High GL식을 섭취하고 있어 복부비만과 대사증후군 위험이 높으며, Low GL식사는 혈당의 변화랑이 크지 않고, 안정적으로 유지할 수 있어 포만감 유지와 식욕 조절에 도움</p>
                   <p><br /><strong>* eGL(estimated Glycemic Load)은 GL을 추정하기 위하여 풀무원에서 임상연구를 통해 개발한 GL계산법으로 한국인 평균 섭취 eGL은 1일 162eGL, 헬씨퀴진은 1일 120eGL원칙 적용!</strong></p>
               </div>
           </div>


  		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/popup/dietmeal_info.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
					<td><a href="/mobile/shop/healthyMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">헬씨퀴진 구매하기</span></span></a></td>
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