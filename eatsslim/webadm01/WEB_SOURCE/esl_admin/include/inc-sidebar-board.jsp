<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>����������</h2>
			<%if(eslAdminMenu.indexOf("4")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="popup_list.jsp" class="bgtop_lnb">�˾�����</a></li>
				<li><a href="banner_main.jsp">���ι�� ����</a></li>
				<li><a href="banner_category.jsp">ī�װ� ��� ����</a></li>
				<li><a href="recommend_list.jsp">�ս��� ��õ��ǰ</a></li>
				<li><a href="">�ս��� ��ǰ ���캸��</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('�ش� �޴��� �������� �����ϴ�.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->