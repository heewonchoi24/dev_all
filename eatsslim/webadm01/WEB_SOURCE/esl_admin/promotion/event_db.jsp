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

String savePath			= uploadDir + "promotion/"; // 저장할 디렉토리 (절대경로)
int sizeLimit			= 10 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String table			= "ESL_EVENT";
String query			= "";
String mode				= ut.inject(multi.getParameter("mode"));
int eventId				= 0;
String gubun			= ut.inject(multi.getParameter("gubun"));
String eventType		= ut.inject(multi.getParameter("event_type"));
String title			= ut.inject(multi.getParameter("title"));
String stdate			= ut.inject(multi.getParameter("stdate"));
String ltdate			= ut.inject(multi.getParameter("ltdate"));
String openYn			= ut.inject(multi.getParameter("open_yn"));
String eventTarget		= ut.inject(multi.getParameter("event_target"));
String ancDate			= ut.inject(multi.getParameter("anc_date"));
String content			= multi.getParameter("content");
String mcontent			= multi.getParameter("mcontent");
String goodsNames[]		= multi.getParameterValues("goods_name");
String goodsName		= "";
String param			= ut.inject(multi.getParameter("param"));
String delIds			= "";
int delId				= 0;
String listImg			= ut.inject(multi.getParameter("org_list_img"));
String delListImg		= ut.inject(multi.getParameter("del_list_img"));

String viewImg			= ut.inject(multi.getParameter("org_view_img"));
String delViewImg		= ut.inject(multi.getParameter("del_view_img"));

String eventUrl			= ut.inject(multi.getParameter("event_url"));
String[] arrDelId;
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();
String winner			= ut.inject(multi.getParameter("winner"));

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
					newFileName = "event_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					listImg	= newFileName;
				}


				if(formName.equals("view_img")){					
					newFileName = "event_v_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					viewImg	= newFileName;

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


	if (delViewImg.length() > 0) {
		File f1 = new File(savePath+viewImg);
		if (f1.exists()) f1.delete();
		viewImg		= "";
	}
	


	if (mode.equals("ins")) {
		query		= "INSERT INTO "+ table;
		query		+= "	(EVENT_TYPE, TITLE, STDATE, LTDATE, OPEN_YN, EVENT_TARGET, ANC_DATE, CONTENT, CONTENT_MOBILE, LIST_IMG,";
		query		+= "	 EVENT_URL, HIT_CNT, INST_ID, INST_IP, INST_DATE, VIEW_IMG, GUBUN)";
		query		+= " VALUES";
		query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, ?, ?, NOW(),?,?)";
		pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		pstmt.setString(1, eventType);
		pstmt.setString(2, title);
		pstmt.setString(3, stdate);
		pstmt.setString(4, ltdate);
		pstmt.setString(5, openYn);
		pstmt.setString(6, eventTarget);
		pstmt.setString(7, ancDate);
		pstmt.setString(8, content);
		pstmt.setString(9, mcontent);
		pstmt.setString(10, listImg);
		pstmt.setString(11, eventUrl);
		pstmt.setString(12, instId);
		pstmt.setString(13, userIp);
		pstmt.setString(14, viewImg);
		pstmt.setString(15, gubun);
		pstmt.executeUpdate();
		try {
			rs			= pstmt.getGeneratedKeys();
			if (rs.next()) {
				eventId		= rs.getInt(1);
			}
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}
		rs.close();

		if (goodsNames.length > 0 && eventId > 0) {
			for (i = 1; i < goodsNames.length; i++) {
				goodsName	= goodsNames[i];

				query		= "INSERT INTO "+ table +"_GOODS ";
				query		+= "	(EVENT_ID, GOODS_NAME)";
				query		+= " VALUES";
				query		+= "	("+ eventId +", '"+ goodsName +"')";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e+"=>"+query);
					if (true) return;
				}
			}
		}

		ut.jsRedirect(out, "event_list.jsp");
	} else if (mode.equals("upd")) {
		eventId		= Integer.parseInt(multi.getParameter("id"));

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	EVENT_TYPE		= ?,";
			query		+= "	TITLE			= ?,";
			query		+= "	STDATE			= ?,";
			query		+= "	LTDATE			= ?,";
			query		+= "	OPEN_YN			= ?,";
			query		+= "	EVENT_TARGET	= ?,";
			query		+= "	ANC_DATE		= ?,";
			query		+= "	CONTENT			= ?,";
			query		+= "	CONTENT_MOBILE	= ?,";
			query		+= "	LIST_IMG		= ?,";
			query		+= "	EVENT_URL		= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW(),";
			query		+= "	VIEW_IMG		= ?,";
			query		+= "	GUBUN			= ?";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, eventType);
			pstmt.setString(2, title);
			pstmt.setString(3, stdate);
			pstmt.setString(4, ltdate);
			pstmt.setString(5, openYn);
			pstmt.setString(6, eventTarget);
			pstmt.setString(7, ancDate);
			pstmt.setString(8, content);
			pstmt.setString(9, mcontent);
			pstmt.setString(10, listImg);
			pstmt.setString(11, eventUrl);
			pstmt.setString(12, instId);
			pstmt.setString(13, userIp);
			pstmt.setString(14, viewImg);
			pstmt.setString(15, gubun);
			pstmt.setInt(16, eventId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			out.println(e);
			//ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			//ut.jsBack(out);
			return;
		}

		try {
			query		= "DELETE FROM "+ table + "_GOODS WHERE EVENT_ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, eventId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		if (goodsNames.length > 0 && eventId > 0) {
			for (i = 1; i < goodsNames.length; i++) {
				goodsName	= goodsNames[i];

				query		= "INSERT INTO "+ table +"_GOODS ";
				query		+= "	(EVENT_ID, GOODS_NAME)";
				query		+= " VALUES";
				query		+= "	("+ eventId +", '"+ goodsName +"')";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e+"=>"+query);
					if (true) return;
				}
			}
		}

		ut.jsRedirect(out, "event_list.jsp?"+ param);
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

			ut.jsRedirect(out, "event_list.jsp");
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
		}
	} else if(mode.equals("winner")) {
		eventId		= Integer.parseInt(multi.getParameter("id"));

		query		= "UPDATE "+ table +" SET WINNER = '"+ winner +"' WHERE ID = "+ eventId;
		try {
			stmt.executeUpdate(query);

			ut.jsRedirect(out, "event_list.jsp?"+ param);
		} catch(Exception e) {
			//out.println(e+"=>"+query);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
		}
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>