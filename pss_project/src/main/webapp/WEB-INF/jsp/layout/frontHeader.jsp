<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:forEach var="i" items="${menuList}" varStatus="status">
	<c:if test="${i.MENU_ID == cMenuId}">
		<c:set var="cMenu1stDepth" value="${i.depth1st }"/>
		<c:set var="cMenu2ndDepth" value="${i.depth2nd }"/>
		<c:set var="cMenu3rdDepth" value="${i.depth3rd }"/>
		<c:set var="cMenuLevel" value="${i.LEVEL }"/>
		<c:set var="cMenuName" value="${i.MENU_NM }"/>
	</c:if>
</c:forEach>

<header id="header" class="header-total">
  <h1 class="blind">PC/Tablet용 헤더입니다.</h1>
  <div class="header_inner">
    <div class="lnb_bg"></div>
    <div class="top clearfix">
      <div class="inr-c">
        <nav class="lst_right clearfix">
          <ul class="lst customer clearfix">
                    <li class="btn_mypage_top">
		                <a><span class="c1">${sessionScope.userInfo.insttNm}(${sessionScope.userInfo.userNm})</span> <span>님 환영합니다.</span><span class="icon-android-arrow-dropdown ico"></span></a>
		                <div class="dep2">
		                    <div class="inner">
			                    <ul>
				                    <li><a href="#" onclick="move('/user/userInfoChk.do'); return false;">나의정보</a></li>
				                    <li><a href="#" onclick="move('/msg/receiveMsgList.do'); return false;">수신업무</a></li>
				                    <li><a href="#" onclick="move('/msg/trnsmitMsgList.do'); return false;">송신업무</a></li>
				                    <li><a href="#" onclick="move('/user/passwordInfo.do'); return false;">비밀번호 변경</a></li>
				                    <li class="logout"><a href="#" onclick="javascript:logout();">로그아웃</a></li>
			                    </ul>
   		                    </div>
		                </div>
		            </li>
          </ul>
        </nav>
        <!-- //lst_right -->
      </div>
    </div>
    <!-- //top -->
    <div class="inr-c ta-l mid">
      <h1 class="logo"><a href="/main.do"><img src="/resources/front/images/common/h_logo.png" alt="SSIS 보건복지 개인정보보호 지원시스템"></a></h1>
    </div>

    <div id="lnbPc">
      <div class="lnb">
        <h1 class="blind">Local Navigation Bar</h1>
        <ul id="lnb-pc">
          <c:forEach items="${menuList}" var="i" varStatus="status">
          	<c:if test="${i.INDICT_TITLE_YN == 'Y'}">
          		<c:if test="${i.LEVEL == '1'}">
          			<c:choose>
       					<c:when test="${'1' eq i.MENU_ID and '5' eq sessionScope.userInfo.authorId and !fn:contains(sessionScope.userInfo.userId, 'ds')}">
       					</c:when>
       					<c:otherwise>
       						<c:choose>
      							<c:when test="${'2' eq i.MENU_ID and '5' eq sessionScope.userInfo.authorId and !fn:contains(sessionScope.userInfo.userId, 'se')}">
      							</c:when>
						<c:otherwise>
            			<c:set var="topMenuOrder" value="${i.depth1st}"/>
            			<li class="mc m${i.depth1st}">
           					<%-- <a href="${i.URL}" class="IcoAfter arr2"><span class="out">${i.MENU_NM}</span><span class="in">${i.MENU_NM}</span></a> --%>
           					<a href="#" class="IcoAfter arr2"><span class="out">${i.MENU_NM}</span><span class="in">${i.MENU_NM}</span></a>
            				<nav class="depth2">
            					<div class="inr">
            						<ul>
		            					<c:forEach items="${menuList}" var="x" varStatus="status">
		            						<c:if test="${x.LEVEL == '2' && x.depth1st == topMenuOrder}"> 
		            							<c:choose>
			            							<c:when test="${'56' eq x.MENU_ID}"><!-- 기초현황 -->
			            								<c:if test="${'Y' eq x.authRead}">
			            									<li class="n1"><a href="#" onclick="move('${x.URL}'); return false;">${x.MENU_NM}</a></li>
			            								</c:if>
			            							</c:when>	
			            							<c:when test="${'9' eq x.MENU_ID}"><!-- 실적등록 및 조회 -->
			            								<!-- 보건복지부 권한이거나, 실적등록 기간인 경우 -->
			            								<c:if test="${'Y' eq x.authRead and ('1' eq sessionScope.userInfo.authorId or ('5' eq sessionScope.userInfo.authorId and ( fn:contains(headerPeriodCd, 'A') or fn:contains(headerPeriodCd, 'H') ) ) or (('IC02' eq sessionScope.userInfo.insttClCd or 'IC03' eq sessionScope.userInfo.insttClCd) and fn:contains(headerPeriodCd, 'A')) or (('IC01' eq sessionScope.userInfo.insttClCd or 'IC04' eq sessionScope.userInfo.insttClCd) and fn:contains(headerPeriodCd, 'H')))}">
			            									<li class="n1"><a href="#" onclick="move('${x.URL}'); return false;">${x.MENU_NM}</a></li>
			            								</c:if>
			            							</c:when>
			            							<c:when test="${'10' eq x.MENU_ID}"><!-- 서면평가 -->		
			            								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
			            								<c:if test="${'Y' eq x.authRead and '2' ne sessionScope.userInfo.authorId and ('1' eq sessionScope.userInfo.authorId or '1' eq sessionScope.userInfo.authorId or 'B' eq headerPeriodCd or 'C' eq headerPeriodCd or 'D' eq headerPeriodCd)}">
			            									<li class="n1"><a href="#" onclick="move('${x.URL}'); return false;">${x.MENU_NM}</a></li>
			            								</c:if>
			            							</c:when>
			            							<c:when test="${'76' eq x.MENU_ID}"><!-- 이의신청 -->	
			            								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
			            								<c:if test="${'Y' eq x.authRead and '2' ne sessionScope.userInfo.authorId and ('1' eq sessionScope.userInfo.authorId or 'B' eq headerPeriodCd or 'C' eq headerPeriodCd or 'D' eq headerPeriodCd)}">
			            									<li class="n1"><a href="#" onclick="move('${x.URL}'); return false;">${x.MENU_NM}</a></li>
			            								</c:if>
			            							</c:when>		
			            							<c:when test="${'77' eq x.MENU_ID }"><!-- 중간점수/이의신청 -->		
			            								<!-- 기관담당자 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
			            								<c:if test="${'Y' eq x.authRead and ('2' eq sessionScope.userInfo.authorId and ('B' eq headerPeriodCd or 'C' eq headerPeriodCd or 'D' eq headerPeriodCd))}">
			            									<li class="n1"><a href="#" onclick="move('${x.URL}'); return false;">${x.MENU_NM}</a></li>
			            								</c:if>		            								
			            							</c:when>		
			            							<c:when test="${'11' eq x.MENU_ID }"><!-- 수준진단 결과 -->		
			            								<!-- 기관담당자 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
			            								<c:if test="${'Y' eq x.authRead}">
			            									<li class="n1"><a href="#" onclick="move('${x.URL}'); return false;">${x.MENU_NM}</a></li>
			            								</c:if>		            								
			            							</c:when>				            							
			            							<c:when test="${'12' eq x.MENU_ID}"><!-- 현장점검 등록 -->	
			            								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
			            								<c:if test="${'Y' eq x.authRead and ('1' eq sessionScope.userInfo.authorId or 'E' eq headerPeriodCd or 'F' eq headerPeriodCd or 'G' eq headerPeriodCd)}">
			            									<li class="n1"><a href="#" onclick="move('${x.URL}'); return false;">${x.MENU_NM}</a></li>
			            								</c:if>
			            							</c:when>
			            							<c:when test="${'13' eq x.MENU_ID}"><!-- 점검결과 조회 -->		
			            								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
			            								<c:if test="${'Y' eq x.authRead}">
			            									<li class="n1"><a href="#" onclick="move('${x.URL}'); return false;">${x.MENU_NM}</a></li>
			            								</c:if>
			            							</c:when>					            							
			            							<c:when test="${'14' eq x.MENU_ID or '15' eq x.MENU_ID}"><!-- 서면점검 실적등록 및 조회 / 우수사례 자료실 -->	
			            								<c:if test="${'Y' eq x.authRead}">
			            									<li class="n1"><a href="#" onclick="move('${x.URL}'); return false;">${x.MENU_NM}</a></li>
			            								</c:if>
			            							</c:when>
			            							<c:otherwise>
			            								<li class="n1"><a href="#" onclick="move('${x.URL}'); return false;">${x.MENU_NM}</a></li>
			            							</c:otherwise>
			            						</c:choose>
		            						</c:if>				
		            					</c:forEach>
	            					</ul>
            					</div>
            				</nav>
            			</li>
       					</c:otherwise>
          				</c:choose>
            			</c:otherwise>
            		</c:choose>
          		</c:if>
          	</c:if>
          </c:forEach>
        </ul>
        
        <form id="headerForm" name="headerForm" method="post" action="/main.do">
			<input type="hidden" id="sMenuId" name="sMenuId"/>
			<input type="hidden" id="sUrl" name="sUrl"/>
			<input type="hidden" id="seq" name="seq"/>
			<input type="hidden" id="threadSeq" name="threadSeq"/>
		</form>
        
      </div>
        <!-- //lnb -->
    </div>
	<c:if test="${'1' eq sessionScope.userInfo.authorId or '2' eq sessionScope.userInfo.authorId}">
		<div class="bus_cooperation">
			<a href="#layerPopupT2" class="btn1" onclick="layerPopupV2.open('/mylibry/mylibry.do', prdCallback); return false;">
				<span class="bg_moniter"></span>
				<span class="t1">마이 라이브러리</span>
			</a>
		</div>
	</c:if>	
  </div>
  <!-- //header_inner -->
