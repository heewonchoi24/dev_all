package org.ssis.pss.quickMenu.web;

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
import org.ssis.pss.quickMenu.service.QuickMenuService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.LogCrud;


@Controller
public class QuickMenuController {

	protected Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private EgovMessageSource egovMessageSource;

	@Autowired
	private QuickMenuService quickMenuService;
	
	@Autowired
	private UserService UserService;

	@Autowired
	private ConnectService connectService;		
	
	/**
	 * 컨텐츠 관리 - 퀵메뉴 관리 목록 조회
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/contact/quickMenuList.do")
	public ModelAndView quickMenuList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		zvl.put("open_yn", "");

		resultList = quickMenuService.quickMenuList(zvl);
		modelAndView.addObject("resultList", resultList);
		
		modelAndView.addObject("pageLevel1", "contact");
		modelAndView.addObject("pageLevel2", "7");
		modelAndView.addObject("pageName", "퀵메뉴 관리");
		modelAndView.setViewName( "contact/quickMenuList" );
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/contact/quickMenuList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);				

		return modelAndView;

	}

	/**
	 * 컨텐츠 관리 - 퀵메뉴 관리 등록/수정
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/admin/contact/quickMenuRegistThread.do")
	public ModelAndView quickMenuRegistThread(MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		
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
			
			quickMenuService.quickMenuRegistThread(zvl, request);

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
	
	/**
	 * 프론트 퀵메뉴 불러오기
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/contact/quickMenuCall.do")
	public ModelAndView quickMenuCall(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		try{
			resultList = quickMenuService.quickMenuList(zvl);
			modelAndView.setViewName( "jsonView" );
			modelAndView.addObject("quickMenuList", resultList);
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}

		return modelAndView;
	}
	
}
