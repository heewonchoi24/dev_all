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
var _TRK_PNG = "간편식";
var _TRK_PNG_NM = "03";
var _TRK_PNC = "0331";
var _TRK_PNC_NM = "수프";
</SCRIPT>

<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> 시크릿수프 </h1>
			<div class="pageDepth">
				HOME > 제품소개 > <strong>시크릿수프</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
				<div class="one last col">
					<div class="secret_pr">
					   <h2><img src="/images/secret_tit.png" width="442" height="152"></h2>
					   <div class="chep_img">
					       <img src="/images/secret_img2.png" width="456" height="347">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">칼로리 DOWN</p>
						   <p>탄수화물 특성을 고려한 원재료를<br />구성으로 섭취한 열량 대비 체내에서<br />흡수되는 열량을 낮추도록 설계</p>
					   </div>
					   <!--
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">Beauty&Balance</p>
						   <p style="text-align:right;">장내 배변활동을 원활하게 도와주는<br />식이섬유와 뷰티레시피 콜라겐을 넣어<br />다이어트 기간에 부족하기 쉬운<br />밸런스를 맞춤</p>
					   </div>
					   -->
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right;">맛있는 시크릿 스프</p>
						   <p style="text-align:right;">토마토 파스타, 팥죽, 미역국 컨셉으로<br />맛까지 잡은 맛있는 시크릿 스프</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">비법 재료와 레시피</p>
						   <p>6가지 비법 재료로 만든<br />홈메이드타입 수프입니다.<br />열량은 낮고 영양이 풍부한 레드빈(팥)과<br />율무, 곤약, 닭가슴살, 이집트콩등을<br />함유한 잇슬림만의 비법 레시피!</p>
					   </div>
					   <div class="chep_05">
					       <img src="../images/secret_img2dec.png" width="445" height="129">
						</div>
					</div>
					<div class="secret_pr2 marb50">
					    <div class="chep_01">
						     <img src="/images/secret_img3.png" width="1000" height="139">
						</div>
					</div>
					<div class="secret_pr3 marb50">
					    <div class="chep_01">
					       <img src="/images/secret_img4.png" width="863" height="140">
						</div>
					</div>
					<h2>시크릿수프 스케쥴</h2>
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>월</th>
							<th>화</th>
							<th>수</th>
							<th>목</th>
					<!--		<th>금</th>
							<th class="last">토</th> -->
							<th class="last">금</th>
						</tr>
						<tr>
							<td><p class="secr_soup bbl">수프D</p>이집트 콩토마토 풍기니<br />+<br />레드빈율무</td>
							<td><p class="secr_soup ggr">수프E</p>레드빈율무<br />+<br />닭가슴살 미역곤약</td>
							<td><p class="secr_soup bbr">수프F</p>닭가슴살 미역곤약<br />+<br />이집트 콩토마토 풍기니</td>
							<td><p class="secr_soup bbl">수프D</p>이집트 콩토마토 풍기니<br />+<br />레드빈율무</td>
							<td><p class="secr_soup ggr">수프E</p>레드빈율무<br />+<br />닭가슴살 미역곤약</td>
	<!--						<td><p class="secr_soup bbr">수프F</p>닭가슴살 미역곤약<br />+<br />이집트 콩토마토 풍기니</td> -->
						</tr>
					</table>
				</div>
			</div>
			<!-- End Row --> 
			<!-- 
            <div class="row">
			    <div class="one last col">
                <!-- 
                <img src="/images/secret_info.jpg" width="999" height="321"> 
       
                </div>
               <div class="clear"></div> 
            </div>
             -->
			
			<div class="divider">
			</div>
			<div class="row">
				<div class="one last col">
					<dl class="quizintit">
						<dt>시크릿수프</dt>
						<dd>6가지 비법재료와 식이섬유/콜라겐으로 만들어진 홈메이드 타입 3종 시크릿 수프</dd>
					</dl>
					
					<!-- 퀴진 리스트 -->
					<div class="foodlist">
						<%
						int setId			= 0;
						String thumbImg		= "";
						String imgUrl		= "";
						String setName		= "";
						String calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 6 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
			
			<div class="row">
				<div class="one last col center">
					<div class="button large dark">
						<a href="/shop/secretSoup.jsp">주문하기</a>
					</div>
				</div>
			</div>
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