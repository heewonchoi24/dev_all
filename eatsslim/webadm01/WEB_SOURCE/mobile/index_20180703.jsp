<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
NumberFormat nf		= NumberFormat.getNumberInstance();
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
String table		= "ESL_EVENT";
String where		= "";
String query		= "";
String queryQ		= "";
String query1		= "";
int intTotalCnt		= 0;
int eventId			= 0;
String listImg		= "";
String imgUrl		= "";
String eventUrl		= "";
String viewLink		= "";
String title		= "";
String bannerImg 	= "";
String clickLink 	= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();

String chkMonth		= "";
String todayYear	= "";
String todayMonth	= "";
String todayDay		= "";

String year			= today.substring(0 , 4);
String month		= today.substring(5 , 7);
String day			= today.substring(8 , 10);


int footerNoticeId = 0;
String footerTitle = "";


%>

	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/idangerous.swiper.css" />
	<script src="/mobile/common/js/idangerous.swiper.js" type="text/javascript"></script>

	<!-- <link href="/mobile/common/css/main_style.css" rel="stylesheet" /> -->
	<link href="/mobile/common/css/jquery.bxslider.css" rel="stylesheet" />
	<!-- bxSlider Javascript file -->
	<script src="/mobile/common/js/jquery.bxslider.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$('#slider1').bxSlider({
		  mode: 'fade',
		  auto: true,
		  autoControls: true,
		  pause: 2000
		});

		$('#slider2').bxSlider({
		  auto: true,
		  autoControls: true,
		  pause: 3000
		});
	});

	function clickMainBanner(url) {

		ga('send', 'event', 'main', 'click', '잇슬림이벤트');

		if (url) {
			location = url;
		}

	}
	</script>

	<style>
	/* [s] 공통 */
	/* IE10 Windows Phone 8 Fixes */
	.swiper-wp8-horizontal {
		-ms-touch-action: pan-y
	}

	.swiper-wp8-vertical {
		-ms-touch-action: pan-x
	}

	#mBanner {margin-top: 5px; padding: 0 5px}
	#mBanner a {display: block;}
	#mBanner a img {width: 100%; max-width: auto}
	</style>

	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/stylesheet_n2.css" />
	<script type="text/javascript" src="/mobile/common/js/jssor.js"></script>
	<script type="text/javascript" src="/mobile/common/js/jssor.slider.js"></script>
	<meta name="format-detection" content="telephone=no" />
</head>

<body class="">
<div id="wrap" class="expansioncss">
	<%@ include file="/mobile/common/include/inc-header.jsp"%>
	<div class="clearfix"></div>
	<div id="main_container">

		<!-- main_slider -->
		<div class="visual_area">
			<div class="main_visual">
<%
				query		= "SELECT ID, TITLE, BANNER_IMG, LINK";
				query		+= " FROM ESL_BANNER ";
				query		+= " WHERE GUBUN in ('5') AND OPEN_YN = 'Y' AND ('"+ today +"' BETWEEN STDATE AND LTDATE)";
				query		+= " ORDER BY ID DESC";
				pstmt		= conn.prepareStatement(query);
				rs			= pstmt.executeQuery();

				while (rs.next()) {
					title			= rs.getString("TITLE");
					bannerImg		= rs.getString("BANNER_IMG");
					if (bannerImg.equals("") || bannerImg == null) {
						imgUrl		= "../images/event_thumb01.jpg";
					} else {
						imgUrl		= webUploadDir +"banner/"+ bannerImg;
					}
					clickLink		= rs.getString("LINK");
%>
				<div class="visual_item"><a href="<%=clickLink%>"><img src="<%=imgUrl%>" alt="<%=title%>"></a></div>
<%
				}

				rs.close();
