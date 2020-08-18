<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <ul class="subnavi">
			<li class="current"><a href="/mobile/customer/service.jsp">주문안내</a></li>
			<li><a href="/mobile/goods/cuisine.jsp">제품소개</a></li>
            <li><a href="/mobile/intro/schedule.jsp">이달의 식단</a></li>
		</ul>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content" style="margin-top:135px;">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">일일,택배배달 주문안내</span></span></h1>
           <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:10px 0;">
             <tr>
               <td width="40" class="badge-bg green">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>01</p>
                   </div>
               </td>
               <td width="10">&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>주문안내 확인</h3>
                       <p>상품의 종류와 기능을 확인하신 후 주문하실 제품을 선택해주세요.</p>
                   </div>
               </td>
             </tr>
             <tr>
               <td class="badge-bg green">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>02</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>배달가능지역 확인</h3>
                       <p>일일배달 상품(다이어트 식사, 다이어트 프로그램, 시크릿 수프)의 경우 고객님의 지역에서 가까운 위탁배달점을 통하여 매일 냉장배달되고 있습니다.<br />일일배달 상품을 주문하실 경우 배달가능 지역인지 꼭 확인 후 주문해주세요.</p>
                   </div>
               </td>
             </tr>
             <tr>
               <td class="badge-bg orange">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>03</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>식사기간 선택</h3>
                       <p>선택하신 상품에 따른 식단표와 고객님이 가능하신 일정에 따라 식사기간(주)를 선택해주세요.</p>
                       <br />
    <!--                 <h4 class="font-orange">다이어트식사 5일(2주/4주)</h4>
                     <table width="100%" border="0" cellspacing="0" cellpadding="0">
                         <tr bgcolor="#FFFFFF">
                           <td width="14%" align="center">월</td>
                           <td width="14%" align="center">화</td>
                           <td width="14%" align="center">수</td>
                           <td width="14%" align="center">목</td>
                           <td width="14%" align="center">금</td>
                           <td width="14%" align="center">토</td>
                           <td width="16%" align="center">일</td>
                       </tr>
                         <tr>
                           <td colspan="5" align="center" class="bg-orange">5일 배달</td>
                           <td align="right" class="bg-brown">배달</td>
                           <td align="left" class="bg-brown">없음</td>
                       </tr>
                     <tr>
                           <td colspan="6" align="center" class="bg-green">6일배달</td>
                           <td colspan="1" align="center" class="bg-brown">없음</td>
                       </tr> 
                     </table>
            <p>- 일: 주 5일(월~금) 또는 주6일(월~토) 선택가능</p> 
                     <p>- 주: 2주 또는 4주 선택 가능</p>  
                     <br />  -->

                     <h4 class="font-orange">다이어트식사,시크릿수프(매일/격일 선택)</h4>
                     <table width="100%" border="0" cellspacing="0" cellpadding="0">
                         <tr bgcolor="#FFFFFF">
                           <td align="center">월</td>
                           <td align="center">화</td>
                           <td align="center">수</td>
                           <td align="center">목</td>
                           <td align="center">금</td>
                           <td align="center">토</td>
                           <td align="center">일</td>
                       </tr>
                         <tr>
                           <td colspan="5" align="center" class="bg-orange">5일 배달</td>
                           <td colspan="2" align="center" class="bg-brown">배달</td>
                       </tr>
                         <tr>
						    <td align="center" class="bg-green">격일</td>
                           <td align="center" bgcolor="#FFCC00">&nbsp;</td>
                           <td align="center" class="bg-green">격일</td>
                           <td align="center" bgcolor="#FFCC00">&nbsp;</td>
						   <td align="center" class="bg-green">격일</td>
                           <td align="center" class="bg-brown">없음</td>
						   <td align="center" class="bg-brown">&nbsp;</td>
                       </tr>
                     </table>
                     <p>- 일: 주 5일(월~금) 또는 주 3일(월수금) 선택가능</p>
                     <p>- 주: 주 5일 상품(1주, 2주, 4주 선택가능), 주 3일 상품(2주,4주 선택가능)</p>
                     <br />  
						<h4 class="font-orange">프로그램 다이어트</h4>
							<p>- 3일, 6일, 2주, 4주 : 주말(토,일)을 제외한 평일 5일 매일 배송</p> 
                   </div>


               </td>
             </tr>
             <tr>
               <td class="badge-bg orange">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>04</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>첫 배달일 지정</h3>
                       <p>일일배달의 경우 식재료 구매부터 배달까지 총 6일 소요되며, 6일 이후 일정부터 선택 가능합니다. </p>
                       <p>택배배달의 경우 배달일 지정은 불가능하며, 결제완료 이후 2~5일후에 상품을 수령하실 수 있습니다.</p>
                   </div>
               </td>
             </tr>
             <tr>
               <td class="badge-bg orange">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>05</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>보냉가방주문</h3>
                       <p>보냉가방 구매 여부를 선택해주세요.</p>
                       <p>처음 일일배달 상품을 주문하실 경우 보냉가방을 필수로 구매하셔야 상품을 신선하게 받으실 수 있습니다.</p>
                       <p>보냉가방을 이미 구매하여 상품을 받으신 이력이 있는 경우, 선택적으로 구매가 가능합니다.</p>
                   </div>
               </td>
             </tr>
             <tr>
               <td class="badge-bg brown">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>06</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>배달지입력</h3>
                       <p>일일배달 상품과 택배배달 상품을 구분하여 배달지를 입력할 수 있습니다.</p>
                       <p>일일배달 상품, 택배배달 상품 모두 같은 배달지로 받으실 경우 동일하게 입력하시면 됩니다.</p>
                   </div>
               </td>
             </tr>
             <tr>
               <td class="badge-bg brown last">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>07</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>주문결제</h3>
                       <!-- <p>카드결제, 실시간 계좌이체, 가상계좌 중 원하시는 결제방법으로 결제를 하시면 됩니다.</p> -->
                       <p>가상계좌결제, 실시간계좌이체, 신용카드 결제 중 원하시는 결제수단을 선택하여 결제하시면 주문이 완료됩니다.</p>
                   </div>
               </td>
             </tr>
           </table>
     </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
<