<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
			<p class="welcome"><strong><%=cpAdminId%></strong>님은 로그인중입니다.</p>
			<p class="logout"><a href="../login_db.jsp?mode=<%=URLEncoder.encode("logout")%>"><img src="../images/common/layout/btn_logout.gif" alt="로그아웃" /></a></p>