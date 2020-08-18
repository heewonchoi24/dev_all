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
          <div class="matchfood"> <img class="thumbleft" src="/images/result_reductionProgram.jpg" width="130" height="80"> <span class="post-title">
            <h4>2주 감량프로그램</h4>
            <p>감량을 체계적으로 원하는 고객을 위하여 밸런스쉐이크/다이어트수프/식사다이어트로 스케줄링 되어 제공되는 감량 맞춤형 식사 프로그램입니다.</p>
            </span> </div>
          <div class="clear"></div>
        </div>
      </div>
      <!-- End row -->
      <div class="row">
        <div class="one last col center">
          <div class="floatleft">
            <div class="button large darkgreen"><a href="javascript:frameMove('/shop/weight2weeks.jsp')">제품 상세보기 ></a></div>
            <div class="button large darkbrown"><a href="javascript:frameMove('/shop/weight2weeks.jsp')">제품 구매하기 ></a></div>
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
