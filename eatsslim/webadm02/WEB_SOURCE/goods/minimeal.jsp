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
			<h1> 미니밀 </h1>
			<div class="pageDepth">
				HOME > 제품소개 > <strong>미니밀</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
				<div class="one last col">
					<div class="mini_pr">
					   <h2><img src="/images/mini_tit.png"></h2>
					   <div class="chep_img">
					       <img src="/images/minimeal_img2.png" width="425" height="350">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">Simple! 미니컵 타입으로<br />한손으로 간편하게</p>
						   <p>언제 어디서나 간편하게 한끼 해결!<br /> 
다이어터, 바쁜 직장인 등 현대인들의 건강한<br /> 한 끼를 위해 Mini- Cup 타입으로 한손에<br /> 들고 간편하게 섭취하는 One-dish meal</p>
					   </div>
					   <!--
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">Beauty&Balance</p>
						   <p style="text-align:right;">장내 배변활동을 원활하게 도와주는<br />식이섬유와 뷰티레시피 콜라겐을 넣어<br />다이어트 기간에 부족하기 쉬운<br />밸런스를 맞춤</p>
					   </div>
					   -->
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right; margin-right:40px;">Tasty! 다이어트 중에도<br/>맛있게 먹자!</p>
						   <p style="text-align:right; margin-right:40px;">200kcal지만 포만감을 주는 식재료 구성으로<br/> 든든하고 맛있게 즐길 수 있는 잇슬림 미니밀!<br/> 식이섬유가 풍부해 포만감을 더하는<br/> 녹차, 귀리, 유기 현미 등의 식재료 사용!</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">Healthy! 슈퍼곡물,푸드로<br/>건강한 다이어트를</p>
						   <p>슈퍼곡물 퀴노아와 귀리를 비롯한 흑미,<br/>자수정보리, 현미 등 모든 메뉴에<br/>건강 잡곡을 사용한 밥으로 건강함을!<br/>슈퍼푸드 녹차 및 우엉, 두부 등<br/>다이어트에 도움을 주는 재료를 사용!</p>
					   </div>					 
					</div>
					<div class="mini_pr2 marb50"></div>			
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
						<dt>잇슬림 미니밀</dt>
						<dd>칼로리 걱정없이 기분좋은 든든함</dd>
					</dl>					
					<!-- 퀴진 리스트 -->
					<div class="foodlist">
						<%
						int setId			= 0;
						String thumbImg		= "";
						String imgUrl		= "";
						String setName		= "";
						String calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 13 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
						<a href="/shop/minimeal.jsp">주문하기</a>
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