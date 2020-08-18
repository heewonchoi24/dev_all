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
var _TRK_PNC = "0300717";
var _TRK_PNC_NM = "퀴진";
</SCRIPT>

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
					       <p class="f24 bold8 goodtt">매일 다른 메뉴로 배달되는<br />칼로리를 낮춘 도시락</p>
						   <p>한식 or 양식으로 매일매일 색다른 메뉴로 배달되어<br />전자레인지에 데워 바로 섭취하는 간편한 저칼로리 도시락<br />(주 5회, 2주/4주 주문, 총20여가지 메뉴)</p>
					   </div>
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">맛과 영양<br />두가지 모두를<br />살린 요리!</p>
						   <p style="text-align:right;">영양이 풍부한 슈퍼푸드, 곡물을<br />호텔출신 풀무원 쉐프들의 레시피로 만든<br />맛과 영양을 모두 살린 요리!</p>
					   </div>
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right;">안전한 냉장온도 유지</p>
						   <p style="text-align:right;">출고후 고객이 배달받기까지 냉장0~10&deg;C로<br />유지될 수 있도록 풀무원 극신선배송시스템으로<br />냉장차량온도 관리 및 보냉패키지 설계</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">다이어트를 위한<br />과학적인 영양설계</p>
						   <p>탄수화물:지방:단백질의 황금비율의 영양설계에<br />튀기지 않는 웰빙조리법으로 만든<br />평균 367Kcal의 칼로리 Down 식사</p>
						   <p>일일 섭취권장량 2,000mg 나트륨 기준에 맞춘<br />나트륨 Down 식사</p>
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
						<dt>퀴진 STYLE</dt>
						<dd>한식/양식 다양한 메뉴를 칼로리 & 나트륨 Down된 건강식단으로 만나보는 <strong>Designed Diet Meal</strong></dd>
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
					<p class="mart10 marb10">* 잇슬림에서는 불필요한 일회용품 사용을 줄이고, 다이어트 식습관을 길들이기 위해서 <strong>일부 메뉴는 젓가락만 제공</strong>됩니다. <br />
					* 젓가락만 제공되는 퀴진 메뉴 : 삼치오븐구이세트, 두부돈저냐세트, 매운닭조림세트, 닭고기간장찜세트, 치킨앤넛츠믹스세트, 팽이버섯제육불고기세트, 구운오야꼬동세트
					</p>
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