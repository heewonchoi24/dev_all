<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String temp_no = (String)session.getAttribute("esl_member_idx");
if(temp_no!=null){
	if(temp_no.equals("1")){//통합회원 sso에서 약관동의 안한 사람은 회원세션소멸
		session.setAttribute("esl_member_idx","");
		session.setAttribute("esl_member_id",null);
		session.setAttribute("esl_member_name","");
		session.setAttribute("esl_member_code",""); //통합회원 구분
		response.sendRedirect("https://www.eatsslim.co.kr/sso/logout.jsp");if(true)return;
	}
}

if(request.getServerName().equals("eatsslim.co.kr")){ ///www있을때랑 없을때랑 세션이 틀림
	response.sendRedirect("https://www.eatsslim.co.kr");if(true)return;
}
%>
<%
String query = "";
int noticeId = 0;
String topYn = "";
String title = "";
String content = "";
String listImg = "";
int maxLength = 0;
String imgUrl = "";
String instDate = "";
%>

	<script type="text/javascript" src="/common/js/main.js"></script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div id="index_slider" class="index_slider">
			<div id="index-slider-control" class="index-slider-control">
				<div class="index-slider-nav index-active-lt">
					<h2> 한눈에 보는<br />잇슬림 </h2>
					<span class="index-order"> 1 </span>
				</div>
				<div class="index-slider-nav">
					<h2> 식사<br />다이어트 </h2>
					<span class="index-order"> 2 </span>
				</div>
				<div class="index-slider-nav">
					<h2> 프로그램<br />다이어트 </h2>
					<span class="index-order"> 3 </span>
				</div>
				<div class="index-slider-nav">
					<h2> 타입별<br />다이어트 </h2>
					<span class="index-order"> 4 </span>
				</div>
			</div>
			<div id="index_slides" class="index_slides">
				<div class="index_slideri" id="index_slideri_1">
					<div class="index_inner_wrap">
						<a href="#" title="다이어트 식사" ><img src="/images/slideimg_01.jpg" alt="한눈에 보는 잇슬림" width="999" height="407" /></a>
					</div>
				</div>
				<div class="index_slideri" id="index_slideri_2">
					<div class="index_inner_wrap">
						<a href="#" title="잇슬림 프로그램" ><img src="/images/slideimg_02.jpg" alt="다이어트 식사" width="999" height="407" /></a>
					</div>
				</div>
				<div class="index_slideri" id="index_slideri_3">
					<div class="index_inner_wrap">
						<a href="#" title="기능식품" ><img src="/images/slideimg_03.jpg" alt="잇슬림 프로그램" width="999" height="407" /></a>
					</div>
				</div>
                <div class="index_slideri" id="index_slideri_4">
					<div class="index_inner_wrap">
						<a href="#" title="기능식품" ><img src="/images/slideimg_04.jpg" alt="기능식품" width="999" height="407" /></a>
					</div>
				</div>
			</div>
			<div class="sldr_clearlt">
			</div>
		</div>
		<!-- End index_slider -->
		<div class="divider">
		</div>
		<!--div class="one marb30">
			<form name="form1" method="post" action="">
				<div class="matching">
					<div class="section bg-blue" style="width:133px;">
						나에게 맞는 잇슬림
						<span class="skyarrow"></span>
					</div>
					<ul class="bodyinfo">
						<li>
							<label>키</label>
							<p>
								<input type="text" name="tall" id="tall">
								cm
							</p>
						</li>
						<li>
							<label>체중</label>
							<p>
								<input type="text" name="tall" id="tall">
								kg
							</p>
						</li>
						<li>
							<label>기간</label>
							<p>
								<input type="text" name="tall" id="tall">
								주
							</p>
						</li>
						<li class="last">
							<label>감량목료</label>
							<p>
								<input type="text" name="tall" id="tall">
								kg
							</p>
						</li>
					</ul>
					<div class="result">
						<div class="diagnose">
							<a class="lightbox" href="/shop/popup/mymacthing.jsp?lightbox[width]=620&lightbox[height]=450"></a>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				<!-- End matching -->
		</form>
		</div-->
		<!-- End one Cloumn #1-->
		<div class="sixteen columns offset-by-one">
			<div class="one">
				<div class="indexthird">
					<div id="smooth_slider_1" class="smooth_slider">
						<div class="smooth_sliderb">
							<div class="smooth_slideri">
								<a href="http://blog.eatsslim.com/40174122512?Redirect=Log&from=postView" target="new"><img src="/images/eatsslim_star_01.jpg" alt="잇슬림스타 김지민" /></a>
							</div>
							<div class="smooth_slideri">
								<a href="http://blog.eatsslim.com/40174737183?Redirect=Log&from=postView" target="new"><img src="/images/eatsslim_star_02.jpg" alt="잇슬림스타 김원효" /></a>
							</div>
							<div class="smooth_slideri">
								<a href="http://blog.eatsslim.com/40169741577?Redirect=Log&from=postView" target="new"><img src="/images/eatsslim_star_03.jpg" alt="잇슬림스타 신고은" /></a>
							</div>
							<div class="smooth_slideri">
								<a href="http://blog.eatsslim.com/40173569087?Redirect=Log&from=postView" target="new"><img src="/images/eatsslim_star_04.jpg" alt="잇슬림스타 정경미" /></a>
							</div>
							<div class="smooth_slideri">
								<a href="http://blog.eatsslim.com/40176685847?Redirect=Log&from=postView" target="new"><img src="/images/eatsslim_star_05.jpg" alt="잇슬림스타 심진화" /></a>
							</div>
							<div class="smooth_slideri">
								<a href="http://blog.eatsslim.com/40176884206?Redirect=Log&from=postView" target="new"><img src="/images/eatsslim_star_06.jpg" alt="잇슬림스타 박휘순" /></a>
							</div>
                            <div class="smooth_slideri">
								<a href="http://blog.eatsslim.com/40170032031?Redirect=Log&from=postView" target="new"><img src="/images/eatsslim_star_07.jpg" alt="잇슬림스타 정명옥" /></a>
							</div>
						</div>
						<!--div id="smooth_slider_1_nav" class="smooth_nav"></div-->
						<div id="smooth_slider_1_next" class="smooth_next" style="background-position:-41px 0; top:50%; right:0;">
						</div>
						<div id="smooth_slider_1_prev" class="smooth_prev" style="background-position:0 0; top:50%; left:0;">
						</div>
						<div class="sldr_clearlt">
						</div>
						<div class="sldr_clearrt">
						</div>
					</div>
				</div>
				<!-- End indexthird #2-1 -->
				<div class="indexthird">
					<a href="/intro/lowgldiet.jsp"><img src="/images/main_ad_01.jpg" alt="LOW GL Diet" width="333" height="295"></a>
				</div>
				<!-- End indexthird #2-2 -->
				<div class="indexthird">
					<a href="/shop/fullstepProgram.jsp"><img src="/images/main_banner_01.jpg" alt="Quick Diet" width="333" height="295" /></a>
				</div>
				<!-- End indexthird #2-3 -->
				<div class="clear">
				</div>
			</div>
			<!-- End one Cloumn #2-->
			<div class="one">
				<div class="indexthird">
					<a href="#" onClick="window.open('/intro/foodmonthplan.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,status=no,menubar=no,width=1015,height=600')"><img src="/images/201310.jpg" width="333" height="295" alt="식단" /></a>
				</div>
				<!-- End indexthird #3-1 -->
				<div class="indexthird">
					<div id="smooth_slider_2" class="smooth_slider">
						<div class="smooth_sliderb">
							<div class="box_title">
								잇슬림 후기
							</div>
							<div class="smooth_slideri">
								<a href="/colums/postScript.jsp">
								<div class="thumb">
									<img src="/images/sample_01.jpg" />
								</div>
								<div class="smooth_slidert">
									<div class="meta">
										<div class="star n4">
										</div>
										<div class="name">
											ortjs36 <span> 님 </span>										
                                        </div>
								  </div>
									<span> 맛있는 한식이 많다는 것이 매력이네요!<br/> 반찬도 골고루 좋아요~ </span>
								</div>
								</a>
							</div>
							<!-- End smooth_slideri 1 -->
							<div class="smooth_slideri">
								<a href="/colums/postScript.jsp">
							  <div class="thumb">
									<img src="/images/sample_02.jpg" />
								</div>
								<div class="smooth_slidert">
									<div class="meta">
										<div class="star n3">
										</div>
										<div class="name">yourbaby53<span> 님 </span>										</div>
								  </div>
									제겐 잇슬림 일주 체험이 정말 중요한 가이드가 되었어요!</div>
								</a>
							</div>
						  <!-- End smooth_slideri 2 -->
						</div>
						<!--div id="smooth_slider_1_nav" class="smooth_nav"></div-->
						<div id="smooth_slider_2_next" class="smooth_next" style="background-position:-82px 0; top:50%; right:20px;">
						</div>
						<div id="smooth_slider_2_prev" class="smooth_prev" style="background-position:-123px 0; top:50%; left:20px;">
						</div>
						<div class="sldr_clearlt">
						</div>
						<div class="sldr_clearrt">
						</div>
					</div>
				</div>
				<!-- End indexthird #3-2 -->
				<div class="indexthird">
					<a href="/event/currentEvent.jsp"><img src="/images/main_event_banner.jpg" width="333" height="295" alt="리뉴얼이벤트" /></a>
				</div>
				<!-- End indexthird #3-3 -->
				<div class="clear">
				</div>
			</div>
			<!-- End one Cloumn #3-->
			<div class="one">
				<div class="indexthird boxline">
					<div id="fb-root">
					</div>
					<script>(function(d, s, id) {
			  var js, fjs = d.getElementsByTagName(s)[0];
			  if (d.getElementById(id)) return;
			  js = d.createElement(s); js.id = id;
			  js.src = "//connect.facebook.net/ko_KR/all.js#xfbml=1";
			  fjs.parentNode.insertBefore(js, fjs);
			}(document, 'script', 'facebook-jssdk'));</script>
					<div class="fb-like-box" data-href="https://www.facebook.com/eatsslim" data-width="292" data-show-faces="true" data-header="false" data-stream="false" data-show-border="false">
					</div>
				</div>
				<!-- End indexthird #4-1 -->
				<div class="indexthird mbox_notice">
					<div class="box_title">
						공지사항
					</div>
					<p class="morelink"> <a href="/customer/notice.jsp"></a> </p>
					<ul>
					    <%
						query		= "SELECT ID, TOP_YN, TITLE, CONTENT, LIST_IMG, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE";
						query		+= " FROM ESL_NOTICE ";
						query		+= " ORDER BY INST_DATE DESC, ID DESC LIMIT 0, 6";
						pstmt		= conn.prepareStatement(query);
						rs			= pstmt.executeQuery();


						while (rs.next()) {
							noticeId	= rs.getInt("ID");
							topYn		= (rs.getString("TOP_YN").equals("Y"))? " class=\"headline\"" : "";
							title		= rs.getString("TITLE");
							content		= ut.convertHtmlTags(rs.getString("CONTENT"));
							listImg		= rs.getString("LIST_IMG");
							if (!listImg.equals("")) {
								imgUrl		= "<img class=\"thumbleft\" src=\""+ webUploadDir +"board/"+ listImg +"\" width=\"160\" height=\"108\" title=\""+ title +"\" />";
								maxLength	= 50;
							} else {
								imgUrl		= "";
								maxLength	= 70;
							}
							instDate	= rs.getString("WDATE");
						%>
						<li> <a href="customer/noticeView.jsp?id=<%=noticeId%>" title="<%=title%>"><%=ut.cutString(maxLength, title, "")%></a> <span class="date"> <%=instDate%> </span> </li>
						<% } %>
					  </li>
					</ul>
				</div>
				<!-- End indexthird #4-2 -->
				<div class="indexthird mbox_press">
					<div class="box_title">
											언론보도
					</div>
					<p class="morelink"> <a href="/customer/presscenter.jsp"></a> </p>
                    
					   
					<div class="articlebox">
					   <ul class="pressmain">
                         <li>
                         <a href="http://www.marieclairekorea.com/user/beauty/beauty/view.asp?midx=7282" target="new">
                         <img class="pressthumb" src="images/press_thumb01.jpg" width="137" height="65">
                         <h5>마리끌레르 6월호</h5>
                         <p class="article">오피스 다이어트의 정석</p>
                         </a>
                         </li>
                         <li>
                         <a href="http://www.mlounge.co.kr/living/living_read.html?seq=6348&article_type=N&pub=201306&svc=8&page=2&sea" target="new">
                         <img class="pressthumb" src="images/press_thumb02.jpg" width="137" height="65">
                         <h5>리빙센스 6월호</h5>
                         <p class="article">도시락 배달 왔습니다!</p>
                         </a>
                         </li>
                         <li>
                         <a href="http://health.chosun.com/site/data/html_dir/2013/04/29/2013042901374.html" target="new">
                         <img class="pressthumb" src="images/press_thumb03.jpg" width="137" height="65">
                         <h5>헬스조선 4월호</h5>
                         <p class="article">시간 없다면 주말 48시간 다이어트 하세요!</p>
                         </a>
                         </li>
                       </ul>
					</div>


				</div>
				<!-- End indexthird #4-3 -->
				<div class="clear">
				</div>
			</div>
			<!-- End one Cloumn #4-->
		</div>
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

