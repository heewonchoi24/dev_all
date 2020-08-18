<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<link rel="stylesheet" type="text/css" href="/css/main.css" media="all" />
<script src="/js/main.js" type="text/javascript"></script>
<title>보건복지 개인정보보호 지원시스템 &#124; 메인</title>
<script src="/js/jquery.bxslider.min.js" type="text/javascript"></script>
<script>
	var pUrl, pParam, msg;

	$(document).ready(function() {
		
		$(".org_list ul").bxSlider({
			maxSlides : 5,
			moveSlides : 1,
			slideWidth : 220,
			pager : false
		});
		qestnarPopUp();
		
	});

	function qestnarPopUp() {
		var pUrl = "/main/qestnarList.do";
		var param = new Object();

		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus,
				jqXHR) {
			for ( var i in data.resultList) {
				$("#qestnarSeq").val(data.resultList[i].qestnarSeq);
				var url = "/crossUploader/fileUploadPopUp.do";
				var varParam = "";
				var openParam = "height=693px, width=800px";

				window.open("", "qestnarPopUp" + data.resultList[i].qestnarSeq,
						openParam);

				$("#scheduleForm").attr("target",
						"qestnarPopUp" + data.resultList[i].qestnarSeq);
				$("#scheduleForm").attr("action", "/qestnar/qestnarPopUp.do");
				$("#scheduleForm").submit();
			}
		}, function(jqXHR, textStatus, errorThrown) {

		});
	}

	function yearSchedulePopUp(mngLevelCd, yyyy) {

		$("#mngLevelCd").val(mngLevelCd);
		$("#yyyy").val(yyyy);

		var url = "/crossUploader/fileUploadPopUp.do";
		var varParam = "";
		var openParam = "height=664px, width=700px";

		window.open("", "yearSchedulePopUp", openParam);

		$("#scheduleForm").attr("target", "yearSchedulePopUp");
		$("#scheduleForm").attr("action", "/main/yearSchedulePopUp.do");
		$("#scheduleForm").submit();

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
														html1 += '<a href="#" onclick="alert(\'이전 일정이 없습니다.\'); return false;" class="prev">이전달</a>';
														html1 += '<span class="num1">'
																+ valueObj.CUR_YYYY
																+ '</span>';
														html1 += '<span class="num2">'
																+ valueObj.CUR_MM
																+ '</span>';
														html1 += '<a href="#" onclick="monthlySchedule(\''
																+ valueObj.NEXT_YM
																+ '\'); return false;" class="next">다음달</a>';
													} else if (valueObj.NEXT_YM_SCHDUL_CNT == '0') {
														html1 += '<a href="#" onclick="monthlySchedule(\''
																+ valueObj.PRE_YM
																+ '\'); return false;" class="prev">이전달</a>';
														html1 += '<span class="num1">'
																+ valueObj.CUR_YYYY
																+ '</span>';
														html1 += '<span class="num2">'
																+ valueObj.CUR_MM
																+ '</span>';
														html1 += '<a href="#" onclick="alert(\'다음 일정이 없습니다.\'); return false;" class="next">다음달</a>';
													} else {
														html1 += '<a href="#" onclick="monthlySchedule(\''
																+ valueObj.PRE_YM
																+ '\'); return false;" class="prev">이전달</a>';
														html1 += '<span class="num1">'
																+ valueObj.CUR_YYYY
																+ '</span>';
														html1 += '<span class="num2">'
																+ valueObj.CUR_MM
																+ '</span>';
														html1 += '<a href="#" onclick="monthlySchedule(\''
																+ valueObj.NEXT_YM
																+ '\'); return false;" class="next">다음달</a>';
													}

												}
												html2 += '<li>';
												if (valueObj.MNG_LEVEL_CD == 'ML01') {
													html2 += '<span class="detail">관리수준진단</span>';
													html2 += '<span class="term">'
															+ valueObj.MNG_LEVEL_BGNDE
															+ ' ~ '
															+ valueObj.MNG_LEVEL_ENDDE
															+ '</span>';
													html2 += '<a href="#" onclick="yearSchedulePopUp('
															+ "'"
															+ valueObj.MNG_LEVEL_CD
															+ "','"
															+ valueObj.YYYY
															+ "'"
															+ ');"><span class="title">'
															+ valueObj.MNG_LEVEL_TITLE
															+ '</span></a>';
												} else if (valueObj.MNG_LEVEL_CD == 'ML02') {
													html2 += '<span class="detail type2">관리수준현황조사</span>';
													html2 += '<span class="term">'
															+ valueObj.MNG_LEVEL_BGNDE
															+ ' ~ '
															+ valueObj.MNG_LEVEL_ENDDE
															+ '</span>';
													html2 += '<a href="#" onclick="yearSchedulePopUp('
															+ "'"
															+ valueObj.MNG_LEVEL_CD
															+ "','"
															+ valueObj.YYYY
															+ "'"
															+ ');"><span class="title">'
															+ valueObj.MNG_LEVEL_TITLE
															+ '</span></a>';
												} else if (valueObj.MNG_LEVEL_CD == 'ML03') {
													html2 += '<span class="detail type3">서면점검</span>';
													html2 += '<span class="term">'
															+ valueObj.MNG_LEVEL_BGNDE
															+ ' ~ '
															+ valueObj.MNG_LEVEL_ENDDE
															+ '</span>';
													html2 += '<a href="#" onclick="yearSchedulePopUp('
															+ "'"
															+ valueObj.MNG_LEVEL_CD
															+ "','"
															+ valueObj.YYYY
															+ "'"
															+ ');"><span class="title">'
															+ valueObj.MNG_LEVEL_TITLE
															+ '</span></a>';
												}
												html2 += '</li>';
											})
							$(".date_wrap").html(html1);
							$("#scheduleList").html(html2);
						}, function(jqXHR, textStatus, errorThrown) {

						});
	}
