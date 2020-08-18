<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
     <script>
	  $(function() {
		$( "#accordion" ).accordion({
		  collapsible: true
		});
	  });
	  </script>
</head>
<body>
<div id="wrap">
    <div class="ui-header ui-shadow" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">�Ϲ� ��۰�������</span></span></h1>
            <div id="accordion" class="row">
                <h3 class="ui-btn-up-c">����Ư����</h3>
                    <div id="accordionlist">
                        <ul class="ui-listview">
                            <li class="ui-li ui-li-static ui-btn-up-e">���α�</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">��õ��</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">������</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">������</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">���ϱ�</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">������</li>
                        </ul>
                    </div>
                <h3 class="ui-btn-up-c">��⵵</h3>
                    <div id="accordionlist">
                        <ul class="ui-listview">
                            <li class="ui-li ui-li-static ui-btn-up-e">�Ⱦ��</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">������</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">��õ��</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">�Ȼ��</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">�ϳ���</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">������</li>
                        </ul>
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