<!-- <div id="1381802283472" class="jquery-lightbox-overlay" style="position: fixed; top: 0px; left: 0px; opacity: 0.6; display: block; z-index: 9998; height: 100%; width: 100%;"></div>
<div class="jquery-lightbox-move" style="position: absolute; z-index: 9999; top: 50%; overflow: visible; left: 50%; opacity: 1; display: block;margin-left:-332px; margin-top:-232px;">
<div class="jquery-lightbox jquery-lightbox-mode-html" style="width: 664px; height: 450px;">
<div class="jquery-lightbox-border-top-left"></div>
<div class="jquery-lightbox-border-top-middle"></div>
<div class="jquery-lightbox-border-top-right"></div>
<a class="jquery-lightbox-button-close" href="#close">
<span>Close</span>
</a>
<div class="jquery-lightbox-navigator" style="width: 650px; top: 235px;">
<a class="jquery-lightbox-button-left" href="#" style="display: none;">
<span>Previous</span>
</a>
<a class="jquery-lightbox-button-right" href="#" style="display: none;">
<span>Next</span>
</a>
</div>
<div class="jquery-lightbox-buttons" style="display: none;">
<div class="jquery-lightbox-buttons-init"></div>
<a class="jquery-lightbox-button-left" href="#" style="display: none;">
<span>Previous</span>
</a>
<a class="jquery-lightbox-hide" href="#">
<span>Maximize</span>
</a>
<div class="jquery-lightbox-buttons-custom"></div>
<a class="jquery-lightbox-button-right" href="#" style="display: none;">
<span>Next</span>
</a>
<div class="jquery-lightbox-buttons-end"></div>
</div>
<div class="jquery-lightbox-background" style="width: 650px; height: 470px;"></div>
<div class="jquery-lightbox-html" style="height: 450px;">
<div>
<meta content="text/html; charset=euc-kr" http-equiv="Content-Type">
<title>나에게 맞는 잇슬림</title>
<iframe scrolling="no" src="/shop/popup/myMatching_step1.jsp" style="width:100%; height:450px;"></iframe>
</div>
</div>
<div class="jquery-lightbox-border-bottom-left"></div>
<div class="jquery-lightbox-border-bottom-middle"></div>
<div class="jquery-lightbox-border-bottom-right"></div>
</div>
</div> -->

</body>
</html>

<script>
	$(document).ready(function(){
		$("#myMatching_a").trigger("click");
	});
</script>