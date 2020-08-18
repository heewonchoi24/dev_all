package org.ssis.pss.mylibry.web;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.mngLevelRes.service.MngLevelResService;
import org.ssis.pss.mylibry.service.MylibryService;
import org.ssis.pss.order.service.OrderService;
import org.ssis.pss.org.service.OrgService;
import org.ssis.pss.pinn.service.PinnService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.SessionVO;

@Controller
public class MylibryController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private MylibryService mylibryService;
	
	@Autowired
	private PinnService pinnService;
	
	@Autowired
	private OrgService orgService;
	
	@Autowired
	private CmnService cmnService;
	
	@Autowired
	private UserService UserService;

	@Autowired
	private OrderService orderService;	
	
	@Autowired
	private MngLevelResService mngLevelResService;
	
	@Autowired
	private CmnService CmnService;
	
	/**
	 * 마이 라이브러리
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/mylibry/mylibry.do")
    public ModelAndView mylibry(
							HttpServletRequest request,
							@ModelAttribute("loginVO") LoginVO loginVO
							) throws Exception {
  	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
  	ModelAndView model = new ModelAndView();
  	HttpSession session = request.getSession(false);
  	SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
  	LoginVO resultVO = new LoginVO();
  	ZValue result, cntSet, currentOrder = null;
  	List<ZValue> resultList = null;
  	
  	userInfo.setMyLibryYN("Y");
  	
  	loginVO.setUserId( userInfo.getUserId());
  	zvl.put("user_id", userInfo.getUserId());
  	zvl.put("insttCd", userInfo.getInsttCd());
  	zvl.put("insttNm", userInfo.getInsttNm());
	
	try{
		result = UserService.userInfo(zvl);
		model.addObject("result", result);
		
	  	resultVO  = UserService.userLogin(loginVO);
		
	  	currentOrder = cmnService.retrieveCurrentOrderNo();
	  	model.addObject("currentOrder", currentOrder); // 현재 차수
	  	
	  	zvl.put("searchYyyy", currentOrder.getValue("orderNo"));
	  	List<ZValue> pinnSummaryList = pinnService.selectPinnSummaryList(zvl);
	  	model.addObject("pinnSummaryList", pinnSummaryList);
	  	// 서면점검 종합 상태
	  	
	  	zvl.put("orderNo", currentOrder.getValue("orderNo"));
	  	result = orderService.selectOrderThread(zvl);
	  	model.addObject("orderList", result);
	  	// 차수 목록
	  	
	  	cntSet = mylibryService.mylibryBsisSttusCnt(zvl);
	  	model.addObject("cntSet", cntSet);
	  	// 기초현황 개인정보 보유현황 CNT
	  	
	  	resultList = mylibryService.mylibryBbsList(zvl);
	  	model.addObject("bbsList", resultList);
	  	// 자료실 게시판 글 불러오기
		resultList = mylibryService.mylibryBbsFileList(zvl);
		model.addObject("bbsAttachFileList", resultList);
	  	// 자료실 게시판 글 파일 불러오기
		resultList = mylibryService.mylibryBbsImg(zvl);
		model.addObject("bbsImg", resultList);
		// 자료실 게시판 글 목록이미지 불러오기
	  	
		resultList = mylibryService.mylibryAttachFileList(zvl);
		model.addObject("insttFileList", resultList);
		// 우리 기관 자료실 첨부파일 불러오기
		
		// 관리수준 진단 - 파일누락/재등록 요청
		resultList = mngLevelResService.selectMngLevelIndexList(zvl);
		model.addObject("mngLevelSummary", resultList);
		
		// 관리수준 진단 - 중간결과/최종결과
		result = mylibryService.selectMngLevelResult(zvl);
		model.addObject("mngLevelResult", result);
		
		model.addObject("requestZvl", zvl);
		model.setViewName( "mylibry/mylibry");
		
	}catch(Exception e){
		logger.error(e);
	}
	
	return model;
  }

	/**
	 * 마이 라이브러리 - 우리 기관 자료실 리스트
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/mylibry/insctrInsttList.do")
	public ModelAndView insctrInsttList(HttpServletRequest request
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "jsonView" );
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			resultList = orgService.orgListThread(zvl);
			modelAndView.addObject("insctrInsttList", resultList);
			
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		return modelAndView;
	}
	
	/**
	 * 마이 라이브러리 - 우리 기관 자료실 신규 등록
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/mylibry/mylibryFileInsert.do")
	public ModelAndView mylibryFileInsert(HttpServletRequest request) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		try{
			zvl = mylibryService.mylibryThreadInsert(zvl, request);
			
			resultList = mylibryService.mylibryAttachFileList(zvl);
			modelAndView.addObject("insttFileList", resultList);
			
			logger.debug("############## zvl ##############");
			logger.debug(zvl);
			logger.debug("############## zvl ##############");
			
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
	 * 마이 라이브러리 - 우리 기관 자료실 파일 삭제
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mylibry/mylibryFileDelete.do")
	public ModelAndView mylibryFileDelete(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			mylibryService.mylibryFileDelete(zvl, request);
			
			resultList = mylibryService.mylibryAttachFileList(zvl);
			modelAndView.addObject("insttFileList", resultList);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
}
