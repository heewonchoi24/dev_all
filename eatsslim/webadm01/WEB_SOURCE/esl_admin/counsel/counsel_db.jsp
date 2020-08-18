<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="/lib/dbconn_tbr.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String savePath			= uploadDir + "board/"; // 저장할 디렉토리 (절대경로)
int sizeLimit			= 2 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String table			= "ESL_COUNSEL";
String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
int counselId			= 0;
String param			= ut.inject(multi.getParameter("param"));
String mode				= ut.inject(multi.getParameter("mode"));
String counselType		= ut.inject(multi.getParameter("counsel_type"));
String answer_yn		= "";
String answer			= ut.inject(multi.getParameter("answer"));
String userIp			= request.getRemoteAddr();
String listImg			= ut.inject(multi.getParameter("org_list_img"));
String delListImg		= ut.inject(multi.getParameter("del_list_img"));
String delIds			= "";
int delId				= 0;
String[] arrDelId;
String customerNum		= "";
String memberId			= "";
String name				= "";
String hp				= "";
String hp1				= "";
String hp2				= "";
String hp3				= "";
String email			= "";
String content			= "";
String wdate			= "";
String hdBcode			= "";
String hdScode			= "";
String claimGubun		= "";
String ecs_cate1		= ut.inject(multi.getParameter("ecs_type1"));
String ecs_cate2		= ut.inject(multi.getParameter("ecs_type2"));
String ecs_cate3		= ut.inject(multi.getParameter("ecs_type3"));
String[] tmp			= new String[]{};
//===============================날짜
Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //오늘
String cDate=(new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());


if (mode != null) {
/*
	switch(Integer.parseInt(counselType)){
		case 1:
			hdBcode		= "00005";
			hdScode		= "00002";
			claimGubun	= "00002";break;
		case 2:
			hdBcode		= "00009";
			hdScode		= "00003";
			claimGubun	= "00003";break;
		case 3:
			hdBcode		= "00010";
			hdScode		= "00003";
			claimGubun	= "00003";break;
		case 4:
			hdBcode		= "00002";
			hdScode		= "00001";
			claimGubun	= "00014";break;
		case 5:
			hdBcode		= "00003";
			hdScode		= "00002";
			claimGubun	= "00003";break;
		case 9:
			hdBcode		= "00009";
			hdScode		= "00003";
			claimGubun	= "00003";break;
		default:
			hdBcode		= "&nbsp;";
			hdScode		= "&nbsp;";
			claimGubun	= "&nbsp;";break;
	}
*/
	if (mode.equals("ins")) {

		/*
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(MEMBER_ID, COUNSEL_TYPE, NAME, HP, EMAIL, TITLE, CONTENT, UP_FILE, INST_IP, INST_DATE, ECS_CATE1, ECS_CATE2, ECS_CATE3)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?, ?)";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, eslMemberId);
			pstmt.setString(2, counselType);
			pstmt.setString(3, name);
			pstmt.setString(4, hp);
			pstmt.setString(5, email);
			pstmt.setString(6, title);
			pstmt.setString(7, content);
			pstmt.setString(8, upFile);
			pstmt.setString(9, userIp);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "counsel_list.jsp");
		*/
	} else if (mode.equals("upd")) {
		counselId		= Integer.parseInt(multi.getParameter("id"));
		answer_yn		= (!answer.equals("") && answer != null)? "Y" : "N";


		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	COUNSEL_TYPE	= ?,";
			query		+= "	ANSWER_YN		= ?,";
			query		+= "	ANSWER			= ?,";
			query		+= "	ANSWER_IP		= ?,";
			query		+= "	ANSWER_DATE		= NOW(),";
			query		+= "	ECS_CATE1		= ?,";
			query		+= "	ECS_CATE2		= ?,";
			query		+= "	ECS_CATE3		= ?";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, counselType);
			pstmt.setString(2, answer_yn);
			pstmt.setString(3, answer);
			pstmt.setString(4, userIp);
			pstmt.setString(5, ecs_cate1);
			pstmt.setString(6, ecs_cate2);
			pstmt.setString(7, ecs_cate3);
			pstmt.setInt(8, counselId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}		

		query1		= "SELECT MEMBER_ID, NAME, HP, CONTENT, EMAIL, DATE_FORMAT(INST_DATE, '%Y%m%d') WDATE FROM "+ table;
		query1		+= " WHERE ID = "+ counselId;
		try {
			rs1	= stmt.executeQuery(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}

		if (rs1.next()) {
			memberId	= rs1.getString("MEMBER_ID");
			name		= rs1.getString("NAME");
			hp			= rs1.getString("HP");
			if (hp != null && hp.length()>10) {
				tmp			= hp.split("-");
				hp1			= tmp[0];
				hp2			= tmp[1];
				hp3			= tmp[2];
			}
			content			= rs1.getString("CONTENT");
			email			= rs1.getString("EMAIL");
			wdate			= rs1.getString("WDATE");
		}
		rs1.close();

		query1		= "SELECT CUSTOMER_NUM FROM ESL_MEMBER WHERE MEM_ID = '"+ memberId +"'";
		try {
			rs1	= stmt.executeQuery(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}

		if (rs1.next()) {
			customerNum		= rs1.getString("CUSTOMER_NUM");
		}
		rs1.close();

		query		= "INSERT INTO TBITF_VOICE_IF";
		query		+= "	(RECEIPT_ROOT, BOARD_DIV, BOARD_SEQ, CUSTOMER_NUM, CUSTOMER_NAME, CUSTOMER_PHONEAREA, CUSTOMER_PHONEFIRST, CUSTOMER_PHONESECOND,";
		query		+= "	CUSTOMER_EMAIL, HD_BCODE, HD_SCODE, CLAIM_GUBUN, COUNSEL_DESC, RECEIPT_DATE, PRCS_YN, DEL_YN, ITEM_NAME, REPLY, MODIFY_DATE, SEC_CODE)";
		query		+= " VALUES";
		query		+= "	('10011', '1:1 문의', "+ counselId +", '"+ customerNum +"', '"+ name +"', '"+ hp1 +"', '"+ hp2 +"', '"+ hp3 +"', '"+ email +"', '"+ ecs_cate1 +"',";
		query		+= "	'"+ ecs_cate2 +"', '"+ ecs_cate3 +"', '"+ content +"', '"+ wdate +"', 'N', 'N', '잇슬림', '"+ ut.delHtmlTag(answer) +"', '"+ cDate +"', '953')";
		try {
			stmt_tbr.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}

		ut.jsRedirect(out, "counsel_list.jsp?"+ param);


	} else if (mode.equals("del")) {

		delIds = ut.inject(multi.getParameter("del_ids"));

		arrDelId	= delIds.split(",");
		for (i = 0; i < arrDelId.length; i++) {
			delId		= Integer.parseInt(arrDelId[i]);

			try {
				query		= "SELECT up_file FROM "+ table +" WHERE ID = ?";
				pstmt		= conn.prepareStatement(query);
				pstmt.setInt(1, delId);
				rs			= pstmt.executeQuery();

				if (rs.next()) {
					listImg		= rs.getString("up_file");

					if (listImg != null && listImg.length() > 0) {
						File f1		= new File(savePath+listImg);
						if (f1.exists()) f1.delete();
					}
				}
			} catch (Exception e) {
				out.println(e);
				ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
				ut.jsBack(out);
			} finally {
				if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
			}
		}

		try {
			query		= "DELETE FROM "+ table +" WHERE ID IN ("+ delIds +")";
			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();

			ut.jsRedirect(out, "counsel_list.jsp");
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
		}


	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_tbr.jsp"%>