<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	pageContext.setAttribute("br", "<br/>");
	pageContext.setAttribute("cn", "\n");
%>
<page:applyDecorator name="mainTop" />
<page:applyDecorator name="mainHeader" />

<style> .t1.notice { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 350px; height: 20px; } ul#scheduleList { overflow-y: auto; height: 360px; } .lst-calendar-main { padding-left: 10px; padding-right: 10px; margin-top: 25px; } .lst-calendar-main li { padding-top: 20px; padding-bottom: 20px; } .lst-calendar-main .t1 { font-size: 15px; line-height: 20px; } .lst-calendar-main .data { margin-top: 10px; font-size: 15px; } .lst-notice-main .date { margin-bottom: 13px; }.lst-notice-main { margin-top: 30px; } .lst-notice-main li:first-child { border-top: none; }</style>

<script>

$(document).ready(function() {
	myLibryYN = '${sessionScope.userInfo.myLibryYN}';
	authorId = '${sessionScope.userInfo.authorId}';
	// 보건복지부와 기관담당자만 마이라이브러리 보이도록
	if(authorId == '1' || authorId == '2'){
		if (myLibryYN == "N"){
			mylibryUp();
		}
	}
	qestnarPopUp();
});

function mylibryUp(){
	layerPopupV2.open('/mylibry/mylibry.do', prdCallback);
}

function monthlySchedule(yyyymm) {

	pUrl = "/cmn/monthlySchedule.do";
	pParam = {};
	pParam.yyyyMM = yyyymm;

	$.ccmsvc
			.ajaxSyncRequestPost(
					pUrl,
					pParam,
					function(data, textStatus, jqXHR) {
						var html1 = '';
						var html2 = '';
						$
								.each(
										data.mainMonthlySchedule,
										function(i, valueObj) {
											if (i == 0) {
												if (valueObj.PRE_YM_SCHDUL_CNT == '0') {
													html1 += '<a href="#" onclick="alert(\'이전 일정이 없습니다.\'); return false;" class="prev"><i class="icon-ios-arrow-back"></i></a>';
													html1 += '<span class="date"><span class="y">'
															+ valueObj.CUR_YYYY
															+ '</span>.';
													html1 += '<span class="m">'
															+ valueObj.CUR_MM
															+ '</span></span>';
													html1 += '<a href="#" onclick="monthlySchedule(\''
															+ valueObj.NEXT_YM
															+ '\'); return false;" class="next"><i class="icon-ios-arrow-forward"></i></a>';
												} else if (valueObj.NEXT_YM_SCHDUL_CNT == '0') {
													html1 += '<a href="#" onclick="monthlySchedule(\''
															+ valueObj.PRE_YM
															+ '\'); return false;" class="prev"><i class="icon-ios-arrow-back"></i></a>';
													html1 += '<span class="date"><span class="y">'
															+ valueObj.CUR_YYYY
															+ '</span>.';
													html1 += '<span class="m">'
															+ valueObj.CUR_MM
															+ '</span></span>';
													html1 += '<a href="#" onclick="alert(\'다음 일정이 없습니다.\'); return false;" class="next"><i class="icon-ios-arrow-forward"></a>';
												} else {
													html1 += '<a href="#" onclick="monthlySchedule(\''
															+ valueObj.PRE_YM
															+ '\'); return false;" class="prev"><i class="icon-ios-arrow-back"></i></a>';
													html1 += '<span class="date"><span class="y">'
															+ valueObj.CUR_YYYY
															+ '</span>.';
													html1 += '<span class="m">'
															+ valueObj.CUR_MM
															+ '</span></span>';
													html1 += '<a href="#" onclick="monthlySchedule(\''
															+ valueObj.NEXT_YM
															+ '\'); return false;" class="next"><i class="icon-ios-arrow-forward"></i></a>';
												}

											}
											html2 += '<li>';
											if (valueObj.MNG_LEVEL_CD == 'ML01') {
												html2 += '<p class="categori"><span class="ico-txt green type1">관리수준진단</span></p>';
												html2 += '<p class="t1"><a href="'+ valueObj.LINK + '">'+valueObj.MNG_LEVEL_TITLE+'</a></p>';
												html2 += '<p class="data cal">'
														+ valueObj.MNG_LEVEL_BGNDE
														+ ' ~ '
														+ valueObj.MNG_LEVEL_ENDDE
														+ '</p>';
											} else if (valueObj.MNG_LEVEL_CD == 'ML02') {
												html2 += '<p class="categori"><span class="ico-txt green type2">관리수준현황조사</span></p>';
												html2 += '<p class="t1"><a href="'+ valueObj.LINK + '">'+valueObj.MNG_LEVEL_TITLE+'</a></p>';
												html2 += '<p class="data cal">'
														+ valueObj.MNG_LEVEL_BGNDE
														+ ' ~ '
														+ valueObj.MNG_LEVEL_ENDDE
														+ '</p>';
											} else if (valueObj.MNG_LEVEL_CD == 'ML03') {
												html2 += '<p class="categori"><span class="ico-txt green type3">서면점검</span></p>';
												html2 += '<p class="t1"><a href="'+ valueObj.LINK + '">'+valueObj.MNG_LEVEL_TITLE+'</a></p>';
												html2 += '<p class="data cal">'
														+ valueObj.MNG_LEVEL_BGNDE
														+ ' ~ '
														+ valueObj.MNG_LEVEL_ENDDE
														+ '</p>';
											}
											html2 += '</li>';
										})
						$(".pageing").html(html1);
						$("#scheduleList").html(html2);
					}, function(jqXHR, textStatus, errorThrown) {

					});
}


