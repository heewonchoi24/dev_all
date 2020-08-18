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
				 <td><a href="/mobile/goods/secretSoup.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">시크릿수프</span></span></a></td>
				 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">밸런스쉐이크</span></span><span class="active"></span></a></td>
			   </tr>
           </table>
           </div>

           <div class="row">
               <div class="goods balshake">
                   <div class="top-wrap">
                        <span class="goods-copy bg-brown">
                            고소한·곡물맛에·현미퍼핑으로·씹는·즐거움까지
                        </span>
                        <p class="goods-caption">칼로리는 낮추고 영양은 채운<br /><strong>잇슬림 밸런스 쉐이크</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/goods_img04.png" width="235" height="160" alt="시크릿수프"></div>
                   <h2 class="font-wbrown">고소하게 맛있다!</h2>
                   <p>7가지곡물과 현미퍼핑으로 고소한 맛에 씹는 맛까지 더해 맛있는 다이어트 가능!</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">칼로리는 낮추고 영양은 채웠다!</h2>
                   <p>칼로리는 낮추고, 영양은 채워 건강하게 다이어트를 할 수 있도록 설계된 체중조절용 식품</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">식이섬유와 유산균이 Plus!</h2>
                   <p>식이섬유(1포당 5.5g이 함유)와 장건강에 좋은 유산균(PMO 08)을 함께!</p>
                   <div class="divider"></div>
                   <p><img width="100%" src="../images/eatsslim_goods04.jpg"></p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">섭취량 및 섭취방법</h2>
                   <h3>섭취량 및 방법</h3>
                   <ul class="dot">
                      <li>한 끼 식사 대체 시 1포(35g)를 저지방우유 200ml에 넣고 잘 흔들어 섞은 후 천천히 씹어서 드십시오.</li>
                      <li>기호에 따라 우유의 양은 조절할 수 있습니다.</li>
                      <li>섭취량은 성인 기준으로 표시되어 있으며, 섭취자의 연령이나 신체 상태에 따라 제품섭취량 조절이 가능합니다. </li>
					  <li>가르시니아캄보지아와 카테킨 성분이 소량 함유되어 있어 임산부나 수유부 여성에게는 권장하지 않습니다. </li>
                   </ul>
                   <div class="divider"></div>
                   <h3>섭취 시 주의사항</h3>
                   <ul class="dot">
                      <li>섭취자의 신체 상태에 따라 반응에 차이가 있을 수 있습니다.</li>
                      <li>알레르기 체질이신 경우 성분을 확인하신 후 섭취하여 주시기 바랍니다.</li>
                   </ul>

               </div>
           </div>
			                <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/popup/balshake_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
                 <td><a href="/mobile/shop/balanceShake-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">밸런스쉐이크 구매</span></span></a></td>
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