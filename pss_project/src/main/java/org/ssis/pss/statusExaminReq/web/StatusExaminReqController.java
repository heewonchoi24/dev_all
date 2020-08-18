package org.ssis.pss.statusExaminReq.web;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.mngLevelReq.service.MngLevelReqService;
import org.ssis.pss.statusExaminReq.service.StatusExaminReqService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Controller
public class StatusExaminReqController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private StatusExaminReqService statusExaminReqService;
	
	@Autowired
	private MngLevelReqService MngLevelReqService;

	@Autowired
	private CmnService cmnService;

	/**
	 * 현황관리 - 실적등록 및 조회
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/statusExaminReq/statusExaminResultSummaryList.do")
	public ModelAndView statusExaminResultSummaryList(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> resultList = null;

		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		if( zvl.get("order_no")==null || "".equals(zvl.get("order_no"))){
			zvl.put("s_order_no", orderVal.getValue("orderNo"));
			zvl.put("order_no", zvl.get("s_order_no"));
		}
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());			
		}
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			resultList = statusExaminReqService.statusExaminInsttEvlOrderList(zvl);
			model.addAttribute("statusExaminInsttEvlOrderList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttClCdList(zvl);
			model.addAttribute("statusExaminInsttClCdList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttList(zvl);
			model.addAttribute("statusExaminInsttList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttSelectList(zvl);
			model.addAttribute("statusExaminInsttSelectList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttTableList(zvl);
			model.addAttribute("statusExaminInsttTableList", resultList);
			
			resultList = statusExaminReqService.statusExaminIdxList(zvl);
			model.addAttribute("statusExaminIdxList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttEvlList(zvl);
			model.addAttribute("statusExaminInsttEvlList", resultList);

			model.addAttribute("requestZvl", zvl);

		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		try{
			modelAndView.setViewName( "statusExaminReq/statusExaminResultSummaryList" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		/* 페이지 정보 */
		model.addAttribute("pageName", "현장점검 등록");
		
		return modelAndView;	
	}

	/**
	 * 현황관리 - 서면평가(기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody                           
	@RequestMapping(value="/statusExaminReq/statusExaminInsttListAjax.do")
	public ModelAndView statusExaminInsttListAjax(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		 
		zvl.put("order_no", orderVal.getValue("orderNo"));

		try{
			resultList = statusExaminReqService.StatusExaminInsttListAjax(zvl);
			
			modelAndView.setViewName( "jsonView" );
			modelAndView.addObject("resultList", resultList);
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}

	/**
	 * 현황관리 지표 리스트 화면
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/statusExaminReq/statusExaminResultModify.do")
	public ModelAndView statusExaminResultModify(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		ZValue result = null;

		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("s_order_no", orderVal.getValue("orderNo"));
		String periodCd = cmnService.retrieveEvlPeriodCode();		
		zvl.put("periodCd", periodCd);

		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());
		}

//		String tempInsttCd = zvl.getValue("instt_nm");

		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{			
			result = statusExaminReqService.statusExaminInsttTotalEvl(zvl);
			model.addAttribute("statusExaminInsttTotalEvl", result);

			resultList = statusExaminReqService.statusExaminInsttFileList(zvl);
			model.addAttribute("statusExaminFileList", resultList);

			resultList = statusExaminReqService.statusExaminInsttEvlOrderList(zvl);
			model.addAttribute("statusExaminInsttEvlOrderList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttClCdList(zvl);
			model.addAttribute("statusExaminInsttClCdList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttList(zvl);
			model.addAttribute("statusExaminInsttList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttSelectList(zvl);
			model.addAttribute("statusExaminInsttSelectList", resultList);
			
			model.addAttribute("requestZvl", zvl);

			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "statusExaminReq/statusExaminResultModify" );

		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		/* 페이지 정보 */
		model.addAttribute("pageName", "현장점검 등록");
		
		return modelAndView;	
	}

	/**
	 * 현황관리 지표 리스트 화면
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/statusExaminReq/statusExaminResultModifyList.do")
	public ModelAndView statusExaminResultModifyList(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		ZValue result = null;

		ZValue orderVal = cmnService.retrieveCurrentOrderNo();
		zvl.put("s_order_no", orderVal.getValue("orderNo"));
		String periodCd = cmnService.retrieveEvlPeriodCode();		
		zvl.put("periodCd", periodCd);
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());
		}

		//String tempInsttCd = zvl.getValue("instt_nm");

		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			resultList = statusExaminReqService.statusExaminInsttClCdList(zvl);
			model.addAttribute("statusExaminInsttClCdList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttList(zvl);
			model.addAttribute("statusExaminInsttList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttSelectList(zvl);
			model.addAttribute("statusExaminInsttSelectList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttEvlOrderList(zvl);
			model.addAttribute("statusExaminInsttEvlOrderList", resultList);
			
			zvl.put("s_instt_cd", zvl.getValue("instt_cd"));
			resultList = MngLevelReqService.selectMngLevelReqstAllFileList(zvl);
			model.addAttribute("mngLevelAllFileList", resultList);

			resultList = statusExaminReqService.statusExaminPreFileList(zvl);
			model.addAttribute("mngLevelPreFileList", resultList);

			resultList = statusExaminReqService.statusExaminInsttDetailList(zvl);
			model.addAttribute("statusExaminInsttDetailList", resultList);
			
			result = statusExaminReqService.statusExaminInsttTotalEvl(zvl);
			model.addAttribute("statusExaminInsttTotalEvl", result);

			resultList = statusExaminReqService.statusExaminInsttFileList(zvl);
			model.addAttribute("statusExaminFileList", resultList);

			result = statusExaminReqService.beforeOrderNo(zvl);
			
			String tOrderNo = EgovStringUtil.nullConvert( result.getValue( "orderNo" ) );  
			if("".equals(tOrderNo)) {
				zvl.put("b_order_no", orderVal.getValue("orderNo"));
			} else {
				zvl.put("b_order_no", result.getValue("orderNo"));
			}
			model.addAttribute("requestZvl", zvl);

			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "statusExaminReq/statusExaminResultModifyList" );

		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		/* 페이지 정보 */
		model.addAttribute("pageName", "현장점검 등록");

		// READ/WRITE/DOWNLOAD 권한
		zvl.put("authorId", userInfo.getAuthorId());
		zvl.put("menuId",   session.getAttribute("cMenuId"));
		resultList = cmnService.getAuthority(zvl);
		
		userInfo.setAuthRead(resultList.get(0).getValue("authRead"));
		userInfo.setAuthWrite(resultList.get(0).getValue("authWrite"));
		userInfo.setAuthDwn(resultList.get(0).getValue("authDwn"));
		
		logger.debug("###################### auth ######################");  
		logger.debug("authRead:  " + userInfo.getAuthRead());  
		logger.debug("authWrite: " + userInfo.getAuthWrite());
		logger.debug("authDwn:   " + userInfo.getAuthDwn());  
		logger.debug("###################### auth ######################");  
		
		return modelAndView;	
	}

	/**
	 * 현황관리 - 현장점검등록(기관별 상세 지표조회)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/statusExaminReq/statusExaminResultMemoList.do")
	public ModelAndView statusExaminResultMemoList(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		ZValue result = null;
		ZValue zvlTemp = new ZValue();
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());
		}
		
		String periodCd = cmnService.retrieveEvlPeriodCode();		
		zvl.put("periodCd", periodCd);

		zvlTemp.put("mngLevelUpperCd", "ML00");
		zvlTemp.put("mngLevelCd"     , "ML02");
		zvlTemp.put("orderNo", zvl.getValue("order_no"));
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			resultList = statusExaminReqService.statusExaminInsttEvlOrderList(zvl);
			model.addAttribute("statusExaminInsttEvlOrderList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttClCdList(zvl);
			model.addAttribute("statusExaminInsttClCdList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttList(zvl);
			model.addAttribute("statusExaminInsttList", resultList);
			
			result = statusExaminReqService.statusExaminInsttDetail(zvl);
			model.addAttribute("statusExaminRegist", result);
			
			resultList = statusExaminReqService.statusExaminInsttSelectList(zvl);
			model.addAttribute("statusExaminInsttSelectList", resultList);
			
			resultList = statusExaminReqService.statusExaminInsttDetailFileList(zvl);
			model.addAttribute("statusExaminDetailFileList", resultList);

			resultList = statusExaminReqService.statusExaminInsttIdxFileList(zvl);
			model.addAttribute("statusExaminIdxFileList", resultList);

			resultList = statusExaminReqService.statusExaminInsttIdxDetailList(zvl);
			model.addAttribute("statusExaminInsttIdxDetailList", resultList);

			resultList = cmnService.retrieveCheckItemScoreSeList(zvlTemp);
			model.addAttribute("statusExaminScoreSeList", result);

			model.addAttribute("requestZvl", zvl);

			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "statusExaminReq/statusExaminResultMemoList" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		/* 페이지 정보 */
		model.addAttribute("pageName", "현장점검 등록");
		
		// READ/WRITE/DOWNLOAD 권한
		zvl.put("authorId", userInfo.getAuthorId());
		zvl.put("menuId",   session.getAttribute("cMenuId"));
		resultList = cmnService.getAuthority(zvl);
		
		userInfo.setAuthRead(resultList.get(0).getValue("authRead"));
		userInfo.setAuthWrite(resultList.get(0).getValue("authWrite"));
		userInfo.setAuthDwn(resultList.get(0).getValue("authDwn"));
		
		logger.debug("###################### auth ######################");  
		logger.debug("authRead:  " + userInfo.getAuthRead());  
		logger.debug("authWrite: " + userInfo.getAuthWrite());
		logger.debug("authDwn:   " + userInfo.getAuthDwn());  
		logger.debug("###################### auth ######################");  		
		
		return modelAndView;	
	}

	/**
	 * 현황관리 지표 등록
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/statusExaminReq/insertStatusExaminRes.do")
	public ModelAndView insertStatusExaminIndex(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));
		String periodCd = cmnService.retrieveEvlPeriodCode();		
		zvl.put("periodCd", periodCd);
		
		try{
			statusExaminReqService.createStatusExaminRes(zvl, request);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	
	/**
	 * 현황관리 지표 수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/statusExaminReq/updateStatusExaminRes.do")
	public ModelAndView updateStatusExaminRes(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));
		String periodCd = cmnService.retrieveEvlPeriodCode();		
		zvl.put("periodCd", periodCd);
		
		try{
			statusExaminReqService.updateStatusExaminRes(zvl, request);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.update"));
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	
	/**
	 * 현황관리 지표 실적 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/statusExaminReq/deleteStatusExaminRes.do")
	public ModelAndView deleteStatusExaminRes(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));

		try{
			statusExaminReqService.deleteStatusExaminRes(zvl, request);
					
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
		}catch(Exception e){
					
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 현황관리 등록결과 - 실적등록(재등록 요청사유 AJAX)  
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/statusExaminReq/statusExaminFobjctResnAjax.do")
	public ModelAndView selectMngLevelRergistResnAjax(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));
		

		result = statusExaminReqService.statusExaminFobjctResnAjax(zvl);
		model.addAttribute("result", result);
			
		List<ZValue> resultList = statusExaminReqService.statusExaminFobjctResnFile(zvl);
		model.addAttribute("resultList", resultList);

		modelAndView.setViewName( "jsonView" );
		modelAndView.addAllObjects(zvl);
		
		return modelAndView;	
	}

}
