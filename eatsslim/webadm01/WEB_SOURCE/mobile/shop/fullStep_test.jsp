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
			<li class="current"><a href="/mobile/shop/reductionProgram.jsp">프로그램다이어트</a></li>
			<li><a href="/mobile/shop/secretSoup.jsp">타입별다이어트</a></li>
		</ul>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content" style="margin-top: 135px;">
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/popup/program_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
					<td><a href="/mobile/shop/dietProgram-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">프로그램다이어트 구매</span></span></a></td>
				</tr>
			</table>
		</div>
		<div class="grid-navi">
			<table class="navi" cellspacing="10" cellpadding="0">
				<tr>
					<!-- <td><a href="/mobile/shop/reductionProgram.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">감량<br /> 프로그램</span></span></a></td>
					<td><a href="/mobile/shop/keepProgram.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">유지<br /> 프로그램</span></span></a></td>-->
					<td><a href="/mobile/shop/fullStep.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner"><span class="ui-btn-text">New Full-Step 프로그램</span></span><span class="active"></span></a></td>
				</tr>
			</table>
		</div>
		<div class="divider"></div>
		<div class="row">
			<div class="bg-gray font-brown">
				<p>밸런스쉐이크/다이어트수프/식사다이어트가 주차별로 스케쥴링 되어 집중 감량에서 유지까지 Full-Step으로 경험해 보는 잇슬림의 추천 프로그램!</p>
				<div style="margin: 25px 0 10px 0;">
					<img src="/mobile/images/fullstepProgram01_new.png" width="100%" alt="" />
				</div>
			</div>
		</div>
		<div class="row">
			<h2 class="font-brown">01. 프로그램</h2>
			<div style="margin: 5px auto 15px;">
				<img src="/mobile/images/fullstepProgram02_new.png" width="100%" style="margin-bottom: 10px" />
				<p class="f14">준비기 1주, 체중 감소기 2주, 유지기 1주 총 4주 프로그램으로 준비기를 통해 급격한 식사조절이 아닌 준비된 식사조절을 시작하여 2주간 체중 감소기를 통해 집중감량을 진행하며 감량후 유지기를 통해 요요현상을 막아줍니다.</p>
			</div>
			<h3>4주 프로그램</h3>
			<p class="f14">준비기 1주, 체중 감소기2주, 유지기 1주 총 4주 프로그램으로 집중적으로 체중 감소 후 일상식으로 적응을 원할하게 도울 수 있도록 구성된 상품입니다.</p>
			<div class="divider"></div>
			<h2 class="font-brown">02. 체계적인 식사 스케쥴</h2>
			<div style="margin: 5px auto;">
				<img src="/mobile/images/fullstepProgram03_new.png" width="100%" />
			</div>
			<p class="f12">- 월~금 스케쥴입니다. 주말(토,일)을 위하여 “잇슬림밸런스쉐이크”를 함께 이용하세요.</p>
			<div class="divider"></div>
			<h2 class="font-brown">03. 맛있는 다이어트</h2>
			<ul class="dot">
				<li class="f14">한식/양식/일식/중식호텔출신 전문 쉐프팀</li>
				<li class="f14">육즙과 부드럽게 맛이 유지되는 수비드 공법으로 조리된 육류</li>
				<li class="f14">천연 소재 맛 성분과 소스의 조화를 연구</li>
			</ul>
			<div class="divider"></div>
			<h2 class="font-brown">04. 과학적인 영양설계</h2>
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
			<h2 class="font-brown">05. 바른재료와 철저한 위생관리</h2>
			<img class="floatleft" src="/mobile/images/reductionProgram05.png" width="113" height="37" style="margin-right: 10px;" />
			<p class="f14" style="display: inline-block; width: 55%;">풀무원 식품안전센터를 통한 원료 안전성 검사 및 완제품 안전성 컨트롤</p>
			<div class="divider"></div>
			<img class="floatleft" src="/mobile/images/reductionProgram06.png" width="113" height="37" style="margin-right: 10px;" />
			<p class="f14">센트럴키친을 통한 품질의 표준화 및 전문화</p>
			<div class="divider"></div>
			<h2 class="font-brown">06. 포장 & 배달</h2>
			<div style="margin: 5px auto;">
				<img src="/mobile/images/reductionProgram07.png" width="100%" />
			</div>
			<h3>안전하고 신선한 냉장배송</h3>
			<p class="f14">잇슬림 자체 극신선 배송시스템으로 출고되는 후부터 고객님이 배달받는 시점까지 냉장0~10℃로 유지될 수 있도록 냉장차량온도 관리 및 보냉패키지 설계가 되어있습니다.</p>
			<div style="margin: 5px auto;">
				<img src="/mobile/images/reductionProgram08.png" width="100%">
			</div>
			<h3>완전밀폐! 완벽포장! 안전용기!</h3>
			<p class="f14">전자레인지에 데워도 유해물질이 나오지 않는 용기를 사용합니다.</p>
			<div class="divider"></div>
			<h3>제품수령</h3>
			<p class="f14">잇슬림 자체 배송시스템을 통해 배송이 이루어지며, 현관앞비치, 경비실 위탁수령 2가지 방법 중에서 고객님의 편의에 따라 선택하여 배송받으실 수 있습니다.</p>
		</div>
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/popup/program_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
					<td><a href="/mobile/shop/dietProgram-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">프로그램다이어트 구매</span></span></a></td>
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