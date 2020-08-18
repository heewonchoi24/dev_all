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
			<h1>�ս����� ó���̽ö��?</h1>
			<div class="pageDepth">
				HOME > <strong>ù ���� ���̵�</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one ">
			<div class="row">
				<h4 class="marb20"> �Ǻε�, ����, ������ �Ϻ��ϰ� �����ϴ� �������� ���� �ս����� <span class="font-blue">'�����ϰ� �����޴�'</span>�Ĵ�!<br/>
				�켱, Į�θ� ����, �ǰ������� ����, �Ǵ� �׳� �ѹ� �ս����� ã���ֽ� ������ ��� ��� �� �ȹ��� ȯ���մϴ�!<br/>
			    ���� ���� �� �տ��� ���۵Ǵ� ������ ������ �������� <span class="font-blue">'EatSlim'</span>�� ���������� ����� �帱�Կ�.</h4>
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