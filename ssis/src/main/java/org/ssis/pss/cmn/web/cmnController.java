package org.ssis.pss.cmn.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.mylibry.service.MylibryService;
import org.ssis.pss.order.service.OrderService;
import org.ssis.pss.popup.service.PopupService;
import org.ssis.pss.quickMenu.service.QuickMenuService;
import org.ssis.pss.sort.service.SortService;
import org.ssis.pss.visual.service.VisualService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;

@Controller
public class cmnController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private CmnService CmnService;
	
	@Autowired
	private SortService sortService;	
	
	@Autowired
	private VisualService visualService;	
	
	@Autowired
	private PopupService popupService;	
	
	@Autowired
	private QuickMenuService quickMenuService;	
	
	@Autowired
	private OrderService orderService;	
	
	@Autowired
	private MylibryService mylibryService;	
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	/**
	 * 로그인 페이지 이동
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/login/login.do")
	public ModelAndView goIndex(
						@ModelAttribute("loginVO") LoginVO loginVO,
						HttpServletRequest request,
						ModelMap model
						) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		String message = request.getParameter("message");
		String messageCd = request.getParameter("messageCd");
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		if (!org.apache.commons.lang.StringUtils.isEmpty(message)) {
			model.addAttribute("message", egovMessageSource.getMessage(message));
		}
		if (!org.apache.commons.lang.StringUtils.isEmpty(messageCd)) {
			model.addAttribute("messageCd", messageCd);
		}
		
		modelAndView.setViewName( "login/login" );
		modelAndView.addObject( "model", model );
		
		return modelAndView;
	}
	
	/**
	 * IE 버젼 체크
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/login/browserVersion.do")
	public ModelAndView browserVersion(HttpServletRequest request) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		modelAndView.setViewName( "login/browserVersion" );
		
		return modelAndView;
	}
	
	/**
	 * 메인 페이지 이동
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/main.do")
	public ModelAndView goMain(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			resultList = CmnService.mainBbsNoticeList(zvl);
			modelAndView.addObject("mainBbsNoticeList", resultList);
			
			resultList = CmnService.mainBbsResourceList(zvl);
			modelAndView.addObject("mainBbsResourceList", resultList);
			
			resultList = mylibryService.mylibryBbsImg(zvl);
			modelAndView.addObject("bbsImg", resultList);
			// 자료실 게시판 글 목록이미지 불러오기
			
			resultList = CmnService.mainBbsIndvdlLawList(zvl);
			modelAndView.addObject("mainBbsIndvdlLawList", resultList);
			
			resultList = CmnService.mainMonthlySchedule(zvl);
			modelAndView.addObject("mainMonthlySchedule", resultList);
			
			resultList = sortService.sortList(zvl);
			modelAndView.addObject("sortResultList", resultList);
			
			resultList = visualService.visualList(zvl);
			modelAndView.addObject("mainVisualList", resultList);		
			
			resultList = popupService.popupList(zvl);
			modelAndView.addObject("popupList", resultList);	
			
			resultList = quickMenuService.quickMenuList(zvl);
			modelAndView.addObject("quickMenuList", resultList);	
			
			ZValue result = null;
			ZValue orderVal = CmnService.retrieveCurrentOrderNo();
			zvl.put("orderNo", orderVal.getValue("orderNo"));
			
			result = orderService.selectOrderThread(zvl);
			modelAndView.addObject("orderList", result);
			modelAndView.setViewName( "main/main" );
			
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;
	}
	
	/**
	 * 메인 페이지 메시지 리스트
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/cmn/recptnMsgList.do")
	public ModelAndView recptnMsgList(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		ZValue result = null;
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			resultList = CmnService.recptnMsgList(zvl, request);
			modelAndView.addObject("recptnMsgList", resultList);
			
			result = CmnService.recptnMsgListCnt(zvl, request);
			modelAndView.addAllObjects(result);
			
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 공통 리스트 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
    @SuppressWarnings("unchecked")
	@RequestMapping(value="/commonList.do")
    public void commonList(HttpServletRequest request,
							HttpServletResponse response
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request); 
		List<ZValue> result = null;
		JSONArray jsonArray = new JSONArray();
		
		try{
			result = CmnService.retrieveCommonList(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
    	if(result != null && result.size()>0) {
    	    for(int i=0; i<result.size(); i++){  
    	    	jsonArray.add(result.get(i)); 
    	    }
    	}
		
		response.setContentType("application/x-json; charset=utf-8");
		PrintWriter printWriter = null;
		
		try{
			printWriter = response.getWriter();
		}catch (IOException e){
			logger.error(e);
		}
		
	    printWriter.print(jsonArray.toString()); 
	    printWriter.flush();
	    printWriter.close();
    }
    
	/**
	 * 공통 인서트
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/commonInsert.do")
    public void commonInsert(HttpServletRequest request,
							HttpServletResponse response
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request); 
		
		try{
			logger.debug(zvl);
			CmnService.createCommonInfo(zvl);
		}catch(Exception e){
			logger.error(e);
		}
    }
	
	/**
	 * 메인 - 월간 일정 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/cmn/monthlySchedule.do")
	public ModelAndView monthlySchedule(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;

		try{
			resultList = CmnService.mainMonthlySchedule(zvl);
			
			modelAndView.setViewName( "jsonView" );
			modelAndView.addObject("mainMonthlySchedule", resultList);
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 에러 페이지 이동
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/exception/error.do")
	public ModelAndView error(
						HttpServletRequest request,
						ModelMap model
						) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		
		String retPage = "exception/error";
		logger.debug("retPage : " + retPage);
		
		return modelAndView;
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/cmn/getMenuId.do")
	public ModelAndView getMenuId(
								HttpServletRequest request
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;

		try{
			result = CmnService.getMenuId(zvl);
			
			modelAndView.setViewName( "jsonView" );
			modelAndView.addAllObjects(result);
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 로그인 페이지 이동
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/login/invaliSession.do")
	public ModelAndView invaliSession(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		//model.addAttribute("message", "세션이 종료되었습니다.");
		
		modelAndView.setViewName("redirect:/login/login.do");
		modelAndView.addObject("messageCd", "session");
		
		return modelAndView;
	}
	
	/**
	 * 메인(주요일정 팝업)
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/main/yearSchedulePopUp.do")
	public ModelAndView yearSchedulePopUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> resultList = CmnService.mainYearScheduleDtlList(zvl);
		modelAndView.addObject("resultList", resultList);
		modelAndView.addObject("requestZvl", zvl);
		
		modelAndView.setViewName( "main/yearSchedulePopUp" );
		
		return modelAndView;
	}

	/**
	 * 메인(설문조사 대상 리스트)
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/main/qestnarList.do")
	public ModelAndView qestnarList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> resultList = CmnService.getQestnrSeq(zvl, request);
		modelAndView.addObject("resultList", resultList);
		
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
	
	/**
	 * 관리자 페이지 이동
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/login.do")
	public ModelAndView goAdminIndex(
						@ModelAttribute("loginVO") LoginVO loginVO,
						HttpServletRequest request,
						ModelMap model
						) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		String message = request.getParameter("message");
		String messageCd = request.getParameter("messageCd");
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		if (!org.apache.commons.lang.StringUtils.isEmpty(message)) {
			model.addAttribute("message", egovMessageSource.getMessage(message));
		}
		if (!org.apache.commons.lang.StringUtils.isEmpty(messageCd)) {
			model.addAttribute("messageCd", messageCd);
		}
		
		modelAndView.setViewName( "admin/login" );
		modelAndView.addObject( "model", model );
		
		return modelAndView;
	}	
}