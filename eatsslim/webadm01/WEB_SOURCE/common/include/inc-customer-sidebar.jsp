<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
		<div class="sidebar four columns">
			<p><a href="/customer/service_member.jsp"><img src="../images/side_banner_01.jpg" alt="잇슬림 한눈에 알아보기" width="242" height="211" /></a></p>
	  <div class="bestfaq">
				<h3>자주하는 질문</h3>
				<ul>
					<%
					query		= "SELECT ID, TITLE FROM ESL_FAQ ORDER BY HIT_CNT DESC LIMIT 0, 5";
					pstmt		= conn.prepareStatement(query);
					rs			= pstmt.executeQuery();

					while (rs.next()) {
					%>
					<li><a href="faq.jsp?id=<%=rs.getInt("ID")%>"><%=ut.cutString(50, rs.getString("TITLE"), "..")%></a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>