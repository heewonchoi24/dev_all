<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
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
    <%@ include file="/mobile/common/include/inc-header.jsp"%>
    <ul class="subnavi">
      <li><a href="/mobile/shop/dietMeal.jsp">식사다이어트</a></li>
      <li><a href="/mobile/shop/fullStep.jsp">프로그램다이어트</a></li>
      <li class="current"><a href="/mobile/shop/secretSoup.jsp">타입별다이어트</a></li>
    </ul>
  </div>
  <!-- End ui-header -->
  <!-- Start Content -->
  <div id="content" style="margin-top:135px;">
    
	<div class="grid-navi">
      <table class="navi" border="0" cellspacing="10" cellpadding="0">
        <tr>
          <td><a href="/mobile/shop/popup/ssoup_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
          <td><a href="/mobile/shop/typeDiet_order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">타입별 다이어트 구매하기</span></span></a></td>
        </tr>
      </table>
    </div>
	<div class="grid-navi">
      <table class="navi" cellspacing="10" cellpadding="0">
        <tr>
          <td>
			 <a href="#" class="ui-btn ui-btn-inline ui-btn-up-a">
				<span class="ui-btn-inner">
					<span class="ui-btn-text">간편식</span></span><span class="active">
				</span>
			</a>
		  </td>
          <td><a href="/mobile/shop/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">밸런스 쉐이크</span></span></a></td>
        </tr>
		<tr class="easyMeal">
			<td colspan="2">
				<span><a class="here" href="#">잇슬림 미니밀</a></span>
				<span><a href="/mobile/shop/simple_rice.jsp">잇슬림 라이스</a></span>
				<span><a href="/mobile/shop/simple_secretsoup.jsp">시크릿수프</a></span>
			</td>
	    </tr>
      </table>
    </div>
    
    <div class="divider"></div>
    <div class="row">
      <div class="bg-gray font-brown">
        <p>한손에 쏙, 간편하게 즐기는 미니컵밥 칼로리 걱정없이 기분 좋은 든든함, 잇슬림 미니밀</p>
        <div class="mart20 marb30"><img src="/mobile/images/shop_minimeal_01.jpg" width="100%" alt="" /></div>
        <div class="memo">
          <div class="ribbon-tit"></div>
          <ul>
            <li class="memo05">슈퍼곡물, 푸드를 사용한 밥으로 건강한 다이어트</li>
            <li class="memo04">미니컵 타입으로 언제 어디서나 간편하게!</li>
            <li class="memo02">다이어트 중에도 맛있게</li>
            <li class="memo01">매일 새롭고 즐거운 다이어트</li>
            <li class="memo03">식이섬유가 풍부해 포만감을 더하는 식재료 사용</li>
            <li class="memo07">평균 200kcal</li>
          </ul>
        </div>
      </div>
    </div>
    <div class="row">
      <ul class="ui-listview">
        <%
					int setId			= 0;
					String thumbImg		= "";
					String imgUrl		= "";
					String setName		= "";
					String calorie		= "";

					query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG,PORTION_SIZE FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 6 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
          <div class="ui-btn-inner ui-li"> <a class="ui-link-inherit iframe" href="/mobile/shop/cuisineinfo/cuisineA.jsp?set_id=<%=setId%>"> <img class="ui-li-thumb" src="<%=imgUrl%>" width="116" height="70">
            <h3 class="ui-li-heading"><%=setName%></h3>
            <p class="ui-li-desc">총1회 제공량 <%=portionSize%>g</p>
            </a> <span class="cal_banner"><%=calorie%><br />
            kcal</span> </div>
        </li>
        <%
						i++;
					}
					%>
      </ul>
    </div>
    <div class="divider"></div>
    <div class="row">
      <h2 class="font-brown">01. 잇슬림 미니밀 상품 구성</h2>
      <div class="mart10 marb20"> 
		<p>잇슬림 미니밀은 한식 스타일 / 양식 스타일로 구성되어 있습니다. 각 스타일 별로 3개의 미니밀 제품이 구성되어 있으며 최소 2set부터 주문가능합니다.</p>
		<img src="/mobile/images/shop_minimeal_02.jpg" width="100%" alt="" />        
      </div>
      <div class="divider"></div>
      <h2 class="font-brown">02. 잇슬림 미니밀만의 특별함</h2>
      <div style="margin:15px auto;width:235px;"><img src="/mobile/images/esMinimeal01.png" width="235" height="160" alt="시크릿수프"></div>
      <h3 class="font-wbrown">Simple! 미니컵 타입으로 한손으로 간편하게</h3>
      <p>언제 어디서나 간편하게 한끼 해결! 다이어터, 바쁜 직장인 등 현대인들의 건강한 한 끼를 위해 Mini- Cup 타입으로 한손에 들고, 간편하게 섭취하는 One-dish meal</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">Healthy! 슈퍼곡물, 푸드로 건강한 다이어트를</h3>
      <p>슈퍼곡물 퀴노아와 귀리를 비롯한 흑미, 자수정보리, 현미 등 모든 메뉴에 건강 잡곡을 사용한 밥으로 건강함을! 슈퍼푸드 녹차 및 우엉, 두부 등 다이어트에 도움을 주는 재료를 사용!</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">Tasty! 다이어트중에도 맛있게 먹자!</h3>
      <p>200kcal지만 포만감을 주는 식재료 구성으로 든든하고 맛있게 즐길 수 있는 잇슬림 미니밀! 식이섬유가 풍부해 포만감을 더하는 녹차, 귀리, 유기 현미 등의 식재료 사용!</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">Beauty&Balance</h3>
      <p>장내 배변활동을 원활하게 도와주는 식이섬유와 뷰티레시피 콜라겐을 넣어 다이어트 기간에 부족하기 쉬운 밸런스 맞춤</p>
      <div class="divider"></div><br/>
	  <h2 class="font-brown">03. 잇슬림 미니밀 메뉴 소개</h2>
	  <table width="100%" class="tblMinimeal">
		<tr>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_03.jpg" width="100%" alt="매운한돈우엉밥">
				<p class="menuTit">매운한돈우엉밥</p>
				<p class="menuTxt">건강 곡류인 유기흑미와 식이섬유를 포함한 밥에 매콤한 돼지고기와 뿌리채소인 우엉, 파프리카가 어우러진 매운한돈우엉덮밥입니다.</p>
			</td>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_04.jpg" width="100%" alt="고구마찜닭흑미밥">
				<p class="menuTit">고구마찜닭흑미밥</p>
				<p class="menuTxt">건강 곡류인 유기흑미와 GI지수가 낮은 고구마가 어우러진 밥에 달콤 매콤한 간장찜닭이 어우러진 맛있는 고구마찜닭흑미덮밥입니다.</p>
			</td>
		</tr>
		<tr>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_05.jpg" width="100%" alt="매운한돈우엉밥">
				<p class="menuTit">소고기마파두부보리밥</p>
				<p class="menuTxt">건강 곡류인 자수정찰보리쌀과 두부, 버섯 등 다이어트에 도움을 주는 재료를 사용한 중화 풍의 마파두부덮밥입니다.</p>
			</td>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_06.jpg" width="100%" alt="고구마찜닭흑미밥">
				<p class="menuTit">녹차현미삼계리조또</p>
				<p class="menuTxt">카테킨이 들어있는 슈퍼푸드 녹차잎의 개운함과 식이섬유, 현미에  담백하고 진한 삼계의 맛이 어우러져 맛있게 즐기 수 있는 녹차잎현미삼계리조또입니다. </p>
			</td>
		</tr>
		<tr>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_07.jpg" width="100%" alt="레드퀴노아연두부게살리조또">
				<p class="menuTit">레드퀴노아연두부게살리조또</p>
				<p class="menuTxt">슈퍼곡물인 퀴노아와 다이어트에 도음을 주는 연두부, 게살에 청양고추를 넣어 칼칼하고 부드럽게 먹는 중식풍 리조또입니다..</p>
			</td>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_08.jpg" width="100%" alt="양송이버섯귀리리조또">
				<p class="menuTit">양송이버섯귀리조또</p>
				<p class="menuTxt">슈퍼푸드 통곡식 귀리와 현미가 토마토 소스와 닭가슴살, 채소와 잘 어우러져 부드러운 양송이버섯통귀리리조또입니다.</p>
			</td>
		</tr>
	  </table><br/><br/>
	  <h2 class="font-brown">04. 포장 & 배달</h2>
	  <ul class="step04">
		<li class="tit"><p>[택배 배달 프로세스]</p></li>
		<li>잇슬림의 택배 배달은 풀무원의 <span>철저한 신선 제품 냉장 운영기준</span>에 따라 택배 발송부터 익일 고객님 수령까지 안전하게 유지합니다.</li>
		<li>잇슬림의 택배 배달은 <span>35℃에서도 30시간까지 5℃를 유지</span>하도록 아이스젤과 드라이아이스를 사용합니다.</li>
		<li>잇슬림의 택배 패키지는 0℃-5℃를 유지하며 제품이 얼었다 녹음으로 인한 <span>관능의 저하를 막을 수 있도록 세심하게 설계</span>되었습니다.</li>
		<img src="/mobile/images/shop_minimeal_09.jpg" width="100%" alt="택배 배달 프로세스">
	  </ul><br/>
	  <ul class="step04">
		<li class="tit"><p>[택배 수령일 안내]</p></li>
		<li>평일 및 일반 배송 수령일 주문 시, 익일 발송이 가능한 요일인 <span>화, 수, 목, 금, 토요일만</span> 익일 수령 가능합니다.  택배사(CJ택배)의 일요일 휴무로 인하여, 익일 배송이 불가능한 <span>일요일, 월요일은 택배 배달이 없으며, 공휴일은 택배 발송 및 수령이 불가능</span>합니다.</li>
		<li>하단 표와 같이 <span>수요일이 공휴일인 경우,</span> 택배사 휴무로 인하여 배송과 출고가 없기 때문에, 수요일, 목요일 이틀간 제품을 수령하실 수 없습니다.</li><br/>
		<img src="/mobile/images/shop_minimeal_10.jpg" width="100%" alt="택배 수령일 안내"><br/><br/>
		<img src="/mobile/images/shop_minimeal_11.jpg" width="100%" alt="택배 수령일 안내">
	  </ul><br/>
    </div>
    <div class="grid-navi">
      <table class="navi" border="0" cellspacing="10" cellpadding="0">
        <tr>
          <td><a href="/mobile/shop/popup/ssoup_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
          <td><a href="/mobile/shop/typeDiet_order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">타입별 다이어트 구매하기</span></span></a></td>
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