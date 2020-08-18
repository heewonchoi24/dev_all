<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <ul class="subnavi">
			<li class="current"><a href="/mobile/customer/service.jsp">�ֹ��ȳ�</a></li>
			<li><a href="/mobile/goods/cuisine.jsp">��ǰ�Ұ�</a></li>
            <li><a href="/mobile/intro/schedule.jsp">�̴��� �Ĵ�</a></li>
		</ul>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content" style="margin-top:135px;">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">����,�ù��� �ֹ��ȳ�</span></span></h1>
           <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:10px 0;">
             <tr>
               <td width="40" class="badge-bg green">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>01</p>
                   </div>
               </td>
               <td width="10">&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>�ֹ��ȳ� Ȯ��</h3>
                       <p>��ǰ�� ������ ����� Ȯ���Ͻ� �� �ֹ��Ͻ� ��ǰ�� �������ּ���.</p>
                   </div>
               </td>
             </tr>
             <tr>
               <td class="badge-bg green">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>02</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>��ް������� Ȯ��</h3>
                       <p>���Ϲ�� ��ǰ(���̾�Ʈ �Ļ�, ���̾�Ʈ ���α׷�, ��ũ�� ����)�� ��� ������ �������� ����� ��Ź������� ���Ͽ� ���� �����޵ǰ� �ֽ��ϴ�.<br />���Ϲ�� ��ǰ�� �ֹ��Ͻ� ��� ��ް��� �������� �� Ȯ�� �� �ֹ����ּ���.</p>
                   </div>
               </td>
             </tr>
             <tr>
               <td class="badge-bg orange">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>03</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>�Ļ�Ⱓ ����</h3>
                       <p>�����Ͻ� ��ǰ�� ���� �Ĵ�ǥ�� ������ �����Ͻ� ������ ���� �Ļ�Ⱓ(��)�� �������ּ���.</p>
                       <br />
    <!--                 <h4 class="font-orange">���̾�Ʈ�Ļ� 5��(2��/4��)</h4>
                     <table width="100%" border="0" cellspacing="0" cellpadding="0">
                         <tr bgcolor="#FFFFFF">
                           <td width="14%" align="center">��</td>
                           <td width="14%" align="center">ȭ</td>
                           <td width="14%" align="center">��</td>
                           <td width="14%" align="center">��</td>
                           <td width="14%" align="center">��</td>
                           <td width="14%" align="center">��</td>
                           <td width="16%" align="center">��</td>
                       </tr>
                         <tr>
                           <td colspan="5" align="center" class="bg-orange">5�� ���</td>
                           <td align="right" class="bg-brown">���</td>
                           <td align="left" class="bg-brown">����</td>
                       </tr>
                     <tr>
                           <td colspan="6" align="center" class="bg-green">6�Ϲ��</td>
                           <td colspan="1" align="center" class="bg-brown">����</td>
                       </tr> 
                     </table>
            <p>- ��: �� 5��(��~��) �Ǵ� ��6��(��~��) ���ð���</p> 
                     <p>- ��: 2�� �Ǵ� 4�� ���� ����</p>  
                     <br />  -->

                     <h4 class="font-orange">���̾�Ʈ�Ļ�,��ũ������(����/���� ����)</h4>
                     <table width="100%" border="0" cellspacing="0" cellpadding="0">
                         <tr bgcolor="#FFFFFF">
                           <td align="center">��</td>
                           <td align="center">ȭ</td>
                           <td align="center">��</td>
                           <td align="center">��</td>
                           <td align="center">��</td>
                           <td align="center">��</td>
                           <td align="center">��</td>
                       </tr>
                         <tr>
                           <td colspan="5" align="center" class="bg-orange">5�� ���</td>
                           <td colspan="2" align="center" class="bg-brown">���</td>
                       </tr>
                         <tr>
						    <td align="center" class="bg-green">����</td>
                           <td align="center" bgcolor="#FFCC00">&nbsp;</td>
                           <td align="center" class="bg-green">����</td>
                           <td align="center" bgcolor="#FFCC00">&nbsp;</td>
						   <td align="center" class="bg-green">����</td>
                           <td align="center" class="bg-brown">����</td>
						   <td align="center" class="bg-brown">&nbsp;</td>
                       </tr>
                     </table>
                     <p>- ��: �� 5��(��~��) �Ǵ� �� 3��(������) ���ð���</p>
                     <p>- ��: �� 5�� ��ǰ(1��, 2��, 4�� ���ð���), �� 3�� ��ǰ(2��,4�� ���ð���)</p>
                     <br />  
						<h4 class="font-orange">���α׷� ���̾�Ʈ</h4>
							<p>- 3��, 6��, 2��, 4�� : �ָ�(��,��)�� ������ ���� 5�� ���� ���</p> 
                   </div>


               </td>
             </tr>
             <tr>
               <td class="badge-bg orange">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>04</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>ù ����� ����</h3>
                       <p>���Ϲ���� ��� ����� ���ź��� ��ޱ��� �� 6�� �ҿ�Ǹ�, 6�� ���� �������� ���� �����մϴ�. </p>
                       <p>�ù����� ��� ����� ������ �Ұ����ϸ�, �����Ϸ� ���� 2~5���Ŀ� ��ǰ�� �����Ͻ� �� �ֽ��ϴ�.</p>
                   </div>
               </td>
             </tr>
             <tr>
               <td class="badge-bg orange">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>05</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>���ð����ֹ�</h3>
                       <p>���ð��� ���� ���θ� �������ּ���.</p>
                       <p>ó�� ���Ϲ�� ��ǰ�� �ֹ��Ͻ� ��� ���ð����� �ʼ��� �����ϼž� ��ǰ�� �ż��ϰ� ������ �� �ֽ��ϴ�.</p>
                       <p>���ð����� �̹� �����Ͽ� ��ǰ�� ������ �̷��� �ִ� ���, ���������� ���Ű� �����մϴ�.</p>
                   </div>
               </td>
             </tr>
             <tr>
               <td class="badge-bg brown">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>06</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>������Է�</h3>
                       <p>���Ϲ�� ��ǰ�� �ù��� ��ǰ�� �����Ͽ� ������� �Է��� �� �ֽ��ϴ�.</p>
                       <p>���Ϲ�� ��ǰ, �ù��� ��ǰ ��� ���� ������� ������ ��� �����ϰ� �Է��Ͻø� �˴ϴ�.</p>
                   </div>
               </td>
             </tr>
             <tr>
               <td class="badge-bg brown last">
                   <div class="badge">
                       <p class="tit">STEP</p>
                       <p>07</p>
                   </div>
               </td>
               <td>&nbsp;</td>
               <td>
                   <div class="bg-gray" style="margin:0 0 10px 0;">
                       <h3>�ֹ�����</h3>
                       <!-- <p>ī�����, �ǽð� ������ü, ������� �� ���Ͻô� ����������� ������ �Ͻø� �˴ϴ�.</p> -->
                       <p>������°���, �ǽð�������ü, �ſ�ī�� ���� �� ���Ͻô� ���������� �����Ͽ� �����Ͻø� �ֹ��� �Ϸ�˴ϴ�.</p>
                   </div>
               </td>
             </tr>
           </table>
     </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
<