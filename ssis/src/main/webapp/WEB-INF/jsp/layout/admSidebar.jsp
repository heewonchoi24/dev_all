<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- nav sidebar -->
<nav id="sidebar">
	<div class="menu on" data-level="1">
		<h2>ALL CATEGORIES</h2>
		<ul>
			<li class="ico_leftArrow">
				<a href="javascript:void(0);"><span>게시판 관리</span></a>
				<div class="menu <c:if test="${pageLevel1 eq 'board'}">on</c:if>" data-level="2">
					<h2>게시판 관리</h2>
					<a class="back" href="javascript:void(0);">뒤로가기</a>
					<ul>
						<li <c:if test="${pageLevel1 eq 'board' and pageLevel2 eq '1'}">class="active"</c:if>>
							<a href="/admin/notice/mngNoticeDtlList.do?bbsCd=BN01"><span>공지사항</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'board' and pageLevel2 eq '2'}">class="active"</c:if>>
							<a href="/admin/notice/mngNoticeDtlList.do?bbsCd=BN02"><span>자주하는 질문</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'board' and pageLevel2 eq '3'}">class="active"</c:if>>
							<a href="/admin/notice/mngNoticeDtlList.do?bbsCd=BN03"><span>질의응답</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'board' and pageLevel2 eq '4'}">class="active"</c:if>>
							<a href="/admin/notice/mngNoticeDtlList.do?bbsCd=BN04"><span>자료실</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'board' and pageLevel2 eq '5'}">class="active"</c:if>>
							<a href="/admin/notice/mngNoticeDtlList.do?bbsCd=BN05"><span>개인정보 언론동향</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'board' and pageLevel2 eq '6'}">class="active"</c:if>>
							<a href="/admin/notice/mngNoticeDtlList.do?bbsCd=BN06"><span>우수사례자료실</span></a>
						</li>
						<%-- <li <c:if test="${pageLevel1 eq 'board' and pageLevel2 eq '7'}">class="active"</c:if>>
							<a href="/admin/notice/mngNoticeDtlList.do?bbsCd=BN07"><span>개인정보법령</span></a>
						</li> --%>
					</ul>
				</div>
			</li>
			<li class="ico_leftArrow">
				<a href="javascript:void(0);"><span>계정 관리</span></a>
				<div class="menu <c:if test="${pageLevel1 eq 'account'}">on</c:if>" data-level="2">
					<h2>계정 관리</h2>
					<a class="back" href="javascript:void(0);">뒤로가기</a>
					<ul>
						<li <c:if test="${pageLevel1 eq 'account' and pageLevel2 eq '1'}">class="active"</c:if>>
							<a href="/admin/auth/authList.do"><span>권한 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'account' and pageLevel2 eq '2'}">class="active"</c:if>>
							<a href="/admin/user/userList.do"><span>사용자 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'account' and pageLevel2 eq '3'}">class="active"</c:if>>
							<a href="/admin/user/userCertificationList.do"><span>사용자 사전 등록 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'account' and pageLevel2 eq '4'}">class="active"</c:if>>
							<a href="/admin/org/orgList.do"><span>기관 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'account' and pageLevel2 eq '5'}">class="active"</c:if>>
							<a href="/admin/org/orgMrrblList.do"><span>기관 통폐합 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'account' and pageLevel2 eq '6'}">class="active"</c:if>>
							<a href="/admin/account/connectList.do"><span>접속 이력 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'account' and pageLevel2 eq '7'}">class="active"</c:if>>
							<a href="/admin/user/userInsctrList.do"><span>점검원 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'account' and pageLevel2 eq '8'}">class="active"</c:if>>
							<a href="/admin/system/fileSizeList.do"><span>파일 용량 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'account' and pageLevel2 eq '9'}">class="active"</c:if>>
							<a href="/admin/sms/smsPageList.do"><span>SMS 발송 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'account' and pageLevel2 eq '10'}">class="active"</c:if>>
							<a href="/admin/sms/smsLogList.do"><span>SMS 이력 관리</span></a>
						</li>
					</ul>
				</div>
			</li>
			<li class="ico_leftArrow">
				<a href="javascript:void(0);"><span>컨텐츠 관리</span></a>
				<div class="menu <c:if test="${pageLevel1 eq 'contact'}">on</c:if>" data-level="2">
					<h2>컨텐츠 관리</h2>
					<a class="back" href="javascript:void(0);">뒤로가기</a>
					<ul>
						<li <c:if test="${pageLevel1 eq 'contact' and pageLevel2 eq '1'}">class="active"</c:if>>
							<a href="/admin/contact/mainVisualList.do"><span>메인 비주얼 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'contact' and pageLevel2 eq '2'}">class="active"</c:if>>
							<a href="/admin/contact/mainContentsSortList.do"><span>메인 컨텐츠 순서</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'contact' and pageLevel2 eq '3'}">class="active"</c:if>>
							<a href="/admin/contact/popupList.do"><span>팝업 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'contact' and pageLevel2 eq '4'}">class="active"</c:if>>
							<a href="/admin/footer/footerPage.do"><span>푸터 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'contact' and pageLevel2 eq '5'}">class="active"</c:if>>
							<a href="/admin/menu/menuList.do"><span>메뉴 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'contact' and pageLevel2 eq '6'}">class="active"</c:if>>
							<a href="/admin/qestnar/qestnarList.do"><span>설문조사 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'contact' and pageLevel2 eq '7'}">class="active"</c:if>>
							<a href="/admin/contact/quickMenuList.do"><span>퀵메뉴 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'contact' and pageLevel2 eq '8'}">class="active"</c:if>>
							<a href="/admin/contact/dashboardSetting.do"><span>대시보드 속도관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'contact' and pageLevel2 eq '9'}">class="active"</c:if>>
							<a href="/admin/contact/dashboardSchedule.do"><span>대시보드 교육일정</span></a>
						</li>
					</ul>
				</div>
			</li>
			<li class="ico_leftArrow">
				<a href="javascript:void(0);"><span>진단 관리</span></a>
				<div class="menu <c:if test="${pageLevel1 eq 'diagnosis'}">on</c:if>" data-level="2">
					<h2>진단 관리</h2>
					<a class="back" href="javascript:void(0);">뒤로가기</a>
					<ul>
						<li <c:if test="${pageLevel1 eq 'diagnosis' and pageLevel2 eq '1'}">class="active"</c:if>>
							<a href="/admin/order/orderList.do"><span>차수 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'diagnosis' and pageLevel2 eq '2'}">class="active"</c:if>>
							<a href="/admin/order/fyerSchdulList.do"><span>일정 관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'diagnosis' and pageLevel2 eq '3'}">class="active"</c:if>>
							<a href="/admin/index/mngLevelIndexList.do"><span>관리수준 지표관리</span></a>
						</li>
						<li <c:if test="${pageLevel1 eq 'diagnosis' and pageLevel2 eq '4'}">class="active"</c:if>>
							<a href="/admin/index/statusExaminIndexList.do"><span>현황조사 지표관리</span></a>
						</li>
					</ul>
				</div>
			</li>
		</ul>
	</div>
</nav>
<!-- nav sidebar -->