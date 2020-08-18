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
			<h1>
				�ս��� ���̵�
			</h1>
			<div class="pageDepth">
				<span>HOME</span><span>�ս��� ���̵�</span><strong>�ֹ�����#2</strong>
			</div>
						<div class="clear">
			</div>
			<div class="eventList_tabmenu">
				<ul>
					<li><a href="/intro/checkLocation.jsp">����&�Ĵ�ã��</a></li>
					<li><a href="/intro/orderForm.jsp">�ֹ�&��������</a></li>
					<li><a href="/intro/changeOrder.jsp">�ֹ�����#1</a></li>
					<li class="active"><a href="/intro/changeOrderKakao.jsp">�ֹ�����#2</a></li>
				</ul>
			</div>
			<div class="clear">
			</div>
		</div>
		<img class="htopimg" src="/images/guideImg_04.jpg" width="100%">

		<div class="clear">
		</div>
	</div>
	<%@ include file="/common/include/inc-cart.jsp"%>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
</body>
</html>