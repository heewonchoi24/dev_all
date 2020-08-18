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
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">배달지역확인</span></span></h1>
        <div class="grid-navi">
          <table class="navi" border="0" cellspacing="10" cellpadding="0">
            <tr>
              <td><a href="/mobile/delivery/delivery.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">배달 가능지역</span></span></a></td>
              <td><a href="/mobile/delivery/deliveryGuide.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">배달 상세안내</span></span><span class="active"></span></a></td>
            </tr>
          </table>
        </div>
        <div class="row" style="margin: 0 3%;">
           <h2 class="mart20 font-green">택배</h2>
           <table class="delitb" width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <th>배달처</th>
                <td>롯데택배</td>
              </tr>
              <tr>
                <th>배달비용</th>
                <td>구매금액 40,000원 미만일 경우 택배비 2,700원 고객부담</td>
              </tr>
              <tr>
                <th>배달기간</th>
                <td>주문 후 경우에 따라 2~5일 소요</td>
              </tr>
            </table>
           <div class="divider"></div>
           <div class="divider"></div>
           <h2 class="font-blue">일일배달</h2>
           <table class="delitb" width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <th>배달처</th>
                <td>각 지역 위탁배달점</td>
              </tr>
              <tr>
                <th>배달비용</th>
                <td>무료</td>
              </tr>
              <tr>
                <th>배달기간</th>
                <td>식재료 구매부터 배달까지 총 6일이 소요되며, 접수일로부터 6일 이후 선택한 첫 배달일에 배달이 됩니다.
배달시간은 22시부터 6시 사이에 이루어 집니다. 악천후, 교통상황, 배달물량의 급격한 증가, 고객님의 요청 등의 상황에 따라 정해진 배달 시간에서 1시간 정도는 조기, 연장 배달될 수 있습니다.</td>
              </tr>
            </table>
           <div class="divider"></div>
           <div class="divider"></div>
           <h2 class="font-brown">교환/반품안내</h2>
           <table class="delitb" width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>
                <p class="marb10">1. 단순변심에 의한 환불은 제품 수령 후 7일이내까지만 가능 (왕복배송비 고객부담)</p>
                <p class="marb10">2. 제품 하자의 경우 물품수령 후 3개월이내 또는 그 사실을 안 날로부터 30일이내 반품 가능</p>
                <p class="marb10">3. 포장이 훼손되어 상품 가치가 현저히 상실된 경우 교환 반품 불가</p>
              </td>
              </tr>
            </table>
           <div class="divider"></div>
        </div>
     </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>