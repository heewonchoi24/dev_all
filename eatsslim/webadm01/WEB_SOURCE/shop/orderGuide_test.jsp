<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>잇슬림이 처음이시라면?</h1>
			<div class="pageDepth">
				HOME > <strong>첫 구매 가이드</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one ">
			<div class="row">
				<h4 class="marb20"> 피부도, 몸도, 마음도 완벽하게 관리하는 여려분을 위한 잇슬림의 <span class="font-blue">'세심하게 관리받는'</span>식단!<br/>
				우선, 칼로리 관리, 건강관리를 위해, 또는 그냥 한번 잇슬림을 찾아주신 여러분 모두 모두 두 팔벌려 환영합니다!<br/>
			    매일 새벽 집 앞에서 시작되는 세심한 관리로 여러분의 <span class="font-blue">'EatSlim'</span>을 성공적으로 만들어 드릴게요.</h4>
				<img class="" src="/images/firstvisit_02.jpg" width="1000" height="4806" />
			
		<!-- End sixteen columns offset-by-one -->
		</div>

		</div>
		<div class="clear"></div>
	
	</div>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
<script type="text/javascript">
$(document).ready(function() { 
	$('.ordertabs a').click(function(){
		switch_tabs($(this));
	});
 
	switch_tabs($('.defaulttab')); 
});
 
function switch_tabs(obj) {
	$('.tab-content').hide();
	$('.ordertabs a').removeClass("selected");
	var id = obj.attr("rel");
 
	$('#'+id).show();
	obj.addClass("selected");
}
</script>
</body>
</html>