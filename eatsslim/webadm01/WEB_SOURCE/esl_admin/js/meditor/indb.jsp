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
if(code==null){out.println("�ڵ尡 �������� �ʽ��ϴ�.");if(true)return;}
String savePath = uploadDir + code; // ������ ���丮 (������)
String WebPath = webUploadDir + code;
String newFileName = "";
//WebPath="/include/download.jsp?code="+code+"&filename="; //�̹������������� �ϳ�

//String savePath = request.getRealPath("/")+"upload_data\\lost\\"; // ������ ���丮 (������)
//String savePath = request.getRealPath("/");
int sizeLimit = 2 * 1024 * 1024 ; // 2�ް����� ���� �Ѿ�� ���ܹ߻�
//out.print(savePath);if(true)return;
MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
try
{
	Enumeration formNames = multi.getFileNames();  // ���� �̸� ��ȯ
	while(formNames.hasMoreElements())
	{
		String formName = (String)formNames.nextElement();
		fileName = multi.getFilesystemName(formName); // ������ �̸� ���
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

                    //���ϸ� ����
                    fileName  = savePath +"/"+ fileName; //�ý��ۻ��� �����θ� ������ ���ϸ�
                    File f1 = new File(fileName);
                    if(f1.exists()){  //���ε�� ���ϸ� �����ϸ� rename
						File newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile);  //���� ���Ͻô� ���ϸ����� ����.
					}
             }
			fileName = newFileName;

		}
	}
 } catch(Exception e) {
	out.print("ȭ�� ���ε� ����..! ");
 } 

%>
<Script Language="JavaScript">
parent.opener.mini_set_html(<%=idx%>,"<img src='<%=WebPath%>/<%=fileName%>'>");
parent.window.close();
</script>
