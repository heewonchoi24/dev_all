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

String savePath				= uploadDir + "promotion/"; // 저장할 디렉토리 (절대경로)
int sizeLimit				= 2 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi		= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());

String table				= "ESL_MAIN_BANNER";
String query				= "";

String instId				= (String)session.getAttribute("esl_admin_id");
String userIp				= request.getRemoteAddr();

String mode					= ut.inject(multi.getParameter("mode"));

String topBannerType		= ut.inject(multi.getParameter("top_banner"));
String leftBannerType		= ut.inject(multi.getParameter("left_banner"));

String topImgFile			= ut.inject(multi.getParameter("top_imgFile"));
String topFirstUrl			= ut.inject(multi.getParameter("top_first_url"));
String topFirstBgcolor		= ut.inject(multi.getParameter("top_first_bgcolor"));
String topSecondUrl			= ut.inject(multi.getParameter("top_second_url"));
String topSecondBgcolor		= ut.inject(multi.getParameter("top_second_bgcolor"));

String leftFirstImgFile		= ut.inject(multi.getParameter("left_first_imgFile"));
String leftFirstUrl			= ut.inject(multi.getParameter("left_first_url"));
String leftSecondImgFile	= ut.inject(multi.getParameter("left_second_imgFile"));
String leftSecondUrl		= ut.inject(multi.getParameter("left_second_url"));
String leftThirdImgFile		= ut.inject(multi.getParameter("left_third_imgFile"));
String leftThirdUrl			= ut.inject(multi.getParameter("left_third_url"));

String topBannerOpenYn		= ut.inject(multi.getParameter("top_banner_open_yn"));
String leftBannerOpenYn		= ut.inject(multi.getParameter("left_banner_open_yn"));

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

				if(formName.equals("top_imgFile")){					
					newFileName = "banner_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					topImgFile	= newFileName;
				}

				if(formName.equals("left_first_imgFile")){					
					newFileName = "banner_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					leftFirstImgFile	= newFileName;
				}

				if(formName.equals("left_second_imgFile")){					
					newFileName = "banner_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					leftSecondImgFile	= newFileName;
				}

				if(formName.equals("left_third_imgFile")){					
					newFileName = "banner_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					leftThirdImgFile	= newFileName;
				}
			}
		}
	} catch(Exception e) {
		out.print("파일 업로드 에러..! "+e+"<br>");
	}

	if (mode.equals("upd")) {
		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	TOP_BANNER_TYPE			= '"+ topBannerType +"',";
			query		+= "	LEFT_BANNER_TYPE		= '"+ leftBannerType +"',";
			if(topImgFile!=""){
			query		+= "	TOP_IMGFILE				= '"+ topImgFile +"',";
			}
			query		+= "	TOP_FIRST_URL			= '"+ topFirstUrl +"',";
			query		+= "	TOP_FIRST_BGCOLOR		= '"+ topFirstBgcolor +"',";
			query		+= "	TOP_SECOND_URL			= '"+ topSecondUrl +"',";
			query		+= "	TOP_SECOND_BGCOLOR		= '"+ topSecondBgcolor +"',";
			if(leftFirstImgFile!=""){
			query		+= "	LEFT_FIRST_IMGFILE		= '"+ leftFirstImgFile +"',";
			}
			query		+= "	LEFT_FIRST_URL			= '"+ leftFirstUrl +"',";
			if(leftSecondImgFile!=""){
			query		+= "	LEFT_SECOND_IMGFILE		= '"+ leftSecondImgFile +"',";
			}
			query		+= "	LEFT_SECOND_URL			= '"+ leftSecondUrl +"',";
			if(leftThirdImgFile!=""){
			query		+= "	LEFT_THIRD_IMGFILE		= '"+ leftThirdImgFile +"',";
			}
			query		+= "	LEFT_THIRD_URL			= '"+ leftThirdUrl +"',";
			query		+= "	TOP_BANNER_OPEN_YN		= '"+ topBannerOpenYn +"',";
			query		+= "	LEFT_BANNER_OPEN_YN		= '"+ leftBannerOpenYn +"',";
			query		+= "	UPDT_ID					= '"+ instId +"',";
			query		+= "	UPDT_IP					= '"+ userIp +"',";
			query		+= "	UPDT_DATE				= NOW()";
			query		+= " WHERE ID = "+ 1;
			stmt.executeUpdate(query);

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsRedirect(out, "event_banner.jsp");
	} 
}
%>
<%@ include file="../lib/dbclose.jsp" %>