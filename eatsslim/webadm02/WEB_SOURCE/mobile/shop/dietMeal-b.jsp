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
            <li class="current"><a href="/mobile/shop/dietMeal.jsp">식사다이어트</a></li>
            <li><a href="/mobile/shop/fullStep.jsp">프로그램다이어트</a></li>
            <li><a href="/mobile/shop/minimeal.jsp"> 타입별다이어트</a></li>
        </ul>
    </div>
    <!-- End ui-header -->
    
    <!-- Start Content -->
    <div id="content" style="margin-top:135px;">
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/popup/dietmeal_info.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">상품정보</span></span></a></td>
                 <td><a href="/mobile/shop/dietMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">식사 다이어트 구매하기</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/dietMeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">퀴진<br />한식Style</span></span></a></td>
					<td><a href="/mobile/shop/dietMeal-b.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner1"><span class="ui-btn-text">퀴진<br />양식Style</span></span><span class="active"></span></a></td>
					<td><a href="/mobile/shop/dietMeal-alacarteA.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">신선한<br />알라까르떼</span></span></a></td>
                    <td><a href="/mobile/shop/dietMeal-alacarteB.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">든든한<br />알라까르떼</span></span></a></td>
				</tr>
			</table>
           </div>
           <div class="row">
           <div class="bg-gray font-brown">
               <p>퀴진 양식STYLE은 세계의 다양한 요리를 저열량 건강식단으로 만나보는 Designed Diet Meal입니다.</p>
               <div style="margin:25px 0 30px 0;"><img src="/mobile/images/img_top_goods02.jpg" width="100%" alt="" /></div>
                  <div class="memo">
                      <div class="ribbon-tit"></div>
                      <ul>
                          <li class="memo01">총 18가지 다양한 메뉴로 질리지 않는 즐거운 식사</li>
                          <li class="memo02">특급호텔 출신 쉐프가 직접 만드는 맛있는 식사</li>
                          <li class="memo03">풀무원 식문화연구소 자문단의 과학적인 영양설계</li>
                          <li class="memo04">풀무원 극신선배송시스템으로 신선도 유지</li>
                      </ul>
                  </div>
           </div>
           </div>
           
           <div class="row">
           <div class="guide">* 아래 메뉴가 주차별로 순환됩니다.</div>
               <ul class="ui-listview">



					<%
					int setId			= 0;
					String thumbImg		= "";
					String imgUrl		= "";
					String setName		= "";
					String calorie		= "";

					query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG,PORTION_SIZE FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 1 ORDER BY GS.ID";
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
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
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