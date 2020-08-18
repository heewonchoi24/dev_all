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

<section id="spot-sub" class="dmp-parallax sub${cMenu1stDepth}">
	<div class="thumb">
      <div class="inner">
        <h1>${cMenuName}</h1>
      </div>
    </div>
	<div class="rtitle">
        <h1 class="blind">${cMenuName}의 서브메뉴</h1>
        <nav class="lst n${cMenu1stDepth}">
            <ul>
            	<c:forEach items="${menuList }" var="i" varStatus="status">
            		<c:if test="${i.LEVEL == '2' && i.depth1st == cMenu1stDepth}">
            			<c:choose>
   							<c:when test="${'56' eq i.MENU_ID}"><!-- 기초현황 -->
   								<c:if test="${'Y' eq i.authRead}">
   									<li class="n${i.depth2nd}"><a href="#" onclick="move('${i.URL}'); return false;">${i.MENU_NM}</a></li>
   								</c:if>
   							</c:when>	
   							<c:when test="${'9' eq i.MENU_ID}"><!-- 실적등록 및 조회 -->
   								<!-- 보건복지부 권한이거나, 실적등록 기간인 경우 -->
   								<c:if test="${'Y' eq i.authRead and ('1' eq sessionScope.userInfo.authorId or ('5' eq sessionScope.userInfo.authorId and ( fn:contains(headerPeriodCd, 'A') or fn:contains(headerPeriodCd, 'H') ) ) or (('IC02' eq sessionScope.userInfo.insttClCd or 'IC03' eq sessionScope.userInfo.insttClCd) and fn:contains(headerPeriodCd, 'A')) or (('IC01' eq sessionScope.userInfo.insttClCd or 'IC04' eq sessionScope.userInfo.insttClCd) and fn:contains(headerPeriodCd, 'H')))}">
   									<li class="n${i.depth2nd}"><a href="#" onclick="move('${i.URL}')">${i.MENU_NM}</a></li>
   								</c:if>
   							</c:when>
   							<c:when test="${'10' eq i.MENU_ID}"><!-- 서면평가 -->		
   								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
   								<c:if test="${'Y' eq i.authRead and '2' ne sessionScope.userInfo.authorId and ('1' eq sessionScope.userInfo.authorId or 'B' eq headerPeriodCd or 'C' eq headerPeriodCd or 'D' eq headerPeriodCd)}">
   									<li class="n${i.depth2nd}"><a href="#" onclick="move('${i.URL}')">${i.MENU_NM}</a></li>
   								</c:if>
   							</c:when>
   							<c:when test="${'76' eq i.MENU_ID}"><!-- 이의신청 -->	
   								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
   								<c:if test="${'Y' eq i.authRead and '2' ne sessionScope.userInfo.authorId and ('1' eq sessionScope.userInfo.authorId or 'B' eq headerPeriodCd or 'C' eq headerPeriodCd or 'D' eq headerPeriodCd)}">
   									<li class="n${i.depth2nd}"><a href="#" onclick="move('${i.URL}')">${i.MENU_NM}</a></li>
   								</c:if>
   							</c:when>		
   							<c:when test="${'77' eq i.MENU_ID }"><!-- 중간점수/이의신청 -->		
   								<!-- 기관담당자 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
   								<c:if test="${'Y' eq i.authRead and ('2' eq sessionScope.userInfo.authorId and ('B' eq headerPeriodCd or 'C' eq headerPeriodCd or 'D' eq headerPeriodCd))}">
   									<li class="n${i.depth2nd}"><a href="#" onclick="move('${i.URL}')">${i.MENU_NM}</a></li>
   								</c:if>		            								
   							</c:when>		
   							<c:when test="${'11' eq i.MENU_ID }"><!-- 수준진단 결과 -->		
   								<!-- 기관담당자 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
   								<c:if test="${'Y' eq i.authRead}">
   									<li class="n${i.depth2nd}"><a href="#" onclick="move('${i.URL}');">${i.MENU_NM}</a></li>
   								</c:if>		            								
   							</c:when>	   							
   							<c:when test="${'12' eq i.MENU_ID}"><!-- 현장점검 등록 -->	
   								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
   								<c:if test="${'Y' eq i.authRead and ('1' eq sessionScope.userInfo.authorId or 'E' eq headerPeriodCd or 'F' eq headerPeriodCd or 'G' eq headerPeriodCd)}">
   									<li class="n${i.depth2nd}"><a href="#" onclick="move('${i.URL}')">${i.MENU_NM}</a></li>
   								</c:if>
   							</c:when>
   							<c:when test="${'13' eq i.MENU_ID}"><!-- 점검결과 조회 -->		
   								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
   								<c:if test="${'Y' eq i.authRead}">
   									<li class="n${i.depth2nd}"><a href="#" onclick="move('${i.URL}')">${i.MENU_NM}</a></li>
   								</c:if>
   							</c:when>					            							
   							<c:when test="${'14' eq i.MENU_ID or '15' eq i.MENU_ID}"><!-- 서면점검 실적등록 및 조회 / 우수사례 자료실 -->	
   								<c:if test="${'Y' eq i.authRead}">
   									<li class="n${i.depth2nd}"><a href="#" onclick="move('${i.URL}')">${i.MENU_NM}</a></li>
   								</c:if>
   							</c:when>
   							<c:otherwise>
   								<li class="n${i.depth2nd}"><a href="#" onclick="move('${i.URL}')">${i.MENU_NM}</a></li>
   							</c:otherwise>            			
						</c:choose>
            		</c:if>
            	</c:forEach>
            </ul>
        </nav>
    </div>
</section>
  <!-- //spot-sub -->
