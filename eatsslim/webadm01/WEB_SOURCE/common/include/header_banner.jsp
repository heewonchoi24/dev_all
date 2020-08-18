<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%				
				query		= "SELECT ID, TITLE, BANNER_IMG, LINK";
				query		+= " FROM ESL_BANNER ";
				query		+= " WHERE GUBUN in ('3') AND OPEN_YN = 'Y' AND ('"+ today +"' BETWEEN STDATE AND LTDATE)";
				query		+= " ORDER BY ID DESC LIMIT 1";
				pstmt		= conn.prepareStatement(query);
				rs			= pstmt.executeQuery();

				while (rs.next()) {
					title			= rs.getString("TITLE");
					bannerImg		= rs.getString("BANNER_IMG");
					if (bannerImg.equals("") || bannerImg == null) {
						imgUrl		= "../images/event_thumb01.jpg";
					} else {
						imgUrl		= webUploadDir +"banner/"+ bannerImg;
					}
					clickLink		= rs.getString("LINK");
%>			
				<a href="<%=clickLink%>"><img src="<%=imgUrl%>" alt="<%=title%>" /></a>
<%
				}
				rs.close();
%>
