<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
			<p class="welcome">
				<a href="http://192.1.5.171:8027/administrator/login.jsp" target="old_admin" style="color:#fff">- 구관리자 바로가기</a><br />
				<a href="javascript:;" onclick="window.open('/intro/foodmonthplan.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=1013,height=600')" style="color:#fff">- 잇슬림 식단스케줄</a>
			</p>
			<p class="welcome"><strong><%=eslAdminName%></strong>님은 로그인중입니다.</p>
			<p class="logout"><a href="../login_db.jsp?mode=<%=URLEncoder.encode("logout")%>"><img src="../images/common/layout/btn_logout.gif" alt="로그아웃" /></a></p>