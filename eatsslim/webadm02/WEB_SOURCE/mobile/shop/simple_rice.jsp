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
				<span><a href="/mobile/shop/simple_minimeal.jsp">잇슬림 미니밀</a></span>
				<span><a class="here" href="#">잇슬림 라이스</a></span>
				<span><a href="/mobile/shop/simple_secretsoup.jsp">시크릿수프</a></span>
			</td>
	    </tr>
      </table>
    </div>
    
    <div class="divider"></div>
    <div class="row">
      <div class="bg-gray font-brown">
        <p>밥만 바꿨을 뿐인데, 내몸의 변화가 느껴지는 잇슬림 라이스</p>
        <div class="mart20 marb30"><img src="/mobile/images/shop_rice_01.jpg" width="100%" alt="" /></div>
        <div class="memo">
          <div class="ribbon-tit"></div>
          <ul>
            <li class="memo05">일반밥(백미)보다 30% 낮은 칼로리!</li>
            <li class="memo04">칼로리는 낮고, 필수 아미노산이 풍부한 하이아미쌀</li>
            <li class="memo02">일상 생활에서 밥만 바꾸어도 체중 조절에 도움</li>
            <li class="memo01">매일 새롭고 즐거운 다이어트</li>
            <li class="memo03">식이섬유가 풍부해 포만감을 더하는 식재료 사용</li>
            <li class="memo07">평균 130kcal</li>
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
      <h2 class="font-brown">01. 잇슬림 라이스 상품 구성</h2>
      <div class="mart10 marb20"> 
		<p>잇슬림 라이스는 총 4가지 메뉴로 구성되어 있습니다.<br/>동일한 메뉴 2개가 1SET로 구성되며, 최초 3SET부터 주문 가능합니다.</p>
		<img src="/mobile/images/shop_rice_02.jpg" width="100%" alt="" />        
      </div>
      <div class="divider"></div>
      <h2 class="font-brown">02. 잇슬림 라이스만의 특별함</h2>
      <div style="margin:15px auto;width:235px;"><img src="/mobile/images/esRice01.png" width="235" height="160" alt="시크릿수프"></div>
      <h3 class="font-wbrown">잇슬림만의 비법으로 일반밥보다 30% 낮은 칼로리</h3>
      <p>칼로리는 낮고, 필수 아미노산이 풍부한 곤약과 하이아미쌀을 사용하여 일반 밥(백미) 대비 칼로리를 30% 낮추었습니다. (즉석밥 130g: 190Kcal, 잇슬림 라이스 130g: 130Kcal</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">건강한 비법재료로 맛있고 든든한 밥!</h3>
      <p>각 메뉴별로 섬유질이 풍부해 다이어트 시 도움이 되는 흑미, 녹차잎, 약콩, 단호박을 사용하여 든든한 포만감은 물론, 맛과 식감을 더하였습니다.</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">일상에서 작은 변화를 통한 내몸의 변화</h3>
      <p>급격한 변화를 통한 체중감량이 아닌 일상생활 속에서 밥만의 변화를 통하여 자연스럽게 내 몸의 변화를!</p>
      <div class="divider"></div>
	  <h2 class="font-brown">03. 잇슬림 라이스 메뉴 소개</h2>
	  <table width="100%" class="tblMinimeal">
		<tr>
			<td width="50%">
				<img src="/mobile/images/shop_rice_03.jpg" width="100%" alt="매운한돈우엉밥">
				<p class="menuTit">아마씨드오곡밥</p>
				<p class="menuTxt">주재료 : 아마씨드, 무, 곤약, 유기찹쌀, 자수정보리쌀, 유기현미, 율무</p>
			</td>
			<td width="50%">
				<img src="/mobile/images/shop_rice_04.jpg" width="100%" alt="고구마찜닭흑미밥">
				<p class="menuTit">흑미곤약무밥</p>
				<p class="menuTxt">주재료 : 무, 곤약, 유기찹쌀, 유기흑미</p>
			</td>
		</tr>
		<tr>
			<td width="50%">
				<img src="/mobile/images/shop_rice_05.jpg" width="100%" alt="매운한돈우엉밥">
				<p class="menuTit">검은콩율무단호박밥</p>
				<p class="menuTxt">주재료 : 검은약콩, 단호박, 이집트콩, 유기찹쌀, 무, 곤약</p>
			</td>
			<td width="50%">
				<img src="/mobile/images/shop_rice_06.jpg" width="100%" alt="고구마찜닭흑미밥">
				<p class="menuTit">녹차잎귀리밥</p>
				<p class="menuTxt">주재료 : 녹차잎, 귀리, 쌀, 유기찹쌀, 무, 곤약</p>
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