%>
			</div>
			<div class="main_visual_count">
				<span class="current"></span>/<span class="total"></span>
				<a href="/mobile/main_slider_pop.jsp" class="main_visual_more cboxElement2"><img src="/mobile/common/images/m_mainvisual_more.png" alt="" /></a>
			</div>
		</div>
		<!-- notice ticker -->
		<div class="row">
			<div class="notice_ticker">
				<h2>Notice</h2>
				<%
					query		= "SELECT ID, TOP_YN, TITLE, CONTENT, LIST_IMG, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE";
					query		+= " FROM ESL_NOTICE WHERE 1=1";
					query		+= " ORDER BY TOP_YN DESC, ID DESC";
					query		+= " LIMIT 1";
					pstmt		= conn.prepareStatement(query);

					rs			= pstmt.executeQuery();

					/* 공지사항 갯수 */
					query1		= "SELECT COUNT(*)";
					query1		+= " FROM ESL_NOTICE";
					pstmt		= conn.prepareStatement(query1);

					rs1			= pstmt.executeQuery();
					int noticeCnt 	= 0;
					if(rs1.next()){
						noticeCnt = rs1.getInt(1);
					}

					if(noticeCnt > 0){
						if(rs.next()){
							footerNoticeId	= rs.getInt("ID");
							footerTitle		= rs.getString("TITLE");
						}
						%>
						<p><a href="/mobile/customer/notice.jsp?id=<%=footerNoticeId%>" title="<%=footerTitle%>"><%=ut.cutString(36, footerTitle, "..")%></a></p>
						<%
					}
				%>
				<a href="/mobile/customer/notice.jsp" class="notice_more">더보기</a>
			</div>
			<!-- //notice ticker -->
			<!-- banner -->
			<div class="banner_main">
				<ul>
					<li><a href="/mobile/shop/mypage/index.jsp">
						<img src="/mobile/common/images/ico/m_banner_img1.png" alt="" />
						<p><span>주문조회변경</span></p>
					</a></li>
					<li><a href="/mobile/intro/schedule.jsp">
						<img src="/mobile/common/images/ico/m_banner_img2.png" alt="" />
						<p><span>이달의 식단</span></p>
					</a></li>
					<li><a href="/mobile/delivery/delivery.jsp">
						<img src="/mobile/common/images/ico/m_banner_img3.png" alt="" />
						<p><span>배달지역확인</span></p>
					</a></li>
					<li><a href="/mobile/shop/mypage/outmallOrder.jsp">
						<img src="/mobile/common/images/ico/m_banner_img4.png" alt="" />
						<p><span>타쇼핑몰<br/>주문확인</span></p>
					</a></li>
				</ul>
			</div>
		</div>
		<!-- //banner -->

		<div class="row">
			<h2 class="title">잇슬림 추천 제품</h2>
			<div class="cont1">
				<ul class="item_list">

