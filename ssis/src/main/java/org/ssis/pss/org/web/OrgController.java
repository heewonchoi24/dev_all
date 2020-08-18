package org.ssis.pss.org.web;

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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.org.service.OrgService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import twitter4j.JSONArray;

@Controller
public class OrgController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private OrgService orgService;

	@Autowired
	private UserService UserService;
	
	@Autowired
	private ConnectService connectService;	
	
	/**
	 * 기관관리 목록
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/org/orgList.do")
    public String orgList(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
    	
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());

		//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) 
    		zvl.put("pageIndex", 1);
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
		
		if(!"".equals(zvl.getValue("instt_nm"))){
			zvl.put("tInsttNm", "%" + zvl.getValue("instt_nm") + "%" );
		}

    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			resultList = orgService.orgListThread(zvl);
			resultListCnt = orgService.orgCntThread(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
		paginationInfo.setTotalRecordCount(resultListCnt);
		
		model.addAllAttributes(zvl);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultListCnt", resultListCnt);
		
		resultList = orgService.orgInsttClCdList(zvl);
		model.addAttribute("orgInsttClCdList", resultList);

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("requestZvl", zvl);
		
		//화면Sidebar정보
		model.addAttribute("pageLevel1", "account");
		model.addAttribute("pageLevel2", "4");
		model.addAttribute("pageName", "기관 관리");

		//로그 이력 저장(HC07 기관)
/*		zvl.put("parameter",  zvl.toString());
		zvl.put("conect_cd", "HC07");
		zvl.put("crud",      "R");
		UserService.connectHistoryInsert(zvl, request);*/
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/org/orgList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);				

		return "org/orgList";
    }
	
	
	/**
	 * 기관관리 기관등록
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/org/orgWrite.do")
    public String orgWrite(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
    	ZValue result = null;
    	
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());
		
		//등록, 수정 구분처리
		String gubun     = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) ); 
		if("U".equals(gubun)) {
			result = orgService.selectOrgInfo(zvl);
		}
		model.addAttribute("result", result);
		model.addAttribute("zvl", zvl);
		model.addAllAttributes(zvl);
		
		// 화면 Sidebar 정보
		model.addAttribute("pageLevel1", "account");
		model.addAttribute("pageLevel2", "4");
		model.addAttribute("pageName", "기관 관리");

		return "org/orgWrite";
    }
	
	
	/**
	 * 기관관리 등록/수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/org/orgModify.do")
	public ModelAndView orgModify(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		String gubun     = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) );  
		
		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
		
		try{
			if("I".equals(gubun)) {
				orgService.insertOrgList(zvl, request);
				model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
				
				//로그 이력 저장(HC07 기관)
/*				zvl.put("parameter",  zvl.toString());
				zvl.put("conect_cd", "HC07");
				zvl.put("crud",      "C");
				UserService.connectHistoryInsert(zvl, request);*/
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/org/orgList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.INSERT);
				zvl.put("menu_id",    menu_id);
				zvl.put("conect_cd",  "HC07");
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);		
				
			} else {
				orgService.updateOrgList(zvl, request);
				model.addObject("message", egovMessageSource.getMessage("success.common.update"));

				//로그 이력 저장(HC07 기관)
/*				zvl.put("parameter",  zvl.toString());
				zvl.put("conect_cd", "HC07");
				zvl.put("crud",      "U");
				UserService.connectHistoryInsert(zvl, request);*/
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/org/orgList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.UPDATE);
				zvl.put("menu_id",    menu_id);
				zvl.put("conect_cd",  "HC07");
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);						
			}
			
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 기관관리 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/org/deleteOrg.do")
	public ModelAndView deleteOrg(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
		try{
			orgService.deleteOrgList(zvl, request);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			
			//로그 이력 저장(HC07 기관)
/*			zvl.put("parameter",  zvl.toString());
			zvl.put("conect_cd", "HC07");
			zvl.put("crud",      "D");
			UserService.connectHistoryInsert(zvl, request);*/
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/org/orgList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.DELETE);
			zvl.put("menu_id",    menu_id);
			zvl.put("conect_cd",  "HC07");
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);				
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 기관관리 목록
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/org/orgMrrblList.do")
    public String orgMrrblList(
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

		if(!"".equals(zvl.getValue("instt_nm"))){
			zvl.put("tInsttNm", "%" + zvl.getValue("instt_nm") + "%" );
		}

    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			resultList = orgService.orgHistListThread(zvl);
			resultListCnt = orgService.orgHistCntThread(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
		paginationInfo.setTotalRecordCount(resultListCnt);
		
		model.addAllAttributes(zvl);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultListCnt", resultListCnt);
		
		resultList = orgService.orgInsttClCdList(zvl);
		model.addAttribute("orgInsttClCdList", resultList);

		resultList = orgService.orgInsttList(zvl);
		model.addAttribute("orgInsttList", resultList);

		ObjectMapper objectMapper = new ObjectMapper();
		JSONArray jsonList = new JSONArray(objectMapper.writeValueAsString(resultList));

		resultList = orgService.orgInsttAllList(zvl);
		model.addAttribute("orgInsttAllList", resultList);
		
		JSONArray jsonList2 = new JSONArray(objectMapper.writeValueAsString(resultList));

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("requestZvl", zvl);
		model.addAttribute("jsonList", jsonList);
		model.addAttribute("jsonList2", jsonList2);
		
		//화면Sidebar정보
		model.addAttribute("pageLevel1", "account");
		model.addAttribute("pageLevel2", "5");
		model.addAttribute("pageName", "기관 통폐합 관리");
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/org/orgMrrblList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);			
		
		return "org/orgMrrblList";
    }

	/**
	 * 기관 통폐합관리 등록/수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/org/orgHistModify.do")
	public ModelAndView orgHistModify(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		String gubun     = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) );  
		
		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
		
		try{
			if("I".equals(gubun)) {
				orgService.insertOrgHist(zvl, request);
				model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/org/orgMrrblList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.INSERT);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);			
				
			} else {
				orgService.updateOrgHist(zvl, request);
				model.addObject("message", egovMessageSource.getMessage("success.common.update"));
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/org/orgMrrblList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.UPDATE);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);					
			}
			
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 기관 통폐합관리 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/org/deleteHist.do")
	public ModelAndView deleteHist(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
		try{
			orgService.deleteOrgHist(zvl, request);
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/org/orgMrrblList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.DELETE);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);		
			
		}catch(Exception e){
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
			
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

}
