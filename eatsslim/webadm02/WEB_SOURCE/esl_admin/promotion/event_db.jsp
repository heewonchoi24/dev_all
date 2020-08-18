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
System.out.println("savePath: " + savePath);
int sizeLimit			= 10 * 1024		* 1024 ; // 화일용량제한
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
String content			= ut.inject(multi.getParameter("content"));
String mcontent			= ut.inject(multi.getParameter("mcontent"));
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

String dw_yn			= ut.inject(multi.getParameter("dw_yn"));	// 무조건 다운 가능: DW, 댓글 등록 시 다운 가능: RDW
String imgMapLocal_p1	= ut.inject(multi.getParameter("imgMapLocal_p1"));
String coupon_num_p1	= ut.inject(multi.getParameter("coupon_num_p1"));
String imgMapLocal_p2	= ut.inject(multi.getParameter("imgMapLocal_p2"));
String coupon_num_p2	= ut.inject(multi.getParameter("coupon_num_p2"));
String imgMapLocal_p3	= ut.inject(multi.getParameter("imgMapLocal_p3"));
String coupon_num_p3	= ut.inject(multi.getParameter("coupon_num_p3"));

String imgMapLocal_m1	= ut.inject(multi.getParameter("imgMapLocal_m1"));
String coupon_num_m1	= ut.inject(multi.getParameter("coupon_num_m1"));
String imgMapLocal_m2	= ut.inject(multi.getParameter("imgMapLocal_m2"));
String coupon_num_m2	= ut.inject(multi.getParameter("coupon_num_m2"));
String imgMapLocal_m3	= ut.inject(multi.getParameter("imgMapLocal_m3"));
String coupon_num_m3	= ut.inject(multi.getParameter("coupon_num_m3"));

String imgMapLocal_p4	= ut.inject(multi.getParameter("imgMapLocal_p4"));
String link_num_p4		= ut.inject(multi.getParameter("link_num_p4"));
String imgMapLocal_p5	= ut.inject(multi.getParameter("imgMapLocal_p5"));
String link_num_p5		= ut.inject(multi.getParameter("link_num_p5"));
String imgMapLocal_p6	= ut.inject(multi.getParameter("imgMapLocal_p6"));
String link_num_p6		= ut.inject(multi.getParameter("link_num_p6"));

String imgMapLocal_m4	= ut.inject(multi.getParameter("imgMapLocal_m4"));
String link_num_m4		= ut.inject(multi.getParameter("link_num_m4"));
String imgMapLocal_m5	= ut.inject(multi.getParameter("imgMapLocal_m5"));
String link_num_m5		= ut.inject(multi.getParameter("link_num_m5"));
String imgMapLocal_m6	= ut.inject(multi.getParameter("imgMapLocal_m6"));
String link_num_m6		= ut.inject(multi.getParameter("link_num_m6"));

String imgMapLocal_p7   = ut.inject(multi.getParameter("imgMapLocal_p7"));
String link_num_p7		= ut.inject(multi.getParameter("link_num_p7"));
String imgMapLocal_p8   = ut.inject(multi.getParameter("imgMapLocal_p8"));
String link_num_p8		= ut.inject(multi.getParameter("link_num_p8"));

String imgMapLocal_m7   = ut.inject(multi.getParameter("imgMapLocal_m7"));
String link_num_m7		= ut.inject(multi.getParameter("link_num_m7"));
String imgMapLocal_m8   = ut.inject(multi.getParameter("imgMapLocal_m8"));
String link_num_m8		= ut.inject(multi.getParameter("link_num_m8"));

