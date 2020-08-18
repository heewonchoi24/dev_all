package org.ssis.pss.menu.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.menu.service.MenuService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import twitter4j.JSONArray;

@Controller
public class MenuController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
		
	@Autowired
	private CmnService cmnService;
	
	@Autowired
	private MenuService menuService;

	@Autowired
	private UserService UserService;

	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private ConnectService connectService;		
	
	/**
	 * 메뉴관리 리스트
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/admin/menu/menuList.do")
	public ModelAndView menuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/menu/menuList" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		int totalCnt = 0; 
		int totalPageCnt = 0;
		
		//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) zvl.put("pageIndex", 1);
    	zvl.put("pageUnit", 10);
    	zvl.put("pageSize", 10);
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(zvl.getInt("pageUnit"));
		paginationInfo.setPageSize(zvl.getInt("pageSize"));
		
		zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
		zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
		zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		List<ZValue> resultList = menuService.selectMenuList(zvl);
		
		totalCnt = menuService.selectMenuTotalCnt(zvl);
		totalPageCnt = (int) Math.ceil((double)totalCnt/(double)10);
		
		logger.debug("############## zvl ##############");
		logger.debug(totalPageCnt);
		logger.debug("############## zvl ##############");
		
		model.addObject("totalCnt", totalCnt);
		model.addObject("totalPageCnt", totalPageCnt);
		
		paginationInfo.setTotalRecordCount(totalCnt);
		
		model.addAllObjects(zvl);
		model.addObject("paginationInfo", paginationInfo);
		model.addObject("resultList", resultList);

		/* jsp화면 Sidebar 정보 */
		model.addObject("pageLevel1", "contact");
		model.addObject("pageLevel2", "5");
		model.addObject("pageName", "메뉴 관리");
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/menu/menuList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("conect_cd",  "HC08");
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);				

		return model;
	}
	
	/**
	 * 메뉴 등록 화면
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/admin/menu/createMenu.do")
	public ModelAndView createMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/menu/createMenu" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		zvl.put("mode", "C");
		
		List<ZValue> resultList = menuService.selectMenuList(zvl);
		
		List<ZValue> authList = cmnService.retrieveAuthorList();
		
		ObjectMapper objectMapper = new ObjectMapper();
		JSONArray jsonList = new JSONArray(objectMapper.writeValueAsString(resultList));
				
		model.addAllObjects(zvl);
		model.addObject("resultList", resultList);
		model.addObject("authList", authList);
		model.addObject("jsonList", jsonList);
		
		/* jsp화면 Sidebar 정보 */
		model.addObject("pageLevel1", "contact");
		model.addObject("pageLevel2", "5");
		model.addObject("pageName", "메뉴 관리");
		
		return model;
	}
	
	/**
	 * 메뉴 권한 체크
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/menu/menuAuthChek.do")
	public ModelAndView menuAuthChek(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> resultList = menuService.selectDistinctAuthorId(zvl);
			
		model.addObject("resultList", resultList);
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	
	/**
	 * 메뉴 등록
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/menu/insertMenu.do")
	public ModelAndView insertMenu(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			menuService.insertMenu(zvl, request);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.insert"));

			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/menu/menuList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.INSERT);
			zvl.put("menu_id",    menu_id);
			zvl.put("conect_cd",  "HC08");
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);					

		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	
	/**
	 * 메뉴 수정 화면
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/admin/menu/modifyMenu.do")
	public ModelAndView modifyMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/menu/modifyMenu" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		zvl.put("mode", "C");
		
		List<ZValue> resultList = menuService.selectMenuList(zvl);
		
		ZValue result = menuService.selectMenu(zvl);
		
		List<ZValue> userAuthList = menuService.selectDistinctAuthorId(zvl);
		
		List<ZValue> authList = cmnService.retrieveAuthorList();
		
		ObjectMapper objectMapper = new ObjectMapper();
		JSONArray jsonList = new JSONArray(objectMapper.writeValueAsString(resultList));
		
		String displayLevel = zvl.getValue("displayLevel");
		if("1".equals(displayLevel)) {
			zvl.put("menuId_1", zvl.getValue("menuId"));
		} else if("2".equals(displayLevel)) {
			zvl.put("menuId_1", zvl.getValue("upperMenuId"));
			zvl.put("menuId_2", zvl.getValue("menuId"));
		} else {
			zvl.put("menuId_1", menuService.selectUpperMenuId(zvl));
			zvl.put("menuId_2", zvl.getValue("upperMenuId"));
			zvl.put("menuId_3", zvl.getValue("menuId"));
		}
				
		model.addAllObjects(zvl);
		model.addObject("resultList", resultList);
		model.addObject("result", result);
		model.addObject("userAuthList", userAuthList);
		model.addObject("authList", authList);
		model.addObject("jsonList", jsonList);
		
		/* jsp화면 Sidebar 정보 */
		model.addObject("pageLevel1", "contact");
		model.addObject("pageLevel2", "5");
		model.addObject("pageName", "메뉴 관리");
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/menu/menuList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.UPDATE);
		zvl.put("menu_id",    menu_id);
		zvl.put("conect_cd",  "HC08");
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);					
		
		return model;
	}
	
	/**
	 * 메뉴 수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/menu/updateMenu.do")
	public ModelAndView updateMenu(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			menuService.updateMenu(zvl, request);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.update"));
			
			//로그 이력 저장(HC08 메뉴)
			zvl.put("parameter",  zvl.toString());
			zvl.put("conect_cd", "HC08");
			zvl.put("crud",      LogCrud.UPDATE);
			UserService.connectHistoryInsert(zvl, request);

		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	
	/**
	 * 메뉴 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/menu/deleteMenu.do")
	public ModelAndView deleteMenu(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			menuService.deleteMenu(zvl, request);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			
			//로그 이력 저장(HC08 메뉴)
			zvl.put("parameter",  zvl.toString());
			zvl.put("conect_cd", "HC08");
			zvl.put("crud",      LogCrud.DELETE);
			UserService.connectHistoryInsert(zvl, request);
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
}