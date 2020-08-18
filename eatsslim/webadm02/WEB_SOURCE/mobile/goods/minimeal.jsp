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
    <div id="content" class="esMinimeal" style="margin-top:135px;">
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
						<span><a class="here" href="/mobile/goods/minimeal.jsp">�ս��� �̴Ϲ�</a></span>
						<span><a href="/mobile/goods/secretSoup.jsp">��ũ������</a></span>
					</td>
			   </tr>
           </table>
           </div>
           <div class="divider"></div>
           <div class="row">
               <div class="goods ssoup">
                   <div class="top-wrap">
                        <span class="goods-copy bg-brown">
                            �Ѽտ� ��, �����ϰ� ���� �̴��Ź�
                        </span>
                        <p class="goods-caption">Į�θ� �������� ������� �����,<br /><strong>�ս��� �̴Ϲ�</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/esMinimeal01.png" width="235" height="160" alt="�ս��� ���̽�"></div>
                   <h2 class="font-wbrown">Simple! �̴��� Ÿ������ �Ѽ����� �����ϰ�</h2>
                   <p>���� ��𼭳� �����ϰ� �ѳ� �ذ�! ���̾���, �ٻ� ������ �� �����ε��� �ǰ��� �� ���� ���� Mini- Cup Ÿ������ �Ѽտ� ���, �����ϰ� �����ϴ� One-dish meal</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">Healthy! ���۰, Ǫ��� �ǰ��� ���̾�Ʈ��</h2>
                   <p>���۰ ����ƿ� �͸��� ����� ���, �ڼ�������, ���� �� ��� �޴��� �ǰ� ����� ����� ������ �ǰ�����! ����Ǫ�� ���� �� ���, �κ� �� ���̾�Ʈ�� ������ �ִ� ��Ḧ ���!</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">Tasty! ���̾�Ʈ�߿��� ���ְ� ����!</h2>
                   <p>200kcal���� �������� �ִ� ����� �������� ����ϰ� ���ְ� ��� �� �ִ� �ս��� �̴Ϲ�! ���̼����� ǳ���� �������� ���ϴ� ����, �͸�, ���� ����  ���� ����� ���!</p>
                   <div class="divider"></div>
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