function qestnarPopUp() {
	var pUrl = "/main/qestnarList.do";
	var param = new Object();

	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus,
			jqXHR) {
		for ( var i in data.resultList) {
			$("#qestnarSeq").val(data.resultList[i].qestnarSeq);

			window.open("", "qestnarPopUp" + data.resultList[i].qestnarSeq,
					"width=800px, height=693px");

			$("#scheduleForm").attr("target",
					"qestnarPopUp" + data.resultList[i].qestnarSeq);
			$("#scheduleForm").attr("action", "/qestnar/qestnarPopUp.do");
			$("#scheduleForm").submit();
		}
	}, function(jqXHR, textStatus, errorThrown) {

	});
}
</script>

<form method="post" id="scheduleForm" name="scheduleForm" action="/qestnar/qestnarPopUp.do">
	<input name="mngLevelCd" id="mngLevelCd" type="hidden" value="" />
	<input name="yyyy" id="yyyy" type="hidden" value="" />
	<input name="qestnarSeq" id="qestnarSeq" type="hidden" value="" />
</form>

<section id="container" class="main">
	<div class="container_inner">
		<section id="spot" class="main">
			<h1 class="blind">메인 비주얼</h1>

			<div id="bxMain" class="bxSlide-main">
				
				<!-- 메인 비주얼1 -->
				<c:if test="${!empty mainVisualList}">
					<c:forEach var="i" items="${mainVisualList }" varStatus="status">
						<c:if test="${i.SEQ eq '1' and i.TITLE != '' and i.IMG_PATH != ''}">
							<div class="lst n1" data-num="0">
								<div class="bg" style="background-image: url(${i.IMG_PATH}/${i.IMG_NM});"></div>
								<div class="cont">
									<div class="inner">
										<div class="inr-c">
											<p class="t t1">${i.MODIFIER}</p>
											<p class="t t2">${i.TITLE}</p>
											<p class="t t3">${i.CONTENT}</p>
											<c:if test="${i.LINK != ''}" >
												<div class="btns">
													<a href="${i.LINK}" class="btn-ty1 icon-ios-arrow-right"><span>바로가기</span></a>
												</div>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:if>
				<!--// 메인 비주얼1 -->
	
				<!-- 메인 비주얼2 -->
				<div class="lst n2" data-num="1">
					<div class="bg" style="background-image: url(/resources/front/images/main/bg_spot2.jpg);"></div>
					<div class="cont">
						<div class="inner">
							<div class="inr-c">
		                        <div class="t t2">
		                          <p>${orderList.orderNo}년 개인정보 보호</p>
		                          <p>관리수준 진단 스케쥴</p>
		                        </div>
		                        <div class="wrap-step-type1">
		                          <div class="clearfix">
		                            <div class="step n1">
		                              <span class="circle"><span class="txt">예정</span></span>
		                              <div class="step_tit1">
		                                <p class="h1">실적등록 기간</p>
		                              </div>
		                            </div>
 		                            <div class="step n2">
		                              <span class="circle"><span class="txt">예정</span></span>
		                              <div class="step_tit1">
		                                <p class="h1">추가자료 제출</p>
		                              </div>
		                            </div>
		                            <div class="step n3">
		                              <span class="circle"><span class="txt">예정</span></span>
		                              <div class="step_tit1">
		                                <p class="h1">이의신청</p>
		                              </div>
		                            </div>
		                            <div class="step n4">
		                              <span class="circle"><span class="txt">예정</span></span>
		                              <div class="step_tit1">
		                                <p class="h1">개선조치 등록</p>
		                              </div>
		                            </div>
		                          </div>
		                          <div class="line"></div>
		                        </div>
							</div>
						</div>
					</div>
					<c:choose>
						<c:when test="${sessionScope.userInfo.authorId eq '2' and (('IC02' eq sessionScope.userInfo.insttClCd or 'IC03' eq sessionScope.userInfo.insttClCd) and fn:contains(orderList.periodCode, 'A'))}" >
							<script>
								$('.step.n1').addClass('on');
								$('.step.n1 span').addClass('c2');
								$('.step.n1 span span').text('진행중');
	                                                                                                                                         
								$('.step.n2 span').addClass('c3');
								$('.step.n3 span').addClass('c3');
								$('.step.n4 span').addClass('c3');
								
								$('.step.n2 span span').text('예정');
								$('.step.n3 span span').text('예정');
								$('.step.n4 span span').text('예정');						
							</script>
						</c:when>
						<c:when test="${sessionScope.userInfo.authorId eq '2' and (('IC01' eq sessionScope.userInfo.insttClCd or 'IC04' eq sessionScope.userInfo.insttClCd) and fn:contains(orderList.periodCode, 'H'))}" >	
							<script>
								$('.step.n1').addClass('on');
								$('.step.n1 span').addClass('c2');
								$('.step.n1 span span').text('진행중');
	                                                                                                                                         
								$('.step.n2 span').addClass('c3');
								$('.step.n3 span').addClass('c3');
								$('.step.n4 span').addClass('c3');
								
								$('.step.n2 span span').text('예정');
								$('.step.n3 span span').text('예정');
								$('.step.n4 span span').text('예정');						
							</script>
						</c:when>
						<c:when test="${fn:contains(orderList.periodCode, 'A') || fn:contains(orderList.periodCode, 'H')}">
							<script>
								$('.step.n1').addClass('on');
								$('.step.n1 span').addClass('c2');
								$('.step.n1 span span').text('진행중');
	                                                                                                                                         
								$('.step.n2 span').addClass('c3');
								$('.step.n3 span').addClass('c3');
								$('.step.n4 span').addClass('c3');
								
								$('.step.n2 span span').text('예정');
								$('.step.n3 span span').text('예정');
								$('.step.n4 span span').text('예정');						
							</script>
						</c:when>					
						<c:when test="${fn:contains(orderList.periodCode, 'Y')}"> 
							<script>
								$('.step.n2').addClass('on');
								$('.step.n2 span').addClass('c2');
								$('.step.n2 span span').text('진행중');
	                                                                                                                                         
								$('.step.n1 span').addClass('c1');
								$('.step.n3 span').addClass('c3');
								$('.step.n4 span').addClass('c3');
								
								$('.step.n1 span span').text('완료');
								$('.step.n3 span span').text('예정');
								$('.step.n4 span span').text('예정');								
							</script>
						</c:when>		
						<c:when test="${fn:contains(orderList.periodCode, 'C')}"> 
							<script>
								$('.step.n3').addClass('on');
								$('.step.n3 span').addClass('c2');
								$('.step.n3 span span').text('진행중');
	                                                                                                                                         
								$('.step.n1 span').addClass('c1');
								$('.step.n2 span').addClass('c1');
								$('.step.n4 span').addClass('c3');
								
								$('.step.n1 span span').text('완료');
								$('.step.n2 span span').text('완료');
								$('.step.n4 span span').text('예정');								
							</script>
						</c:when>		
						<c:when test="${fn:contains(orderList.periodCode, 'D')}"> 
							<script>
								$('.step.n4').addClass('on');
								$('.step.n4 span').addClass('c2');
								$('.step.n4 span span').text('진행중');
	                                                                                                                                         
								$('.step.n1 span').addClass('c1');
								$('.step.n2 span').addClass('c1');
								$('.step.n3 span').addClass('c1');
								
								$('.step.n1 span span').text('완료');
								$('.step.n2 span span').text('완료');
								$('.step.n3 span span').text('완료');							
							</script>
						</c:when>	
						<c:when test="${fn:contains(orderList.periodCode, 'E')}"> 
							<script>
								$('.step.n1 span').addClass('c3');
								$('.step.n2 span').addClass('c3');
								$('.step.n3 span').addClass('c3');
								$('.step.n4 span').addClass('c3');							
								
								$('.step.n1 span span').text('예정');
								$('.step.n2 span span').text('예정');
								$('.step.n3 span span').text('예정');	
								$('.step.n4 span span').text('예정');
							</script>
						</c:when>	
						<c:when test="${fn:contains(orderList.periodCode, 'F')}"> 
							<script>
								$('.step.n1 span').addClass('c1');
								$('.step.n2 span').addClass('c1');
								$('.step.n3 span').addClass('c1');
								$('.step.n4 span').addClass('c1');							
								
								$('.step.n1 span span').text('완료');
								$('.step.n2 span span').text('완료');
								$('.step.n3 span span').text('완료');	
								$('.step.n4 span span').text('완료');						
							</script>
						</c:when>									
					</c:choose>
				</div>
				<!--// 메인 비주얼2 -->
				
				<!-- 메인 비주얼3 -->
				<c:if test="${!empty mainVisualList}">
					<c:forEach var="i" items="${mainVisualList }" varStatus="status">
						<c:if test="${i.SEQ eq '3' and i.TITLE != '' and i.IMG_PATH != ''}">
							<div class="lst n3" data-num="2">
								<div class="bg" style="background-image: url(${i.IMG_PATH}/${i.IMG_NM});"></div>
								<div class="cont">
									<div class="inner">
										<div class="inr-c">
											<p class="t t1">${i.MODIFIER}</p>
											<p class="t t2">${i.TITLE}</p>
											<p class="t t3">${i.CONTENT}</p>
											<c:if test="${i.LINK != ''}" >
												<div class="btns">
													<a href="${i.LINK}" class="btn-ty1 icon-ios-arrow-right"><span>바로가기</span></a>
												</div>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:if>
				<!--// 메인 비주얼3 -->					

			</div>
			<div class="area-banner inr-c">
				
			</div>
			<button class="bx-play"><i class="icon-pause2"></i></button>
		</section>
		<!-- //spot -->

		<section class="main-page banner">
			<div class="inr-c clearfix">
			
			</div>
		</section>

	</div>
	<!-- //container_inner -->
