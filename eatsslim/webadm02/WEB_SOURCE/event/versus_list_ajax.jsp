<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%
String table		= "ESL_EVENT_DIARY";
String query		= "";
String where		= "";
String param		= "";
int diaryId			= 0;
String title		= "";
int day				= 0;
String weekday		= "";
int intI			= 0;
String pageType		= ut.inject(request.getParameter("ptype"));

///////////////////////////
int pgsize		= 7; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int iPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;


if (pageType.equals("1")) {
	where			= " WHERE VERSUS = '1' ";

	if (request.getParameter("page") != null && request.getParameter("page").length()>0){
		iPage		= Integer.parseInt(request.getParameter("page"));
		startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
	}else{
		iPage		= 1;
		startpage	= 1;
	}
	if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
		pgsize		= Integer.parseInt(request.getParameter("pgsize"));

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

	query		= "SELECT ID, TITLE, DAY, WEEKDAY";
	query		+= " FROM "+ table + where;
	query		+= " ORDER BY ID DESC";
	query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();
	///////////////////////////
	%>
	<ul>
		<%
		intI	= 0;
		if (intTotalCnt > 0) {
			while (rs.next()) {
				diaryId		= rs.getInt("ID");
				title		= rs.getString("TITLE");
				day			= rs.getInt("DAY");
				weekday		= rs.getString("WEEKDAY");
		%>
		<li><a href="javascript:;" onClick="window.open('choi_diary.jsp?id=<%=diaryId%>','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span><%=day%>일차(<%=weekday%>)</span><%=title%></a></li>
		<%
				intI++;
			}
		}

		for (int ii=(intI + 1); ii<=7; ii++) {
			out.println("<li>&nbsp;</li>");
		}
		%>
	</ul>
	<%@ include file="../common/include/inc-paging-event.jsp"%>
<%
} else if (pageType.equals("2")) {
	where			= " WHERE VERSUS = '2' ";

	if (request.getParameter("page") != null && request.getParameter("page").length()>0){
		iPage		= Integer.parseInt(request.getParameter("page"));
		startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
	}else{
		iPage		= 1;
		startpage	= 1;
	}
	if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
		pgsize		= Integer.parseInt(request.getParameter("pgsize"));

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

	query		= "SELECT ID, TITLE, DAY, WEEKDAY";
	query		+= " FROM "+ table + where;
	query		+= " ORDER BY ID DESC";
	query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();
	///////////////////////////
	%>
	<ul>
		<%
		intI	= 0;
		if (intTotalCnt > 0) {
			while (rs.next()) {
				diaryId		= rs.getInt("ID");
				title		= rs.getString("TITLE");
				day			= rs.getInt("DAY");
				weekday		= rs.getString("WEEKDAY");
		%>
		<li><a href="javascript:;" onClick="window.open('choi_diary.jsp?id=<%=diaryId%>','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span><%=day%>일차(<%=weekday%>)</span><%=title%></a></li>
		<%
				intI++;
			}
		}

		for (int ii=(intI + 1); ii<=7; ii++) {
			out.println("<li>&nbsp;</li>");
		}
		%>
	</ul>
	<%@ include file="../common/include/inc-paging-event.jsp"%>
<%
} else if (pageType.equals("3")) {
	table		= "ESL_EVENT_WEEK_COMMENT";
	int weekId			= 0;
	String stdate		= "";
	String ltdate		= "";
	pgsize		= 4;
	where			= " WHERE 1=1 ";

	if (request.getParameter("page") != null && request.getParameter("page").length()>0){
		iPage		= Integer.parseInt(request.getParameter("page"));
		startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
	}else{
		iPage		= 1;
		startpage	= 1;
	}
	if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
		pgsize		= Integer.parseInt(request.getParameter("pgsize"));

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

	query		= "SELECT ID, DATE_FORMAT(STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(LTDATE, '%Y.%m.%d') LTDATE, TITLE";
	query		+= " FROM "+ table + where;
	query		+= " ORDER BY ID DESC";
	query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();
	///////////////////////////
	%>
	<ul>
		<%
		intI	= 0;
		if (intTotalCnt > 0) {
			while (rs.next()) {
				weekId		= rs.getInt("ID");
				stdate		= rs.getString("STDATE");
				ltdate		= rs.getString("LTDATE");
				title		= rs.getString("TITLE");
		%>
		<li><a href="javascript:;" onClick="window.open('week_comment.jsp?id=<%=weekId%>','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span><%=stdate%>~<%=ltdate%></span><%=title%></a></li>
		<%
				intI++;
			}
		}
		for (int ii=(intI + 1); ii<=4; ii++) {
			out.println("<li>&nbsp;</li>");
		}

		pageType	= "3";
		%>
	</ul>
	<%@ include file="../common/include/inc-paging-event.jsp"%>
<%}%>