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

<SCRIPT type="text/javascript">
var _TRK_PI = "PDV";
var _TRK_PNG = "식사다이어트";
var _TRK_PNG_NM = "01";
var _TRK_PNC = "0300719";
var _TRK_PNC_NM = "알라까르떼";
</SCRIPT>

<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> 알라까르떼 </h1>
			<div class="pageDepth">
				HOME > 제품소개 > <strong>알라까르떼</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
				<div class="one last col">
					<div class="alacarte_pr">
					   <h2><img src="/images/alacarte_tit.png" width="507" height="147"></h2>
					   <div class="chep_img">
					       <img src="/images/alacarte_img_1.png" width="463" height="341">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">과학적인 영양설계</p>
						   <p>GI/GL의 원리를 다이어트 식사에 적용하여,<br />탄수화물 특성에 따른 열량의 체내 흡수율을<br />고려하고, 그에 따른 적합한 식단을 설계</p>
					   </div>
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">쉽고 간편한 식사</p>
						   <p style="text-align:right;">식사준비 필요없이 가정(사무실)에서<br />바로 or 데우기만 하면 OK!<br />평균 265kcal의 다이어트 전문 식단</p>
					   </div>
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right;">안전한 냉장온도 유지</p>
						   <p style="text-align:right;">출고후 고객이 배달받기까지 냉장0~10&deg;C로<br />유지될 수 있도록 풀무원 극신선배송시스템으로<br />냉장차량온도 관리 및 보냉패키지 설계</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">호텔출신 쉐프팀이<br />펼치는 각국 대표요리</p>
						   <p>각국 도시의 대표요리가 호텔출신 잇슬림 쉐프들의<br />손을 거쳐 과학적인 다이어트식으로 재탄생</p>
					   </div>
					   <div class="chep_05">
					       <p class="f24 bold8 goodtt">건강레시피로 구성</p>
						   <p>식이섬유와 단백질이 풍부한 식사구성을<br />지향하며, 튀기지 않고 가공을 최소화</p>
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
						<dt>알라까르떼 슬림</dt>
						<dd>간편한 One-dish Meal 형태로 낮은 칼로리의 신선한 Designed Diet Meal</dd>
					</dl>
					
					<!-- 퀴진 리스트 -->
					<div class="foodlist">
						<%
						int setId			= 0;
						String thumbImg		= "";
						String imgUrl		= "";
						String setName		= "";
						String calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 9 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
								<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>" title="<%=setName%>"><img src="<%=imgUrl%>" alt="<%=setName%>" />
								<div class="food-link">
								<div class="food-calorie">
									<%=calorie%>
								</div>
								<div class="food-title">
									<%=setName%>
								</div>
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
				<div class="one last col">
					<dl class="quizintit">
						<dt>알라까르떼 헬씨</dt>
						<dd>간편한 One-dish Meal 형태로  데워먹는 낮은 칼로리에 든든한 Designed Diet Meal</dd>
					</dl>
					
					<!-- 퀴진 리스트 -->
					<div class="foodlist">
						<%
						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 10 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
						pstmt		= conn.prepareStatement(query);
						rs			= pstmt.executeQuery();

						i			= 0;
						divNum		= 0;
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
								<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>" title="<%=setName%>"><img src="<%=imgUrl%>" alt="<%=setName%>" />
								<div class="food-link">
								<div class="food-calorie">
									<%=calorie%>
								</div>
								<div class="food-title">
									<%=setName%>
								</div>
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
					<p class="mart10 marb10">* 알라까르떼 슬림은 포크가 제공되고, 알라까르떼 헬씨는 스포키가 제공됩니다.	</p>
				</div>
			</div>
			<!-- End Row -->
			<div class="row">
				<div class="one last col center">
					<div class="button large dark">
						<a href="/shop/dietMeal.jsp?tab=9">주문하기</a>
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