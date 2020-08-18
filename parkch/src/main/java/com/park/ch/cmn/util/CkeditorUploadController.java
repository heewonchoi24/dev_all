package com.park.ch.cmn.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class CkeditorUploadController {

	private static final Logger logger = LoggerFactory.getLogger(CkeditorUploadController.class);

	//파일 디렉토리 사용시
	// @Resource(name="uploadPath")
	private String uploadPath = "/upload";

	//1.파일 디렉토리 사용
	@RequestMapping(value="/ckeditorupload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload ) throws Exception{
		//1.CKEditor 에서 파일을 넘겨주는 이름이 upload 로 설정 되어 있다. 반드시 upload 로 설정
		//헤더 설정
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter =response.getWriter();

		String uploadFile="";
		String fileUrl="";
		String message="";  
		//2. 물리적 실제 저장소 에 저장하기   
		// 보안상 , jpg, jpeg, png, gif, 만 업로드 되도록 수정 
		// if(UploadSecurity.check(upload)){

		uploadFile=UploadFileUtils.ckuploadFile(uploadPath, upload.getOriginalFilename(), upload.getBytes());       
		logger.info(" uploadFile  -   {}" ,uploadFile);

		//3.URL 상에서 볼수 있는 이미지 경로
		// /displayFile?fileName="+ fileName;
		fileUrl ="/displayFile?fileName="+ uploadFile;
		message="'이미지를 업로드 했습니다.'";

		//}else{      
		//    message="'이미지 파일이 아닙니다.'";
		//}
		String callback =request.getParameter("CKEditorFuncNum");

		//4.스크립트 작성
		StringBuffer sbuffer =new StringBuffer();
		sbuffer.append("<script>window.parent.CKEDITOR.tools.callFunction(");
		sbuffer.append(callback);
		sbuffer.append(", '");
		sbuffer.append(fileUrl);
		sbuffer.append(" ' , "+message);
		sbuffer.append(") </script>");

		printWriter.println(sbuffer.toString());
		printWriter.flush();
	}




	//년월일 별로 분리하지않고 이미지 보안 처리 안하고 그냥 업로드 - request.getServletContext().getRealPath("/") 사용
	@RequestMapping(value="/ckeditorupload2")
	public void imageUpload2(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload ) throws Exception{
		//CKEditor 에서 파일을 넘겨주는 이름이 upload 로 설정 되어 있다. 반드시 upload 로 설정
		//헤더 설정
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");

		OutputStream out =null;
		PrintWriter printWriter =null;

		String fileName =upload.getOriginalFilename(); //첨부 파일 이름
		byte[] bytes =upload.getBytes(); //첨부파일을 바이트 배열로 저장


		//String uploadPath ="업로드할 디렉토리 경로" + fileName; //물리적 실제 저장소
		//UploadPath 를 사용시
		String uploadPath =UploadPath.path(request) +fileName;

		out=new FileOutputStream(new File(uploadPath));
		out.write(bytes); //서버에 파일 업로드


		String callback =request.getParameter("CKEditorFuncNum");

		printWriter=response.getWriter();
		//URL 상에서 볼수 있는 이미지 경로
		// String fileUrl =request.getContextPath()+"/upload/"+ fileName;
		String fileUrl ="/resources/upload/"+ fileName;

		String script="<script>window.parent.CKEDITOR.tools.callFunction(";
		script +=callback;
		script +=", '";
		script +=fileUrl;
		script +=" ' , '이미지를 업로드 했습니다.'";
		script +=") </script>";

		printWriter.println(script);
		printWriter.flush();


	}


	//3.년월일 별로 분리및 보안 처리 사용 - request.getServletContext().getRealPath("/") 사용
	// 1번과 차이점은 UploadPath.path(request) 의 물리적 주소와 와 
	// fileUrl ="/resources/upload/"+ uploadFile; url 상의
	//경로 차이뿐이 없다.
	@RequestMapping(value="/ckeditorupload3.do")
	public void imageUpload3(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload ) throws Exception{
		//1.CKEditor 에서 파일을 넘겨주는 이름이 upload 로 설정 되어 있다. 반드시 upload 로 설정
		//헤더 설정
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter printWriter =response.getWriter();

		String uploadFile="";
		String fileUrl="";
		String message="";  
		//2. 물리적 실제 저장소 에 저장하기   
		// 보안상 , jpg, jpeg, png, gif, 만 업로드 되도록 수정 
		//if(UploadSecurity.check(upload)){

		uploadFile=UploadFileUtils.ckuploadFile(UploadPath.path(request), upload.getOriginalFilename(), upload.getBytes());     
		logger.info(" uploadFile  -   {}" ,uploadFile);

		//3.URL 상에서 볼수 있는 이미지 경로
		// /displayFile?fileName="+ fileName
		fileUrl = uploadPath + uploadFile;
		message="'이미지를 업로드 했습니다.'";
		
		logger.info(" fileUrl  -   {}" ,fileUrl);
		
		//}else{      
		//    message="'이미지 파일이 아닙니다.'";
		//}
		String callback =request.getParameter("CKEditorFuncNum");

		//4.스크립트 작성
		StringBuffer sbuffer =new StringBuffer();
		sbuffer.append("<script>window.parent.CKEDITOR.tools.callFunction(");
		sbuffer.append(callback);
		sbuffer.append(", '");
		sbuffer.append(fileUrl);
		sbuffer.append(" ' , "+message);
		sbuffer.append(") </script>");

		printWriter.println(sbuffer.toString());
		printWriter.flush();

	}


	@RequestMapping(value="/ckeditorform")
	public String ckeditorTest(){

		return "test/ckeditor";
	}

}