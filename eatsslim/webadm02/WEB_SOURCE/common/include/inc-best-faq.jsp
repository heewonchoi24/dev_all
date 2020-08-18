<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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