</header><!-- header -->
<div class="header_faker"></div>

<script type="text/javascript">
    var $wrap = $("#wrap");
    var $header = $("#header");
    var $lnb = $("#header .lnb");
    var bgSetTime;
    var lnbLineSetTime;
    var wrapPOri;
    var bgOpenFlag = false;
    var pageNum = "${cMenu1stDepth}";
    var subNum = "${cMenu2ndDepth}";
    var threeNum = "${cMenu3rdDepth}";


  function move(url){
  	$("#sUrl").val(url);
  	$("#headerForm").attr({
  		action : url
  	}).submit();	
  }
  
  function PageInit(){
    $header = $("#header");
    $lnb = $("#header .lnb");
    lnbLIneMotion();
    $lnb.find(">ul > li > a").on("click",lnbClick);
  };//PageInit


  // lnb 라인모션
  function lnbLIneMotion(){
      $lnb.find(".depth2").each(function(){
        var $this = $(this);

        function lineEnter(event){
          var $obj = $(this).parent();
          var $ul = $(this).closest("ul");
          var et = event.type;
          //var $line = $(this).closest("ul").siblings(".line");

            $obj.each(function(){
              var $li = $(this);
              if(et == "mouseenter" || et == "focusin"){
                clearInterval(lnbLineSetTime);
                $ul.find("li").removeClass("ovr");
                $li.addClass("ovr");
              }else if(et == "mouseleave" || et == "focusout"){
                $li.removeClass("ovr");
              }//if
            });//each

        };//lineEnter

        $this.find("ul > li > a").on("mouseenter mouseleave focusin focusout",lineEnter);
      });//each


  }





 function lnbEnter2(e){
  var $this = $(this);
  if(e.type == "mouseenter"){
    con("lnbEnter");
    lnbBgMotion(true);
    $this.siblings().removeClass("ovr").end().addClass("ovr");
  }else if(e.type == "mouseleave"){
    con("lnbOut");
    lnbBgMotion(false);
  }

};//lnbEnter

