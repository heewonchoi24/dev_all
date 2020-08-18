package org.ssis.pss.auth.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.auth.service.AuthService;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AuthController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
		
	@Autowired
	private AuthService authService;

	@Autowired
	private UserService UserService;
	
	@Autowired
	private ConnectService connectService;	
	
	/**
	 * 권한관리 목록
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/auth/authList.do")
    public String authList(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
    	
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());

    	//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) zvl.put("pageIndex", 1);
    	zvl.put("pageUnit", 10);
    	zvl.put("pageSize", 10);
    	
    	//페이징 설정 참고용
        /** 현재페이지 */
        int pageIndex = 1;
        /** 페이지갯수 */
        int pageUnit = 10;
        /** 페이지사이즈 */
        int pageSize = 10;
        /** 첫페이지 인덱스 */
        int firstIndex = 1;
        /** 마지막페이지 인덱스 */
        int lastIndex = 1;
        /** 페이지당 레코드 개수 */
        int recordCountPerPage = 10;
    	
		List<ZValue> resultList = null;
		int resultListCnt = 0;
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(zvl.getInt("pageUnit"));
		paginationInfo.setPageSize(zvl.getInt("pageSize"));

		zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
		zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
		zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		if(!"".equals(zvl.getValue("searchTx"))){
			if("1".equals(zvl.getValue("searchGb"))) {
				zvl.put("searchSub", "%" + zvl.getValue("searchTx") + "%" );
			} else if("2".equals(zvl.getValue("searchGb"))) {
				zvl.put("searchCon", "%" + zvl.getValue("searchTx") + "%" );
			} else {
				zvl.put("searchAll", "%" + zvl.getValue("searchTx") + "%" );
			}
		}

    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			resultList = authService.authListThread(zvl);
			resultListCnt = authService.authCntThread(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
		paginationInfo.setTotalRecordCount(resultListCnt);
		
		model.addAllAttributes(zvl);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultListCnt", resultListCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("requestZvl", zvl);
		
		/* jsp화면 Sidebar 정보 */
		model.addAttribute("pageLevel1", "account");
		model.addAttribute("pageLevel2", "1");
		model.addAttribute("pageName", "권한관리");
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/auth/authList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);					
		
		return "auth/authList";
    }

	/**
	 * 게시판 글쓰기 페이지
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/auth/authWrite.do")
	public ModelAndView authWrite(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		List<ZValue> resultDetailList = null;
		List<ZValue> authList = null;
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		String isModify = (String) zvl.get("isModify");
		zvl.setValue("recordCountPerPage", "");
		try{
			if("Y".equals(isModify)) resultDetailList = authService.authListThreadDetail(zvl);
			resultList = authService.authListThread(zvl);
			authList = authService.getAuthList(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
		modelAndView.addObject("authList", authList);
		modelAndView.addObject("resultList", resultList);
		modelAndView.addObject("resultDetailList", resultDetailList);
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "auth/authWrite" );
		
		/* jsp화면 Sidebar 정보 */
		modelAndView.addObject("pageLevel1", "account");
		modelAndView.addObject("pageLevel2", "1");
		modelAndView.addObject("pageName", "권한관리");
		
		return modelAndView;
	}
	
	
	/**
	 * 권한관리 등록/수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/auth/authModify.do")
	public ModelAndView insertAuth(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ModelAndView model = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		String authorId     = EgovStringUtil.nullConvert( zvl.getValue( "authorId" ) );  
		String isModify = (String) zvl.get("isModify");
		
		try{
			if("N".equals(isModify)) {
				authService.insertAuthList(zvl, request);
				model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
				zvl.put("authorId", zvl.getValue("seq"));
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/auth/authList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.INSERT);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);			

			} else {
				authService.updateAuthList(zvl, request);
				model.addObject("message", egovMessageSource.getMessage("success.common.update"));
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/auth/authList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.UPDATE);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);							
			}
			
			authService.mergeAuthDetail(zvl, request);
			
		}catch(Exception e){
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 권한관리 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/auth/deleteAuth.do")
	public ModelAndView deleteAuth(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			
			authService.deleteAuthList(zvl, request);
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

}
