package org.ssis.pss.visual.web;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.user.service.UserService;
import org.ssis.pss.visual.service.VisualService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.LogCrud;


@Controller
public class VisualController {

	protected Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private EgovMessageSource egovMessageSource;

	@Autowired
	private VisualService visualService;
	
	@Autowired
	private UserService UserService;

	@Autowired
	private ConnectService connectService;		

	/**
	 * 컨텐츠 관리 - 메인 비주얼 관리 목록 조회
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/contact/mainVisualList.do")
	public ModelAndView mainVisualList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;

		resultList = visualService.visualList(zvl);
		modelAndView.addObject("resultList", resultList);
		
		modelAndView.addObject("pageLevel1", "contact");
		modelAndView.addObject("pageLevel2", "1");
		modelAndView.addObject("pageName", "메인 비주얼 관리");
		modelAndView.setViewName( "contact/mainVisualList" );
		
		// 로그 이력 저장
		String menu_id = "";
		String url = "/admin/contact/mainVisualList.do";
		zvl.put("url", url);
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);				

		return modelAndView;

	}

	/**
	 * 컨텐츠 관리 - 메인 비주얼 관리 등록/수정
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/admin/contact/mainVisualRegistThread.do")
	public ModelAndView mainVisualRegistThread(MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		try{
			
			String uploadPath = Globals.CROSSUPLOADER_FILE_PATH;
			Iterator<String> iterator = request.getFileNames(); 

			File file = File.createTempFile("temp_image-", ".jpg");

			MultipartFile multipartFile = null; 
			String originalFileName = null; 
			String originalFileExtension = null; 
			String storedFileName = null;

			if(file.exists() == false){ 
				file.mkdirs(); 
			}
			
			while(iterator.hasNext()){ 
				multipartFile = request.getFile(iterator.next()); 
				
				if(multipartFile.isEmpty() == false){ 
	        		originalFileName = multipartFile.getOriginalFilename();
	        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
	        		storedFileName = UUID.randomUUID().toString() + originalFileExtension;
	        		
	        		file = new File(uploadPath + storedFileName);
	        		multipartFile.transferTo(file);
	        		zvl.put("img_nm", storedFileName);
	        		zvl.put("img_path", uploadPath);
				} 
			}	
			
			visualService.visualRegistThread(zvl, request);

			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}	

		return modelAndView;
	}

}
