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
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">�ؽż� ���Ϲ��</span></span></h1>
           <div class="grid-navi eatsstory">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/intro/eatsslimStory.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�ս���<br />���丮</span></span></span></a></td>
                 <td><a href="/mobile/intro/eatsslimFeature.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�ս���<br />Ư¡</span></span></a></td>
                 <td><a href="/mobile/intro/eatsslimCounsel.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�ڹ���<br />�Ұ�</span></span></a></td>
                 <td><a href="/mobile/intro/eatsslimCkitchen.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">����Ʈ<br />Űģ</span></span></a></td>
				 <td><a href="/mobile/delivery/freshparcel.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">�ؽż�<br />���Ϲ��</span></span><span class="active"></span></a></td>
               </tr>
           </table>
           </div>
        <div class="row">
        	<img src="/mobile/common/images/freshparcel_img.jpg" alt="" />
        </div>
	</div>
	<!-- End Content -->
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
</body>
</html>