<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>�Խ��ǰ���</h2>
			<%if(eslAdminMenu.indexOf("4")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="notice_list.jsp" class="bgtop_lnb">��������</a></li>
				<li><a href="press_list.jsp">��к���</a></li>
				<li><a href="dc_list.jsp">GO���̾�Ʈ�÷�</a></li>
				<li><a href="po_list.jsp">���̾�Ʈü���ı�</a></li>
				<li><a href="popup_list.jsp">�˾�����</a></li>
				<li><a href="banner_list.jsp">��ʰ���</a></li>
				<li><a href="event_banner.jsp">������ʰ���</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('�ش� �޴��� �������� �����ϴ�.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->