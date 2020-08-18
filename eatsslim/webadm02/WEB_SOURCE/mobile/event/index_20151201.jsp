<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String table		= "ESL_EVENT";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
int eventId			= 0;
String eventType	= "";
String title		= "";
String openYn		= "";
String stdate		= "";
String ltdate		= "";
String eventTarget	= "";
String ancDate		= "";
String listImg		= "";
String imgUrl		= "";
String eventUrl		= "";
String viewLink		= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());

///////////////////////////
int pgsize		= 10; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int iPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;

where			= " WHERE GUBUN = '2' AND OPEN_YN = 'Y' AND ('"+ today +"' BETWEEN STDATE AND LTDATE)";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // 총 페이지 수
endpage		= startpage + pagelist - 1;
if (endpage > totalPage) {
	endpage = totalPage;
}
curNum		= intTotalCnt-pgsize*(iPage-1);
param		+= "&amp;pgsize=" + pgsize;

query		= "SELECT ID, EVENT_TYPE, TITLE, DATE_FORMAT(STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(LTDATE, '%Y.%m.%d') LTDATE,";
query		+= "	EVENT_TARGET, DATE_FORMAT(ANC_DATE, '%Y.%m.%d') ANC_DATE, LIST_IMG, EVENT_URL";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ID DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>

</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">이벤트</span></span></h1>
            <div class="row">
                <ul class="event">

				<%
					if (intTotalCnt > 0) {
						while (rs.next()) {
								eventId		= rs.getInt("ID");
								eventType	= rs.getString("EVENT_TYPE");
								title		= rs.getString("TITLE");
								stdate		= rs.getString("STDATE");
								ltdate		= rs.getString("LTDATE");
								eventTarget	= rs.getString("EVENT_TARGET");
								ancDate		= (rs.getString("ANC_DATE") == null || rs.getString("ANC_DATE").equals(""))? "미정" : rs.getString("ANC_DATE");
								listImg		= rs.getString("LIST_IMG");
								if (listImg.equals("") || listImg == null) {
									imgUrl		= "../images/event_thumb01.jpg";
								} else {
									imgUrl		= webUploadDir +"promotion/"+ listImg;
								}
								eventUrl	= rs.getString("EVENT_URL");
								viewLink	= (eventUrl == null || eventUrl.equals(""))? "href=\"view.jsp?id="+ eventId + param + "\"" : "href=\""+ eventUrl +"\" target=\"press\"";
					%>
                    <li>
                       <h3><%=title%></h3>
                       <a <%=viewLink%>> 
						  
                          <img src="<%=imgUrl%>" width="600">
                       </a>
                       <p class="meta"><%=stdate%> ~ <%=ltdate%></p>
                    </li>
					<%
							curNum--;
						}
					} else {
					%>
					
					<%
					}
					%>
                </ul>
            </div>
            <!-- <div class="row" style="text-align:center;">
                <a href="#" class="ui-btn ui-btn-inline ui-btn-up-c"><span class="ui-btn-inner"><span class="ui-btn-text">더보기</span></span></a>
            </div> -->

    </div>
    <!-- End Content -->
    <div class="ui-footer">
        <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>