<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
				<ul class="paging">
					<%if (iPage > 1) {%>
						<li class="li_btn"><a href="<%=request.getRequestURI()%>?page=1<%=param%>"><img src="../images/common/ico/ico_first.gif" alt="ó��" /></a></li>
					<%}else{%>
						<li class="li_btn"><img src="../images/common/ico/ico_first.gif" alt="ó��" /></li>
					<%}%>
					<%if (startpage-pagelist >= 1) {%>
						<li class="li_btn"><a href="<%=request.getRequestURI()%>?page=<%=startpage-pagelist%><%=param%>"><img src="../images/common/ico/ico_prev.gif" alt="����" /></a></li>
					<%}else{%>
						<li class="li_btn"><img src="../images/common/ico/ico_prev.gif" alt="����" /></li>
					<%}%>
					<%
					for (i=startpage; i<=endpage; i++)
					{
						if (iPage == i)
						{
							%><li><strong><%=i%></strong></li><%
						}else {
							%><li><a href="<%=request.getRequestURI()%>?page=<%=i%><%=param%>"><%=i%></a></li><%
						}
					}
					%>
					<%if (startpage+pagelist <= totalPage){%>
						<li class="li_btn"><a href="<%=request.getRequestURI()%>?page=<%=startpage+pagelist%><%=param%>"><img src="../images/common/ico/ico_next.gif" alt="����" /></a></li>
					<%}else{%>
						<li class="li_btn"><img src="../images/common/ico/ico_next.gif" alt="����" /></li>
					<%}%>

					<%if (totalPage > 1) {%>
						<li class="li_btn"><a href="<%=request.getRequestURI()%>?page=<%=totalPage%><%=param%>"><img src="../images/common/ico/ico_last.gif" alt="������" /></a></li>
					<%}else{%>
						<li class="li_btn"><img src="../images/common/ico/ico_last.gif" alt="������" /></li>
					<%}%>
				</ul>