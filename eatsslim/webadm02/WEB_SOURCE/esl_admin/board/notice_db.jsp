<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String savePath			= uploadDir + "board/"; // 저장할 디렉토리 (절대경로)
int sizeLimit			= 2 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String table			= "ESL_NOTICE";
String query			= "";
String mode				= ut.inject(multi.getParameter("mode"));
int noticeId			= 0;
String topYn			= ut.inject(multi.getParameter("top_yn"));
String title			= ut.inject(multi.getParameter("title"));
String content			= ut.inject(multi.getParameter("content"));
String param			= ut.inject(multi.getParameter("param"));
String delIds			= "";
int delId				= 0;
String listImg			= ut.inject(multi.getParameter("org_list_img"));
String delListImg		= ut.inject(multi.getParameter("del_list_img"));
String[] arrDelId;
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();

if (mode != null) {
	try {
		//--------------------------------------------
		long currentTime		= System.currentTimeMillis();
		SimpleDateFormat simDf	= new SimpleDateFormat("yyMMddHHmmss");
		int randomNumber		= (int)(Math.random()*100000);
		int dot					= 0;
		String ext				= "";
		String newFileName		= "";
		String rndText			= String.valueOf(randomNumber) + simDf.format(new Date(currentTime));
		File f1, newFile;
		//--------------------------------------------

		Enumeration formNames = multi.getFileNames();  // 폼의 이름 반환
		while (formNames.hasMoreElements()) {
			String formName		= (String)formNames.nextElement();
			String ufileName	= multi.getFilesystemName(formName); // 파일의 이름 얻기
			if (ufileName != null) {
				dot	= ufileName.lastIndexOf(".");
				if (dot != -1) {
					ext = ufileName.substring(dot);
				} else {
					ext = "";
				}
				f1	= new File(savePath +"/"+ ufileName);

				if(formName.equals("list_img")){					
					newFileName = "notice_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					listImg	= newFileName;
				}
			}
		}
	} catch(Exception e) {
		out.print("파일 업로드 에러..! "+e+"<br>");
	}

	if (delListImg.length() > 0) {
		File f1 = new File(savePath+listImg);
		if (f1.exists()) f1.delete();
		listImg		= "";
	}

	if (mode.equals("ins")) {
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(TOP_YN, TITLE, CONTENT, LIST_IMG, HIT_CNT, INST_ID, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, 0, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, topYn);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, listImg);
			pstmt.setString(5, instId);
			pstmt.setString(6, userIp);
			pstmt.executeUpdate();
		} catch (Exception e) {
			out.println(e+"=>"+query);
			//ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			//ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "notice_list.jsp");
	} else if (mode.equals("upd")) {
		noticeId		= Integer.parseInt(multi.getParameter("id"));

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	TOP_YN			= ?,";
			query		+= "	TITLE			= ?,";
			query		+= "	CONTENT			= ?,";
			query		+= "	LIST_IMG		= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, topYn);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, listImg);
			pstmt.setString(5, instId);
			pstmt.setString(6, userIp);
			pstmt.setInt(7, noticeId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "notice_list.jsp?"+ param);
	} else if (mode.equals("del")) {
		delIds		= ut.inject(multi.getParameter("del_ids"));

		arrDelId	= delIds.split(",");
		for (i = 0; i < arrDelId.length; i++) {
			delId		= Integer.parseInt(arrDelId[i]);

			try {
				query		= "SELECT LIST_IMG FROM "+ table +" WHERE ID = ?";
				pstmt		= conn.prepareStatement(query);
				pstmt.setInt(1, delId);
				rs			= pstmt.executeQuery();

				if (rs.next()) {
					listImg		= rs.getString("LIST_IMG");

					if (listImg != null && listImg.length() > 0) {
						File f1		= new File(savePath+listImg);
						if (f1.exists()) f1.delete();
					}
				}
			} catch (Exception e) {
				//out.println(e);
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

			ut.jsRedirect(out, "notice_list.jsp");
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
		}
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>