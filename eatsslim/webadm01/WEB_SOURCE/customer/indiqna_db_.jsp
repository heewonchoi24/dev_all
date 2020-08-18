<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_tbr.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
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
String mode				= ut.inject(multi.getParameter("mode"));
String counselID		= ut.inject(multi.getParameter("counselID"));
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
String listImg			= ut.inject(multi.getParameter("org_list_img"));
String delListImg		= ut.inject(multi.getParameter("del_list_img"));
String upFile			= "";
String userIp			= request.getRemoteAddr();
int counselId			= 0;
String customerNum		= "";
String hdBcode			= "";
String hdScode			= "";
String claimGubun		= "";
String ecs_cate1		= ut.inject(multi.getParameter("ecs_type1"));
String ecs_cate2		= ut.inject(multi.getParameter("ecs_type2"));
String ecs_cate3		= ut.inject(multi.getParameter("ecs_type3"));
//===============================날짜
Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //오늘
String cDate=(new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());

//out.println (counselID);
//if ( true ) return;

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
			String ufileName2	= multi.getOriginalFileName(formName); // 파일의 이름 얻기
			System.out.print(ufileName);
			System.out.print(ufileName2);
			if (ufileName != null) {
				dot	= ufileName.lastIndexOf(".");
				if (dot != -1) {
					ext = ufileName.substring(dot);
				} else {
					ext = "";
				}
				f1	= new File(savePath +"/"+ ufileName);
				System.out.println(ext);
				
				System.out.println(formName);

				if(formName.equals("up_file")){					
					newFileName = "qna_" + rndText + ext;   
						System.out.println(newFileName);
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

	if (delListImg.length() > 0) {
		File f1 = new File(savePath+listImg);
		if (f1.exists()) f1.delete();
		listImg		= "";
	}

	query1		= "SELECT CUSTOMER_NUM FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"'";
	try {
		rs1	= stmt.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	if (rs1.next()) {
		customerNum		= rs1.getString("CUSTOMER_NUM");
	}

	if ( mode.equals("ins") ) {

		ut.jsAlert(out, "1;1 문의가 등록되었습니다.");
		ut.jsRedirect(out, "/shop/mypage/myqna.jsp");
	}
	else if ( mode.equals("mod") ) {


		ut.jsAlert(out, "1:1 문의 수정이 완료되었습니다.");
		ut.jsRedirect(out, "/customer/indiqna.jsp?counselID="+ counselID);
	}
}
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_tbr.jsp"%>