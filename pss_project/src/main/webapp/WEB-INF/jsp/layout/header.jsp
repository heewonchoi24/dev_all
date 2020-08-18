<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script>

$(document).ready(function(){
	<c:if test="${'5' ne sessionScope.userInfo.authorId}">
		listMsg();
	</c:if>
})

function move(url){
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
						msgList += '<dt>' +  data.recptnMsgList[i].SUBJECT + '</dt>';
						msgList += '<dd><a href="#" onclick="viewThread(\'/msg/receiveMsg\',\'' + data.recptnMsgList[i].SEQ + '\'); return false;">' +  data.recptnMsgList[i].CONTENTS + '</a></dd>';
						msgList += '</dl>';
						msgList += '</li>';
					}
					$("#msgList").html(msgList);					
				}else{
					$("div.alram_wrap").css("display", "none");
					$("div").removeClass("alram_wrap");
					$("#alram_open").bind("click", function(){
						move('/msg/receiveMsgList.do');
					})
				}
			}, 
			function(jqXHR, textStatus, errorThrown){
			});
}

function viewThread(url, seq, bbsCd){
	var lUrlStr = bbsCd ? (url + 'List.do?bbsCd=' + bbsCd) : (url + 'List.do');
	var vUrlStr= bbsCd ? (url + 'View.do?bbsCd=' + bbsCd) : (url + 'View.do');
	
	$("#seq").val(seq);
	$("#threadSeq").val(seq);
	$("#sUrl").val(lUrlStr);
	
	$("#headerForm").attr({
		action : vUrlStr
	}).submit();
}

</script>

