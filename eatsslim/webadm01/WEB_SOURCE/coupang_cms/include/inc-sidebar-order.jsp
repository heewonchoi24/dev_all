<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

		<!-- sidebar -->
		<div id="sidebar">
			<div class="bgtop_sidebar"></div>
			<h2>�ֹ�����</h2>
			<%if(eslAdminMenu.indexOf("3")>=0){%>
			<!-- lnb -->
			<ul id="lnb">
				<li><a href="order_list.jsp" class="bgtop_lnb">�ֹ��󼼰���</a></li>
				<li>
					<a href="cancel_list.jsp">���/��ǰ����</a>
					<ul>
						<li><a href="cancel_list.jsp">��Ұ���</a></li>
						<li><a href="return_list.jsp">��ǰ����</a></li>
						<li><a href="exchange_list.jsp">��ȯ����</a></li>
					</ul>
				</li>
				<li><a href="order_refund_list.jsp">ȯ�Ҹ���Ʈ</a></li>
				<li><a href="javascript:;">������ �ֹ����</a></li>
				<li><a href="outmall_upload.jsp">�ܺθ����ε�</a></li>
			</ul>
			<!-- //lnb -->
			<%}else{
					out.println("<script language = 'javascript'>alert('�ش� �޴��� �������� �����ϴ�.');history.back()</script>");if(true)return;
				}%>
			<%@ include file="inc-login-info.jsp" %>
			<div class="bgbtm_sidebar"></div>
		</div>
		<!-- //sidebar -->
