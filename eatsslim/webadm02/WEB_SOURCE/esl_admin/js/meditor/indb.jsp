<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.File" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ include file="/inc/common.jsp"%>
<%
//request.setCharacterEncoding("euc-kr");
String file_name = null;
String fileName = "";
code=request.getParameter("code");
String idx=request.getParameter("idx");
if(idx==null)idx="0";
if(code==null){out.println("코드가 존재하지 않습니다.");if(true)return;}
String savePath = uploadDir + code; // 저장할 디렉토리 (절대경로)
String WebPath = webUploadDir + code;
String newFileName = "";
//WebPath="/include/download.jsp?code="+code+"&filename="; //이미지저장폴더는 하나

//String savePath = request.getRealPath("/")+"upload_data\\lost\\"; // 저장할 디렉토리 (절대경로)
//String savePath = request.getRealPath("/");
int sizeLimit = 2 * 1024 * 1024 ; // 2메가까지 제한 넘어서면 예외발생
//out.print(savePath);if(true)return;
MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
try
{
	Enumeration formNames = multi.getFileNames();  // 폼의 이름 반환
	while(formNames.hasMoreElements())
	{
		String formName = (String)formNames.nextElement();
		fileName = multi.getFilesystemName(formName); // 파일의 이름 얻기
		if(formName.equals("attachfile")){

             if(!fileName.equals("")) {
					////////////////////////////////////////////////////////////////////////////////////////////////
					 //String newFileName   = "aaa.jpg";
					long currentTime = System.currentTimeMillis();
					SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");
					int randomNumber = (int)(Math.random()*100000);
					int dot = fileName.lastIndexOf(".");
					String ext = null;
					if (dot != -1) {
						ext = fileName.substring(dot);
					}   
					else {   
						ext = "";
					}
					newFileName = "IMG_" + randomNumber + simDf.format(new Date(currentTime)) + ext;
					////////////////////////////////////////////////////////////////////////////////////////////////

                    //파일명 구함
                    fileName  = savePath +"/"+ fileName; //시스템상의 절대경로를 포함한 파일명
                    File f1 = new File(fileName);
                    if(f1.exists()){  //업로드된 파일명 존재하면 rename
						File newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile);  //님이 원하시는 파일명으로 변경.
					}
             }
			fileName = newFileName;

		}
	}
 } catch(Exception e) {
	out.print("화일 업로드 에러..! ");
 } 

%>
<Script Language="JavaScript">
parent.opener.mini_set_html(<%=idx%>,"<img src='<%=WebPath%>/<%=fileName%>'>");
parent.window.close();
</script>
