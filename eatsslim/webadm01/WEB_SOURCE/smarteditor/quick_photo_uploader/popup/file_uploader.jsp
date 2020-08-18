<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy, java.util.*, java.io.*"%>
<%@ include file="/lib/config.jsp"%>
<%
System.out.println("uploadDir: " + uploadDir);
String uploadPath			= uploadDir + "editor/"; // 저장할 디렉토리 (절대경로)
StringBuffer buffer = new StringBuffer();
String filename = "";
String editor_id = ut.inject(request.getParameter("editor_id"));
System.out.println("editor_id: " + editor_id);
System.out.println("uploadPath: " + uploadPath);

if(request.getContentLength() > 10*1024*1024 ){
%>
	<script>alert("업로드 용량(총 10Mytes)을 초과하였습니다.");history.back();</script>
<%
	return;
} else {
	MultipartRequest multi=new MultipartRequest(request, uploadPath, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());

	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat ("yyyy_MM_dd_HHmmss", java.util.Locale.KOREA);
	int cnt = 1;
	String upfile = multi.getFilesystemName("Filedata");
	if (!upfile.equals("")) {
		String dateString = formatter.format(new java.util.Date());
		String moveFileName = dateString + upfile.substring(upfile.lastIndexOf(".") );
		String fileExt = upfile.substring(upfile.lastIndexOf(".") + 1);
		File sourceFile = new File(uploadPath + upfile);
		File targetFile = new File(uploadPath + moveFileName);
		sourceFile.renameTo(targetFile);
		filename = moveFileName;
		System.out.println("targetFile: " + targetFile);
		System.out.println("sourceFile: " + sourceFile);
		System.out.println("filename: " + filename);
		%>
		<form id="fileform" name="fileform" method="post">
			<input type="hidden" name="filename" value="<%=filename%>">
			<input type="hidden" name="uploadPath" value="<%=uploadPath%>">
			<input type="hidden" name="editor_id" value="<%=editor_id%>">
		</form>
		<%
	}
}
%>

<script type="text/javascript">
	function fileAttach(){ 
		
		f = document.fileform;
		fpath = "/data/editor/";
	    fname = f.filename.value; 
	    fcode = fpath + fname;
		var editor_id = f.editor_id.value;
	    
	    window.close(); 
	     
	    try{
            opener.parent.pasteHTML(fcode, editor_id); 
	    }catch(e){ 
            alert(e); 
	    } 
	} 
	fileAttach();
	this.window.close();
</script>