</section>
<!-- //container_main -->

<!-- 주요일정 -->	
<div id="calendar" hidden>
	<div class="banner-main calendar ty1" >
		<div class="inner">
			<div class="area_head">
				<h1>주요일정</h1>
				<c:forEach var="i" items="${mainMonthlySchedule}" varStatus="status">
					<c:if test="${status.first }">
						<div class="pageing">
							<c:choose>
								<c:when test="${i.PRE_YM_SCHDUL_CNT == '0' }">
									<a href="#" onclick="alert('이전 일정이 없습니다.'); return false;"
										class="prev"><i class="icon-ios-arrow-back"></i></a>
									<span class="date"><span class="y">${i.CUR_YYYY }</span>.<span
										class="m">${i.CUR_MM }</span></span>
									<a href="#"
										onclick="monthlySchedule('${i.NEXT_YM}'); return false;"
										class="next"><i class="icon-ios-arrow-forward"></i></a>
								</c:when>
								<c:when test="${i.NEXT_YM_SCHDUL_CNT == '0' }">
									<a href="#"
										onclick="monthlySchedule('${i.PRE_YM}'); return false;"
										class="prev"><i class="icon-ios-arrow-back"></i></a>
									<span class="date"><span class="y">${i.CUR_YYYY }</span>.<span
										class="m">${i.CUR_MM }</span></span>
									<a href="#" onclick="alert('다음 일정이 없습니다.'); return false;"
										class="next"><i class="icon-ios-arrow-forward"></i></a>
								</c:when>
								<c:otherwise>
									<a href="#"
										onclick="monthlySchedule('${i.PRE_YM}'); return false;"
										class="prev"><i class="icon-ios-arrow-back"></i></a>
									<span class="date"><span class="y">${i.CUR_YYYY }</span>.<span
										class="m">${i.CUR_MM }</span></span>
									<a href="#"
										onclick="monthlySchedule('${i.NEXT_YM}'); return false;"
										class="next"><i class="icon-ios-arrow-forward"></i></a>
								</c:otherwise>
							</c:choose>
							<i class="icon-android-arrow-dropdown"></i>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="area_mid">
				<div class="lst-calendar-main schedule_content" id="content-d">
					<ul id="scheduleList">
						<c:forEach var="i" items="${mainMonthlySchedule }"
							varStatus="status">
							<li><c:choose>
									<c:when test="${i.MNG_LEVEL_CD == 'ML01' }">
										<p class="categori">
											<span class="ico-txt green type1">관리수준진단</span>
										</p>
										<p class="t1">
											<c:choose>
												<c:when test="${i.LINK != ''}">
													<a onclick="move('${i.LINK})" style="cursor: pointer;">${i.MNG_LEVEL_TITLE }</a>
												</c:when>
												<c:otherwise>
													${i.MNG_LEVEL_TITLE }
												</c:otherwise>
											</c:choose>
										</p>
										<p class="data cal">${i.MNG_LEVEL_BGNDE }~${i.MNG_LEVEL_ENDDE }</p>
									</c:when>
									<c:when test="${i.MNG_LEVEL_CD == 'ML02' }">
										<p class="categori">
											<span class="ico-txt green type2">관리수준현황조사</span>
										</p>
										<p class="t1">
											<c:choose>
												<c:when test="${i.LINK != ''}">
													<a onclick="move('${i.LINK}')" style="cursor: pointer;">${i.MNG_LEVEL_TITLE }</a>
												</c:when>
												<c:otherwise>
													${i.MNG_LEVEL_TITLE }
												</c:otherwise>
											</c:choose>
										</p>
										<p class="data cal">${i.MNG_LEVEL_BGNDE }~${i.MNG_LEVEL_ENDDE }</p>
									</c:when>
									<c:when test="${i.MNG_LEVEL_CD == 'ML03' }">
										<p class="categori">
											<span class="ico-txt green type3">서면점검</span>
										</p>
										<p class="t1">
											<c:choose>
												<c:when test="${i.LINK != ''}">
													<a onclick="move('${i.LINK}')" style="cursor: pointer;">${i.MNG_LEVEL_TITLE }</a>
												</c:when>
												<c:otherwise>
													${i.MNG_LEVEL_TITLE }
												</c:otherwise>
											</c:choose>
										</p>
										<p class="data cal">${i.MNG_LEVEL_BGNDE }~${i.MNG_LEVEL_ENDDE }</p>
									</c:when>
								</c:choose></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<script src="/js/jquery.mCustomScrollbar.concat.min.js"></script>
			<script>
				(function($) {
					$(window)
							.on(
									"load",
									function() {
		
										$.mCustomScrollbar.defaults.scrollButtons.enable = true; //enable scrolling buttons by default
										$.mCustomScrollbar.defaults.axis = "yx"; //enable 2 axis scrollbars by default
		
										$("#content-d").mCustomScrollbar({
											theme : "dark"
										});
		
										$(".all-themes-switch a")
												.click(
														function(e) {
															e.preventDefault();
															var $this = $(this), rel = $this
																	.attr("rel"), el = $(".schedule_content");
															switch (rel) {
															case "toggle-content":
																el
																		.toggleClass("expanded-content");
																break;
															}
														}
												);
		
									});
				})(jQuery);
			</script>	
		</div>
	</div>
