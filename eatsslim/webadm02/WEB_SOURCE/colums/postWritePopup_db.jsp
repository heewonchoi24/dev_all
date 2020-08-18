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

String table			= "ESL_PO";
String query			= "";
String mode				= ut.inject(multi.getParameter("mode"));
String counselType		= ut.inject(multi.getParameter("counsel_type"));
String name				= ut.inject(multi.getParameter("name"));
String hp1				= ut.inject(multi.getParameter("hp1"));
String hp2				= ut.inject(multi.getParameter("hp2"));
String hp3				= ut.inject(multi.getParameter("hp3"));
String hp				= hp1 +"-"+ hp2 +"-"+ hp3;
String emailId			= ut.inject(multi.getParameter("email_id"));
String emailAddr		= ut.inject(multi.getParameter("email_addr"));
String email			= emailId +"@"+ emailAddr;
String title			= ut.inject(multi.getParameter("title"));
String content			= ut.inject(multi.getParameter("content"));
String upFile			= "";
String userIp			= request.getRemoteAddr();

String pressUrl = ut.inject(multi.getParameter("press_url"));
String instId   = ut.inject(multi.getParameter("inst_id"));

String listImg			= ut.inject(multi.getParameter("org_list_img"));
String delListImg		= ut.inject(multi.getParameter("del_list_img"));
String param			= ut.inject(multi.getParameter("param"));

int pressId				= 0;



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
					newFileName = "po_" + rndText + ext;                    
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
	

	if (mode.equals("write")) {



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
				out.println(e+"=>"+query);
				ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
				ut.jsBack(out);
				return;
			}

			ut.jsAlert(out, "��ϵǾ����ϴ�.");
			//ut.jsRedirect(out, "postScript.jsp");
			out.println("<script>opener.location.href='postScript.jsp';self.close();</script>");

	}else if (mode.equals("edit")) {

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
			query		+= " WHERE ID = ? and INST_ID='"+eslMemberId+"'";

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
			out.println(e);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}
		ut.jsAlert(out, "�����Ǿ����ϴ�.");
		//ut.jsRedirect(out, "postScript.jsp?"+ param);
		out.println("<script>opener.location.href='postScript.jsp?"+param+"';self.close();</script>");


	}else if (mode.equals("del")) {
		pressId		= Integer.parseInt(multi.getParameter("id"));

		
		try {
			query		= "DELETE FROM "+ table +" WHERE ID IN ("+ pressId +")  and INST_ID='"+eslMemberId+"' ";
			pstmt		= conn.prepareStatement(query);
			pstmt.executeUpdate();



		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}
		ut.jsAlert(out, "�����Ǿ����ϴ�.");
		//ut.jsRedirect(out, "postScript.jsp?"+ param);
		out.println("<script>opener.location.href='postScript.jsp?"+param+"';self.close();</script>");
	}

}
%>
<%@ include file="../lib/dbclose.jsp" %>