<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
  <div id="header">
    <%@ include file="/common/include/inc-header.jsp"%>
  </div>
  <!-- End header -->
  <div class="container">
    <div class="maintitle">
      <h1> 이용안내 </h1>
      <div class="pageDepth"> HOME > 고객센터 > <strong>이용안내</strong> </div>
      <div class="clear"> </div>
    </div>
    <div class="twelve columns offset-by-one ">
      <div class="row">
        <div class="threefourth last col">
          <ul class="tabNavi">
            <li> <a href="/customer/notice.jsp">공지사항</a> </li>
            <li> <a href="/customer/faq.jsp">FAQ</a> </li>
            <%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">1:1문의</a></li>
						<%} else {%>
						<li><a href="indiqna.jsp">1:1문의</a></li>
						<%}%>
            <li class="active"> <a href="/customer/service_member.jsp">이용안내</a> </li>
            <li> <a href="/customer/presscenter.jsp">언론보도</a> </li>
          </ul>
          <div class="clear"> </div>
        </div>
      </div>
      <div class="row" style="margin-bottom:40px;">
        <div class="threefourth last col">
          <ul class="listSort">
            <li> <a href="/customer/service_member.jsp">회원가입</a> </li>
            <li> <a href="/customer/service_order.jsp">주문/결제</a> </li>
            <li> <a href="/customer/service_change.jsp">주문변경</a> </li>
            <li> <span class="current">취소/교환/환불</span> </li>
            <li> <a href="/customer/service_coupon.jsp">쿠폰사용</a> </li>
          </ul>
        </div>
      </div>
      <!-- End row -->
      <div class="row">
        <div class="threefourth last col">
          <div class="marb50"><img src="/images/serimg_04_01.png" width="721" height="160"></div>
          <dl class="regist">
            <dt>
              <h2>주문취소</h2>
            </dt>
            <dd>
              <ul class="bubblelist">
                <li> <span class="bubble">01</span>
                  <h4>일배</h4>
                  <p> 1. 주문 상품이 결제완료 상태일 경우에는 취소시 전액 환불이 가능합니다.<br />
                    2. 주문완료 후에는 취소시점에 따라 부분적으로 환불이 가능합니다. 잇슬림은 주문생산방식이므로,<br />
					취소를 원하시는 배달일자의 최대 D-3일 전까지 취소 처리가 가능하십니다.<br/>
					예) 배송일자가 1월 10일일 경우 -> 1월 7일까지 취소 요청을 해주셔야 취소 가능) </p>
                  <div class="mart10 marb10"><img src="/images/serimg_04_02.png" width="561" height="50"></div>
                </li>
                <li> <span class="bubble">02</span>
                  <h4>택배</h4>
                  <p> 주문취소는 '주문접수','결제완료'에서만 주문취소가 가능합니다.<br />
                    이후 취소를 요청하실 경우에는 고객센터로 문의해 주시기 바립니다. </p>
                  <div class="mart10 marb10"><img src="/images/serimg_04_03.png" width="561" height="150"></div>
                  <p>주문취소는 <span class="txtline">마이잇슬림 > 주문배달 > 주문배달조회</span>에서 신청하시거나  고객센터 1:1상담 또는 고객기쁨센터 080-022-0085로 내용을 알려주시면 신속하게 처리해 드리겠습니다.</p>
                </li>
                <li> <span class="bubble">03</span>
                  <h4>공통</h4>
                  <p> 주문시 쿠폰을 사용하신 경우 주문 취소시 쿠폰은 재발행되지 않습니다. </p>
                </li>
              </ul>
            </dd>
          </dl>
          <div class="divider"></div>
          <dl class="regist">
            <dt>
              <h2>교환반품<br />
                환불기준</h2>
            </dt>
            <dd>
              <ul class="bubblelist">
                <li> <span class="bubble">01</span>
                  <h4>택배</h4>
                  <p> 1. 교환/반품 신청은 택배상품만 가능합니다.<br />
                    2. 교환/반품신청은 상품 수령 후 7일 이내까지 가능합니다. <br />
                    (주문완료 시점에는 교환/반품 신청이 불가합니다.)<br />
                    3. 고객님의 변심에 의한 교환/반품의 경우 반송시 부과되는 배달료는 고객님께서 부담하셔야 합니다.<br />
                    4. 임의로 반송하실 경우 환불 등의 처리가 지연될 수 있으므로 반송 전 꼭 고객센터로 접수해주시기 바랍니다.<br />
                    5. 주문시 쿠폰을 사용하신 경우 주문 반품시 쿠폰은 재발행되지 않습니다.<br />
                  </p>
                </li>
              </ul>
            </dd>
          </dl>
          <div class="divider"></div>
          <dl class="regist">
            <dt>
              <h2>교환반품<br />
                환불기준</h2>
            </dt>
            <dd>
              <table class="termstable" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <th width="33%">유형</th>
                  <th width="33%">교환/반품 가능</th>
                  <th>접수기간</th>
                </tr>
                <tr>
                  <td>불량 및 오배달으로<br />
                    인한 교환상품<br />
                    (반품/교환 시 발생하는<br />
                    비용은 잇슬림 부담) </td>
                  <td>
                    1. 상품에 하자가 있거나 불량인<br />
                    경우 (변질,불량,파손,표기오류<br />,이물혼입, 중량미달 등)<br />
                  2. 주문한 내역과 다른 상품이<br />배달된 경우</td>
                  <td class="last">1. 제품 수령일로부터 7일이내<br />
                    2. 상품의 내용이 표시,광고 내용 <br />
                    과 상이하거나 계약내용과 다르게<br />
                    이행된 경우에는 상품을 공급받은<br />
                    날로부터 3개월 이내, 그 사실을<br />
                    인지한 시점 또는 인지할 수 있었<br />
                    던 시점으로부터 30일 이내에<br />
                    교환 및 반품이 가능합니다.</td>
                </tr>
                <tr>
                  <td>고객 단순변심으로 인한 
                    반품
                    (반품/교환 시 발생하는
                    비용은 고객부담이며,
                    무료배달의 경우 왕복택
                    배비를 부담)
                    
                    *결제하신 금액에서
                    택배비용을 제외한 금액
                    이 환불됩니다.</td>
                  <td>1. 포장 및 구성품이<br />훼손되지 않는 경우 </td>
                  <td class="last">
                  1. 제품 수령일로부터 7일이내에
                    반품이 가능하며, 택배비는 이용
                    자가 부담해야 합니다.
                    (무료배달의경우 왕복택배비를
                  부담해야합니다.) </td>
                </tr>
                <tr>
                  <td>취소 및 반품이 불가한
                    경우</td>
                  <td>
                    1. 이용자의 책임으로 상품이 훼손된 경우
                    (포장 훼손으로 인한 상품가치가 상실 된 경우도 포함)<br />
                    2. 이용자의 일부 소비로상품의 가치가 현저히 감소한 경우<br />
                  3. 시간의 경과에 의하여 상품의 재판매가 어려운 정도로 상품의 가치가 현저시 감소한경우)</td>
                  <td class="last"></td>
                </tr>
              </table>
              <p class="mart10">주문교환 및 반품은 <span class="txtline">마이잇슬림 > 주문배달 > 주문배달조회</span> 에서 신청하시거나 고객센터 1:1상담<br />
                또는 전화 080-022-0085로 내용을 알려주시면 신속하게 처리해 드리겠습니다.</p>
            </dd>
          </dl>
          <div class="divider"></div>
          <dl class="regist">
            <dt>
              <h2>환불안내</h2>
            </dt>
            <dd>
              <ul class="bubblelist">
                <li> 
                <span class="bubble">01</span>
                  <h4>주문취소 시 결제 방법에 따른 환불</h4>
                  <h5>- 잇슬림 홈페이지에서 주문한 경우</h5>
                   <dl class="bluepoint">
                     <dt>가상계좌</dt><dd><span>환불계좌입금</span></dd>
                     <div class="clear"></div>
                     <dt>실시간계좌이체</dt><dd><span>환불계좌입금</span></dd>
                     <div class="clear"></div>
                     <dt>카드결제</dt><dd><span>카드사 사정에 따라 대략 3~5일정도 취소기간 필요</span></dd>
                   </dl>
                   <br />
                   <h5>- 외부몰에서 주문한 경우</h5>
                    <p>결제 방법에 상관없이 계좌환불 됩니다. 단, 주문 후 첫 배달전 환불시(전체환불) 홈페이지 주문건 환불방법에 따릅니다.</p>
                </li>
                <li>
                  <span class="bubble">02</span>
                  <h4>취소접수일로부터 환불이 완료될때까지 5~7일정도의 시간이 소요됩니다.</h4>
                </li>
              </ul>
            </dd>
          </dl>
        </div>
      </div>
      <!-- End row --> 
    </div>
    <!-- End twelve columns offset-by-one -->
    <div class="sidebar four columns">
      <%@ include file="/common/include/inc-sidecustomer.jsp"%>
    </div>
    <!-- End sidebar four columns -->
    <div class="clear"></div>
  </div>
  <!-- End container -->
  <div id="footer">
    <%@ include file="/common/include/inc-footer.jsp"%>
  </div>
  <!-- End footer -->
  <div id="floatMenu">
    <%@ include file="/common/include/inc-floating.jsp"%>
  </div>
  <%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
</body>
</html>