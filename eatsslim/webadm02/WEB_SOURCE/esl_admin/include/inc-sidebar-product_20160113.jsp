<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>��ǰ����</h2>
			<%if(eslAdminMenu.indexOf("2")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="goods_list.jsp" class="bgtop_lnb">��ǰ��������</a></li>
				<li><a href="category_list.jsp">ī�װ�����</a></li>
				<li><a href="goods_set_list.jsp">�޴�����</a></li>
				<li>
					<a href="goods_group_list.jsp">��Ʈ�׷����</a>
					<ul>
						<li><a href="goods_group_list.jsp?sch_gubun1=01">�Ļ� ���̾�Ʈ</a></li>
						<li><a href="goods_group_list.jsp?sch_gubun1=02">���α׷� ���̾�Ʈ</a></li>
						<li><a href="goods_group_list.jsp?sch_gubun1=03">Ÿ�Ժ� ���̾�Ʈ</a></li>
					</ul>
				</li>
				<li><a href="category_schedule.jsp">�Ĵܰ���</a></li>
				<li><a href="holiday_list.jsp">�޹��ϰ���</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('�ش� �޴��� �������� �����ϴ�.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->
