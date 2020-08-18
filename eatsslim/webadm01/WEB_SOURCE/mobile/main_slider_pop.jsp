<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%
NumberFormat nf		= NumberFormat.getNumberInstance();
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today			= dt.format(new Date());
String query			= "";
String listImg		= "";
String imgUrl		= "";
String eventUrl		= "";
String viewLink		= "";
String bannerImg 	= "";
String clickLink 		= "";
String title			= "";

%>
<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/expansion.css">
   <div class="inner main_slider_pop">
        <header class="pop_header"><h1>진행중인 이벤트</h1></header>
        <div class="pop_content">
			<ul>
<%				
				query		= "SELECT ID, TITLE, BANNER_IMG, LINK";
				query		+= " FROM ESL_BANNER ";
				query		+= " WHERE GUBUN in ('5') AND OPEN_YN = 'Y' AND ('"+ today +"' BETWEEN STDATE AND LTDATE)";
				query		+= " ORDER BY ID DESC";
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
				<li><a href="<%=clickLink%>"><img src="<%=imgUrl%>" alt="<%=title%>" /></a></li>
<%
				}
				rs.close();
%>							
			</ul>
        </div>
    </div>
