<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>게시판관리</h2>
			<%if(eslAdminMenu.indexOf("4")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="notice_list.jsp" class="bgtop_lnb">공지사항</a></li>
				<li><a href="press_list.jsp">언론보도</a></li>
				<li><a href="dc_list.jsp">GO다이어트컬럼</a></li>
				<li><a href="po_list.jsp">다이어트체험후기</a></li>
				<li><a href="popup_list.jsp">팝업관리</a></li>
				<li><a href="banner_list.jsp">배너관리</a></li>
				<li><a href="event_banner.jsp">고정배너관리</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('해당 메뉴의 사용권한이 없습니다.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->