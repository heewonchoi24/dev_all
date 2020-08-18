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
				�ù���
			</h1>
			<div class="pageDepth">
				HOME > ��޾ȳ� > <strong>�ù���</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
			    <div class="one last  col">
				     <div><img src="/images/delivery_top01.jpg" width="999" height="282" alt="�ù���"></div>
				</div>
			</div>
			<!-- End Row -->
            <div class="divider"></div>
			<div class="row">
			    <div class="one last  col">
				   <div class="sectionHeader">
                     <h3>�ù�ý���</h3>
                     <div class="clear"></div>
				   </div>
                     <ul class="freparstep">
                       <li><img src="/images/parstep_01.png" width="142" height="142"><p>�ֹ�����</p></li>
                       <li class="darow"><img src="/images/parstep_arrow.png" width="94" height="58"></li>
                       <li><img src="/images/parstep_02.png" width="142" height="142"><p>�������� ���</p></li>
                       <li class="darow"><img src="/images/parstep_arrow.png" width="94" height="58"></li>
                       <li><img src="/images/parstep_03.png" width="142" height="142"><p>�ù�߼�<br /><span>*�Ե��ù� ����</span></p></li>
                       <li class="darow"><img src="/images/parstep_arrow.png" width="94" height="58"></li>
                       <li><img src="/images/delistep_03.png" width="144" height="144"><p>���� ����</p></li>
                     <div class="clear"></div>
                     </ul>
				</div>
			</div>
			<!-- End Row -->
            <div class="divider"></div>
            <div class="row">
			    <div class="one last  col">
				     <div class="sectionHeader">
                       <h3>�ֹ� �����ð� �� �������</h3>
                       <div class="clear"></div>
                     </div>  
                     <div>
                     <div class="orderdeli">
                       <h4>�Ϲ����� ���</h4>
                       <div class="wbox">
                          <h5>01. �ֹ�</h5>
                          <p>�ֹ���(D-day) 24�� �ֹ����� ����</p>
                          <span class="arrowdown"></span>
                          <h5>02. ��ǰ��� �� ����</h5>
                          <p>D+1�� �Ե��ù迡�� ����</p>
                          <span class="arrowdown"></span>
                          <h5>03. ��� �� ������</h5>
                          <p><span class="font-maple">D+2</span>�Ϻ��� ��޽���</p>
                       </div>
                     </div>
                     <div class="orderdeli">
                       <h4>�ֹ� �������� �Ͽ���/�������� ���</h4>
                       <div class="wbox">
                          <h5>01. �ֹ�</h5>
                          <p>�ֹ���(D-day) 24�� �ֹ����� ����</p>
                          <span class="arrowdown"></span>
                          <h5>02. ��ǰ��� �� ����</h5>
                          <p>D+2�� �Ե��ù迡�� ����</p>
                          <span class="arrowdown"></span>
                          <h5>03. ��� �� ������</h5>
                          <p><span class="font-maple">D+3</span>�Ϻ��� ��޽���</p>
                       </div>
                     </div>
                     <div class="orderdeli" style="margin-right:0;">
                       <h4>�����갣 ������ ���</h4>
                       <div class="wbox">
                          <h5>01. �ֹ�</h5>
                          <p>�ֹ���(D-day) 24�� �ֹ����� ����</p>
                          <span class="arrowdown"></span>
                          <h5>02. ��ǰ��� �� ����</h5>
                          <p>D+2�� �Ե��ù迡�� ����<br /> --> D+3�� �߰����� �̵�</p>
                          <span class="arrowdown"></span>
                          <h5>03. ��� �� ������</h5>
                          <p><span class="font-maple">D+4</span>�Ϻ��� ��޽���</p>
                       </div>
                     </div>
                     <div class="clear"></div>
                     </div>
                     <div class="divider"></div>
                     <ul class="dot">
                       <li>�ֹ� �������� �Ͽ����̳� �������� ���� �����갣 ������ ��찡 ��ĥ ��� 4�� �̻� �ҿ�� �� �ֽ��ϴ�.</li>
                       <li>�̿ܿ� ��� �� ���,��ȯ,ȯ�� ���뿡 ���Ͽ� �ñ��� ���� �����ø� ������ > �̿�ȳ��� Ȯ���� ������.</li>
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