function lnbClick(e){
  var $this = $(this);
  e.preventDefault();
  $this.parent().addClass("ovr");
  lnbBgMotion(true);
  //$lnb.find(">ul > li > a").off("click");
  $lnb.find(">ul > li").on("mouseenter mouseleave",lnbEnter2);
  con("lnbClick");
};//lnbClick

var haderFocusInterval;
var headerFocusFlag = true;
 $header.find("a").on("focusin focusout mouseenter mouseleave",lnbEnter_a);

function lnbEnter_a(e){
  if(e.type == "mouseenter"){
    headerFocusFlag = false;
  }
  if(headerFocusFlag){
    con("focus + e.which:: "+ e.which);
    con("focus + e.type:: "+ e.type);
    clearInterval(haderFocusInterval);
    var $this = $(this);
    var $h = $this.closest("#header");
    var $l = $this.closest(".lnb");
    var a_lang = $h.find("a").length;
    $h.find("a:eq("+(a_lang - 1)+")").addClass("last");
    if($l.length > 0 && e.type == "focusin"){
      lnbBgMotion(true);
      $this.closest("li.mc").siblings().removeClass("ovr").end().addClass("ovr");
      $lnb.find(">ul > li").on("mouseenter mouseleave",lnbEnter2);
    }else if($this.hasClass("last") && e.type == "focusout"){
      haderFocusInterval = setTimeout(function(){
        lnbBgMotion(false);
        $l.find("li.mc").removeClass("ovr");
        $lnb.find(">ul > li").off("mouseenter mouseleave");
      },500)

    }

  }
  if(e.type == "mouseleave"){
    headerFocusFlag = true;
  }
};//lnbEnter_a





