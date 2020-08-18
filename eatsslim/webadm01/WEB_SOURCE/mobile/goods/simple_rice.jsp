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
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">제품소개</span></span></h1>
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/goods/cuisine.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">퀴진<br />제품</span></span></a></td>
                 <td><a href="/mobile/goods/alacarte.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">알라<br />까르떼</span></span><span class="active"></span></a></td>
                 <td>
					<a href="/mobile/goods/secretSoup.jsp" class="ui-btn ui-btn-inline ui-btn-up-f">
						<span class="ui-btn-inner">
							<span class="ui-btn-text" style="padding:9px 0px;">간편식</span></span><span class="active">
						</span>
					</a>
				 </td>
                 <td><a href="/mobile/goods/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">밸런스<br />쉐이크</span></span></a></td>
               </tr>
			   <tr class="easyMeal">
					<td colspan="4">
						<span><a href="/mobile/goods/simple_minimeal.jsp">잇슬림 미니밀</a></span>
						<span><a class="here" href="#">잇슬림 라이스</a></span>
						<span><a href="/mobile/goods/simple_secretsoup.jsp">시크릿수프</a></span>
					</td>
			   </tr>
           </table>
           </div>
           <div class="divider"></div>
           <div class="row">
               <div class="goods ssoup">
                   <div class="top-wrap">
                        <span class="goods-copy bg-brown">
                            슈퍼곡물, 슈퍼푸드가 듬뿍! 영양 듬뿍~
                        </span>
                        <p class="goods-caption">밥만 바꿨을 뿐인데?<br /><strong>잇슬림 라이스</strong></p>
                        <div class="top-tail"></div>
                   </div>
                   <div style="margin:15px auto;width:235px;"><img src="/mobile/images/esRice01.png" width="235" height="160" alt="잇슬림 라이스"></div>
                   <h2 class="font-wbrown">잇슬림만의 비법으로 일반밥보다  30% 낮은 칼로리</h2>
                   <p>칼로리는 낮고, 필수 아미노산이 풍부한 곤약과 하이아미쌀을 사용하여 일반 밥(백미) 대비 칼로리를 30% 낮추었습니다. (즉석밥 130g: 190Kcal, 잇슬림 라이스 130g: 130Kcal</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">건강한 비법재료로 맛있고 든든한 밥!</h2>
                   <p>각 메뉴별로 섬유질이 풍부해 다이어트 시 도움이 되는 흑미, 녹차잎, 약콩, 단호박을 사용하여 든든한 포만감은 물론, 맛과 식감을 더하였습니다. </p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">일상에서 작은 변화를 통한 내몸의 변화</h2>
                   <p>급격한 변화를 통한 체중감량이 아닌 일상생활 속에서 밥만의 변화를 통하여 자연스럽게 내 몸의 변화를!</p>
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