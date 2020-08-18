<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed" style="overflow: hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
		<ul class="subnavi">
			<li><a href="/mobile/shop/dietMeal.jsp">�Ļ���̾�Ʈ</a></li>
			<li class="current"><a href="/mobile/shop/reductionProgram.jsp">���α׷����̾�Ʈ</a></li>
			<li><a href="/mobile/shop/secretSoup.jsp">Ÿ�Ժ����̾�Ʈ</a></li>
		</ul>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content" style="margin-top: 135px;">
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/popup/program_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
					<td><a href="/mobile/shop/dietProgram-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">���α׷����̾�Ʈ ����</span></span></a></td>
				</tr>
			</table>
		</div>
		<div class="grid-navi">
			<table class="navi" cellspacing="10" cellpadding="0">
				<tr>
					<!-- <td><a href="/mobile/shop/reductionProgram.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">����<br /> ���α׷�</span></span></a></td>
					<td><a href="/mobile/shop/keepProgram.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">����<br /> ���α׷�</span></span></a></td>-->
					<td><a href="/mobile/shop/fullStep.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner"><span class="ui-btn-text">New Full-Step ���α׷�</span></span><span class="active"></span></a></td>
				</tr>
			</table>
		</div>
		<div class="divider"></div>
		<div class="row">
			<div class="bg-gray font-brown">
				<p>�뷱������ũ/���̾�Ʈ����/�Ļ���̾�Ʈ�� �������� �����층 �Ǿ� ���� �������� �������� Full-Step���� ������ ���� �ս����� ��õ ���α׷�!</p>
				<div style="margin: 25px 0 10px 0;">
					<img src="/mobile/images/fullstepProgram01_new.png" width="100%" alt="" />
				</div>
			</div>
		</div>
		<div class="row">
			<h2 class="font-brown">01. ���α׷�</h2>
			<div style="margin: 5px auto 15px;">
				<img src="/mobile/images/fullstepProgram02_new.png" width="100%" style="margin-bottom: 10px" />
				<p class="f14">�غ�� 1��, ü�� ���ұ� 2��, ������ 1�� �� 4�� ���α׷����� �غ�⸦ ���� �ް��� �Ļ������� �ƴ� �غ�� �Ļ������� �����Ͽ� 2�ְ� ü�� ���ұ⸦ ���� ���߰����� �����ϸ� ������ �����⸦ ���� ��������� �����ݴϴ�.</p>
			</div>
			<h3>4�� ���α׷�</h3>
			<p class="f14">�غ�� 1��, ü�� ���ұ�2��, ������ 1�� �� 4�� ���α׷����� ���������� ü�� ���� �� �ϻ������ ������ �����ϰ� ���� �� �ֵ��� ������ ��ǰ�Դϴ�.</p>
			<div class="divider"></div>
			<h2 class="font-brown">02. ü������ �Ļ� ������</h2>
			<div style="margin: 5px auto;">
				<img src="/mobile/images/fullstepProgram03_new.png" width="100%" />
			</div>
			<p class="f12">- ��~�� �������Դϴ�. �ָ�(��,��)�� ���Ͽ� ���ս����뷱������ũ���� �Բ� �̿��ϼ���.</p>
			<div class="divider"></div>
			<h2 class="font-brown">03. ���ִ� ���̾�Ʈ</h2>
			<ul class="dot">
				<li class="f14">�ѽ�/���/�Ͻ�/�߽�ȣ����� ���� ������</li>
				<li class="f14">����� �ε巴�� ���� �����Ǵ� ����� �������� ������ ����</li>
				<li class="f14">õ�� ���� �� ���а� �ҽ��� ��ȭ�� ����</li>
			</ul>
			<div class="divider"></div>
			<h2 class="font-brown">04. �������� ���缳��</h2>
			<p class="f18 font-blue mart10">
				<strong>Low GL diet point !</strong>
			</p>
			<p class="f16">
				<strong>1�� ���� ������ ź��ȭ�� ����</strong>
			</p>
			<p class="f14">�ܹ����� ���мս� �� ����ұ����� �ּ�ȭ �մϴ�.</p>
			<div class="divider"></div>
			<p class="f16">
				<strong>Low GI (�� ����)�� ����� ��� ���� �� ���� ���� ����</strong>
			</p>
			<p class="f14">ź��ȭ���� ���� ü�� ����ӵ��� �����ϱ� ���Ͽ� ����� ������ �����ϰ�, ��ü ź��ȭ�� ���޿� �� Ǯ�������ؿ� ���� Low GI�� �з��Ǵ� ź��ȭ�� �޿� ������ �����մϴ�.</p>
			<div class="divider"></div>
			<p class="f16">
				<strong>Low GL (����� ����)�� ����� ź��ȭ�� �Է� ����</strong>
			</p>
			<p class="f14">�ٸ� ź��ȭ���� ����/���� �������� ��ǰ�� 1ȸ ����� GL������ �����Ͽ� ��ü �Ĵ��� �����մϴ�.</p>
			<div class="divider"></div>
			<h2 class="font-brown">05. �ٸ����� ö���� ��������</h2>
			<img class="floatleft" src="/mobile/images/reductionProgram05.png" width="113" height="37" style="margin-right: 10px;" />
			<p class="f14" style="display: inline-block; width: 55%;">Ǯ���� ��ǰ�������͸� ���� ���� ������ �˻� �� ����ǰ ������ ��Ʈ��</p>
			<div class="divider"></div>
			<img class="floatleft" src="/mobile/images/reductionProgram06.png" width="113" height="37" style="margin-right: 10px;" />
			<p class="f14">��Ʈ��Űģ�� ���� ǰ���� ǥ��ȭ �� ����ȭ</p>
			<div class="divider"></div>
			<h2 class="font-brown">06. ���� & ���</h2>
			<div style="margin: 5px auto;">
				<img src="/mobile/images/reductionProgram07.png" width="100%" />
			</div>
			<h3>�����ϰ� �ż��� ������</h3>
			<p class="f14">�ս��� ��ü �ؽż� ��۽ý������� ���Ǵ� �ĺ��� ������ ��޹޴� �������� ����0~10�ɷ� ������ �� �ֵ��� ���������µ� ���� �� ������Ű�� ���谡 �Ǿ��ֽ��ϴ�.</p>
			<div style="margin: 5px auto;">
				<img src="/mobile/images/reductionProgram08.png" width="100%">
			</div>
			<h3>��������! �Ϻ�����! �������!</h3>
			<p class="f14">���ڷ������� ������ ���ع����� ������ �ʴ� ��⸦ ����մϴ�.</p>
			<div class="divider"></div>
			<h3>��ǰ����</h3>
			<p class="f14">�ս��� ��ü ��۽ý����� ���� ����� �̷������, �����պ�ġ, ���� ��Ź���� 2���� ��� �߿��� ������ ���ǿ� ���� �����Ͽ� ��۹����� �� �ֽ��ϴ�.</p>
		</div>
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/popup/program_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
					<td><a href="/mobile/shop/dietProgram-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">���α׷����̾�Ʈ ����</span></span></a></td>
				</tr>
			</table>
		</div>
	</div>
	<!-- End Content -->
	<div class="ui-footer">
		<div class="marb10">
			<%@ include file="/mobile/common/include/inc-footer.jsp"%>
		</div>
	</div>
</div>
</body>
</html>