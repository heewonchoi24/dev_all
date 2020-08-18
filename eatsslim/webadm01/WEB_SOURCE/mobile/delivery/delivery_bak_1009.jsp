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
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">일배 배송가능지역</span></span></h1>
            <div id="accordion" class="row">
                <h3 class="ui-btn-up-c">서울특별시</h3>
                    <div id="accordionlist">
                        <ul class="ui-listview">
                            <li class="ui-li ui-li-static ui-btn-up-e">구로구</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">금천구</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">강남구</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">강서구</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">강북구</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">성동구</li>
                        </ul>
                    </div>
                <h3 class="ui-btn-up-c">경기도</h3>
                    <div id="accordionlist">
                        <ul class="ui-listview">
                            <li class="ui-li ui-li-static ui-btn-up-e">안양시</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">수원시</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">과천시</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">안산시</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">하남시</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">성남시</li>
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