System.out.println("dw_yn: " + dw_yn);

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

				if(formName.equals("content")){					
					newFileName = "event_v_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					content	= newFileName;
				}

				if(formName.equals("mcontent")){					
					newFileName = "event_v_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					mcontent	= newFileName;
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
		query		+= "	 EVENT_URL, HIT_CNT, INST_ID, INST_IP, INST_DATE, VIEW_IMG, GUBUN, DW_YN, IMG_P1, COUPON_NUM_P1, IMG_P2, COUPON_NUM_P2, IMG_P3, COUPON_NUM_P3, IMG_M1, COUPON_NUM_M1, IMG_M2, COUPON_NUM_M2, IMG_M3, COUPON_NUM_M3, IMG_P4, HL_P4, IMG_P5, HL_P5, IMG_P6, HL_P6, IMG_M4, HL_M4, IMG_M5, HL_M5, IMG_M6, HL_M6, IMG_P7, HL_P7, IMG_P8, HL_P8, IMG_M7, HL_M7, IMG_M8, HL_M8)";
		query		+= " VALUES";
		query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, ?, ?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
		pstmt.setString(16, dw_yn);
		pstmt.setString(17, imgMapLocal_p1);
		pstmt.setString(18, coupon_num_p1);
		pstmt.setString(19, imgMapLocal_p2);
		pstmt.setString(20, coupon_num_p2);
		pstmt.setString(21, imgMapLocal_p3);
		pstmt.setString(22, coupon_num_p3);
		pstmt.setString(23, imgMapLocal_m1);
		pstmt.setString(24, coupon_num_m1);
		pstmt.setString(25, imgMapLocal_m2);
		pstmt.setString(26, coupon_num_m2);
		pstmt.setString(27, imgMapLocal_m3);
		pstmt.setString(28, coupon_num_m3);
		pstmt.setString(29, imgMapLocal_p4);
		pstmt.setString(30, link_num_p4);
		pstmt.setString(31, imgMapLocal_p5);
		pstmt.setString(32, link_num_p5);
		pstmt.setString(33, imgMapLocal_p6);
		pstmt.setString(34, link_num_p6);
		pstmt.setString(35, imgMapLocal_m4);
		pstmt.setString(36, link_num_m4);
		pstmt.setString(37, imgMapLocal_m5);
		pstmt.setString(38, link_num_m5);
		pstmt.setString(39, imgMapLocal_m6);
		pstmt.setString(40, link_num_m6);
		pstmt.setString(41, imgMapLocal_p7);
		pstmt.setString(42, link_num_p7);
		pstmt.setString(43, imgMapLocal_p8);
		pstmt.setString(44, link_num_p8);
		pstmt.setString(45, imgMapLocal_m7);
		pstmt.setString(46, link_num_m7);
		pstmt.setString(47, imgMapLocal_m8);
		pstmt.setString(48, link_num_m8);
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
		int j = 1;
		eventId	= Integer.parseInt(multi.getParameter("id"));
		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	EVENT_TYPE		= ?,";
			query		+= "	TITLE			= ?,";
			query		+= "	STDATE			= ?,";
			query		+= "	LTDATE			= ?,";
			query		+= "	OPEN_YN			= ?,";
			query		+= "	EVENT_TARGET	= ?,";
			query		+= "	ANC_DATE		= ?,";
			if(content.length() > 0){
			query		+= "	CONTENT			= ?,";
			}
			if(mcontent.length() > 0){
			query		+= "	CONTENT_MOBILE	= ?,";
			}
			query		+= "	LIST_IMG		= ?,";
			query		+= "	EVENT_URL		= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW(),";
			query		+= "	VIEW_IMG		= ?,";
			query		+= "	GUBUN			= ?,";
			query		+= "	DW_YN           = ?,";
			query		+= "	IMG_P1			= ?,";
			query		+= "	COUPON_NUM_P1   = ?,";
			query		+= "	IMG_P2			= ?,";
			query		+= "	COUPON_NUM_P2   = ?,";
			query		+= "	IMG_P3			= ?,";
			query		+= "	COUPON_NUM_P3	= ?,";
			query		+= "	IMG_M1			= ?,";
			query		+= "	COUPON_NUM_M1   = ?,";
			query		+= "	IMG_M2			= ?,";
			query		+= "	COUPON_NUM_M2   = ?,";
			query		+= "	IMG_M3			= ?,";
			query		+= "	COUPON_NUM_M3   = ?,";
			query		+= "	IMG_P4			= ?,";
			query		+= "	HL_P4			= ?,";
			query		+= "	IMG_P5			= ?,";
			query		+= "	HL_P5			= ?,";
			query		+= "	IMG_P6			= ?,";
			query		+= "	HL_P6			= ?,";
			query		+= "	IMG_M4			= ?,";
			query		+= "	HL_M4			= ?,";
			query		+= "	IMG_M5			= ?,";
			query		+= "	HL_M5			= ?,";
			query		+= "	IMG_M6			= ?,";
			query		+= "	HL_M6			= ?,";
			query		+= "	IMG_P7			= ?,";
			query		+= "	HL_P7			= ?,";
			query		+= "	IMG_P8			= ?,";
			query		+= "	HL_P8			= ?,";
			query		+= "	IMG_M7			= ?,";
			query		+= "	HL_M7			= ?,";
			query		+= "	IMG_M8			= ?,";
			query		+= "	HL_M8			= ? ";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(j++, eventType);
			pstmt.setString(j++, title);
			pstmt.setString(j++, stdate);
			pstmt.setString(j++, ltdate);
			pstmt.setString(j++, openYn);
			pstmt.setString(j++, eventTarget);
			pstmt.setString(j++, ancDate);
			if(content.length() > 0){
			pstmt.setString(j++, content);
			}
			if(mcontent.length() > 0){
			pstmt.setString(j++, mcontent);
			}
			pstmt.setString(j++, listImg);
			pstmt.setString(j++, eventUrl);
			pstmt.setString(j++, instId);
			pstmt.setString(j++, userIp);
			pstmt.setString(j++, viewImg);
			pstmt.setString(j++, gubun);		
			pstmt.setString(j++, dw_yn);
			pstmt.setString(j++, imgMapLocal_p1);
			pstmt.setString(j++, coupon_num_p1);
			pstmt.setString(j++, imgMapLocal_p2);
			pstmt.setString(j++, coupon_num_p2);
			pstmt.setString(j++, imgMapLocal_p3);
			pstmt.setString(j++, coupon_num_p3);
			pstmt.setString(j++, imgMapLocal_m1);
			pstmt.setString(j++, coupon_num_m1);
			pstmt.setString(j++, imgMapLocal_m2);
			pstmt.setString(j++, coupon_num_m2);
			pstmt.setString(j++, imgMapLocal_m3);
			pstmt.setString(j++, coupon_num_m3);
			pstmt.setString(j++, imgMapLocal_p4);
			pstmt.setString(j++, link_num_p4);
			pstmt.setString(j++, imgMapLocal_p5);
			pstmt.setString(j++, link_num_p5);
			pstmt.setString(j++, imgMapLocal_p6);
			pstmt.setString(j++, link_num_p6);
			pstmt.setString(j++, imgMapLocal_m4);
			pstmt.setString(j++, link_num_m4);
			pstmt.setString(j++, imgMapLocal_m5);
			pstmt.setString(j++, link_num_m5);
			pstmt.setString(j++, imgMapLocal_m6);
			pstmt.setString(j++, link_num_m6);
			pstmt.setString(j++, imgMapLocal_p7);
			pstmt.setString(j++, link_num_p7);
			pstmt.setString(j++, imgMapLocal_p8);
			pstmt.setString(j++, link_num_p8);
			pstmt.setString(j++, imgMapLocal_m7);
			pstmt.setString(j++, link_num_m7);
			pstmt.setString(j++, imgMapLocal_m8);
			pstmt.setString(j++, link_num_m8);
			pstmt.setInt(j++, eventId);
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