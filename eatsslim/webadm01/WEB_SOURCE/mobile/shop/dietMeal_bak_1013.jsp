<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <ul class="subnavi">
            <li class="current"><a href="/mobile/shop/dietMeal.jsp">식사다이어트</a></li>
            <li><a href="/mobile/shop/keepProgram.jsp">프로그램다이어트</a></li>
            <li><a href="/mobile/shop/secretSoup.jsp"> 타입별다이어트</a></li>
        </ul>
    </div>
    <!-- End ui-header -->
    
    <!-- Start Content -->
    <div id="content" style="margin-top:135px;">
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/dietMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">다이어트식사 구매하기</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/dietMeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner"><span class="ui-btn-text">퀴진<br />한식Style</span></span><span class="active"></span></a></td>
                 <td><a href="/mobile/shop/dietMeal-b.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">퀴진<br />양식Style</span></span></a></td>
                 <td><a href="/mobile/shop/dietMeal-alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">알라까르떼<br />FRESH</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="row">
           <div class="bg-gray font-brown">
               <p>퀴진A는 한식 퓨전 식사에 맞게 저열량 건강식단으로 만나보는 Designed Diet Meal입니다.</p>
                  <div class="memo">
                      <div class="ribbon-tit"></div>
                      <ul>
                          <li class="memo01">총 18가지 다양한 메뉴로 질리지 않는 즐거운 식사</li>
                          <li class="memo02">특급호텔 출신 쉐프가 직접 만드는 맛있는 식사</li>
                          <li class="memo03">풀무원 식문화연구소 자문단의 과학적인 영양설계</li>
                          <li class="memo04">풀무원 극신선배송시스템으로 신선도 유지</li>
                      </ul>
                  </div>
           </div>
           </div>
           
           <div class="row">
               <ul class="ui-listview">
                   <li class="ui-btn ui-btn-up-e ui-li ui-li-has-thumb ui-first-child">
                       <div class="ui-btn-inner ui-li">
                           <a class="ui-link-inherit lightbox" href="/mobile/shop/cuisineinfo/cuisineA.jsp?lightbox[iframe]=true&lightbox[width]=300&lightbox[height]=400">
                           <img class="ui-li-thumb" src="/mobile/images/cuisine_sample.jpg" width="116" height="70">
                           <h3 class="ui-li-heading">참치야채샐러드</h3>
                           <p class="ui-li-desc">총1회 제공량 390g</p>
                           </a>
                           <span class="cal_banner">360<br />kcal</span>
                       </div>
                   </li>
                   <li class="ui-btn ui-btn-up-e ui-li ui-li-has-thumb">
                       <div class="ui-btn-inner ui-li">
                           <a class="ui-link-inherit lightbox" href="/mobile/shop/cuisineinfo/cuisineA.jsp?lightbox[iframe]=true&lightbox[width]=300&lightbox[height]=400">
                           <img class="ui-li-thumb" src="/mobile/images/cuisine_sample.jpg" width="116" height="70">
                           <h3 class="ui-li-heading">참치야채샐러드</h3>
                           <p class="ui-li-desc">총1회 제공량 390g</p>
                           </a>
                           <span class="cal_banner">360<br />kcal</span>
                       </div>
                   </li>
                   <li class="ui-btn ui-btn-up-e ui-li ui-li-has-thumb ui-last-child">
                       <div class="ui-btn-inner ui-li">
                           <a class="ui-link-inherit lightbox" href="/mobile/shop/cuisineinfo/cuisineA.jsp?lightbox[iframe]=true&lightbox[width]=300&lightbox[height]=400">
                           <img class="ui-li-thumb" src="/mobile/images/cuisine_sample.jpg" width="116" height="70">
                           <h3 class="ui-li-heading">참치야채샐러드</h3>
                           <p class="ui-li-desc">총1회 제공량 390g</p>
                           </a>
                           <span class="cal_banner">360<br />kcal</span>
                       </div>
                   </li>
               </ul>
           </div>
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/dietMeal-order.html" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">다이어트식사 구매하기</span></span></a></td>
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