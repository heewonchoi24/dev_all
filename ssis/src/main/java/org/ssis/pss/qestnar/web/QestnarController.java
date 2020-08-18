package org.ssis.pss.qestnar.web;

import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.qestnar.service.QestnarService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class QestnarController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private QestnarService qestnarService;
	
	@Autowired
	private UserService UserService;

	@Autowired
	private ConnectService connectService;		
	
	/**
	 * 설문관리 목록
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/qestnar/qestnarList.do")
    public String qestnarList(
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

		if(!"".equals(zvl.getValue("qustrnCn"))){
			zvl.put("searchSub", "%" + zvl.getValue("qustrnCn") + "%" );
		}

    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			resultList = qestnarService.qestnarListThread(zvl);
			resultListCnt = qestnarService.qestnarCntThread(zvl);
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
		model.addAttribute("pageLevel1", "contact");
		model.addAttribute("pageLevel2", "6");
		model.addAttribute("pageName", "설문조사관리");
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/qestnar/qestnarList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);				
		
		return "qestnar/qestnarList";
    }


	/**
	 * 설문관리 등록/수정 조회
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/qestnar/qestnarModify.do")
	public ModelAndView qestnarModify(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception { 
		
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		ZValue result = null;

		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{			
			result = qestnarService.selectQestnar(zvl);
			model.addAttribute("qestnarMastr", result);

			resultList = qestnarService.selectItemList(zvl);
			model.addAttribute("qestnarItemList", resultList);

			resultList = qestnarService.selectDetailList(zvl);
			model.addAttribute("qestnarDetailList", resultList);

			model.addAttribute("requestZvl", zvl);

			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "qestnar/qestnarModify" );
			
			/* jsp화면 Sidebar 정보 */
			model.addAttribute("pageLevel1", "contact");
			model.addAttribute("pageLevel2", "6");
			model.addAttribute("pageName", "설문조사관리");
			
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}

	/**
	 * 설문관리 등록/수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/qestnar/saveQestnar.do")
	public ModelAndView saveQestnar(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		String gubun     = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) );  
		
		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
		
		try{
			if("I".equals(gubun)) {
				qestnarService.insertQestnarList(zvl, request);
				model.addObject("message", egovMessageSource.getMessage("success.common.insert"));

				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/qestnar/qestnarList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.INSERT);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);	
				
			} else {
				qestnarService.updateQestnarList(zvl, request);
				model.addObject("message", egovMessageSource.getMessage("success.common.update"));
				
			}
			
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	
	/**
	 * 설문관리 등록/수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/qestnar/saveQestnar2.do")
	public ModelAndView saveQestnar2(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		String gubun     = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) );  
		
		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
		
		try{
			qestnarService.updateQestnarList2(zvl, request);
			model.addObject("message", egovMessageSource.getMessage("success.common.update"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/qestnar/qestnarList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.UPDATE);
			zvl.put("menu_id",    menu_id);
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
	 * 설문관리 결과보기
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/qestnar/qestnarResultList.do")
	public ModelAndView qestnarResultList(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception { 
		
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		ZValue result = null;

		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{			
			result = qestnarService.selectQestnar(zvl);
			model.addAttribute("qestnarMastr", result);

			resultList = qestnarService.selectItemList(zvl);
			model.addAttribute("qestnarItemList", resultList);

			resultList = qestnarService.selectDetailList(zvl);
			model.addAttribute("qestnarDetailList", resultList);

			model.addAttribute("requestZvl", zvl);

			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "qestnar/qestnarResultList" );
			
			/* jsp화면 Sidebar 정보 */
			model.addAttribute("pageLevel1", "contact");
			model.addAttribute("pageLevel2", "6");
			model.addAttribute("pageName", "설문조사관리");
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/qestnar/qestnarList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.READ);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);						

		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}

	/**
	 * 설문관리 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/qestnar/deleteQestnar.do")
	public ModelAndView deleteQestnar(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			qestnarService.deleteQestnarList(zvl, request);
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/qestnar/qestnarList.do");
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

	/**
	 * 설문관리 주관식 응답결과 - 설문관리(주관식 응답결과 AJAX)  
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/qestnar/qestnarResultListAjax.do")
	public ModelAndView selectMngLevelRergistResnAjax(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;		
			
		List<ZValue> resultList = qestnarService.qestnarResultListAjax(zvl);
		model.addAttribute("resultList", resultList);

		modelAndView.setViewName( "jsonView" );
		modelAndView.addAllObjects(zvl);
		
		return modelAndView;	
	}

	/**
	 * 설문조사 결과 엑셀다운로드
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/qestnar/qestnarExcelDown.do")
	public String qestnarExcelDown(
			Map<String, Object> ModelMap,
			HttpServletRequest request,
			HttpServletResponse response
			) throws Exception {
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		List<ZValue> resultList = null;
		ZValue result = null;

		result = qestnarService.selectQestnar(zvl);
		ModelMap.put("qestnarMastr", result);

		resultList = qestnarService.selectItemList(zvl);
		ModelMap.put("qestnarItemList", resultList);

		resultList = qestnarService.selectDetailList(zvl);
		ModelMap.put("qestnarDetailList", resultList);

		ModelMap.put("downName", "qestnarExcelDown");

		//ModelMap.put("result", result);
		
		return "excelDownload";
	}

	/**
	 * 메인(설문조사 팝업)
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/qestnar/qestnarPopUp.do")
	public ModelAndView qestnarPopUp(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> resultList = null;
		ZValue result = null;
		
		result = qestnarService.selectQestnar(zvl);
		model.addAttribute("qestnarMastr", result);

		resultList = qestnarService.selectItemList(zvl);
		model.addAttribute("qestnarItemList", resultList);

		resultList = qestnarService.selectDetailList(zvl);
		model.addAttribute("qestnarDetailList", resultList);
		
		modelAndView.setViewName( "qestnar/qestnarPopUp" );
		
		return modelAndView;
	}

	/**
	 * 설문조사 응답 저장
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/qestnar/saveQestnarResult.do")
	public ModelAndView saveQestnarResult(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			qestnarService.saveQestnarResult(zvl, request);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

}
