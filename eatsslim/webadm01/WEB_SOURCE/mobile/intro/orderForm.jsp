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
    <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">�ս��� ���̵�</span></span></h1>
    <div class="grid-navi eatsstory">
      <table class="navi" cellspacing="10" cellpadding="0">
        <tr>
          <td><a href="/mobile/intro/checkLocation.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�������<br />
            Ȯ��</span></span></a></td>
          <td><a href="/mobile/intro/findMenu.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">���ϴ�<br />
            �Ĵ�ã��</span></span></a></td>
          <td><a href="/mobile/intro/orderForm.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">�ֹ��ϱ�<br />
            ��������</span></span><span class="active"></span></a></td>
          <td><a href="/mobile/intro/changeOrder.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�ֹ�����<br />
            Type1</span></span></a></td>
          <td><a href="/mobile/intro/changeOrderKakao.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�ֹ�����<br />
            Type2</span></span></a></td>
        </tr>
      </table>
    </div>
    <div class="row">

	<div><img src="/mobile/images/step03.jpg" alt="�������Ȯ��"></div>
      <div class="divider"></div>
    </div>
  </div>

  <!-- End Content -->
  <div class="ui-footer">
    <%@ include file="/mobile/common/include/inc-footer.jsp"%>
  </div>
</div>
</body>
</html>