</div>

<!-- 공지사항 -->
<div id="notice" hidden>
	<div class="banner-main notice ty1" >
		<div class="inner">
			<div class="area_head" style="margin-bottom: 0px">
				<h1>공지사항</h1>
			</div>
			<div class="area_mid">
				<div class="lst-notice-main">
					<ul>
						<c:forEach var="i" items="${mainBbsNoticeList }" varStatus="status">
							<li>
								<p class="date">${i.REGIST_DT}</p>
								<p class="t1 notice">
									<a href="#" onclick="viewThread('/bbs/bbsView.do?bbsCd=BN01', '${i.SEQ }', '20'); return false;">
										<c:if test="${i.HEAD_CATEGORY_TEXT != '' }">[${i.HEAD_CATEGORY_TEXT }] </c:if>${i.SUBJECT}
									</a>
								</p> 
								<c:if test="${i.ATCHMNFL_ID != ''}">
									<p class="file">
										<i class="icon-paper-clip"></i>${i.FILE_COUNT}
									</p>
								</c:if>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<a href="#" onclick="move('/bbs/bbsList.do?bbsCd=BN01'); return false;" class="more"><i class="icon-ios-plus-empty"></i><span class="blind">더보기</span></a>
		</div>
	</div>
</div>

<!-- 자료실 -->
<div id="dataroom" hidden>
	<div class="banner-main dataroom ty1">
		<div class="inner">
			<div class="area_head">
				<h1>자료실</h1>
			</div>
			<div class="area_mid">
		
				<div class="lst-dataroom-main">
					<ul>
						<c:forEach var="i" items="${mainBbsResourceList }" varStatus="status">
							<li>
								<div class="thumb">
									<a href="#top" onclick="viewThread('/bbs/bbsView.do?bbsCd=BN04', '${i.SEQ }', '23'); return false;" return false;">
										<c:forEach var="x" items="${bbsImg}" varStatus="status">
											<c:if test="${(x.BBS_SEQ == i.SEQ && i.IMG_NM == x.IMG_NM)}">
												<c:choose>
													<c:when test="${x.USE_YN == 'Y'}">
															<img src="${x.IMG_PATH}${x.IMG_NM}" style="width: 123px; height: 158px;">
													</c:when>
													<c:otherwise>
														<img src="/resources/admin/images/board/list_img_1.jpg" style="width: 123px; height: 158px;">
													</c:otherwise>
												</c:choose>
											</c:if>
										</c:forEach>
									</a>
								</div>
								<div class="cont">
									<p class="categori">${i.CATEGORY }</p>
									<p class="t1">
										<a href="#" onclick="viewThread('/bbs/bbsView.do?bbsCd=BN04', '${i.SEQ }', '23'); return false;" return false;">${i.SUBJECT }</a>
									</p>
									<p class="data">${i.REGIST_DT }</p>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<a href="#"onclick="move('/bbs/bbsList.do?bbsCd=BN04'); return false;" class="more"><i class="icon-ios-plus-empty"></i><span class="blind">더보기</span></a>
		</div>
	</div>
