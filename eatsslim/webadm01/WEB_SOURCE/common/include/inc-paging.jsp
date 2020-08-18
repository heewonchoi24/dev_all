<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
					<div class="pageNavi">
						<%if (iPage > 1) {%>
						<a class="latelypostslink" href="<%=request.getRequestURI()%>?page=1<%=param%>">&lt;&lt;</a>
						<%}%>
						<%if (startpage-pagelist >= 1) {%>
						<a class="previouspostslink" href="<%=request.getRequestURI()%>?page=<%=startpage-pagelist%><%=param%>">&lt;</a>
						<%}%>
						<%
						for (int i=startpage; i<=endpage; i++) {
							if (iPage == i) {
						%>
						<span class="current"><%=i%></span>
						<%
							} else {
						%>
						<a href="<%=request.getRequestURI()%>?page=<%=i%><%=param%>"><%=i%></a>
						<%
							}
						}
						%>
						<%if (startpage+pagelist <= totalPage){%>
						<a class="firstpostslink" href="<%=request.getRequestURI()%>?page=<%=startpage+pagelist%><%=param%>">&gt;</a>
						<%}%>
						<%if (totalPage > 1) {%>
						<a class="nextpostslink" href="<%=request.getRequestURI()%>?page=<%=totalPage%><%=param%>">&gt;&gt;</a>
						<%}%>
					</div>
