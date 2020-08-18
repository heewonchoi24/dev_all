<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
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
    <div id="content">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ�Ұ�</span></span></h1>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">����<br />��ǰ</span></span><span class="active"></span></a></td>
                 <td><a href="/mobile/goods/alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�˶�<br />���</span></span></a></td>
                 <td><a href="/mobile/goods/secretSoup.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">��ũ��<br />����</span></span></a></td>
                 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�뷱��<br />����ũ</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="divider"></div>
           <div class="row">
               <div class="goods cuisine">
                   <div class="top-wrap">
                        <p class="goods-copy">
                            �����ִ� ���缳��� �پ��� �޴��� �⺻
                        </p>
                        <p class="goods-caption">��Ʈ��Down & Į����Down���� �����ε� ���ִ� �Ļ�, <strong>����</strong></p>
                   </div>
                   <div style="margin:5px auto;"><img src="/images/goods_img01.png" width="235" height="160" alt="����"></div>
                   <h2>�������� ���缳��</h2>
                   <p>GI/GL�� ������ ���̾�Ʈ �Ļ翡 ���� �Ͽ�, ź��ȭ�� Ư���� ���� ������ ü�� ������� ����ϰ�, �׿� ���� ������ �Ĵ��� ����</p>
                   <div class="divider"></div>
                   <h2>������ ����µ� ����</h2>
                   <p>��� �� ���� ��޹ޱ���� ���� 0~10��C�� ������ �� �ֵ��� Ǯ���� �ؽż� ��� �ý������� ���������µ� ���� �� ������Ű�� ����</p>
                   <div class="divider"></div>
                   <h2>���� ������ �Ļ�</h2>
                   <p>�Ļ��غ� �ʿ���� ����(�繫��)���� ����⸸ �ϸ� OK! ��� 330Kcal�� ���̾�Ʈ ���� �Ĵ�</p>
                   <div class="divider"></div>
                   <h2>��Ʈ������ ����</h2>
                   <p>���̼����� �ܹ����� ǳ���� �Ļ籸���� �����ϸ�, ���� 2,000mg��Ʈ�������� �����Ͽ� ����</p>
                   <div class="divider"></div>
                   <h2>ȣ����� �������� ��ġ�� ���� ��ǥ�丮</h2>
                   <p>���� ������ ��ǥ�丮�� ȣ�� ��� �ս��� �������� ���� ���� �������� ���̾�Ʈ������ ��ź�� </p>
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