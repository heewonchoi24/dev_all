<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <ul class="subnavi">
            <li class="current"><a href="/mobile/shop/dietMeal.jsp">�Ļ���̾�Ʈ</a></li>
            <li><a href="/mobile/shop/keepProgram.jsp">���α׷����̾�Ʈ</a></li>
            <li><a href="/mobile/shop/secretSoup.jsp"> Ÿ�Ժ����̾�Ʈ</a></li>
        </ul>
    </div>
    <!-- End ui-header -->
    
    <!-- Start Content -->
    <div id="content" style="margin-top:135px;">
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/dietMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">���̾�Ʈ�Ļ� �����ϱ�</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/dietMeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner"><span class="ui-btn-text">����<br />�ѽ�Style</span></span><span class="active"></span></a></td>
                 <td><a href="/mobile/shop/dietMeal-b.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">����<br />���Style</span></span></a></td>
                 <td><a href="/mobile/shop/dietMeal-alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">�˶���<br />FRESH</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="row">
           <div class="bg-gray font-brown">
               <p>����A�� �ѽ� ǻ�� �Ļ翡 �°� ������ �ǰ��Ĵ����� �������� Designed Diet Meal�Դϴ�.</p>
                  <div class="memo">
                      <div class="ribbon-tit"></div>
                      <ul>
                          <li class="memo01">�� 18���� �پ��� �޴��� ������ �ʴ� ��ſ� �Ļ�</li>
                          <li class="memo02">Ư��ȣ�� ��� ������ ���� ����� ���ִ� �Ļ�</li>
                          <li class="memo03">Ǯ���� �Ĺ�ȭ������ �ڹ����� �������� ���缳��</li>
                          <li class="memo04">Ǯ���� �ؽż���۽ý������� �ż��� ����</li>
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
                           <h3 class="ui-li-heading">��ġ��ä������</h3>
                           <p class="ui-li-desc">��1ȸ ������ 390g</p>
                           </a>
                           <span class="cal_banner">360<br />kcal</span>
                       </div>
                   </li>
                   <li class="ui-btn ui-btn-up-e ui-li ui-li-has-thumb">
                       <div class="ui-btn-inner ui-li">
                           <a class="ui-link-inherit lightbox" href="/mobile/shop/cuisineinfo/cuisineA.jsp?lightbox[iframe]=true&lightbox[width]=300&lightbox[height]=400">
                           <img class="ui-li-thumb" src="/mobile/images/cuisine_sample.jpg" width="116" height="70">
                           <h3 class="ui-li-heading">��ġ��ä������</h3>
                           <p class="ui-li-desc">��1ȸ ������ 390g</p>
                           </a>
                           <span class="cal_banner">360<br />kcal</span>
                       </div>
                   </li>
                   <li class="ui-btn ui-btn-up-e ui-li ui-li-has-thumb ui-last-child">
                       <div class="ui-btn-inner ui-li">
                           <a class="ui-link-inherit lightbox" href="/mobile/shop/cuisineinfo/cuisineA.jsp?lightbox[iframe]=true&lightbox[width]=300&lightbox[height]=400">
                           <img class="ui-li-thumb" src="/mobile/images/cuisine_sample.jpg" width="116" height="70">
                           <h3 class="ui-li-heading">��ġ��ä������</h3>
                           <p class="ui-li-desc">��1ȸ ������ 390g</p>
                           </a>
                           <span class="cal_banner">360<br />kcal</span>
                       </div>
                   </li>
               </ul>
           </div>
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/dietMeal-order.html" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">���̾�Ʈ�Ļ� �����ϱ�</span></span></a></td>
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