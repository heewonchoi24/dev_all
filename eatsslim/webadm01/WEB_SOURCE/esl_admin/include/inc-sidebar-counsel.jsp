<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>���/���ǰ���</h2>
			<%if(eslAdminMenu.indexOf("5")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="counsel_list.jsp">1:1 ����</a></li>
				<li><a href="faq_list.jsp">FAQ</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('�ش� �޴��� �������� �����ϴ�.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->