</script>
</head>

<form method="post" id="scheduleForm" name="scheduleForm"
	action="/qestnar/qestnarPopUp.do">
	<input name="mngLevelCd" id="mngLevelCd" type="hidden" value="" /> <input
		name="yyyy" id="yyyy" type="hidden" value="" /> <input
		name="qestnarSeq" id="qestnarSeq" type="hidden" value="" />
</form>

<!-- content -->
<div class="main_wrap">
	<div class="section1">
		<div class="section1_1">
			<div class="main_banner">
				<div class="vi_control">
					<a href="#link" class="btn_play"><span>재생</span></a> <a
						href="#link" class="btn_stop"><span>멈춤</span></a>
				</div>
				<ul class="visual">
					<li class="bg1"><span>첫번째 배너</span></li>
					<li class="bg2"><span>두번째 배너</span></li>
					<li class="bg3"><span>세번째 배너</span></li>
				</ul>
			</div>
			<div class="schedule_wrap">
				<h2>
					<span>주요일정</span>
				</h2>
				<div class="schedule">
					<c:forEach var="i" items="${mainMonthlySchedule }"
						varStatus="status">
						<c:if test="${status.first }">
							<div class="date_wrap">
								<c:choose>
									<c:when test="${i.PRE_YM_SCHDUL_CNT == '0' }">
										<a href="#" onclick="alert('이전 일정이 없습니다.'); return false;"
											class="prev">이전달</a>
										<span class="num1">${i.CUR_YYYY }</span>
										<span class="num2">${i.CUR_MM }</span>
										<a href="#"
											onclick="monthlySchedule('${i.NEXT_YM}'); return false;"
											class="next">다음달</a>
									</c:when>
									<c:when test="${i.NEXT_YM_SCHDUL_CNT == '0' }">
										<a href="#"
											onclick="monthlySchedule('${i.PRE_YM}'); return false;"
											class="prev">이전달</a>
										<span class="num1">${i.CUR_YYYY }</span>
										<span class="num2">${i.CUR_MM }</span>
										<a href="#" onclick="alert('다음 일정이 없습니다.'); return false;"
											class="next">다음달</a>
									</c:when>
									<c:otherwise>
										<a href="#"
											onclick="monthlySchedule('${i.PRE_YM}'); return false;"
											class="prev">이전달</a>
										<span class="num1">${i.CUR_YYYY }</span>
										<span class="num2">${i.CUR_MM }</span>
										<a href="#"
											onclick="monthlySchedule('${i.NEXT_YM}'); return false;"
											class="next">다음달</a>
									</c:otherwise>
								</c:choose>
							</div>
						</c:if>
					</c:forEach>
					<div id="content-d" class="schedule_content content_scroll light">
						<div class="detail_wrap">
							<ul id="scheduleList">
								<c:forEach var="i" items="${mainMonthlySchedule }"
									varStatus="status">
									<li><c:choose>
											<c:when test="${i.MNG_LEVEL_CD == 'ML01' }">
												<span class="detail">관리수준진단</span>
												<span class="term">${i.MNG_LEVEL_BGNDE } ~
													${i.MNG_LEVEL_ENDDE }</span>
												<a href="#"
													onclick="yearSchedulePopUp('${i.MNG_LEVEL_CD}', '${i.YYYY}');"><span
													class="title">${i.MNG_LEVEL_TITLE }</span></a>
											</c:when>
											<c:when test="${i.MNG_LEVEL_CD == 'ML02' }">
												<span class="detail type2">관리수준현황조사</span>
												<span class="term">${i.MNG_LEVEL_BGNDE } ~
													${i.MNG_LEVEL_ENDDE }</span>
												<a href="#"
													onclick="yearSchedulePopUp('${i.MNG_LEVEL_CD}', '${i.YYYY}');"><span
													class="title">${i.MNG_LEVEL_TITLE }</span></a>
											</c:when>
											<c:when test="${i.MNG_LEVEL_CD == 'ML03' }">
												<span class="detail type3">서면점검</span>
												<span class="term">${i.MNG_LEVEL_BGNDE } ~
													${i.MNG_LEVEL_ENDDE }</span>
												<a href="#"
													onclick="yearSchedulePopUp('${i.MNG_LEVEL_CD}', '${i.YYYY}');"><span
													class="title">${i.MNG_LEVEL_TITLE }</span></a>
											</c:when>
										</c:choose></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
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
													});

								});
			})(jQuery);
		</script>
		<div class="section1_2">
			<div class="board_view">
				<h2>공지사항</h2>
				<a href="#" class="btn_more"
					onclick="move('/bbs/bbsList.do?bbsCd=BN01'); return false;">공지사항
					더보기</a>
				<ul>
					<c:forEach var="i" items="${mainBbsNoticeList }" varStatus="status">
						<li><a href="#"
							onclick="viewThread('/bbs/bbs', '${i.SEQ }', '${i.BBS_CD }'); return false;"><span
								class="tool_text" title="${i.SUBJECT }">${i.SUBJECT }</span></a> <c:if
								test="${i.ISNEW == 'Y' }">
								<span class="new">NEW</span>
							</c:if> <span class="date">${i.REGIST_DT }</span></li>
					</c:forEach>
				</ul>
			</div>
			<div class="board_view">
				<h2>자료실</h2>
				<a href="#" class="btn_more"
					onclick="move('/bbs/bbsList.do?bbsCd=BN04'); return false;">자료실
					더보기</a>
				<ul>
					<c:forEach var="i" items="${mainBbsResourceList }"
						varStatus="status">
						<li><a href="#"
							onclick="viewThread('/bbs/bbs', '${i.SEQ }', '${i.BBS_CD }'); return false;"><span
								class="tool_text" title="${i.SUBJECT }">${i.SUBJECT }</span></a> <c:if
								test="${i.ISNEW == 'Y' }">
								<span class="new">NEW</span>
							</c:if> <span class="date">${i.REGIST_DT }</span></li>
					</c:forEach>
				</ul>
			</div>
			<div class="board_view">
				<h2>개인정보 소식</h2>
				<ul>
					<c:forEach var="i" items="${mainBbsIndvdlLawList }"
						varStatus="status">
						<li><c:choose>
								<c:when test="${i.BBS_CD == 'BN05' }">
									<a href="#"
										onclick="viewThread('/bbs/bbs', '${i.SEQ }', '${i.BBS_CD }'); return false;"><span
										class="tool_text" title="${i.SUBJECT }">[동향]&nbsp;${i.SUBJECT }</span></a>
								</c:when>
								<c:when test="${i.BBS_CD == 'BN07' }">
									<a href="#"
										onclick="viewThread('/bbs/bbs', '${i.SEQ }', '${i.BBS_CD }'); return false;"><span
										class="tool_text" title="${i.SUBJECT }">[법령]&nbsp;${i.SUBJECT }</span></a>
								</c:when>
							</c:choose> <c:if test="${i.ISNEW == 'Y' }">
								<span class="new">NEW</span>
							</c:if> <span class="date">${i.REGIST_DT }</span></li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<div class="section2">
		<div class="section2_1">
			<div class="shortcut">
				<h2>
					<span>서면점검 우수사례</span>
					<c:if test="${'8' ne sessionScope.userInfo.authorId}">
						<a href="#"
							onclick="move('/bbs/bbsList.do?bbsCd=BN06'); return false;"
							class="btn_more">우수사례 더보기</a>
					</c:if>
				</h2>
				<span>서면점검 우수기관 자료를<br>확인하실 수 있습니다.
				</span>
			</div>
			<div class="inquiry">
				<h2>시스템 문의</h2>
				<div class="tel">
					<span>전화번호</span> <span> 02-6360-6575 </span>
				</div>
				<div class="time">
					<span>이메일</span> <span>privacy@ssis.or.kr</span>
				</div>
			</div>
			<div class="quick_btn">
				<ul>
					<li><a href="#"
						onclick="move('/bbs/bbsList.do?bbsCd=BN02'); return false;">자주하는
							질문</a></li>
					<li><a href="#"
						onclick="move('/user/certUpdate.do'); return false;">공인인증서 갱신</a></li>
					<li><a href="#"
						onclick="move('/bbs/bbsList.do?bbsCd=BN03'); return false;">질의응답</a></li>
					<li><a href="#"
						onclick="move('/user/passwordInfo.do'); return false;">비밀번호 변경</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="section3">
		<script src="../js/jquery.bxslider.min.js"></script>
		<script>
			$(function() {
				$(".org_list ul").bxSlider({
					// minSlides: 1,
					maxSlides : 5,
					moveSlides : 1,
					slideWidth : 220,
					pager : false
				});
			});
		</script>
		<div class="org_wrap">
			<div class="org_list">
				<ul>
					<li><a href="http://www.mohw.go.kr" target="_blank"
						title="보건복지부 사이트 새창열림"><img
							src="/images/content/org_banner01.gif" alt="보건복지부"></a></li>
					<li><a href="http://www.ssis.or.kr" target="_blank"
						title="사회보장정보원 사이트 새창열림"><img
							src="/images/content/org_banner02.gif" alt="사회보장정보원"></a></li>
					<li><a href="http://www.mois.go.kr" target="_blank"
						title="행정안전부 사이트 새창열림"><img
							src="/images/content/org_banner03.gif" alt="행정안전부"></a></li>
					<li><a href="http://www.kisa.or.kr" target="_blank"
						title="한국인터넷진흥원 사이트 새창열림"><img
							src="/images/content/org_banner04.gif" alt="한국인터넷진흥원"></a></li>
					<li><a href="http://intra.privacy.go.kr" target="_blank"
						title="개인정보보호종합지원시스템 사이트 새창열림"><img
							src="/images/content/org_banner05.gif" alt="개인정보보호종합지원시스템"></a></li>
					<li><a href="http://www.privacy.go.kr" target="_blank"
						title="개인정보보호 종합포털 사이트 새창열림"><img
							src="/images/content/org_banner06.gif" alt="개인정보보호종합지원시스템"></a></li>
					<li><a href="http://www.pipc.go.kr" target="_blank"
						title="개인정보보호 위원회 사이트 새창열림"><img
							src="/images/content/org_banner07.gif" alt="개인정보보호종합지원시스템"></a></li>
					<li><a href="http://www.kopico.go.kr" target="_blank"
						title="개인정보분쟁조정위원회 사이트 새창열림"><img
							src="/images/content/org_banner08.gif" alt="개인정보보호종합지원시스템"></a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- /content -->