</div>

<!-- 개인정보 언론동향 -->
<div id="media" hidden>
	<div class="banner-main media ty1">
		<div class="inner">
			<div class="area_head">
				<h1>개인정보 언론동향</h1>
			</div>
			<div class="area_mid">
		
				<div class="lst-notice2-main">
					<ul>
						<c:forEach var="i" items="${mainBbsIndvdlLawList }"
							varStatus="status">
							<li><c:choose>
									<c:when test="${i.BBS_CD == 'BN05' }">
										<p class="t1">
											<span class="dot">-</span><a href="#" onclick="viewThread('/bbs/bbsView.do?bbsCd=BN05', '${i.SEQ }', '24'); return false;">${i.SUBJECT }</a>
										</p>
										<p class="t2 clearfix">
											<span class="col categori">${i.SOURCE}</span>
											<span class="col date">${i.REGIST_DT}</span>
										</p>
									</c:when>
								</c:choose></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<a href="#" onclick="move('/bbs/bbsList.do?bbsCd=BN05'); return false;" class="more"><i class="icon-ios-plus-empty"></i><span class="blind">더보기</span></a>
		</div>
	</div>
</div>

<c:if test="${!empty sortResultList}"> 
	<script>
	var html1 = '';
	var html2 = '';
	var bannerPosition1 = '';
	var bannerPosition2 = '';
	var sort = 0;
	</script>
	<c:forEach var="i" items="${sortResultList }" varStatus="status">
		<script>
		var seq  = "<c:out value="${i.SEQ}"/>";
		var title  = "<c:out value="${i.TITLE}"/>";

		switch(seq){
			case "1": 
				bannerPosition1 = ".area-banner.inr-c";
				sort = 1;
				break;
			case "2" || "3" || "4":
				bannerPosition2 = ".inr-c.clearfix";
				sort = 0;
				break;
		}	
		
		if(sort == 1){
			switch(title){
				case "주요일정": 
					$(bannerPosition1).html($("#calendar").html());
					break;
					
				case "공지사항":
					$(bannerPosition1).html($("#notice").html());
					break;
					
				case "자료실":
					$(bannerPosition1).html($("#dataroom").html());
					break;
					
				case "개인정보 언론동향":
					$(bannerPosition1).html($("#media").html());
					break;
			}
			
		}else {
			switch(title){
				case "주요일정": 
					html2 += $("#calendar").html();
					break;
					
				case "공지사항":
					html2 += $("#notice").html();
					break;
					
				case "자료실":
					html2 += $("#dataroom").html();
					break;
					
				case "개인정보 언론동향":
					html2 +=  $("#media").html();
					break;
			}
			
		}
		
		</script>										 
	</c:forEach>
	<script>
	$(bannerPosition2).html(html2);
	</script>
