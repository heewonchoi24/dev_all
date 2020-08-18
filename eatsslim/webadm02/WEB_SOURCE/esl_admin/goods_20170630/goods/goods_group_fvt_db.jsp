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

String savePath			= uploadDir + "goods/"; // 저장할 디렉토리 (절대경로)
int sizeLimit			= 2 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String query			= "";
String mode				= ut.inject(multi.getParameter("mode"));
int groupId				= 0;
String pid				= ut.inject(multi.getParameter("id"));
String gubun1			= ut.inject(multi.getParameter("gubun1"));
String gubun2			= ut.inject(multi.getParameter("gubun2"));
String groupName		= ut.inject(multi.getParameter("group_name"));
String groupCode		= ut.inject(multi.getParameter("group_code"));
int groupPrice			= Integer.parseInt(multi.getParameter("group_price"));
String groupInfo		= multi.getParameter("group_info");
String offerNotice		= multi.getParameter("offer_notice");
String cartImg			= ut.inject(multi.getParameter("org_cart_img"));
String delCartImg		= ut.inject(multi.getParameter("del_cart_img"));
String param			= ut.inject(multi.getParameter("param"));
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

				if(formName.equals("cart_img")){					
					newFileName = "groupCart_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					cartImg	= newFileName;
				}
			}
		}
	} catch(Exception e) {
		out.print("파일 업로드 에러..! "+e+"<br>");
	}

	if (delCartImg.length() > 0) {
		File f1 = new File(savePath+cartImg);
		if (f1.exists()) f1.delete();
		cartImg		= "";
	}

	if (mode.equals("ins")) {
		try {
			query		= "INSERT INTO ESL_GOODS_GROUP";
			query		+= "	(GUBUN1, GUBUN2, GROUP_CODE, GROUP_NAME, GROUP_INFO, OFFER_NOTICE, CART_IMG, INST_ID, INST_IP, INST_DATE, GROUP_PRICE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";
			//ut.jsAlert(out, groupCode+"-"+groupName+"-"+offerNotice);
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, gubun1);
			pstmt.setString(2, gubun2);
			pstmt.setString(3, groupCode);
			pstmt.setString(4, groupName);
			pstmt.setString(5, groupInfo);
			pstmt.setString(6, offerNotice);
			pstmt.setString(7, cartImg);
			pstmt.setString(8, instId);
			pstmt.setString(9, userIp);
			pstmt.setInt(10, groupPrice);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		ut.jsRedirect(out, "goods_group_list.jsp");
	} else if (mode.equals("upd")) {
		try {
			query		= "UPDATE ESL_GOODS_GROUP SET ";
			query		+= "	GROUP_INFO		= ?,";
			query		+= "	OFFER_NOTICE	= ?,";
			query		+= "	CART_IMG		= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW(),";
			query		+= "	GROUP_PRICE		= ?";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, groupInfo);
			pstmt.setString(2, offerNotice);
			pstmt.setString(3, cartImg);
			pstmt.setString(4, userIp);
			pstmt.setInt(5, groupPrice);
			pstmt.setString(6, pid);
			pstmt.executeUpdate();

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}
		
		ut.jsRedirect(out, "goods_group_list.jsp?"+ param);
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>