<!-- header -->
    <div id="util_wrap">
        <!-- 접속정보 및 상단 메뉴 -->
        <div class="util_menu">
            <div class="user_info"><strong>${sessionScope.userInfo.userNm }</strong>&nbsp;님 접속중입니다.</div>
            <div class="user_menu">
                <ul>
                	<c:choose>
                		<c:when test="${'5' ne sessionScope.userInfo.authorId}">
                    		<li><a href="#" onclick="move('/user/userInfoChk.do'); return false;">마이페이지</a></li>
                    	</c:when>
                    	<c:otherwise>
                    		<li><a href="#" onclick="move('/user/passwordInfo.do'); return false;">마이페이지</a></li>
                    	</c:otherwise>
                    </c:choose>
                    <li><a href="/login/logout.do">로그아웃</a></li>
                </ul>
                <div class="admin_wrap">
                	<c:if test="${sessionScope.userInfo.authorId =='1' || sessionScope.userInfo.authorId =='4'}">
						<div id="admin" class="admin_menu">
                			<ul>
                				<c:forEach var="i" items="${menuList }" varStatus="status">
                					<c:choose>
                						<c:when test="${i.MENU_ID == '8' && i.UPPER_MENU_ID == '0' }">
                							<li><a href="#" onclick="move('${i.URL }'); return false;">${i.MENU_NM }</a></li>		
                						</c:when>
                						<c:when test="${i.UPPER_MENU_ID == '8' }">
                							<li><a href="#" onclick="move('${i.URL }'); return false;">${i.MENU_NM }</a></li>
                						</c:when>
                					</c:choose>
                				</c:forEach>
							</ul>							
						</div>
                	</c:if>
                	<c:if test="${'1' eq sessionScope.userInfo.authorId or fn:contains(sessionScope.userInfo.chrgDutyCd, 'IJ03') or fn:contains(sessionScope.userInfo.chrgDutyCd, 'IJ04')}">
                		<a href="/cjs/intrcnRegist.do" class="control_btn">관제업무지원 시스템</a>
                	</c:if>
                </div>
            </div>
        </div>
        <!-- /접속정보 및 상단 메뉴 -->
    </div>
    
    <!-- 로고, GNB, 메시지함, 전체메뉴 -->
    <div id="gnb_wrap">
        <div id="gnb">
            <h1><a href="/main.do"><img src="/images/common/logo_white.png" alt="보건복지 개인정보보호 지원시스템"></a></h1>
            <ul class="gnb_menu gnb6">
            <c:forEach items="${menuList }" var="i" varStatus="status">
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
            			<c:set var="topMenuOrder" value="${i.depth1st }"/>
            			<li class="gnb_depth1">
           				<a href="#" onclick="move('${i.URL }'); return false;">${i.MENU_NM }</a>
	           				
            				<ul class="gnb_depth2 w210">
            					<c:forEach items="${menuList }" var="x" varStatus="status">
            						<c:if test="${x.LEVEL == '2' && x.depth1st == topMenuOrder}">
            							<c:choose>
	            							<c:when test="${'9' eq x.MENU_ID}">
	            								<!-- 보건복지부 권한이거나, 실적등록 기간인 경우 -->
	            								<c:if test="${'1' eq sessionScope.userInfo.authorId or ('5' eq sessionScope.userInfo.authorId and (fn:contains(headerPeriodCd, 'A') or fn:contains(headerPeriodCd, 'H'))) or (('IC02' eq sessionScope.userInfo.insttClCd or 'IC03' eq sessionScope.userInfo.insttClCd) and fn:contains(headerPeriodCd, 'A')) or (('IC01' eq sessionScope.userInfo.insttClCd or 'IC04' eq sessionScope.userInfo.insttClCd) and fn:contains(headerPeriodCd, 'H'))}">
	            									<li><a href="#" onclick="move('${x.URL }'); return false;">${x.MENU_NM }</a></li>
	            								</c:if>
	            							</c:when>
	            							<c:when test="${'10' eq x.MENU_ID}">
	            								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
	            								<c:if test="${'1' eq sessionScope.userInfo.authorId or 'B' eq headerPeriodCd or 'C' eq headerPeriodCd or 'D' eq headerPeriodCd}">
	            									<li><a href="#" onclick="move('${x.URL }'); return false;">${x.MENU_NM }</a></li>
	            								</c:if>
	            							</c:when>
	            							<c:when test="${'12' eq x.MENU_ID}">
	            								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
	            								<c:if test="${'1' eq sessionScope.userInfo.authorId or 'E' eq headerPeriodCd or 'F' eq headerPeriodCd or 'G' eq headerPeriodCd}">
	            									<li><a href="#" onclick="move('${x.URL }'); return false;">${x.MENU_NM }</a></li>
	            								</c:if>
	            							</c:when>
	            							<c:otherwise>
	            								<li><a href="#" onclick="move('${x.URL }'); return false;">${x.MENU_NM }</a></li>
	            							</c:otherwise>
	            						</c:choose>
            						</c:if>				
            					</c:forEach>
            				</ul>
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
            <ul class="right_menu">
            	<c:if test="${'5' ne sessionScope.userInfo.authorId && '8' ne sessionScope.userInfo.authorId}">
	                <li class="alram">
	                    <div class="alramNum">0</div>
	                    <a href="#" id="alram_open"><span>업무협업</span></a>
	                </li>
                </c:if>
                <li class="allMenu">
                    <a href="#"><span>전체메뉴</span></a>
                </li>
            </ul>
			<div class="alram_wrap">
				<div class="alram_content">
					<div class="alram_scroll">
						<ul id="msgList">
						</ul>
					</div>
					<div class="alram_go">
						<a href="#"  onclick="move('/msg/receiveMsgList.do'); return false;" title="업무협업 바로가기" class="go">업무협업 바로가기</a>
						<a href="#" class="alrm_close">닫기</a>
					</div>						
				</div>
			</div>
        </div>    
    </div>
    
    <c:forEach var="i" items="${menuList }" varStatus="status">
		<c:if test="${i.MENU_ID == cMenuId}">
			<c:set var="cMenu1stDepth" value="${i.depth1st }"/>
			<c:set var="cMenu2ndDepth" value="${i.depth2nd }"/>
			<c:set var="cMenu3rdDepth" value="${i.depth3rd }"/>
			<c:set var="cMenuLevel" value="${i.LEVEL }"/>
		</c:if>
    </c:forEach>
    
    <!-- /로고, GNB, 메시지함, 전체메뉴 -->        
    <!-- sub menu -->
    <c:if test="${cMenuId != '0'}">
	<div id="snb">
        <div class="snb_wrap">
            <ul>
                <li class="home"><a href="/main.do">홈</a></li>
                <c:forEach begin="1" end="${cMenuLevel}" varStatus="status">
                	<li class="snb_depth1">
                		<c:choose>
                			<c:when test="${status.count == '1' }">
                				<c:forEach items="${menuList }" var="i" varStatus="status">
                					<c:if test="${i.LEVEL == '1' && i.depth1st == cMenu1stDepth}">
                						<c:choose>
            								<c:when test="${'1' eq i.MENU_ID and '5' eq sessionScope.userInfo.authorId and !fn:contains(sessionScope.userInfo.userId, 'ds')}">
            								</c:when>
            								<c:otherwise>
            									<c:choose>
		            								<c:when test="${'2' eq i.MENU_ID and '5' eq sessionScope.userInfo.authorId and !fn:contains(sessionScope.userInfo.userId, 'se')}">
		            								</c:when>
		            								<c:otherwise>
			           									<a href="">${i.MENU_NM }</a>
		            								</c:otherwise>
		            							</c:choose>
            								</c:otherwise>
            							</c:choose>
                					</c:if>
                				</c:forEach>
                				<ul class="snb_depth2">
	                				<c:forEach items="${menuList }" var="i" varStatus="status">
										<c:if test="${i.LEVEL == '1' }">
											<c:choose>
            									<c:when test="${'1' eq i.MENU_ID and '5' eq sessionScope.userInfo.authorId and !fn:contains(sessionScope.userInfo.userId, 'ds')}">
            									</c:when>
            									<c:otherwise>
            										<c:choose>
			            								<c:when test="${'2' eq i.MENU_ID and '5' eq sessionScope.userInfo.authorId and !fn:contains(sessionScope.userInfo.userId, 'se')}">
			            								</c:when>
			            								<c:otherwise>
				           									<li><a href="#" onclick="move('${i.URL }'); return false;" <c:if test="${i.depth1st == cMenu1stDepth}">class="on"</c:if>>${i.MENU_NM }</a></li>
			            								</c:otherwise>
			            							</c:choose>
            									</c:otherwise>
            								</c:choose>
										</c:if>
									</c:forEach>
                				</ul>
                			</c:when>
                			<c:when test="${status.count == '2' }">
                				<c:forEach items="${menuList }" var="i" varStatus="status">
                					<c:if test="${i.LEVEL == '2' && i.depth1st == cMenu1stDepth && i.depth2nd == cMenu2ndDepth}">
                						<a href="">${i.MENU_NM }</a>
                					</c:if>
                				</c:forEach>
                				<ul class="snb_depth2">
	                				<c:forEach items="${menuList }" var="i" varStatus="status">
										<c:if test="${i.LEVEL == '2' && i.depth1st == cMenu1stDepth}">
											<c:choose>
		            							<c:when test="${'9' eq i.MENU_ID}">
		            								<!-- 보건복지부 권한이거나, 실적등록 기간인 경우 -->
		            								<c:if test="${'1' eq sessionScope.userInfo.authorId or ('5' eq sessionScope.userInfo.authorId and (fn:contains(headerPeriodCd, 'A') or fn:contains(headerPeriodCd, 'H'))) or (('IC02' eq sessionScope.userInfo.insttClCd or 'IC03' eq sessionScope.userInfo.insttClCd) and fn:contains(headerPeriodCd, 'A')) or (('IC01' eq sessionScope.userInfo.insttClCd or 'IC04' eq sessionScope.userInfo.insttClCd) and fn:contains(headerPeriodCd, 'H'))}">
		            									<li><a href="#" onclick="move('${i.URL }'); return false;" <c:if test="${i.depth2nd == cMenu2ndDepth}">class="on"</c:if>>${i.MENU_NM }</a></li>
		            								</c:if>
		            							</c:when>
		            							<c:when test="${'10' eq i.MENU_ID}">
		            								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
		            								<c:if test="${'1' eq sessionScope.userInfo.authorId or 'B' eq headerPeriodCd or 'C' eq headerPeriodCd or 'D' eq headerPeriodCd}">
		            									<li><a href="#" onclick="move('${i.URL }'); return false;" <c:if test="${i.depth2nd == cMenu2ndDepth}">class="on"</c:if>>${i.MENU_NM }</a></li>
		            								</c:if>
		            							</c:when>
		            							<c:when test="${'12' eq i.MENU_ID}">
		            								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
		            								<c:if test="${'1' eq sessionScope.userInfo.authorId or 'E' eq headerPeriodCd or 'F' eq headerPeriodCd or 'G' eq headerPeriodCd}">
		            									<li><a href="#" onclick="move('${i.URL }'); return false;" <c:if test="${i.depth2nd == cMenu2ndDepth}">class="on"</c:if>>${i.MENU_NM }</a></li>
		            								</c:if>
		            							</c:when>
		            							<c:otherwise>
		            								<li><a href="#" onclick="move('${i.URL }'); return false;" <c:if test="${i.depth2nd == cMenu2ndDepth}">class="on"</c:if>>${i.MENU_NM }</a></li>
		            							</c:otherwise>
		            						</c:choose>
										</c:if>
									</c:forEach>
                				</ul>
                			</c:when>
                			<c:when test="${status.count == '3' }">
                				<c:forEach items="${menuList }" var="i" varStatus="status">
                					<c:if test="${i.LEVEL == '3' && i.depth1st == cMenu1stDepth && i.depth2nd == cMenu2ndDepth && i.depth3rd == cMenu3rdDepth}">
                						<a href="">${i.MENU_NM }</a>
                					</c:if>
                				</c:forEach>
                				<ul class="snb_depth2">
	                				<c:forEach items="${menuList }" var="i" varStatus="status">
										<c:if test="${i.LEVEL == '3' && i.depth1st == cMenu1stDepth && i.depth2nd == cMenu2ndDepth}">
											<li><a href="#" onclick="move('${i.URL }'); return false;"<c:if test="${i.depth3rd == cMenu3rdDepth}">class="on"</c:if>>${i.MENU_NM }</a></li>
										</c:if>
									</c:forEach>
                				</ul>
                			</c:when>
                		</c:choose>
                	</li>	
                </c:forEach>
            </ul>
        </div>
    </div>
    <!-- /sub menu -->
    </c:if>     
<!-- /header -->