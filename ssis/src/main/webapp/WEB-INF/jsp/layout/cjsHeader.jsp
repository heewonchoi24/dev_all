<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
		                <a href="#"><span class="c1">${sessionScope.userInfo.insttNm}(${sessionScope.userInfo.userNm})</span> <span>님 환영합니다.</span><span class="icon-android-arrow-dropdown ico"></span></a>
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
      <h1 class="logo"><a href="/cjs/intrcnRegist.do"><img src="/resources/front/images/common/h_logo.png" alt="SSIS 보건복지 개인정보보호 지원시스템"></a></h1>
    </div>

    <div id="lnbPc">
      <div class="lnb">
        <h1 class="blind">Local Navigation Bar</h1>
        <ul id="lnb-pc">
        	<li class="mc m1 on">
        		<a href="/cjs/intrcnRegist.do"><span class="out">관제소개 및 신청</span><span class="in">관제소개 및 신청</span></a>
        	</li>
        	<li class="mc m2">
        		<a href="/cjs/bbsList.do"><span class="out">관제 알림마당</span><span class="in">관제 알림마당</span></a>
        	</li>
        	<c:if test="${'Y' eq adminMenu}">
        	<li class="mc m3">
        		<a href="/cjs/cntrlRegistMngList.do"><span class="out">관제 신청관리</span><span class="in">관제 신청관리</span></a>
        	</li>
        	</c:if>
          
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

<!--     <div class="bus_cooperation">
		<a href="#layerPopupT2" class="btn1" onclick="layerPopupV2.open('/mylibry/mylibry.do', prdCallback); return false;">
			<span class="bg_moniter"></span>
			<span class="t1">마이 라이브러리</span>
		</a>
	</div> -->
  </div>
  <!-- //header_inner -->
</header><!-- header -->
<div class="header_faker"></div>

<script>
$(document).ready(function(){
	listMsg();
})

function move(url, menuDeths1, menuDeths2){	
	$("#sUrl").val(url);
	$("#headerForm").attr({
		action : url
	}).submit();
}

function listMsg(){
	var msgList = '';
	$.ccmsvc.ajaxSyncRequestPost(
			'/cmn/recptnMsgList.do',
			'',
			function(data, textStatus, jqXHR){
				$(".alramNum").text(data.msgCnt);
				if(data.msgCnt > 0){
					for(var i in data.recptnMsgList){
						msgList += '<li>';
						msgList += '<span class="date">' + data.recptnMsgList[i].REGIST_DT + '</span>';
						msgList += '<dl>';
						msgList += '<dt>재등록 요청</dt>';
						msgList += '<dd><a href="#" onclick="viewThread(\'/cjs/receiveMsgView.do\',\'' + data.recptnMsgList[i].SEQ + '\'); return false;">' +  data.recptnMsgList[i].SUBJECT + '</a></dd>';
						msgList += '</dl>';
						msgList += '</li>';
					}
					$("#msgList").html(msgList);					
				}else{
					$("div.alram_wrap").css("display", "none");
					$("div").removeClass("alram_wrap");
					$("#alram_open").bind("click", function(){
						move('/cjs/receiveMsgList.do');
					})
				}
			}, 
			function(jqXHR, textStatus, errorThrown){
			});
}

function viewThread(url, seq){
	$("#threadSeq").val(seq);
	$("#headerForm").attr({
		action : url
	}).submit();
}

</script>

