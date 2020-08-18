<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				택배배달
			</h1>
			<div class="pageDepth">
				HOME > 배달안내 > <strong>택배배달</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
			    <div class="one last  col">
				     <div><img src="/images/delivery_top01.jpg" width="999" height="282" alt="택배배달"></div>
				</div>
			</div>
			<!-- End Row -->
            <div class="divider"></div>
			<div class="row">
			    <div class="one last  col">
				   <div class="sectionHeader">
                     <h3>택배시스템</h3>
                     <div class="clear"></div>
				   </div>
                     <ul class="freparstep">
                       <li><img src="/images/parstep_01.png" width="142" height="142"><p>주문접수</p></li>
                       <li class="darow"><img src="/images/parstep_arrow.png" width="94" height="58"></li>
                       <li><img src="/images/parstep_02.png" width="142" height="142"><p>물류센터 출고</p></li>
                       <li class="darow"><img src="/images/parstep_arrow.png" width="94" height="58"></li>
                       <li><img src="/images/parstep_03.png" width="142" height="142"><p>택배발송<br /><span>*롯데택배 집하</span></p></li>
                       <li class="darow"><img src="/images/parstep_arrow.png" width="94" height="58"></li>
                       <li><img src="/images/delistep_03.png" width="144" height="144"><p>고객님 가정</p></li>
                     <div class="clear"></div>
                     </ul>
				</div>
			</div>
			<!-- End Row -->
            <div class="divider"></div>
            <div class="row">
			    <div class="one last  col">
				     <div class="sectionHeader">
                       <h3>주문 마감시간 및 배달일정</h3>
                       <div class="clear"></div>
                     </div>  
                     <div>
                     <div class="orderdeli">
                       <h4>일반적인 경우</h4>
                       <div class="wbox">
                          <h5>01. 주문</h5>
                          <p>주문일(D-day) 24시 주문접수 종료</p>
                          <span class="arrowdown"></span>
                          <h5>02. 상품출고 및 집하</h5>
                          <p>D+1일 롯데택배에서 집하</p>
                          <span class="arrowdown"></span>
                          <h5>03. 배달 및 고객수령</h5>
                          <p><span class="font-maple">D+2</span>일부터 배달시작</p>
                       </div>
                     </div>
                     <div class="orderdeli">
                       <h4>주문 다음날이 일요일/공휴일인 경우</h4>
                       <div class="wbox">
                          <h5>01. 주문</h5>
                          <p>주문일(D-day) 24시 주문접수 종료</p>
                          <span class="arrowdown"></span>
                          <h5>02. 상품출고 및 집하</h5>
                          <p>D+2일 롯데택배에서 집하</p>
                          <span class="arrowdown"></span>
                          <h5>03. 배달 및 고객수령</h5>
                          <p><span class="font-maple">D+3</span>일부터 배달시작</p>
                       </div>
                     </div>
                     <div class="orderdeli" style="margin-right:0;">
                       <h4>도서산간 지역의 경우</h4>
                       <div class="wbox">
                          <h5>01. 주문</h5>
                          <p>주문일(D-day) 24시 주문접수 종료</p>
                          <span class="arrowdown"></span>
                          <h5>02. 상품출고 및 집하</h5>
                          <p>D+2일 롯데택배에서 집하<br /> --> D+3일 중간물류 이동</p>
                          <span class="arrowdown"></span>
                          <h5>03. 배달 및 고객수령</h5>
                          <p><span class="font-maple">D+4</span>일부터 배달시작</p>
                       </div>
                     </div>
                     <div class="clear"></div>
                     </div>
                     <div class="divider"></div>
                     <ul class="dot">
                       <li>주문 다음날이 일요일이나 공휴일인 경우와 도서산간 지역일 경우가 겹칠 경우 4일 이상 소요될 수 있습니다.</li>
                       <li>이외에 배달 및 취소,교환,환불 내용에 대하여 궁금한 점이 있으시면 고객센터 > 이용안내를 확인해 보세요.</li>
                     </ul>
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
<script type="text/javascript">
$(document).ready(function(){
	$(".boardStyle div.post-view").hide();
	$(".boardStyle a").click(function(){
		$(".boardStyle div.post-view").slideUp(200);
		$(this).next("div.post-view").slideToggle(200);	
	})	
})
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>