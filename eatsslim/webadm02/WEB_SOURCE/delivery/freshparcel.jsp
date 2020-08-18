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
				극신선 일일배달
			</h1>
			<div class="pageDepth">
				HOME > 배달안내 > <strong>극신선 일일배달</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
			    <div class="one last  col">
				     <div><img src="/images/delivery_top04.jpg" width="999" height="281" alt="극신선 일일배달"></div>
				</div>
			</div>
			<!-- End Row -->
            <div class="divider"></div>
			<div class="row">
			    <div class="one last  col">
				   <div class="sectionHeader">
                     <h3>일일배달 시스템</h3>
                     <div class="clear"></div>
				   </div>
                     <ul class="delistep">
                       <li><img src="/images/delistep_01.png" width="144" height="144"><p><strong class="font-blue">[제품생산]</strong><br/>풀무원 도안센터</p></li>
                       <li class="darow"><img src="/images/delistep_arrow.png" width="94" height="58"></li>
                       <li><img src="/images/delistep_02.png" width="144" height="144"><p><strong class="font-blue">[제품생산+1일]</strong><br/>전문 배달점</p></li>
                       <li class="darow"><img src="/images/delistep_arrow.png" width="94" height="58"></li>
                       <li><img src="/images/delistep_03.png" width="144" height="144"><p><strong class="font-blue">[제품생산+2일]</strong><br/>고객님 가정<br /><span>(밤10시~아침6시)</span></p></li>
                     <div class="clear"></div>
                     </ul>
                     
                     <div class="divider"></div>
                     <div class="delisystem">
                       <div class="floatleft">
                       <h3 class="marb10">풀무원 콜드체인 시스템</h3>
                       <p>고객님께서 주문하신 잇슬림은 풀무원의 안심온도<br />콜드체인시스템을 통하여 전문배달점으로 신선하게<br />이동됩니다.</p>
                       <p><strong class="font-blue">콜드체인 :</strong> 냉장에 의한 신선한 식료품의 유통방식</p>
                       <img src="/images/coldchainimg.jpg" width="123" height="105"> 
                       </div>
                       <div class="floatright">
                       <h3 class="marb10">냉장전용 보냉가방과 아이스팩</h3>
                       <p>잇슬림 배달에 사용되는 보냉가방과 아이스팩은<br /><strong class="font-blue">외부기온 30℃에서도 9시간 이상 5℃이하로</strong><br />유지되도록 설계되었습니다.<br />가방에서 제품만 꺼내어 안심하고 드세요.</p>
                       <p><strong class="font-blue">콜드체인 :</strong> 냉장에 의한 신선한 식료품의 유통방식</p>
                       <img src="/images/icepackimg.jpg" width="128" height="112"> 
                       </div>
                     <div class="clear"></div>
                     </div>
				</div>
			</div>
			<!-- End Row -->
            <div class="divider"></div>
            <div class="row">
			    <div class="one last  col">
                     <h3>주문 마감시간 및 일일배달일정</h3>
                     <p>일일배달의 경우 식재료 구매부터 배달까지 6일이 소요되며 주문일 기준 6일 후부터 첫 배달일 선택이 가능합니다.<br />
                     선택한 첫 배달일에 잇슬림 제품이 배달됩니다.</p>
                     <div class="divider"></div>
                     <h3>배달 시간</h3>
                     <p>22시부터 6시 사이에 이루어 집니다.<br />악천 후,교통상황,배달물량의 급격한 증가,고객님의 요청 등의 상황에 따라 정해진 배달 시간에서 1시간 정도 조기,연장 배달될 수 있습니다. </p>
                     <div class="divider"></div>
                     <h3>수령방법</h3>
                     <p>잇슬림 자체 배달시스템을 통해 배달이 이루어지며, 현관 앞 비치, 경비실 위탁수령 2가지 방법 중에서 고객님의 편의에 따라 선택하여 배송을 받으실 수 있습니다.<br />
                     주문하실 때 공동 현관 출입문 비밀번호를 기재해주시고, 카드키 출입일 경우 출입 방법,부재 시 수령관련 연락처 등을 배달 메시지에 남겨주시면 좀 더 정확하고 안전한 배달이 가능합니다.</p>
                     <div class="divider"></div>
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