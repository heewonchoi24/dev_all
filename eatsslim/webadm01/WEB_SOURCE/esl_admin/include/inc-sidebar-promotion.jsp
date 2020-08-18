<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>프로모션관리</h2>
			<%if(eslAdminMenu.indexOf("6")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="coupon_list.jsp" class="bgtop_lnb">쿠폰관리</a></li>				
				<li><a href="event_list.jsp">이벤트</a></li>
				<li><a href="event_join_list.jsp">이벤트참여현황</a></li>
				<li><a href="event_versus.jsp">최과장VS이대리</a></li>
				<li><a href="diary_list.jsp">다이어트 일기</a></li>
				<li><a href="week_comment_list.jsp">전문가 주간 코멘트</a></li>
				<li><a href="event_observe.jsp">밀착감시</a></li>
				<li><a href="choi_post_list.jsp">최과장이 쏘는<br />잇슬림 체험후기</a></li>
				<li><a href="sale_list.jsp">정율할인</a></li>
				<li><a href="event_housewife.jsp">주부 다이어트 대결</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('해당 메뉴의 사용권한이 없습니다.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->
