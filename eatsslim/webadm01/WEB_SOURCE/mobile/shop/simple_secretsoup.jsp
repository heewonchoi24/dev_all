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
  <div id="content">
    
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
				<span><a href="/mobile/shop/simple_rice.jsp">잇슬림 라이스</a></span>
				<span><a class="here" href="#">시크릿수프</a></span>
			</td>
	    </tr>
      </table>
    </div>
    
    <div class="divider"></div>
    <div class="row">
      <div class="bg-gray font-brown">
        <p>6가지 채소와 저칼로리 재료의 비법레시피, 식이섬유/콜라겐 뷰티레시피를 더한 홈메이드 타입 수프</p>
        <div class="mart20 marb30"><img src="/mobile/images/img_top_ssoup01_01.jpg" width="100%" alt="" /></div>
        <div class="memo">
          <div class="ribbon-tit"></div>
          <ul>
            <li class="memo05">6가지 채소의 비법레시피!</li>
            <li class="memo04">식이섬유와 콜라겐의 뷰티레시피!</li>
            <li class="memo06">홈메이드 타입의 수프로 매일매일 새롭게</li>
            <li class="memo07">매일 새롭고 즐거운 다이어트</li>
            <li class="memo03">따뜻하게 데워서 즐기는 홈메이드 타입 수프</li>
            <li class="memo04">평균 100kcal</li>
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
      <h2 class="font-brown">01. 시크릿수프의 구성</h2>
      <div class="mart10 marb20"> <img src="/mobile/images/img_mid_ssoup02_01.jpg" width="100%" alt="" />
        <p class="f12">시크릿수프 상품은 1일 2개의 수프가 묶음으로 배송됩니다.<br />
          매일 2개씩 드시기 어려운 고객님은 배송타입(매일,월/수/금,화/목/토)과 배송기간을 설정하여 구매해주세요.</p>
      </div>
      <div class="divider"></div>
      <h2 class="font-brown">02. 잇슬림 수프만의 특별함</h2>
      <div style="margin:15px auto;width:235px;"><img src="/mobile/images/goods_img03_01.png" width="235" height="160" alt="시크릿수프"></div>
      <h3 class="font-wbrown">칼로리 Down</h3>
      <p>탄수화물의 특성을 고려한 원재료를 구성으로 섭취한 열량대비 체내에서 흡수되는 열량을 낮추도록 
        설계</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">즐거운 다이어트</h3>
      <p>토마토 파스타, 팥죽, 미역국 컨셉으로 맛까지 잡은 즐거운 다이어트</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">비법재료와 레시피</h3>
      <p>6가지 비법재료로 만든 홈메이드타입 다이어트 수프입니다. 열량은 낮고 영양이 풍부한 레드빈(팥)과 율무, 곤약, 닭가슴살, 이집트콩등을 함유한 잇슬림만의 비법 레시피!</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">Beauty&Balance</h3>
      <p>장내 배변활동을 원활하게 도와주는 식이섬유와 뷰티레시피 콜라겐을 넣어 다이어트 기간에 부족하기 쉬운 밸런스 맞춤</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">따뜻하게 데워서 즐기는 홈메이드 타입 다이어트 수프</h3>
      <div class="divider"></div>
      <p><img width="100%" src="/mobile/images/eatsslim_goods03.jpg"></p>
      <div class="divider"></div>
      <h2 class="font-brown">03. 시크릿수프 스케쥴</h2>
      <div class="marb20"><img src="/mobile/images/eatsslim_goods03_01_01.jpg" width="100%" alt="" /></div>
      <div class="divider"></div>
      <h2 class="font-brown">04. 포장&배달</h2>
      <div style="margin:15px auto;width:229px;"><img src="/mobile/images/shop_deli_01.jpg" width="100%" alt="" /></div>
      <h3>안전하고 신선한 냉장배달</h3>
      <p class="f14">잇슬림 자체 극신선 배송시스템으로 출고 되는 후부터 고객님이 배달받는 시점까지 냉장0~10℃로 유지될 수 있도록 냉장차량 온도 관리 및 보냉패키지 설계가 되어있습 니다. </p>
      <div style="margin:15px auto;width:229px;"><img src="/mobile/images/shop_deli_02.jpg" width="100%" alt="" /></div>
      <h3>제품수령</h3>
      <p class="f14">잇슬림 자체 배송시스템을 통해 배송이 이루
어지며, 현관앞비치, 경비실 위탁수령 2가지 방법 중에서 고객님의 편의에 따라 선택하여 배송받으실 수 있습니다.</p>
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