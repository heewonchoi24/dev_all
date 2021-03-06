<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="myMatching_header.jsp"%>

<div class="pop-wrap">
  <%@ include file="myMatching_title.jsp"%>
  <div class="contentpop">
    <div class="popup columns offset-by-one">
      <div class="row">
        <div class="one last col">
          <h4 class="mart20 font-green">A. 고객님께 적합한 제품을 추천드립니다.</h4>
          <div class="divider"></div>
          <div class="matchfood"> <img class="thumbleft" src="/images/result_sample.jpg" width="130" height="80"> <span class="post-title">
            <h4>밸런스쉐이크 / <span class="meta">125kcal</span></h4>
            <p>칼로리는 Down! 영양은UP! 칼로리는 낮추고 영양은 채워 건강하게 다이어트를 할 수 있도록 설계된 체중 조절용 식품입니다.</p>
            </span> </div>
          <div class="clear"></div>
        </div>
      </div>
      <!-- End row -->
      <div class="row">
        <div class="one last col center">
          <div class="floatleft">
            <div class="button large darkgreen"><a href="javascript:frameMove('/goods/balanceShake.jsp')">제품 상세보기 ></a></div>
            <div class="button large darkbrown"><a href="javascript:frameMove('/shop/balanceShake.jsp')">제품 구매하기 ></a></div>
          </div>
          <div class="floatright">
            <div class="button large gray"><a href="myMatching_step1.jsp">다시하기 ></a></div>
          </div>
        </div>
      </div>
      <!-- End row --> 
      
    </div>
    <!-- End popup columns offset-by-one --> 
    
  </div>
  <!-- End contentpop --> 
  
</div>
<%@ include file="myMatching_footer.jsp"%>