</c:if>

<link rel="stylesheet" href="/resources/front/css/jquery.bxslider.css" />
<script src="/resources/front/js/jquery.bxslider.min.js"></script>
<script src="/resources/front/js/main.js"></script>

<article id="banner-partners">
    <div class="inr-c clearfix">

      <div class="wrap_btns clearfix">
        <button class="prev">
          <span class="blind">이전</span>
          <i class="icon-ios-arrow-left"></i>
        </button>
        <button class="btn_bxplay ty2">
          <span class="blind">재생</span>
          <i class="play icon-arrow-right-b"></i>
          <i class="icon-ios-pause stop"></i>
        </button>
        <button class="next">
          <span class="blind">다음</span>
          <i class="icon-ios-arrow-right"></i>
        </button>
      </div>
      <div id="carousel_main" class="bx_ticker owl-carousel owl-theme">
          <div class="item"><a href="http://www.mohw.go.kr" ><img src="/resources/front/images/tmp/img_partners1.jpg" alt="보건복지부"></a></div>
          <div class="item"><a href="http://www.ssis.or.kr" ><img src="/resources/front/images/tmp/img_partners2.jpg" alt="SSIS 사회보장정보원"></a></div>
          <div class="item"><a href="http://www.mois.go.kr" ><img src="/resources/front/images/tmp/img_partners3.jpg" alt="행안안전부"></a></div>
          <div class="item"><a href="http://www.kisa.or.kr" ><img src="/resources/front/images/tmp/img_partners4.jpg" alt="한국인터넷진흥원"></a></div>
          <div class="item"><a href="http://www.kisa.or.kr" ><img src="/resources/front/images/tmp/img_partners5.jpg" alt="보건복지부 보건복지상담센터"></a></div>
      </div>
    </div>