function lnbBgMotion(b,f){
  var $lnbBg = $header.find(".lnb_bg");
  var $search = $lnbBg.find(".search");
  var fast = f;
  if(b){
    clearInterval(bgSetTime);
    if(bgOpenFlag == false){
      var h = 0;
       bgOpenFlag = true;
       wrapPOri = parseInt($wrap.css("padding-top"));
      $lnb.find(".depth2").each(function(){
        var $depth = $(this);
        var outerH = $depth.outerHeight();
        if(h < outerH){
          h = outerH;
        }

        // TweenMax.to($depth,0.2,{"opacity":1});
        $depth.css({"display":"block"});
        TweenMax.to($depth.find(">.inr"),0.4,{"margin-top":0,"delay":0.1});
      })

      // TweenMax.to($wrap,0.4,{"padding-top":wrapPOri + h});
      // if(pageNum == "0" && $("#spot.main").length > 0){
      //   TweenMax.to($("#spot.main"),0.4,{"margin-top":h});
      // }
      // TweenMax.to($wrap,0.4,{"padding-top":wrapPOri + h});
      $lnbBg.css("display","block");
      TweenMax.to($lnbBg,0.4,{height:h});
      $(".rtitle").css("display","none");
      $lnb.addClass("lOn");
    }//lf :bgOpenFlag

  }else{
    var setTimeNum = 1000;
    if(fast == true){
      setTimeNum = 0;
      $lnbBg.css("display","none");
    }
    con("lnbBgOut");
    bgSetTime = setTimeout(function(){
      con("lnbBgSetOut");
      if(pageNum == "0" && $("#spot.main").length > 0){
        TweenMax.to($("#spot.main"),0.4,{"margin-top":0});
      }
      TweenMax.to($wrap,0.4,{"padding-top":wrapPOri,onComplete:function(){
          $wrap.css("padding-top","");
          bgOpenFlag = false;
          $lnb.find(">ul>li.ovr").removeClass("ovr");
        }
      });

      TweenMax.to($lnbBg,0.4,{height:0,onComplete:function(){
          $lnbBg.css("display","none");
      }});
      $lnb.find(".depth2").each(function(){
        var $depth = $(this);
        TweenMax.to($depth.find(">.inr"),0.2,{"margin-top":-200,onComplete:function(){
          $depth.css({"display":"none"});
        }});
      });

      $(".rtitle").css("display","block");
      $lnb.find(">ul > li").off("mouseenter mouseleave");
      $lnb.removeClass("lOn");

    },setTimeNum);
  }

};//lnbBgMotion



$(function(){
	PageInit();
	$(".accessibilityWrap a").on('keypress',function(){
		var w = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
		var $id = $($(this).attr("href"));
		$id.attr("tabindex","0");
		$id.find("a:first").focus();
	})
});

var heaerTotalSetTime;

$(window).on("resize.heaerTotal",function(){
  WinWdith = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
  clearInterval(heaerTotalSetTime);
  heaerTotalSetTime = setTimeout(function(){
    if(mobileSizeMin >= WinWdith){
      lnbBgMotion(false);
    }
  },400)

})


</script>