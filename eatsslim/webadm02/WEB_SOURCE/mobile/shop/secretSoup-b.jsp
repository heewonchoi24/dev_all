<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <ul class="subnavi">
            <li><a href="/mobile/shop/dietMeal.jsp">���̾�Ʈ�Ļ�</a></li>
            <li><a href="/mobile/shop/keepProgram.jsp">���̾�Ʈ ���α׷�</a></li>
            <li class="current"><a href="/mobile/shop/secretSoup.jsp">��ɽ� ���̾�Ʈ</a></li>
        </ul>
    </div>
    <!-- End ui-header -->
    
    <!-- Start Content -->
    <div id="content" style="margin-top:135px;">
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/dietSoup-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">��ũ������ ����</span></span></a></td>
                 <td><a href="/mobile/shop/balanceShake-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�뷱������ũ ����</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/secretSoup.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">��ũ������<br />AŸ��</span></span></a></td>
                 <td><a href="/mobile/shop/secretSoup-b.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner"><span class="ui-btn-text">��ũ������<br />BŸ��</span></span><span class="active"></span></a></td>
                 <td><a href="/mobile/shop/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">�뷱��<br />����ũ</span></span></a></td>
               </tr>
           </table>
           </div>
           <div class="divider"></div>
           <div class="row">
           <h2>��ũ������ BŸ��?</h2>
           <p>��ũ������ BŸ�Կ� ���� ������ ����</p>
           <div class="divider"></div>
           <img src="/mobile/images/eatsslim_intro.jpg" width="100%">
           </div>
           
           
  </div>
    <!-- End Content -->
    <div class="ui-footer">
        <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>