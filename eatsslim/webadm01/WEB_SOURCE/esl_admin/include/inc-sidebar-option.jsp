<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>����</h2>
			<%if(eslAdminMenu.indexOf("7")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="admin_list.jsp" class="bgtop_lnb">�����ڼ���</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('�ش� �޴��� �������� �����ϴ�.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->
