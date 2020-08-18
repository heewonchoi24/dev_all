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

String savePath			= uploadDir + "board/"; // ������ ���丮 (������)
int sizeLimit			= 2 * 1024 * 1024 ; // ȭ�Ͽ뷮����
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String table			= "ESL_EVENT_REPLY";
String query			= "";
String mode				= ut.inject(multi.getParameter("mode"));

int noticeId		= 0;

noticeId	= Integer.parseInt(multi.getParameter("id"));

String m_id		= ut.inject(multi.getParameter("m_id"));
String m_name				= ut.inject(multi.getParameter("m_name"));
String content				= ut.inject(multi.getParameter("content"));
String goodsName			= ut.inject(multi.getParameter("goods_name"));
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

int couponCnt			= 0;
String couponNum		= "";

if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param		= "&amp;page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword+"&p_gubun="+p_gubun+"&id="+noticeId;

if (mode != null) {
	if (mode.equals("write")) {
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(ID, M_ID, M_NAME, CONTENT, INST_IP, INST_DATE, GOODS_NAME)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, NOW(), ?)";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, noticeId);
			pstmt.setString(2, m_id);
			pstmt.setString(3, m_name);
			pstmt.setString(4, content);
			pstmt.setString(5, userIp);
			pstmt.setString(6, goodsName);
			pstmt.executeUpdate();
		} catch (Exception e) {
			out.println(e+"=>"+query);

			if(true)return;
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}
		
		if ( noticeId == 230 ) {
			query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
			//query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.COUPON_NAME like '%50�ϴ��̾�Ʈ-�Ļ� 8�ֱ��Ž�%'";
			query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID = 2768";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			if (rs.next()) {
				couponCnt	= rs.getInt(1);
			}
			rs.close();

			if (couponCnt > 0) {	
			} else {
				SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
				couponNum		= "ET" + dt.format(new Date()) + "001";

				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (2768,'"+ couponNum +"','"+ m_id +"','N',NOW())";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e);
					if(true)return;
				}
			}
			
			out.print("<script>alert('���� �߱��� �Ϸ�Ǿ����ϴ� -');location.href='eventView.jsp?"+param+"';</script>");
		} else {
			out.print("<script>alert('��ϵǾ����ϴ�');location.href='eventView.jsp?"+param+"';</script>");
		}

	}else if(mode.equals("edit")) {

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	CONTENT			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW(),";
			query		+= "	GOODS_NAME		= ?";
			query		+= " WHERE IDX = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, content);
			pstmt.setString(2, userIp);
			pstmt.setString(3, goodsName);
			pstmt.setInt(4, reply_idx);
			pstmt.executeUpdate();

		} catch (Exception e) {
			out.println(e);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}

		out.print("<script>alert('�����Ǿ����ϴ�');location.href='eventView.jsp?"+param+"';</script>");


	}else if(mode.equals("del")) {

		try {
			query		= "DELETE FROM "+ table +" WHERE IDX IN ("+ reply_idx +") and M_ID='"+eslMemberId+"'";


			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();

		} catch (Exception e) {
			out.println(e);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}

		out.print("<script>alert('�����Ǿ����ϴ�');location.href='eventView.jsp?"+param+"';</script>");
	}

}
%>
<%@ include file="../lib/dbclose.jsp" %>