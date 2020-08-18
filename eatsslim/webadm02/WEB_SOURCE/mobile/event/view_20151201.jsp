<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>

<%
request.setCharacterEncoding("euc-kr");

int eventId				= 0;
String query			= "";
String eventType		= "";
String title			= "";
String openYn			= "";
String stdate			= "";
String ltdate			= "";
String eventTarget		= "";
String ancDate			= "";
String content			= "";
String param			= "";
String keyword			= "";
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String schCate			= ut.inject(request.getParameter("sch_cate"));
String field			= ut.inject(request.getParameter("field"));


String login_stat_str = "";

int reply_count = 0;
int reply_id = 0;
int reply_idx = 0;

String m_id = "";
String m_name = "";
String reply_content = "";
String reply_content2 = "";
String reply_date = "";
String reply_date2 = "";
String reply_mode = "write";

String imgUrl = "";
String viewImg = "";

int noticeId = 0;

if (request.getParameter("reply_idx") != null && request.getParameter("reply_idx").length() > 0) {
	reply_idx = Integer.parseInt(request.getParameter("reply_idx"));
}



if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	eventId	= Integer.parseInt(request.getParameter("id"));


	//댓글수

	noticeId = eventId;
	query		= "SELECT COUNT(ID) FROM ESL_EVENT_REPLY where ID="+noticeId+"";

	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();
	if (rs.next()) {
		reply_count = rs.getInt(1); //총 레코드 수		
	}
	if (rs != null) try { rs.close(); } catch (Exception e) {}
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}



	query		= "SELECT TITLE, DATE_FORMAT(STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(LTDATE, '%Y.%m.%d') LTDATE,";
	query		+= "	EVENT_TARGET, DATE_FORMAT(ANC_DATE, '%Y.%m.%d') ANC_DATE, CONTENT, VIEW_IMG";
	query		+= " FROM ESL_EVENT";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, eventId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		stdate			= rs.getString("STDATE");
		ltdate			= rs.getString("LTDATE");
		ancDate			= (rs.getString("ANC_DATE") == null || rs.getString("ANC_DATE").equals(""))? "미정" : rs.getString("ANC_DATE");
		content			= rs.getString("CONTENT");
		viewImg			= (rs.getString("VIEW_IMG").equals("") || rs.getString("VIEW_IMG") == null)? "" : rs.getString("VIEW_IMG");
		imgUrl			= webUploadDir +"promotion/"+ viewImg;
	}
} else {
	ut.jsBack(out);
	if (true) return;
}
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
                <div class="event">
                    <div class="head">
                       <span class="fb"><a href="#"></a></span>
                       <span class="tw"><a href="#"></a></span>
                       <span class="me"><a href="#"></a></span>
                       <h3><%=title%></h3>
                       <p class="meta"><%=stdate%> ~ <%=ltdate%></p>
                    </div>
                    <div class="article">
                         <%=content%>
                    </div>
                </div>
            </div>
            <div class="row" style="text-align:center;">
                <a href="index.jsp?<%=param%>" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c"><span class="ui-btn-inner"><span class="ui-btn-text">목록보기</span></span></a>
            </div>
    </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>