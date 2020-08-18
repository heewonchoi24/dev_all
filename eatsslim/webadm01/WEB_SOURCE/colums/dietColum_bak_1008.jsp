<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<script type="text/javascript">  
$(document).ready(function(){
    var $container = $('.fluidbox');

    var gutter = 12;
    var min_width = 240;
    $container.imagesLoaded( function(){
        $container.masonry({
            itemSelector : '.box',
            gutterWidth: gutter,
            isAnimated: true,
              columnWidth: function( containerWidth ) {
                var box_width = (((containerWidth - 3*gutter)/4) | 0) ;

                if (box_width < min_width) {
                    box_width = (((containerWidth - gutter)/2) | 0);
                }

                if (box_width < min_width) {
                    box_width = containerWidth;
                }

                $('.box').width(box_width);

                return box_width;
              }
        });
    });
});
 
</script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				다이어트 칼럼
			</h1>
			<div class="pageDepth">
				HOME > GO! 다이어트 > <strong>다이어트 칼럼</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
                <div class="one last  col">
                    <div class="graytitbox">
                        <ul class="filter floatleft" style="margin-top:5px;">
                            <li class="current"><a href="#">ALL(153)</a></li>
                            <li><a href="#">다이어트 식사(53)</a></li>
                            <li><a href="#">다이어트 프로그램(23)</a></li>
                            <li><a href="#">다이어트 기능식(42)</a></li>
                        </ul>
                        <div class="searchBar floatright">
							<label>
								<select name="select" id="select" style="width:70px;">
									<option>제목</option>
									<option>내용</option>
								</select>
							</label>
							<label>
							<input type="text" name="textfield" id="textfield">
							</label>
							<label>
							<input type="submit" class="button dark small" name="button" value="검색">
							</label>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <!-- End Row -->
            <div class="row">
			    <div class="one last  col">
				   <div class="fluidbox">
				      <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="잇슬림컬럼" class="thumbnail" src="/images/Jaipur-1.jpg">
                              </a>
                              <p class="cate">[생활습관]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>헬스트렌드 폴댄스</h4>
                              <p>얼마전 인기걸그룹 "에프터스쿨"이 선보인 안무가 화제입니다.
                              별도의 장치 없이 맨몸으로 기둥에 매달려 묘기에 가까운 퍼포먼스를 선보였기 
                              때문인데요. 안무로 한층 탄탄해진 멤버들의 몸매도 시선을 잡았습니다.</p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="잇슬림컬럼" class="thumbnail" src="/images/Jaipur-2.jpg">
                              </a>
                              <p class="cate">[다이어트 속설과 과학]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>먼 길 다녀온 당신, 건강부터 챙겨라!</h4>
                              <p>오매불망 기다려온 꿀같은 여름휴가! 도심을 떠나 계곡으로, 바다로 향해 달려보지만
                              쉬려고 떠난 여행에서 오히려 병을 얻어올 수 있다는 사실!
                              오랜시간 같은 자세로 앉아 있거나 장거리 운전으로 인해 당신의 관절들이 외치는 비명에 귀기울여보자!</p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="잇슬림컬럼" class="thumbnail" src="/images/Jaipur-3.jpg">
                              </a>
                              <p class="cate">[생활습관]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>달콤달콤 셀프 아이스바</h4>
                              <p>이렇게 쉬웠어? 집에서 쉽게 즐기는 셀프 아이스바 만들기. </p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="잇슬림컬럼" class="thumbnail" src="/images/Jaipur-4.jpg">
                              </a>
                              <p class="cate">[생활습관]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>더위를 극복하는 천연음식</h4>
                              <p>"몸보신 좀 해야지" 라는 말이 절로 나올 만큼 삼복더위의 한 가운데서 쉽게 지치는 요즘.
                              인공적인 영양제 못지않게 여름철 우리 건강을 지켜줄 천연음식을 알아보자. </p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="잇슬림컬럼" class="thumbnail" src="/images/Jaipur-5.jpg">
                              </a>
                              <p class="cate">[다이어트 먹거리]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>맛있는 음식과 함께하니 즐겁지 아니한가 소셜...</h4>
                              <p>서셜 다이닝은 식사를 매개로 모르는 사람과도 친교를 맺는 기회를 뜻한다. 
                              함께 밥을 먹으며 공통 관심사에 대해 이야기를 나누는 "소셜 다이닝 (Social Dining)"이 뜨는 것도 바로 그런 이유다. </p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="잇슬림컬럼" class="thumbnail" src="/images/Jaipur-6.jpg">
                              </a>
                              <p class="cate">[다이어트 먹거리]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>한여름에 만나는 눈꽃빙수 <스노우 마운틴></h4>
                              <p>LOW 칼로리, LOW 유지방, NO 방부제, NO 인공색소로 건강에 좋지 않은것들은 빼고 유기농 인증을 받은
                              제품들로 건강뿐만 아니라 환경까지 생각하는 스노우 마운틴의 달콤한 디저트를 즐겨보자. </p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>	
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="잇슬림컬럼" class="thumbnail" src="/images/Jaipur-7.jpg">
                              </a>
                              <p class="cate">[생활습관]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>웰빙+피트니스=성공과 행복을 위해 운동하라</h4>
                              <p>"몸보신 좀 해야지" 라는 말이 절로 나올 만큼 삼복더위의 한 가운데서 쉽게 지치는 요즘.
                              인공적인 영양제 못지않게 여름철 우리 건강을 지켜줄 천연음식을 알아보자. </p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>	
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="잇슬림컬럼" class="thumbnail" src="/images/Jaipur-8.jpg">
                              </a>
                              <p class="cate">[생활습관]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>우리 몸을 살리는 마크로비오틱 원칙</h4>
                              <p>커다란 호응 속에 지난달에 이어 열린 마크로비오틱 강좌. 건강한 요리로 가족건강을
                              지키겠다는 열정이 있었던 쿠킹클래스 현장을 찾아보았다.</p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>											
				   </div>
                   <!-- End Fluidbox -->
                   <div class="readmore">
                       <button id="">Read More...</button>
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
	</div> <!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
<script src="/common/js/jquery.masonry.min.js"></script>
</body>
</html>