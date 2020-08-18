<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String savePath			= uploadDir + "board/"; // 저장할 디렉토리 (절대경로)
int sizeLimit			= 2 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String table			= "ESL_DC_REPLY";
String query			= "";
String mode				= ut.inject(multi.getParameter("mode"));

int noticeId		= 0;

noticeId	= Integer.parseInt(multi.getParameter("id"));

String m_id		= ut.inject(multi.getParameter("m_id"));
String m_name				= ut.inject(multi.getParameter("m_name"));
String content				= ut.inject(multi.getParameter("content"));
int reply_idx				= 0;

if (multi.getParameter("reply_idx") != null && multi.getParameter("reply_idx").length() > 0) {
	reply_idx = Integer.parseInt(multi.getParameter("reply_idx"));
}


String userIp			= request.getRemoteAddr();

String param = "";
String keyword		= "";
String iPage		= ut.inject(multi.getParameter("page"));
String pgsize		= ut.inject(multi.getParameter("pgsize"));
String schCate		= ut.inject(multi.getParameter("sch_cate"));
String field		= ut.inject(multi.getParameter("field"));
String p_gubun		= ut.inject(multi.getParameter("p_gubun"));
String pressUrl		= "";
int HIT_CNT = 0;

String login_stat_str = "";


if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param		= "&amp;page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword+"&p_gubun="+p_gubun+"&id="+noticeId;





if (mode != null) {

		

	if (mode.equals("write")) {
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(ID, M_ID, M_NAME, CONTENT, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, noticeId);
			pstmt.setString(2, m_id);
			pstmt.setString(3, m_name);
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

		out.print("<script>alert('등록되었습니다');location.href='dietColumView.jsp?"+param+"';</script>");
	}else if(mode.equals("edit")) {

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	CONTENT			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE IDX = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, content);
			pstmt.setString(2, userIp);
			pstmt.setInt(3, reply_idx);
			pstmt.executeUpdate();

		} catch (Exception e) {
			out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		out.print("<script>alert('수정되었습니다');location.href='dietColumView.jsp?"+param+"';</script>");


	}else if(mode.equals("del")) {

		try {
			query		= "DELETE FROM "+ table +" WHERE IDX IN ("+ reply_idx +") and M_ID='"+eslMemberId+"'";


			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();

		} catch (Exception e) {
			out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		out.print("<script>alert('삭제되었습니다');location.href='dietColumView.jsp?"+param+"';</script>");
	}

}
%>
<%@ include file="../lib/dbclose.jsp" %>