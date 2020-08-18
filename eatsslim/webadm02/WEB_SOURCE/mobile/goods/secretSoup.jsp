<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <ul class="subnavi">
			<li><a href="/mobile/customer/service.jsp">�ֹ��ȳ�</a></li>
			<li class="current"><a href="/mobile/goods/cuisine.jsp">��ǰ�Ұ�</a></li>
            <li><a href="/mobile/intro/schedule.jsp">�̴��� �Ĵ�</a></li>
		</ul>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content" style="margin-top:135px;">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ�Ұ�</span></span></h1>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">����<br />��ǰ</span></span></a></td>
                 <td><a href="/mobile/goods/alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�˶�<br />���</span></span><span class="active"></span></a></td>
                 <td>
					<a href="/mobile/goods/minimeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-f">
						<span class="ui-btn-inner">
							<span class="ui-btn-text" style="padding:9px 0px;">�����</span></span><span class="active">
						</span>
					</a>
				 </td>
                 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�뷱��<br />����ũ</span></span></a></td>
               </tr>
			   <tr class="easyMeal">
					<td colspan="4">
						<span><a href="/mobile/goods/minimeal.jsp">�ս��� �̴Ϲ�</a></span>
						<span><a class="here" href="/mobile/goods/secretSoup">��ũ������</a></span>
					</td>
			   </tr>
           </table>
           </div>
           <div class="divider"></div>
           <div class="row">
               <div class="goods ssoup">
                   <div class="top-wrap">
                        <span class="goods-copy bg-brown">
                            Ȩ���̵�Ÿ�ԡ����̾�Ʈ����
                        </span>
                        <p class="goods-caption">6���� ä���� ���������,<br /><strong>�ս��� ��ũ������(HOT)</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/goods_img03_01.png" width="235" height="160" alt="��ũ������"></div>
                   <h2 class="font-wbrown">Į�θ� Down</h2>
                   <p>ź��ȭ���� Ư���� ����� ����Ḧ �������� ������ ������� ü������ ����Ǵ� ������ ���ߵ��� ����.</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">��ſ� ���̾�Ʈ</h2>
                   <p>�丶�� �Ľ�Ÿ, ����, �̿��� �������� ������ ���� ��ſ� ���̾�Ʈ</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">������� ������</h2>
                   <p>6���� ������� ���� Ȩ���̵�Ÿ�� ���̾�Ʈ �����Դϴ�. ������ ���� ������ ǳ���� �����(��)�� ����, ���, �߰�����, ����Ʈ����� ������ �ս������� ��� ������!</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">Beauty&Balance</h2>
                   <p>�峻 �躯Ȱ���� ��Ȱ�ϰ� �����ִ� ���̼����� ��Ƽ������ �ݶ���� �־� ���̾�Ʈ �Ⱓ�� �����ϱ� ���� �뷱�� ����</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">�����ϰ� ������ ���� Ȩ���̵� Ÿ�� ���̾�Ʈ ����</h2>
                   <div class="divider"></div>
                   <p><img width="100%" src="/mobile/images/eatsslim_goods03.jpg"></p>
                   <div class="divider"></div>
                   <h3 class="font-wbrown">��ũ������ ������</h3>
                   <p><img width="100%" src="/mobile/images/eatsslim_goods03_01_01.jpg"></p>
               </div>
           </div>
  </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>