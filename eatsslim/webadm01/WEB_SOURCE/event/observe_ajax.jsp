<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String table		= "ESL_EVENT_OBSERVE";
String query		= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
int pressId			= 0;
String title		= "";
String listImg		= "";
String pressUrl		= "";
String viewLink		= "";
String imgUrl		= "";
String instDate		= "";
int divNum			= 0;
String content		= "";
String p_gubun		= "";
int nextPage		= 0;

///////////////////////////
int pgsize		= 12; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int iPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;
int hitCnt = 0;

int gubun_all_cnt = 0;
int gubun1_cnt = 0;
int gubun2_cnt = 0;
int gubun3_cnt = 0;

if (mode.equals("getList")) {
	where			= " WHERE 1=1";

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

	p_gubun =  (request.getParameter("p_gubun") == null)? "" : request.getParameter("p_gubun");

	if(p_gubun.equals("1")){
		where += " and press_url='1' ";
		param		+= "&amp;p_gubun=" + p_gubun;
	}else if(p_gubun.equals("2")){
		where += " and press_url='2' ";
		param		+= "&amp;p_gubun=" + p_gubun;
	}else if(p_gubun.equals("3")){
		where += " and press_url='3' ";
		param		+= "&amp;p_gubun=" + p_gubun;
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

	query		= "SELECT ID, TITLE, LIST_IMG, PRESS_URL, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE,CONTENT,HIT_CNT,(select count(id) from ESL_EVENT_OBSERVE_REPLY where ID="+table+".ID) as re_cnt";
	query		+= " FROM "+ table + where;
	query		+= " ORDER BY ID DESC";
	query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();

	if (intTotalCnt > 0) {
		int i		= 0;
		while (rs.next()) {
			pressId		= rs.getInt("ID");
			title		= rs.getString("TITLE");
			listImg		= rs.getString("LIST_IMG");
			content		= rs.getString("CONTENT");
			hitCnt		= rs.getInt("HIT_CNT");
			content		= ut.delHtmlTag(content);

			if (!listImg.equals("")) {
				imgUrl		= webUploadDir +"board/"+ listImg;
			} else {
				imgUrl		= "";
			}
			pressUrl	= rs.getString("PRESS_URL");			
			instDate	= rs.getString("WDATE");
			nextPage	= iPage + 1;
			nextPage	= (nextPage > totalPage)? 0 : nextPage;

			data		+= "<diet>"+ pressId +"|<![CDATA["+ title +"]]>|<![CDATA["+ imgUrl +"]]>|<![CDATA["+ ut.cutString(260, content, "..") +"]]>|<![CDATA["+ hitCnt +"]]>|<![CDATA["+ pressUrl +"]]>|<![CDATA["+ instDate.substring(2,10) +"]]>|"+ rs.getInt("re_cnt") +"|"+ nextPage +"</diet>";
		}
	}

	if (intTotalCnt > 0) {
		code		= "success";
	} else {
		code		= "error";
		data		= "<error><![CDATA[요청하신 메뉴가 준비되지 않았습니다.\n다른 메뉴를 이용해 주세요.]]></error>";
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>