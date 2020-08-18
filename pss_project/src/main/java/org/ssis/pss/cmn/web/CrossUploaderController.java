package org.ssis.pss.cmn.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CrossUploaderService;
import org.ssis.pss.cmn.util.WebFactoryUtil;

@Controller
public class CrossUploaderController {

	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private CrossUploaderService CrossUploaderService;
	 
	/**
	 * 공통 리스트 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/crossUploader/fileUpload.do")
    public void fileUpload( HttpServletRequest request, HttpServletResponse response ) throws Exception {
    	//
    	logger.debug( "fileUpload:: Start" );
    	ZValue zvl = WebFactoryUtil.getAttributesInit( request ); 
    	//
		try{
			CrossUploaderService.fileUpload( request, response, zvl );
		}
		catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		logger.debug( "fileUpload:: End" );
    }

	@RequestMapping(value="/crossUploader/fileDownload.do")
    public ModelAndView  fileDownload( HttpServletRequest request, HttpServletResponse response ) throws Exception {
		
    	logger.debug( "fileDownload:: Start" );
    	
    	ModelAndView modelAndView = new ModelAndView();
    	ZValue zvl = WebFactoryUtil.getAttributesInit( request ); 
		try{
	    	logger.debug( "fileDownload:: zvl {{"+ zvl.toString() +"}}" );
	    	logger.debug( "fileDownload:: CD_DOWNLOAD_FILE_INFO {{"+ ( String )request.getParameter( "CD_DOWNLOAD_FILE_INFO" )+"}}" );
	    	 
			modelAndView.setViewName( "downloadView" );
			modelAndView.addObject( "zvl", zvl );
		}
		catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		logger.debug( "fileDownload:: End" );
		return modelAndView;
    }	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/crossUploader/fileUploadPopUp.do")
    public String fileUploadPopUp( HttpServletRequest request, HttpServletResponse response, ModelMap model ) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit( request ); 
    	
		logger.debug("file uploader zvl ################: " + zvl);
    	
 		return "/cmmn/fileUpload";
    }
}
