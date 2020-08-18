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

String savePath			= uploadDir + "banner/"; // ������ ���丮 (������)
int sizeLimit			= 2 * 1024 * 1024 ; // ȭ�Ͽ뷮����
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());

String table		= "ESL_BANNER";
String query		= "";
String mode			= ut.inject(multi.getParameter("mode"));
String pid			= ut.inject(multi.getParameter("id"));
String title		= ut.inject(multi.getParameter("title"));
String openYn		= ut.inject(multi.getParameter("open_yn"));
String stdate		= ut.inject(multi.getParameter("stdate"));
String ltdate		= ut.inject(multi.getParameter("ltdate"));
String bannerImg	= ut.inject(multi.getParameter("org_banner_img"));
String bannerType	= ut.inject(multi.getParameter("banner_type"));
String link			= ut.inject(multi.getParameter("link"));
String param		= ut.inject(multi.getParameter("param"));
String delIds		= "";
String instId		= (String)session.getAttribute("esl_admin_id");
String userIp		= request.getRemoteAddr();
String delCartImg		= ut.inject(multi.getParameter("del_cart_img"));


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

				if(formName.equals("banner_img")){					
					newFileName = "banner_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //���ϸ��� ����
					}
					bannerImg	= newFileName;
				}
			}
		}
	} catch(Exception e) {
		out.print("���� ���ε� ����..! "+e+"<br>");
	}

	if (delCartImg.length() > 0) {
		File f1 = new File(savePath+bannerImg);
		if (f1.exists()) f1.delete();
		bannerImg		= "";
	}

	
	if (mode.equals("ins")) {
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(TITLE, OPEN_YN, STDATE, LTDATE, GUBUN, BANNER_IMG, LINK, INST_ID, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	('"+ title +"', '"+ openYn +"', '"+ stdate +"', '"+ ltdate +"',";
			query		+= "	'"+ bannerType +"', '"+ bannerImg +"', '"+ link +"', '"+ instId +"', '"+ userIp +"', NOW())";
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}

		ut.jsRedirect(out, "banner_list.jsp");
	} else if (mode.equals("upd")) {
		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	TITLE			= '"+ title +"',";
			query		+= "	OPEN_YN			= '"+ openYn +"',";
			query		+= "	STDATE			= '"+ stdate +"',";
			query		+= "	LTDATE			= '"+ ltdate +"',";
			query		+= "	GUBUN			= '"+ bannerType +"',";
			query		+= "	BANNER_IMG		= '"+ bannerImg +"',";
			query		+= "	LINK			= '"+ link +"',";
			query		+= "	UPDT_ID			= '"+ instId +"',";
			query		+= "	UPDT_IP			= '"+ userIp +"',";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE ID = "+ pid;
			stmt.executeUpdate(query);

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "banner_list.jsp?"+ param);
	} else if (mode.equals("del")) {
		delIds		= ut.inject(multi.getParameter("del_ids"));

		try {
			query		= "DELETE FROM "+ table +" WHERE ID IN ("+ delIds +")";
			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();

			ut.jsRedirect(out, "banner_list.jsp");
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
		}		
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>