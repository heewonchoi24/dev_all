<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
			<p class="welcome">
				<a href="http://192.1.5.171:8027/administrator/login.jsp" target="old_admin" style="color:#fff">- �������� �ٷΰ���</a><br />
				<a href="javascript:;" onclick="window.open('/intro/foodmonthplan.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=1013,height=600')" style="color:#fff">- �ս��� �Ĵܽ�����</a>
			</p>
			<p class="welcome"><strong><%=eslAdminName%></strong>���� �α������Դϴ�.</p>
			<p class="logout"><a href="../login_db.jsp?mode=<%=URLEncoder.encode("logout")%>"><img src="../images/common/layout/btn_logout.gif" alt="�α׾ƿ�" /></a></p>