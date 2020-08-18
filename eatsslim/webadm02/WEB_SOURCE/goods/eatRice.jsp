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
			<h1> 잇슬림 라이스 </h1>
			<div class="pageDepth">
				HOME > 제품소개 > <strong>잇슬림 라이스</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
				<div class="one last col">
					<div class="rice_pr">
					   <h2><img src="/images/rice_tit.png"></h2>
					   <div class="chep_img">
					       <img src="/images/rice_img2.png" width="489" height="341">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">잇슬림만의 비법으로<br />일반밥보다 30% 낮은 칼로리</p>
						   <p>칼로리는 낮고 필수 아미노산이 풍부한 곤약과<br /> 하이아미쌀을 사용하여 일반 밥(흰쌀밥) 대비<br /> 칼로리를 30% 낮추었습니다. (즉석밥 130g:<br /> 190Kcal, 잇슬림 라이스 130g: 130Kcal)</p>
					   </div>
					   <!--
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">Beauty&Balance</p>
						   <p style="text-align:right;">장내 배변활동을 원활하게 도와주는<br />식이섬유와 뷰티레시피 콜라겐을 넣어<br />다이어트 기간에 부족하기 쉬운<br />밸런스를 맞춤</p>
					   </div>
					   -->
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right; margin-right:40px;">건강한 비법 재료로<br /> 맛있고 든든한 밥!</p>
						   <p style="text-align:right; margin-right:40px;">200kcal지만 포만감을 주는 식재료 구성으로<br/> 든든하고 맛있게 즐길 수 있는 잇슬림 미니밀!<br/> 식이섬유가 풍부해 포만감을 더하는<br/> 녹차, 귀리, 유기 현미 등의 식재료 사용!</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">일상에서 작은 변화를 <br />통한 내몸의 변화  </p>
						   <p>급격한 변화를 통한 체중감량이 아닌<br/> 일상 생활 속에서 밥만의 변화를 통하여<br/> 자연스럽게 내 몸의 변화를 도와 줍니다.</p>
					   </div>					 
					</div>
					<div class="rice_pr2 marb50"></div>
					
			
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
						<dt>잇슬림 라이스</dt>
						<dd>일상생활 속 밥만의 변화로 내몸의 변화를!</dd>
					</dl>
					
					<!-- 퀴진 리스트 -->
					<div class="foodlist">
						<%
						int setId			= 0;
						String thumbImg		= "";
						String imgUrl		= "";
						String setName		= "";
						String calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 12 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
						<a href="/shop/eatRice.jsp">주문하기</a>
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