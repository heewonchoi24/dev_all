package org.ssis.pss.cmn.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.AbstractView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CrossUploaderService;
import org.ssis.pss.cmn.util.WebFactoryUtil;

@Service
public class CrossUploaderView extends AbstractView {
	//
	protected Logger log = LogManager.getLogger(this.getClass()); 

	@Autowired 
	private CrossUploaderService CrossUploaderService;
	
	public CrossUploaderView() {
		setContentType("applictaiton/download; charset=utf-8");
	}
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.debug( "renderMergedOutputModel :: Start..." );
    	ZValue zvl = WebFactoryUtil.getAttributesInit( request ); 
		log.debug( "renderMergedOutputModel :: zvl {{"+ zvl +"}}" );
		try {
			CrossUploaderService.fileDownload( request, response,  zvl) ;
		} catch(Exception e) {
			//throw e;
			response.sendRedirect("/exception/error.do");
		}
		log.debug( "renderMergedOutputModel :: End..." );
	}
	
}
