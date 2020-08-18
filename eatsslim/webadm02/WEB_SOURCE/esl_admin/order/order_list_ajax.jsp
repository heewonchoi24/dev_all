<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

//String savePath			= uploadDir + "board/"; // 저장할 디렉토리 (절대경로)
//int sizeLimit			= 2 * 1024 * 1024 ; // 화일용량제한
//MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

//String table			= "ESL_NOTICE";
String query			= "";
String mode				= ut.inject(request.getParameter("mode"));
int noticeId			= 0;
String topYn			= ut.inject(request.getParameter("top_yn"));
String title			= ut.inject(request.getParameter("title"));
String content			= ut.inject(request.getParameter("content"));
String param			= ut.inject(request.getParameter("param"));
String delIds			= "";
String delId				= "";
String listImg			= ut.inject(request.getParameter("org_list_img"));
String delListImg		= ut.inject(request.getParameter("del_list_img"));
String[] arrDelId;
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();
SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
String instDate		= dt.format(new Date());

if (mode != null) {
	
	if (mode.equals("del")) {
		delIds		= ut.inject(request.getParameter("del_ids"));

		arrDelId	= delIds.split(",");
		for (i = 0; i < arrDelId.length; i++) {
			delId		= arrDelId[i];
/*
				query		= "INSERT INTO ESL_ORDER_BACKUP (Select * from ESL_ORDER WHERE ORDER_NUM = '"+ delId +"')";
				pstmt		= conn.prepareStatement(query);
				pstmt.executeUpdate();

				query		= "INSERT INTO ESL_ORDER_GOODS_BACKUP (Select * from ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ delId +"')";
				pstmt		= conn.prepareStatement(query);
				pstmt.executeUpdate();
				
				query		= "INSERT INTO ESL_ORDER_DEVL_DATE_BACKUP (Select * from ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ delId +"')";
				pstmt		= conn.prepareStatement(query);
				pstmt.executeUpdate();
*/				
				
				query		= "DELETE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ delId +"'";
				pstmt		= conn.prepareStatement(query);
				pstmt.executeUpdate();

				query		= "DELETE FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ delId +"'";
				pstmt		= conn.prepareStatement(query);
				pstmt.executeUpdate();

				query		= "DELETE FROM ESL_ORDER WHERE ORDER_NUM = '"+ delId  +"'";
				pstmt		= conn.prepareStatement(query);
				pstmt.executeUpdate();

				query		= "DELETE FROM ESL_ORDER_CANCEL WHERE ORDER_NUM = '"+ delId  +"'";
				pstmt		= conn.prepareStatement(query);
				pstmt.executeUpdate();	
				
			
			//================PHI 연동
			query		= "UPDATE PHIBABY.P_ORDER_MALL_PHI_ITF SET INTERFACE_FLAG_YN = 'Y' WHERE ORD_NO = '"+ delId +"'";
			try {
				stmt_phi.executeUpdate(query);
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}

			int ordSeq			= 0;

			// 시퀀스 조회
			query		= "SELECT MAX(ORD_SEQ) FROM PHIBABY.P_ORDER_MALL_PHI_ITF";
			try {
				rs_phi		= stmt_phi.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			if (rs_phi.next()) {
				ordSeq		= rs_phi.getInt(1) + 1;
			}
			rs_phi.close();

			query		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
			query		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM)";
			query		+= "	VALUES";
			query		+= "	("+ ordSeq +", '"+ instDate +"', '"+ delId +"', '00000000', 'D', '취소', '취소', '111111', '취소', '취소', '00000000000', '00000000000', 'cancel', 0, 0, 0, 0, '40', '0001', '', '', 1, '"+ instDate +"', '000000', 0, 0, 0, SYSDATE)";
			try {
				stmt_phi.executeUpdate(query);
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}

		}

		ut.jsRedirect(out, "order_list.jsp");
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="../lib/dbclose_phi.jsp" %>