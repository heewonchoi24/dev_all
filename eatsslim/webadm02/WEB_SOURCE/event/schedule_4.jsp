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
				최과장&이대리 다이어트 식단
			</h1>
			<div class="pageDepth">
				HOME > 이벤트 > <strong>최과장&이대리 다이어트 식단</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
			    <div class="one last  col">
				     <div><a href="/event/schedule_1.jsp" target="_self"><img src="/images/schedule_bt_1off.gif" width="120" height="35" alt="1"></a><a href="/event/schedule_2.jsp" target="_self"><img src="/images/schedule_bt_2off.gif" width="120" height="35" alt="2"></a><a href="/event/schedule_3.jsp" target="_self"><img src="/images/schedule_bt_3off.gif" width="120" height="35" alt="3"></a><a href="/event/schedule_4.jsp" target="_self"><img src="/images/schedule_bt_4on.gif" width="120" height="35" alt="4"></a><a href="/event/schedule_5.jsp" target="_self"><img src="/images/schedule_bt_5off.gif" width="120" height="35" alt="4"></a><a href="/event/schedule_6.jsp" target="_self"><img src="/images/schedule_bt_6off.gif" width="120" height="35" alt="4"></a><a href="/event/schedule_7.jsp" target="_self"><img src="/images/schedule_bt_7off.gif" width="120" height="35" alt="4"></a></div>
				     <div><img src="/images/schedule_4.jpg" width="999" height="1625" alt="최과장&이대리 식단 스케쥴"></div>
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