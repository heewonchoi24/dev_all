package org.ssis.pss.footer.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.footer.service.FooterService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.com.utl.fcc.service.EgovStringUtil;



@Controller
public class FooterController {

	protected Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private FooterService footerService;
	
	@Autowired
	private UserService UserService;	
	
	@Autowired
	private ConnectService connectService;	
	
	/**
	 * 푸터 텍스트 데이터 가져오기
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/footer/getfooterText.do")
	public ModelAndView getfooterText(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue resultList = null;
		
		resultList    = footerService.selectFooterText(zvl);
		
		modelAndView.addAllObjects(resultList);
		modelAndView.setViewName( "jsonView" );		
		
		return modelAndView;
		
	}
	
	/**
	 * 푸터 텍스트 관리자 화면
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/footer/footerPage.do")
	public ModelAndView footerTextPage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue resultList = null;
		
		modelAndView.addObject("pageLevel1", "contact");
		modelAndView.addObject("pageLevel2", "4");
		modelAndView.addObject("pageName", "푸터 관리");		
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		resultList    = footerService.selectFooterText(zvl);
		
		modelAndView.addObject("footerText", resultList);
		modelAndView.setViewName("footer/footerPage");
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/footer/footerPage.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);				
		
		return modelAndView;
		
	}
	
	/**
	 * 푸터 텍스트 입력/수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/footer/footerTextInsert.do")
	public ModelAndView insertFooterText(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl          	  = WebFactoryUtil.getAttributesInit(request);
		
		HttpSession session 	  = request.getSession();
		SessionVO userInfo  	  = (SessionVO) session.getAttribute("userInfo");
		
		String fId                = EgovStringUtil.nullConvert( zvl.getValue( "fId" ) );  
		zvl.put("registId", userInfo.getUserId()); 
		
		modelAndView.addObject("pageLevel1", "contact");
		modelAndView.addObject("pageLevel2", "3");
		modelAndView.addObject("pageName", "푸터 관리");
		
		try{
			if("".equals(fId)) {
				footerService.insertFooterText(zvl, request);
				modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
				modelAndView.addAllObjects(zvl);
				modelAndView.setViewName( "jsonView" );
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/footer/footerPage.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.INSERT);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);				
				
			} else {
				footerService.updateFooterText(zvl, request);
				modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
				modelAndView.addAllObjects(zvl);
				modelAndView.setViewName( "jsonView" );
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/footer/footerPage.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.UPDATE);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);				
							
			}
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
			e.printStackTrace();
		}
		
		return modelAndView;
		
	}	

}
