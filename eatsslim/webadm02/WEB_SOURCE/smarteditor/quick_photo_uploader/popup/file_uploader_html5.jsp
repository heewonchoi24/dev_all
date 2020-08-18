<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.UUID"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
 
<%
    String sFileInfo = "";
	String filename = multi.getFilesystemName("Filedata");
    //String filename = request.getHeader("file-name");
	System.out.println("filename : " + filename );
    String filename_ext = filename.substring(filename.lastIndexOf(".") + 1);
    filename_ext = filename_ext.toLowerCase();
 
    String[] allow_file = { "jpg", "png", "bmp", "gif" };
 
    //돌리면서 확장자가 이미지인지 
    int cnt = 0;
    for (int i = 0; i < allow_file.length; i++) {
        if (filename_ext.equals(allow_file[i])) {
            cnt++;
        }
    }
 
    //이미지가 아님
    if (cnt == 0) {
        out.println("NOTALLOW_" + filename);
    } else {
        //이미지이므로 신규 파일로 디렉토리 설정 및 업로드   
        //파일 기본경로
        String dftFilePath = request.getSession().getServletContext().getRealPath("/");
        //파일 기본경로 _ 상세경로
        String filePath = dftFilePath + "SE2" + File.separator + "multiupload" + File.separator;
        File file = new File(filePath);
        if (!file.exists()) {
            file.mkdirs();
        }
        String realFileNm = "";
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String today = formatter.format(new java.util.Date());
        realFileNm = today + UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf("."));
        String rlFileNm = filePath + realFileNm;
        ///////////////// 서버에 파일쓰기 ///////////////// 
        InputStream is = request.getInputStream();
        OutputStream os = new FileOutputStream(rlFileNm);
        int numRead;
        byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
        while ((numRead = is.read(b, 0, b.length)) != -1) {
            os.write(b, 0, numRead);
        }
        if (is != null) {
            is.close();
        }
        os.flush();
        os.close();
        ///////////////// 서버에 파일쓰기 /////////////////
 
        // 정보 출력
        sFileInfo += "&bNewLine=true";    
        sFileInfo += "&sFileName=" + filename;    
        sFileInfo += "&sFileURL=/smarteditorSample/SE2/multiupload/"+realFileNm;
        out.println(sFileInfo);
    }
%>
