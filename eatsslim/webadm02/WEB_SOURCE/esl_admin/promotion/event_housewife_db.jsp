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

String savePath			= uploadDir + "promotion/"; // ������ ���丮 (������)
int sizeLimit			= 2 * 1024 * 1024 ; // ȭ�Ͽ뷮����
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String table			= "ESL_EVENT_HOUSEWIFE";
String query			= "";
String mode				= ut.inject(multi.getParameter("mode"));
int pressId				= 0;
String title			= ut.inject(multi.getParameter("title"));
String content			= ut.inject(multi.getParameter("content"));
String param			= ut.inject(multi.getParameter("param"));
String delIds			= "";
int delId				= 0;
String listImg			= ut.inject(multi.getParameter("org_list_img"));
String delListImg		= ut.inject(multi.getParameter("del_list_img"));
String pressUrl			= ut.inject(multi.getParameter("press_url"));
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

		Enumeration formNames = multi.getFileNames();  // ���� �̸� ��ȯ
		while (formNames.hasMoreElements()) {
			String formName		= (String)formNames.nextElement();
			String ufileName	= multi.getFilesystemName(formName); // ������ �̸� ���
			if (ufileName != null) {
				dot	= ufileName.lastIndexOf(".");
				if (dot != -1) {
					ext = ufileName.substring(dot);
				} else {
					ext = "";
				}
				f1	= new File(savePath +"/"+ ufileName);

				if(formName.equals("list_img")){					
					newFileName = "observe_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //���ϸ��� ����
					}
					listImg	= newFileName;
				}
			}
		}
	} catch(Exception e) {
		out.print("���� ���ε� ����..! "+e+"<br>");
	}

	if (delListImg.length() > 0) {
		File f1 = new File(savePath+listImg);
		if (f1.exists()) f1.delete();
		listImg		= "";
	}

	if (mode.equals("ins")) {
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(TITLE, CONTENT, LIST_IMG, PRESS_URL, HIT_CNT, INST_ID, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, 0, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, listImg);
			pstmt.setString(4, pressUrl);
			pstmt.setString(5, instId);
			pstmt.setString(6, userIp);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "event_housewife.jsp");
	} else if (mode.equals("upd")) {
		pressId		= Integer.parseInt(multi.getParameter("id"));

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	TITLE			= ?,";
			query		+= "	CONTENT			= ?,";
			query		+= "	LIST_IMG		= ?,";
			query		+= "	PRESS_URL		= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, listImg);
			pstmt.setString(4, pressUrl);
			pstmt.setString(5, instId);
			pstmt.setString(6, userIp);
			pstmt.setInt(7, pressId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "event_housewife.jsp?"+ param);
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
				out.println(e);
				ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
				ut.jsBack(out);
			} finally {
				if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
			}
		}
		
		query		= "DELETE FROM "+ table +"_REPLY WHERE ID IN ("+ delIds +")";
		stmt.executeUpdate(query);
		try {
			ut.jsRedirect(out, "event_housewife.jsp");
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
		}

		try {
			query		= "DELETE FROM "+ table +" WHERE ID IN ("+ delIds +")";
			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();

			ut.jsRedirect(out, "event_housewife.jsp");
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
		}
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>