<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>컨텐츠관리</h2>
			<%if(eslAdminMenu.indexOf("4")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="popup_list.jsp" class="bgtop_lnb">팝업관리</a></li>
				<li><a href="banner_main.jsp">메인배너 관리</a></li>
				<li><a href="banner_category.jsp">카테고리 배너 관리</a></li>
				<li><a href="recommend_list.jsp">잇슬림 추천제품</a></li>
				<li><a href="">잇슬림 제품 살펴보기</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('해당 메뉴의 사용권한이 없습니다.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->