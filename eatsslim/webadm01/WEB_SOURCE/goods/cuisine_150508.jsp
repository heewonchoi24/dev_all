<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
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
%>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> 퀴진 </h1>
			<div class="pageDepth">
				HOME > 제품소개 > <strong>퀴진</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
				<div class="one last col">
					<div class="cuisine_pr">
					   <h2><img src="/images/cuisine_tit.png" width="712" height="149"></h2>
					   <div class="chep_img">
					       <img src="/images/cuisine_img.png" width="431" height="275">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">과학적인 영양설계</p>
						   <p>GI/GL의 원리를 다이어트 식사에 적용하여,<br />탄수화물 특성에 따른 열량의 체내 흡수율을<br />고려하고, 그에 따른 적합한 식단을 설계</p>
					   </div>
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">맛과 영양 두가지를 모두를 살린 요리!</p>
						   <p style="text-align:right;">영양이 풍부한 슈퍼푸드, 곡물을 호텔출신 풀무원 쉐프들의 레시피로 만든 맛과 영양을 모두 살린 요리!</p>
					   </div>
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right;">안전한 냉장온도 유지</p>
						   <p style="text-align:right;">출고후 고객이 배달받기까지 냉장0~10&deg;C로<br />유지될 수 있도록 풀무원 극신선배송시스템으로<br />냉장차량온도 관리 및 보냉패키지 설계</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">안전한 냉장온도 유지</p>
						   <p>출고후 고객이 배달받기까지 냉장 0~10℃로 유지될 수 있도록 풀무원 극신선배송 시스템으로 냉장차량온도 관리 및 보냉패키지 설계</p>
					   </div>
					</div>
				</div>
			</div>
			<!-- End Row -->
			<div class="divider">
			</div>
			<div class="row">
				<div class="one last col">
					<dl class="quizintit">
						<dt>퀴진 한식STYLE</dt>
						<dd>한식 퓨전 식사에 맞게 저열량 건강식단으로 만나보는 <strong>Designed Diet Meal</strong> </dd>
					</dl>
					<!-- 퀴진 리스트 -->
					<div class="foodlist">
						<%
						int setId			= 0;
						String thumbImg		= "";
						String imgUrl		= "";
						String setName		= "";
						String calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 7 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
							calorie		= (rs.getString("CALORIE").equals(""))? "" : rs.getString("CALORIE") + "kcal";

							divNum		= i % 8;
							if (divNum == 0) {
								divClass	= " first";
							} else if (divNum == 8) {
								divClass	= " last";
							} else {
								divClass	= "";
							}
						%>
						<div class="food<%=divClass%>">
							<div>
								<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>" title="<%=setName%>"><img src="<%=imgUrl%>" alt="<%=setName%>" /></a> <a class="food-link lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>">
								<div class="food-calorie">
									<%=calorie%>
								</div>
								<div class="food-title">
									<%=setName%>
								</div>
								</a>
							</div>
						</div>
						<%
							i++;
						}
						%>
						<div class="clear">
						</div>
					</div>
					<!-- End 퀴진 리스트 -->
				</div>
			</div>
			<!-- End Row -->
			<div class="divider">
			</div>
			<div class="row">
				<div class="one last col">
					<dl class="quizintit">
						<dt>퀴진 양식STYLE</dt>
						<dd>세계의 다양한 요리를 저열량 건강식단으로 만나보는 <strong>Designed Diet Meal</strong></dd>
					</dl>
					<!-- 퀴진 리스트 -->
					<div class="foodlist">
						<%
						setId			= 0;
						thumbImg		= "";
						imgUrl		= "";
						setName		= "";
						calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 8 AND GS.USE_YN ='Y' ORDER BY GS.ID";
						pstmt		= conn.prepareStatement(query);
						rs			= pstmt.executeQuery();

						i			= 0;
						divNum		= 0;
						divClass	= "";
						while (rs.next()) {
							setId		= rs.getInt("ID");
							thumbImg	= rs.getString("THUMB_IMG");
							if (thumbImg.equals("") || thumbImg == null) {
								imgUrl		= "/images/quizin_sample.jpg";
							} else {										
								imgUrl		= webUploadDir +"goods/"+ thumbImg;
							}
							setName		= rs.getString("SET_NAME");
							calorie		= (rs.getString("CALORIE").equals(""))? "" : rs.getString("CALORIE") + "kcal";

							divNum		= i % 8;
							if (divNum == 0) {
								divClass	= " first";
							} else if (divNum == 8) {
								divClass	= " last";
							} else {
								divClass	= "";
							}
						%>
						<div class="food<%=divClass%>">
							<div>
								<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>" title="<%=setName%>"><img src="<%=imgUrl%>" alt="<%=setName%>" /></a> <a class="food-link lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>">
								<div class="food-calorie">
									<%=calorie%>
								</div>
								<div class="food-title">
									<%=setName%>
								</div>
								</a>
							</div>
						</div>
						<%
							i++;
						}
						%>
						<div class="clear">
						</div>
					</div>
					<!-- End 퀴진 리스트 -->
				</div>
			</div>
			<!-- End Row -->
			<div class="row">
				<div class="one last col center">
					<div class="button large dark">
						<a href="/shop/dietMeal.jsp">주문하기</a>
					</div>
				</div>
			</div>
			<!-- End Row -->
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear">
		</div>
	</div>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
</body>
</html>