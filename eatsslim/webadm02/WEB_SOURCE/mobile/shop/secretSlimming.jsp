<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed" style="overflow: hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
		<ul class="subnavi">
			<li><a href="/mobile/shop/dietMeal.jsp">식사다이어트</a></li>
			<li class="current"><a href="/mobile/shop/weight2weeks.jsp">프로그램다이어트</a></li>
			<li><a href="/mobile/shop/minimeal.jsp">타입별다이어트</a></li>
			<li><a href="/mobile/shop/dietCLA.jsp">풀비타</a></li>
		</ul>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content" style="margin-top: 135px;">
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/popup/program_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
					<td><a href="/mobile/shop/secretSlimming-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">프로그램다이어트 구매</span></span></a></td>
				</tr>
			</table>
		</div>
		<div class="grid-navi">
			<table class="navi" cellspacing="10" cellpadding="0">
				<tr>
		    		<td><a href="/mobile/shop/weight3days.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">3일<br />프로그램</span></span></a></td>
					<td><a href="/mobile/shop/secretSlimming.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner"><span class="ui-btn-text">시크릿<br />6일</span></span></a></td>
					<td><a href="/mobile/shop/weight2weeks.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">집중감량<br />2주</span></span></a></td>
					<td><a href="/mobile/shop/fullStep.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">감량유지<br />4주</span></span></span></a></td>
				</tr>
			</table>
		</div>
		<div class="divider"></div>
		<div class="row">
			<div class="bg-gray font-brown">
				<p>밸런스쉐이크/다이어트 간편식/식사다이어트가 주차별로 스케쥴링 되어 집중 감량에서 유지까지 Full-Step으로 경험해 보는 잇슬림의 추천 프로그램!</p>
				<div style="margin: 25px 0 10px 0;">
					<img src="/mobile/images/slimming_img01.png" width="100%" alt="" />
				</div>
			</div>
		</div>
		<div class="row">
			<h2 class="font-brown">01. 프로그램</h2>
			<div style="margin: 5px auto 15px;">
				<img src="/mobile/images/slimming_img02.png" width="100%" style="margin-bottom: 10px" />
				<p class="f14">평소 잘못된 식습관으로 인해 증가한 체중을 보다 효과적으로 체중 감량을 할 수 있도록 도움을 줍니다. 몸의 생체 리듬에 맞춰 4시간 간격으로 음식을 섭최함으로서 다이어트시 공복감에 대한 스트레스를 줄이는데 도움을 줄 수 있습니다.</p>
			</div>
			<div class="divider"></div>
			<h2 class="font-brown">02. 체계적인 식사 스케쥴</h2>
			<div style="margin: 5px auto;">
				<img src="/mobile/images/slimming_img03.png" width="100%" />
			</div>
			<p class="f12">- 월~금 스케쥴입니다. 주말(토,일)을 위하여 “잇슬림밸런스쉐이크”를 함께 이용하세요.</p>
			<div class="divider"></div>
			<h2 class="font-brown">03. 과학적인 영양설계</h2>
			<p class="f18 font-blue mart10">
				<strong>Low GL diet point !</strong>
			</p>
			<p class="f16">
				<strong>1일 기준 적절한 탄수화물 공급</strong>
			</p>
			<p class="f14">단백질과 수분손실 등 영양불균형을 최소화 합니다.</p>
			<div class="divider"></div>
			<p class="f16">
				<strong>Low GI (당 지수)를 고려한 재료 선정 및 설계 기준 설정</strong>
			</p>
			<p class="f14">탄수화물에 의한 체내 흡수속도를 조정하기 위하여 재료의 종류를 선정하고, 전체 탄수화물 공급원 중 풀무원기준에 맞춘 Low GI로 분류되는 탄수화물 급원 비율을 조정합니다.</p>
			<div class="divider"></div>
			<p class="f16">
				<strong>Low GL (당부하 지수)를 고려한 탄수화물 함량 설정</strong>
			</p>
			<p class="f14">바른 탄수화물의 질적/양적 기준으로 제품별 1회 섭취시 GL지수를 산출하여 전체 식단을 검증합니다.</p>
			<div class="divider"></div>
			<h2 class="font-brown">04. 바른재료와 철저한 위생관리</h2>
			<img class="floatleft" src="/mobile/images/reductionProgram05.png" width="113" height="37" style="margin-right: 10px;" />
			<p class="f14" style="display: inline-block; width: 55%;">풀무원 식품안전센터를 통한 원료 안전성 검사 및 완제품 안전성 컨트롤</p>
			<div class="divider"></div>
			<img class="floatleft" src="/mobile/images/reductionProgram06.png" width="113" height="37" style="margin-right: 10px;" />
			<p class="f14">센트럴키친을 통한 품질의 표준화 및 전문화</p>
			<div class="divider"></div>
			<h2 class="font-brown">05. 포장 & 배달</h2>
	  <ul class="step04">
		<li class="tit"><p>[택배 배달 프로세스]</p></li>
		<li>잇슬림의 택배 배달은 풀무원의 <span>철저한 신선 제품 냉장 운영기준</span>에 따라 택배 발송부터 익일 고객님 수령까지 안전하게 유지합니다.</li>
		<li>잇슬림의 택배 배달은 <span>35℃에서도 30시간까지 5℃를 유지</span>하도록 아이스젤과 드라이아이스를 사용합니다.</li>
		<li>잇슬림의 택배 패키지는 0℃-5℃를 유지하며 제품이 얼었다 녹음으로 인한 <span>관능의 저하를 막을 수 있도록 세심하게 설계</span>되었습니다.</li>
		<img src="/mobile/images/shop_minimeal_09.jpg" width="100%" alt="택배 배달 프로세스">
	  </ul><br/>
	  <ul class="step04">
		<li class="tit"><p>[택배 수령일 안내]</p></li>
		<li>평일 및 일반 배송 수령일 주문 시, 익일 발송이 가능한 요일인 <span>화, 수, 목, 금요일만</span> 익일 수령 
   가능하며, 주문하신 날로부터 최대 3~6일정도 소요됩니다.</li>
        <li>택배사(CJ택배)의 일요일 휴무로 인하여, 익일 배송이 불가능한 <span>일요일, 월요일은 택배 배달이 없으며, 
   공휴일은 택배 발송 및 수령이 불가능</span>합니다.</li>
		<li>하단 표와 같이 <span>수요일이 공휴일인 경우,</span> 택배사 휴무로 인하여 배송과 출고가 없기 때문에, 수요일, 목요일 이틀간 제품을 수령하실 수없으시며, 목요일, 금요일 주문 건은 기존 배송체계와 같이 차주 화요일에 수령됩니다. </li><br/>
		<img src="/mobile/images/shop_minimeal_10.jpg" width="100%" alt="택배 수령일 안내"><br/><br/>
		<img src="/mobile/images/shop_minimeal_11.jpg" width="100%" alt="택배 수령일 안내">
	  </ul><br/>
    </div>
    <div class="grid-navi">
      <table class="navi" border="0" cellspacing="10" cellpadding="0">
        <tr>
          <td><a href="/mobile/shop/popup/program_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
          <td><a href="/mobile/shop/secretSlimming-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">프로그램다이어트 구매</span></span></a></td>
        </tr>
      </table>
    </div>
  </div>
	<!-- End Content -->
	<div class="ui-footer">
		<div class="marb10">
			<%@ include file="/mobile/common/include/inc-footer.jsp"%>
		</div>
	</div>
</div>
</body>
</html>