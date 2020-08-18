<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>주문관리</h2>
			<%if(eslAdminMenu.indexOf("3")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="order_list.jsp" class="bgtop_lnb">주문상세관리</a></li>
				<li>
					<a href="cancel_list.jsp">취소/반품관리</a>
					<ul>
						<li><a href="cancel_list.jsp">취소관리</a></li>
						<li><a href="return_list.jsp">반품관리</a></li>
						<li><a href="exchange_list.jsp">교환관리</a></li>
					</ul>
				</li>
				<li><a href="order_refund_list.jsp">환불리스트</a></li>
				<li><a href="javascript:;">관리자 주문등록</a></li>
				<li><a href="outmall_upload.jsp">외부몰업로드</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('해당 메뉴의 사용권한이 없습니다.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->