<%
query		= "SELECT \n";
query		+= "		(SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE DATE_FORMAT(NOW( ) , '%Y-%m-%d') BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS ATYPE, \n";
query		+= "		(SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE DATE_FORMAT(NOW( ) , '%Y-%m-%d') BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS BTYPE, \n";
query		+= " 		GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1,KAL_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, ";
query		+= " 		DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5, CATE_CODE, DAY_EAT";
query		+= " FROM ESL_GOODS_GROUP EGG";
query		+= " WHERE USE_YN = 'Y' ";
query		+= " AND LIST_VIEW_YN = 'Y' ";
query		+= " AND TAG LIKE '%,05,%' ";
query		+= " ORDER BY TAG_SORT DESC LIMIT 4";
//System.out.println(query);
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
while(rs.next() ){
	int maintotalPrice			= 0;
	int maingroupPrice			= rs.getInt("GROUP_PRICE");
	int maingroupPrice1			= rs.getInt("GROUP_PRICE1");
	int mainkalInfo				= rs.getInt("KAL_INFO");
	int maincartId				= rs.getInt("ID");
	String mainaType			= rs.getString("ATYPE");
	String mainbType			= rs.getString("BTYPE");
	String maingroupCode		= rs.getString("GROUP_CODE");
	String maingroupName		= rs.getString("GROUP_NAME");
	String maingroupInfo1		= rs.getString("GROUP_INFO1");
	String maingroupImg			= rs.getString("GROUP_IMGM");
	String maingubun2			= rs.getString("GUBUN2");
	String maintag				= rs.getString("TAG");
	String maindevlType			= rs.getString("DEVL_GOODS_TYPE");
	String maingubun2Txt		= ut.isnull(rs.getString("DAY_EAT") );;

	if(mainbType == null){
		maintotalPrice = maingroupPrice1;
	}else{
		if(mainaType.equals("P")){
			//int maindBtype = Integer.parseInt(mainbType)/100.0;
			maintotalPrice = maingroupPrice1 - (int)(maingroupPrice1 * Integer.parseInt(mainbType)/100.0); // %세일 계산
			//System.out.println(maintotalPrice);
		}else if(mainaType.equals("W")){
			maintotalPrice = maingroupPrice1 - Integer.parseInt(mainbType);
		}else if(mainaType == null){
			maintotalPrice = maingroupPrice1;
		}
	}
%>
					<li><a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=<%=maincartId%>&groupCode=<%=maingroupCode %>">

						<div class="img">
							<div class="centered">
								<img src="/data/goods/<%=maingroupImg%>" alt="" />
							</div>
							<div class="badge">
								<%
									if(maintag.indexOf("01") != -1){
										%>
										<span class="b_event"></span>
										<%
									}
									if(maintag.indexOf("02") != -1){
										%>
										<span class="b_special"></span>
										<%
									}
									if(maintag.indexOf("03") != -1){
										%>
										<span class="b_sale"></span>
										<%
									}
									if(maintag.indexOf("04") != -1){
										%>
										<span class="b_new"></span>
										<%
									}
									if(maintag.indexOf("05") != -1){
										%>
										<span class="b_rcmd"></span>
										<%
									}
									if(maintag.indexOf("06") != -1){
										%>
										<span class="b_best"></span>
										<%
									}
								%>
							</div>
							<button type="button" class="minimal_cart" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/order/__ajax_goods_set_options.jsp?groupId=<%=maincartId%>'});return false;"><img src="/mobile/common/images/order/ico_cart_s.png" alt="" /></button>
						</div>
						<div class="info">
							<p class="title"><%=maingroupName%></p>
							<p class="desc">
								<span class="price">
									<span><strong><%=ut.getComma(maintotalPrice)%>원</strong></span>
									<%=maingroupPrice1 == maintotalPrice ? "":"<span><del>"+ut.getComma(maingroupPrice1)+"원</del></span>"%>
								</span>
								<%="".equals(maingubun2Txt) ? "" : "<span class=\"description\">"+maingubun2Txt+"</span>"%>
							</p>
						</div>
					</a></li>
<%
}
if(rs != null) rs.close();
if(pstmt != null) pstmt.close();
%>
				</ul>
			</div>
		</div>
		<div class="row">
			<h2 class="title">잇슬림 칼로리 조절 프로그램</h2>
			<div class="cont1">
				<ul class="item_list">
<%
query		= "SELECT \n";
query		+= "		(SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE DATE_FORMAT(NOW( ) , '%Y-%m-%d') BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS ATYPE, \n";
query		+= "		(SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE DATE_FORMAT(NOW( ) , '%Y-%m-%d') BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS BTYPE, \n";
query		+= " 		GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1,KAL_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, ";
query		+= " 		DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5, CATE_CODE, DAY_EAT";
query		+= " FROM ESL_GOODS_GROUP EGG";
query		+= " WHERE USE_YN = 'Y' ";
query		+= " AND LIST_VIEW_YN = 'Y' ";
query		+= " AND ID IN (65,51,82) ";

