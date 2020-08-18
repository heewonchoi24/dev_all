<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String savePath			= uploadDir + "board/"; // ������ ���丮 (������)
int sizeLimit			= 2 * 1024 * 1024 ; // ȭ�Ͽ뷮����
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
			query		= "UPDATE "+ table +" SET ";
			query		+= "	CONTENT2			= ?,";
			query		+= "	RE_UPDT_DATE			= NOW()";
			query		+= " WHERE IDX = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, content);
			pstmt.setInt(2, reply_idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			out.println(e+"=>"+query);

			if(true)return;
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}

		out.print("<script>alert('��ϵǾ����ϴ�');location.href='dc_edit.jsp?"+param+"';</script>");
	}else if(mode.equals("edit")) {



	}else if(mode.equals("del")) {

		try {
			query		= "DELETE FROM "+ table +" WHERE IDX IN ("+ reply_idx +") ";


			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();

		} catch (Exception e) {
			out.println(e);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}

		out.print("<script>alert('�����Ǿ����ϴ�');location.href='dc_edit.jsp?"+param+"';</script>");

	}else if(mode.equals("del2")) {

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	CONTENT2			= ?";
			query		+= " WHERE IDX = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, "");
			pstmt.setInt(2, reply_idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			out.println(e+"=>"+query);

			if(true)return;
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}

		out.print("<script>alert('�����Ǿ����ϴ�');location.href='dc_edit.jsp?"+param+"';</script>");
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>