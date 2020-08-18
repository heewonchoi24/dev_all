<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <ul class="subnavi">
            <li><a href="/mobile/shop/dietMeal.jsp">�Ļ���̾�Ʈ</a></li>
            <li><a href="/mobile/shop/weight2weeks.jsp">���α׷����̾�Ʈ</a></li>
            <li><a href="/mobile/shop/minimeal.jsp">Ÿ�Ժ����̾�Ʈ</a></li>
			 <li class="current"><a href="/mobile/shop/dietCLA.jsp">Ǯ��Ÿ</a></li>
        </ul>
    </div>
    <!-- End ui-header -->
    
    <!-- Start Content -->
    <div id="content" style="margin-top:135px;">           
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/popup/lock_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
                 <td><a href="/mobile/shop/lock-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">��� ����</span></span></a></td>
               </tr>
           </table>
           </div>
		   <div class="grid-navi">
            <table class="navi" cellspacing="10 5" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/dietCLA.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">���̾�ƮCLA</span></span></a></td>
                 <td><a href="/mobile/shop/digest.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">��������Ʈ</span></span></a></td>
                 <td><a href="/mobile/shop/womanBalance.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">��չ뷱��</span></span></a></td>
			 </tr>
			 <tr>
                 <td><a href="/mobile/shop/lock.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner1"><span class="ui-btn-text">���</span></span><span class="active"></span></a></td>
                 <td><a href="/mobile/shop/vitaminD.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">Į����Ÿ��D</span></a></td>
                 <td><a href="/mobile/shop/chewable.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">������Ƽ����C</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="divider"></div>
           <div class="row">
           <div class="bg-gray font-brown">
               <p>�� �ǰ��� �������� �鿪 ����� ���Ͽ�!</p> 
			   <h2>"ȥ�� ����� ���"</h2>
               <div style="margin:10px 0 20px 0;"><img src="/mobile/images/lock_mo.jpg" width="100%"></div>
                  <div class="memo">
                      <div class="ribbon-tit"></div>
                      <ul>
                          <li class="memo06">����� ��Ƽ� ���� ����հ� ���Ǵ�����!</li>
                          <li class="memo03">8���� ���ι��̿�ƽ���� �Ϸ翡 10�� ���� �̻� ���� ����!</li>
                          <li class="memo06">�峻 ���ر��� ������ �躯 Ȱ���� ��Ȱ�ϰ�!</li>
						  <li class="memo01">�� ���� ������ �����ϴ� ������!</li>
                      </ul>
                  </div>
             </div>   
            <div class="divider"></div>
            </div>
            
            <div class="row">
                <h2 class="font-brown">01. Ǯ��Ÿ ȥ�� ����� ���</h2>
                   <h3 class="font-wbrown"> ����� ��Ƽ� ����!</h3>
                   <p>4���� ����հ� 4���� ���Ǵ�����, ��ġ���� ������ �Ĺ��� ������� 2�� �������� ����� ��Ƽ� ���ϴ�. </p>
                   <div class="divider"></div>
                   <h3 class="font-wbrown">�躯 Ȱ���� ��Ȱ�ϰ�, �� �ǰ��� �����ش�!</h3>
					<p>8���� ���ι��̿�ƽ���� �Ϸ翡 10�� ���� �̻� ���� �����ϸ�, �峻 ���ر��� �����ϰ�, ������ ������� ������ �����ݴϴ�.</p>
                   <div class="divider"></div>
                   <h3 class="font-wbrown">�鿪 ��ɿ� �ʿ��� ���б��� plus!</h3>
                   <p>�鿪 ��ɿ� �ʿ��� �ƿ��� �Բ� �����Ǿ� ������, �ο���� ������ ������ ������ ������ø������ �����Ǿ� �ֽ��ϴ�.</p>
                   <div class="divider"></div>

                   <h2 class="font-brown">02. ���뷮 �� ������</h2>
					<p>1�� 2ȸ, 1�� 1���� �� �Ŀ� ���� �Բ� �����ϼ���.</p>
                   <div class="divider"></div>

                   <h2 class="font-brown">03. �̷� �е鲲 ���ص帳�ϴ�.</h2>
                   <ul class="dot">
                      <li>���� ���� ��� �����Ͻ� ��</li>
                      <li>���� Ȱ���� �������� �ӻ��</li>
					  <li>�躯 Ȱ���� ��Ȱ���� ���� ��</li>
					  <li>�� ����� ���� ���� �Ǵ� ����</li>
					  <li>����� ������ �л�, ������</li>
					  <li>�������� �鿪 ����� �ʿ��Ͻ� ��</li>
                   </ul>
                   <div class="divider"></div>

				   <h2 class="font-brown">04. ���� �� ���� �� ���ǻ���</h2>
                   <ul class="dot">
                      <li>�˷����� ü���� ��� ������ Ȯ���Ͻ� �� �����Ͻʽÿ�.</li>
                      <li>�� ��ǰ�� ��θ� ����� ��ǰ�� ���� �����ü����� �����ϰ� �ֽ��ϴ�.</li>
					  <li>����ִ� ������ ����ִ� ��ǰ�̹Ƿ� ���籤���� ��´ٽ��� ���� ���ϰ�, �ǳ��� ���� �����Ͻʽÿ�. </li>
					  <li>��Ⱓ ���� �ÿ��� ���� �����Ͻø� �����ϴ�.</li>
					  <li>���� �Ŀ��� ������ ���� ��ñ� �ٶ��ϴ�.</li>
                   </ul>
                   <div class="divider"></div>
            </div>
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/popup/lock_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
                 <td><a href="/mobile/shop/lock-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">��� ����</span></span></a></td>
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