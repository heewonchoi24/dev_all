<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <!-- <ul class="subnavi">
                   <li class="current"><a href="/mobile/goods/cuisine.jsp">��ǰ�Ұ�</a></li>
            <li><a href="/mobile/intro/schedule.jsp">�̴��� �Ĵ�</a></li>
                   <li><a href="/mobile/customer/service.jsp">�ֹ��ȳ�</a></li>
                </ul> -->
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content" class="oldClass">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ�Ұ�</span></span></h1>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
			     <td><a href="/mobile/goods/healthyCuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�ﾾ����</span></span></a></td>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">����</span></span><span class="active"></span></a></td>
                 <td><a href="/mobile/goods/alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�˶���</span></span></a></td>
				</tr>
				<tr>
                 <td><a href="/mobile/goods/minimeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�̴Ϲ�</span></span></a></td>
				 <td><a href="/mobile/goods/secretSoup.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">��ũ������</span></span></a></td>
				 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�뷱������ũ</span></span></a></td>
			   </tr>
           </table>
           </div>

           <div class="row">
               <div class="goods cuisine">
                   <div class="top-wrap">
                        <span class="goods-copy bg-brown">
                            �����ִ� ���缳��� �پ��� �޴��� �⺻
                        </span>
                        <p class="goods-caption">��Ʈ��Down & Į�θ�Down����<br />�����ε� ���ִ� �Ļ�, <strong>����</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/goods_img01.png" width="235" height="160" alt="����"></div>
                   <h2 class="font-wbrown">�������� ���缳��</h2>
                   <p>GI/GL�� ������ ���̾�Ʈ �Ļ翡 �����Ͽ�, ź��ȭ�� Ư���� ���� ������ ü�� ������� ����ϰ�, �׿� ���� ������ �Ĵ��� ����</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">������ ����µ� ����</h2>
                   <p>��� �� ���� ��޹ޱ���� ���� 0~10��C�� ������ �� �ֵ��� Ǯ���� �ؽż���۽ý������� ���������µ� ���� �� ������Ű�� ����</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">���� ������ �Ļ�</h2>
                   <p>�Ļ��غ� �ʿ���� ����(�繫��)���� ����⸸ �ϸ� OK! ��� 367Kcal�� ���̾�Ʈ ���� �Ĵ�</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">��Ʈ������ ����</h2>
                   <p>���̼����� �ܹ����� ǳ���� �Ļ籸���� �����ϸ�, ���� 2,000mg��Ʈ�������� �����Ͽ� ����</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">ȣ����� �������� ��ġ�� ���� ��ǥ�丮</h2>
                   <p>���� ������ ��ǥ�丮�� ȣ�� ��� �ս��� �������� ���� ���� �������� ���̾�Ʈ������ ��ź�� </p>
               </div>
           </div>


  		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/popup/dietmeal_info.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
					<td><a href="/mobile/shop/dietMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�Ļ� ���̾�Ʈ �����ϱ�</span></span></a></td>
				</tr>
			</table>
		</div>
  </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>