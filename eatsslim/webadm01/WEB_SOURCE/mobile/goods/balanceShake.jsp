<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content" class="oldClass">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ�Ұ�</span></span></h1>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
				 <td><a href="/mobile/goods/healthyCuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�ﾾ����</span></span></a></td>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">����</span></span></a></td>
                 <td><a href="/mobile/goods/alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�˶���</span></span></a></td>
				</tr>
				<tr>
                 <td><a href="/mobile/goods/minimeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�̴Ϲ�</span></span></a></td>
				 <td><a href="/mobile/goods/secretSoup.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">��ũ������</span></span></a></td>
				 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">�뷱������ũ</span></span><span class="active"></span></a></td>
			   </tr>
           </table>
           </div>

           <div class="row">
               <div class="goods balshake">
                   <div class="top-wrap">
                        <span class="goods-copy bg-brown">
                            ����ѡ�������������������Ρ��ô¡���ſ����
                        </span>
                        <p class="goods-caption">Į�θ��� ���߰� ������ ä��<br /><strong>�ս��� �뷱�� ����ũ</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/goods_img04.png" width="235" height="160" alt="��ũ������"></div>
                   <h2 class="font-wbrown">����ϰ� ���ִ�!</h2>
                   <p>7������� ������������ ����� ���� �ô� ������ ���� ���ִ� ���̾�Ʈ ����!</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">Į�θ��� ���߰� ������ ä����!</h2>
                   <p>Į�θ��� ���߰�, ������ ä�� �ǰ��ϰ� ���̾�Ʈ�� �� �� �ֵ��� ����� ü�������� ��ǰ</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">���̼����� ������� Plus!</h2>
                   <p>���̼���(1���� 5.5g�� ����)�� ��ǰ��� ���� �����(PMO 08)�� �Բ�!</p>
                   <div class="divider"></div>
                   <p><img width="100%" src="../images/eatsslim_goods04.jpg"></p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">���뷮 �� ������</h2>
                   <h3>���뷮 �� ���</h3>
                   <ul class="dot">
                      <li>�� �� �Ļ� ��ü �� 1��(35g)�� ��������� 200ml�� �ְ� �� ���� ���� �� õõ�� �þ ��ʽÿ�.</li>
                      <li>��ȣ�� ���� ������ ���� ������ �� �ֽ��ϴ�.</li>
                      <li>���뷮�� ���� �������� ǥ�õǾ� ������, �������� �����̳� ��ü ���¿� ���� ��ǰ���뷮 ������ �����մϴ�. </li>
					  <li>�����ôϾ�į�����ƿ� ī��Ų ������ �ҷ� �����Ǿ� �־� �ӻ�γ� ������ �������Դ� �������� �ʽ��ϴ�. </li>
                   </ul>
                   <div class="divider"></div>
                   <h3>���� �� ���ǻ���</h3>
                   <ul class="dot">
                      <li>�������� ��ü ���¿� ���� ������ ���̰� ���� �� �ֽ��ϴ�.</li>
                      <li>�˷����� ü���̽� ��� ������ Ȯ���Ͻ� �� �����Ͽ� �ֽñ� �ٶ��ϴ�.</li>
                   </ul>

               </div>
           </div>
			                <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/popup/balshake_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
                 <td><a href="/mobile/shop/balanceShake-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�뷱������ũ ����</span></span></a></td>
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