<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>ȸ������</h2>
			<%if(eslAdminMenu.indexOf("1")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="member_list.jsp" class="bgtop_lnb">ȸ������Ʈ</a></li>

			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('�ش� �޴��� �������� �����ϴ�.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->