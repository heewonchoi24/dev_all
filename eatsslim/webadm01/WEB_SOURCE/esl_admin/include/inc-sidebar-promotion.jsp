<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>���θ�ǰ���</h2>
			<%if(eslAdminMenu.indexOf("6")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="coupon_list.jsp" class="bgtop_lnb">��������</a></li>				
				<li><a href="event_list.jsp">�̺�Ʈ</a></li>
				<li><a href="event_join_list.jsp">�̺�Ʈ������Ȳ</a></li>
				<li><a href="event_versus.jsp">�ְ���VS�̴븮</a></li>
				<li><a href="diary_list.jsp">���̾�Ʈ �ϱ�</a></li>
				<li><a href="week_comment_list.jsp">������ �ְ� �ڸ�Ʈ</a></li>
				<li><a href="event_observe.jsp">��������</a></li>
				<li><a href="choi_post_list.jsp">�ְ����� ���<br />�ս��� ü���ı�</a></li>
				<li><a href="sale_list.jsp">��������</a></li>
				<li><a href="event_housewife.jsp">�ֺ� ���̾�Ʈ ���</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('�ش� �޴��� �������� �����ϴ�.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->
