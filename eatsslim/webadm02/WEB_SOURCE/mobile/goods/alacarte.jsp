<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <ul class="subnavi">
			<li><a href="/mobile/customer/service.jsp">주문안내</a></li>
			<li class="current"><a href="/mobile/goods/cuisine.jsp">제품소개</a></li>
            <li><a href="/mobile/intro/schedule.jsp">이달의 식단</a></li>
		</ul>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content" style="margin-top:135px;">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">제품소개</span></span></h1>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">퀴진<br />제품</span></span></a></td>
                 <td><a href="/mobile/goods/alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">알라<br />까르떼</span></span><span class="active"></span></a></td>
                 <td><a href="/mobile/goods/minimeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text" style="padding:9px 0px;">간편식</span></span></a></td>
                 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">밸런스<br />쉐이크</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="divider"></div>
           <div class="row">
               <div class="goods alacarte">
                   <div class="top-wrap">
                        <span class="goods-copy">
                            나트륨Down·칼로리Down 영양설계와
                        </span><br />
                        <span class="goods-copy">
                            다양한 메뉴는 기본!
                        </span>
                        <p class="goods-caption">One-dish Style로 디자인된<br />간편한 식사, <strong>알라까르떼</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/goods_img02.png" width="235" height="160" alt="퀴진"></div>
                   <h2 class="font-wbrown">과학적인 영양설계</h2>
                   <p>GI/GL의 원리를 다이어트 식사에 적용하여, 탄수화물 특성에 따른 열량의 체내 흡수율을 고려하고, 그에 따른 적합한 식단을 설계</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">안전한 냉장온도 유지</h2>
                   <p>출고후 고객이 배달받기까지 냉장 0~10˚C로 유지될 수 있도록 풀무원 극신선배송시스템으로 냉장차량온도 관리 및 보냉팩키지 설계</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">쉽고 간편한 식사</h2>
                   <p>데우지 않고 간편하게 언제 어디서나 섭취할 수 있도록 샐러드/샌드위치/파스타 형태로 구현</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">건강레시피로 구성</h2>
                   <p>식이섬유와 단백질이 풍부한 식사구성을 지향하며,튀기지 않고 가공을 최소화</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">호텔출신 쉐프팀이 펼치는 각국 대표요리</h2>
                   <p>각국 도시의 대표요리가 호텔 출신 잇슬림 쉐프들의 손을 거쳐 과학적인 다이어트식으로 재탄생 </p>
               </div>
           </div>
  </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>