query		+= " ORDER BY ID ASC LIMIT 3";
//System.out.println(query);
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
while(rs.next() ){
	int maintotalPrice			= 0;
	int maingroupPrice			= rs.getInt("GROUP_PRICE");
	int maingroupPrice1			= rs.getInt("GROUP_PRICE1");
	int mainkalInfo				= rs.getInt("KAL_INFO");
	int maincartId				= rs.getInt("ID");
	String mainaType			= rs.getString("ATYPE");
	String mainbType			= rs.getString("BTYPE");
	String maingroupCode		= rs.getString("GROUP_CODE");
	String maingroupName		= rs.getString("GROUP_NAME");
	String maingroupInfo1		= rs.getString("GROUP_INFO1");
	String maingroupImg			= rs.getString("GROUP_IMGM");
	String maingubun2			= rs.getString("GUBUN2");
	String maintag				= rs.getString("TAG");
	String maindevlType			= rs.getString("DEVL_GOODS_TYPE");
	String maingubun2Txt		= ut.isnull(rs.getString("DAY_EAT") );;

	if(mainbType == null){
		maintotalPrice = maingroupPrice1;
	}else{
		if(mainaType.equals("P")){
			//int maindBtype = Integer.parseInt(mainbType)/100.0;
			maintotalPrice = maingroupPrice1 - (int)(maingroupPrice1 * Integer.parseInt(mainbType)/100.0); // %세일 계산
			//System.out.println(maintotalPrice);
		}else if(mainaType.equals("W")){
			maintotalPrice = maingroupPrice1 - Integer.parseInt(mainbType);
		}else if(mainaType == null){
			maintotalPrice = maingroupPrice1;
		}
	}
%>
					<li><a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=<%=maincartId%>&groupCode=<%=maingroupCode %>">

						<div class="img">
							<div class="centered">
								<img src="/data/goods/<%=maingroupImg%>" alt="" />
							</div>
							<div class="badge">
								<%
									if(maintag.indexOf("01") != -1){
										%>
										<span class="b_event"></span>
										<%
									}
									if(maintag.indexOf("02") != -1){
										%>
										<span class="b_special"></span>
										<%
									}
									if(maintag.indexOf("03") != -1){
										%>
										<span class="b_sale"></span>
										<%
									}
									if(maintag.indexOf("04") != -1){
										%>
										<span class="b_new"></span>
										<%
									}
									if(maintag.indexOf("05") != -1){
										%>
										<span class="b_rcmd"></span>
										<%
									}
									if(maintag.indexOf("06") != -1){
										%>
										<span class="b_best"></span>
										<%
									}
								%>
							</div>
							<button type="button" class="minimal_cart" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/order/__ajax_goods_set_options.jsp?groupId=<%=maincartId%>'});return false;"><img src="/mobile/common/images/order/ico_cart_s.png" alt="" /></button>
						</div>
						<div class="info">
							<p class="title"><%=maingroupName%></p>
							<p class="desc">
								<span class="price">
									<span><strong><%=ut.getComma(maintotalPrice)%>원</strong></span>
									<%=maingroupPrice1 == maintotalPrice ? "":"<span><del>"+ut.getComma(maingroupPrice1)+"원</del></span>"%>
								</span>
								<%="".equals(maingubun2Txt) ? "" : "<span class=\"description\">"+maingubun2Txt+"</span>"%>
							</p>
						</div>
					</a></li>
<%
}
if(rs != null) rs.close();
if(pstmt != null) pstmt.close();
%>
				</ul>
			</div>
		</div>
		<div class="row">
			<h2 class="title">오늘의 식단</h2>
			<%
			/* 오늘의 식단 쿼리 */
			query		= "SELECT COUNT(*) AS CNT, (SELECT DAYOFWEEK('"+today+"')) AS WEEK ";
			query		+= " FROM ESL_SYSTEM_HOLIDAY WHERE DATE_FORMAT(HOLIDAY, '%Y') =  '"+ year  + "' AND DATE_FORMAT(HOLIDAY, '%m') =  '"+  month  + "' AND DATE_FORMAT(HOLIDAY, '%d') =  '"+ day+"' AND HOLIDAY_TYPE = '02' ";
			query		+= " ORDER BY HOLIDAY DESC, ID DESC";
			pstmt		= conn.prepareStatement(query);
			rs			= pstmt.executeQuery();

			int holidayCnt 	= 0;
			int weekCnt		= 0;
			if(rs.next()){
				holidayCnt 	= rs.getInt("CNT");
				weekCnt		= rs.getInt("WEEK");
			}

			%>
			<div class="cont1">
				<div class="date_calendar"><!--달력부분에 링크 추가 2017. 09. 15  -->
					<div class="date_calendar_inner"><a href="/mobile/intro/schedule.jsp">
						<span class="img"><img src="/mobile/common/images/common/m_img_date_calendar.png" alt="" /></span>
						<span class="year"><%=year %></span>.
						<span class="month"><%=month %></span>.
						<span class="date"><%=day %></span></a>
					</div>
				</div>
				<ul class="foodtable_list">
				<%
				if(holidayCnt < 1 && weekCnt != 1 && weekCnt != 7){
					queryQ		= "SELECT S.ID, SET_NAME, CATEGORY_CODE, CALORIE, THUMB_IMG, BIG_IMG, S.USE_YN ";
					queryQ		+= " FROM ESL_GOODS_CATEGORY_SCHEDULE CS, ESL_GOODS_SET S , ESL_GOODS_SET_CONTENT B";
					queryQ		+= " WHERE CS.SET_CODE = S.SET_CODE";
					queryQ		+= " AND S.ID = B.ID";
					queryQ		+= " AND CATEGORY_CODE IN ('0301368','0300584','0300700','0300586','0300702','0300965')";
					queryQ		+= " AND DEVL_DATE = '"+today+"'";
					queryQ		+= "AND S.USE_YN = 'Y'";
					queryQ		+= " ORDER BY FIELD(CATEGORY_CODE,'0300584','0300700','0300586','0300702','0300965','0301368') ";
					pstmt		= conn.prepareStatement(queryQ);
					rs			= pstmt.executeQuery();

					String caregoryCode = "";
					String setName 		= "";
					String calorie		= "";
					String thumbImg		= "";
					String bigImg		= "";
					int setID			= 0;
					while(rs.next()){
						caregoryCode	= rs.getString("CATEGORY_CODE");
						setName			= rs.getString("SET_NAME");
						calorie			= rs.getString("CALORIE");
						thumbImg		= rs.getString("THUMB_IMG");
						bigImg			= rs.getString("BIG_IMG");
						setID			= rs.getInt("ID");
						%>
						<li>
							<div class="img"><a class="iframe cboxElement" href="/mobile/shop/cuisineinfo/cuisineA.jsp?set_id=<%=setID%>&caregoryCode=<%=caregoryCode%>"><img src="/data/goods/<%=bigImg %>" alt="" /></a></div>
							<div class="info">
							<%
								if(caregoryCode.equals("0301368") || caregoryCode.equals("0301368")){
									%>
									<div class="category">헬씨퀴진</div>
									<%
								}else if(caregoryCode.equals("0300584") || caregoryCode.equals("0300700")){
									%>
									<div class="category">퀴진</div>
									<%
								}else if(caregoryCode.equals("0300586") || caregoryCode.equals("0300702")){
									%>
									<div class="category">알라까르떼 슬림</div>
									<%
								}else if(caregoryCode.equals("0300965")){
									%>
									<div class="category">알라까르떼 헬씨</div>
									<%
								}
							%>
								<div class="title"><%=setName %></div>
								<div class="calorie"><%=calorie %>kcal</div>
							</div>
						</li>

						<%
					}
				}else if(holidayCnt > 0 || weekCnt == 1 || weekCnt == 7){
					/* 오늘의 식단이 없을시 이미지 처리 부분 */
					%>
					<li class="emptyToday">
						<img src="/dist/images/common/emptyToday.jpg" alt="" />
					</li>
				<%
				}
				%>
					<!-- <li>
						<div class="img"><a href="javascript:void(0);"><img src="/dist/images/sample_todaymenu1.jpg" alt=""></a></div>
						<div class="info">
							<div class="category">헬씨퀴진</div>
							<div class="title">오돈불고기세트</div>
							<div class="calorie">367kcal</div>
						</div>
					</li>
					<li>
						<div class="img"><a href="javascript:void(0);"><img src="/dist/images/sample_todaymenu2.jpg" alt=""></a></div>
						<div class="info">
							<div class="category">퀴진</div>
							<div class="title">담백한두부 덮밥세트</div>
							<div class="calorie">367kcal</div>
						</div>
					</li>
					<li>
						<div class="img"><a href="javascript:void(0);"><img src="/dist/images/sample_todaymenu3.jpg" alt=""></a></div>
						<div class="info">
							<div class="category">알라까르떼 슬림</div>
							<div class="title">오븐커틀렛 샐러드</div>
							<div class="calorie">367kcal</div>
						</div>
					</li>
					<li>
						<div class="img"><a href="javascript:void(0);"><img src="/dist/images/sample_todaymenu4.jpg" alt=""></a></div>
						<div class="info">
							<div class="category">알라까르떼 헬씨</div>
							<div class="title">매운닭조림과 퀴노아밥</div>
							<div class="calorie">367kcal</div>
						</div>
					</li> -->
				</ul>
			</div>
	<!-- 2017.08.08 삭제
			<div class="cont2">
				<a href="/mobile/colums/dietColum.jsp"><img src="/mobile/common/images/m_linebanner.jpg" alt="" /></a>
			</div> -->
		</div>
		<div class="row">
			<h2 class="title">브랜드 스토리</h2>
			<div class="cont1">
				<ul class="bs_list">
					<li><a href="/mobile/intro/eatsslimStory.jsp" title="잇슬림 스토리"><img src="/mobile/common/images/common/m_bs1.jpg" alt="" /></a></li>
					<li><a href="/mobile/intro/eatsslimFeature.jsp" title="잇슬림 특징"><img src="/mobile/common/images/common/m_bs2.jpg" alt="" /></a></li>
					<li><a href="/mobile/delivery/freshparcel.jsp" title="극신선 일일배달"><img src="/mobile/common/images/common/m_bs3.jpg" alt="" /></a></li>
				</ul>
			</div>
		</div>
		<div class="row last">
			<h2 class="title">#eatsslim_<p class="subtt"><a href="https://www.instagram.com/eatsslim_/?ref=badge" target="_blank">잇슬림 인스타그램 바로가기 ></a></p></h2>
			<div class="cont1 ajax_insta_list">
				<ul></ul>
			</div>
		</div>
	</div>
	<!-- End content -->
	<%@ include file="/mobile/common/include/inc-footer.jsp"%>
</div>
</body>
<script type="text/javascript">

	var list = "";
	$.ajax({
		url : 'https://api.instagram.com/v1/users/self/media/recent/?access_token=2100633077.84cd584.2218414d0cb647c7afde45effa6ac53d',
		type:"POST",
		async : false,
		dataType : "jsonp",
		success : function (args){
			for (var i = 0; i < 9; i++){
				var images = args.data[i].images.low_resolution.url;
				var alternativeText = args.data[i].caption.text;
				var itemLink = args.data[i].link;

				list += '<li>';
				list += '<a href="';
				list += itemLink;
				list += '" target="_blank">';
				list += '<img src="'+images+'" alt="'+alternativeText+'" />';
				list += '<span></span>';
				list += '</a>';
				list +=	'</li>';

				$(".ajax_insta_list ul").empty().html(list);
			}
		},
		complete : function (args){
			$(".ajax_insta_list ul").slick({
			  infinite: true,
			  dots: true,
			  arrows: false,
			  slidesToShow: 3,
			  slidesToScroll: 3
			});
		},
		error : function(e){
			alert(e.reponseText);
		}
	});
</script>
</html>