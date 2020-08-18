<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title><decorator:title default="보건복지 개인정보보호 지원시스템"/></title>
<page:applyDecorator name="common" />
<decorator:head />
</head>
<body>
	<div id="wrap">
		<!-- 메뉴 건너띄기 -->
		<div id="skipnav">
		    <ul>
		        <li><a href="#container">본문 바로가기</a></li>
		        <li><a href="#gnb">주메뉴 바로가기</a></li>
		        <li><a href="#footer">하단 바로가기</a></li>
		    </ul>
		</div>
		<!-- /메뉴 건너띄기 -->
		<div id="header">
			<page:applyDecorator name="header" />
		</div>
			<decorator:body />
		<div id="footer">
			<page:applyDecorator name="footer" />
		</div>
		<div class="layer_bg"></div>
		
		<div class="all_menu_wrap">
	        <span class="title">사이트맵</span>
	        <button type="button" class="close">닫기</button>
	        <div class="menu_scroll">
	            <div>
	                <ul>
		                <c:forEach var="list" items="${menuList }"  varStatus="status">
							<c:if test="${'0' eq list.UPPER_MENU_ID}">
							<c:choose>
       							<c:when test="${'1' eq list.MENU_ID and '5' eq sessionScope.userInfo.authorId and !fn:contains(sessionScope.userInfo.userId, 'ds')}">
       							</c:when>
       							<c:otherwise>
       								<c:choose>
      									<c:when test="${'2' eq list.MENU_ID and '5' eq sessionScope.userInfo.authorId and !fn:contains(sessionScope.userInfo.userId, 'se')}">
      									</c:when>
      									<c:otherwise>
								<li>
				                    <dl>
				                        <dt>${list.MENU_NM }</dt>
				                        <c:forEach var="subList" items="${menuList }"  varStatus="status1">
				                        	<c:if test="${list.MENU_ID eq subList.UPPER_MENU_ID}">
				                        		<c:choose>
			            							<c:when test="${'9' eq subList.MENU_ID}">
			            								<!-- 보건복지부 권한이거나, 실적등록 기간인 경우 -->
			            								<c:if test="${'1' eq sessionScope.userInfo.authorId or ('5' eq sessionScope.userInfo.authorId and (fn:contains(headerPeriodCd, 'A') or fn:contains(headerPeriodCd, 'H'))) or (('IC02' eq sessionScope.userInfo.insttClCd or 'IC03' eq sessionScope.userInfo.insttClCd) and fn:contains(headerPeriodCd, 'A')) or (('IC01' eq sessionScope.userInfo.insttClCd or 'IC04' eq sessionScope.userInfo.insttClCd) and fn:contains(headerPeriodCd, 'H'))}">
			            									<dd><a href="#" onclick="move('${subList.URL}'); return false;">${subList.MENU_NM }</a></dd>
			            								</c:if>
			            							</c:when>
			            							<c:when test="${'10' eq subList.MENU_ID}">
			            								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
			            								<c:if test="${'1' eq sessionScope.userInfo.authorId or 'B' eq headerPeriodCd or 'C' eq headerPeriodCd or 'D' eq headerPeriodCd}">
			            									<dd><a href="#" onclick="move('${subList.URL}'); return false;">${subList.MENU_NM }</a></dd>
			            								</c:if>
			            							</c:when>
			            							<c:when test="${'12' eq subList.MENU_ID}">
			            								<!-- 보건복지부 권한이거나, 서면평가(중간), 이의신청, 서면평가(최종) 기간인 경우 -->
			            								<c:if test="${'1' eq sessionScope.userInfo.authorId or 'E' eq headerPeriodCd or 'F' eq headerPeriodCd or 'G' eq headerPeriodCd}">
			            									<dd><a href="#" onclick="move('${subList.URL}'); return false;">${subList.MENU_NM }</a></dd>
			            								</c:if>
			            							</c:when>
			            							<c:otherwise>
			            								<dd><a href="#" onclick="move('${subList.URL}'); return false;">${subList.MENU_NM }</a></dd>
			            							</c:otherwise>
			            						</c:choose>
				                        	</c:if>
				                        </c:forEach>
				                    </dl>
				                </li>
				                		</c:otherwise>
				                	</c:choose>
				                </c:otherwise>
				           	</c:choose>
							</c:if>
						</c:forEach>
	            	</ul>
	            </div>
	        </div>
    	</div>
	</div>
</body>
</html>