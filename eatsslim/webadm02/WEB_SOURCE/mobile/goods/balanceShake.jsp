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
                 <td><a href="/mobile/goods/minimeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text" style="padding:9px 0px;">�����</span></span></a></td>
                 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">�뷱��<br />����ũ</span></span><span class="active"></span></a></td>
               </tr>
           </table>
           </div>
           <div class="divider"></div>
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