</article>

<!-- 메인 팝업 -->
<c:if test="${not empty popupList}">
	<c:forEach var="i" items="${popupList }" varStatus="status">
		<c:set var="cnt" value="${i.OPEN_YN_CNT}" />
	</c:forEach>
	<c:if test="${cnt > 0 }" >
		<section id="popupMain">
		    <div class="popup_main s1">
		      <div class="warp_cont">
		        <button class="prev">
		          <span class="blind">이전</span>
		          <i class="icon-ios-arrow-left"></i>
		        </button>
		        <button class="next">
		          <span class="blind">다음</span>
		          <i class="icon-ios-arrow-right"></i>
		        </button>
		        <div class="owl-carousel popup">
		        	<c:forEach var="i" items="${popupList }" varStatus="status">
		        		<c:if test="${i.OPEN_YN == 'Y'}">
		        			<c:if test="${i.POP_TYPE == '1'}">
					          <div class="item">
					            <div class="wrap-pop-ty1">
					              <header class="head">
					                <div class="logo">
					                  <img src="${i.ICON_IMG_PATH}${i.ICON_IMG_NM}" alt="">
					                </div>
					                <div class="cont">
					                  <div class="inner">
					                    <p>${i.TITLE}</p>
					                  </div>
					                </div>
					              </header>
					              <div class="type-text">
					              	<a href="${i.LINK }"><p>${i.CONTENT}</p></a>
					              </div>
					              <a href="${i.LINK }">
						              <div class="img">
						                <img src="${i.MAIN1_IMG_PATH}${i.MAIN1_IMG_NM}" alt="" style="width: 100%">
						              </div>	
					              </a>
					            </div>
					          </div>	
					         </c:if>
		        			<c:if test="${i.POP_TYPE == '2'}">
					          <div class="item">
					            <div class="wrap-pop-ty1">
					              <header class="head">
					                <div class="logo">
					                  <img src="${i.ICON_IMG_PATH}${i.ICON_IMG_NM}" alt="" style="width: 100%">
					                </div>
					                <div class="cont">
					                  <div class="inner">
					                    <p>${i.TITLE}</p>
					                  </div>
					                </div>
					              </header>
					              <div class="type-text">
					              	<a href="${i.LINK }"><p>${i.CONTENT}</p></a>
					              </div>
					            </div>
					          </div>	
					         </c:if>		
					         <c:if test="${i.POP_TYPE == '3'}">
					          <div class="item">
					          	 <a href="${i.LINK }">
					              <div class="img">
					                <img src="${i.MAIN2_IMG_PATH}${i.MAIN2_IMG_NM}" alt="">
					              </div>	
					             </a>
					             </div>
					         </c:if>	
				        </c:if>
			        </c:forEach>
			  	</div>
		      </div>
		      <div class="pageing">
		      <!-- <span class="page">1</span> / <span class="items">3</span> -->
		      </div>
		      <div class="bot">
		        <div class="left">
		          <input type="checkbox" class="ickjs" id="mpop1">
		          <label for="mpop1">오늘 하루 열지 않음</label>
		        </div>
		        <div class="right">
		          <button popup-name="popup_1" class="b-close">닫기</button>
		        </div>
		      </div>
		    </div>
		</section>
	</c:if> 	
