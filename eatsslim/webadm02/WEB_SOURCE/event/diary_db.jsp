<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_EVENT_DIARY_REPLY";
String query		= "";
String mode			= ut.inject(request.getParameter("mode"));
int diaryId			= 0;
if (request.getParameter("id") != null && request.getParameter("id").length() > 0)
	diaryId		= Integer.parseInt(request.getParameter("id"));
String memberId		= ut.inject(request.getParameter("member_id"));
String memberName	= ut.inject(request.getParameter("member_name"));
String content		= ut.inject(request.getParameter("content"));
String returnUrl	= ut.inject(request.getParameter("return_url"));
int replyId			= 0;
if (request.getParameter("reply_id") != null && request.getParameter("reply_id").length() > 0)
	replyId		= Integer.parseInt(request.getParameter("reply_id"));
String userIp		= request.getRemoteAddr();

if (mode != null) {
	if (mode.equals("ins")) {
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(DIARY_ID, MEMBER_ID, MEMBER_NAME, CONTENT, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, diaryId);
			pstmt.setString(2, memberId);
			pstmt.setString(3, memberName);
			pstmt.setString(4, content);
			pstmt.setString(5, userIp);
			pstmt.executeUpdate();
		} catch (Exception e) {
			out.println(e+"=>"+query);

			if(true)return;
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		out.print("<script>alert('등록되었습니다');location.href='"+returnUrl+".jsp?id="+diaryId+"';</script>");
	} else if(mode.equals("upd")) {
		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	CONTENT			= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, content);
			pstmt.setString(2, eslMemberId);
			pstmt.setString(3, userIp);
			pstmt.setInt(4, replyId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		out.print("<script>alert('수정되었습니다');location.href='"+returnUrl+".jsp?id="+diaryId+"';</script>");
	} else if(mode.equals("del")) {
		try {
			query		= "DELETE FROM "+ table +" WHERE ID = "+ replyId +" AND MEMBER_ID='"+ eslMemberId +"'";
			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();
		} catch (Exception e) {
			out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		out.print("<script>alert('삭제되었습니다');location.href='"+returnUrl+".jsp?id="+diaryId+"';</script>");
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>