<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
				<ul class="paging">
					<%if (viPage > 1) {%>
						<li class="li_btn"><a href="<%=request.getRequestURI()%>?vpage=1<%=vparam%>&<%=param%>"><img src="../images/common/ico/ico_first.gif" alt="ó��" /></a></li>
					<%}else{%>
						<li class="li_btn"><img src="../images/common/ico/ico_first.gif" alt="ó��" /></li>
					<%}%>
					<%if (startpage-pagelist >= 1) {%>
						<li class="li_btn"><a href="<%=request.getRequestURI()%>?vpage=<%=startpage-pagelist%><%=vparam%>&<%=param%>"><img src="../images/common/ico/ico_prev.gif" alt="����" /></a></li>
					<%}else{%>
						<li class="li_btn"><img src="../images/common/ico/ico_prev.gif" alt="����" /></li>
					<%}%>
					<%
					for (i=startpage; i<=endpage; i++)
					{
						if (viPage == i)
						{
							%><li><strong><%=i%></strong></li><%
						}else {
							%><li><a href="<%=request.getRequestURI()%>?vpage=<%=i%><%=vparam%>&<%=param%>"><%=i%></a></li><%
						}
					}
					%>
					<%if (startpage+pagelist <= totalPage){%>
						<li class="li_btn"><a href="<%=request.getRequestURI()%>?vpage=<%=startpage+pagelist%><%=vparam%>&<%=param%>"><img src="../images/common/ico/ico_next.gif" alt="����" /></a></li>
					<%}else{%>
						<li class="li_btn"><img src="../images/common/ico/ico_next.gif" alt="����" /></li>
					<%}%>

					<%if (totalPage > 1) {%>
						<li class="li_btn"><a href="<%=request.getRequestURI()%>?vpage=<%=totalPage%><%=vparam%>&<%=param%>"><img src="../images/common/ico/ico_last.gif" alt="������" /></a></li>
					<%}else{%>
						<li class="li_btn"><img src="../images/common/ico/ico_last.gif" alt="������" /></li>
					<%}%>
				</ul>