<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>회원관리</h2>
			<%if(eslAdminMenu.indexOf("1")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="member_list.jsp" class="bgtop_lnb">회원리스트</a></li>

			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('해당 메뉴의 사용권한이 없습니다.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->