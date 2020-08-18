					<div class="pageNavipr">
						<%if (iPage > 1) {%>	
						<a class="latelypostslink" href="javascript:;" onclick="getDiary(1, '<%=pageType%>')">&lt;&lt;</a>
						<%}%>
						<%if (startpage-pagelist >= 1) {%>
						<a class="previouspostslink" href="javascript:;" onclick="getDiary(<%=startpage-pagelist%>, '<%=pageType%>')">&lt;</a>
						<%}%>
						<%
						for (int i=startpage; i<=endpage; i++) {
							if (iPage == i) {
						%>
						<strong><%=i%></strong>
						<%
							} else {
						%>
						<a href="javascript:;" onclick="getDiary(<%=i%>, '<%=pageType%>')"><%=i%></a>
						<%
							}
						}
						%>
						<%if (startpage+pagelist <= totalPage){%>
						<a class="firstpostslink" href="javascript:;" onclick="getDiary(<%=startpage+pagelist%>, '<%=pageType%>')">&gt;</a>
						<%}%>
						<%if (totalPage > 1) {%>
						<a class="nextpostslink" href="javascript:;" onclick="getDiary(<%=totalPage%>, '<%=pageType%>')">&gt;&gt;</a>
						<%}%>
					</div>