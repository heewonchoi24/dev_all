<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
	String query			= "";
	int groupId				= 0;
	int price				= 0;
	int totalPrice			= 0;
	int realPrice			= 0;
	String groupInfo		= "";
	String offerNotice		= "";
	String groupName		= "";
	NumberFormat nf			= NumberFormat.getNumberInstance();
	String table			= " ESL_GOODS_GROUP";
	String where			= " WHERE GUBUN1 = '01' AND GUBUN2 = '11'";
	String sort				= " ORDER BY ID ASC";
	String portionSize = "";
%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%> <!--  -->
        <ul class="subnavi">
			<li><a href="/mobile/shop/healthyMeal.jsp">헬씨퀴진</a></li>
            <li class="current"><a href="/mobile/shop/dietMeal.jsp">식사다이어트</a></li>
            <li><a href="/mobile/shop/fullStep.jsp">프로그램</a></li> <!--  -->
            <li><a href="/mobile/shop/minimeal.jsp">간편식</a></li> <!--  -->
			<li><a href="/mobile/shop/dietCLA.jsp">기능식품</a></li>	<!--  -->
			<li><a href="/mobile/shop/onion.jsp">건강즙</a></li> <!--  -->
        </ul>
    </div>
    <!-- End ui-header -->
    
    <!-- Start Content -->
    <div id="content">
	<!--
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/popup/alacarte_info.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
                 <td><a href="/mobile/shop/dietMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">식사 다이어트 구매하기</span></span></a></td>
               </tr>
           </table>
           </div>
		   -->
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/dietMeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;퀴진&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />&nbsp;</span></span></a></td>
					<td><a href="/mobile/shop/dietMeal-alacarteA.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">알라까르떼<br />슬림</span></span></a></td>  
				    <td><a href="/mobile/shop/dietMeal-alacarteB.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner1"><span class="ui-btn-text">알라까르떼<br />헬씨</span></span><span class="active"></span></a></td>
                </tr>
			</table>
           </div>
           <div class="row">
           <div class="bg-gray font-brown">
               <p>덮밥/리조또 등의 형태로 전자레인지에 데워 간편하게 먹을 수 있는 <strong>"알라까르떼 헬씨"</strong>(총 10종 메뉴)</p>
               <div style="margin:10px 0 5px 0;"><img src="/mobile/images/img_top_goods04.jpg" width="100%" alt="" /></div>

		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/popup/dietmeal_info.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
					<td><a href="/mobile/shop/dietMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">식사 다이어트 구매하기</span></span></a></td>
				</tr>
			</table>
		</div>
         <div class="divider"></div>

                  <div class="memo">
                      <div class="ribbon-tit"></div>
                      <ul>
                          <li class="memo01">총 10가지 다양한 메뉴로 질리지 않는 즐거운 식사</li>
                          <li class="memo02">데워서 간편하게 언제 어디서나 섭취 가능</li>
                          <li class="memo03">풀무원 식문화연구소 자문단의 과학적인 영양설계</li>
                          <li class="memo04">풀무원 극신선배송시스템으로 신선도 유지</li>
                      </ul>
                  </div>
           </div>
           </div>

           <div class="divider"></div>
           <div class="row">
				<h2 class="font-brown">01. 메뉴별 제품 정보</h2>
               <div class="guide">* 아래 메뉴가 주차별로 순환됩니다. 클릭하시면 자세히 볼 수 있습니다. <br />
			   * 알라까르떼 헬씨는 스포키가 함께 제공됩니다.
			   </div>
               <ul class="ui-listview">
					<%
					int setId			= 0;
					String thumbImg		= "";
					String imgUrl		= "";
					String setName		= "";
					String calorie		= "";

					query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG,PORTION_SIZE FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 10 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
					pstmt		= conn.prepareStatement(query);
					rs			= pstmt.executeQuery();

					int i			= 0;
					int divNum		= 0;
					String divClass	= "";
					while (rs.next()) {
						setId		= rs.getInt("ID");
						thumbImg	= rs.getString("THUMB_IMG");
						if (thumbImg.equals("") || thumbImg == null) {
							imgUrl		= "/images/quizin_sample.jpg";
						} else {										
							imgUrl		= webUploadDir +"goods/"+ thumbImg;
						}
						setName		= rs.getString("SET_NAME");
						calorie		= (rs.getString("CALORIE").equals(""))? "" : rs.getString("CALORIE");

						portionSize = rs.getString("PORTION_SIZE");

						divNum		= i % 3;
						if (divNum == 0) {
							divClass	= " ui-first-child";
						} else if (divNum == 8) {
							divClass	= " ui-last-child";
						} else {
							divClass	= "";
						}
					%>
					<li class="ui-btn ui-btn-up-e ui-li ui-li-has-thumb<%=divClass%>">
                       <div class="ui-btn-inner ui-li">
                           <a class="ui-link-inherit iframe" href="/mobile/shop/cuisineinfo/cuisineA.jsp?set_id=<%=setId%>">
                           <img class="ui-li-thumb" src="<%=imgUrl%>" width="116" height="70">
                           <h3 class="ui-li-heading"><%=setName%></h3>
                           <p class="ui-li-desc">총1회 제공량 <%=portionSize%>g</p>
                           </a>
                           <span class="cal_banner"><%=calorie%><br />kcal</span>
                       </div>
                   </li>
					<%
						i++;
					}
					%>
               </ul>
           </div>

	<div class="row">
                <h2 class="font-brown">02. 식사다이어트만의 특별함</h2> 
                   <h2 class="font-wbrown">과학적인 영양설계</h2>
                   <p>GI/GL의 원리를 다이어트 식사에 적용 하여, 탄수화물 특성에 따른 열량의 체내 흡수율을 고려하고, 그에 따른 적합한 식단을 설계</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">안전한 냉장온도 유지</h2>
                   <p>출고 후 고객이 배달받기까지 냉장 0~10˚C로 유지될 수 있도록 풀무원 극신선배달시스템으로 냉장차량온도 관리 및 보냉팩키지 설계</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">쉽고 간편한 식사</h2>
                   <p>식사준비 필요없이 가정(사무실)에서 데우기만 하면 OK! 평균 367Kcal의 다이어트 전문 식단</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">나트륨기준 충족</h2>
                   <p>식이섬유와 단백질이 풍부한 식사구성을 지향하며, 일일 2,000mg나트륨기준을 충족하여 설계</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">호텔출신 쉐프팀이 펼치는 각국 대표요리</h2>
                   <p>각국 도시의 대표요리가 호텔 출신 잇슬림 쉐프들의 손을 거쳐 과학적인 다이어트식으로 재탄생 </p>

               <div class="divider"></div>
               <h2 class="font-brown">03. 맛있는 다이어트</h2>
                <ul class="dot">
                    <li class="f14">한식/양식/일식/중식호텔출신 전문 쉐프팀</li>
                    <li class="f14">육즙과 부드럽게 맛이 유지되는 수비드 공법으로 조리된 육류</li>
                    <li class="f14">천연 소재 맛 성분과 소스의 조화를 연구 </li>
                </ul>
              <div class="divider"></div>
              <h2 class="font-brown">04. 과학적인 영양설계</h2>
              <h3 class="font-blue"><strong>Low GL diet point !</strong></h3>
              <p class="f16"><strong>1일 기준 적절한 탄수화물 공급</strong></p>
              <p class="f14">단백질과 수분손실 등 영양불균형을 최소화 합니다.</p>
              <div class="divider"></div>
              <p class="f16"><strong>Low GI (당 지수)를 고려한 재료 선정 및 설계 기준 설정</strong></p>
              <p class="f14">탄수화물에 의한 체내 흡수속도를 조정하기 위하여 재료의 종류를 선정하고, 전체 탄수화물 공급원 중 풀무원기준에 맞춘 Low GI로 분류되는 탄수화물 급원 비율을 조정합니다.</p>
              <div class="divider"></div>
              <p class="f16"><strong>Low GL (당부하 지수)를 고려한 탄수화물 함량 설정</strong></p>
              <p class="f14">바른 탄수화물의 질적/양적 기준으로 제품별 1회 섭취시 GL지수를 산출하여 전체 식단을 검증합니다.</p>
              <div class="divider"></div>
              <h2 class="font-brown">05. 다양한 메뉴구성</h2>
              <p class="f14">평균 295kcal, 리조또, 필라프, 크림 스튜 등 평소 다이어트에는 고칼로리 음식으로 먹지 못했던 메뉴를, 저칼로리 레시피로 만들어 맛있게 구성하였습니다.</p>
              <div class="divider"></div>
              <h2 class="font-brown">06. 바른재료와 철저한 위생관리</h2>
              <img class="floatleft" src="/mobile/images/reductionProgram05.png" width="113" height="37" style="margin-right:10px;">
              <p class="f14" style="display:inline-block;width:55%;">풀무원 식품안전센터를 통한 원료 안전성 검사 및 완제품 안전성 컨트롤</p>
              <div class="divider"></div>
              <img class="floatleft" src="/mobile/images/reductionProgram06.png" width="113" height="37" style="margin-right:10px;">
              <p class="f14">센트럴키친을 통한 품질의 표준화 및 전문화</p>
              <div class="divider"></div>
              <h2 class="font-brown">07. 포장 & 배달</h2>
              <div style="margin:5px auto;"><img src="/mobile/images/reductionProgram07.png" width="100%"></div>
              <h3>안전하고 신선한 냉장배달</h3>
              <p class="f14">잇슬림 자체 극신선 배달시스템으로 출고되는 후부터 고객님이 배달받는 시점까지 냉장0~10℃로 유지될 수 있도록 냉장차량온도 관리 및 보냉패키지 설계가 되어있습니다.</p>
              <div style="margin:5px auto;"><img src="/mobile/images/reductionProgram08.png" width="100%"></div>
              <h3>완전밀폐! 완벽포장! 안전용기!</h3>
              <p class="f14">전자레인지에 데워도 유해물질이 나오지 않는 용기를 사용합니다.</p>
              <div class="divider"></div>
              <h3>제품수령</h3>
              <p class="f14">잇슬림 자체 배달시스템을 통해 배달이 이루어지며, 현관앞비치, 경비실 위탁수령 2가지 방법 중에서 고객님의 편의에 따라 선택하여 배달받으실 수 있습니다.</p>
             </div>

           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
			   <td><a href="/mobile/shop/popup/dietmeal_info.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
                 <td><a href="/mobile/shop/dietMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">식사 다이어트 구매하기</span></span></a></td>
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