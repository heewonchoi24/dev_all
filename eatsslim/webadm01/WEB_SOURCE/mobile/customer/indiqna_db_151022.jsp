<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String savePath			= uploadDir + "board/"; // 저장할 디렉토리 (절대경로)
int sizeLimit			= 2 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String table			= "ESL_COUNSEL";
String query			= "";
String mode				= ut.inject(multi.getParameter("mode"));
String counselID		= ut.inject(multi.getParameter("counselID"));
String counselType		= ut.inject(multi.getParameter("counsel_type"));
String name				= ut.inject(multi.getParameter("name"));
String hp				= ut.inject(multi.getParameter("hp"));
String email			= ut.inject(multi.getParameter("email"));
String title			= ut.inject(multi.getParameter("title"));
String content			= ut.inject(multi.getParameter("content"));
String upFile			= "";
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

				if(formName.equals("up_file")){					
					newFileName = "counsel_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					upFile	= newFileName;
				}
			}
		}
	} catch(Exception e) {
		out.print("파일 업로드 에러..! "+e+"<br>");
	}

	if ( mode.equals("ins") ) {
		try {
			query		= "INSERT INTO "+ table;
			query		+= "	(MEMBER_ID, COUNSEL_TYPE, NAME, HP, EMAIL, TITLE, CONTENT, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, eslMemberId);
			pstmt.setString(2, counselType);
			pstmt.setString(3, name);
			pstmt.setString(4, hp);
			pstmt.setString(5, email);
			pstmt.setString(6, title);
			pstmt.setString(7, content);
			pstmt.setString(8, userIp);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e+"=>"+query);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsAlert(out, "등록되었습니다.");
		ut.jsRedirect(out, "/mobile/shop/mypage/myqna.jsp");
	}
	else if ( mode.equals("mod") ) {
		try {
			query  = "UPDATE "+ table +" SET ";
			query += " counsel_type	= ?, ";
			query += " name			= ?, ";
			query += " hp			= ?, ";
			query += " email		= ?, ";
			query += " title		= ?, ";
			query += " content		= ?, ";
			query += " inst_ip		= ?  ";
			query += " WHERE id = ?";

			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, counselType);
			pstmt.setString(2, name);
			pstmt.setString(3, hp);
			pstmt.setString(4, email);
			pstmt.setString(5, title);
			pstmt.setString(6, content);
			pstmt.setString(7, userIp);
			pstmt.setString(8, counselID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e+"=>"+query);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		ut.jsAlert(out, "1:1 문의 수정이 완료되었습니다.");
		ut.jsRedirect(out, "/mobile/shop/mypage/myqna.jsp");
	}

}
%>
<%@ include file="/lib/dbclose.jsp" %>