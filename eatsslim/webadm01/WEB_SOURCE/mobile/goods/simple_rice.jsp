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
    <div id="content" class="esRice oldClass">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ�Ұ�</span></span></h1>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">����<br />��ǰ</span></span></a></td>
                 <td><a href="/mobile/goods/alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�˶�<br />���</span></span><span class="active"></span></a></td>
                 <td>
					<a href="/mobile/goods/secretSoup.jsp" class="ui-btn ui-btn-inline ui-btn-up-f">
						<span class="ui-btn-inner">
							<span class="ui-btn-text" style="padding:9px 0px;">�����</span></span><span class="active">
						</span>
					</a>
				 </td>
                 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�뷱��<br />����ũ</span></span></a></td>
               </tr>
			   <tr class="easyMeal">
					<td colspan="4">
						<span><a href="/mobile/goods/simple_minimeal.jsp">�ս��� �̴Ϲ�</a></span>
						<span><a class="here" href="#">�ս��� ���̽�</a></span>
						<span><a href="/mobile/goods/simple_secretsoup.jsp">��ũ������</a></span>
					</td>
			   </tr>
           </table>
           </div>
           <div class="divider"></div>
           <div class="row">
               <div class="goods ssoup">
                   <div class="top-wrap">
                        <span class="goods-copy bg-brown">
                            ���۰, ����Ǫ�尡 ���! ���� ���~
                        </span>
                        <p class="goods-caption">�丸 �ٲ��� ���ε�?<br /><strong>�ս��� ���̽�</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/esRice01.png" width="235" height="160" alt="�ս��� ���̽�"></div>
                   <h2 class="font-wbrown">�ս������� ������� �Ϲݹ亸��  30% ���� Į�θ�</h2>
                   <p>Į�θ��� ����, �ʼ� �ƹ̳���� ǳ���� ���� ���̾ƹ̽��� ����Ͽ� �Ϲ� ��(���) ��� Į�θ��� 30% ���߾����ϴ�. (�Ｎ�� 130g: 190Kcal, �ս��� ���̽� 130g: 130Kcal</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">�ǰ��� ������� ���ְ� ����� ��!</h2>
                   <p>�� �޴����� �������� ǳ���� ���̾�Ʈ �� ������ �Ǵ� ���, ������, ����, ��ȣ���� ����Ͽ� ����� �������� ����, ���� �İ��� ���Ͽ����ϴ�. </p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">�ϻ󿡼� ���� ��ȭ�� ���� ������ ��ȭ</h2>
                   <p>�ް��� ��ȭ�� ���� ü�߰����� �ƴ� �ϻ��Ȱ �ӿ��� �丸�� ��ȭ�� ���Ͽ� �ڿ������� �� ���� ��ȭ��!</p>
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