</c:if>

<!-- //메인 팝업 -->

<script type="text/javascript">

$(function(){

    var owlPartnersConfig = {
        items:5,
        loop:true,
        margin:5,
        autoplay:true,
        autoplayTimeout:3000,
        autoplayHoverPause:false
    };

  var owlPartners = $('.bx_ticker').owlCarousel(owlPartnersConfig);

  $('#banner-partners button').on('click',function(e){
      var $this = $(this)
      if($this.hasClass("prev")){
          owlPartners.trigger('prev.owl.carousel');
      }else if($this.hasClass("next")){
        owlPartners.trigger('next.owl.carousel');
      }
  });

  $("#banner-partners .btn_bxplay").on("click",function(){
       if(!$(this).hasClass("on")){
          owlPartners.trigger('stop.owl.autoplay');
          $(this).addClass("on");
          $(this).find(".blind").text("재생");
       }else{
          owlPartners.trigger('play.owl.autoplay');
          $(this).removeClass("on");
          $(this).find(".blind").text("정지");
       };
  });

    var owlPopupConfig = {
        items:1,
        loop:false,
        margin:0,
        autoplay:true,
        autoplayTimeout:3000,
        autoHeight:true,
        autoplayHoverPause:false
    };
    
    
    if( $("#popupMain .item").length == 1 ){
       	$("#popupMain .prev, #popupMain .next, #popupMain .pageing").css("display", "none");
    }

    var owlPopups = $('.owl-carousel.popup').owlCarousel(owlPopupConfig);

    owlPopups.on('initialize.owl.carousel', function(event) {

    }).on('initialize.owl.carousel, changed.owl.carousel', function(event) {
      popup_pageing(event);
    });

    function popup_pageing(event){
       // Provided by the core
      var element   = event.target;         // DOM element, in this example .owl-carousel
      var name      = event.type;           // Name of the event, in this example dragged
      var namespace = event.namespace;      // Namespace of the event, in this example owl.carousel
      var items     = event.item.count;     // Number of items
      var item      = event.item.index;     // Position of the current item
      // Provided by the navigation plugin
      var pages     = event.page.count;     // Number of pages
      var page      = event.page.index;     // Position of the current page
      var size      = event.page.size;      // Number of items per page

      var $txt_page = $('#popupMain').find(".pageing .page");
      var $txt_items = $('#popupMain').find(".pageing .items");

      $txt_page.text(page + 1);
      $txt_items.text(items);
    }

      $('.popup_main button').on('click',function(e){
          var $this = $(this)
          if($this.hasClass("prev")){
              owlPopups.trigger('prev.owl.carousel');
          }else if($this.hasClass("next")){
            owlPopups.trigger('next.owl.carousel');
          }
      });

      $('.popup_main .ickjs').iCheck({
        checkboxClass: 'icheckbox_square',
        radioClass: 'iradio_square'
      });



  setTimeout(function(){
    var popup_name = "popup-name1";
    
    if(getCookie(popup_name) != "no"){
    	
        $("#popupMain").css("display","block");

        $("#popupMain").bPopup({
            closeClass : "b-close",
             modalColor: '#001d4b',
            //positionStyle : "absolute",
            //follow: [true, false], //x, y
            //position : ['auto','auto'],
            //modalClose :false,
            onOpen: function(){
              //bodyScrollLock.disableBodyScroll(document.querySelector("#popupMain"));

            },
            onClose: function(){
                bodyScrollLock.enableBodyScroll(document.querySelector("#popupMain"));
            }
            //modalClose : false
          });
    }else{
    	
    	 $("#popupMain").css("display","none");
    }

    $("#popupMain .popup_main .bot .right button").on("click",function(){
        var todayHide  = $(this).closest(".bot").find(":checkbox").is(":checked");
        if (todayHide) setCookie(popup_name, "no", 1);
    });

    $("#popupMain .left label ,#popupMain .left .iCheck-helper").on("click",function(){
        $("#popupMain .popup_main .bot .right button").trigger("click");
    });



   },600);

});

</script>

<page:applyDecorator name="mainFooter" />
<page:applyDecorator name="mainBot" />
