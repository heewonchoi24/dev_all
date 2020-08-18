<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>상품관리</h2>
			<%if(eslAdminMenu.indexOf("2")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="goods_list.jsp" class="bgtop_lnb">상품구성관리</a></li>
				<li><a href="category_list.jsp">카테고리관리</a></li>
				<li><a href="goods_set_list.jsp">메뉴관리</a></li>
				<li>
					<a href="goods_group_list.jsp">세트그룹관리</a>
					<ul>
						<li><a href="goods_group_list.jsp?sch_gubun1=01">식사 다이어트</a></li>
						<li><a href="goods_group_list.jsp?sch_gubun1=02">프로그램 다이어트</a></li>
						<li><a href="goods_group_list.jsp?sch_gubun1=03">타입별 다이어트</a></li>
					</ul>
				</li>
				<li><a href="category_schedule.jsp">식단관리</a></li>
				<li><a href="holiday_list.jsp">휴무일관리</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('해당 메뉴의 사용권한이 없습니다.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->
