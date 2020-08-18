<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>설정</h2>
			<%if(eslAdminMenu.indexOf("7")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="admin_list.jsp" class="bgtop_lnb">관리자설정</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('해당 메뉴의 사용권한이 없습니다.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->
