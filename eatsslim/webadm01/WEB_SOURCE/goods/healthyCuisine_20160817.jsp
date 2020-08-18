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
	String where			= " WHERE GUBUN1 = '01' AND GUBUN2 = '21'";
	String sort				= " ORDER BY ID ASC";
%>
</head>

<SCRIPT type="text/javascript">
var _TRK_PI = "PDV";
var _TRK_PNG = "건강도시락";
var _TRK_PNG_NM = "00";
var _TRK_PNC = "0301368";
var _TRK_PNC_NM = "헬씨퀴진";
</SCRIPT>

<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> 헬씨퀴진 </h1>
			<div class="pageDepth">
				HOME > 제품소개 > <strong>헬씨퀴진</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
				<div class="one last col">
					<div class="healthyCuisine_pr">
					<h2><span class=".font-maple">사계절 신선한 자연 식재료를 적용</span>하여 영양설계된 건강 도시락</h2>
					<h3>나트륨, 칼로리 조정, Low GL설계로<br />디자인 된 맛있는 식사, <strong>헬씨퀴진</strong></h3>
					<!--<h2><img src="/images/healthyCuisine_tit.png" width="681" height="145"></h2> -->
					   <div class="chep_img">
					       <img src="/images/healthyCuisine_img.png" width="406" height="280">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">자연을 담은<br />건강 도시락</p>
						   <p>사계절 신선한 제철 자연식재료를 적용하여<br />나물, 샐러드 등의 채소 2가지, 잡곡밥,<br />튀기지 않는 조리법을 적용한<br />건강 도시락 </p>
					   </div>
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">체중 관리 및<br />건강 관리</p>
						   <p style="text-align:right;">내몸을 위한 건강 관리와 체중 관리가<br />가능하도록 설계된 제품</p>
					   </div>
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right;">1식 40eGL설계<br />잇슬림 Low GL</p>
						   <p style="text-align:right;">한국인은 High GL식을 섭취하고 있어<br />복부비만과 대사증후군 위험이 높으며<br />Low GL식사는 혈당의 변화랑이 크지 않고<br />안정적으로 유지할 수 있어<br /> 포만감 유지와 식욕 조절에 도움</p>
						   <p style="text-align:right;">* eGL(estimated Glycemic Load)은 GL을<br />추정하기 위하여 풀무원에서 임상연구를 통해<br />개발한 GL계산법으로 한국인 평균 섭취 eGL은<br />1일 162eGL, 헬씨퀴진은 1일 120eGL원칙 적용!</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">과학적인 영양설계</p>
						   <p>대한지역사회영양학회 영양자문,<br />1식 기준 kcal 평균 500kcal이하,<br />나트륨 평균 950mg이하,<br />40eGL의 영양설계 적용</p>
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
						<dt>헬씨퀴진 STYLE</dt>
						<dd>사계절 신선한 자연 식재료를 적용하여 영양 설계된 <strong>Designed Healthy Meal</strong></dd>
					</dl>
					<!-- 퀴진 리스트 -->
					<div class="foodlist">
						<%
						int setId			= 0;

						String thumbImg		= "";
						String imgUrl		= "";
						String setName		= "";
						String calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 16 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
								<a class="food-thumb2 lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>" title="<%=setName%>"><img src="<%=imgUrl%>" alt="<%=setName%>" /></a> <a class="food-link lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>">
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
						<a href="/shop/healthyMeal.jsp">주문하기</a>
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

<!-- 미디어큐브 스크립트 2016-06-24 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=1035515&mt_adid=158356&v1=&v2=&v3=&s1=&s2=&s3='></script>

</body>
</html>