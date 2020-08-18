package org.ssis.pss.popup.web;

import java.io.File;
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
import org.ssis.pss.popup.service.PopupService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.LogCrud;


@Controller
public class PopupController {

	protected Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private EgovMessageSource egovMessageSource;

	@Autowired
	private PopupService popupService;

	@Autowired
	private UserService UserService;

	@Autowired
	private ConnectService connectService;		

	/**
	 * 컨텐츠 관리 - 팝업 관리 목록 조회
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/contact/popupList.do")
	public ModelAndView popupList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;

		resultList = popupService.popupList(zvl);
		modelAndView.addObject("resultList", resultList);
		
		modelAndView.addObject("pageLevel1", "contact");
		modelAndView.addObject("pageLevel2", "3");
		modelAndView.addObject("pageName", "팝업 관리");
		modelAndView.setViewName( "contact/popupList" );
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/contact/popupList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);					
		
		return modelAndView;

	}

	/**
	 * 컨텐츠 관리 - 팝업 관리 등록/수정
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/admin/contact/popupRegistThread.do")
	public ModelAndView popupRegistThread(MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			String uploadPath = Globals.CROSSUPLOADER_FILE_PATH;
			
			File file = File.createTempFile("temp_image-", ".jpg");
			
			MultipartFile imagefile_icon = request.getFile("imagefile_icon");
			MultipartFile imagefile_main1 = request.getFile("imagefile_main1");
			MultipartFile imagefile_main2 = request.getFile("imagefile_main2");

			String originalFileName = null; 
			String originalFileExtension = null; 
			String storedFileName = null;
			
			if(file.exists() == false){ 
				file.mkdirs(); 
			}			
			
			if(imagefile_icon != null){ 
	    		originalFileName = imagefile_icon.getOriginalFilename();
	    		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
	    		storedFileName = UUID.randomUUID().toString() + originalFileExtension;
        		file = new File(uploadPath + storedFileName);
        		imagefile_icon.transferTo(file);		    		
	    		
	    		zvl.put("icon_img_nm", storedFileName);
	    		zvl.put("icon_img_path", uploadPath);
			} 
			
			if(imagefile_main1 != null){ 
	    		originalFileName = imagefile_main1.getOriginalFilename();
	    		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
	    		storedFileName = UUID.randomUUID().toString() + originalFileExtension;
        		file = new File(uploadPath + storedFileName);
        		imagefile_main1.transferTo(file);	    		
	    		
	    		zvl.put("main1_img_nm", storedFileName);
	    		zvl.put("main1_img_path", uploadPath);
			} 
			
			if(imagefile_main2 != null){ 
	    		originalFileName = imagefile_main2.getOriginalFilename();
	    		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
	    		storedFileName = UUID.randomUUID().toString() + originalFileExtension;
        		file = new File(uploadPath + storedFileName);
        		imagefile_main2.transferTo(file);		    		
	    		
	    		zvl.put("main2_img_nm", storedFileName);
	    		zvl.put("main2_img_path", uploadPath);
			} 	
			
			popupService.popupRegistThread(zvl, request);

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
