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
					<td><a href="/mobile/shop/cleanseProgram-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">프로그램다이어트 구매</span></span></a></td>
				</tr>
			</table>
		</div>
		<div class="grid-navi">
			<table class="navi" cellspacing="5" cellpadding="0">
				<tr>
		    		<td><a href="/mobile/shop/weight3days.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">3일</span></span></a></td>
					<td><a href="/mobile/shop/secretSlimming.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">6일</span></span></a></td>
					<td><a href="/mobile/shop/weight2weeks.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">2주</span></span></a></td>
					<td><a href="/mobile/shop/fullStep.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">4주</span></span></span></a></td>
					<td><a href="/mobile/shop/cleanseProgram.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner"><span class="ui-btn-text">클렌즈</span></span></span></a></td>
				</tr>
			</table>
		</div>
		<div class="divider"></div>
		<div class="row">
			<div class="bg-gray font-brown">
				<p>집중 감량부터 안정화 단계인 체중유지까지 설계된 프로그램으로 옵션에 따라 1주/ 2주/ 4주로 구성된 맞춤형 클렌즈 프로그램!</p>
				<div style="margin: 25px 0 10px 0;">
					<img src="/mobile/images/cleanse_mobile1.jpg" width="100%" alt="" />
				</div>
			</div>
		</div>
		<div class="row">
			<h2 class="font-brown">01. 프로그램(4주 옵션 기준)</h2>
			<div style="margin: 5px auto 15px;">
			<img src="/mobile/images/cleanse_mobile2.png" width="100%" style="margin-bottom: 10px" />
			<h3>1. 1일차 </h3>
			<p class="f14">24시간 쉬지 못하는 우리 몸의 휴식과 비움을 위한 클렌즈 시작(클렌즈 1day)! <br />하루 8병의 클렌즈주스로 가볍고 상쾌한 하루를 만들어주며 채소와 과일 퓨레가 포만감을 주어 배고픔을 덜어줍니다.</p>
			<h3>2. 감량 단계 </h3>
			<p class="f14">건강한 신체 유지, 활력있게 감량할 수 있도록 적정량의 탄수화물과 단백질 공급으로 신체의 지방을 태우는 모드로 전환시키는 기간입니다.</p>
			<h3>3. 주말(토,일) </h3>
			<p class="f14">대사작용을 정상으로 돌리기 위한 출발점을 의미하며, 이 기간동안 탄수화물 수치를 낮게 유지하게 됩니다. <br />특히 이 기간 동안 탄수화물 섭취량을 엄격히 지켜야 하며, 탄수화물에 대한 갈망을 줄이는데 효과를 끼치는 인슐린을 낮게 안정화 시키는 것이 중요합니다. <br />이 기간 동안 지방과 함께 함유되어 있는 수분의 체중이 빠지면서 높았던 인슐린 수치를 정상화합니다.</p>
			<h3>4. 안정화 단계 </h3>
			<p class="f14">감량이 한계를 보이는 시기에 단백질 공급량을 유지하면서 탄수화물을 높여, 적은 열량에 인체가 적응하게 되어 대사율이 떨어지는 문제를 방지하는 기간입니다.</p>
			<div class="divider"></div>
			<h2 class="font-brown">02. 체계적인 식사 스케쥴</h2>
			<div style="margin: 5px auto;">
			<p class="f14">모든 옵션에서 1주차의 1일차는 클렌즈(비움), 식사 4일이 제공되며,<br /> 2주차부터는 식사 5일이 제공됩니다.(주말은 고객이 직접 준비하실 수 있도록, 추천 식단만 제공합니다) </p>
			<div class="divider"></div>
				<img src="/mobile/images/cleanse_mobile3.png" width="100%" />
			</div>
			<p class="f12">- 퀴진, 알라까르떼, 미니밀은 식단에 따라 매일 다르게 배송됩니다.</p>
						<div class="divider"></div>
			<h3>* 다이어트에 도움이 되는 주말 식단 제안! </h3>
				<img src="/mobile/images/cleanse_mobile4.png" width="100%" />
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
					<td><a href="/mobile/shop/cleanseProgram-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">프로그램다이어트 구매</span></span></a></td>
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