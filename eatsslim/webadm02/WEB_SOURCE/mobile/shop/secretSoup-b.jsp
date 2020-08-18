<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <ul class="subnavi">
            <li><a href="/mobile/shop/dietMeal.jsp">다이어트식사</a></li>
            <li><a href="/mobile/shop/keepProgram.jsp">다이어트 프로그램</a></li>
            <li class="current"><a href="/mobile/shop/secretSoup.jsp">기능식 다이어트</a></li>
        </ul>
    </div>
    <!-- End ui-header -->
    
    <!-- Start Content -->
    <div id="content" style="margin-top:135px;">
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/dietSoup-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">시크릿수프 구매</span></span></a></td>
                 <td><a href="/mobile/shop/balanceShake-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">밸런스쉐이크 구매</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/secretSoup.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">시크릿수프<br />A타입</span></span></a></td>
                 <td><a href="/mobile/shop/secretSoup-b.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner"><span class="ui-btn-text">시크릿수프<br />B타입</span></span><span class="active"></span></a></td>
                 <td><a href="/mobile/shop/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">밸런스<br />쉐이크</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="divider"></div>
           <div class="row">
           <h2>시크릿수프 B타입?</h2>
           <p>시크릿수프 B타입에 대한 간단한 설명</p>
           <div class="divider"></div>
           <img src="/mobile/images/eatsslim_intro.jpg" width="100%">
           </div>
           
           
  </div>
    <!-- End Content -->
    <div class="ui-footer">
        <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>