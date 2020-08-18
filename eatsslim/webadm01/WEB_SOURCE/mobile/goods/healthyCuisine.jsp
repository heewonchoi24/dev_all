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
			   <td><a href="/mobile/goods/healthyCuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">�ﾾ����</span></span><span class="active"></span></a></td>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">����</span></span></a></td>
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
                            ����� �ż��� �ڿ� ����Ḧ �����Ͽ� ���缳��� �ǰ� ���ö�
                        </span>
                        <p class="goods-caption">��Ʈ��,Į�θ� ����, LowGL�����<br />�����ε� ���ִ� �Ļ�, <strong>�ﾾ����</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/healthyCuisine_goods_img01.jpg" width="235" height="160" alt="�ﾾ����"></div>
                   <h2 class="font-wbrown">�ڿ��� ���� �ǰ� ���ö�!</h2>
                   <p>����� �ż��� ��ö �ڿ� ����Ḧ �����Ͽ� ����, ������ ���� ä�� 2����, ����, Ƣ���� �ʴ� �������� ������ �ǰ� ���ö�</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">ü�� ���� �� �ǰ� ����!</h2>
                   <p>������ ���� �ǰ� ������ ü�� ������ �����ϵ��� ����� ��ǰ </p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">�������� ���缳��!</h2>
                   <p>����������ȸ������ȸ �����ڹ�, 1�� ���� kcal ��� 500kcal���� , ��Ʈ�� ��� 950mg����, 40eGL�� ���缳�� ����</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">1�� 40eGL���� �ս��� Low GL!</h2>
				   <p>GL(Glycemic load)�� ���� ���� ��ȭ���� ��Ÿ���� ��ǥ��, ������ ������ �����ϴ��� GL(�������)�� ���� �Ļ�� ������ ���� �ø��� �ʾ� �ν����� ���� �к�� ü���� ������ ���� ����. <br />
				   �ѱ����� High GL���� �����ϰ� �־� ���κ񸸰� ������ı� ������ ������, Low GL�Ļ�� ������ ��ȭ���� ũ�� �ʰ�, ���������� ������ �� �־� ������ ������ �Ŀ� ������ ����</p>
                   <p><br /><strong>* eGL(estimated Glycemic Load)�� GL�� �����ϱ� ���Ͽ� Ǯ�������� �ӻ󿬱��� ���� ������ GL�������� �ѱ��� ��� ���� eGL�� 1�� 162eGL, �ﾾ������ 1�� 120eGL��Ģ ����!</strong></p>
               </div>
           </div>


  		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/popup/dietmeal_info.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
					<td><a href="/mobile/shop/healthyMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�ﾾ���� �����ϱ�</span></span></a></td>
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